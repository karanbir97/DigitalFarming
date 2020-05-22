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
		<script src="<%=request.getContextPath()%>/js/scripts_prodotti_aliquote.js"></script>					
		<title>Prodotti aliquote</title>		
	</head>
	<body onLoad="getAliquote()">
		<%@ include file="/partials/header.jsp" %>				
		<div id="content">
			<div id="content-content">
				<p class="adminTitoloPagina">Gestione Aliquote</p> 
				<table id="aliquoteTable">
					<thead class="adminHeadDataTable">
						<tr>
							<th>Nome Aliquota</th>
							<th>Valore (%)</th>
							<th>Elimina</th>
						</tr>	
					</thead>
					<tbody id="bodyAliquote" class="adminBodyDataTable">
						
					</tbody>
				</table>
				
				<div id="aggiungiAliquota" class="adminAggiungi">
					<button id="buttonAggiungiAliquota" class="adminButtonAggiungi"><i class="fas fa-plus"></i></button>
				</div>
				
				<div id="formAggiungiAliquota" class="adminFormAggiungi" style="display: none;">
					
				</div>
				
			</div>
		</div>
		<%@ include file="/partials/footer.jsp" %>	
	</body>
</html>