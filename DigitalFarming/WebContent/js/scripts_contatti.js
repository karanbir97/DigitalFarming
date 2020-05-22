$(document).ready(function(){
	$('#contattiTable').DataTable( {
        "order": [[ 0, "desc" ]],
        "language": {
			    "sEmptyTable":     "Nessun Contatto Presente",
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
	
	$(document).on('click', '.chiudiModalContatti', function(e){	
		$("#modalContatti").css("display", "none");
		getContatti();
		
	});			
	
	$(document).on('click', '.visualizzaContatto', function(e){		
		var idContatto = $(this).data("idcontatto");
		
		if(idContatto != undefined && idContatto > 0){					
			$("#loader").show();			
			$.ajax({
				url: absolutePath+"/GetContatto",
				type: "POST",
				dataType: 'JSON',
				async: false,
				data: {
					"idContatto": idContatto
				},
				success:function(msg){
					if(!msg.risultato){
						showAlert(1, msg.errore);
					}
					else{
						$("#modalContattiBody").html(msg.contenuto);
						$("#modalContatti").css("display", "block");
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

function getContatti(){ 
	$("#loader").show();

	$.ajax({
		url: absolutePath+"/GetContatti",
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
					$("#bodyContatti").html(msg.contenuto);
				}											
				else{
					$("#bodyContatti").html("<tr><td colspan='4'>Nessun Contatto Presente</td></tr>");
				}
				
			}
		},
		error: function(msg){
			showAlert(1, "Impossibile Recuperare i dati.");
		}
	});
	
	$("#loader").hide();	
	
}
