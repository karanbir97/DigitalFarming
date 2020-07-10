$(document).ready(function(){	
	$('#immaginiTable').DataTable( {
        "order": [[ 0, "desc" ]],
        "language": {
			    "sEmptyTable":     "Nessuna Immagine Presente",
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
	
	$(document).on('click', '#buttonAggiungiImmagine', function(e){
		
		if($("#formAggiungiImmagine").css("display") == "block"){
			$("#formAggiungiImmagine").html("");
			$("#formAggiungiImmagine").css("display", "none");
		}
		else{
			$("#loader").show();
			
			$.ajax({
				url: absolutePath+"/GetFormAggiungiImmagine",
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
						$("#formAggiungiImmagine").html(msg.contenuto);
						$("#formAggiungiImmagine").css("display", "block");
					}
				},
				error: function(msg){
					//showAlert(1, "Impossibile Recuperare i dati.");
				}
			});
			
			$("#loader").hide();			
		}
	});	
	
	$(document).on('click', '#confirmAggiungiImmagine', function(e){		
		var filenameImmagineProdotto = $("#filenameImmagineProdotto").val();
		var defaultImmagine = $("#defaultImmagine").is(":checked");		
		var idProdotto = $("#idProdottoImmagine").val();
		if(idProdotto != undefined && idProdotto > 0){
			if(filenameImmagineProdotto != undefined && filenameImmagineProdotto.length > 5 && defaultImmagine != undefined){
				if(defaultImmagine){
					defaultImmagine = 1;
				}
				else{
					defaultImmagine = 0;
				}
				$("#loader").show();			
				$.ajax({
					url: absolutePath+"/AggiungiImmagine",
					type: "POST",
					dataType: 'JSON',
					async: false,
					data: {
						"filenameImmagineProdotto": filenameImmagineProdotto,
						"defaultImmagine": defaultImmagine,
						"idProdotto": idProdotto		
					},
					success:function(msg){
						if(!msg.risultato){
							showAlert(1, msg.errore);
						}
						else{
							showAlert(0, msg.contenuto);
							$("#formAggiungiImmagine").html("");
							$("#formAggiungiImmagine").css("display", "none");
							getImmagini();
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
		}
		else{
			showAlert(1, "Errore Parametri.");
		}
	});	
		
	
	$(document).on('click', '.eliminaImmagine', function(e){		
		var idImmagine = $(this).data("idimmagine");
		
		if(idImmagine != undefined && idImmagine > 0){		
			if(confirm("Conferma la cancellazione dell'immagine selezionata?")){
				$("#loader").show();			
				$.ajax({
					url: absolutePath+"/EliminaImmagine",
					type: "POST",
					dataType: 'JSON',
					async: false,
					data: {
						"idImmagine": idImmagine
					},
					success:function(msg){
						if(!msg.risultato){
							showAlert(1, msg.errore);
						}
						else{
							showAlert(0, msg.contenuto);
							getImmagini();
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

function getImmagini(){
	var idProdotto = $("#idProdottoImmagine").val();
	if(idProdotto != undefined && idProdotto > 0){
		$("#loader").show();
		
		$.ajax({
			url: absolutePath+"/GetImmagini",
			type: "POST",
			dataType: 'JSON',
			async: false,
			data: {
				"idProdotto": idProdotto,
				"richiesta": 1
			},
			success:function(msg){
				if(!msg.risultato){
					showAlert(1, msg.errore);
				}
				else{				
					if(msg.contenuto.length > 0){
						$("#bodyImmagini").html(msg.contenuto);
					}											
					else{
						$("#bodyImmagini").html("<tr><td colspan='3'>Nessuna Immagine Presente</td></tr>");
					}
					
				}
			},
			error: function(msg){
				//showAlert(1, "Impossibile Recuperare i dati.");
			}
		});
		
		$("#loader").hide();	
		
	}
	else{
		showAlert(1, "Errore Parametri.");
	}
	
}


function createDropzone(){	
	var idProdotto = $("#idProdottoImmagine").val();
	if(idProdotto != undefined && idProdotto > 0){
		$(".dropzoneImmagineProdotto").dropzone({
			  maxFiles: 1,
			  acceptedFiles: ".jpeg,.jpg,.png",
			  accept: function(file, done){					    
			    done();
			  },
			  init: function() {			      				      						  		    
			      this.on("maxfilesexceeded", function(file){
				  	  showAlert(1, "Allegare al massimo un file");		    	  
			      });
			    					    
				  this.on("success", function(file, response) {
					  var msg = jQuery.parseJSON(response);
				  	  if(msg.risultato){
				  		  $("#filenameImmagineProdotto").val(msg.contenuto);
				  	  }    
				  	  else{			  		  			  		 
				  		showAlert(1, msg.errore);
				  	  }	            		            	
				  });	        
				  
				  this.on("sending", function(file, xhr, formData) {
			        formData.append("idProdotto", idProdotto);
			      });				  
			  }		  						
		});		
	}
	else{
		showAlert(1, "Errore Parametri.");
	}		
}