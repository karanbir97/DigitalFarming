package control;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import org.json.simple.JSONObject;

import model.ConnessioneDB;
/**
 * Servlet implementation class EliminaStati
 */
@WebServlet("/EliminaStati")
public class EliminaStati extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public EliminaStati() {
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
		
		int idstato = Integer.parseInt(request.getParameter("idstato"));
        
        Integer risultato = 0;
        String errore = "";
        String contenuto = "";
        
        ConnessioneDB connDB = new ConnessioneDB();
		if(connDB.getConn() != null) {
			try {
				Statement stmt = connDB.getConn().createStatement();
				String sql = "";
				sql = "UPDATE ordini_stati SET attivo = 0 WHERE id_stato = "+idstato+";";
				if(stmt.executeUpdate(sql) == 1) {
					contenuto = "Stato Eliminato con Successo";
					risultato = 1;			 		
				}
				else {
					errore = "Errore Cancellazione stato.";
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
