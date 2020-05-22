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
		<script src="<%=request.getContextPath()%>/js/scripts_contatti.js"></script>					
		<title>Contatti Admin</title>		
	</head>
	<body onLoad="getContatti()">
		<%@ include file="/partials/header.jsp" %>				
		<div id="content">
			<div id="content-content">
				<p class="adminTitoloPagina">Gestione Contatti</p> 
				<table id="contattiTable">
					<thead class="adminHeadDataTable">
						<tr>
							<th>Data</th>
							<th>Cliente</th>
							<th>Ordine N.</th>
							<th>Azioni</th>
						</tr>	
					</thead>
					<tbody id="bodyContatti" class="adminBodyDataTable">
						
					</tbody>
				</table>							
			</div>
		</div>
		<%@ include file="/partials/footer.jsp" %>	
	</body>
</html>