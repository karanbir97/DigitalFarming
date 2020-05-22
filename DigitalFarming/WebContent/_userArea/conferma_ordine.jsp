<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="model.ConnessioneDB,java.sql.*, model.SystemInformation, model.CheckSession, model.Prodotto"%>
<!DOCTYPE html>
<html lang = "it">
	<head>
		<% 	
			CheckSession ck = new CheckSession(0, request.getSession());	
			if(ck.getRedirect()){
				String path = request.getContextPath()+ck.getUrlRedirect();
				%>
					<script>
						window.location.href = '<%=path%>';
					</script>
				<%	
			} 
		%>	
		<%@ include file="/partials/head.jsp" %>			
		<script src="<%=request.getContextPath()%>/js/scripts_conferma_ordine.js"></script>
		<title>Conferma Ordine</title>		
	</head>
	<body>
		<%@ include file="/partials/header.jsp" %>		
		<div id="content">
			<div id="content-content">

			<%
				String output = "";				
				String fatturazione = "";
				String spedizione = "";
				String vettore = "";
				String metodoPagamento = "";
				String totali = "";
				String body = "";
		    	if(request.getSession() != null){
		    		Integer idOrdine = (Integer) request.getSession().getAttribute("id_ordine");		    		
		    		if(idOrdine != null){
		    			String sql;
		    			Statement stmt;
		    			Statement stmt1;
		    			ResultSet result;
		    			ResultSet result1;
		    			Float prz;		    			
		    	        ConnessioneDB connDB = new ConnessioneDB();
		    			if(connDB.getConn() != null) {
			    				try {
				    				sql = "";
				    				stmt = null;
				    				result = null;		    				

			    					stmt = connDB.getConn().createStatement();
				    				sql = ""
											+ "SELECT * "
											+ "FROM ordini AS p "
											+ "WHERE attivo = 0 AND id_ordine = "+idOrdine+"; ";
			    					//System.out.println(sql);
			    					result = stmt.executeQuery(sql);				
			    					if(!result.wasNull()) {
			    						while(result.next()) {

						    				sql = "";
						    				stmt1 = null;
						    				result1 = null;	
						    				stmt1 = connDB.getConn().createStatement();
											sql = "SELECT i.nome, i.cognome, i.indirizzo, i.note, (SELECT valore FROM cap WHERE id_cap = i.id_cap) AS cap, (SELECT valore FROM citta WHERE id_citta = i.id_citta) AS citta, (SELECT sigla FROM province WHERE id_provincia = i.id_provincia) AS provincia, i.telefono, i.cellulare "
												+ "FROM indirizzi AS i "
												+ "WHERE i.id_indirizzo = "+result.getInt("id_indirizzo_spedizione")+"; ";
											result1 = stmt1.executeQuery(sql);
					    					if(!result1.wasNull()) {
					    						while(result1.next()){
					    							spedizione = result1.getString("nome")+" "+result1.getString("cognome")+" <br/> "+result1.getString("indirizzo")+" <br/> "+result1.getString("cap")+" "+result1.getString("citta")+" ("+result1.getString("provincia")+")";
					    						}
					    					}	
					    					
						    				sql = "";
						    				stmt1 = null;
						    				result1 = null;	
						    				stmt1 = connDB.getConn().createStatement();
											sql = "SELECT i.nome, i.cognome, i.indirizzo, i.note, (SELECT valore FROM cap WHERE id_cap = i.id_cap) AS cap, (SELECT valore FROM citta WHERE id_citta = i.id_citta) AS citta, (SELECT sigla FROM province WHERE id_provincia = i.id_provincia) AS provincia, i.telefono, i.cellulare "
												+ "FROM indirizzi AS i "
												+ "WHERE i.id_indirizzo = "+result.getInt("id_indirizzo_fatturazione")+"; ";
											result1 = stmt1.executeQuery(sql);
					    					if(!result1.wasNull()) {
					    						while(result1.next()){
					    							fatturazione = result1.getString("nome")+" "+result1.getString("cognome")+" <br/> "+result1.getString("indirizzo")+" <br/> "+result1.getString("cap")+" "+result1.getString("citta")+" ("+result1.getString("provincia")+")";
					    						}
					    					}						    					
					    					
						    				sql = "";
						    				stmt1 = null;
						    				result1 = null;	
						    				stmt1 = connDB.getConn().createStatement();
											sql = "SELECT nome, descrizione, costo "
												+ "FROM ordini_vettori "
												+ "WHERE id_vettore = "+result.getInt("id_vettore")+"; ";
											result1 = stmt1.executeQuery(sql);
					    					if(!result1.wasNull()) {
					    						while(result1.next()){
					    							vettore = result1.getString("nome")+" (&euro;"+new SystemInformation().truncateDecimal(result1.getFloat("costo"), 2)+")<br/>"+result1.getString("descrizione")+"";
					    						}
					    					}						    					

					    					
						    				sql = "";
						    				stmt1 = null;
						    				result1 = null;	
						    				stmt1 = connDB.getConn().createStatement();
											sql = "SELECT nome, descrizione "
												+ "FROM ordini_metodi_pagamento "
												+ "WHERE id_metodo = "+result.getInt("id_metodo")+"; ";
											result1 = stmt1.executeQuery(sql);
					    					if(!result1.wasNull()) {
					    						while(result1.next()){
					    							metodoPagamento = result1.getString("nome")+"<br/>"+result1.getString("descrizione")+"";
					    						}
					    					}						    					
					    					
					    					
					    					totali += "<p><b>Totale Prodotti:</b> &euro;"+new SystemInformation().truncateDecimal(result.getFloat("totale_prodotti"),2)+"</p>";
					    					totali += "<p><b>Totale IVA Prodotti:</b> &euro;"+new SystemInformation().truncateDecimal(result.getFloat("totale_iva_prodotti"), 2)+"</p>";
					    					totali += "<p><b>Totale Spedizione:</b> &euro;"+new SystemInformation().truncateDecimal(result.getFloat("totale_spedizione"), 2)+"</p>";
					    					totali += "<p><b>Totale Ordine:</b> &euro;"+new SystemInformation().truncateDecimal(result.getFloat("totale_ordine"), 2)+"</p>";
					    					
			    						}					
			    					}				 	    						

				    				sql = "";
				    				stmt = null;
				    				result = null;					    				
				    				stmt = connDB.getConn().createStatement();
				    				sql = ""
											+ "SELECT op.*, " 
											+ "(SELECT sigla FROM prodotti_unita WHERE id_unita = op.id_unita) AS unita, "
											+ "(SELECT filename FROM prodotti_immagini WHERE id_prodotto = op.id_prodotto AND is_default = 1 AND attivo = 1) AS filename "											
											+ "FROM ordini_prodotti AS op "
											+ "WHERE op.attivo = 1 AND op.id_ordine = "+idOrdine+"; ";
			    					//System.out.println(sql);
			    					result = stmt.executeQuery(sql);				
			    					if(!result.wasNull()) {
			    						while(result.next()){
			    							String filename;
			    							if(result.getString("filename") != null){
			    								filename = new SystemInformation().getPathImmaginiProdottoHTML()+result.getInt("id_prodotto")+"/"+result.getString("filename");												
			    							}
			    							else{
			    								filename = new SystemInformation().getPathImmaginiProdottoDefault();												
			    							}	    
			    							
			    							body += "<tr>";							
				    							body += "<td>"+result.getInt("id_prodotto")+"</td>";							
				    							body += "<td><img class='showImmagineProdotto' src='"+filename+"' alt='"+filename+"' /></td>";
				    							body += "<td>"+result.getString("nome")+"</td>";							
				    							body += "<td>"+result.getInt("quantita")+" "+result.getString("unita")+"</td>";
				    							body += "<td>";	    					
				    								if(result.getInt("id_sconto") > 0){
				    									body += "<span style='color: #DC483E;'>&euro; "+ new SystemInformation().truncateDecimal(result.getFloat("prezzo_totale"), 2)+"*</span>";	
				    								}
				    								else{
				    									body += "&euro; "+ new SystemInformation().truncateDecimal(result.getFloat("prezzo_totale"), 2);
				    								}													
												body += "</td>";    								    							
											body += "</tr>";			    							
			    						}
			    					}
			    					
			    					connDB.getConn().close();
			    				}
			    				catch(Exception e) {
			    					body += "Errore esecuzione Query."+e.getMessage();
			    				}	    				    							    			 					    	        			    		
		    			}
			    		else {
			    			body = connDB.getError();
			    		}	    	

				    	%>
					    	<div id="confermaOrdinePage">
								<p class='adminTitoloPagina'>Concludi Ordine</p>
								
			        			<table id='confermaOrdineTable'>
			       					<thead class='adminHeadDataTable'>
			      						<tr>
			     							<th>ID</th>
			     							<th>Foto</th>
			     							<th>Nome</th>
											<th>Quantit&agrave;</th>
			        						<th>Prezzo</th>
			        					</tr>	
									</thead>
									<tbody id="bodyCarrello" class='adminBodyDataTable'>
										<%=body %>
									</tbody>
								</table>
								
								<div class="left">
									<p>Indirizzo di Fatturazione</p>
									<p><%=fatturazione %></p>
								</div>
								<div class="right">
									<p>Indirizzo di Spedizione</p>
									<p><%=spedizione %></p>									
								</div>
								
								<div class="left">
									<p><b>Vettore</b></p>
									<p><%=vettore %></p>		
								</div>
								<div class="right">
									<p><b>Metodo di Pagamento</b></p>
									<p><%=metodoPagamento %></p>		
								</div>
								
								<%=totali %>								

								<button id='userButtonTerminaOrdine' data-href="<%=request.getContextPath()%>/_userArea/ordini.jsp" class='userButtonCheckout'>Termina Ordine</button>			
					    	</div>
				    	<%	    					    		
		    		}
		    		else{
		    			output = "Errore Parametri";
		    		}		    			    
		    	}
				else{
					output = "Errore Parametri";
				}	    
			%>
			<%=output %>
			</div>
		</div>
		<%@ include file="/partials/footer.jsp" %>	
	</body>
</html>