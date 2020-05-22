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
			
			Integer idProdotto = Integer.parseInt(request.getParameter("idProdotto"));
		%>
		<%@ include file="/partials/head.jsp" %>		
		<script src="<%=request.getContextPath()%>/js/scripts_prodotti_immagini.js"></script>					
		<title>Prodotti immagini</title>		
	</head>
	<body onLoad="getImmagini()">
		<%@ include file="/partials/header.jsp" %>				
		<div id="content">
			<div id="content-content">
				<p class="adminTitoloPagina">Gestione Immagini Prodotto ID:<%=idProdotto %> <span><a href="prodotti.jsp">Torna ai Prodotti</a></span></p> 			
				<table id="immaginiTable">
					<thead class="adminHeadDataTable">
						<tr>
							<th>FileName</th>
							<th>Primaria</th>
							<th>Elimina</th>
						</tr>	
					</thead>
					<tbody id="bodyImmagini" class="adminBodyDataTable">
						
					</tbody>
				</table>
				
				<div id="aggiungiImmagine" class="adminAggiungi">
					<button id="buttonAggiungiImmagine" class="adminButtonAggiungi"><i class="fas fa-plus"></i></button>
				</div>
				
				<div id="formAggiungiImmagine" class="adminFormAggiungi" style="display: none;">
					
				</div>
				<input type="hidden" id="idProdottoImmagine" value="<%=idProdotto %>" />
			</div>
		</div>
		<%@ include file="/partials/footer.jsp" %>	
	</body>
</html>