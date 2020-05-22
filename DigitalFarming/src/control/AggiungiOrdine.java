package control;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.json.simple.JSONObject;

import model.Carrello;
import model.ConnessioneDB;


/**
 * Servlet implementation class AggiungiOrdine
 */
@WebServlet("/AggiungiOrdine")
public class AggiungiOrdine extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AggiungiOrdine() {
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
        
        Integer richiesta = Integer.parseInt(request.getParameter("richiesta"));		
        if(richiesta == 1) {
	    	if(request.getSession() != null){
	    		Integer idOrdine = (Integer) request.getSession().getAttribute("id_ordine");   
	    		Integer idUtente = (Integer) request.getSession().getAttribute("id_utente");
	    		if(idOrdine != null && idUtente != null){
			        ConnessioneDB connDB = new ConnessioneDB();
					if(connDB.getConn() != null) {
						try {				
							String sql; 
			    			Statement stmt0;
			    			ResultSet result;
							stmt0 = connDB.getConn().createStatement();
		    				sql = ""
									+ "SELECT op.quantita, op.id_prodotto, " 
									+ "(SELECT quantita_disponibile FROM prodotti WHERE id_prodotto = op.id_prodotto) AS qta_disponibile "
									+ "FROM ordini_prodotti AS op "
									+ "WHERE op.attivo = 1 AND op.id_ordine = "+idOrdine+"; ";
	    					result = stmt0.executeQuery(sql);				
	    					if(!result.wasNull()) {	    							    					
	    						int rowCount = result.last() ? result.getRow() : 0;
	    						if(rowCount > 0) {
	    							Integer continua = 1;	    							
		    						result.beforeFirst();
		    						PreparedStatement  stmt;
		    						while(result.next()){
		    							if(result.getInt("qta_disponibile") >= result.getInt("quantita")) {
			    							stmt = null;
			    							sql = "UPDATE prodotti SET quantita_disponibile = (quantita_disponibile - ?) WHERE id_prodotto = ?";
			    							stmt = connDB.getConn().prepareStatement(sql);
			    							stmt.setInt(1, result.getInt("quantita"));
			    							stmt.setInt(2, result.getInt("id_prodotto"));
											if(stmt.executeUpdate() != 1) {
												errore += "Errore Prenotazione Quantit&agrave; dal magazzino per il prodotto "+result.getInt("id_prodotto");
												continua *= 0;																
											}
		    							}
		    							else {
		    								continua *= 0;
		    								errore += "Il prodotto "+result.getInt("id_prodotto")+" non &egrave; disponibile nelle quantit&agrave; indicate. (Disponibile: "+result.getInt("qta_disponibile")+")";	    						
		    							}
		    						}
		    						
		    						if(continua == 1) {
		    							sql = "UPDATE ordini SET attivo = 1 WHERE id_ordine = ?;";
		    							stmt = connDB.getConn().prepareStatement(sql);
		    							stmt.setInt(1, idOrdine);
		    							if(stmt.executeUpdate() == 1) {								
											Carrello newCart = new Carrello(idUtente);
											request.getSession().setAttribute("carrello", newCart);
		    								risultato = 1;					
		    								contenuto = "Ordine Terminato con Successo";
		    							}
		    							else {
		    								risultato = 0;					
		    								contenuto = "Errore Completamento Ordine";
		    							}											    							
		    						}
		    						else {
		    							risultato = 0;
		    						}	    							
	    						}
	    						else {
	    							errore = "Nessun Prodotto Trovato";
	    							risultato = 0;
	    						}
	    					}
	    					else {
								risultato = 0;					
								errore = "Errore Prelevamento Quantit&agrave; Ordine";	    						
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
				}
				else {
					errore = "Nessun ordine trovato.";
					risultato = 0;		    		    				
				}
	    	}
	    	else {
				errore = "Nessun Carrello trovato.";
				risultato = 0;		    		    				    		
	    	}        	
        }
        				
		JSONObject res = new JSONObject();
		res.put("risultato", risultato);
		res.put("errore", errore);
		res.put("contenuto", contenuto);
		out.println(res);
	}



}
