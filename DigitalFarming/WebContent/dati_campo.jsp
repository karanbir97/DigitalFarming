<div class="right">
	<form action="salva_dato.jsp" method="get">
	<input type="hidden" id="id_cat" value="<%= idProdotto%>">
	<p class="nomeProdotto"><%=nomeProdotto %></p>
	<p class="categoriaProdotto"><%=categoriaProdotto %></p>
	<p class="prezzoProdotto" >Coltura : <b id="coltura"><%=coltura %></b> <input style="display:none" type="text" id="coltura" name="coltura" value="<%=coltura %>"></p>
	<p class="prezzoProdotto" >Varieta : <b id="varieta"><%=varieta %></b> <input style="display:none" type="text" id="varieta" name="varieta" value="<%=varieta %>"></p>
	<p class="prezzoProdotto" >Quantita' : <b id="quantita"><%=quantita %></b> <input style="display:none" type="text" id="quantita" name="quantita" value="<%=quantita %>"></p>
	<p class="prezzoProdotto" >Data Semina:<b id="data_semina"><%=data_semina %></b> <input style="display:none" type="text" id="data_semina" name="data_semina" value="<%=data_semina %>"> </p>
	<p class="prezzoProdotto" >Data raccolta prevista: <b id="data_raccolta"><%=data_raccolta %></b> <input style="display:none" type="text" id="data_raccolta" name="data_raccolta" value="<%=data_raccolta %>"></p>
	<p class="prezzoProdotto" >Dimensione campo: <b id="dimensione_campo"><%=dimensione_campo %></b> <input style="display:none" type="text" id="dimensione_campo" name="dimensione_campo" value="<%=dimensione_campo %>"></p>
	
	<input type="submit" id="salva" style="display:none" class='userButtonAggiungiAlCarrello' value="Salva dati">	
</form>
	<button id="modifica" class='userButtonAggiungiAlCarrello' onclick="Modifica()">Modifica prodotto</button>
	<p><button id="annulla" style="display:none" class='userButtonAggiungiAlCarrello' onclick="Annulla()">Annulla modifica</button>	</p>
	
	
	
</div>