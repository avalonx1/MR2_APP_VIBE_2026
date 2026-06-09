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

  
        String url = "home.jsp";
       
        
       
        //out.println(modul_id+" "+url);
%>

<!DOCTYPE html>
<html lang="en">
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <!-- Meta, title, CSS, favicons, etc. -->
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title><%=v_appNameURL%></title>

    
    <%@include file="../includes/css_load.jsp" %>
    
  </head>

  <body class="nav-md footer_fixed">
    <div class="container body">
      <div class="main_container">
        <div class="col-md-3 left_col">
          <div class="left_col scroll-view">
            <div class="navbar nav_title" style="border: 0;">
              <a href="index.jsp" class="site_title"><i class="fa fa-sellsy"></i> <span><%=v_appNameURL%></span></a>
            </div>

            <div class="clearfix"></div>

            <!-- menu profile quick info -->
            <div class="profile">
              <div class="profile_pic">
                  <img src="<%=v_user_image_path%>" alt="<%=v_user_image_path%>" onerror="if (this.src != '<%=v_imgProfileDefault%>') this.src = '<%=v_imgProfileDefault%>';' " class="img-circle profile_img">
              </div>
              <div class="profile_info">
                <span>Welcome,</span>
                <h2><%=v_firstName%></h2>
              </div>
            </div>
    
            <!-- /menu profile quick info -->

            <br />

            <!-- sidebar menu -->
            <div id="sidebar-menu" class="main_menu_side hidden-print main_menu">
              <div class="menu_section">
                <h3><%=v_roleName%></h3>
                <ul class="nav side-menu">
                  <li><a id="goto_home"><i class="fa fa-home"></i> Home</a>
                  </li>
                  
            
                  <li><a href="project_detail_dev.html"><i class="fa fa-star showopacity glyphicon glyphicon-th-list"></i>Opportunities</a>
                  </li>
                  <li><a id="goto_leads" ><i class="fa fa-child"></i>Leads</a>
                  </li>
                  <li><a href="tables_list_leads2.html"><i class="fa fa-building"></i>Accounts</a>
                  </li>
                  <li><a href="tables_list_leads2.html"><i class="fa fa-book"></i>Contacts</a>
                  </li>
                  <li><a href="projects_dev.html"><i class="fa fa-google-wallet"></i>Products</a>
                  </li>
                  <li><a href="project_detail_dev.html"><i class="fa fa-bullseye"></i>Campaigns</a>
                  </li>
                  <li><a href="project_detail_dev.html"><i class="fa fa-tasks"></i>Tasks</a>
                  </li>
                  <li><a href="profile_dev.html"><i class="fa fa-users"></i>Groups</a>
                  </li>
                  <li><a href="profile_dev.html"><i class="fa fa-gears"></i>Roles</a>
                  </li>
                  <li><a href="profile_dev.html"><i class="fa fa-user"></i>Users</a>
                  </li>
                  <li><a id="goto_lov"><i class="fa fa-list"></i>List Of Value</a>
                  </li>
                </ul>
              </div>
              
                

            </div>
            <!-- /sidebar menu -->

            <!-- /menu footer buttons -->
            <div class="sidebar-footer hidden-small">
              <a data-toggle="tooltip" data-placement="top" title="Settings">
                <span class="glyphicon glyphicon-cog" aria-hidden="true"></span>
              </a>
              <a data-toggle="tooltip" data-placement="top" title="FullScreen">
                <span class="glyphicon glyphicon-fullscreen" aria-hidden="true"></span>
              </a>
              <a data-toggle="tooltip" data-placement="top" title="Lock">
                <span class="glyphicon glyphicon-eye-close" aria-hidden="true"></span>
              </a>
              <a data-toggle="tooltip" data-placement="top" title="Logout">
                <span class="glyphicon glyphicon-off" aria-hidden="true"></span>
              </a>
            </div>
            <!-- /menu footer buttons -->
          </div>
        </div>

        <!-- top navigation -->
        <div class="top_nav">
          <div class="nav_menu">
            <nav>
              <div class="nav toggle">
                <a id="menu_toggle"><i class="fa fa-bars"></i></a>
              </div>

              <ul class="nav navbar-nav navbar-right">
                <li class="">
                  <a href="javascript:;" class="user-profile dropdown-toggle" data-toggle="dropdown" aria-expanded="false">
                    <img src="<%=v_user_image_path%>" alt="Profile Image" onerror="if (this.src != '<%=v_imgProfileDefault%>') this.src = '<%=v_imgProfileDefault%>';' "  ><%=v_firstName%>
                    <span class=" fa fa-angle-down"></span>
                  </a>
                  <ul class="dropdown-menu dropdown-usermenu pull-right">
                    <li><a href="javascript:;"> Profile</a></li>
                    <li>
                      <a href="javascript:;">
                        <span class="badge bg-red pull-right">50%</span>
                        <span>Settings</span>
                      </a>
                    </li>
                    <li><a href="javascript:;">Help</a></li>
                    <li><a href="logout.jsp"><i class="fa fa-sign-out pull-right"></i> Log Out</a></li>
                  </ul>
                </li>

                <li role="presentation" class="dropdown">
                  <a href="javascript:;" class="dropdown-toggle info-number" data-toggle="dropdown" aria-expanded="false">
                    <i class="fa fa-envelope-o"></i>
                    <span class="badge bg-green">6</span>
                  </a>
                  <ul id="myinbox" class="dropdown-menu list-unstyled msg_list" role="menu">
                    <li>
                      <a>
                          <span class="image"><img src="" alt="Profile Image" /></span>
                        <span>
                          <span><%=v_firstName%></span>
                          <span class="time">3 mins ago</span>
                        </span>
                        <span class="message">
                          Film festivals used to be do-or-die moments for movie makers. They were where...
                        </span>
                      </a>
                    </li>
                    <li>
                      <a>
                        <span class="image"><img src="images/img.jpg" alt="Profile Image" /></span>
                        <span>
                          <span>Gumilar</span>
                          <span class="time">3 mins ago</span>
                        </span>
                        <span class="message">
                          Film festivals used to be do-or-die moments for movie makers. They were where...
                        </span>
                      </a>
                    </li>
                    <li>
                      <a>
                        <span class="image"><img src="images/img.jpg" alt="Profile Image" /></span>
                        <span>
                          <span>Gumilar</span>
                          <span class="time">3 mins ago</span>
                        </span>
                        <span class="message">
                          Film festivals used to be do-or-die moments for movie makers. They were where...
                        </span>
                      </a>
                    </li>
                    <li>
                      <a>
                        <span class="image"><img src="images/img.jpg" alt="Profile Image" /></span>
                        <span>
                          <span>Gumilar</span>
                          <span class="time">3 mins ago</span>
                        </span>
                        <span class="message">
                          Film festivals used to be do-or-die moments for movie makers. They were where...
                        </span>
                      </a>
                    </li>
                    <li>
                      <div class="text-center">
                        <a>
                          <strong>See All Alerts</strong>
                          <i class="fa fa-angle-right"></i>
                        </a>
                      </div>
                    </li>
                  </ul>
                </li>
              </ul>
            </nav>
          </div>
        </div>
        <!-- /top navigation -->

        <!-- page content -->
        <div id="maincontent" class="right_col" role="main">
         
            <div id="loading">
                <ul class="bokeh">
                    <li></li>
                    <li></li>
                    <li></li>
                </ul>
            </div>
            
        </div>
                
        <!-- /page content -->

        <!-- footer content -->
        <footer>
          <div class="pull-right">
           <%=v_appNameDesc%> Version <%=v_appVer%>    <%=v_appUpdateYear%> &copy; <%=v_appCompany%> 
          </div>
          <div class="clearfix"></div>
        </footer>
        <!-- /footer content -->
      </div>
    </div>

          
    <%@include file="../includes/javascript.jsp" %>
    
    <!-- JS Main -->
    <script type=text/javascript>
     
          $(document).ready(function() {
          
          
          
          new PNotify({
          title: "PNotify",
          type: "info",
          text: "Welcome, Selamat Datang di Aplikasi Muamalat Sales Tracking.<br/>Aplikasi ini adalah Prototype yang sedang IT Kembangkan,<br/> Have a Nice Day!",
          addclass: 'dark',
          styling: 'bootstrap3',
          before_close: function(PNotify) {
            PNotify.update({
              title: PNotify.options.title + " - Enjoy your Stay",
              before_close: null
            });

            PNotify.queueRemove();

            return false;
          }
        });
        
        
    
    
    
          var cliknav_progress = null;
          
           $("#loading").show();
            cliknav_progress=$.ajax({
                    type: 'POST',
                    url: "<%=url%>",
                    data: "",
                    cache:false,
                    success: function(d) {
                        $("#maincontent").empty();
                        $("#maincontent").html(d);
                        $("#maincontent").show();
                    },
                    complete: function(){
                        $("#loading").hide();
                        cliknav_progress = null;
            }});
          

           $("#goto_home").click(function() {
          
                    if (cliknav_progress) {
                    cliknav_progress.abort();
                    }
                    
                    $("#loading").show();
                    cliknav_progress=$.ajax({
                    type: 'POST',
                    url: "home.jsp",
                    data: "",
                    cache:false,
                    success: function(d) {
                        $("#maincontent").empty();
                        $("#maincontent").html(d);
                        $("#maincontent").show();
                    },
                    complete: function(){
                        $("#loading").hide();
                        cliknav_progress = null;
                        
                        
                        
                        
                     }});
              
           });
           
           $("#goto_leads").click(function() {
          
                        if (cliknav_progress) {
                        cliknav_progress.abort();
                        }

                        $("#loading").show();
                        cliknav_progress=$.ajax({
                        type: 'POST',
                        url: "module/leads/leads_list.jsp",
                        data: "",
                        cache:false,
                        success: function(d) {
                            $("#maincontent").empty();
                            $("#maincontent").html(d);
                            $("#maincontent").show();
                        },
                        complete: function(){
                            $("#loading").hide();
                            cliknav_progress = null;

                         }});
              
                     });     
                     
           
                   $("#goto_lov").click(function() {
          
          
                  
          
                        if (cliknav_progress) {
                        cliknav_progress.abort();
                        }

                        $("#loading").show();
                        cliknav_progress=$.ajax({
                        type: 'POST',
                        url: "module/lov/lov_list.jsp",
                        data: "",
                        cache:false,
                        success: function(d) {
                            $("#maincontent").empty();
                            $("#maincontent").html(d);
                            $("#maincontent").show();
                        },
                        complete: function(){
                            $("#loading").hide();
                            cliknav_progress = null;

                         }});
              
                     });            
           
           

           });
           
           
         
    </script>
               
                
  </body>
</html>


<%} else {
    response.sendRedirect("../oops.jsp");
}
%>