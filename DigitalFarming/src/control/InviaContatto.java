package control;

import java.io.IOException; 
import java.io.PrintWriter;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import org.json.simple.JSONObject;

import model.ConnessioneDB;
/**
 * Servlet implementation class InviaContatto
 */
@WebServlet("/InviaContatto")
public class InviaContatto extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public InviaContatto() {
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
		
		String nome = request.getParameter("nome");
		String email = request.getParameter("email");
		String messaggio = request.getParameter("messaggio");
		Integer idCliente = Integer.parseInt(request.getParameter("idCliente"));
		Integer idOrdine = Integer.parseInt(request.getParameter("idOrdine"));
		        
        Integer risultato = 0;
        String errore = "";
        String contenuto = "";
        
        ConnessioneDB connDB = new ConnessioneDB();
		if(connDB.getConn() != null) {
			try {				
				String sql = "INSERT INTO contatti (id_cliente, id_ordine, nome, email, note, letta, data_registrazione, attivo) VALUES (?, ?, ?, ?, ?, ?, DATE(NOW()), ?);";
				PreparedStatement  stmt = connDB.getConn().prepareStatement(sql);				
				
				if(idCliente == 0) stmt.setNull(1, 1); else stmt.setInt(1, idCliente); 
				if(idOrdine == 0) stmt.setNull(2, 1); else stmt.setInt(2, idOrdine);				
				stmt.setString(3, nome);			
				stmt.setString(4, email);
				stmt.setString(5, messaggio);
				stmt.setInt(6, 0);				
				stmt.setInt(7, 1);
				if(stmt.executeUpdate() == 1) {
					contenuto = "Grazie per averci Contattato";
					risultato = 1;					
				}
				else {
					errore = "Errore Inserimento Contatto.";
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
