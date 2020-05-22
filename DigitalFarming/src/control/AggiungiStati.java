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
 * Servlet implementation class AggiungiStati
 */
@WebServlet("/AggiungiStati")
public class AggiungiStati extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AggiungiStati() {
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
		
		String nomeStato = request.getParameter("nomeStato");
		Integer ordineAnnullabileStato = Integer.parseInt(request.getParameter("ordineAnnullabileStato"));		
		Integer primoStato = Integer.parseInt(request.getParameter("primoStato"));		
        
        Integer risultato = 0;
        String errore = "";
        String contenuto = "";

        ConnessioneDB connDB = new ConnessioneDB();
		if(connDB.getConn() != null) {
			try {				
    			Statement stmt0;
    			ResultSet result;
    			String sql;    		
    			Integer continua = 0;
    			
    			if(primoStato == 1) {
					stmt0 = connDB.getConn().createStatement();				
					sql = ""
							+ "SELECT id_stato "
							+ "FROM ordini_stati "
							+ "WHERE attivo = 1 AND primo_stato = 1";
					//System.out.println(sql);
					result = stmt0.executeQuery(sql);				
					if(!result.wasNull()) {
						int rowCount = result.last() ? result.getRow() : 0;
						if(rowCount > 0) {						
							errore = "Esiste Gi&agrave; Uno Stato Iniziale.";
							risultato = 0;										
						}
						else {
							continua = 1;
						}
					}    				
    			}
    			else {
    				continua = 1;
    			}

				if(continua == 1) {
					sql = "INSERT INTO ordini_stati (nome, ordine_annullabile, primo_stato, attivo) VALUES (?, ?, ?, ?) ;";
					PreparedStatement  stmt = connDB.getConn().prepareStatement(sql);
					stmt.setString(1, nomeStato);
					stmt.setInt(2, ordineAnnullabileStato);	
					stmt.setInt(3, primoStato);				
					stmt.setInt(4, 1);
					if(stmt.executeUpdate() == 1) {
						contenuto = "Stato Inserito con Successo";
						risultato = 1;					
					}
					else {
						errore = "Errore Inserimento del Stato.";
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
				errore = "Errore esecuzione Query."+e.getMessage();
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
