 <%@include file="../../../includes/check_auth_layer3.jsp"%>

          <div class="">
            <div class="page-title">
              <div class="title_left">
                <h3><i class="fa fa-universal-access"></i> Users Access</h3>
              </div>
            </div>

            <div class="clearfix"></div>

            <div class="row">
              

              <!-- table widget -->
              <div class="col-md-12 col-sm-12 col-xs-12">
                <div class="x_panel">
                    
                  <div class="x_title">
                    <h2>List Of Users Access <small></small></h2>
                    
                    <ul class="nav navbar-right panel_toolbox">
                        <li>      
                          <button id="goto_modifyUser" class="btn navbar-right panel_toolbox btn-danger"><a ><font color="#fff"> + New User Access </font></a></button>
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
                          <!--<th>Matrix ID</th>-->
                          <th>NIK</th>
                          <th>First Name</th>
                          <th>Last Name</th>
                          <th>Divisi</th>
                          <!--<th>Role ID</th>-->
                          <th>Role Name</th>
                         </tr>
                      </thead>                      
                    </table>
                  </div>
                </div>
              </div>              
            </div>
          </div>
        <!-- /page content -->


    <script>
      $(document).ready(function() {
          
          
          
          $("#goto_modifyUser").click(function() {
     
                       $("#loading").show();
                       $.ajax({
                        type: "POST",
                        url: "module/user_access/user_acs_list_modify.jsp",
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
//                {
//                  extend: "copyHtml5",
//                  exportOptions: {
//                    columns: [1,2,3,4,5,6,7]
//                   }
//                },
//                {
//                  extend: "csv",
//                  exportOptions: {
//                    columns: [1,2,3,4,5,6,7]
//                   }
//                },
                'csv',
                'excel'
//                'colvis'
        ],
        responsive: true,
        ajax: {url:'module/user_access/user_acs_list_json.jsp',type: 'POST'},
        columns: [
            { "data": "action" },
//            { "data": "id" },
            { "data": "username" },
            { "data": "first_name" },
            { "data": "last_name" },
            { "data": "divisi" },
//            { "data": "role_id" },
            { "data": "role_name" }
            ]
        });


      });
    </script>

