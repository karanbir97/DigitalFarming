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
 * Servlet implementation class GetVettori
 */
@WebServlet("/GetVettori")
public class GetVettori extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public GetVettori() {
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
						+ "SELECT id_vettore, nome, descrizione, costo, contrassegno "
						+ "FROM ordini_vettori "
						+ "WHERE attivo = 1; ";
				ResultSet result = stmt.executeQuery(sql);				
				if(!result.wasNull()) {
					while(result.next()) {
						contenuto += "<tr>";
							contenuto += "<td>"+result.getString("nome")+"</td>";
							contenuto += "<td>"+result.getString("descrizione")+"</td>";
							contenuto += "<td>"+new SystemInformation().truncateDecimal(result.getFloat("costo"), 2)+"</td>";							
							contenuto += "<td>"+((result.getInt("contrassegno") == 1) ? "Si" : "No")+"</td>";
							contenuto += "<td> <i class='elimina eliminaVettore fas fa-times' style='cursor: pointer;' data-idvettore='"+result.getInt("id_vettore")+"' title='Elimina vettore'></i></td>";
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
	
		
		JSONObject res = new JSONObject();
		res.put("risultato", risultato);
		res.put("errore", errore);
		res.put("contenuto", contenuto);
		out.println(res);		
	}

}
