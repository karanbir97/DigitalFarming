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
 * Servlet implementation class GetContatti
 */
@WebServlet("/GetContatti")
public class GetContatti extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public GetContatti() {
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
	    
		Integer risultato = 0;
	    String errore = "";
	    String contenuto = "";
	    
        ConnessioneDB connDB = new ConnessioneDB();
		if(connDB.getConn() != null) {
			
			try {
				Statement stmt = connDB.getConn().createStatement();
				String sql = "";
				sql = ""
						+ "SELECT c.id_contatto, c.data_registrazione, c.letta, IFNULL((SELECT codice_fiscale FROM utenti WHERE id_utente = c.id_cliente), '') AS cliente, IFNULL(c.id_ordine, '') AS id_ordine "
						+ "FROM contatti AS c "
						+ "WHERE c.attivo = 1; ";
				//System.out.println(sql);
				ResultSet result = stmt.executeQuery(sql);				
				if(!result.wasNull()) {
					SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
					String cl = "";
					while(result.next()) {
						contenuto += "<tr>";														
							contenuto += "<td>"+sdf.format(result.getDate("data_registrazione"))+"</td>";	
							contenuto += "<td>"+result.getString("cliente")+"</td>";
							contenuto += "<td>"+result.getString("id_ordine")+"</td>";							
							contenuto += "<td>";
							
							if(result.getInt("letta") == 1) { //Se è stato letto
								cl = "letto";
							}
							else {
								cl = "nonLetto";
							}							
							
							contenuto += "	<i class='visualizza visualizzaContatto "+cl+" fas fa-eye' style='cursor: pointer;' data-idcontatto='"+result.getInt("id_contatto")+"' title='Visualizza Contatto'></i>";
							contenuto += "</td>";
						contenuto += "</tr>";
					}					
				}				 
				
				risultato = 1;				
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
