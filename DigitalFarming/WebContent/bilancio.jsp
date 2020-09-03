<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="model.ConnessioneDB,java.sql.*, model.SystemInformation"%>
<!DOCTYPE html>
<html lang = "it">
	<head>
		<%@ include file="/partials/head.jsp" %>			
		<title>Bilancio</title>		
		
		<link rel="stylesheet" href="css/style.css"/>
		
	</head>
	<body>
		<%@ include file="/partials/header.jsp" %>		
		<br>
		<%@ include file="/corpo_bilancio.jsp" %>
		
		<script src="js/home/jquery-3.2.1.min.js"></script>
		<script src="js/home/jquery.nicescroll.min.js"></script>
		<script src="js/home/pana-accordion.js"></script>
		<script src="js/home/main.js"></script>  
		
		<%@ include file="/partials/footer.jsp" %>	
	</body> 
</html>