$(document).ready(function(){
	
		
	$(document).on('submit', '#formContattaci', function(e){
		
		
		var nome = $("#nome").val();
		var email = $("#email").val();
		var messaggio = $("#messaggio").val();
		var idCliente = $("#idCliente").val();
		var idOrdine = $("#idOrdine").val();
				
		var continua = 1;
		if(nome == undefined || nome == "" || nome.length < 3){			
			showAlert(1, "Inserire un Nome Utente valido");
			continua *= 0;
		}
		if(email == undefined || email == "" || !checkEmail(email)){
			showAlert(1, "Inserire un' Email valida");
			continua *= 0;
		}
		if(messaggio == undefined || messaggio == "" || messaggio.length < 3){			
			showAlert(1, "Inserire un Messaggio valido");
			continua *= 0;
		}
				
		if(continua){
			if(idCliente != undefined && idOrdine != undefined){
				$("#loader").show();
				
				$.ajax({
					url: absolutePath+"/InviaContatto",
					type: "POST",
					dataType: 'JSON',
					async: false,
					data: {
						"nome": nome,
						"email": email,
						"messaggio": messaggio,
						"idCliente": idCliente,
						"idOrdine": idOrdine
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
			else{
				showAlert(1, "Errore Parametri.");
			}
			return false;
		}
		else{			
			return false;
		}				
	});	
	
	
	
	
	
});
