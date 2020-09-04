<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="model.ConnessioneDB,java.sql.*, model.SystemInformation"%>

<!doctype html>

<html lang="en">
  <head>
    <meta charset="utf-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1, viewport-fit=cover"/>
    <meta http-equiv="X-UA-Compatible" content="ie=edge"/>
    <title>Bilancio</title>
    <link rel="preconnect" href="https://fonts.gstatic.com/" crossorigin>
    <meta name="msapplication-TileColor" content="#206bc4"/>
    <meta name="theme-color" content="#206bc4"/>
    <meta name="apple-mobile-web-app-status-bar-style" content="black-translucent"/>
    <meta name="apple-mobile-web-app-capable" content="yes"/>
    <meta name="mobile-web-app-capable" content="yes"/>
    <meta name="HandheldFriendly" content="True"/>
    <meta name="MobileOptimized" content="320"/>
    <meta name="robots" content="noindex,nofollow,noarchive"/>
    <link rel="icon" href="./favicon.ico" type="image/x-icon"/>
    <link rel="shortcut icon" href="./favicon.ico" type="image/x-icon"/>
    <!-- CSS files -->
    <link href="./dist/libs/jqvmap/dist/jqvmap.min.css" rel="stylesheet"/>
    <link href="./dist/css/tabler.min.css" rel="stylesheet"/>
    <link href="./dist/css/demo.min.css" rel="stylesheet"/>
    <style>
      body {
      	display: none;
      }
    </style>
  </head>
  <body class="antialiased">
  
<%
Integer positivo=0;
Integer negativo=0;
Integer ca=0;
Integer spesa=0;
Integer i=0;
String m="";
Integer ricavato=0;
Integer media=0;

ConnessioneDB conn = new ConnessioneDB();

