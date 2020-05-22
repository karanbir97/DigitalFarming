$(document).ready(function(){
	
	
	
	
	
	$(document).on('submit', '#formRegistrati', function(e){
		var emailUtente = $("#emailUtente").val();
		var passwordUtente = $("#passwordUtente").val();
		var confermaPasswordUtente = $("#confermaPasswordUtente").val();
		var codiceFiscaleUtente = $("#codiceFiscaleUtente").val();
		var nomeUtente = $("#nomeUtente").val();
		var cognomeUtente = $("#cognomeUtente").val();
		var sessoUtente = $(".sessoUtente:checked").val();
		var dataNascitaUtente = $("#dataNascitaUtente").val();
		var tipoUtente = $("#tipoUtente").val();

		
		var continua = 1;
		if(emailUtente == undefined || emailUtente == "" || !checkEmail(emailUtente)){			
			showAlert(1, "Inserire un'email valida");
			continua *= 0;
		}
		if(passwordUtente == undefined || passwordUtente == "" || passwordUtente.length < 6){			
			showAlert(1, "Inserire una password valida di almeno 6 caratteri");
			continua *= 0;
		}
		if(confermaPasswordUtente == undefined || passwordUtente != confermaPasswordUtente){			
			showAlert(1, "Controllare che le due password coincidano");
			continua *= 0;
		}
		if(codiceFiscaleUtente == undefined || codiceFiscaleUtente == "" || !validaCF(codiceFiscaleUtente)){			
			showAlert(1, "Inserire un codice fiscale valido");
			continua *= 0;
		}
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
		if(tipoUtente == undefined || tipoUtente > 2 || tipoUtente < 1){			
			showAlert(1, "Inserire un Tipo Utente valido");
			continua *= 0;
		}
		if(dataNascitaUtente == undefined || dataNascitaUtente == "" || dataNascitaUtente.length != 10){			
			showAlert(1, "Inserire una data nascita valida");
			continua *= 0;
		}
		
		if(continua){
			$("#loader").show();

			$.ajax({
				url: absolutePath+"/SalvaUtente",
				type: "POST",
				dataType: 'JSON',
				async: false,
				data: {
					"emailUtente": emailUtente,
					"passwordUtente": passwordUtente,
					"codiceFiscaleUtente": codiceFiscaleUtente,
					"nomeUtente": nomeUtente,
					"cognomeUtente": cognomeUtente,
					"sessoUtente": sessoUtente,
					"dataNascitaUtente": dataNascitaUtente,
					"tipoUtente": tipoUtente
				},
				success:function(msg){
					if(!msg.risultato){
						showAlert(1, msg.errore);
					}
					else{
						showAlert(0, msg.contenuto);
					}
				},
				error: function(msg){
					showAlert(1, "Impossibile Recuperare i dati.");
				}
			});
			
			$("#loader").hide();
			return false;
		}
		else{			
			return false;
		}					
		return false;
	});	
	
	
	
	
	
});
