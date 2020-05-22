$(document).ready(function(){
	$('#scontiTable').DataTable( {
        "order": [[ 0, "desc" ]],
        "language": {
			    "sEmptyTable":     "Nessuno Sconto Presente",
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
	
	$(document).on('click', '#buttonAggiungiSconto', function(e){
		
		if($("#formAggiungiSconto").css("display") == "block"){
			$("#formAggiungiSconto").html("");
			$("#formAggiungiSconto").css("display", "none");
		}
		else{
			$("#loader").show();
			
			$.ajax({
				url: absolutePath+"/GetFormAggiungiSconto",
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
						$("#formAggiungiSconto").html(msg.contenuto);
						$("#formAggiungiSconto").css("display", "block");
					}
				},
				error: function(msg){
					showAlert(1, "Impossibile Recuperare i dati.");
				}
			});
			
			$("#loader").hide();			
		}
	});	
	
	$(document).on('click', '#confirmAggiungiSconto', function(e){		
		var prodottoSconto = $("#prodottoSconto").val();
		var prezzoSconto = $("#prezzoSconto").val();
		var daSconto = $("#daSconto").val();
		var aSconto = $("#aSconto").val();
		 
		

		if(prodottoSconto != undefined && prodottoSconto > 0 && prezzoSconto != undefined && prezzoSconto > 0 && daSconto != undefined && daSconto.length == 10 && aSconto != undefined && aSconto.length == 10){		
			//console.log("prodottoSconto:"+prodottoSconto+"prezzoSconto:"+prezzoSconto+"daSconto:"+daSconto+"aSconto:"+aSconto);
			$("#loader").show();			
			$.ajax({
				url: absolutePath+"/AggiungiSconto",
				type: "POST",
				dataType: 'JSON',
				async: false,
				data: {
					"prodottoSconto": prodottoSconto,
					"prezzoSconto": prezzoSconto,
					"daSconto": daSconto,
					"aSconto": aSconto
				},
				success:function(msg){
					if(!msg.risultato){
						showAlert(1, msg.errore);
					}
					else{
						showAlert(0, msg.contenuto);
						$("#formAggiungiSconto").html("");
						$("#formAggiungiSconto").css("display", "none");
						getSconti();
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
		
	
	$(document).on('click', '.eliminaSconto', function(e){		
		var idSconto = $(this).data("idsconto");
		
		if(idSconto != undefined && idSconto > 0){		
			if(confirm("Conferma la cancellazione dello sconto selezionato?")){
				$("#loader").show();			
				$.ajax({
					url: absolutePath+"/EliminaSconto",
					type: "POST",
					dataType: 'JSON',
					async: false,
					data: {
						"idSconto": idSconto
					},
					success:function(msg){
						if(!msg.risultato){
							showAlert(1, msg.errore);
						}
						else{
							showAlert(0, msg.contenuto); 
							getSconti();
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

function getSconti(){
	$("#loader").show();

	$.ajax({
		url: absolutePath+"/GetSconti",
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
					$("#bodySconti").html(msg.contenuto);
				}								
				else{
					$("#bodySconti").html("<tr><td colspan='6'>Nessuno Sconto Presente</td></tr>");
				}
			}
		},
		error: function(msg){
			showAlert(1, "Impossibile Recuperare i dati.");
		}
	});
	
	$("#loader").hide();	
	
}
