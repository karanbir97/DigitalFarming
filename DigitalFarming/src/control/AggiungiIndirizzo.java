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
 * Servlet implementation class AggiungiIndirizzo
 */
@WebServlet("/AggiungiIndirizzo")
public class AggiungiIndirizzo extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AggiungiIndirizzo() {
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

		Integer capIndirizzo = Integer.parseInt(request.getParameter("capIndirizzo"));
		Integer cittaIndirizzo = Integer.parseInt(request.getParameter("cittaIndirizzo"));
		Integer provinciaIndirizzo = Integer.parseInt(request.getParameter("provinciaIndirizzo"));
		Integer idUtente = Integer.parseInt(request.getParameter("idUtente"));
		
		String nomeIndirizzo = request.getParameter("nomeIndirizzo");
		String cognomeIndirizzo = request.getParameter("cognomeIndirizzo");
		String indirizzoIndirizzo = request.getParameter("indirizzoIndirizzo");
		String telefonoIndirizzo = request.getParameter("telefonoIndirizzo");
		String cellulareIndirizzo = request.getParameter("cellulareIndirizzo");
		String noteIndirizzo = request.getParameter("noteIndirizzo");
		
        Integer risultato = 0;
        String errore = "";
        String contenuto = "";
        
        
        ConnessioneDB connDB = new ConnessioneDB();
		if(connDB.getConn() != null) {
			try {				
				String sql = "INSERT INTO indirizzi(nome, cognome, indirizzo, note, id_cap, id_citta, id_provincia, telefono, cellulare, data_registrazione, id_utente, attivo) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, NOW(), ?, ?) ;";
				PreparedStatement  stmt = connDB.getConn().prepareStatement(sql);
				stmt.setString(1, nomeIndirizzo);				
				stmt.setString(2, cognomeIndirizzo);				
				stmt.setString(3, indirizzoIndirizzo);				
				stmt.setString(4, noteIndirizzo);				
				stmt.setInt(5, capIndirizzo);
				stmt.setInt(6, cittaIndirizzo);
				stmt.setInt(7, provinciaIndirizzo);
				stmt.setString(8, telefonoIndirizzo);				
				stmt.setString(9, cellulareIndirizzo);				
				stmt.setInt(10, idUtente);
				stmt.setInt(11, 1);			
				if(stmt.executeUpdate() == 1) {
					contenuto = "Indirizzo Inserito con Successo";
					risultato = 1;					
				}
				else {
					errore = "Errore Inserimento Indirizzo.";
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
