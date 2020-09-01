<script type="text/javascript">
		function Modifica() {
  			
  				document.getElementById("tipo").style.display = 'block';
  				document.getElementById("targa").style.display = 'block';
  				document.getElementById("revisione").style.display = 'block';
  				document.getElementById("immatricolazione").style.display = 'block';
  				document.getElementById("serbatoio").style.display = 'block';
  				document.getElementById("annulla").style.display = 'block'; 
  				document.getElementById("salva").style.display = 'block'; 
  				document.getElementById("elimina").style.display = 'block'; 
  				
  				document.getElementById("ti").style.display = 'none';   
  	  			document.getElementById("ta").style.display = 'none'; 	
	  	  		document.getElementById("re").style.display = 'none'; 
	  	  		document.getElementById("im").style.display = 'none'; 
	  	  		document.getElementById("se").style.display = 'none'; 
	  			document.getElementById("modifica").style.display = 'none'; 
		}
		function Annulla() {
			document.getElementById("tipo").style.display = 'none';
			document.getElementById("targa").style.display = 'none';
			document.getElementById("revisione").style.display = 'none';
			document.getElementById("immatricolazione").style.display = 'none';
			document.getElementById("serbatoio").style.display = 'none';
			
	  		document.getElementById("ti").style.display = 'block';  
	  		document.getElementById("ta").style.display = 'block'; 	
  	  		document.getElementById("re").style.display = 'block'; 
  	  		document.getElementById("im").style.display = 'block'; 
  	  		document.getElementById("se").style.display = 'block';  
  			document.getElementById("modifica").style.display = 'block'; 
  			document.getElementById("annulla").style.display = 'none'; 
  			document.getElementById("salva").style.display = 'none';
  			document.getElementById("elimina").style.display = 'none'; 
	}
</script>

<div class="right">
	<form action="salva_dato_m.jsp" method="get">
	<input type="hidden" id="idcat" name="idcat" value="<%=idProdotto %>">
	<p class="nomeProdotto"><%=nomeProdotto %></p>
	<p class="categoriaProdotto"><%=categoriaProdotto %></p>
	<p class="prezzoProdotto" >Tipo : <b id="ti"><%=tipo %></b> <input style="display:none" type="text" id="tipo" name="tipo" value="<%=tipo %>"></p>
	<p class="prezzoProdotto" >Targa : <b id="ta"><%=targa %></b> <input style="display:none" type="text" id="targa" name="targa" value="<%=targa %>"></p>
	<p class="prezzoProdotto" >Ultima revisione : <b id="re"><%=revisione %></b> <input style="display:none" type="text" id="revisione" name="revisione" value="<%=revisione %>"></p>
	<p class="prezzoProdotto" >Data immatricolazione:<b id="im"><%=immatricolazione %></b> <input style="display:none" type="text" id="immatricolazione" name="immatricolazione" value="<%=immatricolazione %>"> </p>
	<p class="prezzoProdotto" >Capacita' serbatoio: <b id="se"><%=serbatoio %></b> <input style="display:none" type="text" id="serbatoio" name="serbatoio" value="<%=serbatoio %>"></p>
	
	<input type="submit" id="salva" style="display:none" class='userButtonAggiungiAlCarrello' value="Salva dati">	
</form>
	<br/>
	
	<form action="error.jsp" method="get">
	<input type="hidden" id="idcat" name="idcat" value="<%=idProdotto %>">
	<input type="hidden" id="nome" name="nome" value="<%=nomeProdotto %>">
	<input type="hidden" id="categoria" name="categoria" value="<%=categoriaProdotto %>">
	<input type="hidden" id="tipo" name="tipo" value="<%=tipo %>">
	<input type="hidden" id="targa" name="targa" value="<%= targa%>">
	<input type="hidden" id="revisione" name="revisione" value="<%= revisione%>">
	<input type="hidden" id="immatricolazione" name="immatricolazione" value="<%= immatricolazione%>">
	<input type="hidden" id="serbatoio" name="serbatoio" value="<%= serbatoio%>">
	
	<input type="submit" id="elimina" name="elimina" style="display:none" class='userButtonAggiungiAlCarrello' value="Elimina prodotto">		
	
	</form>
	
	<button id="modifica" class='userButtonAggiungiAlCarrello' onclick="Modifica()">Modifica prodotto</button>
	<p><button id="annulla" style="display:none" class='userButtonAggiungiAlCarrello' onclick="Annulla()">Annulla modifica</button>	</p>
	
	
	
</div>