<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="model.ConnessioneDB,java.sql.*, model.SystemInformation"%>
<!DOCTYPE html>
<html lang = "it">
	<head>
		<%@ include file="/partials/head.jsp" %>			
		<script src="<%=request.getContextPath()%>/js/scripts_prodotto_dettaglio.js"></script>
		<title>Dettaglio Prodotto</title>	
		
		<script type="text/javascript">
		function Modifica() {
  			
  				document.getElementById("descrizione").style.display = 'block';
  				document.getElementById("sesso").style.display = 'block';
  				document.getElementById("data").style.display = 'block';
  				document.getElementById("peso").style.display = 'block';
  				document.getElementById("produzione").style.display = 'block';
  				document.getElementById("controllo").style.display = 'block';
  				document.getElementById("annulla").style.display = 'block'; 
  				document.getElementById("salva").style.display = 'block'; 
  	  			document.getElementById("desc").style.display = 'none';  
  	  			document.getElementById("sex").style.display = 'none'; 	
	  	  		document.getElementById("date").style.display = 'none'; 
	  	  		document.getElementById("kg").style.display = 'none'; 
	  	  		document.getElementById("prod").style.display = 'none'; 
	  			document.getElementById("control").style.display = 'none'; 
	  			document.getElementById("modifica").style.display = 'none'; 
		}
		function Annulla() {
			document.getElementById("descrizione").style.display = 'none';
			document.getElementById("sesso").style.display = 'none';
			document.getElementById("data").style.display = 'none';
			document.getElementById("peso").style.display = 'none';
			document.getElementById("produzione").style.display = 'none';
			document.getElementById("controllo").style.display = 'none';
	  		document.getElementById("desc").style.display = 'block';  
	  		document.getElementById("sex").style.display = 'block'; 	
  	  		document.getElementById("date").style.display = 'block'; 
  	  		document.getElementById("kg").style.display = 'block'; 
  	  		document.getElementById("prod").style.display = 'block'; 
  			document.getElementById("control").style.display = 'block'; 
  			document.getElementById("modifica").style.display = 'block'; 
  			document.getElementById("annulla").style.display = 'none'; 
  			document.getElementById("salva").style.display = 'none'; 
	}
		</script>		
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
																																	
											descrizioneAbbreviata = result.getString("descrizione_abbreviata");
											descrizione = result.getString("descrizione");
											categoriaProdotto = "Categoria: <a href='"+request.getContextPath()+"/categoria.jsp?idcat="+result.getInt("id_categoria")+"'>"+result.getString("categoria")+"</a>";											
											
											quantitaProdotto = result.getInt("quantita_disponibile");
											sesso=result.getString("sesso");
											data=result.getString("data");
											produzione=result.getInt("produzione");
											controllo=result.getString("controllo");
																					
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
						<p class="prezzoProdotto" >Razza : <b id="desc"><%=descrizione %></b> <input style="display:none" type="text" id="descrizione" name="descrizione" value="<%=descrizione %>"></p>
						<p class="prezzoProdotto" >Sesso : <b id="sex"><%=sesso %></b> <input style="display:none" type="text" id="sesso" name="sesso" value="<%=sesso %>"></p>
						<p class="prezzoProdotto" >Data : <b id="date"><%=data %></b> <input style="display:none" type="text" id="data" name="data" value="<%=data %>"></p>
						<p class="prezzoProdotto" >Peso animale:<b id="kg"><%=quantitaProdotto %></b> <input style="display:none" type="text" id="peso" name="peso" value="<%=quantitaProdotto %>"> Kg </p>
						<p class="prezzoProdotto" >Produzione: <b id="prod"><%=produzione %></b> <input style="display:none" type="text" id="produzione" name="produzione" value="<%=produzione %>"></p>
						<p class="prezzoProdotto" >Controllo: <b id="control"><%=controllo %> </b><input style="display:none" type="text" id="controllo" name="controllo" value="<%=controllo %>"></p>
						
						<button id="modifica" class='userButtonAggiungiAlCarrello' onclick="Modifica()">Modifica prodotto</button>
						<p><button id="annulla" style="display:none" class='userButtonAggiungiAlCarrello' onclick="Annulla()">Annulla modifica</button>	</p>
						<p><button id="salva" style="display:none" class='userButtonAggiungiAlCarrello' onclick="Salva()">Salva modifica</button>			</p>	
						
						
						
					</div>
				</div>        			        
			</div>
		</div>
		<%@ include file="/partials/footer.jsp" %>	
	</body>
</html>