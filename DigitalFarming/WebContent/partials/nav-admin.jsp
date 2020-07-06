<div class="nav-admin">
				<ul class="parte-top">
					<li><a href="<%=request.getContextPath()%>/logout.jsp">Logout</a></li>
				</ul>			
				<ul class="parte">
					<li><a href="<%=request.getContextPath()%>/index.jsp">Home</a></li>
					<li class="has-child">						
						<a href="#">Servizi</a>
						<ul class="parte-figlio">
							<li><a href="categoria.jsp?idcat=1">Gestione bestiame</a></li>
							<li><a href="categoria.jsp?idcat=2">Gestione macchinari</a></li>
							<li><a href="categoria.jsp?idcat=3">Gestione campi;</a></li>
 						</ul>
					</li>
					
					<li class="has-child">
						<a href="<%=request.getContextPath()%>/_adminArea/clienti.jsp">Dipendenti</a>
					</li>
				</ul>
				
				<ul class="parte-mobile">
					<li><a href="<%=request.getContextPath()%>/index.jsp">Home</a></li>
					<li class="has-child">
						<a href="#">Servizi</a>
						<ul class="parte-figlio">
							<li><a href="categoria.jsp?idcat=1">Gestione bestiame</a></li>
							<li><a href="categoria.jsp?idcat=2">Gestione macchinari</a></li>
							<li><a href="categoria.jsp?idcat=3">Gestione campi;</a></li>
 						</ul>
					</li>
										<li class="has-child">
						
						<a href="<%=request.getContextPath()%>/_adminArea/clienti.jsp">Dipendenti</a>
					<li><a href="<%=request.getContextPath()%>/logout.jsp">Logout</a></li>
				</ul>				
</div>