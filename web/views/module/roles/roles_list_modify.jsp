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
  
 String v_name="";
 String v_code="";
 String v_desc="";
 String v_hierarchy_flag="";
 int v_role_level=1;
 
 
           
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

                                 
                                 sql = " select id,role_name,role_code,role_description,hierarchy_flag,role_level "
                                         + "from t_roles where id="+id;
                      
                                
                            resultSet = db.executeQuery(sql);
                            String rowstate = "even";
                                
                            while (resultSet.next()) {
                  
                                v_name = resultSet.getString("role_name");
                                v_code = resultSet.getString("role_code");
                                v_desc = resultSet.getString("role_description");
                                v_hierarchy_flag = resultSet.getString("hierarchy_flag");
                                v_role_level = resultSet.getInt("role_level");
                                
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
               <h3><i class="fa fa-cubes"></i> New Roles </h3>
              </div>
              </div>
            </div>
            <div class="clearfix"></div>
            
            
            <div class="col-md-12 col-xs-12">
                <div class="x_panel">
                  <div class="x_title">
                    <h2>Create New Product + </h2>
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
                        <label class="control-label col-md-3 col-sm-3 col-xs-12">Product Code</label>
                        <div class="col-md-9 col-sm-9 col-xs-12">
                            <input id="p_code_role" name="p_code_role" required="true" type="text" class="form-control col-md-7 col-xs-12"  placeholder="Input code" value="<% out.println((v_code == null) ? "" : v_code); %>" >
                        </div>
                      </div>
                        
                      <div class="form-group">
                        <label class="control-label col-md-3 col-sm-3 col-xs-12">Name Product</label>
                        <div class="col-md-9 col-sm-9 col-xs-12">
                          <input id="p_name_role" name="p_name_role" type="text" class="form-control col-md-7 col-xs-12"   placeholder="Input name" value="<% out.println((v_name == null) ? "" : v_name); %>" >
                        </div>
                      </div>
                   
                                          
                     <div class="form-group">
                        <label class="control-label col-md-3 col-sm-3 col-xs-12" >Description Product</label>
                         <div class="col-md-9 col-sm-9 col-xs-12">
                            <textarea id="p_desc_role" name="p_desc_role" class="resizable_textarea form-control"><% out.println((v_desc == null) ? "" : v_desc); %></textarea>
                        </div>
                    </div>
                        
                        <div class="form-group">
                        <label class="control-label col-md-3 col-sm-3 col-xs-12">Hierarchy Flag </label>
                        <div class="col-md-9 col-sm-9 col-xs-12">
                         <select id="p_hierarchy_flag" name="p_hierarchy_flag" class="select2_single form-control" required tabindex="-1">
                                       
                                       <%

                                    try {
                                        ResultSet resultSet=null;
                                        Database db = new Database();
                                        try {
                                            db.connect(1);
                                            String sql;

                                            sql = "SELECT 'Y' AS ID, 'YES' AS DESC UNION ALL SELECT 'N' AS ID,'NO' AS DESC "
                                                    + " ORDER BY 2 ";
                                            resultSet = db.executeQuery(sql);
                                            while (resultSet.next()) {
                                                if (v_hierarchy_flag.equalsIgnoreCase(resultSet.getString(1))) {
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
                                    
                      <div class="form-group">
                        <label class="control-label col-md-3 col-sm-3 col-xs-12">Role Level (NUMBER)</label>
                        <div class="col-md-9 col-sm-9 col-xs-12">
                          <input id="p_level_role" name="p_level_role" required="true" type="number" min="1" max="100" class="form-control col-md-7 col-xs-12" value="<%=v_role_level%>" >
                        </div>
                      </div>
                        
                                    
                      
                        
                      <div class="ln_solid"></div>
                      <div class="form-group">
                        <div class="col-md-9 col-sm-9 col-xs-12 col-md-offset-3">
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
          
        
      
          $(".flat").iCheck({
                                checkboxClass: 'icheckbox_flat-green',
                                radioClass: 'icheckbox_flat-green'
                            });

        
            $("#goto_back").click(function() {
                                 $("#loading").show();
                                $.ajax({
                                 type: "POST",
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
                                  }});

            });
            
             $("#goto_submitModifyForm").submit(function () {
             
                $("#loading").show();
                var statProcess="";
                $.ajax({
                                 type: "POST",
                                 url: "module/roles/roles_list_modify_process.jsp",
                                 data: $(this).serialize(),
                                 cache:false,
                                 success: function(d) {
                                    statProcess = $.trim(d);
                                 },
                                 complete: function(){
                                     
                                      $.ajax({
                                            type: 'POST',
                                            url: "module/roles/roles_list.jsp",
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
    <!-- /Datatables -->