<div class="right">
	<form action="error.jsp" method="get">
	<p class="nomeProdotto">Aggiungi animale</p>
	<p class="prezzoProdotto" >Razza : <input  class="w3-input w3-border w3-round" type="text" id="descrizione" name="descrizione" required></p>
	
	<p class="prezzoProdotto" >Sesso :  <select name="sesso" id="sesso" required>
	<option value="Uomo">Uomo</option>
	<option value="Donna">Donna</option>
	</select>
	<p class="prezzoProdotto" >Data : <input  type="date" id="data" name="data" required></p>
	<p class="prezzoProdotto" >Peso animale:<input  type="text" id="peso" name="peso" required> </p>
	<p class="prezzoProdotto" >Produzione: <input type="text" id="produzione" name="produzione" required></p>
	<p class="prezzoProdotto" >Data ultimo controllo: <input  type="date" id="controllo" name="controllo" required></p>
	
	
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
	
	<input type="submit" id="inserisci" name="inserisci"  class='userButtonAggiungiAlCarrello' value="Inserisci animale">		
	
	</form>
	
	
</div>