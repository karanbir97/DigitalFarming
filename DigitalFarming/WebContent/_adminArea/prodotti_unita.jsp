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
		<script src="<%=request.getContextPath()%>/js/scripts_prodotti_unita.js"></script>					
		<title>Prodotti unita</title>		
	</head>
	<body onLoad="getUnita()">
		<%@ include file="/partials/header.jsp" %>				
		<div id="content">
			<div id="content-content">
				<p class="adminTitoloPagina">Gestione Unit&agrave;</p> 
				<table id="unitaTable">
					<thead class="adminHeadDataTable">
						<tr>
							<th>Nome Unit&agrave;</th>
							<th>Sigla</th>
							<th>Elimina</th>
						</tr>	
					</thead>
					<tbody id="bodyUnita" class="adminBodyDataTable">
						
					</tbody>
				</table>
				
				<div id="aggiungiUnita" class="adminAggiungi">
					<button id="buttonAggiungiUnita" class="adminButtonAggiungi"><i class="fas fa-plus"></i></button>
				</div>
				
				<div id="formAggiungiUnita" class="adminFormAggiungi" style="display: none;">
					
				</div>
				
			</div>
		</div>
		<%@ include file="/partials/footer.jsp" %>	
	</body>
</html>