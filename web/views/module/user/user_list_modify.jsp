<%@include file="../../../includes/check_auth_layer3.jsp"%>
<%        
        
        
 String action = request.getParameter("action");
 String actionCode = "";
 String actionText = "";
 
 if (action==null) {
     actionCode="ADD";
     actionText="Insert";
 }else {
     actionCode="EDT";
     actionText="Update";
 }
 
 String header_title_act="";
 String id="0";
 String v_id_parent="";
// String v_gender_user="";
 String v_role="";
 String v_role_name="";
 String v_div_id="";
 String v_divisi="";
 String v_fname_user="";
 String v_lname_user="";
 String v_uname_user="";
 String v_pass_user="";
 String v_altname_user="";
 String v_empid_user="";
 String v_phones_user="";
 String v_title_user="";
 String v_birthday_user="";
 String v_email="";
 String v_user_detail="";
 String v_id_user= "";
 String v_role_id= "";
 
 
 if (actionCode.equals("ADD") ) {
     header_title_act="Add";
 } else {
     header_title_act="Edit";
     id  = request.getParameter("id");
     
     
      try {
                        ResultSet resultSet = null;
                        Database db = new Database();
                        try {
                            db.connect(1);
                            String sql;
                                 
 
//                            original
//                                 sql = " select userid as id, username, first_name, last_name, role_id, role_name, div_id, divisi "
//                                         + "from v_user_matrix where userid="+id;
                                 
                                 sql = " select id, username, first_name, last_name, div_id, role_code "
                                         + "from t_user where id="+id;
                                 
                        if (v_debugMode.equals("1")) {
                       System.out.println(sql);
                        }
                                
                            resultSet = db.executeQuery(sql);
                            String rowstate = "even";
                                
                            while (resultSet.next()) {
                                //userid, username, first_name, last_name, role_id, role_name, div_id, divisi
                                v_id_user = resultSet.getString("id");
                                v_uname_user = resultSet.getString("username"); 
                                System.out.println("v_uname_user = "+v_uname_user);
                                v_fname_user = resultSet.getString("first_name");                               
                                v_lname_user = resultSet.getString("last_name");                               
                                v_role = resultSet.getString("role_code");                               
                                System.out.println("v_role = "+v_role);
//                                v_role_name = resultSet.getString("role_name"); 
                                v_div_id = resultSet.getString("div_id");  
                                System.out.println("v_div_id = "+v_div_id);
//                                v_role_id = resultSet.getString("role_id");
//                                v_divisi = resultSet.getString("divisi");                               
//                                v_phones_user = resultSet.getString("phone_number");
//                                v_birthday_user = resultSet.getString("birthday");
//                                v_id_parent = resultSet.getString("id_parent");
//                                v_email = resultSet.getString("email");
                                
//                                v_user_detail = v_uname_user +" - "+v_fname_user;
                            }
                                
                        } catch (SQLException Sqlex) {
                            out.println("<div class=sql>" + Sqlex.getMessage() + "</div>");
                        } finally {
                            db.close();
                                if (resultSet != null) resultSet.close(); 
                        }
                    } catch (Exception except) {
                        out.println("<div class=sql>" + except.getMessage() + "</div>");
                    }
 }
       
