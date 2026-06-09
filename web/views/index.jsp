<%@ page language="java" import="Engines.*,Database.*,java.util.*,java.util.regex.*, java.sql.*,javax.naming.*,javax.sql.*, java.lang.String"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
         String clientIP = request.getRemoteAddr();
         int v_statMaintenance=0;
         
         String v_userID = (String) session.getAttribute("session_userid"); 
         String v_employee_id = (String) session.getAttribute("employee_id") ;
         
         
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
//        response.sendRedirect("login.jsp");
//        respons.sendRedirect("login_nonldap.jsp");
        response.sendRedirect("index.jsp?menuid=1");
    } else if ((String) session.getAttribute("session_username") != null) {
            
              
        String v_groupID = (String) session.getAttribute("session_group_id");
        String v_roleID = (String) session.getAttribute("session_role_id");
        String v_groupName = (String) session.getAttribute("session_group_name");
        String v_roleName = (String) session.getAttribute("session_role_name");
        String v_user_image_path = (String ) session.getAttribute("session_image_path");
        
        String v_firstName = (String) session.getAttribute("session_first_name");
        String v_lastName = (String) session.getAttribute("session_last_name");

  
        String url = "home.jsp";
//        String url = "";
       
        
       
//        out.println(modul_id+" "+url);
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
            <div class="navbar nav_title" style="border: 0; background: #5D1689B3;">
                <a href="index.jsp" class="site_title"><img src="images/BMI_LOGO.png"  width="40" height="40"><span style="font-family: Segoe UI;"><b>  <%=v_appNameURL%></b></span></a>
            </div>

            <div class="clearfix"></div>

            <!-- menu profile quick info -->
            <div class="profile">
              <div class="profile_pic">
                  <img src="<%=v_user_image_path != null ? v_user_image_path : "images/man.png"%>" alt="Profile" onerror="this.src = 'images/man.png'" class="img-circle profile_img">
              </div>
              <div class="profile_info" >
                  <!--style="margin-bottom: 10px"-->
                <span>Welcome,</span>
                <h2><%=v_firstName%></h2>
                <!--<br/>-->
                <!--<h2><%=v_lastName%></small></h2>-->
                
              </div>
            </div>

            
            <div id="sidebar-menu" class="main_menu_side hidden-print main_menu">
              <div class="menu_section"> 
                     <br/>
                <h3> Main menu </h3> 
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
                                            sql = "select id,disp_name,url,icon_name,ordernum,id_parent,leaf_stat from v_menu_access_lvl1 where user_id = "+v_userID;
                                            resultSet = db.executeQuery(sql);
                                            while (resultSet.next()) {
                                              
                                                id_menu=resultSet.getString("id");
                                                disp_name_menu=resultSet.getString("disp_name");
                                                url_menu=resultSet.getString("url");
                                                icon_name_menu=resultSet.getString("icon_name");
                                                id_parent_menu=resultSet.getString("id_parent");
                                                leaf_stat=resultSet.getString("leaf_stat");
                                               
                                                if (leaf_stat.equals("1")) {
                                                
                                                %>
                                                
                                                
                                                <li><a id="goto_<%=id_menu%>"><i class="fa <%=icon_name_menu%>"></i><%=disp_name_menu%></a>
                                                </li>
                                                <script type=text/javascript> 
                                                    $(document).ready(function() {
                                                        
                                                var cliknav_progress = null;
                                                $("#goto_<%=id_menu%>").click(function() {


                                                        
                                                            if (cliknav_progress) {
                                                            cliknav_progress.abort();
                                                            }

                                                             $("#maincontent").hide();
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
                                                
                                                <%
                                                
                                                } else {
                                                    
                                                    %>
                                                
                                              <li class="active"><a><i class="fa <%=icon_name_menu%>"></i><%=disp_name_menu%><span class="fa fa-chevron-down"></span></a>
                                                <ul class="nav child_menu" style="display: block;">
                                                   
                                                    
                                                    
                                                    <%

                                                    try {
                                                                        ResultSet resultSet2=null;
                                                                        Database db2 = new Database();
                                                                        try {
                                                                            db2.connect(1);
                                                                            String sql2;
                                                                            sql2 = "select id,disp_name,url,icon_name,ordernum,id_parent,leaf_stat from v_menu_access_lvl2 ";
                                                                            resultSet2 = db2.executeQuery(sql2);
                                                                            
                                                                            System.out.print(sql2);
                                                                            
                                                                            while (resultSet2.next()) {

                                                                                id_menu=resultSet2.getString("id");
                                                                                disp_name_menu=resultSet2.getString("disp_name");
                                                                                url_menu=resultSet2.getString("url");
                                                                                icon_name_menu=resultSet2.getString("icon_name");
                                                                                id_parent_menu=resultSet2.getString("id_parent");
                                                                                leaf_stat=resultSet2.getString("leaf_stat");


                                                                                %>

                                                                                
                                                                                <li><a id="goto_<%=id_menu%>"><i class="fa <%=icon_name_menu%>"></i><%=disp_name_menu%></a>
                                                                                </li>
                                                                                <script type=text/javascript> 
                                                                                    $(document).ready(function() {

                                                                                    var cliknav_progress = null;
                                                                                $("#goto_<%=id_menu%>").click(function() {

                                                                                            if (cliknav_progress) {
                                                                                            cliknav_progress.abort();
                                                                                            }
                                                                                            
                                                                                            $("#maincontent").hide();
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

                                                                                <%
                                                                            }
                                                                            resultSet2.close();
                                                                        } catch (SQLException Sqlex) {
                                                                            out.println("<div class=sql>" + Sqlex.getMessage() + "</div>");
                                                                        } finally {
                                                                            db2.close();
                                                                             if (resultSet2 != null) resultSet2.close(); 
                                                                        }
                                                                    } catch (Exception except) {
                                                                        out.println("<div class=sql>" + except.getMessage() + "</div>");
                                                                    }


                                                    %>
                                                   
                                                   
                                                </ul>
                                              </li>
                                                
                                                <%
                                                    
                                                    
                                                }
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
           
                </ul>
              </div>
            </div>
           
          </div>
        </div>

        <!-- top navigation -->
        <div class="top_nav">
          <div class="nav_menu">
            <nav>

            <!--<div class="nav toggle" style="width: 334px;" >-->
            <div class="nav toggle" style="display: flex; align-items: center;">
                <a id="menu_toggle" style="margin-right: 12px; flex-shrink: 0;"><i class="fa fa-bars"></i></a>
                <span style="font-size: 0.98em; font-family: Segoe UI; color: inherit; white-space: nowrap; display: inline-block; vertical-align: middle;"><b>MUAMALAT REPORT REMINDER APP</b> <small style="color:blueviolet">(Beta)</small></span>
            </div>

              <ul class="nav navbar-nav navbar-right">
                <li class="">
                  <a href="javascript:;" class="user-profile dropdown-toggle" data-toggle="dropdown" aria-expanded="false">
                    <img src="<%=v_user_image_path != null ? v_user_image_path : "images/man.png"%>" alt="Profile Image" onerror="this.src = 'images/man.png'"  ><%=v_firstName%>
                    <span class=" fa fa-angle-down"></span>
                  </a>
                  <ul class="dropdown-menu dropdown-usermenu pull-right">
                    <!--<li><a href="javascript:;"> Profile</a></li>-->

                    
                    <li><a href="logout.jsp"><i class="fa fa-sign-out pull-right"></i> Log Out</a></li>
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
        <footer style = "background-color: #310650; padding: 7px 20px">
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
          title: "<b>Welcome</b>",
          type: "info",
          text: "Selamat Datang di Aplikasi <b>Muamalat Report Reminder (MR2)</b>.<br/>Aplikasi ini masih dalam tahapan pengembangan divisi IT,<br/> Have a Nice Day!",
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
          
          
          <%
                    
                 
                    try {
                                        ResultSet resultSet=null;
                                        Database db = new Database();
                                        try {
                                            db.connect(1);
                                            String sql;
                                            sql = "select id,disp_name,url,icon_name,ordernum,id_parent,leaf_stat from v_menu_access_lvl1 ";
                                            resultSet = db.executeQuery(sql);
                                            while (resultSet.next()) {
                                              
                                                id_menu=resultSet.getString("id");
                                                disp_name_menu=resultSet.getString("disp_name");
                                                url_menu=resultSet.getString("url");
                                                icon_name_menu=resultSet.getString("icon_name");
                                                id_parent_menu=resultSet.getString("id_parent");
                                                leaf_stat=resultSet.getString("leaf_stat");
                                               
                                                if (leaf_stat.equals("1")) {
                                                
                                                %>
                                                
                                                        
                                                var cliknav_progress = null;
                                                $("#goto_<%=id_menu%>").click(function() {


                                                        
                                                            if (cliknav_progress) {
                                                            cliknav_progress.abort();
                                                            }

                                                             $("#maincontent").hide();
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
                                                 
                                                 
                                                <%
                                                
                                                } else {
                                                    
                                                
                                                    try {
                                                                        ResultSet resultSet2=null;
                                                                        Database db2 = new Database();
                                                                        try {
                                                                            db2.connect(1);
                                                                            String sql2;
                                                                            sql2 = "select id,disp_name,url,icon_name,ordernum,id_parent,leaf_stat from v_menu_access_lvl2 ";
                                                                            resultSet2 = db2.executeQuery(sql2);
                                                                            
                                                                            System.out.print(sql2);
                                                                            
                                                                            while (resultSet2.next()) {

                                                                                id_menu=resultSet2.getString("id");
                                                                                disp_name_menu=resultSet2.getString("disp_name");
                                                                                url_menu=resultSet2.getString("url");
                                                                                icon_name_menu=resultSet2.getString("icon_name");
                                                                                id_parent_menu=resultSet2.getString("id_parent");
                                                                                leaf_stat=resultSet2.getString("leaf_stat");


                                                                                %>

                                                                                
                                                                           

                                                                                    var cliknav_progress = null;
                                                                                $("#goto_<%=id_menu%>").click(function() {

                                                                                            if (cliknav_progress) {
                                                                                            cliknav_progress.abort();
                                                                                            }
                                                                                            
                                                                                            $("#maincontent").hide();
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
                                                                              
                                                                                <%
                                                                            }
                                                                            resultSet2.close();
                                                                        } catch (SQLException Sqlex) {
                                                                            out.println("<div class=sql>" + Sqlex.getMessage() + "</div>");
                                                                        } finally {
                                                                            db2.close();
                                                                             if (resultSet2 != null) resultSet2.close(); 
                                                                        }
                                                                    } catch (Exception except) {
                                                                        out.println("<div class=sql>" + except.getMessage() + "</div>");
                                                                    }

 
                                                    
                                                }
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

           });
    </script>
 
  </body>
</html>


 

<%} else {
    response.sendRedirect("../oops.jsp");
}
%>