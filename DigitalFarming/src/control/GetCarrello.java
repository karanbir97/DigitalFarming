package control;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;

import model.Carrello;
import model.ConnessioneDB;
import model.Prodotto;
import model.SystemInformation;

/**
 * Servlet implementation class GetCarrello
 */
@WebServlet("/GetCarrello")
public class GetCarrello extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public GetCarrello() {
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
	    
		Integer risultato = 1;
	    String errore = "";
	    String contenuto = "";

    	if(request.getSession() != null){
    		Integer idUtente = (Integer) request.getSession().getAttribute("id_utente");    		
    		Carrello cart = (Carrello) request.getSession().getAttribute("carrello");
    		if(idUtente != null && cart != null){
    			String sql;
    			Statement stmt;
    			ResultSet result;
    			Integer idProdotto;
    			Integer quantitaProdotto;
    			Float prz;
    			
    	        ConnessioneDB connDB = new ConnessioneDB();
    			if(connDB.getConn() != null) {
	    			for(Prodotto prodotto: cart.getProdotti()) { //Per ogni prodotto del carrello
	    				try {
		    				sql = "";
		    				stmt = null;
		    				result = null;		    				
		    				idProdotto = prodotto.getIdProdotto();
		    				quantitaProdotto = prodotto.getQuantita();
	    					stmt = connDB.getConn().createStatement();
		    				sql = ""
									+ "SELECT p.nome, p.prezzo_base, "
									+ "(SELECT valore FROM prodotti_aliquote WHERE id_aliquota = p.id_aliquota) AS aliquota, "
									+ "(SELECT sigla FROM prodotti_unita WHERE id_unita = p.id_unita) AS unita, "
									+ "(SELECT filename FROM prodotti_immagini WHERE id_prodotto = p.id_prodotto AND is_default = 1 AND attivo = 1) AS filename, "
									+ "(SELECT prezzo FROM prodotti_sconti WHERE id_prodotto = p.id_prodotto AND attivo = 1 AND DATE(NOW()) >= data_da AND data_a >= DATE(NOW()) ORDER BY data_inserimento DESC LIMIT 1) AS prezzo_scontato "
									+ "FROM prodotti  AS p "
									+ "WHERE p.attivo = 1 AND p.id_prodotto = "+idProdotto+"; ";
	    					//System.out.println(sql);
	    					result = stmt.executeQuery(sql);				
	    					if(!result.wasNull()) {
	    						while(result.next()) {
	    							String filename;
	    							if(result.getString("filename") != null){
	    								filename = new SystemInformation().getPathImmaginiProdottoHTML()+idProdotto+"/"+result.getString("filename");												
	    							}
	    							else{
	    								filename = new SystemInformation().getPathImmaginiProdottoDefault();												
	    							}	    							
	    							
	    							contenuto += "<tr>";							
    									contenuto += "<td>"+idProdotto+"</td>";							
	    								contenuto += "<td><img class='showImmagineProdotto' src='"+filename+"' alt='"+filename+"' /></td>";
	    								contenuto += "<td>"+result.getString("nome")+"</td>";							
	    								contenuto += "<td><i class='fas fa-minus rimuoviQuantitaProdottoCarrello' data-idprodotto='"+idProdotto+"'></i>&nbsp;&nbsp;"+quantitaProdotto+"&nbsp;&nbsp;<i class='fas fa-plus aggiungiQuantitaProdottoCarrello' data-idprodotto='"+idProdotto+"'></i></td>";
	    								contenuto += "<td>";	    								
										if(result.getString("prezzo_scontato") != null){
											prz = result.getFloat("prezzo_scontato") * (1+(result.getFloat("aliquota")/100));
											contenuto += "<span style='color: #DC483E;'>&euro; "+ new SystemInformation().truncateDecimal(prz, 2)+"*/"+result.getString("unita")+"</span>";
										}
										else{
											prz = result.getFloat("prezzo_base") * (1+(result.getFloat("aliquota")/100));
											contenuto += "&euro; "+ new SystemInformation().truncateDecimal(prz, 2)+"/"+result.getString("unita");
										}
	    								contenuto += "</td>";    								    							
	    								contenuto += "<td>";
	    								contenuto += "	<i class='elimina eliminaProdottoCarrello fas fa-times' style='cursor: pointer;' data-idprodotto='"+idProdotto+"' title='Elimina Prodotto'></i>";
	    								contenuto += "</td>";
	    							contenuto += "</tr>";
	    						}					
	    					}				 	    						    		
	    					risultato *= 1;
	    				}
	    				catch(Exception e) {
	    					errore += "Errore esecuzione Query."+e.getMessage();
	    					risultato *= 0;	    					
	    				}	    				    				
	    			}	    	
	    			
	    			try {
	    				if(risultato == 0) {
	    					connDB.getConn().rollback();
	    				}
	    				else {
	    					connDB.getConn().commit();
	    				}													    				
						connDB.getConn().close();
					} catch (SQLException e) {
						errore = connDB.getError();
		    			risultato *= 0;
					}
	    			
	    			risultato *= 1;    			
    			}
	    		else {
	    			errore = connDB.getError();
	    			risultato *= 0;
	    		}	    			
    		}
    		else{
    			risultato *= 0;
    			errore = "Errore Parametri";
    		}
    	}
		else{
			risultato *= 0;
			errore = "Errore Parametri";
		}	    
	   
		
		JSONObject res = new JSONObject();
		res.put("risultato", risultato);
		res.put("errore", errore);
		res.put("contenuto", contenuto);
		out.println(res);		
	}


}
