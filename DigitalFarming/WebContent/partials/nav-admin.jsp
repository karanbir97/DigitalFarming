<div class="nav-admin">
				<ul class="parte-top">
					<li><a href="<%=request.getContextPath()%>/logout.jsp">Logout</a></li>
				</ul>			
				<ul class="parte">
					<li><a href="<%=request.getContextPath()%>/index.jsp">Home</a></li>
					<li class="has-child">						
						<a href="#">Catalogo</a>
						<ul class="parte-figlio">
							<li><a href="<%=request.getContextPath()%>/_adminArea/prodotti.jsp">Prodotti</a></li>
							<li><a href="<%=request.getContextPath()%>/_adminArea/prodotti_sconti.jsp">Sconti</a></li>
							<li><a href="<%=request.getContextPath()%>/_adminArea/prodotti_unita.jsp">Unit&agrave;</a></li>
							<li><a href="<%=request.getContextPath()%>/_adminArea/prodotti_categorie.jsp">Categorie</a></li>
							<li><a href="<%=request.getContextPath()%>/_adminArea/prodotti_aliquote.jsp">Aliquote IVA</a></li>
 						</ul>
					</li>
					<li class="has-child">
						<a href="#">Ordini</a>
						<ul class="parte-figlio">
							<li><a href="<%=request.getContextPath()%>/_adminArea/ordini.jsp">Ricevuti</a></li>
							<li><a href="<%=request.getContextPath()%>/_adminArea/ordini_stati.jsp">Stati</a></li>
							<li><a href="<%=request.getContextPath()%>/_adminArea/ordini_vettori.jsp">Vettori</a></li>
							<li><a href="<%=request.getContextPath()%>/_adminArea/ordini_metodi_pagamento.jsp">Metodi di Pagamento</a></li>
 						</ul>
					</li>
					<li class="has-child">
						<a href="<%=request.getContextPath()%>/_adminArea/clienti.jsp">Clienti</a>
						<ul class="parte-figlio">
							<li><a href="<%=request.getContextPath()%>/_adminArea/contatti.jsp">Contatti</a></li>
 						</ul>
					</li>
					<li><a href="<%=request.getContextPath()%>/_adminArea/profilo_admin.jsp">Il mio profilo</a></li>
					<li><a href="<%=request.getContextPath()%>/_adminArea/impostazioni.jsp">Impostazioni</a></li>
				</ul>
				
				<ul class="parte-mobile">
					<li><a href="<%=request.getContextPath()%>/index.jsp">Home</a></li>
					<li class="has-child">
						<a href="#">Catalogo</a>
						<ul class="parte-mobile-figlio">
							<li><a href="<%=request.getContextPath()%>/_adminArea/prodotti.jsp">Prodotti</a></li>
							<li><a href="<%=request.getContextPath()%>/_adminArea/prodotti_sconti.jsp">Sconti</a></li>
							<li><a href="<%=request.getContextPath()%>/_adminArea/prodotti_unita.jsp">Unit&agrave;</a></li>
							<li><a href="<%=request.getContextPath()%>/_adminArea/prodotti_categorie.jsp">Categorie</a></li>
							<li><a href="<%=request.getContextPath()%>/_adminArea/prodotti_aliquote.jsp">Aliquote IVA</a></li>
 						</ul>
					</li>
					<li class="has-child">
						<a href="#">Ordini</a>
						<ul class="parte-mobile-figlio">
							<li><a href="<%=request.getContextPath()%>/_adminArea/ordini.jsp">Ricevuti</a></li>
							<li><a href="<%=request.getContextPath()%>/_adminArea/ordini_stati.jsp">Stati</a></li>
							<li><a href="<%=request.getContextPath()%>/_adminArea/ordini_vettori.jsp">Vettori</a></li>
							<li><a href="<%=request.getContextPath()%>/_adminArea/ordini_metodi_pagamento.jsp">Metodi di Pagamento</a></li>
 						</ul>
					</li>
					<li class="has-child">
						<a href="<%=request.getContextPath()%>/_adminArea/clienti.jsp">Clienti</a>
						<ul class="parte-mobile-figlio">
							<li><a href="<%=request.getContextPath()%>/_adminArea/contatti.jsp">Contatti</a></li>
 						</ul>
					</li>
					<li><a href="<%=request.getContextPath()%>/_adminArea/profilo_admin.jsp">Il mio profilo</a></li>
					<li><a href="<%=request.getContextPath()%>/_adminArea/impostazioni.jsp">Impostazioni</a></li>
					<li><a href="<%=request.getContextPath()%>/logout.jsp">Logout</a></li>
				</ul>				
</div>