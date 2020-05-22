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
 * Servlet implementation class GetFormModificaQuantitaProdottoAdmin
 */
@WebServlet("/GetFormModificaQuantitaProdottoAdmin")
public class GetFormModificaQuantitaProdottoAdmin extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public GetFormModificaQuantitaProdottoAdmin() {
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
        Integer risultato = 0;
        String errore = "";
        String contenuto = "";
        
		if(idProdotto > 0) {		
	        /*PRELEVO LA QUANTITà ATTUALE*/
			Integer quantitaProdotto = 0;
	        ConnessioneDB connDB = new ConnessioneDB();
			if(connDB.getConn() != null) {
				
				try {
					Statement stmt = connDB.getConn().createStatement();
					String sql = "";
					sql = ""
							+ "SELECT quantita_disponibile "
							+ "FROM prodotti "
							+ "WHERE id_prodotto = "+idProdotto+"; ";
					ResultSet result = stmt.executeQuery(sql);				
					if(!result.wasNull()) {
						while(result.next()) {
							quantitaProdotto = result.getInt("quantita_disponibile");
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
	        	        	        	       
			contenuto += "<input type='number' step='1' id='quantitaProdotto' class='quantitaProdotto adminFormField' name='quantitaProdotto' value='"+quantitaProdotto+"' />";	        	        	        
	        contenuto += "<br/>";	        	        	        
	        contenuto += "<input type='hidden' id='idProdotto' value='"+idProdotto+"' />";
	        contenuto += "<button id='confirmAggiungiQuantitaProdotto' class='adminButtonConfermaAggiungi'>Aggiorna Quantit&agrave;</button>";
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
