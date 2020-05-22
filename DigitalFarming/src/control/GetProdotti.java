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
import model.SystemInformation;
/**
 * Servlet implementation class GetProdotti
 */
@WebServlet("/GetProdotti")
public class GetProdotti extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public GetProdotti() {
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
						+ "SELECT p.id_prodotto, p.nome, p.descrizione, p.descrizione_abbreviata, p.quantita_disponibile, p.prezzo_base, (SELECT nome FROM prodotti_aliquote WHERE id_aliquota = p.id_aliquota) AS aliquota, (SELECT nome FROM prodotti_categorie WHERE id_categoria = p.id_categoria) AS categoria, (SELECT sigla FROM prodotti_unita WHERE id_unita = p.id_unita) AS unita "
						+ "FROM prodotti  AS p "
						+ "WHERE p.attivo = 1; ";
				//System.out.println(sql);
				ResultSet result = stmt.executeQuery(sql);				
				if(!result.wasNull()) {
					while(result.next()) {
						contenuto += "<tr>";
							contenuto += "<td>"+result.getInt("id_prodotto")+"</td>";	
							contenuto += "<td>"+result.getString("categoria")+"</td>";
							contenuto += "<td>"+result.getString("nome")+"</td>";							
							contenuto += "<td title='"+result.getString("descrizione")+"'>"+((result.getString("descrizione").length() > 50) ? result.getString("descrizione").substring(0,50)+"&hellip;" : result.getString("descrizione"))+"</td>";
							contenuto += "<td>"+result.getString("descrizione_abbreviata")+"</td>";							
							contenuto += "<td>";
							contenuto += result.getInt("quantita_disponibile");
							contenuto += "&nbsp;<i class='modificaQuantita fas fa-edit' style='cursor: pointer;' data-idprodotto='"+result.getInt("id_prodotto")+"' title='Modifica Quantit&agrave; Prodotto'></i>";
							contenuto += "</td>";								
							contenuto += "<td>"+result.getString("unita")+"</td>";							
							contenuto += "<td>";
							contenuto += new SystemInformation().truncateDecimal(result.getFloat("prezzo_base"),2);
							contenuto += "&nbsp;<i class='modificaPrezzo fas fa-edit' style='cursor: pointer;' data-idprodotto='"+result.getInt("id_prodotto")+"' title='Modifica Prezzo Prodotto'></i>";
							contenuto += "</td>";							
							contenuto += "<td>"+result.getString("aliquota")+"</td>";							
							contenuto += "<td>";
							contenuto += "	<i class='foto fotoProdotto fas fa-camera' style='cursor: pointer;' data-idprodotto='"+result.getInt("id_prodotto")+"' title='Gestisci Foto'></i>";
							contenuto += "	<i class='elimina eliminaProdotto fas fa-times' style='cursor: pointer;' data-idprodotto='"+result.getInt("id_prodotto")+"' title='Elimina Prodotto'></i>";
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
