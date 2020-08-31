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
	<form action="salva_dato_m.jsp" method="get">
	<input type="hidden" id="id_cat" value="<%= idProdotto%>">
	<p class="nomeProdotto"><%=nomeProdotto %></p>
	<p class="categoriaProdotto"><%=categoriaProdotto %></p>
	<p class="prezzoProdotto" >Tipo : <b id="desc"><%=descrizione %></b> <input style="display:none" type="text" id="descrizione" name="descrizione" value="<%=descrizione %>"></p>
	<p class="prezzoProdotto" >Targa : <b id="sex"><%=sesso %></b> <input style="display:none" type="text" id="sesso" name="sesso" value="<%=sesso %>"></p>
	<p class="prezzoProdotto" >Ultima revisione : <b id="date"><%=data %></b> <input style="display:none" type="text" id="data" name="data" value="<%=data %>"></p>
	<p class="prezzoProdotto" >Data immatricolazione:<b id="kg"><%=quantitaProdotto %></b> <input style="display:none" type="text" id="peso" name="peso" value="<%=quantitaProdotto %>"> Kg </p>
	<p class="prezzoProdotto" >Capacita' serbatoio: <b id="prod"><%=produzione %></b> <input style="display:none" type="text" id="produzione" name="produzione" value="<%=produzione %>"></p>
	
	<input type="submit" id="salva" style="display:none" class='userButtonAggiungiAlCarrello' value="Salva dati">	
</form>
	<button id="modifica" class='userButtonAggiungiAlCarrello' onclick="Modifica()">Modifica prodotto</button>
	<p><button id="annulla" style="display:none" class='userButtonAggiungiAlCarrello' onclick="Annulla()">Annulla modifica</button>	</p>
	
	
	
</div>