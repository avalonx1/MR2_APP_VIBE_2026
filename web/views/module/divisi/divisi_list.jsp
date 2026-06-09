<%@include file="../../../includes/check_auth_layer3.jsp"%>


          <div class="">
            <div class="page-title">
              <div class="title_left">
                <h3><i class="fa fa-group"></i> Division </h3>
              </div>

            </div>

            <div class="clearfix"></div>

            <div class="row">

              <!-- table widget -->
              <div class="col-md-12 col-sm-12 col-xs-12">
                <div class="x_panel">
                    
                  <div class="x_title">
                    <h2>List Of Division <small></small></h2>
                    
                    <ul class="nav navbar-right panel_toolbox">
                        <li>      
                          <button id="goto_modifyDivisi" class="btn navbar-right panel_toolbox btn-danger"><a ><font color="#fff"> + New Division </font></a></button>
                        </li>
                      <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
                      </li>
                      <li class="dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" ><i class="fa fa-wrench"></i></a>
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
                    <table id="datatable" class="table table-striped table-bordered dt-responsive nowrap jambo_table" cellspacing="0" width="100%" >
                      <thead>
                        <tr>
                          <th>Action</th>
                          <th>Division Code</th>
                          <th>Division Name</th>
                         </tr>
                      </thead>                      
                    </table>
                  </div>
                </div>
              </div>              
            </div>
          </div>
  

    <script>
      $(document).ready(function() {

          $("#goto_modifyDivisi").click(function() {
     
                       $("#loading").show();
                       $.ajax({
                        type: "POST",
                        url: "module/divisi/divisi_list_modify.jsp",
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
                    columns: [1,2]
                   }
                },
                {
                  extend: "csv",
                  exportOptions: {
                    columns: [1,2]
                   }
                },
                'pageLength',
                'colvis'
        ],
        responsive: true,
        ajax: {url:'module/divisi/divisi_list_json.jsp',type: 'POST'},
        columns: [
            { "data": "action" },
            { "data": "div_id" },
            { "data": "divisi" }
            ]
        });
        
      });
      
    </script>
 