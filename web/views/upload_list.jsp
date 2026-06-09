<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%--<%@include file="/includes/check_auth_layer3.jsp"%>--%>

<!--<div class="x_panel">-->
    
          <div class="row">
            <div class="col-md-12 col-sm-12 col-xs-12 x_panel" style="font-size: 0.975em;">
               <!--<div class="x_panel" style="height: 300px; font-size: 1em;">-->
              <!--<div class="dashboard_graph">-->
              <div class="">
                <div class="page-title x_title">
                    <div class="title_left">
                        <h3><i class="fa fa-list"></i> Upload List Data </h3>
                    </div>
                </div>
            </div>
               <div class="clearfix"></div>
                <div class="row">
                  <!--<div class="col-md-6">-->
<div class="x_content">
           <div class="table-responsive" > 
                    <!--<p class="text-muted font-12 m-b-30"></p>-->
                    <table id="datatable" class="table table-striped table-bordered dt-responsive nowrap jambo_table" cellspacing="0"  width="100%" >
                        <!--<table id="datatable" class="table table-striped table-bordered dt-responsive nowrap" cellspacing="0" width="100%" >-->
                        <!--<table id="datatable" class="table table-bordered table-hover table-striped">-->
                       <!--<table id="datatable" class="table table-striped table-bordered dataTable no-footer" role="grid" aria-describedby="datatable-fixed-header_info">-->
                            <!--<table id="datatable" class="table table-striped responsive-utilities jambo_table">-->
                        <!--<table id="datatable" class="select-checkbox shoting_disabled table table-striped table-bordered dt-responsive nowrap" cellspacing="0"  style="width: 650px;" >-->
                        <thead>
                         <tr>
                          <th>Action</th>
                          <th>Confirmation</th>
                          <th>Report Name</th>
                          <th>Month</th>
                          <th>Submit Date </th>
                         </tr>
                      </thead>                      
                    </table>
                  </div>
              </div>                 
            </div>
          </div>  
          </div>
    
          <br/>

          <div class="row"></div>
<script>
    
    
$(document).ready(function() {
    
   $('#datatable').DataTable( {
//       sScrollX: "100%",
//    sScrollXInner": "110%",
//        fixedHeader: true,
//        deferRender: true,
//        scrollY: 380,
//        processing: true,
//        serverSide: true,
//        searching: true,
//        scrollX: true,
//        select: true,
        
        processing: true,
        serverSide: true,
        searching: true,
        scrollX: true,
        select: true,
        
        dom: "Bfrtip",
            lengthMenu: [
                        [ 10, 25, 50, 100 ],
                        [ '10 rows', '25 rows', '50 rows', '100 rows' ]
            ],
            buttons: [  
                {
                  extend: 'copyHtml5',
                  exportOptions: {
                    columns: [1,2,3,4]
                   }
                },
                {
                  extend: 'csv',
                  exportOptions: {
                    columns: [1,2,3,4]
                   }
                },
                'pageLength',
                'colvis'
        ],
            responsive: true,
//             "ordering": true,
//            "bFilter": true,
//            filters: [true, 'select'],
            ajax: {url:'upload_list_json.jsp',type: 'POST'},
//            fixedColumns:   
//                    {
//            leftColumns: 5,
//            rightColumns: 5}, 
//            "columnDefs": [
//                { "width": "10%", "targets": 2 }
//              ],
//              "columnDefs": [
//                { "type": "alt-string", "targets": 2 }
//              ],
//              "order": [[ 1, 'asc' ], [ 2, 'asc' ]],
//              "order": [[ 1, 'asc' ]],
//            "aaSorting": [[ 3, "desc" ]],
//        bSortable: true,
//        bRetrieve: true,
//        aoColumnDefs: [
//        {className: "no-sort", "targets": [0]}
//            { "action": [ 1 ], "bSortable": true },
//            { "status": [ 2 ], "bSortable": true },
//            { "laporan_detail": [ 3 ], "bSortable": true }
//        ],
            columns: [
                { "data": "action" },
                { "data": "status" },
                { "data": "laporan_detail"},
                { "data": "month_sid" },
                { "data": "upload_date" }
                ]
                
                });  
//   setTimeout(function () {
//                oTable.fnAdjustColumnSizing();
//            }, 10);                                                                                                                                                                                                                                                                                                                                                                                 
            });
                
</script>