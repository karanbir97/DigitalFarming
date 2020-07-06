<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="model.ConnessioneDB,java.sql.*, model.SystemInformation"%>
<!DOCTYPE html>
<html lang = "it">
	<head>
		<%@ include file="/partials/head.jsp" %>			
		<script src="<%=request.getContextPath()%>/js/scripts_prodotto_dettaglio.js"></script>
		<title>Dettaglio Prodotto</title>		
	</head>
	<body>
		<%@ include file="/partials/header.jsp" %>		
		<div id="content">
			<div id="content-content">

			        <%
			        	Integer idProdotto = Integer.parseInt(request.getParameter("idp"));
			        	String output = "";
			        	String sql = "";
			        	String filename = "";
			        	String immaginePrincipale = "";
			        	String immagini = "";
			        	String nomeProdotto = "";
			        	String unita = "";
			        	String descrizioneAbbreviata = "";
			        	String descrizione = "";
			        	String prezzoProdotto = "";
			        	String categoriaProdotto = "";			        	
			        	Integer quantitaProdotto = 0;
			        	String sesso="";
			        	String data="";
			        	Integer produzione=0;
			        	String controllo="";
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
											if(result.getString("filename") != null){
												filename = new SystemInformation().getPathImmaginiProdottoHTML()+result.getInt("id_prodotto")+"/"+result.getString("filename");												
											}
											else{
												filename = new SystemInformation().getPathImmaginiProdottoDefault();												
											}																						
											immaginePrincipale = "<img class='showImmagineProdotto' src='"+"images/prodotti/"+result.getInt("id_prodotto")+"/"+result.getString("filename")+"'  alt='"+filename+"/"+result.getString("filename")+"' alt='"+filename+"' />";		
											
											nomeProdotto = result.getString("nome");													
											if(result.getString("prezzo_scontato") != null){																							
												prezzoProdotto = "<span style='color: #DC483E;'>&euro; "+String.valueOf(new SystemInformation().truncateDecimal(result.getFloat("prezzo_scontato") * (1+(result.getFloat("aliquota")/100)), 2))+"/"+result.getString("unita")+"*</span>"; 
											}
											else{												
												prezzoProdotto = "&euro; "+String.valueOf(new SystemInformation().truncateDecimal(result.getFloat("prezzo_base") * (1+(result.getFloat("aliquota")/100)), 2))+"/"+result.getString("unita");
											}																									
											descrizioneAbbreviata = result.getString("descrizione_abbreviata");
											descrizione = result.getString("descrizione");
											categoriaProdotto = "Categoria: <a href='"+request.getContextPath()+"/categoria.jsp?idcat="+result.getInt("id_categoria")+"'>"+result.getString("categoria")+"</a>";											
											
											quantitaProdotto = result.getInt("quantita_disponibile");
											sesso=result.getString("sesso");
											data=result.getString("data");
																					
											Statement stmt2 = connDB.getConn().createStatement();							
											sql = ""
													+ "SELECT filename " 
													+ "FROM prodotti_immagini "
													+ "WHERE id_prodotto = "+idProdotto+" AND is_default = 0 AND attivo = 1 " 
													+ "ORDER BY id_immagine DESC; "; 
											ResultSet result2 = stmt2.executeQuery(sql);								
											if(!result2.wasNull()) {
												while(result2.next()) { 
													filename = new SystemInformation().getPathImmaginiProdottoHTML()+idProdotto+"/"+result2.getString("filename");
													immagini += "<img class='showImmagineProdotto' src='"+filename+"' alt='"+filename+"' />";
												}
											}										
										
										
										}										
									}
									else {
										nomeProdotto = "Prodotto Non Trovato.";
									}											
								}
								
								connDB.getConn().close();
							}
							catch(Exception e) {
								nomeProdotto = e.getMessage();
							}	
						}
						else {
							nomeProdotto = connDB.getError();
						}				        				        
			        %>
				<div class="dettaglioProdotto">	
					<div class="left">
						<%=immaginePrincipale %>
						<%=immagini %>						
					</div>
					<div class="right">
						<p class="nomeProdotto"><%=nomeProdotto %></p>
						<p class="categoriaProdotto"><%=categoriaProdotto %></p>
						<p class="prezzoProdotto">Razza : <%=descrizione %></p>
						<p class="prezzoProdotto">Sesso : <%=sesso %></p>
						<p class="prezzoProdotto">Data : <%=data %></p>
						<p class="prezzoProdotto"><%=prezzoProdotto %> - 
						<%
							if(quantitaProdotto > 0){
								%>
								Quantit&agrave; Disponibile: <%=quantitaProdotto %>
								<%												
							}
							else{
								%>
								<span style="color: #DC483E;">Quantit&agrave; Disponibile: <%=quantitaProdotto %></span>
								<%																												
							}
						%>						
						</p>
						<%
							if(quantitaProdotto > 0){
								%>
								<button class='userButtonAggiungiAlCarrello product-button' data-idprodotto='<%=idProdotto%>'>Aggiungi Al Carrello</button>
								<%												
							}
						%>						
						<p class="descrizioneAbbreviataProdotto"><%=descrizioneAbbreviata %></p>
						
						
						
					</div>
				</div>        			        
			</div>
		</div>
		<%@ include file="/partials/footer.jsp" %>	
	</body>
</html>