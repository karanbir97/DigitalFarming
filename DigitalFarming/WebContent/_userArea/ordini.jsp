<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="model.CheckSession, javax.servlet.http.HttpSession" %>
<!DOCTYPE html>
<html lang = "it">
	<head>
		<% 
			CheckSession ck = new CheckSession(0, request.getSession());
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
		<script src="<%=request.getContextPath()%>/js/scripts_ordini_user.js"></script>					
		<title>Ordini stati</title>		
	</head>
	<body onLoad="getOrdini()">
		<%@ include file="/partials/header.jsp" %>				
		<div id="content">
			<div id="content-content">
				<p class="adminTitoloPagina">I Miei Ordini</p> 
				<table id="ordiniTable">
					<thead class="userHeadDataTable">
						<tr>
							<th>ID</th>
							<th>Data</th>
							<th>N. Prodotti</th>
							<th>Totale</th>
							<th>Stato</th>
							<th>Elimina</th>
						</tr>	
					</thead>
					<tbody id="bodyOrdini" class="userBodyDataTable">
						
					</tbody>
				</table>
			</div>
		</div>
		<%@ include file="/partials/footer.jsp" %>	
	</body>
</html>