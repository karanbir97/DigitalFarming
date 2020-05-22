package control;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import org.json.simple.JSONObject;
/**
 * Servlet implementation class GetFormAggiungiVettore
 */ 
@WebServlet("/GetFormAggiungiVettore")
public class GetFormAggiungiVettore extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public GetFormAggiungiVettore() {
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
        
		if(Integer.parseInt(request.getParameter("richiesta"))  == 1) {
	        Integer risultato = 0;
	        String errore = "";
	        String contenuto = "";
	        
	        contenuto += "<input type='text' id='nomeVettore' class='nome adminFormField' name='nome' placeholder='Nome vettore' />";
	        contenuto += "<input type='text' id='descrizioneVettore' class='descrizione adminFormField' name='descrizione' placeholder='Descrizione vettore' />";
	        contenuto += "<input type='number' id='costoVettore' class='costo adminFormField' name='costo' placeholder='Costo' step='0.01'/>";
	        contenuto += "<select id='contrassegnoVettore' class='contrassegno adminFormField' name='contrassegno'>";
	        contenuto += "<option value='1'> Si </option>";
	        contenuto += "<option value='0'> No </option>";
	        contenuto += "</select>";
	        contenuto += "<button id='confirmAggiungivettore' class='adminButtonConfermaAggiungi'>Aggiungi</button>";
	        risultato = 1;
	
	        				
			JSONObject res = new JSONObject();
			res.put("risultato", risultato);
			res.put("errore", errore);
			res.put("contenuto", contenuto);
			out.println(res);			
		}
	}

}
