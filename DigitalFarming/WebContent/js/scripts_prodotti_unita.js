$(document).ready(function(){
	$('#unitaTable').DataTable( {
        "order": [[ 0, "desc" ]],
        "language": {
			    "sEmptyTable":     "Nessuna Unit&agrave; Presente",
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
	
	$(document).on('click', '#buttonAggiungiUnita', function(e){
		
		if($("#formAggiungiUnita").css("display") == "block"){
			$("#formAggiungiUnita").html("");
			$("#formAggiungiUnita").css("display", "none");
		}
		else{
			$("#loader").show();
			
			$.ajax({
				url: absolutePath+"/GetFormAggiungiUnita",
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
						$("#formAggiungiUnita").html(msg.contenuto);
						$("#formAggiungiUnita").css("display", "block");
					}
				},
				error: function(msg){
					showAlert(1, "Impossibile Recuperare i dati.");
				}
			});
			
			$("#loader").hide();			
		}
	});	
	
	$(document).on('click', '#confirmAggiungiUnita', function(e){		
		var nomeUnita = $("#nomeUnita").val();
		var siglaUnita = $("#siglaUnita").val();
		
		if(nomeUnita != undefined && nomeUnita.length > 1 && siglaUnita != undefined && siglaUnita.length > 1){		
			$("#loader").show();			
			$.ajax({
				url: absolutePath+"/AggiungiUnita",
				type: "POST",
				dataType: 'JSON',
				async: false,
				data: {
					"nomeUnita": nomeUnita,
					"siglaUnita": siglaUnita
				},
				success:function(msg){
					if(!msg.risultato){
						showAlert(1, msg.errore);
					}
					else{
						showAlert(0, msg.contenuto);
						$("#formAggiungiUnita").html("");
						$("#formAggiungiUnita").css("display", "none");
						getUnita();
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
		
	
	$(document).on('click', '.eliminaUnita', function(e){		
		var idUnita = $(this).data("idunita");
		
		if(idUnita != undefined && idUnita > 0){		
			if(confirm("Conferma la cancellazione dell'unità selezionata?")){
				$("#loader").show();			
				$.ajax({
					url: absolutePath+"/EliminaUnita",
					type: "POST",
					dataType: 'JSON',
					async: false,
					data: {
						"idUnita": idUnita
					},
					success:function(msg){
						if(!msg.risultato){
							showAlert(1, msg.errore);
						}
						else{
							showAlert(0, msg.contenuto);
							getUnita();
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

function getUnita(){
	$("#loader").show();

	$.ajax({
		url: absolutePath+"/GetUnita",
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
					$("#bodyUnita").html(msg.contenuto);
				}
				else{
					$("#bodyUnita").html("<tr><td colspan='3'>Nessuna Unit&agrave; Presente</td></tr>");
				}
				
			}
		},
		error: function(msg){
			showAlert(1, "Impossibile Recuperare i dati.");
		}
	});
	
	$("#loader").hide();	
	
}
