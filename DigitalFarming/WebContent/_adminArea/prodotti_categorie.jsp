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
		<script src="<%=request.getContextPath()%>/js/scripts_prodotti_categorie.js"></script>					
		<title>Prodotti categorie</title>		
	</head>
	<body onLoad="getCategorie()">
		<%@ include file="/partials/header.jsp" %>				
		<div id="content">
			<div id="content-content">
				<p class="adminTitoloPagina">Gestione Categorie</p> 
				<table id="categorieTable">
					<thead class="adminHeadDataTable">
						<tr>
							<th>Nome Categoria</th>
							<th>Elimina</th>
						</tr>	
					</thead>
					<tbody id="bodyCategorie" class="adminBodyDataTable">
						
					</tbody>
				</table>
				
				<div id="aggiungiCategoria" class="adminAggiungi">
					<button id="buttonAggiungiCategoria" class="adminButtonAggiungi"><i class="fas fa-plus"></i></button>
				</div>
				
				<div id="formAggiungiCategoria" class="adminFormAggiungi" style="display: none;">
					
				</div>
				
			</div>
		</div>
		<%@ include file="/partials/footer.jsp" %>	
	</body>
</html>