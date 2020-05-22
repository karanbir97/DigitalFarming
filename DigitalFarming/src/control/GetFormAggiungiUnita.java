package control;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import org.json.simple.JSONObject;
/**
 * Servlet implementation class GetFormAggiungiUnita
 */ 
@WebServlet("/GetFormAggiungiUnita")
public class GetFormAggiungiUnita extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public GetFormAggiungiUnita() {
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
	        
	        contenuto += "<input type='text' id='nomeUnita' class='nome adminFormField' name='nome' placeholder='Nome Unit&agrave;' />";
	        contenuto += "<input type='text' id='siglaUnita' class='sigla adminFormField' name='sigla' placeholder='Sigla Unit&agrave;' />";
	        contenuto += "<button id='confirmAggiungiUnita' class='adminButtonConfermaAggiungi'>Aggiungi</button>";
	        risultato = 1;
	
	        				
			JSONObject res = new JSONObject();
			res.put("risultato", risultato);
			res.put("errore", errore);
			res.put("contenuto", contenuto);
			out.println(res);			
		}
	}

}
