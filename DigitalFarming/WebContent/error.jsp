<link href="//netdna.bootstrapcdn.com/bootstrap/3.0.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<script src="//netdna.bootstrapcdn.com/bootstrap/3.0.0/js/bootstrap.min.js"></script>
<script src="//code.jquery.com/jquery-1.11.1.min.js"></script>
<!------ Include the above in your HEAD tag ---------->
<%
    	String id= request.getParameter("idcat");
    	Integer idProdotto = Integer.parseInt(request.getParameter("idcat"));
    	String nome=request.getParameter("nome");	
    	String categoria= request.getParameter("categoria");	
    	String nomeProdotto = request.getParameter("descrizione");	
    	String quantitaProdotto = request.getParameter("peso");
    	String sesso=request.getParameter("sesso");
    	String data=request.getParameter("data");
    	String prod=request.getParameter("produzione");
    	String controllo=request.getParameter("controllo");
    	String coltura=request.getParameter("coltura");
    	
    	
%>
<div class="modal in" style="display: block;">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h4 class="modal-title">ATTENZIONE</h4>
      </div>
      <div class="modal-body">
      	<%if(idProdotto == 22){ %>
      	<p>Sei sicuro di voler inserire il seguente animale ?</p>
      	<%}else { %>
        <p>Sei sicuro di voler eliminare definitivamente il prodotto selezionato ?</p>
        <%}%>
        <div class="row">
            <div class="col-12-xs text-center">
            	<%if((idProdotto == 22)){ %>
            	<form action="aggiungi_dato.jsp" method="get">
            	
				<input type="hidden" id="idcat" name="idcat" value="<%= idProdotto%>">
				<input type="hidden" id="descrizione" name="descrizione" value="<%=nomeProdotto %>">
				<input type="hidden" id="sesso" name="sesso" value="<%= sesso%>">
				<input type="hidden" id="data" name="data" value="<%= data%>">
				<input type="hidden" id="peso" name="peso" value="<%= quantitaProdotto%>">
				<input type="hidden" id="produzione" name="produzione" value="<%= prod%>">
				<input type="hidden" id="controllo" name="controllo" value="<%= controllo%>">
                	<input type="submit" value="Si" class="btn btn-success btn-md">
                	<input type="button" class="btn btn-danger btn-md" value="No" onClick="history.go(-1);return true;" name="button">
                
                </form>
            	<%}else { %>
            	<form action="elimina_dato.jsp" method="get">
            	
				<input type="hidden" id="idcat" name="idcat" value="<%= idProdotto%>">
				
                	<input type="submit" value="Si" class="btn btn-success btn-md">
                	<input type="button" class="btn btn-danger btn-md" value="No" onClick="history.go(-1);return true;" name="button">
                
                </form>
                <%}%>
            </div>
        </div>
      </div>
   
    </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
</div><!-- /.modal -->