package control;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;

import model.ConnessioneDB;

/**
 * Servlet implementation class SalvaUtente
 */
@WebServlet("/SalvaUtente")
public class SalvaUtente extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SalvaUtente() {
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
		
		String emailUtente = request.getParameter("emailUtente");
		String passwordUtente = request.getParameter("passwordUtente");
		String codiceFiscaleUtente = request.getParameter("codiceFiscaleUtente");
		String nomeUtente = request.getParameter("nomeUtente");
		String cognomeUtente = request.getParameter("cognomeUtente");
		String sessoUtente = request.getParameter("sessoUtente");
		String dataNascitaUtente = request.getParameter("dataNascitaUtente");
		Integer tipoUtente = Integer.parseInt(request.getParameter("tipoUtente"));
		
        Integer risultato = 0;
        String errore = "";
        String contenuto = "";
		
        ConnessioneDB connDB = new ConnessioneDB();
		if(connDB.getConn() != null) {
			try {				
				String sql;
				Statement stmt0 = connDB.getConn().createStatement();
				sql = ""
						+ "SELECT id_utente "
						+ "FROM utenti "
						+ "WHERE attivo = 1 AND (TRIM(email) = TRIM('"+emailUtente+"') OR TRIM(codice_fiscale) = TRIM('"+codiceFiscaleUtente.toUpperCase()+"')); ";
				ResultSet result = stmt0.executeQuery(sql);				
				if(!result.wasNull()) {
					int rowCount = result.last() ? result.getRow() : 0;
					if(rowCount > 0) {
						errore = "Esiste gi&agrave; un utente con questa email o con questo codice fiscale.";
						risultato = 0;
					}					
					else {
						sql = "INSERT INTO utenti (email, password, codice_fiscale, nome, cognome, sesso, data_nascita, data_registrazione, id_tipo, attivo) VALUES (?, ?, ?, ?, ?, ?, ?, NOW(), ?, ?);";
						PreparedStatement  stmt = connDB.getConn().prepareStatement(sql);
						stmt.setString(1, emailUtente.trim());
						stmt.setString(2, passwordUtente);
						stmt.setString(3, codiceFiscaleUtente.toUpperCase().trim());
						stmt.setString(4, nomeUtente);
						stmt.setString(5, cognomeUtente);
						stmt.setString(6, sessoUtente.toUpperCase());
						stmt.setString(7, dataNascitaUtente);			
						stmt.setInt(8, tipoUtente);				
						stmt.setInt(9, 1);				
						if(stmt.executeUpdate() == 1) {
							contenuto = "Registrazione Effettuata con Successo";
							risultato = 1;					
						}
						else {
							errore = "Errore registrazione.";
							risultato = 0;					
						}				
					}
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
