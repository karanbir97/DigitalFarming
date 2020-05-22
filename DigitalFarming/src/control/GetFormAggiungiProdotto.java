package control;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import org.json.simple.JSONObject;

import model.ConnessioneDB;
/**
 * Servlet implementation class GetFormAggiungiProdotto
 */ 
@WebServlet("/GetFormAggiungiProdotto")
public class GetFormAggiungiProdotto extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public GetFormAggiungiProdotto() {
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
	        Integer risultato = 1;
	        String errore = "";
	        String contenuto = "";
	        
	        
	        /*PRELEVO LE CATEGORIE, LE ALIQUOTE E LE UNITA*/
	        String categorie = "";
	        String aliquote = "";
	        String unita = "";
	        Statement stmt;
	        String sql;
	        ResultSet result;
	        ConnessioneDB connDB = new ConnessioneDB();
			if(connDB.getConn() != null) {			
				try {
					//Categorie
					stmt = connDB.getConn().createStatement();
					sql = "";
					sql = ""
							+ "SELECT id_categoria, nome "
							+ "FROM prodotti_categorie "
							+ "WHERE attivo = 1; ";
					result = stmt.executeQuery(sql);				
					if(!result.wasNull()) {
						int rowCount = result.last() ? result.getRow() : 0;
						if(rowCount > 0) {
							categorie += "<option value='0'>Selezionare una Categoria</option>";
							result.beforeFirst();
							while(result.next()) {
								categorie += "<option value='"+result.getString("id_categoria")+"'>"+result.getString("nome")+"</option>";
							}												
						}
						else {
							categorie += "<option value='0'>Nessuna Categoria Esistente</option>";
						}
					}		
					else {
						risultato *= 0;
					}

					//Aliquote
					stmt = connDB.getConn().createStatement();
					sql = "";
					sql = ""
							+ "SELECT id_aliquota, nome "
							+ "FROM prodotti_aliquote "
							+ "WHERE attivo = 1; ";
					result = stmt.executeQuery(sql);				
					if(!result.wasNull()) {
						int rowCount = result.last() ? result.getRow() : 0;
						if(rowCount > 0) {
							aliquote += "<option value='0'>Selezionare un'Aliquota</option>";
							result.beforeFirst();
							while(result.next()) {
								aliquote += "<option value='"+result.getString("id_aliquota")+"'>"+result.getString("nome")+"</option>";
							}												
						}
						else {
							aliquote += "<option value='0'>Nessuna Aliquota Esistente</option>";
						}
					}			
					else {
						risultato *= 0;
					}
					
					
					//Unita
					stmt = connDB.getConn().createStatement();
					sql = "";
					sql = ""
							+ "SELECT id_unita, sigla "
							+ "FROM prodotti_unita "
							+ "WHERE attivo = 1; ";
					result = stmt.executeQuery(sql);				
					if(!result.wasNull()) {
						int rowCount = result.last() ? result.getRow() : 0;
						if(rowCount > 0) {
							unita += "<option value='0'>Selezionare un'unit&agrave;</option>";
							result.beforeFirst();
							while(result.next()) {
								unita += "<option value='"+result.getString("id_unita")+"'>"+result.getString("sigla")+"</option>";
							}												
						}
						else {
							unita += "<option value='0'>Nessuna Unit&agrave; Esistente</option>";
						}
					}			
					else {
						risultato *= 0;
					}
					
					risultato *= 1;
					
					if(risultato == 0) {
						connDB.getConn().rollback();
					}
					else {
						connDB.getConn().commit();
					}																	
					connDB.getConn().close();
					
				}
				catch(Exception e) {
					errore = "Errore esecuzione Query1.";
					risultato *= 0;
				}
						
			}
			else {
				errore = connDB.getError();
				risultato *= 0;
			}						    
	        	        	        	       
	        contenuto += "<select id='categoriaProdotto' class='categoria adminFormField' name='categoria'>";
	        contenuto += categorie;
	        contenuto += "</select>";	     	        
	        contenuto += "<input type='text' id='nomeProdotto' class='nome adminFormField' name='nome' placeholder='Nome' />";
	        contenuto += "<input type='text' id='descrizioneProdotto' class='descrizione adminFormField' name='descrizione' placeholder='Descrizione' />";
	        contenuto += "<input type='text' id='descrizioneAbbreviataProdotto' class='descrizioneAbbreviata adminFormField' name='descrizioneAbbreviata' placeholder='Descrizione Abbreviata' />";	        
	        contenuto += "<input type='number' id='quantitaProdotto' class='quantita adminFormField' name='quantita' placeholder='Quantit&agrave;' />";
	        contenuto += "<select id='unitaProdotto' class='unita adminFormField' name='unita'>";
	        contenuto += unita;
	        contenuto += "</select>";	     	        
	        contenuto += "<input type='number' step='0.01' id='prezzoProdotto' class='prezzo adminFormField' name='prezzo' placeholder='Prezzo' />";
	        contenuto += "<select id='aliquotaProdotto' class='aliquota adminFormField' name='aliquota'>";
	        contenuto += aliquote;
	        contenuto += "</select>";	     	        	        
	        contenuto += "<button id='confirmAggiungiProdotto' class='adminButtonConfermaAggiungi'>Aggiungi</button>";
	        risultato *= 1;
	
	        				
			JSONObject res = new JSONObject();
			res.put("risultato", risultato);
			res.put("errore", errore);
			res.put("contenuto", contenuto);
			out.println(res);			
		}
	}

}
