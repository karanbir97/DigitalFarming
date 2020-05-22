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
 * Servlet implementation class GetFormAggiungiIndirizzo
 */
@WebServlet("/GetFormAggiungiIndirizzo")
public class GetFormAggiungiIndirizzo extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public GetFormAggiungiIndirizzo() {
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
	        	         
	        /*PRELEVO cap,citta,province*/
	        String cap = "";
	        String citta = "";
	        String province = "";
	        ConnessioneDB connDB = new ConnessioneDB();
			if(connDB.getConn() != null) {
				
				try {
					Statement stmt = connDB.getConn().createStatement();
					String sql;
					ResultSet result;
					
					sql = "";
					result = null;
					sql = ""
							+ "SELECT id_cap, valore "
							+ "FROM cap "
							+ "ORDER BY valore; ";
					result = stmt.executeQuery(sql);				
					if(!result.wasNull()) {
						int rowCount = result.last() ? result.getRow() : 0;
						if(rowCount > 0) {
							cap += "<option value='0'>CAP</option>";
							result.beforeFirst();
							while(result.next()) {
								cap += "<option value='"+result.getString("id_cap")+"'>"+result.getString("valore")+"</option>";
							}												
						}
						else {
							cap += "<option value='0'>CAP</option>";
						}
					}		
					
					sql = "";
					result = null;
					sql = ""
							+ "SELECT id_citta, valore "
							+ "FROM citta "
							+ "ORDER BY valore; ";
					result = stmt.executeQuery(sql);				
					if(!result.wasNull()) {
						int rowCount = result.last() ? result.getRow() : 0;
						if(rowCount > 0) {
							citta += "<option value='0'>Selezionare una Citt&agrave;</option>";
							result.beforeFirst();
							while(result.next()) {
								citta += "<option value='"+result.getString("id_citta")+"'>"+result.getString("valore")+"</option>";
							}												
						}
						else {
							citta += "<option value='0'>Nessuna Citt&agrave; presente</option>";
						}
					}	
					
					
					sql = "";
					result = null;
					sql = ""
							+ "SELECT id_provincia, valore "
							+ "FROM province "
							+ "ORDER BY valore; ";
					result = stmt.executeQuery(sql);				
					if(!result.wasNull()) {
						int rowCount = result.last() ? result.getRow() : 0;
						if(rowCount > 0) {
							province += "<option value='0'>Selezionare una Provincia</option>";
							result.beforeFirst();
							while(result.next()) {
								province += "<option value='"+result.getString("id_provincia")+"'>"+result.getString("valore")+"</option>";
							}												
						}
						else {
							province += "<option value='0'>Nessuna Provincia presente</option>";
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
	        	        	        	       
	        contenuto += "<input type='text' id='nomeIndirizzo' class='nome adminFormField' name='nome' placeholder='Nome' />";
	        contenuto += "<input type='text' id='cognomeIndirizzo' class='cognome adminFormField' name='cognome' placeholder='Cognome' />";
	        contenuto += "<input type='text' id='indirizzoIndirizzo' class='indirizzo adminFormField' name='indirizzo' placeholder='Indirizzo' />";
	        contenuto += "<select id='capIndirizzo' class='cap adminFormField' name='cap'>";
	        contenuto += cap;
	        contenuto += "</select>";	        	        
	        contenuto += "<select id='cittaIndirizzo' class='citta adminFormField' name='citta'>";
	        contenuto += citta;
	        contenuto += "</select>";	        	        
	        contenuto += "<select id='provinciaIndirizzo' class='provincia adminFormField' name='provincia'>";
	        contenuto += province;
	        contenuto += "</select>";	        	        
	        
	        contenuto += "<input type='text' id='telefonoIndirizzo' class='telefono adminFormField' name='telefono' placeholder='Telefono' />";
	        contenuto += "<input type='text' id='cellulareIndirizzo' class='cellulare adminFormField' name='cellulare' placeholder='Cellulare' />";
	        contenuto += "<textarea id='noteIndirizzo' class='note adminFormField' name='note' placeholder='Eventuali Note'></textarea>";
	        
	        contenuto += "<button id='confirmAggiungiIndirizzo' class='adminButtonConfermaAggiungi'>Aggiungi</button>";
	        risultato = 1;
	
	        				
			JSONObject res = new JSONObject();
			res.put("risultato", risultato);
			res.put("errore", errore);
			res.put("contenuto", contenuto);
			out.println(res);			
		}
	}


}
