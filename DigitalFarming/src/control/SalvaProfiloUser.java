package control;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;

import model.ConnessioneDB;

/**
 * Servlet implementation class SalvaProfiloUser
 */
@WebServlet("/SalvaProfiloUser")
public class SalvaProfiloUser extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SalvaProfiloUser() {
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
		
		Integer idUtente = Integer.parseInt(request.getParameter("idUtente"));
		Integer tipo = Integer.parseInt(request.getParameter("tipo"));		

		String passwordUtente = "";
		String nomeUtente = request.getParameter("nomeUtente");
		String cognomeUtente = request.getParameter("cognomeUtente");
		String sessoUtente = request.getParameter("sessoUtente");
		String dataNascitaUtente = request.getParameter("dataNascitaUtente");	
		if(tipo == 1){ //Salvo anche la pwd
			passwordUtente = request.getParameter("passwordUtente");
		}
		
        Integer risultato = 0;
        String errore = "";
        String contenuto = "";
		
        ConnessioneDB connDB = new ConnessioneDB();
		if(connDB.getConn() != null) {
			try {				
				String sql = "";
				PreparedStatement  stmt = null;
				if(tipo == 0){ //Salvo solo i dati
					sql = "UPDATE utenti SET nome = ?, cognome = ?, sesso = ?, data_nascita = ? WHERE id_utente = ?;";
					stmt = connDB.getConn().prepareStatement(sql);
					stmt.setString(1, nomeUtente);
					stmt.setString(2, cognomeUtente);
					stmt.setString(3, sessoUtente);
					stmt.setString(4, dataNascitaUtente);
					stmt.setInt(5, idUtente);	
				}
				else if(tipo == 1){ //Salvo anche la pwd			
					sql = "UPDATE utenti SET nome = ?, cognome = ?, sesso = ?, data_nascita = ?, password = ? WHERE id_utente = ?;";
					stmt = connDB.getConn().prepareStatement(sql);
					stmt.setString(1, nomeUtente);
					stmt.setString(2, cognomeUtente);
					stmt.setString(3, sessoUtente);
					stmt.setString(4, dataNascitaUtente);
					stmt.setString(5, passwordUtente);
					stmt.setInt(6, idUtente);	
				}						
			
				if(stmt.executeUpdate() == 1) {
					contenuto = "Utenza Aggiornata con Successo";
					risultato = 1;					
				}
				else {
					errore = "Errore Aggiornamento Password.";
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
