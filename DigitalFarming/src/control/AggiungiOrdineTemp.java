package control;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;

import model.Carrello;
import model.ConnessioneDB;
import model.Prodotto;
import model.SystemInformation;


/**
 * Servlet implementation class AggiungiOrdineTemp
 */
@WebServlet("/AggiungiOrdineTemp")
public class AggiungiOrdineTemp extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AggiungiOrdineTemp() {
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

		Integer fatturazioneCheckout = Integer.parseInt(request.getParameter("fatturazioneCheckout"));
		Integer spedizioneCheckout = Integer.parseInt(request.getParameter("spedizioneCheckout"));
		Integer vettoreCheckout = Integer.parseInt(request.getParameter("vettoreCheckout"));
		Integer metodoPagamentoCheckout = Integer.parseInt(request.getParameter("metodoPagamentoCheckout"));

        Integer risultato = 0;
        String errore = "";
        String contenuto = "";
		
    	if(request.getSession() != null){
    		Integer idUtente = (Integer) request.getSession().getAttribute("id_utente");    		
    		Carrello cart = (Carrello) request.getSession().getAttribute("carrello");
    		if(idUtente != null && cart != null){
    			if(cart.getNumeroProdotti() > 0) {
    				
			        ConnessioneDB connDB = new ConnessioneDB();
					if(connDB.getConn() != null) {
						try {				
							Statement  stmt0;
							PreparedStatement  stmt1;
							ResultSet result;
							String sql;
							Integer contrassegno = null;	
							Float costo_vettore = null;
							Integer in_contanti = null;		
							Integer primo_stato = null;
							Float importo_minimo_ordine_sped_grat = null;

							stmt0 = connDB.getConn().createStatement();
		    				sql = ""
									+ "SELECT contrassegno, costo "
									+ "FROM ordini_vettori "
									+ "WHERE id_vettore = "+vettoreCheckout+"; ";
	    					result = stmt0.executeQuery(sql);				
	    					if(!result.wasNull()) {
	    						while(result.next()) {							
	    							contrassegno = result.getInt("contrassegno");
	    							costo_vettore = result.getFloat("costo");	    							
	    						}
	    					}
	    					
							stmt0 = connDB.getConn().createStatement();
		    				sql = ""
									+ "SELECT in_contanti "
									+ "FROM ordini_metodi_pagamento "
									+ "WHERE id_metodo = "+metodoPagamentoCheckout+"; ";
	    					result = stmt0.executeQuery(sql);				
	    					if(!result.wasNull()) {
	    						while(result.next()) {							
	    							in_contanti = result.getInt("in_contanti");
	    						}
	    					}

							stmt0 = connDB.getConn().createStatement();
		    				sql = ""
									+ "SELECT valore AS importo_minimo_ordine_sped_grat "
									+ "FROM impostazioni "
									+ "WHERE slug = 'importo_minimo_ordine_sped_grat' AND attivo = 1";
	    					result = stmt0.executeQuery(sql);				
	    					if(!result.wasNull()) {
	    						while(result.next()) {							
	    							importo_minimo_ordine_sped_grat = result.getFloat("importo_minimo_ordine_sped_grat");
	    						}
	    					}

	    					stmt0 = connDB.getConn().createStatement();
		    				sql = ""
									+ "SELECT id_stato "
									+ "FROM ordini_stati "
									+ "WHERE primo_stato = 1; ";
	    					result = stmt0.executeQuery(sql);				
	    					if(!result.wasNull()) {
	    						while(result.next()) {							
	    							primo_stato = result.getInt("id_stato");
	    						}
	    					}
	    					
	    					if(contrassegno != null && in_contanti != null && primo_stato > 0) {	    				
		    					if(in_contanti == 1 && contrassegno == 0){ //Se ho scelto un metodo di pagamento in contanti e un vettore che NON supporta il contrassegno
									errore = "Verifica che il vettore selezionato supporti il contrassegno.";
									risultato = 0;														
		    					}
		    					else {		    						
									sql = "INSERT INTO ordini (id_utente, id_vettore, id_metodo, id_indirizzo_spedizione, id_indirizzo_fatturazione, data_ordine, attivo, id_stato, totale_spedizione) VALUES (?, ?, ?, ?, ?, NOW(), ?, ?, ?) ;";
									PreparedStatement  stmt = connDB.getConn().prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
									stmt.setInt(1, idUtente);
									stmt.setInt(2, vettoreCheckout);
									stmt.setInt(3, metodoPagamentoCheckout);							
									stmt.setInt(4, spedizioneCheckout);
									stmt.setInt(5, fatturazioneCheckout);
									stmt.setInt(6, 0);							
									stmt.setInt(7, primo_stato);							
									stmt.setFloat(8, costo_vettore);							
									if(stmt.executeUpdate() == 1) {								
										Integer idOrdine = 0;								
										ResultSet rs = stmt.getGeneratedKeys();
										if (rs.next()){
											idOrdine = rs.getInt(1);
										}								
										
										if(idOrdine > 0) {									
											Integer continua = 1;
											Float prezzo;
											Float iva;
							    			for(Prodotto prodotto: cart.getProdotti()) { //Per ogni prodotto del carrello
							    				stmt0 = null;
							    				result = null;					    				
						    					stmt0 = connDB.getConn().createStatement();
							    				sql = ""
														+ "SELECT p.nome, p.prezzo_base, "
														+ "(SELECT valore FROM prodotti_aliquote WHERE id_aliquota = p.id_aliquota) AS aliquota, "
														+ "p.id_aliquota AS id_aliquota, "
														+ "p.id_unita AS id_unita, "
														+ "p.id_categoria AS id_categoria, "
														+ "(SELECT id_sconto FROM prodotti_sconti WHERE id_prodotto = p.id_prodotto AND attivo = 1 AND DATE(NOW()) >= data_da AND data_a >= DATE(NOW()) ORDER BY data_inserimento DESC LIMIT 1) AS id_sconto, "
														+ "(SELECT prezzo FROM prodotti_sconti WHERE id_prodotto = p.id_prodotto AND attivo = 1 AND DATE(NOW()) >= data_da AND data_a >= DATE(NOW()) ORDER BY data_inserimento DESC LIMIT 1) AS prezzo_scontato "
														+ "FROM prodotti  AS p "
														+ "WHERE p.attivo = 1 AND p.id_prodotto = "+prodotto.getIdProdotto()+"; ";
						    					//System.out.println(sql);
						    					result = stmt0.executeQuery(sql);				
						    					if(!result.wasNull()) {
						    						while(result.next()) {
						    							stmt1 = null;
						    							sql = "INSERT INTO ordini_prodotti (id_ordine, id_prodotto, nome, quantita, prezzo_unitario, prezzo_prodotti, prezzo_iva, prezzo_totale, id_aliquota_iva, id_categoria, id_unita, id_sconto, attivo) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?);";
									    				stmt1 = connDB.getConn().prepareStatement(sql);
									    				stmt1.setInt(1, idOrdine);												
									    				stmt1.setInt(2, prodotto.getIdProdotto());
									    				stmt1.setString(3, result.getString("nome"));
									    				stmt1.setInt(4, prodotto.getQuantita());												
														if(result.getString("prezzo_scontato") != null){
															prezzo = result.getFloat("prezzo_scontato");													
														}
														else{
															prezzo = result.getFloat("prezzo_base");
														}	
														stmt1.setFloat(5, prezzo);
														stmt1.setFloat(6, prezzo*prodotto.getQuantita());
														iva = ((prezzo*prodotto.getQuantita()) * result.getFloat("aliquota"))/100;
														stmt1.setFloat(7, iva);
														stmt1.setFloat(8, (prezzo*prodotto.getQuantita())+iva);
														stmt1.setInt(9, result.getInt("id_aliquota"));
														stmt1.setInt(10, result.getInt("id_categoria"));
														stmt1.setInt(11, result.getInt("id_unita"));
														if(result.getInt("id_sconto") == 0)
															stmt1.setNull(12, 1);
														else 
															stmt1.setInt(12, result.getInt("id_unita"));																								
														stmt1.setInt(13, 1);
														if(stmt1.executeUpdate() != 1) {
															errore += "Errore Inserimento Prodotto "+prodotto.getIdProdotto();
															continua *= 0;
														}
						    						}
						    					}
						    					else {
													errore += "Errore Inserimento Prodotto "+prodotto.getIdProdotto();
													continua *= 0;
						    					}
							    			}
											
							    			if(continua == 1) {
							    				stmt1 = null;
				    							sql = "UPDATE ordini SET "
				    								 +"totale_prodotti =  (SELECT SUM(prezzo_prodotti) FROM ordini_prodotti WHERE id_ordine = ?), "
				    								 +"totale_iva_prodotti =  (SELECT SUM(prezzo_iva) FROM ordini_prodotti WHERE id_ordine = ?), "
				    								 +"totale_ordine =  ((SELECT SUM(prezzo_prodotti) FROM ordini_prodotti WHERE id_ordine = ?) + (SELECT SUM(prezzo_iva) FROM ordini_prodotti WHERE id_ordine = ?) + totale_spedizione) "
				    								 +"WHERE id_ordine = ?;";
				    							//System.out.println(sql);
							    				stmt1 = connDB.getConn().prepareStatement(sql);
							    				stmt1.setInt(1, idOrdine);												
							    				stmt1.setInt(2, idOrdine);												
							    				stmt1.setInt(3, idOrdine);												
							    				stmt1.setInt(4, idOrdine);												
							    				stmt1.setInt(5, idOrdine);												
												if(stmt1.executeUpdate() == 1) {
								    				stmt0 = null;
								    				result = null;			
								    				Float limite_contanti = (float) 0;
								    				Float totale_prodotti = (float) 1;	
								    				Float totale_iva_prodotti = (float) 0;								    				
								    				stmt0 = connDB.getConn().createStatement();
								    				sql = ""
															+ "SELECT totale_prodotti, totale_iva_prodotti, (SELECT valore FROM impostazioni WHERE attivo = 1 AND TRIM(slug) = TRIM('limite_contanti')) AS limite_contanti "
															+ "FROM ordini "
															+ "WHERE id_ordine = "+idOrdine+"; ";
							    					result = stmt0.executeQuery(sql);				
							    					if(!result.wasNull()) {
							    						while(result.next()) {
							    							totale_prodotti = result.getFloat("totale_prodotti");
							    							totale_iva_prodotti = result.getFloat("totale_iva_prodotti");
							    							limite_contanti = result.getFloat("limite_contanti");
							    						}													
							    					}
							    					
							    					continua = 1;
							    					if((totale_prodotti+totale_iva_prodotti) > importo_minimo_ordine_sped_grat) {
							    						stmt1 = null;
							    						sql = "UPDATE ordini SET "
						    								 +"totale_spedizione =  0, "
						    								 +"totale_ordine =  (totale_prodotti + totale_iva_prodotti) "
						    								 +"WHERE id_ordine = ?;";
						    							//System.out.println(sql);
									    				stmt1 = connDB.getConn().prepareStatement(sql);
									    				stmt1.setInt(1, idOrdine);												
									    				if(stmt1.executeUpdate() != 1) {
									    					risultato = 0;
									    					errore = "Impossibile rendere gratuita la spedizione.";
									    					continua = 0;
									    				}
							    					}
							    					
							    					if(continua == 1) {
							    						if(in_contanti == 1 && totale_prodotti >= limite_contanti) {
															errore = "Non &egrave; possibile pagare in contanti un ordine con totale maggiore di "+new SystemInformation().truncateDecimal(limite_contanti, 2)+".";
															risultato = 0;																																	    							
							    						}
							    						else {
															request.getSession().setAttribute("id_ordine", idOrdine);
															risultato = 1;					
															contenuto = "Ordine Inserito con Successo";						    							
							    						}							    						
							    					}
												}
												else {
													errore = "Errore Aggiornamento Prezzo Ordine.";
													risultato = 0;																											
												}							    				
							    			}
							    			else {
												risultato = 0;									    			
							    			}
											
										}
										else {
											errore = "Errore Generazione Nuovo Ordine Temporaneo.";
											risultato = 0;														
										}								
									}
									else {
										errore = "Errore Inserimento del Stato.";
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
	    					}
	    					else {
								errore = "Errore Verifica Metodo di Pagamento.";
								risultato = 0;														
	    					}	    																		
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
    				
    				
    			}
    			else {
    				errore = "Nessun prodotto trovato.";
    				risultato = 0;		    		    				
    			}
    		}
        	else {
    			errore = "Carrello Non Trovato.";
    			risultato = 0;		    		
        	}
    	}
    	else {
			errore = "Carrello Non Trovato.";
			risultato = 0;		    		
    	}

        				
		JSONObject res = new JSONObject();
		res.put("risultato", risultato);
		res.put("errore", errore);
		res.put("contenuto", contenuto);
		out.println(res);
	}


}
