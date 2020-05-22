<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="model.ConnessioneDB,java.sql.*, model.SystemInformation, model.CheckSession"%>
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
		<script src="<%=request.getContextPath()%>/js/scripts_carrello.js"></script>
		<title>Carrello</title>		
	</head>
	<body onLoad="getCarrello()">
		<%@ include file="/partials/header.jsp" %>		
		<div id="content">
			<div id="content-content">
				<p class='adminTitoloPagina'>Il tuo carrello</p>

        			<table id='carrelloTable'>
       					<thead class='adminHeadDataTable'>
      						<tr>
     							<th>ID</th>
     							<th>Foto</th>
     							<th>Nome</th>
								<th>Quantit&agrave;</th>
        						<th>Prezzo</th>
        						<th>Elimina</th>
        					</tr>	
						</thead>
						<tbody id="bodyCarrello" class='adminBodyDataTable'>
						
						</tbody>
					</table>
					
					<button style="display: none;" data-href="<%=request.getContextPath()%>/_userArea/checkout.jsp" class='userButtonCheckout'>Vai al Checkout</button>
			</div>
		</div>
		<%@ include file="/partials/footer.jsp" %>	
	</body>
</html>