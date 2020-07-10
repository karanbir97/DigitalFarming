$(document).ready(function(){
	
	resizeContent();
	$( window ).resize(function() {
		resizeContent();
	});	
	
	getCarrelloSmall();
	
	/*********************************************************/
	/***************************menu************************/
	/*********************************************************/
	$(document).on('mouseover', ".parte > li.has-child > a", function() {
		$(".parte-figlio").css("display", "none");
		$(this).closest("li").children(".parte-figlio").css("display", "block");
	});	

	$(document).on('mouseover', ".parte > li", function() {
		if(!$(this).hasClass("has-child")){			
			$(".parte-figlio").css("display", "none");			
		}
	});	

	$(document).on('mouseover', "#content", function() {
		$(".parte-figlio").css("display", "none");
	});	

	$(window).on("scroll", function() {
		$(".parte-figlio").css("display", "none");
	});
	
	$(document).on('click', '.icon-nav > i.fa-bars', function() {
		$(".nav-ospite").css("display", "block");
		$(".nav-utente").css("display", "block");
		$(".nav-admin").css("display", "block");
		$('.fa-bars').addClass('fa-times').removeClass('fa-bars');
	});	
	
	$(document).on('click', '.icon-nav > i.fa-times', function() {
		$(".nav-ospite").css("display", "none");
		$(".nav-utente").css("display", "none");
		$(".nav-admin").css("display", "none");
		$('.fa-times').addClass('fa-bars').removeClass('fa-times');
	});	
	
	
	$(document).on('click','.icon-nav > i.fa-bars', function() {
		$('body').css("overflow-y","hidden");
	});
	
	$(document).on('click', '.icon-nav > i.fa-times', function() {
		$('body').css("overflow-y","visible");
	});
	

	$(document).on('click', '.product-title, .product-image', function() { //Click sul nome del prodotto vai al dettaglio
		var idProdotto = $(this).data("idprodotto");
		if(idProdotto != undefined && idProdotto > 0){
			window.location.href = absolutePath+"/prodotto_dettaglio.jsp?idp="+idProdotto;
		}
		else{
			showAlert(1, "Errore Parametri.");
		}
	});
	
	$(document).on('click', '.product-button', function() { //Click su bottone giallo aggiungi al carrello
		var idProdotto = $(this).data("idprodotto");
		if(idProdotto != undefined && idProdotto > 0){
			aggiungiAlCarrello(idProdotto, 1);
		}
		else{
			showAlert(1, "Errore Parametri.");
		}
		return false;
	});
	
	$(document).on('click', '.userButtonRegistrati', function(e){ //Click su bottone registrati oppure registra nuovo admin
		var href = $(this).data("href");
		if(href != undefined && href.length > 1){
			window.location.href = href;
		}		
	});
	
	
	$(document).on('click', '.showImmagineProdotto', function(e){		//Per vedere un'immagine del prodotto nel modal
		var src = $(this).attr("src");
		if(src != undefined){		
			$("#modalImmaginiBody").html('<img src="'+src+'" alt="'+src+'" />');
			$("#modalImmagini").css("display", "block");
			
			return false;
		}
		else{			
			showAlert(1, "Errore Parametri.");
		}		
		return false;
	});	
	
	$(document).on('click', '.chiudiModalImmagini', function(e){	//Per chiudere il modal quando viene mostrata una foto
		$("#modalImmagini").css("display", "none");
	});			
		
});

function getCarrelloSmall(){ 
	$("#loader").show();	
	$.ajax({
		url: absolutePath+"/GetCarrelloSmall",
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
				$(".numeroProdottiCarrello").html(msg.contenuto);
			}
		},
		error: function(msg){
			//showAlert(1, "Impossibile Recuperare i dati.");
		}
	});	
	$("#loader").hide();		
}

function aggiungiAlCarrello(idProdotto, quantita){
	if(idProdotto > 0 && quantita > 0){
		$("#loader").show();
		
		$.ajax({
			url: absolutePath+"/AggiungiAlCarrello",
			type: "POST",
			dataType: 'JSON',
			async: false,
			data: {
				"idProdotto": idProdotto,
				"quantita": quantita
			},
			success:function(msg){
				if(!msg.risultato){
					showAlert(1, msg.errore);
				}
				else{
					if(msg.redirect){
						window.location.href = absolutePath+msg.urlRedirect;
					}
					else{
						getCarrelloSmall();
						showAlert(0, msg.contenuto);
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

//validaCF('CODICEFISCALE');
function validaCF(cf){
	var validi, i, s, set1, set2, setpari, setdisp;
	if( cf == '' )  return '';
	cf = cf.toUpperCase();
	if( cf.length != 16 )
		return false;
	validi = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
	for( i = 0; i < 16; i++ ){
		if( validi.indexOf( cf.charAt(i) ) == -1 )
			return false;
	}
	set1 = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";
	set2 = "ABCDEFGHIJABCDEFGHIJKLMNOPQRSTUVWXYZ";
	setpari = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
	setdisp = "BAKPLCQDREVOSFTGUHMINJWZYX";
	s = 0;
	for( i = 1; i <= 13; i += 2 )
		s += setpari.indexOf( set2.charAt( set1.indexOf( cf.charAt(i) )));
	for( i = 0; i <= 14; i += 2 )
		s += setdisp.indexOf( set2.charAt( set1.indexOf( cf.charAt(i) )));
	if( s%26 != cf.charCodeAt(15)-'A'.charCodeAt(0) )
		return false;
	return true;
}

//checkEmail('prova@email.it');
function checkEmail(email){
	var $email = email;
	var re = /[A-Z0-9._%+-]+@[A-Z0-9.-]+.[A-Z]{2,4}/igm;
	if ($email == '' || !re.test($email)){
		return false;
	}
	else{
		return true;
	}
}

function resizeContent(){
	$("#content").css("min-height", ($(window).height() - $("#header").height() - $("#footer").height())+"px");	
}

function showAlert(flag, descrizione){
	toastr.options = {
	  "closeButton": true,
	  "debug": false,
	  "newestOnTop": false,
	  "progressBar": false,
	  "positionClass": "toast-bottom-right",
	  "preventDuplicates": false,
	  "onclick": null,
	  "showDuration": "300",
	  "hideDuration": "1000",
	  "timeOut": "5000",
	  "extendedTimeOut": "1000",
	  "showEasing": "swing",
	  "hideEasing": "linear",
	  "showMethod": "fadeIn",
	  "hideMethod": "fadeOut"
	}
	
	if(flag == 0){ //Tutto OK
		toastr.success(descrizione, "Operazione Effettuata");
	}
	else if(flag == 1){ //Errore		
		toastr.error(descrizione, "Operazione Fallita");
	}	
}