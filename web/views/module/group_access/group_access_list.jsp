<%@include file="../../../includes/check_auth_layer3.jsp"%>

          <div class="">
            <div class="page-title">
              <div class="title_left">
                <h3><i class="fa fa-key"></i> Group Access </h3>
              </div>

            </div>

            <div class="clearfix"></div>

            <div class="row">
              

             
              <!-- table widget -->
              <div class="col-md-12 col-sm-12 col-xs-12">
                <div class="x_panel">
                    
                  <div class="x_title">
                    <h2>List Of Group Access <small></small></h2>
                    
                    <ul class="nav navbar-right panel_toolbox">
                        <li>      
                          <button id="goto_modifyGroup" class="btn navbar-right panel_toolbox btn-danger"><a ><font color="#fff"> + New Group Access </font></a></button>
                        </li>
                      <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
                      </li>
                      <li class="dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false"><i class="fa fa-wrench"></i></a>
                        <ul class="dropdown-menu" role="menu">
                          <li><a href="#">Settings 1</a>
                          </li>
                          <li><a href="#">Settings 2</a>
                          </li>
                        </ul>
                      </li>
                      <li><a class="close-link"><i class="fa fa-close"></i></a>
                      </li>
                    </ul>
                    <div class="clearfix"></div>
                  </div>
                  <div class="x_content">
                    <p class="text-muted font-13 m-b-30">
                      
                    </p>
                    <table id="datatable" class="table table-striped table-bordered dt-responsive nowrap" cellspacing="0" width="100%" >
                      <thead>
                        <tr>
                          <th>Action</th>
                          <th>ID</th>
                          <th>Group Code</th>
                          <th>Group Name</th>
                          
                          <th>Member Code</th>
                          <th>Member name</th>
                         </tr>
                      </thead>                      
                    </table>
                  </div>
                </div>
              </div>              
            </div>
          </div>
        <!-- /page content -->

         <!-- Datatables -->

    <!-- JS Main -->
    <script>
      $(document).ready(function() {
          
          $("#goto_modifyGroup").click(function() {
     
                       $("#loading").show();
                       $.ajax({
                        type: "POST",
                        url: "module/group_access/group_access_list_modify.jsp",
                        data: "",
                        cache:false,
                        success: function(d) {
                            $("#maincontent").empty();
                            $("#maincontent").html(d);
                            $("#maincontent").show();
                        },
                        complete: function(){
                            $("#loading").hide();
                         }});

           });

        $('#datatable').DataTable( {
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
                  extend: "copyHtml5",
                  exportOptions: {
                    columns: [1,2,3,4,5,6,7]
                   }
                },
                {
                  extend: "csv",
                  exportOptions: {
                    columns: [1,2,3,4,5,6,7]
                   }
                },
                'pageLength',
                'colvis'
        ],
        responsive: true,
        ajax: {url:'module/group_access/group_access_list_json.jsp',type: 'POST'},
        columns: [
            { "data": "action" },
            { "data": "id" },
            { "data": "group_code" },
            { "data": "group_name" },
            { "data": "member_code" },
            { "data": "member_name" }
            ]
        });
        
        var handleDataTableButtons = function() {
          if ($("#datatable-buttons").length) {
            $("#datatable-buttons").DataTable({
              dom: "Bfrtip",
              buttons: [
                {
                  extend: "copy",
                  className: "btn-sm"
                },
                {
                  extend: "csv",
                  className: "btn-sm"
                },
                {
                  extend: "pdfHtml5",
                  className: "btn-sm"
                },
                {
                  extend: "print",
                  className: "btn-sm"
                }
              ],
              responsive: true
            });
          }
        };

        TableManageButtons = function() {
          "use strict";
          return {
            init: function() {
              handleDataTableButtons();
            }
          };
        }();


        
        var $datatable = $('#datatable-checkbox');

        $datatable.dataTable({
          'order': [[ 1, 'asc' ]],
          'columnDefs': [
            { orderable: false, targets: [0] }
          ]
        });
        $datatable.on('draw.dt', function() {
          $('input').iCheck({
            checkboxClass: 'icheckbox_flat-green'
          });
        });

        TableManageButtons.init();
      });
      
    </script>
    <!-- /Datatables -->