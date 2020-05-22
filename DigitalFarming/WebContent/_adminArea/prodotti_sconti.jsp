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
		<script src="<%=request.getContextPath()%>/js/scripts_prodotti_sconti.js"></script>					
		<title>Prodotti sconti</title>		
	</head>
	<body onLoad="getSconti()">
		<%@ include file="/partials/header.jsp" %>				
		<div id="content">
			<div id="content-content">
				<p class="adminTitoloPagina">Gestione Sconti</p> 
				<table id="scontiTable">
					<thead class="adminHeadDataTable">
						<tr>
							<th>Prodotto</th>
							<th>Prezzo Base</th>
							<th>Prezzo Scontato</th>
							<th>Dal</th>
							<th>Al</th>
							<th>Elimina</th>
						</tr>	
					</thead>
					<tbody id="bodySconti" class="adminBodyDataTable">
						
					</tbody>
				</table>
				
				<div id="aggiungiSconto" class="adminAggiungi">
					<button id="buttonAggiungiSconto" class="adminButtonAggiungi"><i class="fas fa-plus"></i></button>
				</div>
				
				<div id="formAggiungiSconto" class="adminFormAggiungi" style="display: none;">
					
				</div>
				
			</div>
		</div>
		<%@ include file="/partials/footer.jsp" %>	
	</body>
</html>