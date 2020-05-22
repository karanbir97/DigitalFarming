package control;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import org.json.simple.JSONObject;

import model.ConnessioneDB;
import model.SystemInformation;
/**
 * Servlet implementation class EliminaProdotto
 */
@WebServlet("/EliminaProdotto")
public class EliminaProdotto extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public EliminaProdotto() {
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
		
		int idProdotto = Integer.parseInt(request.getParameter("idProdotto"));
        
        Integer risultato = 0;
        String errore = "";
        String contenuto = "";
        
        ConnessioneDB connDB = new ConnessioneDB();
		if(connDB.getConn() != null) {
			try {
				Integer continua = 1;
				
				//Cancello gli sconti
				Statement stmt0 = connDB.getConn().createStatement();
				String sql = "";
				sql = ""
						+ "SELECT id_sconto "
						+ "FROM prodotti_sconti "
						+ "WHERE attivo = 1 AND id_prodotto = "+idProdotto+";";
				ResultSet result = stmt0.executeQuery(sql);				
				if(!result.wasNull()) {
					int rowCount = result.last() ? result.getRow() : 0;
					if(rowCount > 0) {
						Statement stmt = connDB.getConn().createStatement();
						sql = "UPDATE prodotti_sconti SET attivo = 0 WHERE attivo = 1 AND id_prodotto = "+idProdotto+";";
						if(stmt.executeUpdate(sql) == 1) {									
							continua *= 1;
						}
						else {
							errore = "Errore Cancellazione Sconti.";
							risultato *= 0;					
						}					
					}
					else {
						continua *= 1;
					}
				}					
				
				
				//Cancello Le immagini sia in DB che fisicamente
				Statement stmt1 = connDB.getConn().createStatement();
				sql = ""
						+ "SELECT id_immagine "
						+ "FROM prodotti_immagini "
						+ "WHERE attivo = 1 AND id_prodotto = "+idProdotto+";";
				result = stmt1.executeQuery(sql);				
				if(!result.wasNull()) {
					int rowCount = result.last() ? result.getRow() : 0;
					if(rowCount > 0) {
						String filePath = new SystemInformation().getPathImmaginiProdotto()+idProdotto+"\\";
						File file = new File(filePath);					    
						File[] contents = file.listFiles();
					    if (contents != null) {
					        for (File f : contents) {
							    if(!f.delete()){
									errore = "Errore Cancellazione File Immagini.";
									continua *= 0;
									return;
					    		}
					        }
					    }
					    if(file.delete()){
			    			continua *= 1;
			    		}
			    		else{
							errore = "Errore Cancellazione File Immagini.";
							continua *= 0;
							return;
			    		}				

						
						if(continua == 1) {
							Statement stmt2 = connDB.getConn().createStatement();
							sql = "UPDATE prodotti_immagini SET attivo = 0 WHERE attivo = 1 AND id_prodotto = "+idProdotto+";";
							if(stmt2.executeUpdate(sql) == 1) {									
								continua *= 1;
							}
							else {
								errore = "Errore Cancellazione Immagini.";
								risultato *= 0;					
							}												
						}
						
					}
					else {
						continua *= 1;
					}
				}					
				
				
				if(continua == 1) {
					//Cancello il prodotto
					Statement stmt3 = connDB.getConn().createStatement();
					sql = "UPDATE prodotti SET attivo = 0 WHERE id_prodotto = "+idProdotto+";";
					if(stmt3.executeUpdate(sql) == 1) {					
						contenuto = "Prodotto Eliminato con Successo";
						risultato = 1;			
					}
					else {
						errore = "Errore Cancellazione Prodotto.";
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
