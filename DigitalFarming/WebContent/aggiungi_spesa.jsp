<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="model.ConnessioneDB,java.sql.*, model.SystemInformation"%>
<!DOCTYPE html>
<html lang = "it">
	<head>
		<%@ include file="/partials/head.jsp" %>			
		<title>Aggiungi</title>		
	</head>
	<body>
		<%@ include file="/partials/header.jsp" %>		
		<div id="content">
			<div id="content-content">
				<div class="categoriaProdotto">
			        
			        <%
				        String spesa=request.getParameter("spesa");
			        	Integer s = Integer.parseInt(spesa);
				        String descrizione=request.getParameter("descrizione");
				        String categoria=request.getParameter("categoria");
				        String data=request.getParameter("data");
			        	
			        	String contenuto="";
			        	Integer risultato=0;
			        	String errore="";
			        	String msg="";
			        	
			        	ConnessioneDB connDB = new ConnessioneDB();
						if(connDB.getConn() != null) {
							try {
								String sql = "INSERT INTO bilancio(descrizione, categoria, spese, attivo, data) VALUES (?, ?, ?, ?, ?) ;";
								PreparedStatement  stmt = connDB.getConn().prepareStatement(sql);
								stmt.setString(1, descrizione);				
								stmt.setString(2, categoria);				
								stmt.setInt(3, s);								
								stmt.setInt(4, 1);
								stmt.setString(5, data);
								if(stmt.executeUpdate() == 1) {
									contenuto = "Prodotto Inserito con Successo";
									risultato = 1;					
								}
								else {
									errore = "Errore Inserimento Prodotto.";
									risultato = 0;					
								}
								
								if(risultato == 0) {
									connDB.getConn().rollback();
								}
								else {
									connDB.getConn().commit();
								}												
								connDB.getConn().close();
							}
							catch(Exception e) {
								errore = "Errore esecuzione Query."+e.getMessage();
								risultato = 0;
							}
						}	
						response.sendRedirect("bilancio.jsp");
			        %>
			        
			        
				</div>
		       
		</div>
		</div>
		<%@ include file="/partials/footer.jsp" %>	
	</body>
</html>