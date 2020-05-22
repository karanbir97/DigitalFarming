$(document).ready(function(){
	$('#vettoriTable').DataTable( {
        "order": [[ 0, "desc" ]],
        "language": {
			    "sEmptyTable":     "Nessun Vettore Presente",
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
	
	$(document).on('click', '#buttonAggiungivettore', function(e){
		
		if($("#formAggiungiVettore").css("display") == "block"){
			$("#formAggiungiVettore").html("");
			$("#formAggiungiVettore").css("display", "none");
		}
		else{
			$("#loader").show();
			
			$.ajax({
				url: absolutePath+"/GetFormAggiungiVettore",
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
						$("#formAggiungiVettore").html(msg.contenuto);
						$("#formAggiungiVettore").css("display", "block");
					}
				},
				error: function(msg){
					showAlert(1, "Impossibile Recuperare i dati.");
				}
			});
			
			$("#loader").hide();			
		}
	});	
	
	$(document).on('click', '#confirmAggiungivettore', function(e){		
		var nomevettore = $("#nomeVettore").val();
		var descrizionevettore = $("#descrizioneVettore").val();
		var costovettore = $("#costoVettore").val();
		var contrassegnovettore = $("#contrassegnoVettore").val();

		if(nomevettore != undefined && nomevettore.length > 1 
			&& descrizionevettore != undefined && descrizionevettore.length > 1 
			&& contrassegnovettore != undefined && contrassegnovettore >= 0 && contrassegnovettore <= 1 
			&& costovettore != undefined && costovettore.length >= 0){		
			$("#loader").show();			
			$.ajax({
				url: absolutePath+"/AggiungiVettori",
				type: "POST",
				dataType: 'JSON',
				async: false,
				data: {
					"nomeVettore": nomevettore,
					"descrizioneVettore": descrizionevettore,
					"costoVettore": costovettore,
					"contrassegnoVettore": contrassegnovettore,
				},
				success:function(msg){
					if(!msg.risultato){
						showAlert(1, msg.errore);
					}
					else{
						showAlert(0, msg.contenuto);
						$("#formAggiungiVettore").html("");
						$("#formAggiungiVettore").css("display", "none");
						getvettori();
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
		
	
	$(document).on('click', '.eliminaVettore', function(e){		
		var idvettore = $(this).data("idvettore");
		
		if(idvettore != undefined && idvettore > 0){		
			if(confirm("Conferma la cancellazione del vettore selezionato?")){
				$("#loader").show();			
				$.ajax({
					url: absolutePath+"/EliminaVettori",
					type: "POST",
					dataType: 'JSON',
					async: false,
					data: {
						"idvettore": idvettore
					},
					success:function(msg){
						if(!msg.risultato){
							showAlert(1, msg.errore);
						}
						else{
							showAlert(0, msg.contenuto);
							getvettori();
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

function getvettori(){
	$("#loader").show();

	$.ajax({
		url: absolutePath+"/GetVettori",
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
					$("#bodyVettori").html(msg.contenuto);
				}											
				else{
					$("#bodyVettori").html("<tr><td colspan='5'>Nessun Vettore Presente</td></tr>");
				}
				
			}
		},
		error: function(msg){
			showAlert(1, "Impossibile Recuperare i dati.");
		}
	});
	
	$("#loader").hide();	
	
}
