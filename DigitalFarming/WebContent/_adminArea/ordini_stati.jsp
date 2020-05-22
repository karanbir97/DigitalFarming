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
		<script src="<%=request.getContextPath()%>/js/scripts_ordini_stati.js"></script>					
		<title>Ordini stati</title>		
	</head>
	<body onLoad="getstati()">
		<%@ include file="/partials/header.jsp" %>				
		<div id="content">
			<div id="content-content">
				<p class="adminTitoloPagina">Gestione Stati</p> 
				<table id="statiTable">
					<thead class="adminHeadDataTable">
						<tr>
							<th>Nome Stato</th>
							<th>Tipo Ordine</th>
							<th>Primo Stato</th>
							<th>Elimina</th>
						</tr>	
					</thead>
					<tbody id="bodyStati" class="adminBodyDataTable">
						
					</tbody>
				</table>
				
				<div id="aggiungiStato" class="adminAggiungi">
					<button id="buttonAggiungistato" class="adminButtonAggiungi"><i class="fas fa-plus"></i></button>
				</div>
				
				<div id="formAggiungiStato" class="adminFormAggiungi" style="display: none;">
					
				</div>
				
			</div>
		</div>
		<%@ include file="/partials/footer.jsp" %>	
	</body>
</html>