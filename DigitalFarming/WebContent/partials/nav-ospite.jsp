<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="model.ConnessioneDB,java.sql.*" %>
<div class="nav-ospite">
				
				<ul class="parte">
					<li><a href="<%=request.getContextPath()%>/chi_siamo.jsp">Chi siamo</a></li>
				</ul>
				
				<ul class="parte-mobile">
					<li><a href="<%=request.getContextPath()%>/index.jsp">Home</a></li>
					<li><a href="<%=request.getContextPath()%>/accedi.jsp">Accedi</a></li>
					<li class="has-child">
						<a href="<%=request.getContextPath()%>/categoria.jsp?idcat=0">Prodotti</a>
						<ul class="parte-mobile-figlio">
				        	
 						</ul>
					</li>
					<li><a href="<%=request.getContextPath()%>/chi_siamo.jsp">Chi siamo</a></li>
					<li><a href="<%=request.getContextPath()%>/contattaci.jsp">Contattaci</a></li>
				</ul>				
</div>