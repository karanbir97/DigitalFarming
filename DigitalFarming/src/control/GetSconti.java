package control;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;
import java.sql.Statement;
import java.text.SimpleDateFormat;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import org.json.simple.JSONObject;

import model.ConnessioneDB;
import model.SystemInformation;
/**
 * Servlet implementation class GetSconti
 */
@WebServlet("/GetSconti")
public class GetSconti extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public GetSconti() {
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
						+ "SELECT ps.id_sconto, p.nome AS nome_prodotto, p.prezzo_base, ps.prezzo AS prezzo_scontato, ps.data_da, ps.data_a "
						+ "FROM prodotti_sconti AS ps INNER JOIN prodotti AS p ON p.id_prodotto = ps.id_prodotto  "
						+ "WHERE ps.attivo = 1 AND p.attivo = 1; ";
				ResultSet result = stmt.executeQuery(sql);				
				if(!result.wasNull()) {
					SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
					while(result.next()) {
						contenuto += "<tr>";
							contenuto += "<td>"+result.getString("nome_prodotto")+"</td>";
							contenuto += "<td>"+new SystemInformation().truncateDecimal(result.getFloat("prezzo_base"),2)+"</td>";
							contenuto += "<td>"+new SystemInformation().truncateDecimal(result.getFloat("prezzo_scontato"),2)+"</td>";
							contenuto += "<td>"+sdf.format(result.getDate("data_da"))+"</td>";
							contenuto += "<td>"+sdf.format(result.getDate("data_a"))+"</td>";
							contenuto += "<td> <i class='elimina eliminaSconto fas fa-times' style='cursor: pointer;' data-idsconto='"+result.getInt("id_sconto")+"' title='Elimina Sconto'></i></td>";
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
