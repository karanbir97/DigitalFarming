<div class="right">
	<form action="error.jsp" method="get">
	<p class="nomeProdotto">Aggiungi macchinari</p>
	<p class="prezzoProdotto" >Tipo : <input  class="w3-input w3-border w3-round" type="text" id="tipo" name="tipo" required></p>
	<p class="prezzoProdotto" >Targa : <input  type="text" id="targa" name="targa" required></p>
	<p class="prezzoProdotto" >Ultima revisione:<input  type="date" id="revisione" name="revisione" required> </p>
	<p class="prezzoProdotto" >Data immatricolazione: <input type="date" id="immatricolazione" name="immatricolazione" required></p>
	<p class="prezzoProdotto" >Capacita: <input  type="text" id="capacita" name="capacita" required></p>
	
	
	<br/>
	
	<input type="hidden" id="tipo" name="tipo" value="<%=tipo %>">
	<input type="hidden" id="targa" name="targa" value="<%=targa %>">
	<input type="hidden" id="revisione" name="revisione" value="<%=revisione %>">
	<input type="hidden" id="immatricolazione" name="immatricolazione" value="<%=immatricolazione %>">
	<input type="hidden" id="capacita" name="capacita" value="<%=serbatoio %>">
	<input type="hidden" id="idcat" name="idcat" value="<%=idProdotto %>">
	
	<input type="submit" id="inserisci" name="inserisci"  class='userButtonAggiungiAlCarrello' value="Inserisci macchinari">		
	
	</form>
	
	
</div>