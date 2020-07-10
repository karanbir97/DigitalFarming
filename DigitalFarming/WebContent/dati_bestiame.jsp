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
	
	<input type="submit" id="salva" style="display:none" class='userButtonAggiungiAlCarrello' value="Salva dati">	
</form>
	<button id="modifica" class='userButtonAggiungiAlCarrello' onclick="Modifica()">Modifica prodotto</button>
	<p><button id="annulla" style="display:none" class='userButtonAggiungiAlCarrello' onclick="Annulla()">Annulla modifica</button>	</p>
	
	
	
</div>