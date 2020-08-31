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
			        
			        nome : <%= request.getParameter("descrizione") %> <br /> 
			        sesso : <%= request.getParameter("sesso") %> <br /> 
			        data : <%= request.getParameter("data") %> <br /> 
			        peso : <%= request.getParameter("peso") %> <br /> 
			        produzione : <%= request.getParameter("produzione") %> <br /> 
			        controllo : <%= request.getParameter("controllo") %> <br /> 
			        
			        <%
			        	String id= request.getParameter("idcat");
			        	Integer idProdotto = Integer.parseInt(request.getParameter("idcat"));
			        	String razza = request.getParameter("descrizione");
			        	String sesso=request.getParameter("sesso");
			        	String data=request.getParameter("data");	
			        	Integer peso =Integer.parseInt( request.getParameter("peso"));
			        	String produzione=request.getParameter("produzione");
			        	String controllo=request.getParameter("controllo"); 
			        	
			        	String contenuto="";
			        	Integer risultato=0;
			        	String errore="";
			        	
			        	ConnessioneDB connDB = new ConnessioneDB();
						if(connDB.getConn() != null) {
							try {
								String sql = "INSERT INTO prodotti(nome, descrizione, descrizione_abbreviata, quantita_disponibile, prezzo_base, id_aliquota, id_categoria, id_unita, attivo, sesso, data, produzione, controllo) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?) ;";
								PreparedStatement  stmt = connDB.getConn().prepareStatement(sql);
								stmt.setString(1, "Mucca1");				
								stmt.setString(2, razza);				
								stmt.setString(3, "");								
								stmt.setInt(4, peso);
								stmt.setFloat(5, 1);						
								stmt.setInt(6, 1);				
								stmt.setInt(7, 1);				
								stmt.setInt(8, 2);				
								stmt.setInt(9, 1);
								stmt.setString(10, sesso);	
								stmt.setString(11, data);	
								stmt.setString(12, produzione);	
								stmt.setString(13, controllo);	
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
									
			        %>
			        
				</div>
		        id : <%= id %> <br /> 
		        msg : <%= contenuto %> <br /> 
		        msg : <%= errore %> <br /> 
		       
		</div>
		</div>
		<%@ include file="/partials/footer.jsp" %>	
	</body>
</html>