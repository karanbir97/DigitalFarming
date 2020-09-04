<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="model.ConnessioneDB,java.sql.*, model.SystemInformation"%>
<!DOCTYPE html>
<html lang = "it">
	<head>
		<%@ include file="/partials/head.jsp" %>			
		<title>Salva bilancio</title>		
	</head>
	<body>
		<%@ include file="/partials/header.jsp" %>		
		<div id="content">
			<div id="content-content">
				<div class="categoriaProdotto">
			        
			        nome : <%= request.getParameter("descrizione") %> <br /> 
			        sesso : <%= request.getParameter("sesso") %> <br /> 
			        data : <%= request.getParameter("data") %> <br /> 
			        peso : <%= request.getParameter("peso") %> <br /> 
			        produzione : <%= request.getParameter("produzione") %> <br /> 
			        controllo : <%= request.getParameter("controllo") %> <br /> 
			        
			        <%
				        Integer spesa=Integer.parseInt(request.getParameter("spesa"));
				        String descrizione=request.getParameter("descrizione");
				        String categoria=request.getParameter("report-type");
				        String data=request.getParameter("data");
				        Integer id_bilancio=Integer.parseInt(request.getParameter("idb"));;
				  		String contenuto="";
			        	Integer risultato=0;
			        	String errore="";
			        	
			        	ConnessioneDB connDB = new ConnessioneDB();
						if(connDB.getConn() != null) {
							try {
								
								PreparedStatement  stmt2 = null;
								String sql = "UPDATE bilancio SET descrizione = ? , categoria = ? , spese = ? , attivo = ? , data = ?  WHERE idbilancio = ?"; 
								stmt2 = connDB.getConn().prepareStatement(sql);
								stmt2.setString(1, descrizione);
								stmt2.setString(2, categoria);
								stmt2.setInt(3, spesa);
								stmt2.setInt(4, 1);
								stmt2.setString(5, data);
								stmt2.setInt(6, id_bilancio);
								stmt2.executeUpdate();
								
								if(stmt2.executeUpdate() == 1) {
									contenuto = "Utenza Aggiornata con Successo";
									risultato = 1;					
								}
								else {
									errore = "Errore Aggiornamento Password.";
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
						else {
							contenuto = connDB.getError();
						}				        
						response.sendRedirect("bilancio.jsp");
									
			        %>
			        
				</div>
				
		        
		       
		</div>
		</div>
		<%@ include file="/partials/footer.jsp" %>	
	</body>
</html>