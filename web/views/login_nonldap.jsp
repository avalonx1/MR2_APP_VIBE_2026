<%@ page language="java" import="Engines.*,Database.*,java.util.*,java.sql.*,javax.naming.*,javax.sql.*"%>
<%
String statSession = request.getParameter("stat_session");

if (statSession==null) {
    statSession="0";
}

String v_clientIP = request.getRemoteAddr();
String v_clientHost = request.getRemoteHost();
String v_appImageLogo="";
          
int v_statMaintenance=0;

String v_appName="";
String v_appNameDesc="";
auth au = new auth(v_clientIP);
         try {
             
         v_statMaintenance= au.isMaintenance();
         v_appName=au.getParamValue("APPNAMEURL");
         v_appNameDesc=au.getParamValue("APPNAMEDESC");
         v_appImageLogo=au.getParamValue("APPIMGLOGO");
         
         
         } catch (SQLException Sqlex) {
         out.println("<div class=sql>" + Sqlex.getMessage() + "</div>");
         } finally {
         au.close();
         }
         

         if (statSession.equals("1")) {
                                 out.println("<div class=alert>Your Session has been expired, please re-login</div>");
                            }

                            if (statSession.equals("2")) {
                                 out.println("<div class=info>Change Password Success, please login re-login</div>");
                            }
                            

                            if(request.getParameter("signin") != null) {
                                
                                String username = request.getParameter("username");
                                String password = request.getParameter("password");
                                if (username.length() != 0 && password.length() != 0) {


                                    int stat_in = 0;
                                    ResultSet resultSet = null;
                                    try {
                                        Database db = new Database();
                                        try {
                                            db.connect(1);
                                            String sql;
                                          
                                           
                                           sql = "SELECT id,username,password,first_name,last_name,record_stat,image_path,id_parent,employee_id "
                                                   + "from t_user " + 
                                                   " WHERE username='"+username+"' ";
                                            
                                           
                                           out.println(sql);
                                           
                                           resultSet = db.executeQuery(sql);
                                            
                                            while (resultSet.next()) {
                                                stat_in=1;
                                                
                                                
                                                if (resultSet.getString("record_stat").equals("O")) {
                                                   stat_in=2;

//                                                  if (resultSet.getString("FLAG").equals("1")) {
//                                                     stat_in=3;
//                                                
                                                    boolean isEligibleLdap = true;
                                                
                                                    String errCode = "";
//                                                    ldapActiveDirectory ldap = new ldapActiveDirectory(v_clientIP); //ini yg konek ke LDAP
                                                    
//                                                    boolean isActiveLDAP = ldap.isRegisterLDAP(username);
                                                    
//                                                    if (isActiveLDAP) {
//                                                    isEligibleLdap=ldap.getAuthByDName(username,password);
                                                    
//                                                    String AttrFirstName=ldap.getFirstName(username);
//                                                    String AttrLastName=ldap.getLastName(username);
//                                                    String AttrEmail=ldap.getEmail(username);
//                                                    String AttrTitle=ldap.getTitle(username);
//                                                    String AttrIPPhone=ldap.getIPPhone(username);
                                                    String AttrFirstName="20160038";
                                                    String AttrLastName="20160038";
                                                    String AttrEmail="20160038";
                                                    String AttrTitle="20160038";
                                                    String AttrIPPhone="20160038";

                                                        if (isEligibleLdap) {
                                                            stat_in=3;
                                                            
//                                                                session.setAttribute("session_userid", resultSet.getString("1"));
//                                                                session.setAttribute("session_username", resultSet.getString("2"));
//                                                                session.setAttribute("session_group_id", resultSet.getString("group_id"));
//                                                                session.setAttribute("session_role_id", resultSet.getString("role_id"));
//                                                                session.setAttribute("session_group_name", resultSet.getString("group_name"));
//                                                                session.setAttribute("session_role_name", resultSet.getString("role_name"));
//                                                                session.setAttribute("session_image_path", resultSet.getString("image_path"));
//                                                                session.setAttribute("id_parent", resultSet.getString("id_parent"));
//                                                                session.setAttribute("session_employee_id", resultSet.getString("employee_id"));
//                                                                
//                                                                session.setAttribute("session_title", AttrTitle);
//                                                                session.setAttribute("session_phone_extension", AttrIPPhone);
//                                                                session.setAttribute("session_first_name", AttrFirstName);
//                                                                session.setAttribute("session_last_name", AttrLastName);
//                                                                session.setAttribute("session_email", AttrEmail);
                                                                
                                                                session.setAttribute("session_userid", resultSet.getString(1));
                                                                session.setAttribute("session_username", resultSet.getString(2));
//                                                                session.setAttribute("session_password", resultSet.getString("password")); //sengaja masuk ke username karena pass sudah dapat dari LDAP
                                                                session.setAttribute("session_password", resultSet.getString(3)); //sengaja masuk ke username karena pass sudah dapat dari LDAP
                                                                session.setAttribute("session_group", resultSet.getString(4));
                                                                session.setAttribute("session_level", resultSet.getString(5));
                                                                session.setAttribute("session_first_name", resultSet.getString("first_name"));
                                                                session.setAttribute("session_last_name", resultSet.getString("last_name"));
                                                                
                                                                
                                                               sql = "update T_USER set "
                                                                       + "stat_login=1, "
                                                                       + "PASSWORD=UPPER(md5('"+resultSet.getString("username")+"')),"
                                                                       + "IP_ADDRESS='"+v_clientIP+"',"
                                                                       + "REMOTE_HOST='"+v_clientHost+"',"
                                                                       + "first_name='"+AttrFirstName+"',"
                                                                       + "last_name='"+AttrLastName+"',"
                                                                       + "title='"+AttrTitle+"',"
                                                                       + "phone_extension='"+AttrIPPhone+"',"
                                                                       + "email='"+AttrEmail+"',"
                                                                       + "employee_id='"+resultSet.getString("username")+"',"
                                                                       + "last_login=current_timestamp " +
                                                                        "where username='" + resultSet.getString("username")+ "' ";


                                                                db.executeUpdate(sql);
                                                                out.println(sql);
                                                                int v_changePasswd=0;


                                                                    sql = "insert into t_user_audit(id,act_tag,act_desc,ip_addr,host_addr,created_userid,created_time) "
                                                                            +"values ( "
                                                                            + "nextval('t_user_audit_seq'),"
                                                                            + "'LOGIN',"
                                                                            + "'User Login : "+resultSet.getString("username")+" - "+AttrFirstName+" "+AttrLastName+"', "
                                                                            + "'"+v_clientIP+"', "
                                                                            + "'"+v_clientHost+"', "
                                                                            + " "+resultSet.getString("id")+", "
                                                                            + " CURRENT_TIMESTAMP"
                                                                            + " )";
                                                                    
                                                                    db.executeUpdate(sql);
                                                                    out.println(sql);
//                                                                    response.sendRedirect("index_old.jsp?menuid=1");
                                                                    response.sendRedirect("index.jsp?menuid=1");
                                                                
                                                                
                                                        } else {
                                                         out.println("<div class=alert> </div>");
                                                          
                                                         %>
                                                         <div class="alert alert-warning alert-dismissible fade in" role="alert">
                                                        <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">×</span>
                                                        </button>
                                                             Authenticate Failed using LDAP Active Directory for username <strong><%=username%></strong>, Please ensure your password is correct. Please contact IT Helpdesk Team for futher information or submit ticket on http://ithelpdesk.bankmuamalat.co.id 
                                                        </div>
                                                
                                                         <%
                                                        }
                                                        
                                                   
                             
                                                } else {
                                                    %>
                                                    
                                                <div class="alert alert-warning alert-dismissible fade in" role="alert">
                                                <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">×</span>
                                                </button>
                                                Username <strong><%=username%></strong> is not active.
                                                </div>
                                                <%
                                                }

                                            }
                                            if (stat_in==0) {
                                            %>    
                                            
                                            <div class="alert alert-warning alert-dismissible fade in" role="alert">
                                                <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">×</span>
                                                </button>
                                                Username <strong><strong><%=username%></strong></strong> is not registered in <%=v_appNameDesc%>. Please Register First (click Register Button).
                                            </div>
                                            
                                            <%
                                            }

                                        } catch (SQLException Sqlex) {
                                            out.println("<div class=sql>" + Sqlex.getMessage() + "</div>");
                                        } finally {
                                            db.close();
                                        }
                                    } catch (Exception except) {
                                        out.println("<div class=sql>" + except.getMessage() + "</div>");
                                    }

                                } else {
                                    %>    
                                            
                                            <div class="alert alert-warning alert-dismissible fade in" role="alert">
                                                <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">×</span>
                                                </button>
                                                You must fill username or password for sign in.
                                            </div>
                                            
                                            <%
                                }
                            }

