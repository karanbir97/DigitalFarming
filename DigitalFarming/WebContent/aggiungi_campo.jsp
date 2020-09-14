<div class="right">
	<form action="error.jsp" method="get">
	<p class="nomeProdotto">Aggiungi campo</p>
	<p class="prezzoProdotto" >Coltura : <input  class="w3-input w3-border w3-round" type="text" id="coltura" name="coltura" required></p>
	<p class="prezzoProdotto" >Varieta : <input  type="text" id="varieta" name="varieta" required></p>
	<p class="prezzoProdotto" >Quantita:<input  type="text" id="quantita" name="quantita" required> </p>
	<p class="prezzoProdotto" >Data semina: <input type="date" id="semina" name="semina" required></p>
	<p class="prezzoProdotto" >Data raccolta prevista: <input type="date" id="raccolta" name="raccolta" required></p>
	<p class="prezzoProdotto" >Dimensione campo: <input  type="text" id="campo" name="campo" required></p>
	
	
	<br/>
	
	<input type="hidden" id="coltura" name="coltura" value="<%=coltura %>">
	<input type="hidden" id="varieta" name="varieta" value="<%=varieta %>">
	<input type="hidden" id="quantita" name="quantita" value="<%=quantita %>">
	<input type="hidden" id="semina" name="semina" value="<%=data_semina %>">
	<input type="hidden" id="raccolta" name="raccolta" value="<%=data_raccolta %>">
	<input type="hidden" id="campo" name="campo" value="<%=dimensione_campo %>">
	<input type="hidden" id="idcat" name="idcat" value="<%=idProdotto %>">
	
	<input type="submit" id="inserisci" name="inserisci"  class='userButtonAggiungiAlCarrello' value="Inserisci macchinari">		
	
	</form>
	
	
</div>