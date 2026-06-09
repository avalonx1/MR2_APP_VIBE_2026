<%@ page language="java" import="Engines.*,Database.*,java.util.*,java.util.regex.*, java.sql.*,javax.naming.*,javax.sql.*, java.lang.String"%>
<%
    
         String clientIP = request.getRemoteAddr();
         int v_statMaintenance=0;
         
         String v_userID = (String) session.getAttribute("session_userid"); 
         
         
        String path = request.getContextPath();
        String getProtocol=request.getScheme();
        String getDomain=request.getServerName();
        String getPort=Integer.toString(request.getServerPort());
        String getPath = getProtocol+"://"+getDomain+":"+getPort+path;
  
  
         String v_urlID="";
         String v_appNameDesc="";
         String v_appNameURL="";
         String v_debugMode="0";
         String v_betaMode="0";
         String v_headerTextMode="0";
         String v_headerTitleBgImage="0";
         String v_appVer="0";
         String v_appUpdateYear = "";
         String v_appCompany="";
         String v_imgProfileDefault="";
                 
         int v_homescreen_notif=0;
         int v_firstTimeLogin_notif=0;
         int v_NDAConfirmed_notif=0;
         
         
         auth au = new auth(clientIP);
         try {
         v_statMaintenance= au.isMaintenance();
         v_appNameDesc=au.getParamValue("APPNAMEDESC");
         v_appNameURL=au.getParamValue("APPNAMEURL");
         v_debugMode=au.getParamValue("DEBUG_MODE");
         v_betaMode=au.getParamValue("BETA_MODE");
         v_headerTextMode=au.getParamValue("HEADER_TITLETEXT_MODE");
         v_headerTitleBgImage=au.getParamValue("HEADER_TITLE_BG_IMAGE");
         v_appVer=au.getParamValue("APPVERSION");
         v_appUpdateYear=au.getParamValue("APPUPDATEYEAR");
         v_appCompany=au.getParamValue("APPCOMPANY");
         v_imgProfileDefault=au.getParamValue("IMG_PROFILE_DEFAULT");
                 
                 
                 
                 
         v_homescreen_notif=au.getHomescreenNotifStat(v_userID);
         v_firstTimeLogin_notif=au.getFirstTimeLoginStat(v_userID);
         v_NDAConfirmed_notif=au.getNDAConfirmedStat(v_userID);
         
         au.close();
         } catch (SQLException Sqlex) {
         out.println("<div class=sql>" + Sqlex.getMessage() + "</div>");
         } finally {
         au.close();
         }

         if (v_statMaintenance == 1) {
             response.sendRedirect("../maintenance.jsp");
         }
         
          String v_popup_notif_path="";
          
     
           if (v_firstTimeLogin_notif == 1) {
              v_popup_notif_path =getPath+"/views/etc/popup_notification/home_base.jsp?";
              v_popup_notif_path += "notifcode=FIRSTLOGNTF&act=1&notifcolumn=first_time_login";
              
             %>
             <script> window.location.href="<%=v_popup_notif_path%>"; </script>
             <%
         } else if (v_NDAConfirmed_notif == 1) {
             v_popup_notif_path =getPath+"/views/etc/popup_notification/home_base.jsp?";
              v_popup_notif_path += "notifcode=NDANTF&act=1&notifcolumn=nda_confirmed";
             %>
             <script> window.location.href="<%=v_popup_notif_path%>"; </script>
             <%
         } else if (v_homescreen_notif == 1) {
             
              v_popup_notif_path =getPath+"/views/etc/popup_notification/home_base.jsp?";
              v_popup_notif_path += "notifcode=POPNTF&act=1&notifcolumn=homescreen_notif";
              
             %>
             <script> window.location.href="<%=v_popup_notif_path%>"; </script>
             <%
         }

         
         
       
    if ((String) session.getAttribute("session_username") == null && (String) session.getAttribute("session_password") == null ) {
        response.sendRedirect("login.jsp");
    } else if ((String) session.getAttribute("session_username") != null) {
        
              
        String v_groupID = (String) session.getAttribute("session_group_id");
        String v_roleID = (String) session.getAttribute("session_role_id");
        String v_groupName = (String) session.getAttribute("session_group_name");
        String v_roleName = (String) session.getAttribute("session_role_name");
        String v_user_image_path = (String ) session.getAttribute("session_image_path");
        
        String v_firstName = (String) session.getAttribute("session_first_name");
        String v_lastName = (String) session.getAttribute("session_last_name");

  
        String url = "welcome.jsp";
       
       
        //out.println(modul_id+" "+url);
%>

          <div class="">
            <div class="page-title">
              <div class="title_left">
                <h3>Users <small>Some examples to get you started</small></h3>
              </div>

              <div class="title_right">
                <div class="col-md-5 col-sm-5 col-xs-12 form-group pull-right top_search">
                  <div class="input-group">
                    <input type="text" class="form-control" placeholder="Search for...">
                    <span class="input-group-btn">
                      <button class="btn btn-default" type="button">Go!</button>
                    </span>
                  </div>
                </div>
              </div>
            </div>

            <div class="clearfix"></div>

            <div class="row">
              

             
              <!-- table widget -->
              <div class="col-md-12 col-sm-12 col-xs-12">
                <div class="x_panel">
                  <div class="x_title">
                    <h2>Table Example <small>Users</small></h2>
                    <ul class="nav navbar-right panel_toolbox">
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
                      The Buttons extension for DataTables provides a common set of options, API methods and styling to display buttons on a page that will interact with a DataTable. The core library provides the based framework upon which plug-ins can built.
                    </p>
                    <table id="datatable" class="table table-striped table-bordered dt-responsive nowrap bulk_action" cellspacing="0" width="100%" >
                      <thead>
                        <tr>
                          <th>id</th>
                          <th>Nama</th>
                          <th>Alamat</th>
                          <th>Saldo</th>
                          </tr>
                      </thead>


                      
                    </table>
                  </div>
                </div>
              </div>

              
            </div>
          </div>
        <!-- /page content -->

    <!-- JS Main -->
    <script>
      $(document).ready(function() {
          
          var progress = null;
                
                $("#loading").show();
                progress = $.ajax({
                    type: 'POST',
                    url: "<%=url%>",
                    data: "",
                    cache:false,
                    success: function(d) {
                        $("#content-right").empty();
                        $("#content-right").html(d);
                        $("#content-right").show();
                    },
                    complete: function(){
                        $("#loading").hide();
                        progress = null;
                    }	});
          
          
          
          
          
                
        $('#datatable').DataTable( {
        processing: true,
        serverSide: true,
        searching: true,
        scrollX: true,
        ajax: {url:'data_table_test.jsp',type: 'POST'}
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


<%} else {
    response.sendRedirect("../oops.jsp");
}
%>