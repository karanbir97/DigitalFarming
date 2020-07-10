<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="model.CheckSession, javax.servlet.http.HttpSession, model.ConnessioneDB, java.sql.*" %>

<!DOCTYPE html>
<html lang = "it">
	<head>
		
		<%@ include file="/partials/head.jsp" %>
		<script src="<%=request.getContextPath()%>/js/scripts_impostazioni_profilo_user.js"></script>				
		<title>Il mio profilo</title>		
	</head>
	<body>
		<%@ include file="/partials/header.jsp" %>				
		<div id="content">
			<div id="content-content">

					<%	
						int idCliente = 0;
						if(request.getSession().getAttribute("id_utente") != null){
							idCliente = (int)request.getSession().getAttribute("id_utente");
						}
						
						String output = "";
						String email = "";
						String nome = "";
						String cognome = "";
						String codice_fiscale = "";
						String sessoM = "";						
						String sessoF = "";
						String data_nascita = "";						
						if(idCliente > 0){				        	
				        	ConnessioneDB connDB = new ConnessioneDB();
							if(connDB.getConn() != null) {
								try {
									String sql = "";
									
									sql = "SELECT email, nome, cognome, codice_fiscale, sesso, data_nascita "
										+ "FROM utenti "
										+ "WHERE attivo = 1 AND id_utente = "+idCliente+";";
									Statement stmt0 = connDB.getConn().createStatement();
									ResultSet result0 = stmt0.executeQuery(sql);								
									if(!result0.wasNull()) {	
										while(result0.next()) {
											email = result0.getString("email");
											nome = result0.getString("nome");
											cognome = result0.getString("cognome");
											codice_fiscale = result0.getString("codice_fiscale");
											if(result0.getString("sesso").equals("M")){
												sessoM = "checked";
											}
											else{
												sessoF = "checked";
											}
											data_nascita = result0.getString("data_nascita");
										}
									}									
									
									Statement stmt = connDB.getConn().createStatement();
									sql = ""
										+ "SELECT i.nome, i.cognome, i.id_indirizzo, i.indirizzo, i.note, (SELECT valore FROM cap WHERE id_cap = i.id_cap) AS cap, (SELECT valore FROM citta WHERE id_citta = i.id_citta) AS citta, (SELECT sigla FROM province WHERE id_provincia = i.id_provincia) AS provincia, i.telefono, i.cellulare "
										+ "FROM indirizzi AS i "
										+ "WHERE i.attivo = 1 AND i.id_utente = "+idCliente+" "
										+ "ORDER BY i.id_indirizzo DESC;";										
									ResultSet result = stmt.executeQuery(sql);								
									if(!result.wasNull()) {										
										int rowCount = result.last() ? result.getRow() : 0;
										if(rowCount > 0) {											
											result.beforeFirst();
											
											while(result.next()) {					
												output += "<form action='#' method='POST' class='formIndirizzo'>";
													output += "<i class='fas fa-times eliminaIndirizzo' data-idindirizzo='"+result.getString("id_indirizzo")+"'></i>";
													output += "<p class='nomeCognome'>";
													output += result.getString("nome");
													output += " ";
													output += result.getString("cognome");
													output += "</p>";
													output += "<p class='indirizzo'>";
													output += result.getString("indirizzo");
													output += "</p>";
													output += "<p class='capCittaProvincia'>";
													output += result.getString("cap")+" - "+result.getString("citta")+" ("+result.getString("provincia")+")";
													output += "</p>";
													output += "<p class='telefono'><strong>Tel</strong>: ";											
													output += result.getString("telefono")+"";
													output += "</p>";												
													output += "<p class='cellulare'><strong>Cell:</strong> ";											
													output += result.getString("cellulare")+"";
													output += "</p>";												
													output += "<p class='note'>";											
													output += result.getString("note")+"";
													output += "</p>";
												output += "</form>";
											}											
										}
									}									
									connDB.getConn().close();
								}
								catch(Exception e) {
									output = e.getMessage();
								}	
							}
							else {
								output = connDB.getError();
							}				        				        				        
						}
						else{
							output = "Impossibile recuperare i dettagli dell'utenza. Errore Parametri";							
						}
					%>			


				<p>Ciao <%=request.getSession().getAttribute("nome") %> <%=request.getSession().getAttribute("cognome") %>, qui puoi cambiare le tue credenziali e gestire i tuoi indirizzi.</p>
					<form action='#' method='POST' id='formImpostazioniUser'>											
						<fieldset>
							<legend>Email</legend>
							<input type='text' class='campoForm' value='<%=email %>' readonly />
						</fieldset>
						<fieldset>
							<legend>Nome</legend>
							<input type='text' id='nomeUtente' name='nomeUtente' class='campoForm' value='<%=nome %>' />
						</fieldset>
						<fieldset>
							<legend>Cognome</legend>
							<input type='text' id='cognomeUtente' name='cognomeUtente' class='campoForm' value='<%=cognome %>' />
						</fieldset>
						<fieldset>
							<legend>Codice Fiscale</legend>
							<input type='text' class='campoForm' value='<%=codice_fiscale %>' readonly />
						</fieldset>
					    <fieldset>
					        <legend>Sesso</legend>
					        <input type='radio' class='sessoUtente' name='sessoUtente' value='M' <%=sessoM %> />M
					        <input type='radio' class='sessoUtente' name='sessoUtente' value='F' <%=sessoF %> />F
					    </fieldset>					
						<fieldset>
							<legend>Data Nascita</legend>
							<input type='date' id='dataNascitaUtente' name='dataNascitaUtente' class='campoForm' value='<%=data_nascita %>' />
						</fieldset>


						<fieldset>
							<legend>Password</legend>
							<input type='password' id='passwordUtente' name='passwordUtente' class='campoForm' value='' />
						</fieldset>

						<fieldset>
							<legend>Ripeti Password</legend>
							<input type='password' id='ripetiPasswordUtente' name='ripetiPasswordUtente' class='campoForm' value='' />
						</fieldset>
						<input type='hidden' id='idUtente' value='<%=idCliente %>' />
						<input type='submit' id='submitForm' name='submitForm' class='submitForm' value='Salva' />
					</form>	

					<div id="formAggiungiIndirizzo" class="userFormAggiungi" style="display: none;">
						
					</div>
					
					<form action="#" method="POST" class="formIndirizzo addIndirizzo">
						<i id="buttonAggiungiIndirizzo" class="fas fa-plus aggiungiIndirizzo" data-idindirizzo="5"></i>
					</form>										
					<%= output %>																						        				      
			</div>
		</div>
		<%@ include file="/partials/footer.jsp" %>	
	</body>
</html>