<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="model.ConnessioneDB,java.sql.*" %>
<div class="nav-utente">
				<ul class="parte-top">
					<li><a href="<%=request.getContextPath()%>/logout.jsp">Logout</a></li>
				</ul>			
				<ul class="parte">
					<li><a href="<%=request.getContextPath()%>/home.jsp">Home</a></li>
					<li class="has-child">						
						<a href="#">Servizi</a>
						<ul class="parte-figlio">
							<li><a href="categoria.jsp?idcat=1">Gestione Bestiame</a></li>
							<li><a href="categoria.jsp?idcat=2">Gestione Macchinari</a></li>
							<li><a href="categoria.jsp?idcat=3">Gestione Campi</a></li>
 						</ul>
					</li>
					<li><a href="<%=request.getContextPath()%>/chi_siamo.jsp">Chi siamo</a></li>
					
				</ul>
				
				
				<ul class="parte-mobile">
				<li><a href="<%=request.getContextPath()%>/index.jsp">Home</a></li>				
					<li class="has-child">
						<a href="#">Servizi</a>
						<ul class="parte-figlio">
							<li><a href="categoria.jsp?idcat=1">Gestione Bestiame</a></li>
							<li><a href="categoria.jsp?idcat=2">Gestione Macchinari</a></li>
							<li><a href="categoria.jsp?idcat=3">Gestione Campi</a></li>
 						</ul>
					</li>
					<li class="has-child">
					<li><a href="<%=request.getContextPath()%>/chi_siamo.jsp">Chi siamo</a></li>
					<li><a href="<%=request.getContextPath()%>/logout.jsp">Logout</a></li>
				</ul>										
</div>