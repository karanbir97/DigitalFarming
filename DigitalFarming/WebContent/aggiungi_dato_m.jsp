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
			        
			        tipo : <%= request.getParameter("tipo") %> <br /> 
			        targa : <%= request.getParameter("targa") %> <br /> 
			        revisione : <%= request.getParameter("revisione") %> <br /> 
			        immatricolazione : <%= request.getParameter("immatricolazione") %> <br /> 
			        serbatoio : <%= request.getParameter("capacita") %> <br /> 
			        
			        <%
			        	String id= request.getParameter("idcat");
			        	Integer idProdotto = Integer.parseInt(request.getParameter("idcat"));
			        	String tipo = request.getParameter("tipo");
			        	String targa=request.getParameter("targa");
			        	String revisione=request.getParameter("revisione");	
			        	Integer capacita =Integer.parseInt( request.getParameter("capacita"));
			        	String immatricolazione=request.getParameter("immatricolazione");
			        	
			        	String contenuto="";
			        	Integer risultato=0;
			        	String errore="";
			        	
			        	ConnessioneDB connDB = new ConnessioneDB();
						if(connDB.getConn() != null) {
							try {
								String sql = "INSERT INTO prodotti(nome, id_categoria, attivo, sesso, data_nascita, produzione, ultimo_controllo, peso, razza, tipo_macchinario, targa, ultima_revisione, immatricolazione, capacita_serbatoio, coltura, varieta, quantita_semina, data_semina, data_raccolto, dimensioni_campo, descrizione) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ? ) ;";
								PreparedStatement  stmt = connDB.getConn().prepareStatement(sql);
								stmt.setString(1, "Macchinario");				
								stmt.setInt(2, 2);				
								stmt.setInt(3, 1);								
								stmt.setString(4, null);
								stmt.setString(5, null);
								stmt.setString(6, null);
								stmt.setString(7, null);
								stmt.setString(8, null);
								stmt.setString(9, null);
								stmt.setString(10, tipo);	
								stmt.setString(11, targa);	
								stmt.setString(12, revisione);	
								stmt.setString(13, immatricolazione);	
								stmt.setInt(14, capacita);	
								stmt.setString(15, "");	
								stmt.setString(16, "");	
								stmt.setInt(17, 0);	
								stmt.setString(18, null);	
								stmt.setString(19, null);	
								stmt.setInt(20, 0);	
								stmt.setString(21, "Macchinario");	
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