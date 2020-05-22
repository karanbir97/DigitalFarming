package control;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import org.json.simple.JSONObject;

import model.ConnessioneDB;
/**
 * Servlet implementation class GetFormAggiungiSconto
 */ 
@WebServlet("/GetFormAggiungiSconto")
public class GetFormAggiungiSconto extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public GetFormAggiungiSconto() {
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
        
		if(Integer.parseInt(request.getParameter("richiesta"))  == 1) {			
	        Integer risultato = 0;
	        String errore = "";
	        String contenuto = "";
	        
	        
	        /*PRELEVO I PRODOTTI*/
	        String prodotti = "";
	        ConnessioneDB connDB = new ConnessioneDB();
			if(connDB.getConn() != null) {
				
				try {
					Statement stmt = connDB.getConn().createStatement();
					String sql = "";
					sql = ""
							+ "SELECT p.id_prodotto, p.nome AS nome_prodotto, p.prezzo_base "
							+ "FROM prodotti AS p "
							+ "WHERE p.attivo = 1 "
							+ "ORDER BY p.id_prodotto DESC; ";
					ResultSet result = stmt.executeQuery(sql);				
					if(!result.wasNull()) {
						int rowCount = result.last() ? result.getRow() : 0;
						if(rowCount > 0) {
							prodotti += "<option value='0'>Selezionare un Prodotto</option>";
							result.beforeFirst();
							while(result.next()) {
								prodotti += "<option value='"+result.getString("id_prodotto")+"'>"+result.getString("id_prodotto")+" - "+result.getString("nome_prodotto")+" (&euro; "+result.getFloat("prezzo_base")+")</option>";
							}												
						}
						else {
							prodotti += "<option value='0'>Nessun Prodotto Esistente</option>";
						}
					}	
					
					if(risultato == 0) {
						connDB.getConn().rollback();
					}
					else {
						connDB.getConn().commit();
					}																						
					connDB.getConn().close();
					risultato = 1;
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
	        	        	        	       
	        contenuto += "<select id='prodottoSconto' class='prodotto adminFormField' name='prodotto'>";
	        contenuto += prodotti;
	        contenuto += "</select>";	        	        
	        contenuto += "<input type='number' step='0.01' id='prezzoSconto' class='prezzo adminFormField' name='prezzo' placeholder='Prezzo' />";
	        contenuto += "<input type='date' id='daSconto' class='da adminFormField' name='da' placeholder='Dal' />";
	        contenuto += "<input type='date' id='aSconto' class='a adminFormField' name='a' placeholder='Al' />";
	        contenuto += "<button id='confirmAggiungiSconto' class='adminButtonConfermaAggiungi'>Aggiungi</button>";
	        risultato = 1;
	
	        				
			JSONObject res = new JSONObject();
			res.put("risultato", risultato);
			res.put("errore", errore);
			res.put("contenuto", contenuto);
			out.println(res);			
		}
	}

}
