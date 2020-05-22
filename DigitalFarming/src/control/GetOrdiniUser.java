package control;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;
import java.sql.Statement;
import java.text.SimpleDateFormat;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;

import model.ConnessioneDB;
import model.SystemInformation;

/**
 * Servlet implementation class GetOrdiniUser
 */
@WebServlet("/GetOrdiniUser")
public class GetOrdiniUser extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public GetOrdiniUser() {
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
	    
    	if(request.getSession() != null){
    		Integer idUtente = (Integer) request.getSession().getAttribute("id_utente");    		
    		if(idUtente != null){
		        ConnessioneDB connDB = new ConnessioneDB();
				if(connDB.getConn() != null) {
					
					try {
						Statement stmt = connDB.getConn().createStatement();
						String sql = "";
						sql = ""
								+ "SELECT o.id_ordine, o.id_stato, o.data_ordine, (SELECT SUM(quantita) FROM ordini_prodotti WHERE id_ordine = o.id_ordine) AS numero_prodotti, o.totale_ordine, (SELECT nome FROM ordini_stati WHERE id_stato = o.id_stato) AS stato, (SELECT ordine_annullabile FROM ordini_stati WHERE id_stato = o.id_stato) AS ordine_annullabile, TIMESTAMPDIFF(MINUTE, o.data_ordine, NOW()) AS diff, (SELECT valore FROM impostazioni WHERE attivo = 1 AND TRIM(slug) = TRIM('numero_ore_ordine_annullabile')) AS numero_ore_ordine_annullabile "
								+ "FROM ordini  AS o "
								+ "WHERE o.attivo = 1 AND o.id_utente = "+idUtente+" "
								+ "ORDER BY o.data_ordine DESC, o.id_ordine DESC; ";
						ResultSet result = stmt.executeQuery(sql);				
						if(!result.wasNull()) {
							SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
							while(result.next()) {
								contenuto += "<tr>";
									contenuto += "<td>"+result.getInt("id_ordine")+"</td>";	
									contenuto += "<td>"+sdf.format(result.getDate("data_ordine"))+"</td>";
									contenuto += "<td>"+result.getString("numero_prodotti")+"</td>";							
									contenuto += "<td>&euro;"+new SystemInformation().truncateDecimal(result.getFloat("totale_ordine"),2)+"</td>";
									contenuto += "<td>"+result.getString("stato")+"</td>";							
									contenuto += "<td>";
									contenuto += "	<i class='foto dettaglioOrdine fas fa-search' style='cursor: pointer;' data-idordine='"+result.getInt("id_ordine")+"' title='Dettaglio Ordine'></i>";
									if(result.getInt("ordine_annullabile") == 1 && result.getInt("diff") <= result.getInt("numero_ore_ordine_annullabile")) { //se lo stato permette di annullare l'ordine e non sono trascorse più di 24h
										contenuto += "	<i class='elimina eliminaOrdine fas fa-times' style='cursor: pointer;' data-idordine='"+result.getInt("id_ordine")+"' title='Elimina Ordine'></i>";
									}									
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
        		errore = "Errore Parametri.";
        		risultato = 0;    			
    		}
    	}
    	else{
    		errore = "Errore Parametri.";
    		risultato = 0;
    	}
			
		
		JSONObject res = new JSONObject();
		res.put("risultato", risultato);
		res.put("errore", errore);
		res.put("contenuto", contenuto);
		out.println(res);		
	}


}
