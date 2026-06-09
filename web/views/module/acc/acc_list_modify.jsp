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
  
 String v_name_acc="";
 String v_desc_acc="";
 String v_website_acc="";
 String v_industry_acc="";
 String v_emp_acc="";
 String v_phone_acc="";
 String v_annual_acc="";
 
 String v_address_acc="";
 String v_country_acc="";
 String v_street_acc="";
 String v_city_acc="";
 String v_postal_acc="";
 String v_state_acc="";
 
 String v_b_address_acc="";
 String v_b_country_acc="";
 String v_b_street_acc="";
 String v_b_city_acc="";
 String v_b_postal_acc="";
 String v_b_state_acc="";
 String v_id_owner="";
 String v_id_member="";
 
 
           
 if (actionCode.equals("ADD") ) {
     header_title_act="Add";
     v_id_owner=v_userID;
 } else {
     header_title_act="Edit";
     id  = request.getParameter("id");
     
     
      try {
                        ResultSet resultSet = null;
                        Database db = new Database();
                        try {
                            db.connect(1);
                            String sql;
                                
//                            sql = "SELECT id,field_name,code as opp_code,name as opp_name,description "
//                                 +" from t_opportunity where id="+id;
                            
                                 sql = "SELECT id,name,website,phone,description,"
                                         + "address_b,country_b,street_b,city_b,state_b,postal_code_b,"
                                         + "address_s,country_s,street_s,city_s,state_s,postal_code_s,"
                                         + "annual_revenue, id_industry, no_of_employees,id_owner,id_member "
                                 +" from t_account where id="+id;

//                            out.println(sql);
                                
                            resultSet = db.executeQuery(sql);
                            String rowstate = "even";
                                
                            while (resultSet.next()) {

                                v_name_acc = resultSet.getString("name");
                                v_website_acc= resultSet.getString("website");
                                v_phone_acc = resultSet.getString("phone");
                                v_desc_acc = resultSet.getString("description");
                                v_b_address_acc= resultSet.getString("address_b");
                                v_b_country_acc= resultSet.getString("country_b");
                                v_b_street_acc= resultSet.getString ("street_b");
                                v_b_city_acc= resultSet.getString ("city_b");
                                v_b_state_acc= resultSet.getString("state_b");
                                v_b_postal_acc= resultSet.getString("postal_code_b");
                                v_address_acc= resultSet.getString("address_s");
                                v_country_acc= resultSet.getString("country_s");
                                v_street_acc= resultSet.getString ("street_s");
                                v_city_acc= resultSet.getString ("city_s");
                                v_state_acc= resultSet.getString("state_s");
                                v_postal_acc= resultSet.getString("postal_code_s");
                                v_annual_acc= resultSet.getString("annual_revenue");
                                v_industry_acc= resultSet.getString("id_industry");
                                v_emp_acc= resultSet.getString("no_of_employees");
                                v_id_owner=resultSet.getString("id_owner");
                                v_id_member = resultSet.getString("id_member");
                               

//                                opp_ordernum =  resultSet.getString("opp_ordernum");
                                
                               
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
               <h3><i class="fa fa-user"></i> New Account </h3>
              </div>
              </div>
            </div>
            <div class="clearfix"></div>
            
            
            <div class="col-md-12 col-xs-12">
                <div class="x_panel">
                  <div class="x_title">
                    <h2>Create New Account + </h2>
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
                        
                           <h2 color="grey">Priviledges </h2> 
                           
                           <div class="col-md-6 col-sm-6 col-xs-12 form-group has-feedback">
                                <label class="control-label col-md-3">Member </label>
                                <div class="col-md-9 col-sm-9 col-xs-12">
                                    <select id="p_id_member" name="p_id_member" class="select2_single form-control" required tabindex="-1">
                                       
                                       <%

                                    try {
                                        ResultSet resultSet=null;
                                        Database db = new Database();
                                        try {
                                            db.connect(1);
                                            String sql;

                                            sql = "SELECT MEMBER_ID AS ID, member_code||' '||member_name AS DESC "
                                                    + " FROM v_user_access where userid="+v_userID+" "
                                                    + " ORDER BY 2 ";
                                            resultSet = db.executeQuery(sql);
                                            while (resultSet.next()) {
                                                if (v_id_member.equalsIgnoreCase(resultSet.getString(1))) {
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
                                <label class="control-label col-md-3">Owner </label>
                                <div class="col-md-9 col-sm-9 col-xs-12">
                                    <select id="p_id_owner" name="p_id_owner" class="select2_single form-control" required tabindex="-1">
                                       
                                       <%

                                    try {
                                        ResultSet resultSet=null;
                                        Database db = new Database();
                                        try {
                                            db.connect(1);
                                            String sql;

                                            sql = "SELECT subordinate_userid as ID, subordinate_first_name||' '||subordinate_last_name ||' ('||subordinate_username||')' AS DESC "
                                                    + " FROM v_subordinate_user "
                                                    + " where userid="+v_userID
                                                    + "  ";
                                            resultSet = db.executeQuery(sql);
                                            while (resultSet.next()) {
                                                if (v_id_owner.equalsIgnoreCase(resultSet.getString(1))) {
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
                      </div>
                      
                                    
                                    
                                    
                                    <div class="divider-dashed"></div>
                                    
                    
                 <div class="form-group">
                           <h2 color="grey">Account Information</h2>         
                      
                      <div class="col-md-6 col-sm-6 col-xs-12 form-group has-feedback">
                        <label class="control-label col-md-3 col-sm-3 col-xs-12">Account Name</label>
                        <div class="col-md-9 col-sm-9 col-xs-12">
                            <input id="p_name_acc" required="true" name="p_name_acc" type="text" class="form-control col-md-7 col-xs-12 has-feedback-left" placeholder="Input account name" value="<% out.println((v_name_acc == null) ? "" : v_name_acc); %>" >
                          <span class="fa fa-user form-control-feedback left" aria-hidden="true"></span>
                        </div>
                      </div>
                          <div class="col-md-6 col-sm-6 col-xs-12 form-group has-feedback">
                        <label class="control-label col-md-3 col-sm-3 col-xs-12">Website</label>
                        <div class="col-md-9 col-sm-9 col-xs-12">
                          <input id="p_website_acc" name="p_website_acc" type="text" class="form-control col-md-7 col-xs-12 has-feedback-left" placeholder="Input website acccount" value="<% out.println((v_website_acc == null) ? "" : v_website_acc); %>" >
                        <span class="fa fa-globe form-control-feedback left" aria-hidden="true"></span>
                        </div>
                      </div>
                        <div class="col-md-6 col-sm-6 col-xs-12 form-group has-feedback">
                        <label class="control-label col-md-3 col-sm-3 col-xs-12">Phone</label>
                        <div class="col-md-9 col-sm-9 col-xs-12">
                          <input id="p_phone_acc" name="p_phone_acc" type="text" class="form-control col-md-7 col-xs-12 has-feedback-left" placeholder="Input phone acccount" value="<% out.println((v_phone_acc == null) ? "" : v_phone_acc); %>" >
                        <span class="fa fa-phone form-control-feedback left" aria-hidden="true"></span>
                        </div>
                      </div>
                        
                         <div class="col-md-6 col-sm-6 col-xs-12 form-group has-feedback">
                                    <label class="control-label col-md-3 col-sm-3 col-xs-12" >Address</label>
                                    <div class="col-md-9 ">
                                        <textarea id="p_address_acc" name="p_address_acc" placeholder="Input account address" class="resizable_textarea form-control"><% out.println((v_address_acc == null) ? "" : v_address_acc); %></textarea>
                                    </div>
                                </div>
                        
                       <div class="col-md-6 col-sm-6 col-xs-12 form-group has-feedback">
                                <label class="control-label col-md-3">Industry</label>
                                <div class="col-md-9 col-sm-9 col-xs-12">
                                    <select id="p_industry_acc" name="p_industry_acc" class="select2_single form-control" tabindex="-1">
                                       <%

                                    try {
                                        ResultSet resultSet=null;
                                        Database db = new Database();
                                        try {
                                            db.connect(1);
                                            String sql;

                                            sql = "SELECT id ID, code||' - '||name AS DESC "
                                                    + " FROM t_lov  "
                                                    + " where field_name = 'INDUSTRY' "
                                                    + " ORDER BY ordernum ";
                                            resultSet = db.executeQuery(sql);
                                            while (resultSet.next()) {
                                                if (v_industry_acc.equalsIgnoreCase(resultSet.getString(1))) {
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
                            <label class="control-label col-md-3 col-sm-3 col-xs-12"><small>Number of Employees</small></label>
                        <div class="col-md-9 col-sm-9 col-xs-12">
                            <input id="p_emp_acc" name=p_emp_acc type="text" class="form-control"  placeholder="input number of employess account" value="<% out.println((v_emp_acc.equals("")) ? "0" : v_emp_acc); %>"  >
                        </div>
                      </div>

                        <div class="col-md-6 col-sm-6 col-xs-12 form-group has-feedback">
                                    <label class="control-label col-md-3 col-sm-3 col-xs-12" >Description</label>
                                    <div class="col-md-9 ">
                                        <textarea id="p_desc_acc" name="p_desc_acc" class="resizable_textarea form-control"><% out.println((v_desc_acc == null) ? "" : v_desc_acc); %></textarea>
                                    </div>
                                </div>

                      <div class="col-md-6 col-sm-6 col-xs-12 form-group has-feedback">
                        <label class="control-label col-md-3 col-sm-3 col-xs-12">Country</label>
                        <div class="col-md-9 col-sm-9 col-xs-12">
                          <input id="p_country_acc" type="text" name="p_country_acc" class="form-control" placeholder="input country name" value="<% out.println((v_country_acc == null) ? "" : v_country_acc); %>">
                        </div>
                      </div>
                        
                      <div class="col-md-6 col-sm-6 col-xs-12 form-group has-feedback">
                        <label class="control-label col-md-3 col-sm-3 col-xs-12">Street</label>
                        <div class="col-md-9 col-sm-9 col-xs-12">
                          <input id="p_street_acc" type="text" name="p_street_acc" class="form-control" placeholder="input street name" value="<% out.println((v_street_acc == null) ? "" : v_street_acc); %>">
                        </div>
                      </div>
                        
                        <div class="col-md-6 col-sm-6 col-xs-12 form-group has-feedback">
                        <label class="control-label col-md-3 col-sm-3 col-xs-12">City</label>
                        <div class="col-md-9 col-sm-9 col-xs-12">
                          <input id="p_city_acc"  type="text" name="p_city_acc" class="form-control" placeholder="input city name" value="<% out.println((v_city_acc == null) ? "" : v_city_acc); %>">
                        </div>
                      </div>
                        
                        <div class="col-md-6 col-sm-6 col-xs-12 form-group has-feedback">
                        <label class="control-label col-md-3 col-sm-3 col-xs-12">State</label>
                        <div class="col-md-9 col-sm-9 col-xs-12">
                          <input id="p_state_acc" type="text" name="p_state_acc" class="form-control" placeholder="input state name" value="<% out.println((v_state_acc == null) ? "" : v_state_acc); %>">
                        </div>
                      </div>
                        
                        <div class="col-md-6 col-sm-6 col-xs-12 form-group has-feedback">
                        <label class="control-label col-md-3 col-sm-3 col-xs-12">Postal Code</label>
                        <div class="col-md-9 col-sm-9 col-xs-12">
                          <input id="p_postal_acc" type="text" name="p_postal_acc" class="form-control" placeholder="input postal code" value="<% out.println((v_postal_acc == null) ? "" : v_postal_acc); %>">
                        </div>
                      </div>
                        
                        <div class="col-md-6 col-sm-6 col-xs-12 form-group has-feedback">
                        <label class="control-label col-md-3 col-sm-3 col-xs-12">Annual Revenue</label>
                        <div class="col-md-9 col-sm-9 col-xs-12">
                            <input id="p_annual_acc" name="p_annual_acc" class="form-control has-feedback-left" placeholder="input annual revenue value" value="<% out.println((v_annual_acc.equals("")) ? "0" : v_annual_acc); %>">
                        <span class="fa fa-money form-control-feedback left" aria-hidden="true"></span>
                        </div>
                      </div>
                        <br/>
                        <br/>
                 </div>
                        
                          

                <div class="divider-dashed"></div>
                <div class="form-group">
                        
                        <!--Billing Information-->
                        <h2 color="grey">Billing Account Information</h2>         
                      
                      <div class="col-md-6 col-sm-6 col-xs-12 form-group has-feedback">
                        <label class="control-label col-md-3 col-sm-3 col-xs-12">Address</label>
                        <div class="col-md-9 col-sm-9 col-xs-12">
                          <input id="p_b_address_acc" name="p_b_address_acc" type="text" class="form-control"  placeholder="input address" value="<% out.println((v_b_address_acc == null) ? "" : v_b_address_acc); %>">
                        </div>
                      </div>
                        
                      <div class="col-md-6 col-sm-6 col-xs-12 form-group has-feedback">
                        <label class="control-label col-md-3 col-sm-3 col-xs-12">Country</label>
                        <div class="col-md-9 col-sm-9 col-xs-12">
                          <input id="p_b_country_acc" name="p_b_country_acc" type="text" class="form-control" placeholder="input country name" value="<% out.println((v_b_country_acc == null) ? "" : v_b_country_acc); %>">
                        </div>
                      </div>
                        
                      <div class="col-md-6 col-sm-6 col-xs-12 form-group has-feedback">
                        <label class="control-label col-md-3 col-sm-3 col-xs-12">Street</label>
                        <div class="col-md-9 col-sm-9 col-xs-12">
                          <input id="p_b_street_acc" name="p_b_street_acc" type="text" class="form-control" placeholder="input street name" value="<% out.println((v_b_street_acc == null) ? "" : v_b_street_acc); %>">
                        </div>
                      </div>
                        
                        <div class="col-md-6 col-sm-6 col-xs-12 form-group has-feedback">
                        <label class="control-label col-md-3 col-sm-3 col-xs-12">City</label>
                        <div class="col-md-9 col-sm-9 col-xs-12">
                          <input id="p_b_city_acc"  name="p_b_city_acc" type="text" class="form-control" placeholder="input city name" value="<% out.println((v_b_city_acc == null) ? "" : v_b_city_acc); %>">
                        </div>
                      </div>
                        
                        <div class="col-md-6 col-sm-6 col-xs-12 form-group has-feedback">
                        <label class="control-label col-md-3 col-sm-3 col-xs-12">State</label>
                        <div class="col-md-9 col-sm-9 col-xs-12">
                          <input id="p_b_state_acc" name="p_b_state_acc" type="text" class="form-control" placeholder="input state name" value="<% out.println((v_b_state_acc == null) ? "" : v_b_state_acc); %>">
                        </div>
                      </div>
                        
                        <div class="col-md-6 col-sm-6 col-xs-12 form-group has-feedback">
                        <label class="control-label col-md-3 col-sm-3 col-xs-12">Postal Code</label>
                        <div class="col-md-9 col-sm-9 col-xs-12">
                          <input id="p_b_postal_acc" name="p_b_postal_acc" type="text" class="form-control" placeholder="input postal code" value="<% out.println((v_b_postal_acc == null) ? "" : v_b_postal_acc); %>">
                        </div>
                      </div>
                </div>
                        
                        

                      <div class="ln_solid"></div>
                      <div class="form-group">
                        <div class="col-md-offset-5">
                          <button id="goto_back" type="button" class="btn btn-danger"><span class="fa fa-remove" aria-hidden="true"></span> Cancel</button>
                          <button type="submit" class="btn btn-success"><span class="fa fa-check" aria-hidden="true"></span> <%=actionText%></button>
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
                                 url: "module/acc/acc_list.jsp",
                                 data: "",
                                 cache:false,
                                 success: function(d) {
                                     $("#maincontent").empty();
                                     $("#maincontent").html(d);
                                     $("#maincontent").show();
                                     out.println(sql);
                                 },
                                 complete: function(){
                                     $("#loading").hide();
                                     out.println(sql);
                                  }});

            });
            
             $("#goto_submitModifyForm").submit(function () {
             
               var statProcess="";
//               out.println("<div class=sql>"+sql+"</div>");
               var targetName = $("#editor_p_desc").attr('data-target');
               $('#'+targetName).val($('#editor_p_desc').html());
       
                $("#maincontent").hide();
                $("#loading").show();
                $.ajax({
                                 type: "POST",
                                 url: "module/acc/acc_list_modify_process.jsp",
//                                 url: " ",
                                 data: $(this).serialize(),
                                 cache:false,
                                 success: function(d) {
                                    $("#maincontent").empty();
                                    $('#maincontent').html(d);
                                    $("#maincontent").show();  
                                     statProcess = $.trim(d);
//                                 out.println("<div class=sql>"+sql+"</div>");
                                 },
                                 complete: function(){
//                                     $("#loading").hide();
                                      $.ajax({
                                            type: 'POST',
                                            url: "module/acc/acc_list.jsp",
                                            data: '',
                                            success: function(d) {
                                                $("#maincontent").empty();
                                                $('#maincontent').html(d);
                                                $("#maincontent").show();                
                                            },
                                            complete: function(){
                                                $('#loading').hide();                                               
                                                
//                                                if (statProcess === "OK") {
//                                                    new PNotify({title: '<%=actionText%> Data',text: 'SUCCESS: Data has been saved..',type: 'success',styling: 'bootstrap3'});
//                                                } else {
//                                                    new PNotify({title: '<%=actionText%> Data',text: 'ERROR: Data Not Saved',type: 'error',styling: 'bootstrap3'});
//                                                }
 
                                            }
                                        });
                                         new PNotify({title: '<%=actionText%> Data',text: 'Data has been saved..',type: 'success',styling: 'bootstrap3'});
                                     }});
                return false;
            });
            
                        
   
      });
      
    </script>
    <!-- /Datatables -->