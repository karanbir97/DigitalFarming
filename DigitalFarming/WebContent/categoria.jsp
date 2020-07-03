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
			        	Integer idCategoria = Integer.parseInt(request.getParameter("idcat"));
			        	String output = "";
			        	String sql = "";
			        	ConnessioneDB connDB = new ConnessioneDB();
						if(connDB.getConn() != null) {
							try {
								if(idCategoria > 0){
									Statement stmt0 = connDB.getConn().createStatement();
									sql = ""
											+ "SELECT nome "
											+ "FROM prodotti_categorie "
											+ "WHERE attivo = 1 AND id_categoria = "+idCategoria+"; ";
									ResultSet result0 = stmt0.executeQuery(sql);								
									if(!result0.wasNull()) {
										while(result0.next()) {
											output = "<p class='adminTitoloPagina'>Categoria: "+result0.getString("nome")+"</p>";
										}					
									}										
								}
								
								
								Statement stmt = connDB.getConn().createStatement();							
								sql = ""
										+ "SELECT p.id_prodotto," 
										+ "       p.nome, "
										+ "       p.prezzo_base, " 
										+ "       (SELECT valore FROM prodotti_aliquote WHERE id_aliquota = p.id_aliquota) AS aliquota, " 
										+ "       (SELECT sigla FROM prodotti_unita WHERE id_unita = p.id_unita) AS unita, "
										+ "       (SELECT filename FROM prodotti_immagini WHERE id_prodotto = p.id_prodotto AND is_default = 1 AND attivo = 1) AS filename, "
										+ "	      (SELECT prezzo FROM prodotti_sconti WHERE id_prodotto = p.id_prodotto AND attivo = 1 AND DATE(NOW()) >= data_da AND data_a >= DATE(NOW()) ORDER BY data_inserimento DESC LIMIT 1) AS prezzo_scontato "
										+ "FROM prodotti  AS p "
										+ "WHERE p.attivo = 1 ";
										if(idCategoria > 0) sql += "AND p.id_categoria = "+idCategoria+" ";										
										sql += "ORDER BY p.id_prodotto DESC; ";								
								ResultSet result = stmt.executeQuery(sql);								
								if(!result.wasNull()) {
									int rowCount = result.last() ? result.getRow() : 0;
									if(rowCount > 0) {
										result.beforeFirst();
										
										while(result.next()) {					
											String filename;
											if(result.getString("filename") != null){
												filename = new SystemInformation().getPathImmaginiProdottoHTML()+result.getInt("id_prodotto")+"/"+result.getString("filename");												
											}
											else{
												filename = new SystemInformation().getPathImmaginiProdottoDefault();												
											}
											
											output += "<div class='product'>";
												output += "<div class='product-image' data-idprodotto='"+result.getInt("id_prodotto")+"'>";
														output += "<img src='"+filename+"'  alt='"+filename+"/"+result.getString("filename")+"' />";
												output += "</div>";
												output += "<div class='product-title' data-idprodotto='"+result.getInt("id_prodotto")+"'>";
													output += result.getString("nome");
												output += "</div>";
												output += "<div class='product-price'>";
													Float prz;
													if(result.getString("prezzo_scontato") != null){
														prz = result.getFloat("prezzo_scontato") * (1+(result.getFloat("aliquota")/100));
														output += "<span style='color: #DC483E;'>&euro; "+ new SystemInformation().truncateDecimal(prz, 2)+"*/"+result.getString("unita")+"</span>";
													}
													else{
														prz = result.getFloat("prezzo_base") * (1+(result.getFloat("aliquota")/100));
														output += "&euro; "+ new SystemInformation().truncateDecimal(prz, 2)+"/"+result.getString("unita");
													}																									
												output += "</div>";
												output += "<div class='product-button' data-idprodotto='"+result.getInt("id_prodotto")+"'>";
													output += "<a href='#'>Aggiungi al Carrello</a>";
												output += "</div>";
											output += "</div>";														
										}										
									}
									else {
										output = "<p class='adminTitoloPagina'>Nessun prodotto presente per la categoria selezionata.</p>";
									}											
								}
								
								connDB.getConn().close();
							}
							catch(Exception e) {
								output = e.getMessage();
							}	
						}
						else {
							output = connDB.getError();
						}				        				        
			        %>
			        <%= output %>
			        
				</div>
			</div>
		</div>
		<%@ include file="/partials/footer.jsp" %>	
	</body>
</html>