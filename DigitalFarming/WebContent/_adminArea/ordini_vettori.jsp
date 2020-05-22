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
		<script src="<%=request.getContextPath()%>/js/scripts_ordini_vettori.js"></script>					
		<title>Ordini vettori</title>		
	</head>
	<body onLoad="getvettori()">
		<%@ include file="/partials/header.jsp" %>				
		<div id="content">
			<div id="content-content">
				<p class="adminTitoloPagina">Gestione Vettori</p> 
				<table id="vettoriTable">
					<thead class="adminHeadDataTable">
						<tr>
							<th>Nome Vettore</th>
							<th>Descrizione</th>
							<th>Costo</th>
							<th>Contrassegno</th>
							<th>Elimina</th>
						</tr>	
					</thead>
					<tbody id="bodyVettori" class="adminBodyDataTable">
						
					</tbody>
				</table>
				
				<div id="aggiungiVettore" class="adminAggiungi">
					<button id="buttonAggiungivettore" class="adminButtonAggiungi"><i class="fas fa-plus"></i></button>
				</div>
				
				<div id="formAggiungiVettore" class="adminFormAggiungi" style="display: none;">
					
				</div>
				
			</div>
		</div>
		<%@ include file="/partials/footer.jsp" %>	
	</body>
</html>