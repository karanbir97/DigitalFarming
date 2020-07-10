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
							<li><% if(((Integer) request.getSession().getAttribute("tipo_utente") == 2) || ((Integer) request.getSession().getAttribute("tipo_utente") == 1)){ %>
									<a href="categoria.jsp?idcat=1">Gestione Bestiame</a>
								<%} else { %>
									<a href="javascript:;" onclick="window.open('Errore/errore.html', 'titolo', 'width=600, height=300, resizable, status, scrollbars=1, center');">Gestione Bestiame</a>
								<% } %></li>
							<li><% if((Integer) request.getSession().getAttribute("tipo_utente") == 4 || ((Integer) request.getSession().getAttribute("tipo_utente") == 1)){ %>
									<a href="categoria.jsp?idcat=2">Gestione Macchinari</a>
								<%} else { %>
									<a href="javascript:;" onclick="window.open('Errore/errore.html', 'titolo', 'width=600, height=300, resizable, status, scrollbars=1, center');">Gestione Macchinari</a>
								<%}%></li>
							<li><% if((Integer) request.getSession().getAttribute("tipo_utente") == 3 || ((Integer) request.getSession().getAttribute("tipo_utente") == 1)){ %>
									<a href="categoria.jsp?idcat=3">Gestione Campi</a>
								<%} else { %>
									<a href="javascript:;" onclick="window.open('Errore/errore.html', 'titolo', 'width=600, height=300, resizable, status, scrollbars=1, center');">Gestione Campi</a>
								<%}%></li>
 						</ul>
					</li>
					<li><a href="<%=request.getContextPath()%>/chi_siamo.jsp">Chi siamo</a></li>
					
				</ul>
				
				
				<ul class="parte-mobile">
				<li><a href="<%=request.getContextPath()%>/index.jsp">Home</a></li>				
					<li class="has-child">
						<a href="#">Servizi</a>
						<ul class="parte-figlio">
							<li><% if(((Integer) request.getSession().getAttribute("tipo_utente") == 2) || ((Integer) request.getSession().getAttribute("tipo_utente") == 1)){ %>
									<a href="categoria.jsp?idcat=1">Gestione Bestiame</a>
								<%} else { %>
									<a href="javascript:;" onclick="window.open('Errore/errore.html', 'titolo', 'width=600, height=300, resizable, status, scrollbars=1, center');">Gestione Bestiame</a>
								<% } %></li>
							<li><% if((Integer) request.getSession().getAttribute("tipo_utente") == 4 || ((Integer) request.getSession().getAttribute("tipo_utente") == 1)){ %>
									<a href="categoria.jsp?idcat=2">Gestione Macchinari</a>
								<%} else { %>
									<a href="javascript:;" onclick="window.open('Errore/errore.html', 'titolo', 'width=600, height=300, resizable, status, scrollbars=1, center');">Gestione Macchinari</a>
								<%}%></li>
							<li><% if((Integer) request.getSession().getAttribute("tipo_utente") == 3 || ((Integer) request.getSession().getAttribute("tipo_utente") == 1)){ %>
									<a href="categoria.jsp?idcat=3">Gestione Campi</a>
								<%} else { %>
									<a href="javascript:;" onclick="window.open('Errore/errore.html', 'titolo', 'width=600, height=300, resizable, status, scrollbars=1, center');">Gestione Campi</a>
								<%}%></li>
 						</ul>
					</li>
					<li class="has-child">
					<li><a href="<%=request.getContextPath()%>/chi_siamo.jsp">Chi siamo</a></li>
					<li><a href="<%=request.getContextPath()%>/logout.jsp">Logout</a></li>
				</ul>										
</div>




