$(document).ready(function(){
	$('#statiTable').DataTable( {
        "order": [[ 0, "desc" ]],
        "language": {
			    "sEmptyTable":     "Nessun Stato Presente",
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
	
	$(document).on('click', '#buttonAggiungistato', function(e){
		
		if($("#formAggiungiStato").css("display") == "block"){
			$("#formAggiungiStato").html("");
			$("#formAggiungiStato").css("display", "none");
		}
		else{
			$("#loader").show();
			
			$.ajax({
				url: absolutePath+"/GetFormAggiungiStato",
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
						$("#formAggiungiStato").html(msg.contenuto);
						$("#formAggiungiStato").css("display", "block");
					}
				},
				error: function(msg){
					showAlert(1, "Impossibile Recuperare i dati.");
				}
			});
			
			$("#loader").hide();			
		}
	});	
	
	$(document).on('click', '#confirmAggiungistato', function(e){		
		var nomeStato = $("#nomeStato").val();
		var ordineAnnullabileStato = $("#ordineAnnullabileStato").val();
		var primoStato = $("#primoStato").val();		

		if(nomeStato != undefined && nomeStato.length > 1 
			&& ordineAnnullabileStato != undefined && (ordineAnnullabileStato == 0 || ordineAnnullabileStato == 1)		
			&& primoStato != undefined && (primoStato == 1 || primoStato == 0) ){		
			$("#loader").show();			
			$.ajax({
				url: absolutePath+"/AggiungiStati",
				type: "POST",
				dataType: 'JSON',
				async: false,
				data: {
					"nomeStato": nomeStato,
					"ordineAnnullabileStato": ordineAnnullabileStato,
					"primoStato": primoStato,
				},
				success:function(msg){
					if(!msg.risultato){
						showAlert(1, msg.errore);
					}
					else{
						showAlert(0, msg.contenuto);
						$("#formAggiungiStato").html("");
						$("#formAggiungiStato").css("display", "none");
						getstati();
					}
				},
				error: function(msg){
					showAlert(1, "Impossibile Recuperare i dati.");
				}
			});
			
			$("#loader").hide();
		}
		else{			
			showAlert(1, "Controllare di aver compilato correttamente tutti i campi.");
		}		
	});	
		
	
	$(document).on('click', '.eliminaStato', function(e){		
		var idstato = $(this).data("idstato");
		
		if(idstato != undefined && idstato > 0){		
			if(confirm("Conferma la cancellazione dello stato selezionato?")){
				$("#loader").show();			
				$.ajax({
					url: absolutePath+"/EliminaStati",
					type: "POST",
					dataType: 'JSON',
					async: false,
					data: {
						"idstato": idstato
					},
					success:function(msg){
						if(!msg.risultato){
							showAlert(1, msg.errore);
						}
						else{
							showAlert(0, msg.contenuto);
							getstati();
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
	
	
	
	
});

function getstati(){
	$("#loader").show();

	$.ajax({
		url: absolutePath+"/GetStati",
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
					$("#bodyStati").html(msg.contenuto);
				}											
				else{
					$("#bodyStati").html("<tr><td colspan='4'>Nessun Stato Presente</td></tr>");
				}
				
			}
		},
		error: function(msg){
			showAlert(1, "Impossibile Recuperare i dati.");
		}
	});
	
	$("#loader").hide();	
	
}
