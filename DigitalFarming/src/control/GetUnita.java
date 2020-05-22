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
/**
 * Servlet implementation class GetUnita
 */
@WebServlet("/GetUnita")
public class GetUnita extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public GetUnita() {
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
						+ "SELECT id_unita, nome, sigla "
						+ "FROM prodotti_unita "
						+ "WHERE attivo = 1; ";
				ResultSet result = stmt.executeQuery(sql);				
				if(!result.wasNull()) {
					while(result.next()) {
						contenuto += "<tr>";
							contenuto += "<td>"+result.getString("nome")+"</td>";
							contenuto += "<td>"+result.getString("sigla")+"</td>";
							contenuto += "<td> <i class='elimina eliminaUnita fas fa-times' style='cursor: pointer;' data-idunita='"+result.getInt("id_unita")+"' title='Elimina Unita'></i></td>";
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
