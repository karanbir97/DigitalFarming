$(document).ready(function(){
	$('#checkoutTable').DataTable( {
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
	
	
	$(document).on('click', '#userButtonConcludiOrdine', function(e){		
		var fatturazioneCheckout = $("#fatturazioneCheckout").val();
		var spedizioneCheckout = $("#spedizioneCheckout").val();
		var vettoreCheckout = $("#vettoreCheckout").val();
		var metodoPagamentoCheckout = $("#metodoPagamentoCheckout").val();
		var href = $(this).data("href");
		
		if(href != undefined && href.length > 1){
			if(fatturazioneCheckout != undefined && spedizioneCheckout != undefined && vettoreCheckout != undefined && metodoPagamentoCheckout != undefined
			   && fatturazioneCheckout > 0 && spedizioneCheckout > 0 && vettoreCheckout > 0 && metodoPagamentoCheckout > 0){		
				$("#loader").show();			
				$.ajax({
					url: absolutePath+"/AggiungiOrdineTemp",
					type: "POST",
					dataType: 'JSON',
					async: false,
					data: {
						"fatturazioneCheckout": fatturazioneCheckout,
						"spedizioneCheckout": spedizioneCheckout,
						"vettoreCheckout": vettoreCheckout,
						"metodoPagamentoCheckout": metodoPagamentoCheckout
					},
					success:function(msg){
						if(!msg.risultato){
							showAlert(1, msg.errore);
						}
						else{							
							window.location.href = href;
						}
					},
					error: function(msg){
						showAlert(1, "Impossibile Recuperare i dati.");
					}
				});
				
				$("#loader").hide();
			}
			else{			
				showAlert(1, "Verificare di aver selezionato un indirizzo di fatturazione, uno di spedizione, un metodo di pagamento e un vettore.");
			}					
		}
		else{
			showAlert(1, "Errore Parametri.");
		}
	});	
	
	
});