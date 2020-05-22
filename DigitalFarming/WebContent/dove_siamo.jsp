<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang = "it">
	<head>
	<meta name="viewport" content="initial-scale=1.0, user-scalable=no" />
		<%@ include file="/partials/head.jsp" %>			
		<title>Dove Siamo</title>		
	</head>
	<body>
		<%@ include file="/partials/header.jsp" %>				
	<div id="content">
	<div id="content-content">
		<div id="information-title">
		<h1>Indicazioni Stradali</h1>
		</div>

	<div id="googleMap">

<script>
function myMap() {
var mapProp= {
    zoom:10,
};
var map=new google.maps.Map(document.getElementById("googleMap"),mapProp);
}
</script>

	<iframe src="https://www.google.com/maps/embed?pb=!1m14!1m8!1m3!1d3028.633063484076!2d15.053283!3d40.6159188!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x1339600cb8039bed%3A0xdff4fded3ecccdd6!2sVia+Umberto+Nobile%2C+22%2C+84025+Eboli+SA!5e0!3m2!1sit!2sit!4v1528362896724" ></iframe>
	</div>
	<div id="information-info">
		<ul class="info_market">
					<li><i class="fas fa-map-marker-alt"></i> <span>Eat Meat 2.0 - Via Umberto Nobile 22 - Eboli (SA) - Italia</span></li>
					<li><i class="fas fa-phone"></i> <span>Centralino: <a href="tel: +39 3333333333">+39 3333333333</a></span></li> 
					<li><i class="fas fa-envelope"></i> <span><a href="mailto:info@eatmeat.com">info@eatmeat.com</a></span></li>
					</ul>

	</div>
</div>
</div>	

		<%@ include file="/partials/footer.jsp" %>	
	
	</body>
</html>

