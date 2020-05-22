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
 * Servlet implementation class AggiungiMetodiPagamento
 */
@WebServlet("/AggiungiMetodiPagamento")
public class AggiungiMetodiPagamento extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AggiungiMetodiPagamento() {
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
		
		String nomemetodoPagamento = request.getParameter("nomemetodoPagamento");
		String descrizionemetodoPagamento = request.getParameter("descrizionemetodoPagamento");
		Integer inContanti = Integer.parseInt(request.getParameter("inContanti"));
        
        Integer risultato = 0;
        String errore = "";
        String contenuto = "";
        
        ConnessioneDB connDB = new ConnessioneDB();
		if(connDB.getConn() != null) {
			try {				
				String sql = "INSERT INTO ordini_metodi_pagamento (nome, descrizione, in_contanti, attivo) VALUES (?, ?, ?, ?) ;";
				PreparedStatement  stmt = connDB.getConn().prepareStatement(sql);
				stmt.setString(1, nomemetodoPagamento);
				stmt.setString(2, descrizionemetodoPagamento);		
				stmt.setInt(3, inContanti);			
				stmt.setInt(4, 1);	
				if(stmt.executeUpdate() == 1) {
					contenuto = "Metodo di Pagamento Inserito con Successo";
					risultato = 1;					
				}
				else {
					errore = "Errore Inserimento Metodo di Pagamento.";
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