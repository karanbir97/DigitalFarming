package control;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;
import java.sql.Statement;
import java.text.SimpleDateFormat;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import org.json.simple.JSONObject;

import model.ConnessioneDB;
/**
 * Servlet implementation class GetContatto
 */
@WebServlet("/GetContatto")
public class GetContatto extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public GetContatto() {
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
		Integer idContatto = Integer.parseInt(request.getParameter("idContatto"));
		PrintWriter out = response.getWriter();
		response.setContentType("text/html");
	    
		Integer risultato = 0;
	    String errore = "";
	    String contenuto = "";
	    
        ConnessioneDB connDB = new ConnessioneDB();
		if(connDB.getConn() != null) {
			
			try {
				String sql = "";
				Statement stmt0 = connDB.getConn().createStatement();				
				sql = "UPDATE contatti SET letta = 1 WHERE id_contatto = "+idContatto+";";
				if(stmt0.executeUpdate(sql) == 1) {
					Statement stmt = connDB.getConn().createStatement();				
					sql = ""
						+ "SELECT c.id_contatto, c.nome, c.email, c.data_registrazione, c.letta, IFNULL((SELECT codice_fiscale FROM utenti WHERE id_utente = c.id_cliente), '') AS cliente, IFNULL(c.id_ordine, '') AS id_ordine, c.note "
						+ "FROM contatti AS c "
						+ "WHERE c.attivo = 1 AND c.id_contatto = "+idContatto+"; ";				
					//System.out.println(sql);
					ResultSet result = stmt.executeQuery(sql);				
					if(!result.wasNull()) {
						SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
						while(result.next()) {
							contenuto += "<h2>Contatto N."+result.getString("id_contatto")+"</h2>";
							contenuto += "<p class='fieldContatto'>Data: "+sdf.format(result.getDate("data_registrazione"))+"</p>";
							contenuto += "<p class='fieldContatto'>Cliente: "+result.getString("cliente")+"</p>";
							contenuto += "<p class='fieldContatto'>Ordine N: "+result.getString("id_ordine")+"</p>";
							contenuto += "<p class='fieldContatto'>Nome: "+result.getString("nome")+"</p>";
							contenuto += "<p class='fieldContatto'>Email: "+result.getString("email")+"</p>";
							contenuto += "<textarea>";														
								contenuto += result.getString("note");
							contenuto += "</textarea>";
						}
						risultato = 1;
					}				 
				}
				else {
					errore = "Errore Aggiornamento Lettura.";
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
