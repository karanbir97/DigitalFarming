$(document).ready(function(){
	$('#aliquoteTable').DataTable( {
        "order": [[ 0, "desc" ]],
        "language": {
			    "sEmptyTable":     "Nessuna Aliquota Presente",
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
	
	$(document).on('click', '#buttonAggiungiAliquota', function(e){
		
		if($("#formAggiungiAliquota").css("display") == "block"){
			$("#formAggiungiAliquota").html("");
			$("#formAggiungiAliquota").css("display", "none");
		}
		else{
			$("#loader").show();
			
			$.ajax({
				url: absolutePath+"/GetFormAggiungiAliquota",
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
						$("#formAggiungiAliquota").html(msg.contenuto);
						$("#formAggiungiAliquota").css("display", "block");
					}
				},
				error: function(msg){
					showAlert(1, "Impossibile Recuperare i dati.");
				}
			});
			
			$("#loader").hide();			
		}
	});	
	
	$(document).on('click', '#confirmAggiungiAliquota', function(e){		
		var nomeAliquota = $("#nomeAliquota").val();
		var valoreAliquota = $("#valoreAliquota").val();
		
		if(nomeAliquota != undefined && nomeAliquota.length > 1 && valoreAliquota != undefined && valoreAliquota > 0 && valoreAliquota <= 100){		
			$("#loader").show();			
			$.ajax({
				url: absolutePath+"/AggiungiAliquota",
				type: "POST",
				dataType: 'JSON',
				async: false,
				data: {
					"nomeAliquota": nomeAliquota,
					"valoreAliquota": valoreAliquota
				},
				success:function(msg){
					if(!msg.risultato){
						showAlert(1, msg.errore);
					}
					else{
						showAlert(0, msg.contenuto);
						$("#formAggiungiAliquota").html("");
						$("#formAggiungiAliquota").css("display", "none");
						getAliquote();
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
		
	
	$(document).on('click', '.eliminaAliquota', function(e){		
		var idAliquota = $(this).data("idaliquota");
		
		if(idAliquota != undefined && idAliquota > 0){		
			if(confirm("Conferma la cancellazione dell'aliquota selezionata?")){
				$("#loader").show();			
				$.ajax({
					url: absolutePath+"/EliminaAliquota",
					type: "POST",
					dataType: 'JSON',
					async: false,
					data: {
						"idAliquota": idAliquota
					},
					success:function(msg){
						if(!msg.risultato){
							showAlert(1, msg.errore);
						}
						else{
							showAlert(0, msg.contenuto);
							getAliquote();
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

function getAliquote(){
	$("#loader").show();

	$.ajax({
		url: absolutePath+"/GetAliquote",
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
					$("#bodyAliquote").html(msg.contenuto);
				}											
				else{
					$("#bodyAliquote").html("<tr><td colspan='3'>Nessuna Aliquota Presente</td></tr>");
				}
				
			}
		},
		error: function(msg){
			showAlert(1, "Impossibile Recuperare i dati.");
		}
	});
	
	$("#loader").hide();	
	
}
