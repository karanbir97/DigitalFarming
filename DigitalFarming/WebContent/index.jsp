<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="model.ConnessioneDB,java.sql.*, model.SystemInformation"%>
<!DOCTYPE html>
<html lang = "it">
	<head>
		<%@ include file="/partials/head.jsp" %>			
		<title>Index</title>		
		
		<link rel="stylesheet" href="css/style.css"/>
		
	</head>
	<body>
		<%@ include file="/partials/header.jsp" %>		
		<br>
		
		<div class="portfolio_area">
        <!-- <div class="container-fluid p-0"> -->
            <div class="portfolio_wrap">
                <div class=" single_gallery">
                    <div class="thumb">
                        <img src="images/bestiame.jpg" alt="">
                    </div>
                    <div class="gallery_hover">
                        <div class="hover_inner">
                                <span>Responsabile</span>
                                <a href="work_details.html"> <h3>Bestiame</h3></a>
                                
                        </div>
                    </div>
                </div>
                <div class="single_gallery small_width">
                    <div class="thumb">
                        <img src="images/macchinari.jpg" alt="">
                    </div>
                    <div class="gallery_hover">
                            <div class="hover_inner">
                                    <span>Responsabile</span>
                                    <a href="work_details.html"> <h3>Macchinari</h3></a>
                            </div>
                        </div>
                </div>
                <div class="single_gallery">
                    <div class="thumb">
                        <img src="images/campi.jpg" alt="">
                    </div>
                    <div class="gallery_hover">
                    	<div class="hover_inner">
                    		<span>Responsabile</span>
                            <a href="work_details.html"> <h3>Raccolta</h3></a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
		<br>
		<script src="js/home/jquery-3.2.1.min.js"></script>
		<script src="js/home/jquery.nicescroll.min.js"></script>
		<script src="js/home/pana-accordion.js"></script>
		<script src="js/home/main.js"></script>  
		
		<%@ include file="/partials/footer.jsp" %>	
	</body> 
</html>
