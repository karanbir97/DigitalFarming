<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang = "it">
	<head>
		<%@ include file="/partials/head.jsp" %>			
		<title>Chi siamo</title>		
	</head>
	<body>
		<%@ include file="/partials/header.jsp" %>				
		<div id="content">
			<p>La MACELLERIA EAT MEAT 2.0, è una macelleria storica di Eboli (Salerno).
				Nel corso degli anni, grazie alla qualità dei prodotti venduti e dei servizi resi con cortesia e professionalità, l'attività s'è ingrandita e così è andato ad aumentare non solo le nostre stalle ma anche il personale</p>
			<div id="prodotti">
				<h1>Qualità dei nostri Prodotti</h1>
				<img src="<%=request.getContextPath()%>/images/p2_chisiamo.jpg">
				<p>L’alta qualità è per noi un impegno quotidiano, una responsabilità che ci assumiamo nei confronti dei nostri clienti.
					Seguiamo metodi di lavorazione tradizionali ed antiche ricette che, insieme alla ricerca e all’utilizzo di moderne tecniche di produzione, ci permettono di ottenere salumi sempre più gustosi, sicuri e genuini.
					Controlliamo personalmente ogni fase del processo produttivo. Solo alla fine, ci mettiamo la firma.
					Per questo abbiamo ottenuto numerosi premi e riconoscimenti.
					Per questo produciamo, ogni giorno, salumi semplicemente buonissimi.</p>
			</div>
			

			
			<div id="stagionatura">
				<h1>Stagionatura</h1>
				<img src="<%=request.getContextPath()%>/images/p_chisiamo.jpg">
				<p>Lunghe e lente stagionature permettono ai nostri salumi un processo di affinamento naturale, senza l’ausilio di tecniche ed enzimi che ne accelerino la trasformazione. Utilizziamo inoltre solo gli agenti antibatterici indispensabili per una sicura conservazione.
					Ci sottoponiamo a rigorosi controlli qualitativi e sanitari di HACCP in collaborazione con i veterinari delle ASL locali e gli istituti di analisi e ricerca accreditati.
					Abbiamo ottenuto recentemente anche le certificazioni internazionali IFS e BRC, standard di sicurezza globale e qualità dei processi.</p>
			</div>
			
	
		
			
			</div>
		<%@ include file="/partials/footer.jsp" %>	
	</body>
</html>