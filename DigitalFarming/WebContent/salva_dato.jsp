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
			        
			        nome : <%= request.getParameter("descrizione") %> <br /> 
			        sesso : <%= request.getParameter("sesso") %> <br /> 
			        data : <%= request.getParameter("data") %> <br /> 
			        peso : <%= request.getParameter("peso") %> <br /> 
			        produzione : <%= request.getParameter("produzione") %> <br /> 
			        controllo : <%= request.getParameter("controllo") %> <br /> 
			        
			        <%
			        	String id= request.getParameter("idcat");
			        	Integer idProdotto = Integer.parseInt(request.getParameter("idcat"));
			        	String output = "";
			        	String sql = "";
			        	String sql2 = "";
			        	String msg = "";
			        	String filename = "";
			        	String nomeProdotto = request.getParameter("descrizione");	
			        	String nome="";
			        	String quantitaProdotto = request.getParameter("peso");
			        	Integer peso=0;
			        	String sesso=request.getParameter("sesso");
			        	String sex="";
			        	String data=request.getParameter("data");
			        	String date="";
			        	String prod=request.getParameter("produzione");
			        	String produ="";
			        	String controllo=request.getParameter("controllo");
			        	String control="";
			        	String contenuto="";
			        	Integer risultato=0;
			        	String errore="";
			        	
			        	ConnessioneDB connDB = new ConnessioneDB();
						if(connDB.getConn() != null) {
							try {

								Statement stmt = connDB.getConn().createStatement();							
								sql = ""
										+ "SELECT p.id_prodotto," 
										+ "       p.nome, "
										+ "       p.id_categoria, "									
										+ "       p.prezzo_base, " 
										+ "       p.descrizione_abbreviata, " 
										+ "       p.descrizione, " 
										+ "       p.quantita_disponibile, " 
										+ "       p.sesso, " 
										+ "       p.data, " 
										+ "       p.produzione, " 
										+ "       p.controllo, " 
										+ "       (SELECT valore FROM prodotti_aliquote WHERE id_aliquota = p.id_aliquota) AS aliquota, " 
										+ "       (SELECT sigla FROM prodotti_unita WHERE id_unita = p.id_unita) AS unita, "
										+ "       (SELECT nome FROM prodotti_categorie WHERE id_categoria = p.id_categoria) AS categoria, "
										+ "       (SELECT filename FROM prodotti_immagini WHERE id_prodotto = p.id_prodotto AND is_default = 1 AND attivo = 1) AS filename, "
										+ "	      (SELECT prezzo FROM prodotti_sconti WHERE id_prodotto = p.id_prodotto AND attivo = 1 AND DATE(NOW()) >= data_da AND data_a >= DATE(NOW()) ORDER BY data_inserimento DESC LIMIT 1) AS prezzo_scontato "
										+ "FROM prodotti  AS p "
										+ "WHERE p.attivo = 1 AND p.id_prodotto = "+idProdotto+"; ";
								ResultSet result = stmt.executeQuery(sql);								
								if(!result.wasNull()) {
									int rowCount = result.last() ? result.getRow() : 0;
									if(rowCount > 0) {
										result.beforeFirst();										
										while(result.next()) {																
											
											nome = result.getString("descrizione");
											peso = result.getInt("quantita_disponibile");
											sex=result.getString("sesso");
											date=result.getString("data");
											produ=result.getString("produzione");
											control=result.getString("controllo");
										}										
									}
									else {
										nomeProdotto = "Prodotto Non Trovato.";
									}											
								}
								
								PreparedStatement  stmt2 = null;
								sql2 = "UPDATE prodotti SET descrizione = ? , quantita_disponibile = ? , sesso = ? , data = ? , produzione = ? , controllo = ? WHERE id_prodotto = ?"; 
								stmt2 = connDB.getConn().prepareStatement(sql2);
								stmt2.setString(1, nomeProdotto);
								stmt2.setString(2, quantitaProdotto);
								stmt2.setString(3, sesso);
								stmt2.setString(4, data);
								stmt2.setString(5, prod);
								stmt2.setString(6, controllo);
								stmt2.setInt(7, idProdotto);
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
							nomeProdotto = connDB.getError();
						}				        
						response.sendRedirect("prodotto_dettaglio.jsp?idp="+idProdotto+"");
									
			        %>
			        
				</div>
				nome : <%= nome %> <br /> 
		        sesso : <%= sex %> <br /> 
		        data : <%= date %> <br /> 
		        peso : <%= peso %> <br /> 
		        produzione : <%= produ %> <br /> 
		        controllo : <%= control %> <br /> 
		        id : <%= id %> <br /> 
		        msg : <%= contenuto %> <br /> 
		        msg : <%= errore %> <br /> 
		        salva : <%= salva %> <br /> 
		       
		</div>
		</div>
		<%@ include file="/partials/footer.jsp" %>	
	</body>
</html>