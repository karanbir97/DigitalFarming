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
		<script src="<%=request.getContextPath()%>/js/scripts_prodotti.js"></script>					
		<title>Prodotti</title>		
	</head>
	<body onLoad="getProdotti()">
		<%@ include file="/partials/header.jsp" %>				
		<div id="content">
			<div id="content-content">
				<p class="adminTitoloPagina">Gestione Prodotti</p> 
				<table id="prodottiTable">
					<thead class="adminHeadDataTable">
						<tr>
							<th>ID</th>
							<th>Categoria</th>
							<th>Nome</th>
							<th>Descrizione</th>
							<th>Descrizione Abbreviata</th>
							<th>Qt&agrave; Disp.</th>
							<th>Unit&agrave;</th>
							<th>Prezzo</th>
							<th>Aliquota</th>							
							<th>Azioni</th>
						</tr>	
					</thead>
					<tbody id="bodyProdotti" class="adminBodyDataTable">
						
					</tbody>
				</table>
				
				<div id="aggiungiProdotto" class="adminAggiungi">
					<button id="buttonAggiungiProdotto" class="adminButtonAggiungi"><i class="fas fa-plus"></i></button>
				</div>
				
				<div id="formAggiungiProdotto" class="adminFormAggiungi" style="display: none;">
					
				</div>
				
			</div>
		</div>
		<%@ include file="/partials/footer.jsp" %>	
	</body>
</html>