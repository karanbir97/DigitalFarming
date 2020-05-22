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
		<script src="<%=request.getContextPath()%>/js/scripts_ordini_metodi_pagamento.js"></script>					
		<title>Ordini metodi di pagamento</title>		
	</head>
	<body onLoad="getmetodiPagamento()">
		<%@ include file="/partials/header.jsp" %>				
		<div id="content">
			<div id="content-content">
				<p class="adminTitoloPagina">Gestione metodi di pagamento</p> 
				<table id="metodiPagamentoTable">
					<thead class="adminHeadDataTable">
						<tr>
							<th>Nome Metodo di Pagamento</th>
							<th>Descrizione</th>
							<th>Contanti</th>
							<th>Elimina</th>
						</tr>	
					</thead>
					<tbody id="bodymetodiPagamento" class="adminBodyDataTable">
						
					</tbody>
				</table>
				
				<div id="aggiungimetodoPagamento" class="adminAggiungi">
					<button id="buttonAggiungimetodoPagamento" class="adminButtonAggiungi"><i class="fas fa-plus"></i></button>
				</div>
				
				<div id="formAggiungimetodoPagamento" class="adminFormAggiungi" style="display: none;">
					
				</div>
				
			</div>
		</div>
		<%@ include file="/partials/footer.jsp" %>	
	</body>
</html>