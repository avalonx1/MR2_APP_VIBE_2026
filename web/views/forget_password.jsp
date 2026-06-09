
<%@ page language="java" import="Engines.*,Database.*,java.util.*,java.sql.*,javax.naming.*,javax.sql.*"%>
<%
String statSession = request.getParameter("stat_session");

if (statSession==null) {
    statSession="0";
}

String v_clientIP = request.getRemoteAddr();
String v_clientHost = request.getRemoteHost();
          
int v_statMaintenance=0;


String v_appName="";
String v_appNameDesc="";
auth au = new auth(v_clientIP);
         try {
             
         v_statMaintenance= au.isMaintenance();
         v_appName=au.getParamValue("APPNAMEURL");
         v_appNameDesc=au.getParamValue("APPNAMEDESC");
         
         
         } catch (SQLException Sqlex) {
         out.println("<div class=sql>" + Sqlex.getMessage() + "</div>");
         } finally {
         au.close();
         }
         
%>




<!DOCTYPE html>
<html lang="en">
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <!-- Meta, title, CSS, favicons, etc. -->
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title><%=v_appNameDesc%></title>
    
    <!-- Bootstrap -->
    <link href="../vendors/bootstrap/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link href="../vendors/font-awesome/css/font-awesome.min.css" rel="stylesheet">
    <!-- NProgress -->
    <link href="../vendors/nprogress/nprogress.css" rel="stylesheet">
    <!-- Animate.css -->
    <link href="../vendors/colorlib/animate.min.css" rel="stylesheet">
    <!-- iCheck -->
    <link href="../vendors/iCheck/skins/flat/green.css" rel="stylesheet">
    <!-- bootstrap-progressbar -->
    <link href="../vendors/bootstrap-progressbar/css/bootstrap-progressbar-3.3.4.min.css" rel="stylesheet">
    <!-- PNotify -->
    <link href="../vendors/pnotify/dist/pnotify.css" rel="stylesheet">
    <link href="../vendors/pnotify/dist/pnotify.buttons.css" rel="stylesheet">
    <link href="../vendors/pnotify/dist/pnotify.nonblock.css" rel="stylesheet">
    
    <!-- Custom Theme Style -->
    <link href="../build/css/custom.min.css" rel="stylesheet">
    
    
  </head>

  <body>

      
         <div class="container">
      
      <div class="col-md-6 col-sm-6 col-xs-12">
              <div class="x_panel">
                <div class="x_title">
                  <h2>Lupa Password Anda?</h2>
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
                  <ul class="list-unstyled timeline">
                    <li>
                      <div class="block">
                        <div class="tags">
                          <a href="" class="tag">
                            <span>Info</span>
                          </a>
                        </div>
                        <div class="block_content">
                          <h2 class="title">
                                          <a>Autentikasi Aplikasi <%=v_appNameDesc%></a>
                                      </h2>
                          <div class="byline">
                            <span>Panduan Pengguna</span> 
                          </div>
                          <p class="excerpt"> Username yang digunakan pada aplikasi ini menggunakan koneksi ke Active Directory PC/Laptop yang sudah terdaftar. JIka Anda belum mendaftarkan, mohon input tiket ke IT Helpdesk untuk didaftarkan User Account LDAP Active Directory. 
                          </p>
                        </div>
                      </div>
                    </li>
                    
                    
                  </ul>

                </div>
              </div>
            </div>
      
             </div>
      
  </body>
</html>
