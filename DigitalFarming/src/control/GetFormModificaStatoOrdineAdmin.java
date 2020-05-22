package control;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;

import model.ConnessioneDB;

/**
 * Servlet implementation class GetFormModificaStatoOrdine
 */
@WebServlet("/GetFormModificaStatoOrdineAdmin")
public class GetFormModificaStatoOrdineAdmin extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public GetFormModificaStatoOrdineAdmin() {
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
        
		Integer idOrdine = Integer.parseInt(request.getParameter("idOrdine"));
        Integer risultato = 0;
        String errore = "";
        String contenuto = "";
        
		if(idOrdine > 0) {				        	        
	        /*PRELEVO GLI STATI*/
	        String prodotti = "";
	        ConnessioneDB connDB = new ConnessioneDB();
			if(connDB.getConn() != null) {
				
				try {
					Statement stmt = connDB.getConn().createStatement();
					String sql = "";
					sql = ""
							+ "SELECT id_stato, nome, (SELECT id_stato FROM ordini WHERE id_ordine = "+idOrdine+") AS id_stato_set "
							+ "FROM ordini_stati "
							+ "WHERE attivo = 1 "
							+ "ORDER BY nome DESC; ";
					ResultSet result = stmt.executeQuery(sql);				
					if(!result.wasNull()) {
						while(result.next()) {
							if(result.getInt("id_stato") == result.getInt("id_stato_set")) {
								prodotti += "<option value='"+result.getInt("id_stato")+"' selected>"+result.getString("nome")+"</option>";
							}
							else {
								prodotti += "<option value='"+result.getInt("id_stato")+"'>"+result.getString("nome")+"</option>";
							}
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
	        	        	        	       
	        contenuto += "<select id='idStatoOrdine' class='idStatoOrdine adminFormField' name='idStatoOrdine'>";
	        contenuto += prodotti;
	        contenuto += "</select>";	        	        	        
	        contenuto += "<br/>";	        	        	        
	        contenuto += "<input type='hidden' id='idOrdine' value='"+idOrdine+"' />";
	        contenuto += "<button id='confirmAggiungiStatoOrdine' class='adminButtonConfermaAggiungi'>Aggiorna Stato</button>";
	        risultato = 1;

	        				
		}
		else {
			errore = "Errore Parametri";
			risultato = 0;			
		}

		JSONObject res = new JSONObject();
		res.put("risultato", risultato);
		res.put("errore", errore);
		res.put("contenuto", contenuto);
		out.println(res);			
	}


}
