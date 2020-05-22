$(document).ready(function(){
	$('#ordiniTable').DataTable( {
        "order": [[ 0, "desc" ]],
        "language": {
			    "sEmptyTable":     "Nessun Ordine Presente",
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
	
	$(document).on('click', '.eliminaOrdine', function(e){		
		var idOrdine = $(this).data("idordine");
		
		if(idOrdine != undefined && idOrdine > 0){		
			if(confirm("Conferma la cancellazione dell'ordine N."+idOrdine+"?")){
				$("#loader").show();			
				$.ajax({
					url: absolutePath+"/EliminaOrdine",
					type: "POST",
					dataType: 'JSON',
					async: false,
					data: {
						"idOrdine": idOrdine
					},
					success:function(msg){
						if(!msg.risultato){
							showAlert(1, msg.errore);
						}
						else{
							showAlert(0, msg.contenuto);
							getOrdini();
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
		
	$(document).on('click', '.dettaglioOrdine', function(e){		
		var idOrdine = $(this).data("idordine");
		
		if(idOrdine != undefined && idOrdine > 0){		
				$("#loader").show();			
				$.ajax({
					url: absolutePath+"/GetDettaglioOrdineUser",
					type: "POST",
					dataType: 'JSON',
					async: false,
					data: {
						"idOrdine": idOrdine
					},
					success:function(msg){
						if(!msg.risultato){
							showAlert(1, msg.errore);
						}
						else{														
							$("#modalDettaglioOrdineBody").html(msg.contenuto);
							$("#modalDettaglioOrdine").css("display", "block");
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
	
	$(document).on('click', '.chiudiModalDettaglioOrdine', function(e){
		$("#modalDettaglioOrdine").css("display", "none");
	});		

	
	
});

function getOrdini(){
	$("#loader").show();

	$.ajax({
		url: absolutePath+"/GetOrdiniUser",
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
					$("#bodyOrdini").html(msg.contenuto);
				}											
				else{
					$("#bodyOrdini").html("<tr><td colspan='6'>Nessun Ordine Presente</td></tr>");
				}
				
			}
		},
		error: function(msg){
			showAlert(1, "Impossibile Recuperare i dati.");
		}
	});
	
	$("#loader").hide();	
	
}
