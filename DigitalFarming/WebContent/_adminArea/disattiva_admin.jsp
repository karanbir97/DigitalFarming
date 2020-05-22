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
		<script src="<%=request.getContextPath()%>/js/scripts_impostazioni_disattiva_admin.js"></script>				
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
				
				String utenti = "";
				String sql = "";
				if(idUtente > 0){				        	
		        	ConnessioneDB connDB = new ConnessioneDB();
					if(connDB.getConn() != null) {
						try {														
							sql = "SELECT id_utente, email, nome, cognome "
								+ "FROM utenti "
								+ "WHERE attivo = 1 AND id_tipo = 1 AND id_utente != "+idUtente+";";								
							Statement stmt = connDB.getConn().createStatement();
							ResultSet result = stmt.executeQuery(sql);								
							if(!result.wasNull()) {	
								int rowCount = result.last() ? result.getRow() : 0;
								if(rowCount > 0) {			
									result.beforeFirst();
									while(result.next()) {
										utenti += "<option value='"+result.getInt("id_utente")+"'>"+result.getString("email")+" - "+result.getString("nome")+" "+result.getString("cognome")+"</option>";
									}
								}
								else{
									utenti += "<option value='0'>Nessun ulteriore Admin Presente</option>";
								}								
							}																
							connDB.getConn().close();
						}
						catch(Exception e) {
							utenti = e.getMessage();
						}	
					}
					else {
						utenti = connDB.getError();
					}				        				        				        
				}
				else{
					utenti = "Impossibile recuperare gli utenti. Errore Parametri";							
				}
										
				%>
			
				<p>Ciao <%=request.getSession().getAttribute("nome") %> <%=request.getSession().getAttribute("cognome") %>, selezionare un admin e premere su "Disattiva" per disattivarlo.</p>
					<form action='#' method='POST' id='formImpostazioniAdmin'>											
						<fieldset>
							<legend>Utente</legend>
							<select id='utenteDisattiva' name='utenteDisattiva' class='campoForm'>
								<%=utenti %>
							</select>
						</fieldset>
						<input type='hidden' id='idUtente' value='<%=idUtente %>' />
						<input type='submit' id='submitForm' name='submitForm' class='submitForm' value='Disattiva Utente' />
					</form>					
			</div>
		</div>
		<%@ include file="/partials/footer.jsp" %>	
	</body>
</html>