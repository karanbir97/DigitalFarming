package control;

import java.io.IOException; 
import java.io.PrintWriter;
import java.sql.PreparedStatement;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.Locale;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import org.json.simple.JSONObject;

import model.ConnessioneDB;
/**
 * Servlet implementation class AggiungiSconto
 */
@WebServlet("/AggiungiSconto")
public class AggiungiSconto extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AggiungiSconto() {
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
		
		Integer prodottoSconto = Integer.parseInt(request.getParameter("prodottoSconto"));
		Float prezzoSconto = Float.parseFloat(request.getParameter("prezzoSconto"));
		String daSconto = request.getParameter("daSconto");
		String aSconto = request.getParameter("aSconto");      
		
        Integer risultato = 0;
        String errore = "";
        String contenuto = "";
        
        
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern ( "yyyy-MM-dd" , Locale.ITALIAN );      
        LocalDate localDa = LocalDate.parse ( daSconto , formatter );
        LocalDate localA = LocalDate.parse ( aSconto , formatter );
        if(localDa.isBefore(localA) || localDa.isEqual(localA)) {
	        ConnessioneDB connDB = new ConnessioneDB();
			if(connDB.getConn() != null) {
				try {				
					String sql = "INSERT INTO prodotti_sconti(id_prodotto, prezzo, data_da, data_a, data_inserimento, attivo) VALUES (?, ?, ?, ?, NOW(), ?) ;";
					PreparedStatement  stmt = connDB.getConn().prepareStatement(sql);
					stmt.setInt(1, prodottoSconto);
					stmt.setFloat(2, prezzoSconto);
					stmt.setString(3, daSconto);				
					stmt.setString(4, aSconto);								
					stmt.setInt(5, 1);				
					if(stmt.executeUpdate() == 1) {
						contenuto = "Sconto Inserito con Successo";
						risultato = 1;					
					}
					else {
						errore = "Errore Inserimento Sconto.";
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

        }
        else {
			errore = "Controllare di Aver Inserito due date corrette.";
			risultato = 0;		        	
        }
             
        				
		JSONObject res = new JSONObject();
		res.put("risultato", risultato);
		res.put("errore", errore);
		res.put("contenuto", contenuto);
		out.println(res);
	}

}
