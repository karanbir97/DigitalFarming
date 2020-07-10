$(document).ready(function(){
	$('#categorieTable').DataTable( {
        "order": [[ 0, "desc" ]],
        "language": {
			    "sEmptyTable":     "Nessuna Categoria Presente",
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
	
	$(document).on('click', '#buttonAggiungiCategoria', function(e){
		
		if($("#formAggiungiCategoria").css("display") == "block"){
			$("#formAggiungiCategoria").html("");
			$("#formAggiungiCategoria").css("display", "none");
		}
		else{		
			$("#loader").show();
			
			$.ajax({
				url: absolutePath+"/GetFormAggiungiCategoria",
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
						$("#formAggiungiCategoria").html(msg.contenuto);
						$("#formAggiungiCategoria").css("display", "block");
					}
				},
				error: function(msg){
					//showAlert(1, "Impossibile Recuperare i dati.");
				}
			});
			
			$("#loader").hide();
		}
	});	
	
	$(document).on('click', '#confirmAggiungiCategoria', function(e){		
		var nomeCategoria = $("#nomeCategoria").val();
		
		if(nomeCategoria != undefined && nomeCategoria.length > 3){		
			$("#loader").show();			
			$.ajax({
				url: absolutePath+"/AggiungiCategoria",
				type: "POST",
				dataType: 'JSON',
				async: false,
				data: {
					"nomeCategoria": nomeCategoria
				},
				success:function(msg){
					if(!msg.risultato){
						showAlert(1, msg.errore);
					}
					else{
						showAlert(0, msg.contenuto);
						$("#formAggiungiCategoria").html("");
						$("#formAggiungiCategoria").css("display", "none");
						getCategorie();
					}
				},
				error: function(msg){
					//showAlert(1, "Impossibile Recuperare i dati.");
				}
			});
			
			$("#loader").hide();
		}
		else{			
			showAlert(1, "Controllare di aver compilato correttamente tutti i campi.");
		}		
	});	
		
	
	$(document).on('click', '.eliminaCategoria', function(e){		
		var idCategoria = $(this).data("idcategoria");
		
		if(idCategoria != undefined && idCategoria > 0){		
			if(confirm("Conferma la cancellazione della categoria selezionata?")){
				$("#loader").show();			
				$.ajax({
					url: absolutePath+"/EliminaCategoria",
					type: "POST",
					dataType: 'JSON',
					async: false,
					data: {
						"idCategoria": idCategoria
					},
					success:function(msg){
						if(!msg.risultato){
							showAlert(1, msg.errore);
						}
						else{
							showAlert(0, msg.contenuto);
							getCategorie();
						}
					},
					error: function(msg){
						//showAlert(1, "Impossibile Recuperare i dati.");
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

function getCategorie(){
	$("#loader").show();

	$.ajax({
		url: absolutePath+"/GetCategorie",
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
					$("#bodyCategorie").html(msg.contenuto);
				}												
				else{
					$("#bodyCategorie").html("<tr><td colspan='2'>Nessuna Categoria Presente</td></tr>");
				}
				
			}
		},
		error: function(msg){
			//showAlert(1, "Impossibile Recuperare i dati.");
		}
	});
	
	$("#loader").hide();	
	
}
