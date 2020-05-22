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
 * Servlet implementation class EliminaOrdine
 */
@WebServlet("/EliminaOrdine")
public class EliminaOrdine extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public EliminaOrdine() {
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
		
		int idOrdine = Integer.parseInt(request.getParameter("idOrdine"));
        
        Integer risultato = 0;
        String errore = "";
        String contenuto = "";
        
        ConnessioneDB connDB = new ConnessioneDB();
		if(connDB.getConn() != null) {
			try {
				String sql; 
    			Statement stmt0;
    			ResultSet result;
				stmt0 = connDB.getConn().createStatement();
				sql = ""
						+ "SELECT op.quantita, op.id_prodotto " 
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
							stmt = null;
							sql = "UPDATE prodotti SET quantita_disponibile = (quantita_disponibile + ?) WHERE id_prodotto = ?";
							stmt = connDB.getConn().prepareStatement(sql);
							stmt.setInt(1, result.getInt("quantita"));
							stmt.setInt(2, result.getInt("id_prodotto"));
							if(stmt.executeUpdate() != 1) {
								errore += "Errore Ripristino Quantit&agrave; per il prodotto "+result.getInt("id_prodotto");
								continua *= 0;																
							}
						}
						
						if(continua == 1) {
							stmt0 = connDB.getConn().createStatement();
							String sql0 = "";
							sql0 = "UPDATE ordini_prodotti SET attivo = 0 WHERE id_ordine = "+idOrdine+";";
							if(stmt0.executeUpdate(sql0) == 1) {
								Statement stmt1 = connDB.getConn().createStatement();
								sql = "UPDATE ordini SET attivo = 0 WHERE id_ordine = "+idOrdine+";";
								if(stmt1.executeUpdate(sql) == 1) {
									contenuto = "Ordine Eliminato con Successo";
									risultato = 1;			 		
								}
								else {
									errore = "Errore Cancellazione Ordine.";
									risultato = 0;					
								}
							}
							else {
								errore = "Errore Cancellazione Prodotti Ordine.";
								risultato = 0;					
							}							
						}
						else {
							risultato = 0;
						}
					}
					else {
						errore = "Errore Prelevamento Prodotti.";
						risultato = 0;											
					}
				}
				else {
					errore = "Errore Prelevamento Prodotti.";
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
