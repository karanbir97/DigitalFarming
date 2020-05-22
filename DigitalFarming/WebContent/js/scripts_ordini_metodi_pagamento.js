$(document).ready(function(){
	$('#metodiPagamentoTable').DataTable( {
        "order": [[ 0, "desc" ]],
        "language": {
			    "sEmptyTable":     "Nessuna metodoPagamento Presente",
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
	
	$(document).on('click', '#buttonAggiungimetodoPagamento', function(e){
		
		if($("#formAggiungimetodoPagamento").css("display") == "block"){
			$("#formAggiungimetodoPagamento").html("");
			$("#formAggiungimetodoPagamento").css("display", "none");
		}
		else{
			$("#loader").show();
			
			$.ajax({
				url: absolutePath+"/GetFormAggiungimetodoPagamento",
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
						$("#formAggiungimetodoPagamento").html(msg.contenuto);
						$("#formAggiungimetodoPagamento").css("display", "block");
					}
				},
				error: function(msg){
					showAlert(1, "Impossibile Recuperare i dati.");
				}
			});
			
			$("#loader").hide();			
		}
	});	
	
	$(document).on('click', '#confirmAggiungimetodoPagamento', function(e){		
		var nomemetodoPagamento = $("#nomemetodoPagamento").val();
		var descrizionemetodoPagamento = $("#descrizionemetodoPagamento").val();
		var inContanti = $("#inContanti").val();

		console.log(nomemetodoPagamento+" "+descrizionemetodoPagamento+" "+inContanti);
		if(nomemetodoPagamento != undefined && nomemetodoPagamento.length > 1 && descrizionemetodoPagamento != undefined && descrizionemetodoPagamento.length > 1 && inContanti != undefined && inContanti >= 0 && inContanti <= 1){		
			$("#loader").show();			
			$.ajax({
				url: absolutePath+"/AggiungiMetodiPagamento",
				type: "POST",
				dataType: 'JSON',
				async: false,
				data: {
					"nomemetodoPagamento": nomemetodoPagamento,
					"descrizionemetodoPagamento": descrizionemetodoPagamento,
					"inContanti": inContanti
				},
				success:function(msg){
					if(!msg.risultato){
						showAlert(1, msg.errore);
					}
					else{
						showAlert(0, msg.contenuto);
						$("#formAggiungimetodoPagamento").html("");
						$("#formAggiungimetodoPagamento").css("display", "none");
						getmetodiPagamento();
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
		
	
	$(document).on('click', '.eliminametodoPagamento', function(e){		
		var idmetodoPagamento = $(this).data("idmetodopagamento");
		
		if(idmetodoPagamento != undefined && idmetodoPagamento > 0){		
			if(confirm("Conferma la cancellazione del metodo di pagamento selezionato?")){
				$("#loader").show();			
				$.ajax({
					url: absolutePath+"/EliminaMetodiPagamento",
					type: "POST",
					dataType: 'JSON',
					async: false,
					data: {
						"idmetodoPagamento": idmetodoPagamento
					},
					success:function(msg){
						if(!msg.risultato){
							showAlert(1, msg.errore);
						}
						else{
							showAlert(0, msg.contenuto);
							getmetodiPagamento();
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

function getmetodiPagamento(){
	$("#loader").show();

	$.ajax({
		url: absolutePath+"/GetMetodiPagamento",
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
					$("#bodymetodiPagamento").html(msg.contenuto);
				}											
				else{
					$("#bodymetodiPagamento").html("<tr><td colspan='4'>Nessun metodo di pagamento Presente</td></tr>");
				}
				
			}
		},
		error: function(msg){
			showAlert(1, "Impossibile Recuperare i dati.");
		}
	});
	
	$("#loader").hide();	
	
}
