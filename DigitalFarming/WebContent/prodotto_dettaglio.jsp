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
  				document.getElementById("elimina").style.display = 'block'; 
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
  			document.getElementById("elimina").style.display = 'none'; 
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
			        	Integer cat=0;
			        	Integer produzione=0;
			        	String controllo="";
			        	String coltura="";
			        	String varieta="";
			        	Integer quantita=0;
			        	String data_semina="";
			        	String data_raccolta="";
			        	Integer dimensione_campo=0;
			        	ConnessioneDB connDB = new ConnessioneDB();
						if(connDB.getConn() != null) {
							try {
								Statement stmt = connDB.getConn().createStatement();							
								sql = ""
										+ "SELECT p.id_prodotto," 
										+ "       p.nome, "
										+ "       p.id_categoria, "	
										+ "       p.descrizione, " 
										+ "       p.sesso, " 
										+ "       p.data_nascita, " 
										+ "       p.produzione, " 
										+ "       p.ultimo_controllo, " 
										+ "       p.peso, " 
										+ "       p.razza, " 
										+ "       p.tipo_macchinario, " 
										+ "       p.targa, " 
										+ "       p.ultima_revisione, " 
										+ "       p.immatricolazione, " 
										+ "       p.capacita_serbatoio, " 
										+ "       p.coltura, " 
										+ "       p.varieta, " 
										+ "       p.quantita_semina, " 
										+ "       p.data_semina, " 
										+ "       p.data_raccolto, " 
										+ "       p.dimensioni_campo, " 
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
																																	
											descrizioneAbbreviata = result.getString("razza");
											descrizione = result.getString("descrizione");
											categoriaProdotto = "Categoria: <a href='"+request.getContextPath()+"/categoria.jsp?idcat="+result.getInt("id_categoria")+"'>"+result.getString("categoria")+"</a>";											
											cat=result.getInt("id_categoria");
											quantitaProdotto = result.getInt("peso");
											sesso=result.getString("sesso");
											data=result.getString("data_nascita");
											produzione=result.getInt("produzione");
											controllo=result.getString("ultimo_controllo");
											coltura=result.getString("coltura");
											varieta=result.getString("varieta");
											quantita=result.getInt("quantita_semina");
											data_semina=result.getString("data_semina");
											data_raccolta=result.getString("data_raccolto");
											dimensione_campo=result.getInt("dimensioni_campo");
																					
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
					<%if(cat == 1){ %>
					<%@ include file="/dati_bestiame.jsp" %>
					<%}else if(cat == 2){ %>
						<%@ include file="/dati_macchinari.jsp" %>
					<%}else if(cat == 3){ %>
					<%@ include file="/dati_campo.jsp" %>
					<%} else if(cat == 4){ %>
					<%@ include file="/aggiungi_bestiame.jsp" %>
					<%} else if(cat == 5){ %>
					<%@ include file="/aggiungi_macchinari.jsp" %>
					<%} else if(cat == 6){ %>
					<%@ include file="/aggiungi_bestiame.jsp" %>
					<%} %>
				</div>        			        
			</div>
		</div>
		<%@ include file="/partials/footer.jsp" %>	
	</body>
</html>