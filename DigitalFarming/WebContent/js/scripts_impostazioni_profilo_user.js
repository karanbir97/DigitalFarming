$(document).ready(function(){

	$(document).on('click', '#confirmAggiungiIndirizzo', function(e){		
		var nomeIndirizzo = $("#nomeIndirizzo").val();
		var cognomeIndirizzo = $("#cognomeIndirizzo").val();
		var indirizzoIndirizzo = $("#indirizzoIndirizzo").val();
		var capIndirizzo = $("#capIndirizzo").val();
		var cittaIndirizzo = $("#cittaIndirizzo").val();
		var provinciaIndirizzo = $("#provinciaIndirizzo").val();
		var telefonoIndirizzo = $("#telefonoIndirizzo").val();
		var cellulareIndirizzo = $("#cellulareIndirizzo").val();
		var noteIndirizzo = $("#noteIndirizzo").val();
		var idUtente = $("#idUtente").val();
		
		if(idUtente != undefined && idUtente > 0){
			if(nomeIndirizzo != undefined && cognomeIndirizzo != undefined && indirizzoIndirizzo != undefined && capIndirizzo != undefined && cittaIndirizzo != undefined && provinciaIndirizzo != undefined && telefonoIndirizzo != undefined && cellulareIndirizzo != undefined && noteIndirizzo != undefined
			   && nomeIndirizzo.length > 1 && cognomeIndirizzo.length > 1 && indirizzoIndirizzo.length > 1 && capIndirizzo > 0 && cittaIndirizzo > 0 && provinciaIndirizzo > 0){		
				$("#loader").show();			
				$.ajax({
					url: absolutePath+"/AggiungiIndirizzo",
					type: "POST",
					dataType: 'JSON',
					async: false,
					data: {
						"nomeIndirizzo": nomeIndirizzo,
						"cognomeIndirizzo": cognomeIndirizzo,
						"indirizzoIndirizzo": indirizzoIndirizzo,
						"capIndirizzo": capIndirizzo,
						"cittaIndirizzo": cittaIndirizzo,
						"provinciaIndirizzo": provinciaIndirizzo,
						"telefonoIndirizzo": telefonoIndirizzo,
						"cellulareIndirizzo": cellulareIndirizzo,
						"noteIndirizzo": noteIndirizzo,
						"idUtente": idUtente
					},
					success:function(msg){
						if(!msg.risultato){
							showAlert(1, msg.errore);
						}
						else{
							showAlert(0, msg.contenuto);
							$("#formAggiungiIndirizzo").html("");
							$("#formAggiungiIndirizzo").css("display", "none");
							setTimeout(function(){ location.reload(); }, 1000);							
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
		}
		else{
			showAlert(1, "Errore Parametri.");
		}		
	});	
	
	$(document).on('click', '#buttonAggiungiIndirizzo', function(e){
		
		if($("#formAggiungiIndirizzo").css("display") == "block"){
			$("#formAggiungiIndirizzo").html("");
			$("#formAggiungiIndirizzo").css("display", "none");
		}
		else{		
			$("#loader").show();
			
			$.ajax({
				url: absolutePath+"/GetFormAggiungiIndirizzo",
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
						$("#formAggiungiIndirizzo").html(msg.contenuto);
						$("#formAggiungiIndirizzo").css("display", "block");
					}
				},
				error: function(msg){
					showAlert(1, "Impossibile Recuperare i dati.");
				}
			});
			
			$("#loader").hide();
		}
	});		
	
	$(document).on('click', '.eliminaIndirizzo', function(e){
		var idIndirizzo = $(this).data("idindirizzo");
		var form = $(this).closest("form");
		if(idIndirizzo != undefined && idIndirizzo > 0){
			if(confirm("Conferma la cancellazione dell'indirizzo selezionato?")){				
				$("#loader").show();
				$.ajax({
					url: absolutePath+"/EliminaIndirizzo",
					type: "POST",
					dataType: 'JSON',
					async: false,
					data: {
						"idIndirizzo": idIndirizzo	
					},
					success:function(msg){
						if(!msg.risultato){
							showAlert(1, msg.errore);
						}
						else{								
							showAlert(0, msg.contenuto);	
							form.remove();
						}
					},
					error: function(msg){							
						showAlert(1, "Impossibile Recuperare i dati.");
					}
				});			
				$("#loader").hide();
			}
			return false;
		}
		else{
			showAlert(1, "Errore Parametri.");
		}
	});	
	
	$(document).on('submit', '#formImpostazioniUser', function(e){
		var idUtente = $("#idUtente").val();
		var nomeUtente = $("#nomeUtente").val();
		var cognomeUtente = $("#cognomeUtente").val();
		var sessoUtente = $(".sessoUtente:checked").val();
		var dataNascitaUtente = $("#dataNascitaUtente").val();
		var passwordUtente = $("#passwordUtente").val();
		var ripetiPasswordUtente = $("#ripetiPasswordUtente").val();

		var continua = 1;
		if(nomeUtente == undefined || nomeUtente == "" || nomeUtente.length < 1){			
			showAlert(1, "Inserire un nome");
			continua *= 0;
		}
		if(cognomeUtente == undefined || cognomeUtente == "" || cognomeUtente.length < 1){			
			showAlert(1, "Inserire un cognome");
			continua *= 0;
		}
		if(sessoUtente == undefined || (sessoUtente != "M" && sessoUtente != "F")){			
			showAlert(1, "Scegliere il sesso");
			continua *= 0;
		}
		if(dataNascitaUtente == undefined || dataNascitaUtente == "" || dataNascitaUtente.length != 10){			
			showAlert(1, "Inserire una data nascita valida");
			continua *= 0;
		}
		if(idUtente == undefined || idUtente <= 0){			
			showAlert(1, "Errore Parametri");
			continua *= 0;
		}

		var tipo = 0;
		if(passwordUtente != undefined && passwordUtente.length > 1){ //Cambio anche la pwd
			if(ripetiPasswordUtente != undefined && ripetiPasswordUtente.length > 1 && passwordUtente == ripetiPasswordUtente){
				tipo = 1
				continua *= 1;
			}
			else{
				showAlert(1, "Controllare che le due password coincidano.");
				continua *= 0;
			}
		}		
		
		if(continua){
			$("#loader").show();
			$.ajax({
				url: absolutePath+"/SalvaProfiloUser",
				type: "POST",
				dataType: 'JSON',
				async: false,
				data: {
					"nomeUtente": nomeUtente,
					"cognomeUtente": cognomeUtente,
					"sessoUtente": sessoUtente,
					"dataNascitaUtente": dataNascitaUtente,
					"passwordUtente": passwordUtente,
					"idUtente": idUtente,
					"tipo": tipo
				},
				success:function(msg){
					if(!msg.risultato){
						showAlert(1, msg.errore);
					}
					else{								
						showAlert(0, msg.contenuto);	
						setTimeout(function(){ location.reload(); }, 1000);
					}
				},
				error: function(msg){							
					showAlert(1, "Impossibile Recuperare i dati.");
				}
			});			
			$("#loader").hide();					
			
		}
		
		
		return false;			
	});	
	
	
	
	
	
});
