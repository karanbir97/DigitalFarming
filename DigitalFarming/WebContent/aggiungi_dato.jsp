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
								String sql = "INSERT INTO prodotti(nome, id_categoria, attivo, sesso, data_nascita, produzione, ultimo_controllo, peso, razza, tipo_macchinario, targa, ultima_revisione, immatricolazione, capacita_serbatoio, coltura, varieta, quantita_semina, data_semina, data_raccolto, dimensioni_campo, descrizione) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ? ) ;";
								PreparedStatement  stmt = connDB.getConn().prepareStatement(sql);
								stmt.setString(1, "Mucca1");				
								stmt.setInt(2, 1);				
								stmt.setInt(3, 1);								
								stmt.setString(4, sesso);
								stmt.setString(5, data);
								stmt.setString(6, produzione);
								stmt.setString(7, controllo);
								stmt.setInt(8, peso);
								stmt.setString(9, razza);
								stmt.setString(10, "");	
								stmt.setString(11, "");	
								stmt.setString(12, null);	
								stmt.setString(13, null);	
								stmt.setInt(14, 0);	
								stmt.setString(15, "");	
								stmt.setString(16, "");	
								stmt.setInt(17, 0);	
								stmt.setString(18, null);	
								stmt.setString(19, null);	
								stmt.setInt(20, 0);	
								stmt.setString(21, "Mucca1");	
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