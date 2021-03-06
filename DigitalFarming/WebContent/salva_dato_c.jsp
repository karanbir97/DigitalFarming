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
			        	String output = "";
			        	String sql = "";
			        	String sql2 = "";
			        	String msg = "";
			        	String filename = "";
			        	String nomeProdotto = request.getParameter("descrizione");	
			        	String coltura= request.getParameter("coltura");	
			        	String varieta=request.getParameter("varieta");	
			        	String quantita=request.getParameter("quantita");
			        	String data_semina=request.getParameter("data_semina");	
			        	String data_raccolta=request.getParameter("data_raccolta");	
			        	String dimensione_campo=request.getParameter("dimensione_campo");	
			        	String nome="";
			        	Integer risultato=0;
			        	String errore="";
			        	String contenuto="";
			        	
			        	ConnessioneDB connDB = new ConnessioneDB();
						if(connDB.getConn() != null) {
							try {

								
								PreparedStatement  stmt2 = null;
								sql2 = "UPDATE prodotti SET coltura = ? , varieta = ? , quantita_semina = ? , data_semina = ? , data_raccolto = ? , dimensioni_campo = ? WHERE id_prodotto = ?"; 
								stmt2 = connDB.getConn().prepareStatement(sql2);
								stmt2.setString(1, coltura);
								stmt2.setString(2, varieta);
								stmt2.setString(3, quantita);
								stmt2.setString(4, data_semina);
								stmt2.setString(5, data_raccolta);
								stmt2.setString(6, dimensione_campo);
								stmt2.setInt(7, idProdotto);
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
							nomeProdotto = connDB.getError();
						}				        
						response.sendRedirect("prodotto_dettaglio.jsp?idp="+idProdotto+"");
									
			        %>
			        
				</div>
				
			         id : <%= request.getParameter("idcat") %> <br /> 
			         nome : <%= request.getParameter("coltura") %> <br /> 
			        sesso : <%= request.getParameter("varieta") %> <br /> 
			        data : <%= request.getParameter("quantita") %> <br /> 
			        peso : <%= request.getParameter("data_semina") %> <br /> 
			        produzione : <%= request.getParameter("data_raccolta") %> <br /> 
			        controllo : <%= request.getParameter("dimensione_campo") %> <br />
			      c : <%=contenuto %> <br />
				
		       
		</div>
		</div>
		<%@ include file="/partials/footer.jsp" %>	
	</body>
</html>