<script type="text/javascript">
		function Modifica() {
  			
  				document.getElementById("descrizione").style.display = 'block';
  				document.getElementById("sesso").style.display = 'block';
  				document.getElementById("data").style.display = 'block';
  				document.getElementById("peso").style.display = 'block';
  				document.getElementById("produzione").style.display = 'block';
  				document.getElementById("controllo").style.display = 'block';
  				document.getElementById("annulla").style.display = 'block'; 
  				document.getElementById("salva").style.display = 'block'; 
  				document.getElementById("elimina").style.display = 'block'; 
  				document.getElementById("desc").style.display = 'none';   
  	  			document.getElementById("sex").style.display = 'none'; 	
	  	  		document.getElementById("date").style.display = 'none'; 
	  	  		document.getElementById("kg").style.display = 'none'; 
	  	  		document.getElementById("prod").style.display = 'none'; 
	  			document.getElementById("control").style.display = 'none'; 
	  			document.getElementById("modifica").style.display = 'none'; 
		}
		function Annulla() {
			document.getElementById("descrizione").style.display = 'none';
			document.getElementById("sesso").style.display = 'none';
			document.getElementById("data").style.display = 'none';
			document.getElementById("peso").style.display = 'none';
			document.getElementById("produzione").style.display = 'none';
			document.getElementById("controllo").style.display = 'none';
	  		document.getElementById("desc").style.display = 'block';  
	  		document.getElementById("sex").style.display = 'block'; 	
  	  		document.getElementById("date").style.display = 'block'; 
  	  		document.getElementById("kg").style.display = 'block'; 
  	  		document.getElementById("prod").style.display = 'block'; 
  			document.getElementById("control").style.display = 'block'; 
  			document.getElementById("modifica").style.display = 'block'; 
  			document.getElementById("annulla").style.display = 'none'; 
  			document.getElementById("salva").style.display = 'none';
  			document.getElementById("elimina").style.display = 'none'; 
	}
</script>		

<div class="right">
	<form action="salva_dato.jsp" method="get">
	<input type="hidden" id="idcat" name="idcat" value="<%= idProdotto%>">
	<p class="nomeProdotto"><%=nomeProdotto %></p>
	<p class="categoriaProdotto"><%=categoriaProdotto %></p>
	<p class="prezzoProdotto" >Razza : <b id="desc"><%=descrizione %></b> <input style="display:none" type="text" id="descrizione" name="descrizione" value="<%=descrizione %>"></p>
	<p class="prezzoProdotto" >Sesso : <b id="sex"><%=sesso %></b> <input style="display:none" type="text" id="sesso" name="sesso" value="<%=sesso %>"></p>
	<p class="prezzoProdotto" >Data : <b id="date"><%=data %></b> <input style="display:none" type="text" id="data" name="data" value="<%=data %>"></p>
	<p class="prezzoProdotto" >Peso animale:<b id="kg"><%=quantitaProdotto %></b> <input style="display:none" type="text" id="peso" name="peso" value="<%=quantitaProdotto %>"> Kg </p>
	<p class="prezzoProdotto" >Produzione: <b id="prod"><%=produzione %></b> <input style="display:none" type="text" id="produzione" name="produzione" value="<%=produzione %>"></p>
	<p class="prezzoProdotto" >Controllo: <b id="control"><%=controllo %> </b><input style="display:none" type="text" id="controllo" name="controllo" value="<%=controllo %>"></p>
	
	<input type="submit" id="salva" name="salva" style="display:none" class='userButtonAggiungiAlCarrello' value="Salva dati">
	</form>
	<br/>
	<form action="error.jsp" method="get">
	<input type="hidden" id="idcat" name="idcat" value="<%= idProdotto%>">
	<input type="hidden" id="nome" name="nome" value="<%=nomeProdotto %>">
	<input type="hidden" id="categoria" name="categoria" value="<%=categoriaProdotto %>">
	<input type="hidden" id="descrizione" name="descrizione" value="<%=descrizione %>">
	<input type="hidden" id="sesso" name="sesso" value="<%= sesso%>">
	<input type="hidden" id="data" name="data" value="<%= data%>">
	<input type="hidden" id="peso" name="peso" value="<%= quantitaProdotto%>">
	<input type="hidden" id="produzione" name="produzione" value="<%= produzione%>">
	<input type="hidden" id="controllo" name="controllo" value="<%= controllo%>">
	
	<input type="submit" id="elimina" name="elimina" style="display:none" class='userButtonAggiungiAlCarrello' value="Elimina prodotto">		
	
	</form>
	
	<button id="modifica" class='userButtonAggiungiAlCarrello' onclick="Modifica()">Modifica prodotto</button>
	<p><button id="annulla" style="display:none" class='userButtonAggiungiAlCarrello' onclick="Annulla()">Annulla modifica</button>	</p>
	
	
	
</div>