<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.text.SimpleDateFormat"%>
<!DOCTYPE html>
<html lang = "it">
	<head>
		<%@ include file="/partials/head.jsp" %>	
		<script src="<%=request.getContextPath()%>/js/scripts_contattaci.js"></script>
		<title>Contattaci Page</title>		
	</head>
	<body>
		<%@ include file="/partials/header.jsp" %>				
		<div id="content">
			<div id="content-content">
				<p class="adminTitoloPagina">Contattaci Qui</p>
				<form action="#" method="POST" id="formContattaci">					
				    <fieldset>
				        <legend>Nome</legend>
				        <input type="text" id="nome" name="nome" class="campoForm" />
				    </fieldset>					

				    <fieldset>
				        <legend>Email</legend>
				        <input type="email" id="email" name="email" class="campoForm" />
				    </fieldset>					
					
					<%
						String output = "";
						int idCliente = 0;
						if(request.getSession().getAttribute("id_utente") != null){
							idCliente = (int)request.getSession().getAttribute("id_utente");
						}
					
						if(idCliente > 0){				        	
				        	ConnessioneDB connDB = new ConnessioneDB();
							if(connDB.getConn() != null) {
								try {
									Statement stmt = connDB.getConn().createStatement();
									String sql = "";
									sql = ""
										+ "SELECT id_ordine, data_ordine, totale_ordine "
										+ "FROM ordini "
										+ "WHERE attivo = 1 AND id_utente = "+idCliente+" "
										+ "ORDER BY id_ordine DESC;";										
									ResultSet result = stmt.executeQuery(sql);
									
									if(!result.wasNull()) {										
										int rowCount = result.last() ? result.getRow() : 0;
										if(rowCount > 0) {
											SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
											result.beforeFirst();
											output += "<fieldset><legend>Ordine</legend>";
											output += "<select id='idOrdine' class='campoForm' name='idOrdine'>";
											while(result.next()) {					
												output += "<option value='"+result.getString("id_ordine")+"'>N."+result.getString("id_ordine")+" - "+sdf.format(result.getDate("data_ordine"))+" - &euro;"+result.getString("totale_ordine")+"</option>";
											}
											output += "</select>";
											output += "</fieldset>";
										}
										else {
											output += "<input type='hidden' id='idOrdine' name='idOrdine' value='0' />";
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
							output += "<input type='hidden' id='idOrdine' name='idOrdine' value='0' />";
						}
					%>
					<%= output %>
				    <fieldset>
				        <legend>Scrivi messaggio</legend>
				        <textarea rows="10" class="campoForm" name="messaggio" id="messaggio" ></textarea>
				    </fieldset>	
				    
				    <input type="hidden" id="idCliente" name="idCliente" value="<%=idCliente %>" />				    				
					<input type="submit" id="submitForm" name="submitForm" class="campoForm submitForm" value="Invia Messaggio" />				
				</form>
			</div>
		</div>
		<%@ include file="/partials/footer.jsp" %>	
	</body>
</html>