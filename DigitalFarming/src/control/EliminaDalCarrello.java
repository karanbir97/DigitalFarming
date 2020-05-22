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
import model.SystemInformation;

/**
 * Servlet implementation class EliminaDalCarrello
 */
@WebServlet("/EliminaDalCarrello")
public class EliminaDalCarrello extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public EliminaDalCarrello() {
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
        Integer redirect = 0;
        String errore = "";
        String contenuto = "";
        String urlRedirect = "";

		Integer idProdotto = Integer.parseInt(request.getParameter("idProdotto"));
		
		Integer idUtente = 0;			
		if(request.getSession().getAttribute("id_utente") != null) {
			idUtente = (Integer) request.getSession().getAttribute("id_utente");
		}					

        if(idUtente > 0) {
        	Carrello cart = (Carrello) request.getSession().getAttribute("carrello");
        	if(cart != null) {        		
	        	if(cart.getProdottoByIdProdotto(idProdotto) != null) { //Se ci sta	        		
	        		cart.delProdotto(idProdotto);
		        	request.getSession().setAttribute("carrello", cart);
		        	contenuto = "Prodotto Eliminato con Successo";
		        	risultato = 1;
	        	}
	        	else {
	        		risultato = 0;
	        		errore = "Prodotto Non Trovato";	        		
	        	}
        	}
        	else {
        		risultato = 0;
        		errore = "Carrello Non Trovato";
        	}
        }
        else {
        	risultato = 1;
        	redirect = 1;
        	contenuto = "Utente Non Loggato";
        	urlRedirect = new SystemInformation().getUrlRedirect();
        }
       
           
        				
		JSONObject res = new JSONObject();
		res.put("risultato", risultato);
		res.put("errore", errore);
		res.put("contenuto", contenuto);
		res.put("redirect", redirect);
		res.put("urlRedirect", urlRedirect);
		out.println(res);
	}


}
