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
         String v_appImageLogo="";
                 
         int v_homescreen_notif=0;
         int v_firstTimeLogin_notif=0;
         int v_NDAConfirmed_notif=0;
         
         
         auth au = new auth(clientIP);
         try {
         v_statMaintenance= au.isMaintenance();
         v_appNameDesc=au.getParamValue("APPNAMEDESC");
         v_appNameURL=au.getParamValue("APPNAMEURL");
         v_appImageLogo=au.getParamValue("APPIMGLOGO");
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
      <!--<link rel="icon" type="image/png" sizes="32x32" href="/favicon-32x32.png">-->
      <link rel="icon" type="image/png" sizes="32x32" href="images/favicon-32x32.png">
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
              <a href="index.jsp" class="site_title"><img src="images/BMI_LOGO.png"  width="50" height="50"> <span><%=v_appNameURL%></span></a>
            </div>

            <div class="clearfix"></div>

            <!-- menu profile quick info -->
            <div class="profile">
              <div class="profile_pic">
                  <img src="<%=v_user_image_path != null ? v_user_image_path : "images/man.png"%>" alt="Profile" onerror="this.src = 'images/man.png'" class="img-circle profile_img">
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
                    
                    <%
                    
                    String id_menu="";
                    String disp_name_menu="";
                    String url_menu="";
                    String icon_name_menu="";
                    String id_parent_menu="";
                    String leaf_stat="";
                    
                    try {
                                        ResultSet resultSet=null;
                                        Database db = new Database();
                                        try {
                                            db.connect(1);
                                            String sql;
                                            sql = "select id,disp_name,url,icon_name,ordernum,id_parent,leaf_stat from v_menu_access_lvl1 where user_id=3 ";
                                            resultSet = db.executeQuery(sql);
                                            while (resultSet.next()) {
                                              
                                                id_menu=resultSet.getString("id");
                                                disp_name_menu=resultSet.getString("disp_name");
                                                url_menu=resultSet.getString("id_parent");
                                                icon_name_menu=resultSet.getString("icon_name");
                                                id_parent_menu=resultSet.getString("id_parent");
                                                leaf_stat=resultSet.getString("leaf_stat");
                                               
                                                
                                                %>
                                                
                                                
                                                <li><a id="goto_<%=id_menu%>"><i class="fa <%=icon_name_menu%>"></i><%=disp_name_menu%></a>
                                                </li>
                                                <script type=text/javascript> 
                                                    $(document).ready(function() {
                                                        
                                                        
                                                $("#goto_<%=id_menu%>").click(function() {

                                                            if (cliknav_progress) {
                                                            cliknav_progress.abort();
                                                            }

                                                            $("#loading").show();
                                                            cliknav_progress=$.ajax({
                                                            type: 'POST',
                                                            url: "<%=url_menu%>",
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
           
                                                <li><a id="goto_leads" ><i class="fa fa-child"></i>Leads</a>
                                                </li>
                                                <li><a id="goto_opp"><i class="fa fa-star"></i>Opportunities</a>
                                                </li>
                                                <li><a id="goto_acc"><i class="fa fa-user"></i>Accounts</a>
                                                </li>
                                                <li><a id="goto_cont"><i class="fa fa-book"></i>Contacts</a>
                                                </li>
                                                <li><a id="goto_product"><i class="fa fa-cubes"></i>Products</a>
                                                </li>
                                                <li><a id="goto_camp"><i class="fa fa-flag"></i>Campaigns</a>
                                                </li>
                                                <li><a id="goto_task"><i class="fa fa-tasks"></i>Tasks</a>
                                                </li>
                                                <li><a id="goto_roles"><i class="fa fa-gears"></i>Roles</a>
                                                </li>
                                                
                                                
                                                
                                                <%
                                            }
                                            resultSet.close();
                                        } catch (SQLException Sqlex) {
                                            out.println("<div class=sql>" + Sqlex.getMessage() + "</div>");
                                        } finally {
                                            db.close();
                                             if (resultSet != null) resultSet.close(); 
                                        }
                                    } catch (Exception except) {
                                        out.println("<div class=sql>" + except.getMessage() + "</div>");
                                    }
                    
                    
                    %>
                    
                    
                  
                  <li class="active"><a><i class="fa fa-users"></i> Group Management <span class="fa fa-chevron-down"></span></a>
                    <ul class="nav child_menu" style="display: block;">
                        <li><a id="goto_group"><small><i class="fa fa-users"></i></small> Groups </a></li>
                       <li><a id="goto_member"><i class="fa fa-list-ul"></i> Members </a></li>
                       <li><a id="goto_group_access"><i class="fa fa-key"></i> Group Access </a></li>
                    </ul>
                  </li>
                  <li class="active"><a><i class="fa fa-desktop"></i> User Management <span class="fa fa-chevron-down"></span></a>
                    <ul class="nav child_menu" style="display: block;">
                       <li><a id="goto_user"><i class="fa fa-list-ul"></i> Users </a></li>
                       <li><a id="goto_user_matrix"><i class="fa fa-key"></i> User Access </a></li>
                    </ul>
                  </li>
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
                    <img src="<%=v_user_image_path != null ? v_user_image_path : "images/man.png"%>" alt="Profile Image" onerror="this.src = 'images/man.png'"  ><%=v_firstName%>
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
        <div class="right_col" role="main">
         
        <div id="loading">
                <ul class="bokeh">
                    <li></li>
                    <li></li>
                    <li></li>
                </ul>
        </div>
        
        <div id="maincontent" ></div>
         
        
        
        </div>
            
            
        <!-- /page content -->

        <!-- footer content -->
        <footer>
          <div class="pull-right">
           <%=v_appNameDesc%> Version <%=v_appVer%>. Copyright &copy; <%=v_appUpdateYear%> <%=v_appCompany%>. All Right Reserved.
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
          title: "Welcome ",
          type: "info ",
          text: "Selamat Datang di Aplikasi Muamalat Sales Tracking.<br/>Aplikasi ini adalah Prototype yang sedang IT Kembangkan,<br/> Have a Nice Day!",
          addclass: 'info',
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
                     
                     
                     
                     $("#goto_opp").click(function() {
          
                        if (cliknav_progress) {
                        cliknav_progress.abort();
                        }

                        $("#loading").show();
                        cliknav_progress=$.ajax({
                        type: 'POST',
                        url: "module/opp/opp_list.jsp",
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
           
           
                    $("#goto_acc").click(function() {
          
                        if (cliknav_progress) {
                        cliknav_progress.abort();
                        }

                        $("#loading").show();
                        cliknav_progress=$.ajax({
                        type: 'POST',
                        url: "module/acc/acc_list.jsp",
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
                     
                     
                     $("#goto_cont").click(function() {
          
                        if (cliknav_progress) {
                        cliknav_progress.abort();
                        }

                        $("#loading").show();
                        cliknav_progress=$.ajax({
                        type: 'POST',
                        url: "module/cont/cont_list.jsp",
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
                     
                     
                     $("#goto_product").click(function() {
          
                        if (cliknav_progress) {
                        cliknav_progress.abort();
                        }

                        $("#loading").show();
                        cliknav_progress=$.ajax({
                        type: 'POST',
                        url: "module/product/product_list.jsp",
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
                     
                     
                     $("#goto_camp").click(function() {
          
                        if (cliknav_progress) {
                        cliknav_progress.abort();
                        }

                        $("#loading").show();
                        cliknav_progress=$.ajax({
                        type: 'POST',
                        url: "module/camp/camp_list.jsp",
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
                     
                     
                     $("#goto_wizard").click(function() {
          
                        if (cliknav_progress) {
                        cliknav_progress.abort();
                        }

                        $("#loading").show();
                        cliknav_progress=$.ajax({
                        type: 'POST',
                        url: "module/leads/leads_list_wizard_main.jsp",
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
                     
                     
                     $("#goto_task").click(function() {
          
                        if (cliknav_progress) {
                        cliknav_progress.abort();
                        }

                        $("#loading").show();
                        cliknav_progress=$.ajax({
                        type: 'POST',
                        url: "module/task/task_list.jsp",
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
                     
                     
                      $("#goto_roles").click(function() {
          
                        if (cliknav_progress) {
                        cliknav_progress.abort();
                        }

                        $("#loading").show();
                        cliknav_progress=$.ajax({
                        type: 'POST',
                        url: "module/roles/roles_list.jsp",
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
                     
                     
                     $("#goto_group").click(function() {
          
                        if (cliknav_progress) {
                        cliknav_progress.abort();
                        }

                        $("#loading").show();
                        cliknav_progress=$.ajax({
                        type: 'POST',
                        url: "module/group/group_list.jsp",
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
                     
                     
                     
                     
                     
                     $("#goto_group_access").click(function() {
          
                        if (cliknav_progress) {
                        cliknav_progress.abort();
                        }

                        $("#loading").show();
                        cliknav_progress=$.ajax({
                        type: 'POST',
                        url: "module/group_access/group_access_list.jsp",
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
                     
                     
                     
                     $("#goto_member").click(function() {
          
                        if (cliknav_progress) {
                        cliknav_progress.abort();
                        }

                        $("#loading").show();
                        cliknav_progress=$.ajax({
                        type: 'POST',
                        url: "module/member/member_list.jsp",
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


                    $("#goto_group_accees").click(function() {
          
                        if (cliknav_progress) {
                        cliknav_progress.abort();
                        }

                        $("#loading").show();
                        cliknav_progress=$.ajax({
                        type: 'POST',
                        url: "module/group_accees/group_accees_list.jsp",
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

                    
                       $("#goto_user").click(function() {
          
                        if (cliknav_progress) {
                        cliknav_progress.abort();
                        }

                        $("#loading").show();
                        cliknav_progress=$.ajax({
                        type: 'POST',
                        url: "module/user/user_list.jsp",
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
                     

                    $("#goto_user_matrix").click(function() {
          
                        if (cliknav_progress) {
                        cliknav_progress.abort();
                        }

                        $("#loading").show();
                        cliknav_progress=$.ajax({
                        type: 'POST',
                        url: "module/user_access/user_acs_list.jsp",
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