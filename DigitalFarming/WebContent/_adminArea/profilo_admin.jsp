<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="model.CheckSession, javax.servlet.http.HttpSession, model.ConnessioneDB, java.sql.*" %>
<!DOCTYPE html>
<html lang = "it">
	<head>
		<% 	
			CheckSession ck = new CheckSession(1, request.getSession());	
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
		<script src="<%=request.getContextPath()%>/js/scripts_impostazioni_profilo_admin.js"></script>				
		<title>Il mio profilo</title>		
	</head>
	<body>
		<%@ include file="/partials/header.jsp" %>				
		<div id="content">
			<div id="content-content">
				<%
				int idUtente = 0;
				if(request.getSession().getAttribute("id_utente") != null){
					idUtente = (int)request.getSession().getAttribute("id_utente");
				}
				
				String output = "";
				String email = "";
				String nome = "";
				String cognome = "";
				String codice_fiscale = "";
				String sessoM = "";						
				String sessoF = "";
				String data_nascita = "";						
				if(idUtente > 0){				        	
		        	ConnessioneDB connDB = new ConnessioneDB();
					if(connDB.getConn() != null) {
						try {
							String sql = "";
							
							sql = "SELECT email, nome, cognome, codice_fiscale, sesso, data_nascita "
								+ "FROM utenti "
								+ "WHERE attivo = 1 AND id_utente = "+idUtente+";";
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
			
				<p>Ciao <%=request.getSession().getAttribute("nome") %> <%=request.getSession().getAttribute("cognome") %>, qui puoi cambiare le tue credenziali. <br/> <button data-href="<%=request.getContextPath()%>/registrati.jsp" class='userButtonRegistraAdmin'>Registra un nuovo Admin</button> <br/> <button data-href="<%=request.getContextPath()%>/_adminArea/disattiva_admin.jsp" class='userButtonDisattivaAdmin'>Disattiva Un Admin</button></p>
					<form action='#' method='POST' id='formImpostazioniAdmin'>											
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
						<input type='hidden' id='idUtente' value='<%=idUtente %>' />
						<input type='submit' id='submitForm' name='submitForm' class='submitForm' value='Salva' />
					</form>
					<%=output %>							
			</div>
		</div>
		<%@ include file="/partials/footer.jsp" %>	
	</body>
</html>