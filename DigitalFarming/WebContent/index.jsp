<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="model.ConnessioneDB, java.sql.*"%>
<!DOCTYPE html>
<html lang = "it">
	<head>
		<%@ include file="/partials/head.jsp" %>	
		<script src="<%=request.getContextPath()%>/js/scripts_accedi.js"></script>	
			
		<title>Accedi</title>		
	</head>
	<body>
		<%@ include file="/partials/header.jsp" %>				
		<div id="content">
			<div id="content-content">
				<p style="text-align: center;">Inserisci le tue credenziali per accedere al pannello di amministrazione: <br/> <button data-href="<%=request.getContextPath()%>/registrati.jsp" class='userButtonRegistrati'>Registrati</button> </p>
				
				
				
				
				<form action="#" method="POST" id="formAccedi">					
				    <fieldset>
				        <legend>Username</legend>
				        <input type="text" id="nomeUtente" name="nomeUtente" class="campoForm" />
				    </fieldset>					

				    <fieldset>
				        <legend>Password</legend>
				        <input type="password" id="passwordUtente" name="passwordUtente" class="campoForm" />
				    </fieldset>					
				    
					<input type="submit" id="submitForm" name="submitForm" class="campoForm submitForm" value="Accedi" />				
				</form>
			</div>
		</div>
		<%@ include file="/partials/footer.jsp" %>	
	</body>
</html>