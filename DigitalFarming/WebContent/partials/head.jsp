<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="model.Carrello" %>	
	<meta charset="UTF-8">
	<meta name="description" content="">
	<meta name="keywords" content="">
	<meta name="author" content="">
	<meta name="viewport" content="width=749, initial-scale=1.0">				
	
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/style_desktop.css">
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/style_tablet.css">
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/style_mobile.css">
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/toastr/toastr.css">
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/datatable/jquery.dataTables.min.css">
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/dropzone/filesystem_dropzone.css">
	<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.0.13/css/all.css">
	
	<script src="<%=request.getContextPath()%>/js/jquery-3.3.1.js"></script>
	<script src="<%=request.getContextPath()%>/js/toastr/toastr.min.js"></script>
	<script src="<%=request.getContextPath()%>/js/datatable/jquery.dataTables.min.js"></script>
	<script src="<%=request.getContextPath()%>/js/dropzone/filesystem_dropzone.js"></script>
	
	<script>
		var absolutePath = "<%=request.getContextPath()%>";
	</script>
	<script src="<%=request.getContextPath()%>/js/scripts.js"></script>
	
	<%		
		if(request.getSession().getAttribute("carrello") == null) { //Se non trova il carrello per qualsiasi motivo, ricreo il carrello
			request.getSession().setAttribute("carrello", new Carrello((Integer) request.getSession().getAttribute("id_utente")));
		}			
	%>	
	