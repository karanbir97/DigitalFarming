package control;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import org.json.simple.JSONObject;
/**
 * Servlet implementation class GetFormAggiungiImmagine
 */ 
@WebServlet("/GetFormAggiungiImmagine")
public class GetFormAggiungiImmagine extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public GetFormAggiungiImmagine() {
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
	        
        	contenuto += "<div id='containerDefaultImmagine'><input type='checkbox' id='defaultImmagine' class='default adminFormField' name='nome' /> <label for='defaultImmagine'>Primaria</label></div>";
        	contenuto += "<div action='"+request.getContextPath()+"/UploadImmagineProdotto' class='dropzoneImmagineProdotto'></div>";	        
        	contenuto += "<input type='hidden' id='filenameImmagineProdotto' value='' />";
        	contenuto += "<input type='submit' id='confirmAggiungiImmagine' class='adminButtonConfermaAggiungi' value='Aggiungi' />";	        	
	        contenuto += "<script>createDropzone();</script>";	        
	        
	        risultato = 1;
	
	        				
			JSONObject res = new JSONObject();
			res.put("risultato", risultato);
			res.put("errore", errore);
			res.put("contenuto", contenuto);
			out.println(res);			
		}
	}

}
