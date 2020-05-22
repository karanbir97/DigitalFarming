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
 * Servlet implementation class AggiungiVettori
 */
@WebServlet("/AggiungiVettori")
public class AggiungiVettori extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AggiungiVettori() {
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
		
		String nomeVettore = request.getParameter("nomeVettore");
		String descrizioneVettore = request.getParameter("descrizioneVettore");
		Float costoVettore = Float.parseFloat(request.getParameter("costoVettore"));
		Integer contrassegnoVettore = Integer.parseInt(request.getParameter("contrassegnoVettore"));
        
        Integer risultato = 0;
        String errore = "";
        String contenuto = "";

        ConnessioneDB connDB = new ConnessioneDB();
		if(connDB.getConn() != null) {
			try {				
				
				String sql = "INSERT INTO ordini_vettori (nome, descrizione, costo, contrassegno, attivo) VALUES (?, ?, ?, ?, ?) ;";
				PreparedStatement  stmt = connDB.getConn().prepareStatement(sql);
				stmt.setString(1, nomeVettore);
				stmt.setString(2, descrizioneVettore);		 
				stmt.setFloat(3, costoVettore);			
				stmt.setInt(4, contrassegnoVettore);
				stmt.setInt(5, 1);
				if(stmt.executeUpdate() == 1) {
					contenuto = "Vettore Inserito con Successo";
					risultato = 1;					
				}
				else {
					errore = "Errore Inserimento del Vettore.";
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
