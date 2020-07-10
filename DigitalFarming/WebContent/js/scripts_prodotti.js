$(document).ready(function(){
	$('#prodottiTable').DataTable( {
        "order": [[ 0, "desc" ]],
        "language": {
			    "sEmptyTable":     "Nessun Prodotto Presente",
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
	
	$(document).on('click', '#buttonAggiungiProdotto', function(e){
		
		if($("#formAggiungiProdotto").css("display") == "block"){
			$("#formAggiungiProdotto").html("");
			$("#formAggiungiProdotto").css("display", "none");
		}
		else{
			$("#loader").show();
			
			$.ajax({
				url: absolutePath+"/GetFormAggiungiProdotto",
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
						$("#formAggiungiProdotto").html(msg.contenuto);
						$("#formAggiungiProdotto").css("display", "block");
					}
				},
				error: function(msg){
					//showAlert(1, "Impossibile Recuperare i dati.");
				}
			});
			
			$("#loader").hide();			
		}
	});	
	
	$(document).on('click', '#confirmAggiungiProdotto', function(e){		
		var categoriaProdotto = $("#categoriaProdotto").val();
		var nomeProdotto = $("#nomeProdotto").val();
		var descrizioneProdotto = $("#descrizioneProdotto").val();
		var descrizioneAbbreviataProdotto = $("#descrizioneAbbreviataProdotto").val();
		var quantitaProdotto = $("#quantitaProdotto").val();
		var unitaProdotto = $("#unitaProdotto").val();
		var prezzoProdotto = $("#prezzoProdotto").val();
		var aliquotaProdotto = $("#aliquotaProdotto").val();
		
		
		if(categoriaProdotto != undefined && categoriaProdotto > 0 && nomeProdotto != undefined && nomeProdotto.length > 1 && descrizioneProdotto != undefined && descrizioneProdotto.length > 1 && descrizioneAbbreviataProdotto != undefined && quantitaProdotto != undefined && quantitaProdotto >= 0 && unitaProdotto != undefined && unitaProdotto > 0 && prezzoProdotto != undefined && prezzoProdotto > 0 && aliquotaProdotto != undefined && aliquotaProdotto > 0){		
			$("#loader").show();			
			$.ajax({
				url: absolutePath+"/AggiungiProdotto",
				type: "POST",
				dataType: 'JSON',
				async: false,
				data: {
					"categoriaProdotto": categoriaProdotto,
					"nomeProdotto": nomeProdotto,
					"descrizioneProdotto": descrizioneProdotto,
					"descrizioneAbbreviataProdotto": descrizioneAbbreviataProdotto,
					"quantitaProdotto": quantitaProdotto,
					"unitaProdotto": unitaProdotto,
					"prezzoProdotto": prezzoProdotto,
					"aliquotaProdotto": aliquotaProdotto
				},
				success:function(msg){
					if(!msg.risultato){
						showAlert(1, msg.errore);
					}
					else{
						showAlert(0, msg.contenuto);
						$("#formAggiungiProdotto").html("");
						$("#formAggiungiProdotto").css("display", "none");
						getProdotti();
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
		
	
	$(document).on('click', '.eliminaProdotto', function(e){		
		var idProdotto = $(this).data("idprodotto");
		
		if(idProdotto != undefined && idProdotto > 0){		
			if(confirm("Conferma la cancellazione del prodotto con ID "+idProdotto+"? Tutti i relativi sconti attivi e le immagini verranno eliminati.")){
				$("#loader").show();			
				$.ajax({
					url: absolutePath+"/EliminaProdotto",
					type: "POST",
					dataType: 'JSON',
					async: false,
					data: {
						"idProdotto": idProdotto
					},
					success:function(msg){
						if(!msg.risultato){
							showAlert(1, msg.errore);
						}
						else{
							showAlert(0, msg.contenuto);
							getProdotti();
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
	
	$(document).on('click', '.fotoProdotto', function(e){		
		var idProdotto = $(this).data("idprodotto");
		
		if(idProdotto != undefined && idProdotto > 0){		
			window.location.href = 'prodotti_immagini.jsp?idProdotto='+idProdotto;
		}
		else{			
			showAlert(1, "Errore Parametri.");
		}		
	});			
	
	
	$(document).on('click', '.modificaQuantita', function(e){		
		var idProdotto = $(this).data("idprodotto");
		
		if(idProdotto != undefined && idProdotto > 0){		
				$("#loader").show();			
				$.ajax({
					url: absolutePath+"/GetFormModificaQuantitaProdottoAdmin",
					type: "POST",
					dataType: 'JSON',
					async: false,
					data: {
						"idProdotto": idProdotto
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
						//showAlert(1, "Impossibile Recuperare i dati.");
					}
				});
				
				$("#loader").hide();
		}
		else{			
			showAlert(1, "Errore Parametri.");
		}		
	});		

	$(document).on('click', '#confirmAggiungiQuantitaProdotto', function(e){		
		var idProdotto = $("#idProdotto").val();
		var quantitaProdotto = $("#quantitaProdotto").val();				
		if(idProdotto != undefined && idProdotto > 0){
			if(quantitaProdotto != undefined && quantitaProdotto >= 0){
				$("#loader").show();			
				$.ajax({
					url: absolutePath+"/AggiornaQuantitaProdottoAdmin",
					type: "POST",
					dataType: 'JSON',
					async: false,
					data: {
						"idProdotto": idProdotto,
						"quantitaProdotto": quantitaProdotto
					},
					success:function(msg){
						if(!msg.risultato){
							showAlert(1, msg.errore);
						}
						else{														
							$("#modalDettaglioOrdine").css("display", "none");
							getProdotti();
							showAlert(0, msg.contenuto);
						}
					},
					error: function(msg){
						//showAlert(1, "Impossibile Recuperare i dati.");
					}
				});
				
				$("#loader").hide();				
			}	
			else{
				showAlert(1, "Inserire una quantit&agrave; valida.");
			}
		}
		else{			
			showAlert(1, "Errore Parametri.");
		}		
	});		
	
	
	$(document).on('click', '.modificaPrezzo', function(e){		
		var idProdotto = $(this).data("idprodotto");
		
		if(idProdotto != undefined && idProdotto > 0){		
				$("#loader").show();			
				$.ajax({
					url: absolutePath+"/GetFormModificaPrezzoProdottoAdmin",
					type: "POST",
					dataType: 'JSON',
					async: false,
					data: {
						"idProdotto": idProdotto
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
						//showAlert(1, "Impossibile Recuperare i dati.");
					}
				});
				
				$("#loader").hide();
		}
		else{			
			showAlert(1, "Errore Parametri.");
		}		
	});		

	$(document).on('click', '#confirmAggiungiPrezzoProdotto', function(e){		
		var idProdotto = $("#idProdotto").val();
		var prezzoProdotto = $("#prezzoProdotto").val();				
		if(idProdotto != undefined && idProdotto > 0){
			if(prezzoProdotto != undefined && prezzoProdotto > 0){
				
				$("#loader").show();			
				$.ajax({
					url: absolutePath+"/AggiornaPrezzoProdottoAdmin",
					type: "POST",
					dataType: 'JSON',
					async: false,
					data: {
						"idProdotto": idProdotto,
						"prezzoProdotto": prezzoProdotto
					},
					success:function(msg){
						if(!msg.risultato){
							showAlert(1, msg.errore);
						}
						else{														
							$("#modalDettaglioOrdine").css("display", "none");
							getProdotti();
							showAlert(0, msg.contenuto);
						}
					},
					error: function(msg){
						//showAlert(1, "Impossibile Recuperare i dati.");
					}
				});
				
				$("#loader").hide();

			}	
			else{
				showAlert(1, "Inserire un prezzo maggiore di 0.");
			}		
		}
		else{			
			showAlert(1, "Errore Parametri.");
		}		
	});		
	
	
	$(document).on('click', '.chiudiModalDettaglioOrdine', function(e){
		$("#modalDettaglioOrdine").css("display", "none");
	});			
});

function getProdotti(){ 
	$("#loader").show();

	$.ajax({
		url: absolutePath+"/GetProdotti",
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
					$("#bodyProdotti").html(msg.contenuto);
				}											
				else{
					$("#bodyProdotti").html("<tr><td colspan='10'>Nessun Prodotto Presente</td></tr>");
				}
				
			}
		},
		error: function(msg){
			//showAlert(1, "Impossibile Recuperare i dati.");
		}
	});
	
	$("#loader").hide();	
	
}
