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
		<h1 align="center">Gestione Bilancio</h1>
		
		
		
<style>
table { width: 500px; background-color: #FFFFFF; color: #000000; border-color: green; border-collapse: collapse; }
th, td { width: 250px; }
</style>
<table border="3" cellspacing="0" cellpadding="0" align="center">
<tbody>
<tr>
<td align="center"><h3>ENTRATE</h3></td>
<td align="center"><h3>USCITE</h3></td>
</tr>
<tr>
<td><h5>+ 500</h5></td>
<td><h5>- 250</h5></td>
</tr>
<td><h5>+ 500</h5></td>
<td><h5>- 250</h5></td>
</tr>
<td><h5>+ 500</h5></td>
<td><h5>- 250</h5></td>
</tr>
<td><h5>+ 500</h5></td>
<td><h5>- 250</h5></td>
</tr>
<td align="right"><h5>TOTALE ENTRATE = 2000</h5></td>
<td align="right"><h5>TOTALE USCITE = 1000</h5></td>
</tr>
</tbody>
</table>
		
		<br>
		<script src="js/home/jquery-3.2.1.min.js"></script>
		<script src="js/home/jquery.nicescroll.min.js"></script>
		<script src="js/home/pana-accordion.js"></script>
		<script src="js/home/main.js"></script>  
		
		<%@ include file="/partials/footer.jsp" %>	
	</body> 
</html>