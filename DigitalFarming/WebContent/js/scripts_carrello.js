$(document).ready(function(){
	$('#carrelloTable').DataTable( {
        "order": [[ 0, "desc" ]],
        "language": {
			    "sEmptyTable":     "Nessun Prodotto Presente",
			    "sInfo":           "Vista da _START_ a _END_ di _TOTAL_ elementi",
			    "sInfoEmpty":      "Vista da 0 a 0 di 0 elementi",
			    "sInfoFiltered":   "(filtrati da _MAX_ elementi totali)",
			    "sInfoPostFix":    "",
			    "sInfoThousands":  ".",
			    "sLengthMenu":     "Visualizza _MENU_ elementi",
			    "sLoadingRecords": "Caricamento...",
			    "sProcessing":     "Elaborazione...",
			    "sSearch":         "Cerca:",
			    "sZeroRecords":    "La ricerca non ha portato alcun risultato.",
			    "oPaginate": {
			        "sFirst":      "Inizio",
			        "sPrevious":   "Precedente",
			        "sNext":       "Successivo",
			        "sLast":       "Fine"
			    },
			    "oAria": {
			        "sSortAscending":  ": attiva per ordinare la colonna in ordine crescente",
			        "sSortDescending": ": attiva per ordinare la colonna in ordine decrescente"
			    }
        }        
    } );

	$(document).on('click', '.userButtonCheckout', function(e){ //Click su bottone vai al checkout
		var href = $(this).data("href");
		if(href != undefined && href.length > 1){
			window.location.href = href;
		}		
	});
	
	$(document).on('click', '.eliminaProdottoCarrello', function(e){		
		var idProdotto = $(this).data("idprodotto");
		
		if(idProdotto != undefined && idProdotto > 0){		
			if(confirm("Conferma la cancellazione dal carrello del prodotto selezionato?")){
				$("#loader").show();			
				$.ajax({
					url: absolutePath+"/EliminaDalCarrello",
					type: "POST",
					dataType: 'JSON',
					async: false,
					data: {
						"idProdotto": idProdotto
					},
					success:function(msg){
						if(!msg.risultato){
							showAlert(1, msg.errore);
						}
						else{
							showAlert(0, msg.contenuto);
							getCarrello();							
						}
					},
					error: function(msg){
						showAlert(1, "Impossibile Recuperare i dati.");
					}
				});
				
				$("#loader").hide();
			}
		}
		else{			
			showAlert(1, "Errore Parametri.");
		}		
	});
	

	$(document).on('click', '.aggiungiQuantitaProdottoCarrello, .rimuoviQuantitaProdottoCarrello', function(e){		
		var mux = null;
		if($(this).hasClass("aggiungiQuantitaProdottoCarrello")){
			mux = 1;
		}
		else if($(this).hasClass("rimuoviQuantitaProdottoCarrello")){
			mux = -1;
		}
		
		var idProdotto = $(this).data("idprodotto");		
		if(idProdotto != undefined && idProdotto > 0){		
			$("#loader").show();			
			$.ajax({
				url: absolutePath+"/ModificaDalCarrello",
				type: "POST",
				dataType: 'JSON',
				async: false,
				data: {
					"idProdotto": idProdotto,
					"mux": mux
				},
				success:function(msg){
					if(!msg.risultato){
						showAlert(1, msg.errore);
					}
					else{
						showAlert(0, msg.contenuto);
						getCarrello();
						getCarrelloSmall();
					}
				},
				error: function(msg){
					showAlert(1, "Impossibile Recuperare i dati.");
				}
			});
			
			$("#loader").hide();
		}
		else{			
			showAlert(1, "Errore Parametri.");
		}		
	});	
	
});

function getCarrello(){ 
	$("#loader").show();

	$.ajax({
		url: absolutePath+"/GetCarrello",
		type: "POST",
		dataType: 'JSON',
		async: false,
		data: {
			"richiesta": 1
		},
		success:function(msg){
			if(!msg.risultato){
				showAlert(1, msg.errore);
			}
			else{				
				if(msg.contenuto.length > 0){
					$("#bodyCarrello").html(msg.contenuto);
					$(".userButtonCheckout").css("display", "block");
				}											
				else{
					$("#bodyCarrello").html("<tr><td colspan='10'>Nessun Prodotto Presente</td></tr>");
					$(".userButtonCheckout").css("display", "none");
				}
				
			}
		},
		error: function(msg){
			showAlert(1, "Impossibile Recuperare i dati.");
		}
	});
	
	$("#loader").hide();	
	
}
