<div class="nav-admin">
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
					
						<li class="has-child">
						<a href="<%=request.getContextPath()%>/chi_siamo.jsp">Chi Siamo</a>
					</li>
					
					<li class="has-child">
						<a href="<%=request.getContextPath()%>/_adminArea/clienti.jsp">Dipendenti</a>
					</li>
					
					<li class="has-child">
						<a href="<%=request.getContextPath()%>/_adminArea/bilancio.jsp">Bilancio</a>
					</li>
				</ul>
				
				<ul class="parte-mobile">
					<li><a href="<%=request.getContextPath()%>/home.jsp">Home</a></li>
					<li class="has-child">
						<a href="#">Servizi</a>
						<ul class="parte-figlio">
							<li><a href="categoria.jsp?idcat=1">Gestione Bestiame</a></li>
							<li><a href="categoria.jsp?idcat=2">Gestione Macchinari</a></li>
							<li><a href="categoria.jsp?idcat=3">Gestione Campi</a></li>
 						</ul>
					</li>
										<li class="has-child">
						
						<a href="<%=request.getContextPath()%>/_adminArea/clienti.jsp">Dipendenti</a>
					<li><a href="<%=request.getContextPath()%>/logout.jsp">Logout</a></li>
				</ul>				
</div>