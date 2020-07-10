$(document).ready(function(){	
	$(document).on('submit', '#formAccedi', function(e){
		var nomeUtente = $("#nomeUtente").val();
		var passwordUtente = $("#passwordUtente").val();
		
		var continua = 1;
		if(nomeUtente == undefined || nomeUtente == "" || !checkEmail(nomeUtente)){			
			showAlert(1, "Inserire un Nome Utente valido");
			continua *= 0;
		}
		if(passwordUtente == undefined || passwordUtente == "" || passwordUtente.length < 3){			
			showAlert(1, "Inserire una password valida");
			continua *= 0;
		}

		if(continua){
			$("#loader").show();

			$.ajax({
				url: absolutePath+"/Accedi",
				type: "POST",
				dataType: 'JSON',
				async: false,
				data: {
					"nomeUtente": nomeUtente,
					"passwordUtente": passwordUtente
				},
				success:function(msg){
					if(!msg.risultato){
						showAlert(1, msg.errore);
					}
					else{
						window.location.href = msg.redirect;
					}
				},
				error: function(msg){
					//showAlert(1, "Impossibile Recuperare i dati.");
				}
			});
			
			$("#loader").hide();
			return false;
		}
		else{			
			return false;
		}				
	});	
	
	
	
	
	
});
