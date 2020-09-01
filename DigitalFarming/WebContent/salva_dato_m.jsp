<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="model.ConnessioneDB,java.sql.*, model.SystemInformation"%>
<!DOCTYPE html>
<html lang = "it">
	<head>
		<%@ include file="/partials/head.jsp" %>			
		<title>Categoria</title>		
	</head>
	<body>
		<%@ include file="/partials/header.jsp" %>		
		<div id="content">
			<div id="content-content">
				<div class="categoriaProdotto">
				 
			        <%
			        	Integer idProdotto = Integer.parseInt(request.getParameter("idcat"));
			        	String sql2 = "";
			        	String msg = "";
			        	String filename = "";
			        	String tipo= request.getParameter("tipo");	
			        	String targa=request.getParameter("targa");	
			        	String revisione=request.getParameter("revisione");
			        	String immatricolazione=request.getParameter("immatricolazione");	
			        	String serbatoio=request.getParameter("serbatoio");		
			        	String nome="";
			        	Integer risultato=0;
			        	String errore="";
			        	String contenuto="";
			        	
			        	ConnessioneDB connDB = new ConnessioneDB();
						if(connDB.getConn() != null) {
							try {

								
								PreparedStatement  stmt2 = null;
								sql2 = "UPDATE prodotti SET tipo_macchinario = ? , targa = ? , ultima_revisione = ? , immatricolazione = ? , capacita_serbatoio = ? WHERE id_prodotto = ?"; 
								stmt2 = connDB.getConn().prepareStatement(sql2);
								stmt2.setString(1, tipo);
								stmt2.setString(2, targa);
								stmt2.setString(3, revisione);
								stmt2.setString(4, immatricolazione);
								stmt2.setString(5, serbatoio);
								stmt2.setInt(6, idProdotto);
								stmt2.executeUpdate();
								
								if(stmt2.executeUpdate() == 1) {
									contenuto = "Utenza Aggiornata con Successo";
									risultato = 1;					
								}
								else {
									contenuto = "Errore Aggiornamento Password.";
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
							msg = connDB.getError();
						}				        
						response.sendRedirect("prodotto_dettaglio.jsp?idp="+idProdotto+"");
									
			        %>
			        
				</div>
				
			         
			      c : <%=contenuto %> <br />
				
		       
		</div>
		</div>
		<%@ include file="/partials/footer.jsp" %>	
	</body>
</html>