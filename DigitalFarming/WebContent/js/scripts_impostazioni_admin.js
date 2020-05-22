$(document).ready(function(){
	
	
	
	
	
	$(document).on('submit', '#formImpostazioniAdmin', function(e){
		var ids = [];
		var values = [];
		$("input.campoForm").each(function( index ) {
			if($(this).data("id") != undefined && $(this).data("id") > 0 && $(this).val() != undefined){			
				ids.push($(this).data("id"));
				values.push($(this).val());
			}
		});		
		
		if(ids.length > 0 && ids.length == values.length){
			var continua = 1;
			var cont = "";
			for(var i = 0; i < ids.length && continua == 1; i++){
				if(ids[i] > 0){
					$("#loader").show();
					$.ajax({
						url: absolutePath+"/SalvaImpostazioni",
						type: "POST",
						dataType: 'JSON',
						async: false,
						data: {
							"id": ids[i],
							"value": values[i],			
						},
						success:function(msg){
							if(!msg.risultato){
								showAlert(1, msg.errore);
								continua *= 0;
							}
							else{								
								continua *= 1;
								cont = msg.contenuto;
							}
						},
						error: function(msg){
							continua *= 0;
							showAlert(1, "Impossibile Recuperare i dati.");
						}
					});			
					$("#loader").hide();					
				}
			}
			if(continua == 1){
				showAlert(0, cont);
				location.reload();
			}
			return false;						
		}
		else{
			showAlert(1, "Errore prelevamento valori, compilare tutti i campi correttamente.");
		}

		return false;			
	});	
	
	
	
	
	
});