if(conn.getConn() != null) {
	try {
	
		Statement stmt = conn.getConn().createStatement();
		String sql = "SELECT * FROM bilancio WHERE attivo = 1;";
		ResultSet result = stmt.executeQuery(sql);
		if(!result.wasNull()) {
			
			int rowCount = result.last() ? result.getRow() : 0;
			if(rowCount > 0) {
				result.beforeFirst();										
				while(result.next()) {
					ca= result.getInt("categoria");
					spesa=result.getInt("spese");
					if(ca == 1)
						negativo=negativo+spesa;
					else if(ca == 2)
						positivo=positivo+spesa;
					i++;
				}										
			}
			else {
				m = "Prodotto Non Trovato.";
			}											
		}															
		ricavato=positivo-negativo;
		if(ricavato>0)
			media=(negativo*100)/positivo;
		else
			media=(positivo*100)/negativo;
		conn.getConn().close();
	}
	catch(Exception e) {
		m = e.getMessage();
	}	
}
else {
	m = conn.getError();
}				     %>
  
      
      <div class="content">
        <div class="container-xl">
          <!-- Page title -->
          <div class="page-header">
            <div class="row align-items-center">
              <div class="col-auto">
                <!-- Page pre-title -->
                
                <h2 class="page-title">
                  Gestione bilancio
                </h2>
              </div>
              <!-- Page title actions -->
              <div class="col-auto ml-auto d-print-none">
                
                <a href="#" class="btn btn-primary ml-3 d-none d-sm-inline-block" data-toggle="modal" data-target="#modal-report">
                  <svg xmlns="http://www.w3.org/2000/svg" class="icon" width="24" height="24" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor" fill="none" stroke-linecap="round" stroke-linejoin="round"><path stroke="none" d="M0 0h24v24H0z"/><line x1="12" y1="5" x2="12" y2="19" /><line x1="5" y1="12" x2="19" y2="12" /></svg>
                  Aggiungi nuova spesa
                </a>
                <a href="#" class="btn btn-primary ml-3 d-sm-none btn-icon" data-toggle="modal" data-target="#modal-report" aria-label="Create new report">
                  <svg xmlns="http://www.w3.org/2000/svg" class="icon" width="24" height="24" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor" fill="none" stroke-linecap="round" stroke-linejoin="round"><path stroke="none" d="M0 0h24v24H0z"/><line x1="12" y1="5" x2="12" y2="19" /><line x1="5" y1="12" x2="19" y2="12" /></svg>
                </a>
              </div>
            </div>
          </div>
          <div class="row row-deck row-cards">
            <div class="col-sm-6 col-lg-3">
              <div class="card">
                <div class="card-body">
                  <div class="d-flex align-items-center">
                    <div class="subheader">Ricavato</div>
                    <div class="ml-auto lh-1">
                      <div class="dropdown">
                        <a class="dropdown-toggle text-muted" href="#" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                          Last 7 days
                        </a>
                        <div class="dropdown-menu dropdown-menu-right">
                          <a class="dropdown-item active" href="#">Last 7 days</a>
                          <a class="dropdown-item" href="#">Last 30 days</a>
                          <a class="dropdown-item" href="#">Last 3 months</a>
                        </div>
                      </div>
                    </div>
                  </div>
                  <div class="h1 mb-3"><%=ricavato %></div>
                  <div class="d-flex mb-2">
                    <div>Conversion rate</div>
                    <div class="ml-auto">
                      <span class="text-green d-inline-flex align-items-center lh-1">
                        <%=media %>% <svg xmlns="http://www.w3.org/2000/svg" class="icon ml-1" width="24" height="24" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor" fill="none" stroke-linecap="round" stroke-linejoin="round"><path stroke="none" d="M0 0h24v24H0z"/><polyline points="3 17 9 11 13 15 21 7" /><polyline points="14 7 21 7 21 14" /></svg>
                      </span>
                    </div>
                  </div>
                  <div class="progress progress-sm">
                    <div class="progress-bar bg-blue" style="width: 50%" role="progressbar" aria-valuenow="50" aria-valuemin="0" aria-valuemax="100">
                      <span class="sr-only">75% Complete</span>
                    </div>
                  </div>
                </div>
              </div>
            </div>
            <div class="col-sm-6 col-lg-3">
              <div class="card">
                <div class="card-body">
                  <div class="d-flex align-items-center">
                    <div class="subheader">Revenue</div>
                    <div class="ml-auto lh-1">
                      <div class="dropdown">
                        <a class="dropdown-toggle text-muted" href="#" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                          Ultimi 7 days
                        </a>
                        <div class="dropdown-menu dropdown-menu-right">
                          <a class="dropdown-item active" href="#">Ultimi 7 days</a>
                          <a class="dropdown-item" href="#">Ultimi 30 days</a>
                          <a class="dropdown-item" href="#">Ultimi 3 months</a>
                        </div>
                      </div>
                    </div>
                  </div>
                  <div class="d-flex align-items-baseline">
                    <div class="h1 mb-0 mr-2">$4,300</div>
                    <div class="mr-auto">
                      <span class="text-green d-inline-flex align-items-center lh-1">
                        8% <svg xmlns="http://www.w3.org/2000/svg" class="icon ml-1" width="24" height="24" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor" fill="none" stroke-linecap="round" stroke-linejoin="round"><path stroke="none" d="M0 0h24v24H0z"/><polyline points="3 17 9 11 13 15 21 7" /><polyline points="14 7 21 7 21 14" /></svg>
                      </span>
                    </div>
                  </div>
                </div>
                <div id="chart-revenue-bg" class="chart-sm"></div>
              </div>
            </div>
            <div class="col-sm-6 col-lg-3">
              <div class="card">
                <div class="card-body">
                  <div class="d-flex align-items-center">
                    <div class="subheader">New clients</div>
                    <div class="ml-auto lh-1">
                      <div class="dropdown">
                        <a class="dropdown-toggle text-muted" href="#" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                          Last 7 days
                        </a>
                        <div class="dropdown-menu dropdown-menu-right">
                          <a class="dropdown-item active" href="#">Last 7 days</a>
                          <a class="dropdown-item" href="#">Last 30 days</a>
                          <a class="dropdown-item" href="#">Last 3 months</a>
                        </div>
                      </div>
                    </div>
                  </div>
                  <div class="d-flex align-items-baseline">
                    <div class="h1 mb-3 mr-2">6,782</div>
                    <div class="mr-auto">
                      <span class="text-yellow d-inline-flex align-items-center lh-1">
                        0% <svg xmlns="http://www.w3.org/2000/svg" class="icon ml-1" width="24" height="24" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor" fill="none" stroke-linecap="round" stroke-linejoin="round"><path stroke="none" d="M0 0h24v24H0z"/><line x1="5" y1="12" x2="19" y2="12" /></svg>
                      </span>
                    </div>
                  </div>
                  <div id="chart-new-clients" class="chart-sm"></div>
                </div>
              </div>
            </div>
            <div class="col-sm-6 col-lg-3">
              <div class="card">
                <div class="card-body">
                  <div class="d-flex align-items-center">
                    <div class="subheader">Active users</div>
                    <div class="ml-auto lh-1">
                      <div class="dropdown">
                        <a class="dropdown-toggle text-muted" href="#" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                          Last 7 days
                        </a>
                        <div class="dropdown-menu dropdown-menu-right">
                          <a class="dropdown-item active" href="#">Last 7 days</a>
                          <a class="dropdown-item" href="#">Last 30 days</a>
                          <a class="dropdown-item" href="#">Last 3 months</a>
                        </div>
                      </div>
                    </div>
                  </div>
                  <div class="d-flex align-items-baseline">
                    <div class="h1 mb-3 mr-2">2,986</div>
                    <div class="mr-auto">
                      <span class="text-green d-inline-flex align-items-center lh-1">
                        4% <svg xmlns="http://www.w3.org/2000/svg" class="icon ml-1" width="24" height="24" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor" fill="none" stroke-linecap="round" stroke-linejoin="round"><path stroke="none" d="M0 0h24v24H0z"/><polyline points="3 17 9 11 13 15 21 7" /><polyline points="14 7 21 7 21 14" /></svg>
                      </span>
                    </div>
                  </div>
                  <div id="chart-active-users" class="chart-sm"></div>
                </div>
              </div>
            </div>
            
            
            
            
            
            
           
            
            <div class="col-md-6 col-lg-8">
              <div class="card">
                <div class="card-header">
                  <h4 class="card-title">Cronologia dati</h4>
                </div>
                <div class="table-responsive">
                <form action="error_bilancio.jsp" method="get">
                  <table class="table card-table table-vcenter">
                    <thead>
                      <tr>
                        <th>Descrizione</th>
                        <th>Categoria</th>
                        <th>Spesa</th>
                        <th colspan="2">Data</th>
                        <th>Modifica</th>
                      </tr>
                    </thead>
                    <%
				  		String descrizione="";
                   		Integer c=0;
                   		String categoria="";
				  		Integer spese=0;
				  		String msg="";
				  		String colore="";
				  		String date="";
				  		Integer id_bilancio=0;
						ConnessioneDB connDB = new ConnessioneDB();
						
						if(connDB.getConn() != null) {
							try {
							
								Statement stmt = connDB.getConn().createStatement();
								String sql = "SELECT * FROM bilancio WHERE attivo = 1;";
								ResultSet result = stmt.executeQuery(sql);
								if(!result.wasNull()) {
									
									int rowCount = result.last() ? result.getRow() : 0;
									if(rowCount > 0) {
										result.beforeFirst();										
										while(result.next()) {
											id_bilancio=result.getInt("idbilancio");
											descrizione = result.getString("descrizione");
											c = result.getInt("categoria");
											spese=result.getInt("spese");
											date=result.getString("data");
											if(c == 1){
												colore="red";
												categoria="uscita";}
											else{
												colore="green";
												categoria="entrate";}
										%>	
											
											<tr >
											
						                      <td>
						                        <%=descrizione %>
						                        
						                      </td>
						                      <td style="color: <%=colore %>;"><%=categoria %></td>
						                      <td style="color: <%=colore %>;"><%=spese %></td>
						                      <td style="color: <%=colore %>;"><%=date %></td>
						                      <td ></td>
						                      <td><a href="modifica_bilancio.jsp?idb=<%=id_bilancio %>" class="btn btn-primary ml-3 d-none d-sm-inline-block" >Modifica </a></td>
						                      <td><a href="error_bilancio.jsp?idb=<%=id_bilancio %>&elimina=elimina" class="btn btn-primary ml-3 d-none d-sm-inline-block">Elimina </a></td>
						                     
						                      </tr>
						                    <% 
											
										}										
									}
									else {
										msg = "Prodotto Non Trovato.";
									}											
								}															
								
								connDB.getConn().close();
							}
							catch(Exception e) {
								msg = e.getMessage();
							}	
						}
						else {
							msg = connDB.getError();
						}				        				        
				 %>
                  </table>
                  </form>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
     
    <div class="modal modal-blur fade" id="modal-report" tabindex="-1" role="dialog" aria-hidden="true">
    <form action="error_bilancio.jsp" method="get">
      <div class="modal-dialog modal-lg" role="document">
        <div class="modal-content">
          <div class="modal-header">
            <h5 class="modal-title">Aggiungi spesa</h5>
            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
              <svg xmlns="http://www.w3.org/2000/svg" class="icon" width="24" height="24" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor" fill="none" stroke-linecap="round" stroke-linejoin="round"><path stroke="none" d="M0 0h24v24H0z"/><line x1="18" y1="6" x2="6" y2="18" /><line x1="6" y1="6" x2="18" y2="18" /></svg>
            </button>
          </div>
          <div class="modal-body">
            <div class="mb-3">
              <label class="form-label">Descrizione</label>
              <textarea class="form-control" rows="3" id="descrizione" name="descrizione"></textarea>
            </div>
            <label class="form-label" >Categoria</label>
            <div class="form-selectgroup-boxes row mb-3">
              <div class="col-lg-6">
                <label class="form-selectgroup-item">
                  <input type="radio" name="report-type" value="2" class="form-selectgroup-input" checked>
                  <span class="form-selectgroup-label d-flex align-items-center p-3">
                    <span class="mr-3">
                      <span class="form-selectgroup-check"></span>
                    </span>
                    <span class="form-selectgroup-label-content">
                      <span class="form-selectgroup-title strong mb-1">Entrate</span>
                      <span class="d-block text-muted">Tipologia di spesa che tende ad incrementare il profitto aziendale</span>
                    </span>
                  </span>
                </label>
              </div>
              <div class="col-lg-6">
                <label class="form-selectgroup-item">
                  <input type="radio" name="report-type" value="1" class="form-selectgroup-input">
                  <span class="form-selectgroup-label d-flex align-items-center p-3">
                    <span class="mr-3">
                      <span class="form-selectgroup-check"></span>
                    </span>
                    <span class="form-selectgroup-label-content">
                      <span class="form-selectgroup-title strong mb-1">Uscita</span>
                      <span class="d-block text-muted">Tipologia di spesa che tende a diminuire il profitto aziendale</span>
                    </span>
                  </span>
                </label>
              </div>
            </div>
            <div class="row">
              <div class="col-lg-8">
                <div class="mb-3">
                  <label class="form-label">Somma della spesa</label>
                  <div class="input-group input-group-flat">
                    <input type="text" class="form-control pl-0" id="spesa" name="spesa" >
                  </div>
                </div>
              </div>
              <div class="col-lg-4">
                <div class="mb-3">
                  <label class="form-label">Valuta</label>
                  <select class="form-select">
                    <option value="1" selected>Euro</option>
                  </select>
                </div>
              </div>
            </div>
          </div>
          <div class="modal-body">
            <div class="row">
              
              <div class="col-lg-6">
                <div class="mb-3">
                  <label class="form-label">Data</label>
                  <input type="date" class="form-control" id="data" name="data">
                </div>
              </div>
              
            </div>
          </div>
          <div class="modal-footer">
            <a href="#" class="btn btn-link link-secondary" data-dismiss="modal">
              Annulla
            </a>
            <input type="submit" id="inserisci" name="inserisci"  class="btn btn-primary ml-auto" value="Inserisci nuova spesa">		
            
          </div>
        </div>
      </div>
      </form>
    </div>
    <!-- Libs JS -->
    <script src="./dist/libs/bootstrap/dist/js/bootstrap.bundle.min.js"></script>
    <script src="./dist/libs/jquery/dist/jquery.slim.min.js"></script>
    <script src="./dist/libs/apexcharts/dist/apexcharts.min.js"></script>
    <script src="./dist/libs/jqvmap/dist/jquery.vmap.min.js"></script>
    <script src="./dist/libs/jqvmap/dist/maps/jquery.vmap.world.js"></script>
    <script src="./dist/libs/peity/jquery.peity.min.js"></script>
    <!-- Tabler Core -->
    <script src="./dist/js/tabler.min.js"></script>
    <script>
      // @formatter:off
      document.addEventListener("DOMContentLoaded", function () {
      	window.ApexCharts && (new ApexCharts(document.getElementById('chart-revenue-bg'), {
      		chart: {
      			type: "area",
      			fontFamily: 'inherit',
      			height: 40.0,
      			sparkline: {
      				enabled: true
      			},
      			animations: {
      				enabled: false
      			},
      		},
      		dataLabels: {
      			enabled: false,
      		},
      		fill: {
      			opacity: .16,
      			type: 'solid'
      		},
      		stroke: {
      			width: 2,
      			lineCap: "round",
      			curve: "smooth",
      		},
      		series: [{
      			name: "Profits",
      			data: [37, 35, 44, 28, 36, 24, 65, 31, 37, 39, 62, 51, 35, 41, 35, 27, 93, 53, 61, 27, 54, 43, 19, 46, 39, 62, 51, 35, 41, 67]
      		}],
      		grid: {
      			strokeDashArray: 4,
      		},
      		xaxis: {
      			labels: {
      				padding: 0
      			},
      			tooltip: {
      				enabled: false
      			},
      			axisBorder: {
      				show: false,
      			},
      			type: 'datetime',
      		},
      		yaxis: {
      			labels: {
      				padding: 4
      			},
      		},
      		labels: [
      			'2020-06-20', '2020-06-21', '2020-06-22', '2020-06-23', '2020-06-24', '2020-06-25', '2020-06-26', '2020-06-27', '2020-06-28', '2020-06-29', '2020-06-30', '2020-07-01', '2020-07-02', '2020-07-03', '2020-07-04', '2020-07-05', '2020-07-06', '2020-07-07', '2020-07-08', '2020-07-09', '2020-07-10', '2020-07-11', '2020-07-12', '2020-07-13', '2020-07-14', '2020-07-15', '2020-07-16', '2020-07-17', '2020-07-18', '2020-07-19'
      		],
      		colors: ["#206bc4"],
      		legend: {
      			show: false,
      		},
      	})).render();
      });
      // @formatter:on
    </script>
    <script>
      // @formatter:off
      document.addEventListener("DOMContentLoaded", function () {
      	window.ApexCharts && (new ApexCharts(document.getElementById('chart-new-clients'), {
      		chart: {
      			type: "line",
      			fontFamily: 'inherit',
      			height: 40.0,
      			sparkline: {
      				enabled: true
      			},
      			animations: {
      				enabled: false
      			},
      		},
      		fill: {
      			opacity: 1,
      		},
      		stroke: {
      			width: [2, 1],
      			dashArray: [0, 3],
      			lineCap: "round",
      			curve: "smooth",
      		},
      		series: [{
      			name: "May",
      			data: [37, 35, 44, 28, 36, 24, 65, 31, 37, 39, 62, 51, 35, 41, 35, 27, 93, 53, 61, 27, 54, 43, 4, 46, 39, 62, 51, 35, 41, 67]
      		},{
      			name: "April",
      			data: [93, 54, 51, 24, 35, 35, 31, 67, 19, 43, 28, 36, 62, 61, 27, 39, 35, 41, 27, 35, 51, 46, 62, 37, 44, 53, 41, 65, 39, 37]
      		}],
      		grid: {
      			strokeDashArray: 4,
      		},
      		xaxis: {
      			labels: {
      				padding: 0
      			},
      			tooltip: {
      				enabled: false
      			},
      			type: 'datetime',
      		},
      		yaxis: {
      			labels: {
      				padding: 4
      			},
      		},
      		labels: [
      			'2020-06-20', '2020-06-21', '2020-06-22', '2020-06-23', '2020-06-24', '2020-06-25', '2020-06-26', '2020-06-27', '2020-06-28', '2020-06-29', '2020-06-30', '2020-07-01', '2020-07-02', '2020-07-03', '2020-07-04', '2020-07-05', '2020-07-06', '2020-07-07', '2020-07-08', '2020-07-09', '2020-07-10', '2020-07-11', '2020-07-12', '2020-07-13', '2020-07-14', '2020-07-15', '2020-07-16', '2020-07-17', '2020-07-18', '2020-07-19'
      		],
      		colors: ["#206bc4", "#a8aeb7"],
      		legend: {
      			show: false,
      		},
      	})).render();
      });
      // @formatter:on
    </script>
    <script>
      // @formatter:off
      document.addEventListener("DOMContentLoaded", function () {
      	window.ApexCharts && (new ApexCharts(document.getElementById('chart-active-users'), {
      		chart: {
      			type: "bar",
      			fontFamily: 'inherit',
      			height: 40.0,
      			sparkline: {
      				enabled: true
      			},
      			animations: {
      				enabled: false
      			},
      		},
      		plotOptions: {
      			bar: {
      				columnWidth: '50%',
      			}
      		},
      		dataLabels: {
      			enabled: false,
      		},
      		fill: {
      			opacity: 1,
      		},
      		series: [{
      			name: "Profits",
      			data: [37, 35, 44, 28, 36, 24, 65, 31, 37, 39, 62, 51, 35, 41, 35, 27, 93, 53, 61, 27, 54, 43, 19, 46, 39, 62, 51, 35, 41, 67]
      		}],
      		grid: {
      			strokeDashArray: 4,
      		},
      		xaxis: {
      			labels: {
      				padding: 0
      			},
      			tooltip: {
      				enabled: false
      			},
      			axisBorder: {
      				show: false,
      			},
      			type: 'datetime',
      		},
      		yaxis: {
      			labels: {
      				padding: 4
      			},
      		},
      		labels: [
      			'2020-06-20', '2020-06-21', '2020-06-22', '2020-06-23', '2020-06-24', '2020-06-25', '2020-06-26', '2020-06-27', '2020-06-28', '2020-06-29', '2020-06-30', '2020-07-01', '2020-07-02', '2020-07-03', '2020-07-04', '2020-07-05', '2020-07-06', '2020-07-07', '2020-07-08', '2020-07-09', '2020-07-10', '2020-07-11', '2020-07-12', '2020-07-13', '2020-07-14', '2020-07-15', '2020-07-16', '2020-07-17', '2020-07-18', '2020-07-19'
      		],
      		colors: ["#206bc4"],
      		legend: {
      			show: false,
      		},
      	})).render();
      });
      // @formatter:on
    </script>
    <script>
      // @formatter:off
      document.addEventListener("DOMContentLoaded", function () {
      	window.ApexCharts && (new ApexCharts(document.getElementById('chart-mentions'), {
      		chart: {
      			type: "bar",
      			fontFamily: 'inherit',
      			height: 240,
      			parentHeightOffset: 0,
      			toolbar: {
      				show: false,
      			},
      			animations: {
      				enabled: false
      			},
      			stacked: true,
      		},
      		plotOptions: {
      			bar: {
      				columnWidth: '50%',
      			}
      		},
      		dataLabels: {
      			enabled: false,
      		},
      		fill: {
      			opacity: 1,
      		},
      		series: [{
      			name: "Web",
      			data: [1, 0, 0, 0, 0, 1, 1, 0, 0, 0, 2, 12, 5, 8, 22, 6, 8, 6, 4, 1, 8, 24, 29, 51, 40, 47, 23, 26, 50, 26, 41, 22, 46, 47, 81, 46, 6]
      		},{
      			name: "Social",
      			data: [2, 5, 4, 3, 3, 1, 4, 7, 5, 1, 2, 5, 3, 2, 6, 7, 7, 1, 5, 5, 2, 12, 4, 6, 18, 3, 5, 2, 13, 15, 20, 47, 18, 15, 11, 10, 0]
      		},{
      			name: "Other",
      			data: [2, 9, 1, 7, 8, 3, 6, 5, 5, 4, 6, 4, 1, 9, 3, 6, 7, 5, 2, 8, 4, 9, 1, 2, 6, 7, 5, 1, 8, 3, 2, 3, 4, 9, 7, 1, 6]
      		}],
      		grid: {
      			padding: {
      				top: -20,
      				right: 0,
      				left: -4,
      				bottom: -4
      			},
      			strokeDashArray: 4,
      			xaxis: {
      				lines: {
      					show: true
      				}
      			},
      		},
      		xaxis: {
      			labels: {
      				padding: 0
      			},
      			tooltip: {
      				enabled: false
      			},
      			axisBorder: {
      				show: false,
      			},
      			type: 'datetime',
      		},
      		yaxis: {
      			labels: {
      				padding: 4
      			},
      		},
      		labels: [
      			'2020-06-20', '2020-06-21', '2020-06-22', '2020-06-23', '2020-06-24', '2020-06-25', '2020-06-26', '2020-06-27', '2020-06-28', '2020-06-29', '2020-06-30', '2020-07-01', '2020-07-02', '2020-07-03', '2020-07-04', '2020-07-05', '2020-07-06', '2020-07-07', '2020-07-08', '2020-07-09', '2020-07-10', '2020-07-11', '2020-07-12', '2020-07-13', '2020-07-14', '2020-07-15', '2020-07-16', '2020-07-17', '2020-07-18', '2020-07-19', '2020-07-20', '2020-07-21', '2020-07-22', '2020-07-23', '2020-07-24', '2020-07-25', '2020-07-26'
      		],
      		colors: ["#206bc4", "#79a6dc", "#bfe399"],
      		legend: {
      			show: true,
      			position: 'bottom',
      			height: 32,
      			offsetY: 8,
      			markers: {
      				width: 8,
      				height: 8,
      				radius: 100,
      			},
      			itemMargin: {
      				horizontal: 8,
      			},
      		},
      	})).render();
      });
      // @formatter:on
    </script>
    <script>
      // @formatter:on
      document.addEventListener("DOMContentLoaded", function() {
      	$('#map-world').vectorMap({
      		map: 'world_en',
      		backgroundColor: 'transparent',
      		color: 'rgba(120, 130, 140, .1)',
      		borderColor: 'transparent',
      		scaleColors: ["#d2e1f3", "#206bc4"],
      		normalizeFunction: 'polynomial',
      		values: (chart_data = {"af":16, "al":11, "dz":158, "ao":85, "ag":1, "ar":351, "am":8, "au":1219, "at":366, "az":52, "bs":7, "bh":21, "bd":105, "bb":3, "by":52, "be":461, "bz":1, "bj":6, "bt":1, "bo":19, "ba":16, "bw":12, "br":2023, "bn":11, "bg":44, "bf":8, "bi":1, "kh":11, "cm":21, "ca":1563, "cv":1, "cf":2, "td":7, "cl":199, "cn":5745, "co":283, "km":0, "cd":12, "cg":11, "cr":35, "ci":22, "hr":59, "cy":22, "cz":195, "dk":304, "dj":1, "dm":0, "do":50, "ec":61, "eg":216, "sv":21, "gq":14, "er":2, "ee":19, "et":30, "fj":3, "fi":231, "fr":2555, "ga":12, "gm":1, "ge":11, "de":3305, "gh":18, "gr":305, "gd":0, "gt":40, "gn":4, "gw":0, "gy":2, "ht":6, "hn":15, "hk":226, "hu":132, "is":12, "in":1430, "id":695, "ir":337, "iq":84, "ie":204, "il":201, "it":2036, "jm":13, "jp":5390, "jo":27, "kz":129, "ke":32, "ki":0, "kr":986, "undefined":5, "kw":117, "kg":4, "la":6, "lv":23, "lb":39, "ls":1, "lr":0, "ly":77, "lt":35, "lu":52, "mk":9, "mg":8, "mw":5, "my":218, "mv":1, "ml":9, "mt":7, "mr":3, "mu":9, "mx":1004, "md":5, "mn":5, "me":3, "ma":91, "mz":10, "mm":35, "na":11, "np":15, "nl":770, "nz":138, "ni":6, "ne":5, "ng":206, "no":413, "om":53, "pk":174, "pa":27, "pg":8, "py":17, "pe":153, "ph":189, "pl":438, "pt":223, "qa":126, "ro":158, "ru":1476, "rw":5, "ws":0, "st":0, "sa":434, "sn":12, "rs":38, "sc":0, "sl":1, "sg":217, "sk":86, "si":46, "sb":0, "za":354, "es":1374, "lk":48, "kn":0, "lc":1, "vc":0, "sd":65, "sr":3, "sz":3, "se":444, "ch":522, "sy":59, "tw":426, "tj":5, "tz":22, "th":312, "tl":0, "tg":3, "to":0, "tt":21, "tn":43, "tr":729, "tm":0, "ug":17, "ua":136, "ae":239, "gb":2258, "us":4624, "uy":40, "uz":37, "vu":0, "ve":285, "vn":101, "ye":30, "zm":15, "zw":5}),
      		onLabelShow: function (event, label, code) {
      			if (chart_data[code] > 0) {
      				label.append(': <strong>' + chart_data[code] + '</strong>');
      			}
      		},
      	});
      });
      // @formatter:off
    </script>
    <script>
      // @formatter:off
      document.addEventListener("DOMContentLoaded", function () {
      	window.ApexCharts && (new ApexCharts(document.getElementById('chart-development-activity'), {
      		chart: {
      			type: "area",
      			fontFamily: 'inherit',
      			height: 160,
      			sparkline: {
      				enabled: true
      			},
      			animations: {
      				enabled: false
      			},
      		},
      		dataLabels: {
      			enabled: false,
      		},
      		fill: {
      			opacity: .16,
      			type: 'solid'
      		},
      		title: {
      			text: "Development Activity",
      			margin: 0,
      			floating: true,
      			offsetX: 10,
      			style: {
      				fontSize: '18px',
      			},
      		},
      		stroke: {
      			width: 2,
      			lineCap: "round",
      			curve: "smooth",
      		},
      		series: [{
      			name: "Purchases",
      			data: [3, 5, 4, 6, 7, 5, 6, 8, 24, 7, 12, 5, 6, 3, 8, 4, 14, 30, 17, 19, 15, 14, 25, 32, 40, 55, 60, 48, 52, 70]
      		}],
      		grid: {
      			strokeDashArray: 4,
      		},
      		xaxis: {
      			labels: {
      				padding: 0
      			},
      			tooltip: {
      				enabled: false
      			},
      			axisBorder: {
      				show: false,
      			},
      			type: 'datetime',
      		},
      		yaxis: {
      			labels: {
      				padding: 4
      			},
      		},
      		labels: [
      			'2020-06-20', '2020-06-21', '2020-06-22', '2020-06-23', '2020-06-24', '2020-06-25', '2020-06-26', '2020-06-27', '2020-06-28', '2020-06-29', '2020-06-30', '2020-07-01', '2020-07-02', '2020-07-03', '2020-07-04', '2020-07-05', '2020-07-06', '2020-07-07', '2020-07-08', '2020-07-09', '2020-07-10', '2020-07-11', '2020-07-12', '2020-07-13', '2020-07-14', '2020-07-15', '2020-07-16', '2020-07-17', '2020-07-18', '2020-07-19'
      		],
      		colors: ["#206bc4"],
      		legend: {
      			show: false,
      		},
      		point: {
      			show: false
      		},
      	})).render();
      });
      // @formatter:on
    </script>
    <script>
      document.addEventListener("DOMContentLoaded", function () {
      	$().peity && $('#sparkline-7').text("56/100").peity("pie", {
      		width: 40,
      		height: 40,
      		stroke: "#cd201f",
      		strokeWidth: 2,
      		fill: ["#cd201f", "rgba(110, 117, 130, 0.2)"],
      		padding: .2,
      		innerRadius: 17,
      	});
      });
    </script>
    <script>
      document.addEventListener("DOMContentLoaded", function () {
      	$().peity && $('#sparkline-8').text("22/100").peity("pie", {
      		width: 40,
      		height: 40,
      		stroke: "#fab005",
      		strokeWidth: 2,
      		fill: ["#fab005", "rgba(110, 117, 130, 0.2)"],
      		padding: .2,
      		innerRadius: 17,
      	});
      });
    </script>
    <script>
      document.addEventListener("DOMContentLoaded", function () {
      	$().peity && $('#sparkline-9').text("17, 24, 20, 10, 5, 1, 4, 18, 13").peity("line", {
      		width: 64,
      		height: 40,
      		stroke: "#206bc4",
      		strokeWidth: 2,
      		fill: ["#d2e1f3"],
      		padding: .2,
      	});
      });
    </script>
    <script>
      document.addEventListener("DOMContentLoaded", function () {
      	$().peity && $('#sparkline-10').text("13, 11, 19, 22, 12, 7, 14, 3, 21").peity("line", {
      		width: 64,
      		height: 40,
      		stroke: "#206bc4",
      		strokeWidth: 2,
      		fill: ["#d2e1f3"],
      		padding: .2,
      	});
      });
    </script>
    <script>
      document.addEventListener("DOMContentLoaded", function () {
      	$().peity && $('#sparkline-11').text("10, 13, 10, 4, 17, 3, 23, 22, 19").peity("line", {
      		width: 64,
      		height: 40,
      		stroke: "#206bc4",
      		strokeWidth: 2,
      		fill: ["#d2e1f3"],
      		padding: .2,
      	});
      });
    </script>
    <script>
      document.addEventListener("DOMContentLoaded", function () {
      	$().peity && $('#sparkline-12').text("9, 6, 14, 11, 8, 24, 2, 16, 15").peity("line", {
      		width: 64,
      		height: 40,
      		stroke: "#206bc4",
      		strokeWidth: 2,
      		fill: ["#d2e1f3"],
      		padding: .2,
      	});
      });
    </script>
    <script>
      document.body.style.display = "block"
    </script>
  </body>
</html>