package control;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.json.simple.JSONObject;
import model.Carrello;

/**
 * Servlet implementation class GetCarrelloSmall
 */
@WebServlet("/GetCarrelloSmall")
public class GetCarrelloSmall extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public GetCarrelloSmall() {
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
	    
		Integer risultato = 0;
	    String errore = "";
	    String contenuto = "";

		Integer richiesta = Integer.parseInt(request.getParameter("richiesta"));	   
		if(richiesta == 1) {
        	Carrello cart = (Carrello) request.getSession().getAttribute("carrello");
        	if(cart != null) {
        		int n = cart.getNumeroProdotti();
        		if(n != 0) {
        			contenuto = String.valueOf(n);
        		}
        		risultato = 1;
        	}
        	else {
        		errore = "Carrello Non Trovato.";
				risultato = 0;
        	}
		}
		
		JSONObject res = new JSONObject();
		res.put("risultato", risultato);
		res.put("errore", errore);
		res.put("contenuto", contenuto);
		out.println(res);		
	}


}
