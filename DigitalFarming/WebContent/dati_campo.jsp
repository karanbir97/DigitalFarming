<script type="text/javascript">
		function Modifica() {
  			
  				document.getElementById("coltura").style.display = 'block';
  				document.getElementById("varieta").style.display = 'block';
  				document.getElementById("quantita").style.display = 'block';
  				document.getElementById("data_semina").style.display = 'block';
  				document.getElementById("data_raccolta").style.display = 'block';
  				document.getElementById("dimensione_campo").style.display = 'block';
  				document.getElementById("annulla").style.display = 'block'; 
  				document.getElementById("salva").style.display = 'block'; 
  				document.getElementById("elimina").style.display = 'block'; 
  				
  				document.getElementById("c").style.display = 'none';   
  	  			document.getElementById("v").style.display = 'none'; 	
	  	  		document.getElementById("q").style.display = 'none'; 
	  	  		document.getElementById("ds").style.display = 'none'; 
	  	  		document.getElementById("dr").style.display = 'none'; 
	  			document.getElementById("dc").style.display = 'none'; 
	  			document.getElementById("modifica").style.display = 'none'; 
		}
		function Annulla() {
			document.getElementById("coltura").style.display = 'none';
			document.getElementById("varieta").style.display = 'none';
			document.getElementById("quantita").style.display = 'none';
			document.getElementById("data_semina").style.display = 'none';
			document.getElementById("data_raccolta").style.display = 'none';
			document.getElementById("dimensione_campo").style.display = 'none';
	  		document.getElementById("c").style.display = 'block';  
	  		document.getElementById("v").style.display = 'block'; 	
  	  		document.getElementById("q").style.display = 'block'; 
  	  		document.getElementById("ds").style.display = 'block'; 
  	  		document.getElementById("dr").style.display = 'block'; 
  			document.getElementById("dc").style.display = 'block'; 
  			document.getElementById("modifica").style.display = 'block'; 
  			document.getElementById("annulla").style.display = 'none'; 
  			document.getElementById("salva").style.display = 'none';
  			document.getElementById("elimina").style.display = 'none'; 
	}
</script>

<div class="right">
	<form action="salva_dato_c.jsp" method="get">
	<input type="hidden" id="idcat" name="idcat" value="<%=idProdotto%>">
	<p class="nomeProdotto"><%=nomeProdotto %></p>
	<p class="categoriaProdotto"><%=categoriaProdotto %></p>
	<p class="prezzoProdotto" >Coltura : <b id="c"><%=coltura  %> </b> <input style="display:none" type="text" id="coltura" name="coltura" value="<%=coltura %>"></p>
	<p class="prezzoProdotto" >Varieta : <b id="v"><%=varieta %></b> <input style="display:none" type="text" id="varieta" name="varieta" value="<%=varieta %>"></p>
	<p class="prezzoProdotto" >Quantita' : <b id="q"><%=quantita %></b> <input style="display:none" type="text" id="quantita" name="quantita" value="<%=quantita %>"></p>
	<p class="prezzoProdotto" >Data Semina:<b id="ds"><%=data_semina %></b> <input style="display:none" type="text" id="data_semina" name="data_semina" value="<%=data_semina %>"> </p>
	<p class="prezzoProdotto" >Data raccolta prevista: <b id="dr"><%=data_raccolta %></b> <input style="display:none" type="text" id="data_raccolta" name="data_raccolta" value="<%=data_raccolta %>"></p>
	<p class="prezzoProdotto" >Dimensione campo: <b id="dc"><%=dimensione_campo %></b> <input style="display:none" type="text" id="dimensione_campo" name="dimensione_campo" value="<%=dimensione_campo %>"></p>
	
	<input type="submit" id="salva" style="display:none" class='userButtonAggiungiAlCarrello' value="Salva dati">	
</form>
	<br/>
	<form action="error.jsp" method="get">
	<input type="hidden" id="idcat" name="idcat" value="<%= idProdotto%>">
	<input type="hidden" id="nome" name="nome" value="<%=nomeProdotto %>">
	<input type="hidden" id="categoria" name="categoria" value="<%=categoriaProdotto %>">
	<input type="hidden" id="coltura" name="coltura" value="<%=coltura %>">
	<input type="hidden" id="varieta" name="varieta" value="<%= varieta%>">
	<input type="hidden" id="quantita" name="quantita" value="<%= quantita%>">
	<input type="hidden" id="data_semina" name="data_semina" value="<%= data_semina%>">
	<input type="hidden" id="data_raccolta" name="data_raccolta" value="<%= data_raccolta%>">
	<input type="hidden" id="dimensione_campo" name="dimensione_campo" value="<%= dimensione_campo%>">
	
	<input type="submit" id="elimina" name="elimina" style="display:none" class='userButtonAggiungiAlCarrello' value="Elimina prodotto">		
	
	</form>
	
	<button id="modifica" class='userButtonAggiungiAlCarrello' onclick="Modifica()">Modifica prodotto</button>
	<p><button id="annulla" style="display:none" class='userButtonAggiungiAlCarrello' onclick="Annulla()">Annulla modifica</button>	</p>
	
	
	
</div>