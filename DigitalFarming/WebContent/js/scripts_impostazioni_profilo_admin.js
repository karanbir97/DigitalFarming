$(document).ready(function(){
	
	
	$(document).on('click', '.userButtonRegistraAdmin, .userButtonDisattivaAdmin', function(e){ //Click su bottone registrati oppure registra nuovo admin
		var href = $(this).data("href");
		if(href != undefined && href.length > 1){
			window.location.href = href;
		}		
	});
	
	
	
	$(document).on('submit', '#formImpostazioniAdmin', function(e){
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
				url: absolutePath+"/SalvaProfiloAdmin",
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
