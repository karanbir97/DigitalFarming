$(document).ready(function(){
	
	
	$(document).on('click', '.userButtonRegistraAdmin, .userButtonDisattivaAdmin', function(e){ //Click su bottone registrati oppure registra nuovo admin
		var href = $(this).data("href");
		if(href != undefined && href.length > 1){
			window.location.href = href;
		}		
	});
		
	
	$(document).on('submit', '#formImpostazioniAdmin', function(e){
		var idUtente = $("#idUtente").val();
		var utenteDisattiva = $("#utenteDisattiva").val();
		
		var continua = 1;
		
		if(idUtente == undefined || idUtente <= 0){			
			showAlert(1, "Errore Parametri");
			continua *= 0;
		}
		if(utenteDisattiva == undefined || utenteDisattiva <= 0){			
			showAlert(1, "Errore Parametri");
			continua *= 0;
		}

		if(continua){
			if(confirm("Conferma la disattivazione dell'admin selezionato?")){
				$("#loader").show();
				$.ajax({
					url: absolutePath+"/EliminaAdmin",
					type: "POST",
					dataType: 'JSON',
					async: false,
					data: {
						"idUtente": idUtente,
						"utenteDisattiva": utenteDisattiva
					},
					success:function(msg){
						if(!msg.risultato){
							showAlert(1, msg.errore);
						}
						else{								
							showAlert(0, msg.contenuto);	
							location.reload();
							return false;
						}
					},
					error: function(msg){							
						showAlert(1, "Impossibile Recuperare i dati.");
					}
				});			
				$("#loader").hide();												
			}			
		}
		return false;
	});	
	
	
	
	
	
});
