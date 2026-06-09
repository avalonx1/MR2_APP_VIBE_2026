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
 String v_gender_user="";
 String v_uname_user="";
 String v_first_name="";
 String v_lname_user="";
 String v_pass_user="";
 String v_altname_user="";
 String v_empid_user="";
 String v_phones_user="";
 String v_title_user="";
 String v_birthday_user="";
 
 
 
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

                                 
                                 sql = " SELECT userid as id, username, first_name, last_name, "
                                         + "role_id, role_code, role_name, hirarcy_flag, "
                                         + "group_id, group_type, group_code, group_name "
                                         + "FROM v_user_matrix; ";
                                 
                                 

                           // out.println(sql);
                                
                            resultSet = db.executeQuery(sql);
                            String rowstate = "even";
                                
                            while (resultSet.next()) {

                                v_role_user= resultSet.getString("role_name");;
                                v_group_user= resultSet.getString("group_name");
                                v_first_name= resultSet.getString("first_name");
                                
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
                    <h2>Assign User Matrix for <%=v_first_name%></h2>
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
                            <label class="control-label col-md-3">Assign Role</label>
                                <div class="col-md-9 col-sm-9 col-xs-12">
                                    <select id="p_role_user_matrix" name="p_role_user_matrix" class="select2_single form-control" tabindex="-1">
                                        <option value="" disabled selected >- Select data -</option>
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
                                    
                     <div class="col-md-6 col-sm-6 col-xs-12 form-group has-feedback">
                            <label class="control-label col-md-3">Assign Group</label>
                                <div class="col-md-9 col-sm-9 col-xs-12">
                                    <select id="p_group_user_matrix" name="p_group_user_matrix" class="select2_single form-control" tabindex="-1">
                                        <option value="" disabled selected >- Select data -</option>
                                       <%
                                    try {
                                        ResultSet resultSet=null;
                                        Database db = new Database();
                                        try {
                                            db.connect(1);
                                            String sql;
                                            sql = "SELECT id ID, group_name FROM t_group ";
                                            resultSet = db.executeQuery(sql);
                                            while (resultSet.next()) {
                                                if (v_group_user.equalsIgnoreCase(resultSet.getString(1))) {
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
    <!--                       <div class="ln_solid"></div>-->
                      <div class="form-group">
                          <!--<div class="ln_solid"></div>-->
                        <div class="col-md-9 col-sm-9 col-xs-12 col-md-offset-5">
                         <button id="goto_back" type="button" class="btn btn-danger"><span class="fa fa-remove" aria-hidden="true"></span> Cancel</button>
                          <button type="submit" class="btn btn-success"><span class="fa fa-check" aria-hidden="true"></span> Submit</button>
                        </div>
                      </div>
     </div>

                    </form>
                  </div>
                </div>
              </div>
            
  
     
    <!-- JS Main -->
    <script>
      $(document).ready(function() {
          
          /*
          
      // initialize the validator function
      validator.message.date = 'not a real date';

      // validate a field on "blur" event, a 'select' on 'change' event & a '.reuired' classed multifield on 'keyup':
      $('form')
        .on('blur', 'input[required], input.optional, select.required', validator.checkField)
        .on('change', 'select.required', validator.checkField)
        .on('keypress', 'input[required][pattern]', validator.keypress);

      $('.multi.required').on('keyup blur', 'input', function() {
        validator.checkField.apply($(this).siblings().last()[0]);
      });

      $('form').submit(function(e) {
        e.preventDefault();
        var submit = true;

        // evaluate the form using generic validaing
        if (!validator.checkAll($(this))) {
          submit = false;
        }

        if (submit)
          this.submit();

        return false;
      });
      
      */
      
          $(".flat").iCheck({
                                checkboxClass: 'icheckbox_flat-green',
                                radioClass: 'icheckbox_flat-green'
                            });

            $("#goto_back").click(function() {
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
             
                $("#loading").show();
                $.ajax({
                                 type: "POST",
                                 url: "module/user/user_list_modify_process_matrix.jsp",
                                 data: $(this).serialize(),
                                 cache:false,
                                 success: function(d) {
//                                     $("#maincontent").empty();
//                                     $("#maincontent").html(d);
//                                     $("#maincontent").show();
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
                                            }
                                        });

                                         //$(location).attr('href','module/opp/opp_list.jsp');
                                    
                                     new PNotify({title: '<%=actionText%> Data',text: 'Data has been saved..',type: 'success',styling: 'bootstrap3'});
                                     
                
                                  }});
                              
                return false;
            });

      });
      
</script>
    
        
<script>
    $(document).ready(function() {
        $('#single_cal1').daterangepicker({
            singleDatePicker: true,
            calender_style: "picker_1"
            }, function(start, end, label) {
            console.log(start.toISOString(), end.toISOString(), label);
            });
    });
</script>