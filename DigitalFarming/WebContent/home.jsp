<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="model.ConnessioneDB,java.sql.*, model.SystemInformation"%>
<!DOCTYPE html>
<html lang = "it">
	<head>
		<%@ include file="/partials/head.jsp" %>			
		<title>Index</title>		
		
		<link rel="stylesheet" href="css/style.css"/>
		
	</head>
	<body>
		<%@ include file="/partials/header.jsp" %>		
		<br>
		
		<div class="portfolio_area">
        <!-- <div class="container-fluid p-0"> -->
            <div class="portfolio_wrap">
                <div class=" single_gallery">
                    <div class="thumb">
                        <img src="images/bestiame.jpg" alt="">
                    </div>
                    <%
				        	String output = "";
                           	String bestiame="";
                           	String macchinari="";
                           	String raccolta="";
                           	int i=0;
				        	ConnessioneDB connDB = new ConnessioneDB();
							if(connDB.getConn() != null) {
								try {
									Statement stmt = connDB.getConn().createStatement();
									String sql = "";
									sql = ""
										+ "SELECT id_categoria, nome "
										+ "FROM prodotti_categorie AS pc "
										+ "WHERE pc.attivo = 1 "
										+ "ORDER BY pc.nome ASC;";										
									ResultSet result = stmt.executeQuery(sql);
									
									if(!result.wasNull()) {
										int rowCount = result.last() ? result.getRow() : 0;
										if(rowCount > 0) {
											result.beforeFirst();
											while(result.next()) {							
												output = "<a href='"+request.getContextPath()+"/categoria.jsp?idcat="+result.getString("id_categoria")+"'>"+result.getString("nome")+"</a>";
												if(i==0){
													bestiame=output;
													i++;
												}else if(i==1){
													macchinari=output;
													i++;
												}else if(i==2){
													raccolta=output;
													i++;
												}
											}
										}
										else {
											output = "Errore prelevamento Categorie";
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
                    <div class="gallery_hover">
                        <div class="hover_inner">
                                <span>Responsabile</span>
                                <% if((Integer) request.getSession().getAttribute("tipo_utente") == 2){
            							 %>
                                  	<a href="work_details.html"> <h3><%= bestiame %></h3></a><%} 
										else { 
										%><a href="javascript:;" onclick="window.open('Errore/errore.html', 'titolo', 'width=600, height=300, resizable, status, scrollbars=1, center');">  <h3><%= bestiame %></h3></a>
                           				<%}%>
                           				
                           				
                           				  
                        </div>
                    </div>
                </div>
                <div class="single_gallery small_width">
                    <div class="thumb">
                        <img src="images/macchinari.jpg" alt="">
                    </div>
                    <div class="gallery_hover">
                            <div class="hover_inner">
                                    <span>Responsabile</span>
                                    <% if((Integer) request.getSession().getAttribute("tipo_utente") == 3){
            							 %>
                                  	<a href="work_details.html"> <h3><%= macchinari %></h3></a><%} 
										else { 
										%><a href="javascript:;" onclick="window.open('Errore/errore.html', 'titolo', 'width=600, height=300, resizable, status, scrollbars=1, center');">  <h3><%= macchinari %></h3></a>
                           				<%}%>	
                            </div>
                        </div>
                </div>
                <div class="single_gallery">
                    <div class="thumb">
                        <img src="images/campi.jpg" alt="">
                    </div>
                    <div class="gallery_hover">
                    	<div class="hover_inner">
                    		<span>Responsabile</span>
                    		<% if((Integer) request.getSession().getAttribute("tipo_utente") == 4){
            							 %>
                                  	<a href="work_details.html"> <h3><%= raccolta %></h3></a><%} 
										else { 
										%><a href="javascript:;" onclick="window.open('Errore/errore.html', 'titolo', 'width=600, height=300, resizable, status, scrollbars=1, center');">  <h3><%= raccolta %></h3></a>
                           				<%}%>
                        </div>
                    </div>
                </div>
            </div>
        </div>
		<br>
		<script src="js/home/jquery-3.2.1.min.js"></script>
		<script src="js/home/jquery.nicescroll.min.js"></script>
		<script src="js/home/pana-accordion.js"></script>
		<script src="js/home/main.js"></script>  
		
		<%@ include file="/partials/footer.jsp" %>	
	</body> 
</html>
