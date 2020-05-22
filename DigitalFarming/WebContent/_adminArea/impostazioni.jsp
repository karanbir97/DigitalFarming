<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="model.CheckSession, javax.servlet.http.HttpSession" %>
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
		<script src="<%=request.getContextPath()%>/js/scripts_impostazioni_admin.js"></script>
		<title>impostazioni</title>		
	</head>
	<body>
		<%@ include file="/partials/header.jsp" %>				
		<div id="content">
			<div id="content-content">
				<p>Ciao <%=request.getSession().getAttribute("nome") %> <%=request.getSession().getAttribute("cognome") %>, qui puoi cambiare alcune impostazioni del sito.</p>
				
				        <%
				        	String output = "";
				        	ConnessioneDB connDB = new ConnessioneDB();
							if(connDB.getConn() != null) {
								try {
									Statement stmt = connDB.getConn().createStatement();
									String sql = "";
									sql = ""
										+ "SELECT id_impostazione, nome, valore, tipo, step "
										+ "FROM impostazioni "
										+ "WHERE attivo = 1 "
										+ "ORDER BY id_impostazione ASC;";										
									ResultSet result = stmt.executeQuery(sql);
									
									if(!result.wasNull()) {
										int rowCount = result.last() ? result.getRow() : 0;
										if(rowCount > 0) {
											result.beforeFirst();
											output += "<form action='#' method='POST' id='formImpostazioniAdmin'>";											
											while(result.next()) {											
												output += "<fieldset>";
													output += "<legend>"+result.getString("nome")+"</legend>";												
													output += "<input type='";
													output += result.getString("tipo");
													output += "' class='campoForm' name='";
													output += result.getString("nome");
													output += "' value='";
													output += result.getString("valore");
													output += "' step='";
													output += result.getString("step");
													output += "' data-id='";
													output += result.getString("id_impostazione");
													output += "' />";												
													output += "</fieldset>";
											}
											output += "<input type='submit' id='submitForm' name='submitForm' class='submitForm' value='Salva' />";
											output += "</form>";											
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
				        %>
				        <%= output %>				
			</div>
		</div>
		<%@ include file="/partials/footer.jsp" %>	
	</body>
</html>