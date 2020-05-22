package control;

import java.io.IOException; 
import java.io.PrintWriter;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import org.json.simple.JSONObject;

import model.ConnessioneDB;
/**
 * Servlet implementation class AggiungiProdotto
 */
@WebServlet("/AggiungiProdotto")
public class AggiungiProdotto extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AggiungiProdotto() {
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
		
		String nomeProdotto = request.getParameter("nomeProdotto");
		String descrizioneProdotto = request.getParameter("descrizioneProdotto");
		String descrizioneAbbreviataProdotto = request.getParameter("descrizioneAbbreviataProdotto");
		Integer categoriaProdotto = Integer.parseInt(request.getParameter("categoriaProdotto"));
		Integer quantitaProdotto = Integer.parseInt(request.getParameter("quantitaProdotto"));
		Integer unitaProdotto = Integer.parseInt(request.getParameter("unitaProdotto"));
		Integer aliquotaProdotto = Integer.parseInt(request.getParameter("aliquotaProdotto"));
		Float prezzoProdotto = Float.parseFloat(request.getParameter("prezzoProdotto"));

        Integer risultato = 0;
        String errore = "";
        String contenuto = "";
        
        ConnessioneDB connDB = new ConnessioneDB();
		if(connDB.getConn() != null) {
			try {				
				String sql = "INSERT INTO prodotti(nome, descrizione, descrizione_abbreviata, quantita_disponibile, prezzo_base, id_aliquota, id_categoria, id_unita, attivo) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?) ;";
				PreparedStatement  stmt = connDB.getConn().prepareStatement(sql);
				stmt.setString(1, nomeProdotto);				
				stmt.setString(2, descrizioneProdotto);				
				stmt.setString(3, descrizioneAbbreviataProdotto);								
				stmt.setInt(4, quantitaProdotto);
				stmt.setFloat(5, prezzoProdotto);						
				stmt.setInt(6, aliquotaProdotto);				
				stmt.setInt(7, categoriaProdotto);				
				stmt.setInt(8, unitaProdotto);				
				stmt.setInt(9, 1);					
				if(stmt.executeUpdate() == 1) {
					contenuto = "Prodotto Inserito con Successo";
					risultato = 1;					
				}
				else {
					errore = "Errore Inserimento Prodotto.";
					risultato = 0;					
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
