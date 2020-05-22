<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="model.ConnessioneDB, java.sql.*"%>
<!DOCTYPE html>
<html lang = "it">
	<head>
		<%@ include file="/partials/head.jsp" %>	
		<script src="<%=request.getContextPath()%>/js/scripts_registrati.js"></script>		
		<title>Registrati</title>		
	</head>
	<body>
		<%@ include file="/partials/header.jsp" %>				
		<div id="content">
			<div id="content-content">
				<%
					String output = "";
					String titolo = "";
					int tipoUtente = 0;
					if(request.getSession().getAttribute("tipo_utente") != null){
						tipoUtente = (int)request.getSession().getAttribute("tipo_utente");
					}
					
					if(tipoUtente == 1){
						titolo = "Compila i campi seguenti per registrare un nuovo Admin";
						output = "<input type='hidden' id='tipoUtente' name='tipoUtente' class='campoForm' value='1' />";							
					}
					else{
						titolo = "Compila i campi seguenti per registrarti al nostro e-commerce";
						output = "<input type='hidden' id='tipoUtente' name='tipoUtente' class='campoForm' value='2' />";							
					}					
				%>
			
				<p style="text-align: center;"><%=titolo %></p>				
				<form action="#" method="POST" id="formRegistrati">					
				    <fieldset>
				        <legend>Email</legend>
				        <input type="text" id="emailUtente" name="emailUtente" class="campoForm" />
				    </fieldset>					

				    <fieldset>
				        <legend>Password</legend>
				        <input type="password" id="passwordUtente" name="passwordUtente" class="campoForm" />
				    </fieldset>					

				    <fieldset>
				        <legend>Conferma Password</legend>
				        <input type="password" id="confermaPasswordUtente" name="confermaPasswordUtente" class="campoForm" />
				    </fieldset>					

				    <fieldset>
				        <legend>Codice Fiscale</legend>
				        <input type="text" id="codiceFiscaleUtente" name="codiceFiscaleUtente" class="campoForm" />
				    </fieldset>					

				    <fieldset>
				        <legend>Nome</legend>
				        <input type="text" id="nomeUtente" name="nomeUtente" class="campoForm" />
				    </fieldset>					

				    <fieldset>
				        <legend>Cognome</legend>
				        <input type="text" id="cognomeUtente" name="cognomeUtente" class="campoForm" />
				    </fieldset>					

				    <fieldset>
				        <legend>Sesso</legend>
				        <input type='radio' class='sessoUtente' name='sessoUtente' value='M' />M
				        <input type='radio' class='sessoUtente' name='sessoUtente' value='F' />F
				    </fieldset>					

				    <fieldset>
				        <legend>Data Nascita</legend>
				        <input type="date" id="dataNascitaUtente" name="dataNascitaUtente" class="campoForm" />
				    </fieldset>					

				    <%=output %>	
				    			    				
					<input type="submit" id="submitForm" name="submitForm" class="campoForm submitForm" value="Registrati" />				
				</form>
			</div>
		</div>
		<%@ include file="/partials/footer.jsp" %>	
	</body>
</html>