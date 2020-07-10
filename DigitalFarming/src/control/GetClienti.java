package control;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;
import java.sql.Statement;
import java.text.SimpleDateFormat;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;

import model.ConnessioneDB;

/**
 * Servlet implementation class GetClienti
 */
@WebServlet("/GetClienti")
public class GetClienti extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public GetClienti() {
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
	    
        ConnessioneDB connDB = new ConnessioneDB();
		if(connDB.getConn() != null) {
			
			try {
				Statement stmt = connDB.getConn().createStatement();
				String sql = "";
				sql = ""
						+ "SELECT id_utente, email, codice_fiscale, nome, cognome, sesso, data_nascita "
						+ "FROM utenti "
						+ "WHERE attivo = 1 AND (id_tipo = 2 OR id_tipo = 3 OR id_tipo = 4); ";
				ResultSet result = stmt.executeQuery(sql);				
				if(!result.wasNull()) {
					SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
					while(result.next()) {
						contenuto += "<tr>";
						contenuto += "<td>"+result.getInt("id_utente")+"</td>";
						contenuto += "<td>"+result.getString("email")+"</td>";
						contenuto += "<td>"+result.getString("codice_fiscale")+"</td>";
							contenuto += "<td>"+result.getString("nome")+"</td>";
							contenuto += "<td>"+result.getString("cognome")+"</td>";
							contenuto += "<td>"+result.getString("sesso")+"</td>";
							contenuto += "<td>"+sdf.format(result.getDate("data_nascita"))+"</td>";
							contenuto += "<td> <i class='elimina eliminaCliente fas fa-times' style='cursor: pointer;' data-idutente='"+result.getInt("id_utente")+"' title='Elimina Cliente'></i></td>";
						contenuto += "</tr>";
					}					
				}				 
				
				risultato = 1;

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
