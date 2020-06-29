<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="model.ConnessioneDB,java.sql.*" %>
<div class="nav-ospite">
				<ul class="parte-top">
					<li><a href="<%=request.getContextPath()%>/accedi.jsp">Accedi</a></li>
				</ul>			
				<ul class="parte">
					<li><a href="<%=request.getContextPath()%>/index.jsp">Home</a></li>
					<li class="has-child">
						<a href="<%=request.getContextPath()%>/categoria.jsp?idcat=0">Prodotti</a>
						<ul class="parte-figlio">						
				        <%
				        	String output = "";
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
												output += "<li><a href='"+request.getContextPath()+"/categoria.jsp?idcat="+result.getString("id_categoria")+"'>"+result.getString("nome")+"</a></li>";
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
				        <%= output %>							
							
 						</ul>
					</li>
					<li><a href="<%=request.getContextPath()%>/chi_siamo.jsp">Chi siamo</a></li>
				</ul>
				
				<ul class="parte-mobile">
					<li><a href="<%=request.getContextPath()%>/index.jsp">Home</a></li>
					<li><a href="<%=request.getContextPath()%>/accedi.jsp">Accedi</a></li>
					<li class="has-child">
						<a href="<%=request.getContextPath()%>/categoria.jsp?idcat=0">Prodotti</a>
						<ul class="parte-mobile-figlio">
				        	<%= output %>
 						</ul>
					</li>
					<li><a href="<%=request.getContextPath()%>/chi_siamo.jsp">Chi siamo</a></li>
					<li><a href="<%=request.getContextPath()%>/contattaci.jsp">Contattaci</a></li>
				</ul>				
</div>