%>

   <div class="">
            <div class="page-title">
              <div class="title_left">
               <h3><i class="fa fa-user" aria-hidden="true"></i> User Access </h3>
              </div>
              </div>
            </div>
            <div class="clearfix"></div>
            
            
            <div class="col-md-12 col-xs-12">
                <div class="x_panel">
                  <div class="x_title">
                    <h2><%=actionText%> New User Access + </h2>
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
                    <br />
                    <!-- FORM -->
                    <form id="goto_submitModifyForm" class="form-horizontal form-label-left">
                    <input type="hidden" id="id" name="id" value="<%=id%>" />
                    <input type="hidden" id="actionCode" name="actionCode" value="<%=actionCode%>" />
                
                    <div class="form-group">
                    <% if (actionCode.equals("ADD") ) {  %>
            
                    <div class="col-md-6 col-sm-6 col-xs-12 form-group has-feedback">
                        <label class="control-label col-md-3 col-sm-3 col-xs-12">User Name (NIK)</label>
                        <div class="col-md-9 col-sm-9 col-xs-12">
                          <input id="p_username" name="p_username" type="text" class="form-control col-md-7 col-xs-12" value="<% out.println((v_uname_user == null) ? "" : v_uname_user); %>" >
                        </div>
                    </div>
                        
                        <% } else {  %>
                            
                        
                        <div class="col-md-6 col-sm-6 col-xs-12 form-group has-feedback">
                            <label class="control-label col-md-3">User Name (NIK)</label>
                                <div class="col-md-9 col-sm-9 col-xs-12">
                                    <select id="p_username" name="p_username" class="select2_single form-control" tabindex="-1" disabled>
                                        <option value="" disabled selected >- Select User -</option>
                                       <%
                                    try {
                                        ResultSet resultSet=null;
                                        Database db = new Database();
                                        try {
                                            db.connect(1);
                                            String sql;
                                            sql = "select id, first_name ||' '|| last_name as desc from t_user ORDER BY ID ASC ";
                                            
                                            resultSet = db.executeQuery(sql);
                                            while (resultSet.next()) {
                                                if (v_id_user.equalsIgnoreCase(resultSet.getString(1))) {
//                                                    if (v_fname_user.equalsIgnoreCase(resultSet.getString(1))) {
                                                    out.println("<option value=" + resultSet.getString(1) + " selected=selected >" + resultSet.getString(2) + "</option>");
                                                } else {
                                                    out.println("<option value=" + resultSet.getString(1) + " >" + resultSet.getString(2) + "</option>");
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
                                    </select>
                                </div>
                            </div>
                        
                        <% } %>

                  <div class="col-md-6 col-sm-6 col-xs-12 form-group has-feedback">
                            <label class="control-label col-md-3">Divisi</label>
                                <div class="col-md-9 col-sm-9 col-xs-12">
                                    <select id="p_divisi_user" name="p_divisi_user" class="select2_single form-control" tabindex="-1">
                                        <option value="" disabled selected >- Select Divisi -</option>
                                       <%
                                    try {
                                        ResultSet resultSet=null;
                                        Database db = new Database();
                                        try {
                                            db.connect(1);
                                            String sql;
                                            sql = "SELECT div_id, divisi FROM t_divisi ORDER BY ID ASC ";
                                            resultSet = db.executeQuery(sql);
                                            while (resultSet.next()) {
                                                if (v_div_id.equalsIgnoreCase(resultSet.getString(1))) {
                                                    out.println("<option value=" + resultSet.getString(1) + " selected=selected >" + resultSet.getString(2) + "</option>");
                                                } else {
                                                    out.println("<option value=" + resultSet.getString(1) + " >" + resultSet.getString(2) + "</option>");
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
                                    </select>
                                </div>
                            </div> 
                                    
                                    
                           <div class="col-md-6 col-sm-6 col-xs-12 form-group has-feedback">
                            <label class="control-label col-md-3">Role Access</label>
                                <div class="col-md-9 col-sm-9 col-xs-12">
                                    <select id="p_role_user" name="p_role_user" class="select2_single form-control" tabindex="-1">
                                        <option value="" disabled selected >- Select Role Access -</option>
                                       <%
                                    try {
                                        ResultSet resultSet=null;
                                        Database db = new Database();
                                        try {
                                            db.connect(1);
                                            String sql;
                                            sql = "SELECT role_code, role_name FROM t_roles ";
                                            
                                            resultSet = db.executeQuery(sql);
                                            while (resultSet.next()) {
                                                if (v_role.equalsIgnoreCase(resultSet.getString(1))) {
                                                    out.println("<option value=" + resultSet.getString(1) + " selected=selected >" + resultSet.getString(2) + "</option>");
                                                } else {
                                                    out.println("<option value=" + resultSet.getString(1) + " >" + resultSet.getString(2) + "</option>");
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
                                    </select>
                                </div>
                            </div>          
                                    
                        
                      </div><br/><br/>   
                                    
                      <div class="form-group">
                        <div class="col-md-9 col-sm-9 col-xs-12 col-md-offset-5">
                         <button id="goto_back" type="button" class="btn btn-danger"><span class="fa fa-remove" aria-hidden="true"></span> Cancel</button>
                          <button type="submit" class="btn btn-success"><span class="fa fa-check" aria-hidden="true"></span> Submit</button>
                        </div>
                      </div>
               
                    </form>
                  </div>
                </div>
              </div>
            
  
     
    <!-- JS Main -->
    <script>
      $(document).ready(function() {

            $("#goto_back").click(function() {
                                $("#maincontent").hide();
                                $("#loading").show();
                                $.ajax({
                                 type: "POST",
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
                                  }});

            });
            
             $("#goto_submitModifyForm").submit(function () {
             
             var statProcess="";
                $("#maincontent").hide();
                $("#loading").show();
                $.ajax({
                                 type: "POST",
                                 url: "module/user/user_list_modify_process.jsp",
                                 data: $(this).serialize(),
                                 cache:false,
                                 success: function(d) {
                                      statProcess = $.trim(d);
                                 },
                                 complete: function(){
                                     
                                      $.ajax({
                                            type: 'POST',
                                            url: "module/user/user_list.jsp",
                                            data: '',
                                            success: function(d) {
                                                $("#maincontent").empty();
                                                $('#maincontent').html(d);
                                                $("#maincontent").show();                
                                            },
                                            complete: function(){
                                                $('#loading').hide();
//                                                new PNotify({title:  '<%=actionText%> Data',text: 'SUCCESS: Data has been saved..',type: 'success',styling: 'bootstrap3'});
                                                 if (statProcess === "OK") {
                                                    new PNotify({title:  '<%=actionText%> Data',text: 'SUCCESS: Data has been saved..',type: 'success',styling: 'bootstrap3'});
                                                } else {
                                                    new PNotify({title: '<%=actionText%> Data',text: 'ERROR: Data Not Saved<br>'+statProcess,type: 'error',styling: 'bootstrap3'});
                                                }
                                            }
                                        });
                                  }});
                return false;
            });

      });
      
    </script>
    