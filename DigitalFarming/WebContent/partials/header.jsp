		<div id="loader">
			<img src="<%=request.getContextPath()%>/images/loader.gif" />
		</div>
		
		<div id="modalContatti">			
			<div id="modalContattiNav">
				<i class="fas fa-times chiudiModalContatti"></i>
			</div>			
			<div id="modalContattiBody">				
			</div>
		</div>
		
		<div id="modalImmagini">			
			<div id="modalImmaginiNav">
				<i class="fas fa-times chiudiModalImmagini"></i>
			</div>			
			<div id="modalImmaginiBody">				
			</div>
		</div>


		<div id="modalDettaglioOrdine">			
			<div id="modalDettaglioOrdineNav">
				<i class="fas fa-times chiudiModalDettaglioOrdine"></i>
			</div>			
			<div id="modalDettaglioOrdineBody">				
			</div>
		</div>

		<div id="header">		
				
			<div id="header-content">
				<div class="logo">
					<%		
						if((Integer) request.getSession().getAttribute("tipo_utente") == null){ %>
					<a href="<%=request.getContextPath()%>/index.jsp"><img src="<%=request.getContextPath()%>/images/logo_orizzontale.png" alt="Logo"></a> 
					<% } else {%> 
					<a href="<%=request.getContextPath()%>/home.jsp"><img src="<%=request.getContextPath()%>/images/logo_orizzontale.png" alt="Logo"></a> 
					<% } %>
				</div>			
				<div class="icon-nav">
					<i class="fas fa-bars"></i>
				</div>
					<%		
						if((Integer) request.getSession().getAttribute("tipo_utente") == null){
							%><%@ include file="/partials/nav-ospite.jsp" %><%
						} 
						else if((Integer) request.getSession().getAttribute("tipo_utente") == 1){ 
							%><%@ include file="/partials/nav-admin.jsp" %><%
					   	}
					   	else if((Integer) request.getSession().getAttribute("tipo_utente") == 2){					   	
					   		%><%@ include file="/partials/nav-utente.jsp" %><%
					   	}
					   	else if((Integer) request.getSession().getAttribute("tipo_utente") == 3){					   	
					   		%><%@ include file="/partials/nav-utente.jsp" %><%
					   	}
					   	else if((Integer) request.getSession().getAttribute("tipo_utente") == 4){					   	
					   		%><%@ include file="/partials/nav-utente.jsp" %><%
					   	}
					%>								
			</div>
		</div>