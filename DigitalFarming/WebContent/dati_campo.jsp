<div class="right">
	<form action="salva_dato.jsp" method="get">
	<input type="hidden" id="id_cat" value="<%= idProdotto%>">
	<p class="nomeProdotto"><%=nomeProdotto %></p>
	<p class="categoriaProdotto"><%=categoriaProdotto %></p>
	<p class="prezzoProdotto" >Coltura : <b id="desc"><%=descrizione %></b> <input style="display:none" type="text" id="descrizione" name="descrizione" value="<%=descrizione %>"></p>
	<p class="prezzoProdotto" >Tipo : <b id="sex"><%=sesso %></b> <input style="display:none" type="text" id="sesso" name="sesso" value="<%=sesso %>"></p>
	<p class="prezzoProdotto" >Quantita' : <b id="date"><%=data %></b> <input style="display:none" type="text" id="data" name="data" value="<%=data %>"></p>
	<p class="prezzoProdotto" >Data Semina:<b id="kg"><%=quantitaProdotto %></b> <input style="display:none" type="text" id="peso" name="peso" value="<%=quantitaProdotto %>"> </p>
	<p class="prezzoProdotto" >Data raccolta prevista: <b id="prod"><%=produzione %></b> <input style="display:none" type="text" id="produzione" name="produzione" value="<%=produzione %>"></p>
	<p class="prezzoProdotto" >Dimensione campo: <b id="prod"><%=produzione %></b> <input style="display:none" type="text" id="produzione" name="produzione" value="<%=produzione %>"></p>
	
	<input type="submit" id="salva" style="display:none" class='userButtonAggiungiAlCarrello' value="Salva dati">	
</form>
	<button id="modifica" class='userButtonAggiungiAlCarrello' onclick="Modifica()">Modifica prodotto</button>
	<p><button id="annulla" style="display:none" class='userButtonAggiungiAlCarrello' onclick="Annulla()">Annulla modifica</button>	</p>
	
	
	
</div>