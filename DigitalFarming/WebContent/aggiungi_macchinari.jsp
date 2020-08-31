<div class="right">
	<form action="error.jsp" method="get">
	<p class="nomeProdotto">Aggiungi macchinari</p>
	<p class="prezzoProdotto" >Tipo : <input  class="w3-input w3-border w3-round" type="text" id="tipo" name="tipo" required></p>
	<p class="prezzoProdotto" >Targa : <input  type="text" id="targa" name="targa" required></p>
	<p class="prezzoProdotto" >Ultima revisione:<input  type="date" id="revisione" name="revisione" required> </p>
	<p class="prezzoProdotto" >Data immatricolazione: <input type="date" id="immatricolazione" name="immatricolazione" required></p>
	<p class="prezzoProdotto" >Capacita: <input  type="text" id="capacita" name="capacita" required></p>
	
	
	<br/>
	
	<input type="hidden" id="idcat" name="idcat" value="<%= idProdotto%>">
	<input type="hidden" id="nome" name="nome" value="<%=nomeProdotto %>">
	<input type="hidden" id="categoria" name="categoria" value="<%=categoriaProdotto %>">
	<input type="hidden" id="descrizione" name="descrizione" value="<%=descrizione %>">
	<input type="hidden" id="sesso" name="sesso" value="<%= sesso%>">
	<input type="hidden" id="data" name="data" value="<%= data%>">
	<input type="hidden" id="peso" name="peso" value="<%= quantitaProdotto%>">
	<input type="hidden" id="produzione" name="produzione" value="<%= produzione%>">
	<input type="hidden" id="controllo" name="controllo" value="<%= controllo%>">
	
	<input type="submit" id="inserisci" name="inserisci"  class='userButtonAggiungiAlCarrello' value="Inserisci macchinari">		
	
	</form>
	
	
</div>