package control;

import java.io.IOException; 
import java.io.PrintWriter;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import org.json.simple.JSONObject;

import model.ConnessioneDB;
/**
 * Servlet implementation class AggiungiImmagine
 */
@WebServlet("/AggiungiImmagine")
public class AggiungiImmagine extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AggiungiImmagine() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	@SuppressWarnings("unchecked")
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		PrintWriter out = response.getWriter();
		response.setContentType("text/html");
		
		Integer idProdotto = Integer.parseInt(request.getParameter("idProdotto"));
		String filenameImmagineProdotto = request.getParameter("filenameImmagineProdotto");
		Integer defaultImmagine = Integer.parseInt(request.getParameter("defaultImmagine"));
        
        Integer risultato = 0;        
        String errore = "";
        String contenuto = "";
        
        Integer continua = 0;
        
        ConnessioneDB connDB = new ConnessioneDB();
		if(connDB.getConn() != null) {
			try {				
				String sql = "";
				if(defaultImmagine == 1) { //Se deve essere primaria					
					Statement stmt0 = connDB.getConn().createStatement();					
					sql = "SELECT id_immagine "
						+ "FROM prodotti_immagini "
						+ "WHERE id_prodotto = "+idProdotto+" AND is_default = 1 AND attivo = 1;";
					//System.out.println(sql);
					ResultSet result = stmt0.executeQuery(sql);
					if(result.wasNull()) {
						errore = "Errore esecuzione Query.";
						risultato = 0;
					}
					else {
						int rowCount = result.last() ? result.getRow() : 0;
						if(rowCount == 0) {	
							continua = 1;
						}
						else {
							errore = "Esiste Gi&agrave; un'immagine primaria per questo prodotto.";
							risultato = 0;											
						}
					}
				}
				else {
					continua = 1;
				}
					
				if(continua == 1) {
					sql = "INSERT INTO prodotti_immagini (id_prodotto, filename, is_default, attivo) VALUES (?, ?, ?, ?) ;";
					PreparedStatement  stmt = connDB.getConn().prepareStatement(sql);
					stmt.setInt(1, idProdotto);
					stmt.setString(2, filenameImmagineProdotto);
					stmt.setInt(3, defaultImmagine);				
					stmt.setInt(4, 1);				
					if(stmt.executeUpdate() == 1) {
						contenuto = "Immagine Inserita con Successo";
						risultato = 1;					
					}
					else {
						errore = "Errore Inserimento Immagine.";
						risultato = 0;					
					}															
				}
				
				if(risultato == 0) {
					connDB.getConn().rollback();
				}
				else {
					connDB.getConn().commit();
				}												
				connDB.getConn().close();
			}
			catch(Exception e) {
				errore = "Errore esecuzione Query.";
				risultato = 0;
			}
		}
		else {
	        errore = connDB.getError();
			risultato = 0;
		}
        
        				
		JSONObject res = new JSONObject();
		res.put("risultato", risultato);
		res.put("errore", errore);
		res.put("contenuto", contenuto);
		out.println(res);
	}

}
