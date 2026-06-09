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
 String v_role_user="";
 String v_group_user="";
 String v_fname_acs="";

 
 
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

                                 
//                           sql = " SELECT  id, userid, username, first_name, role_name, role_id, role_code, group_id, group_name, group_code "
//                                 + " FROM v_user_matrix where id="+id;  
                           
                            sql = "SELECT userid as id, username, first_name, last_name, divisi, role_id, role_name FROM rptrack.v_user_matrix"
                                    + " where userid = "+id;

                            resultSet = db.executeQuery(sql);
                            String rowstate = "even";
                                
                            while (resultSet.next()) {

                                v_role_user = resultSet.getString("role_id");;
//                                v_group_user = resultSet.getString("group_id");
                                v_fname_acs = resultSet.getString("id");
                                
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
               <h3><i class="fa fa-user"></i> Users </h3>
              </div>
              </div>
            </div>
            <div class="clearfix"></div>
            
            
            <div class="col-md-12 col-xs-12">
                <div class="x_panel">
                  <div class="x_title">
                    <h2>Assign User Matrix </h2>
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
                

                    <div class="col-md-6 col-sm-6 col-xs-12 form-group has-feedback">
                            <label class="control-label col-md-3"> User </label>
                                <div class="col-md-9 col-sm-9 col-xs-12">
                                    <select id="p_user_matrix" name="p_user_matrix" class="select2_single form-control" tabindex="-1">
                                        <!--<option value="" disabled selected >- Select Users -</option>-->
                                       <%
                                    try {
                                        ResultSet resultSet=null;
                                        Database db = new Database();
                                        try {
                                            db.connect(1);
                                            String sql;
//                                            sql = "SELECT userid as id, first_name ||' '|| last_name as desc FROM v_user_matrix";
//                                            sql = "SELECT id, first_name ||' '|| last_name as desc FROM t_user";
                                            sql="select id, first_name, div_id, role_code from v_user_matrix where id ="+v_userID;";
                                            resultSet = db.executeQuery(sql);
                                            while (resultSet.next()) {
                                                if (v_fname_acs.equalsIgnoreCase(resultSet.getString(1))) {
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
                            <label class="control-label col-md-3">Assign Role</label>
                                <div class="col-md-9 col-sm-9 col-xs-12">
                                    <select id="p_role_user_matrix" name="p_role_user_matrix" class="select2_single form-control" tabindex="-1">
                                        <option value="" disabled selected >- Select Role -</option>
                                       <%
                                    try {
                                        ResultSet resultSet=null;
                                        Database db = new Database();
                                        try {
                                            db.connect(1);
                                            String sql;
                                            sql = "SELECT id ID, role_name FROM t_roles ";
                                            resultSet = db.executeQuery(sql);
                                            while (resultSet.next()) {
                                                if (v_role_user.equalsIgnoreCase(resultSet.getString(1))) {
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
                                  
                     
                                <br/>   
                                <br/>   
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
          
       
      
//          $(".flat").iCheck({
//                                checkboxClass: 'icheckbox_flat-green',
//                                radioClass: 'icheckbox_flat-green'
//                            });

            $("#goto_back").click(function() {
                
                $("#maincontent").hide();
                
                                 $("#loading").show();
                                
                                $.ajax({
                                 type: "POST",
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
                                  }});

            });
            
             $("#goto_submitModifyForm").submit(function () {
             
                var statProcess="";
                $("#maincontent").hide();
                $("#loading").show();
                $.ajax({
                                 type: "POST",
                                 url: "module/user_access/user_acs_list_modify_process.jsp",
                                 data: $(this).serialize(),
                                 cache:false,
                                 success: function(d) {
                                   statProcess = $.trim(d);
                                 },
                                 complete: function(){
                                     
                                      $.ajax({
                                            type: 'POST',
                                            url: "module/user_access/user_acs_list.jsp",
                                            data: '',
                                            success: function(d) {
                                                $("#maincontent").empty();
                                                $('#maincontent').html(d);
                                                $("#maincontent").show();                
                                            },
                                            complete: function(){
                                                $('#loading').hide();
                                                
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