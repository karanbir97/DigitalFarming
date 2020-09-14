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
			        	String coltura=request.getParameter("coltura");
			        	String varieta=request.getParameter("varieta");
			        	Integer quantita = Integer.parseInt(request.getParameter("quantita"));
			        	String data_semina=request.getParameter("semina");
			        	String data_raccolta=request.getParameter("raccolta");
			        	Integer dimensione_campo= Integer.parseInt(request.getParameter("campo"));
			        	
			        	String contenuto="";
			        	Integer risultato=0;
			        	String errore="";
			        	
			        	ConnessioneDB connDB = new ConnessioneDB();
						if(connDB.getConn() != null) {
							try {
								String sql = "INSERT INTO prodotti(nome, id_categoria, attivo, sesso, data_nascita, produzione, ultimo_controllo, peso, razza, tipo_macchinario, targa, ultima_revisione, immatricolazione, capacita_serbatoio, coltura, varieta, quantita_semina, data_semina, data_raccolto, dimensioni_campo, descrizione) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ? ) ;";
								PreparedStatement  stmt = connDB.getConn().prepareStatement(sql);
								stmt.setString(1, "Campo");				
								stmt.setInt(2, 3);				
								stmt.setInt(3, 1);								
								stmt.setString(4, null);
								stmt.setString(5, null);
								stmt.setString(6, null);
								stmt.setString(7, null);
								stmt.setString(8, null);
								stmt.setString(9, null);
								stmt.setString(10, null);	
								stmt.setString(11, null);	
								stmt.setString(12, null);	
								stmt.setString(13, null);	
								stmt.setString(14, null);	
								stmt.setString(15, coltura);	
								stmt.setString(16, varieta);	
								stmt.setInt(17, quantita);	
								stmt.setString(18, data_semina);	
								stmt.setString(19, data_raccolta);	
								stmt.setInt(20, dimensione_campo);	
								stmt.setString(21, "Campo");	
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