%>


<!DOCTYPE html>
<html lang="en">
  <head>
    <link rel="icon" type="image/png" sizes="32x32" href="images/favicon-32x32.png">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <!-- Meta, title, CSS, favicons, etc. -->
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title><%=v_appName%></title>

    <!-- Bootstrap -->
    <link href="../vendors/bootstrap/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link href="../vendors/font-awesome/css/font-awesome.min.css" rel="stylesheet">
    <!-- NProgress -->
    <link href="../vendors/nprogress/nprogress.css" rel="stylesheet">
    <!-- Animate.css -->
    <link href="../vendors/colorlib/animate.min.css" rel="stylesheet">

    <!-- Custom Theme Style -->
    <link href="../build/css/custom.min.css" rel="stylesheet">
  </head>

  <body class="login" style="background-image: url(images/new-bg.jpg); background-size: cover; background-repeat: no-repeat; background-position: center; margin: 0; min-height: 100vh; height: auto">
      
    <div>
      <a class="hiddenanchor" id="signup"></a>
      <a class="hiddenanchor" id="signin"></a>

      <div class="login_wrapper">
        <div class="animate form login_form">
          <section class="login_content">
              <img src="images/mr2_logo_2.png"  width="80" height="80">
              <div style="display: none;">Icons made by <a href="http://www.flaticon.com/authors/flat-icons" title="Flat Icons">Flat Icons</a> from <a href="http://www.flaticon.com" title="Flaticon">www.flaticon.com</a> is licensed by <a href="http://creativecommons.org/licenses/by/3.0/" title="Creative Commons BY 3.0" target="_blank">CC 3.0 BY</a></div>
              <!--<h2 style="font-size: 25px; font-family: Segoe UI"> <b>Muamalat Report Remainder</b></h2>-->
              <h2 style="font-size: 23px; font-family: Segoe UI"> <b>MUAMALAT REPORT REMINDER</b></h2>
              <h2 style="font-size: 27px; font-family: Segoe UI"> <b>( MR2 )</b></h2>
           <form class="form-signin">
               <!--<div class="separator"></div>-->
              <!--<h1><i class="fa fa-upload"></i> Muamalat Report Remainder Application (MR2) </h1>-->
              
              <!--<h2 class="purple" style="font-size:24px">Login to Application</h2>-->
              <div class="separator" style="border-top: 1px solid #AA5EC6">
              <p>:: Login with Active Directory ::</p>
              </div>
              <div>
                <input type="text" class="form-control" id="username1" size="15" type="text" name="username" placeholder="Username" required="" />
              </div>
              <div>
                <input type="password" class="form-control" id="password" size="15" type="password" name="password" placeholder="Password" required="" />
              </div>
              <div>
                  <button type="submit" name="signin" class="btn btn-lg btn-primary btn-block" type="submit" style="background-color: #385c77">Sign in</button>
                  
                <!--<a class="reset_pass" href="#">Lost your password?</a>-->
              </div>

              <div class="clearfix"></div>

              <div class="separator"  style="border-top: 1px solid #AA5EC6">
                  
                  <p class="change_link"><span class="fa fa-info-circle"></span>
                      Untuk melakukan registrasi user silahkan melapor melalui email kepada masing-masing kepala departement.
                  <!--<a href="#signup" class="to_register"> Create Account </a>-->
                </p>

                <div class="clearfix"></div>
                <br />

                <div>
                  <br /><br /><br />
                  <p style="font-size:11px">© 2026 Bank Muamalat Corporation. Muamalat Report Reminder Application. All Rights Reserved. </p>
                  <!--<p style="font-size:11px">© 2016 All Rights Reserved</p><p style="font-size:11px">The application and materials provided by Information Technology division and managed by Compliance division have the only purpose of helping users to upload document.</p><p style="font-size:11px">Privacy policy and Terms.</p>-->

                </div>
              </div>
            </form>
          </section>
        </div>

        <div id="register" class="animate form registration_form">
          <section class="login_content">
            <form>
              <h1>Create Account</h1>
              <div>
                <input type="text" class="form-control" placeholder="Username" required="" />
              </div>
              <div>
                <input type="email" class="form-control" placeholder="Email" required="" />
              </div>
              <div>
                <input type="password" class="form-control" placeholder="Password" required="" />
              </div>
              <div>
                <a class="btn btn-default submit" href="index.html">Submit</a>
              </div>

              <div class="clearfix"></div>

              <div class="separator">
                <p class="change_link">Already a member ?
                  <a href="#signin" class="to_register"> Log in </a>
                </p>

                <div class="clearfix"></div>
                <br />
              </div>
            </form>
          </section>
        </div>
      </div>
    </div>
  </body>
</html>