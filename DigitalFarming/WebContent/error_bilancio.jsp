<link href="//netdna.bootstrapcdn.com/bootstrap/3.0.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<script src="//netdna.bootstrapcdn.com/bootstrap/3.0.0/js/bootstrap.min.js"></script>
<script src="//code.jquery.com/jquery-1.11.1.min.js"></script>
<!------ Include the above in your HEAD tag ---------->
<%
	String spesa=request.getParameter("spesa");
    String descrizione=request.getParameter("descrizione");
    String categoria=request.getParameter("report-type");
    String data=request.getParameter("data");
    	
%>
<div class="modal in" style="display: block;">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h4 class="modal-title">ATTENZIONE</h4>
      </div>
      <div class="modal-body">
      	<p>Sei sicuro di voler inserire questa spesa ?</p>
        <div class="row">
            <div class="col-12-xs text-center">
            	<form action="aggiungi_spesa.jsp" method="get">
            	
				<input type="hidden" id="spesa" name="spesa" value="<%=spesa %>">
				<input type="hidden" id="descrizione" name="descrizione" value="<%=descrizione %>">
				<input type="hidden" id="categoria" name="categoria" value="<%=categoria %>">
				<input type="hidden" id="data" name="data" value="<%=data %>">
                	<input type="submit" value="Si" class="btn btn-success btn-md">
                	<input type="button" class="btn btn-danger btn-md" value="No" onClick="history.go(-1);return true;" name="button">
                
                </form>
            	
            	
                
            </div>
        </div>
      </div>
   
    </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
</div><!-- /.modal -->