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
  
 String v_lead_source="";
 String v_first_name="";
 String v_last_name="";
 String v_statpos="";
 String v_website="";
 String v_company="";
 String v_industry="";
 String v_lead_title="";
 String v_email="";
 String v_phone="";
 String v_mobile="";
 String v_rating="";
 
 
 String v_desc="";
 String v_address="";
 String v_street ="";
 String v_city ="";
 String v_state ="";
 String v_postal ="";
 String v_country ="";
 String v_annual ="";
 
 String v_lead_status="";
 String v_date = "";
 String v_acc = "";
 
 
 String v_prob_opp = "";
 String v_stage_opp = "";
 String v_source_opp = "";
 String v_type_opp = "";
 String v_loss_opp = "";
 
 String v_acc_opp = "";
 String v_prod_opp = "";
 String v_camp_opp = "";
 
// Date v_date = new Date();
 
// v_date= new Date();
            
 if (actionCode.equals("ADD") ) {
     header_title_act="Add";
 } else {
     header_title_act="Edit";
     id  = request.getParameter("id");

      try {
                        ResultSet resultSet = null;
                        String sql;
                        Database db = new Database();
                        
                        try {
                            db.connect(1);
                            sql = "select leads_status_code from v_lead where id="+id;
                            resultSet = db.executeQuery(sql);
                           
                            while (resultSet.next()) {
                                v_statpos  =  resultSet.getString("leads_status_code");
                            }
                            
                            sql = "select id from t_lov where field_name = 'PROBABILITY' and code = '00'";
                            resultSet = db.executeQuery(sql);
                            while (resultSet.next()) {
                                v_prob_opp  =  resultSet.getString("id");
                            }
                            
                            sql = "select id from t_lov where field_name = 'OPPORTUNITY_TYPE' and code = '00'";
                            resultSet = db.executeQuery(sql);
                            while (resultSet.next()) { 
                                v_type_opp  =  resultSet.getString("id");
                            }
                            
                            sql = "select id from t_lov where field_name = 'OPPORTUNITY_STAGE' and code = '00'";
                            resultSet = db.executeQuery(sql);
                            while (resultSet.next()) {
                                v_stage_opp  =  resultSet.getString("id");
                            }
                                
                            sql = "select id from t_lov where field_name = 'LOSS_REASON' and code = '00'";
                            resultSet = db.executeQuery(sql);
                            while (resultSet.next()) {
                                v_loss_opp  =  resultSet.getString("id");
                            }
                            
                            sql = "select id,name from t_campaign where name = 'N/A'";
                            resultSet = db.executeQuery(sql);
                            while (resultSet.next()) {
                                v_camp_opp  =  resultSet.getString("id");
                            }
                            
                            sql = "select id,name from t_product where name = 'N/A'";
                            resultSet = db.executeQuery(sql);
                                
                            while (resultSet.next()) {   
                                v_prod_opp  =  resultSet.getString("id");
                            }
                            
                            sql = "select id,first_name,last_name,description,address,website,email,company,id_industry,id_rating,id_lead_source,id_lead_status,"
                                     + "title, phone, mobilephone, street, city, state, postal_code, country, annual_revenue "
                                     + "from t_lead where id="+id;
                                
                            resultSet = db.executeQuery(sql);
                                
                            while (resultSet.next()) {
                                v_lead_source =  resultSet.getString("id_lead_source");
                                v_lead_status =  resultSet.getString("id_lead_status");
                                v_first_name  =  resultSet.getString("first_name");
                                v_last_name  =  resultSet.getString("last_name");
                                v_website =  resultSet.getString("website");
                                v_company = resultSet.getString("company");
                                v_industry = resultSet.getString("id_industry");
                                v_lead_title = resultSet.getString("title");
                                v_email = resultSet.getString("email");
                                v_phone = resultSet.getString("phone");
                                v_mobile = resultSet.getString("mobilephone");
                                v_rating = resultSet.getString("id_rating");                                
                                v_desc =resultSet.getString("description");
                                v_address =resultSet.getString("address");
                                v_street =resultSet.getString("street");
                                v_city =resultSet.getString("city");
                                v_state =resultSet.getString("state");
                                v_postal =resultSet.getString("postal_code");
                                v_country =resultSet.getString("country");
                                v_annual =resultSet.getString("annual_revenue");
                                
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
                  <h3><i class="fa fa-child"></i> Leads </h3>
              </div>
                </div>
              </div>
            <div class="clearfix"></div>
                <div class="x_panel">
                  <div class="x_title">
                     <h2><i class="fa fa-bolt"></i> <%=actionText%> Leads <%=v_first_name%> </h2>
                    <ul class="nav navzbar-right panel_toolbox">
                      
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
        
                    <!-- Smart Wizard -->

                    <div id="wizard" class="form_wizard wizard_horizontal" >
                      <ul class="wizard_steps">
                        <li>
                          <a href="#step-1">
                            <span class="step_no fa fa-eye-slash"></span>
                            <span class="step_descr">
                                              Unqualified<br />

                                          </span>
                          </a>
                        </li>
                        <li>
                          <a href="#step-2">
                             <span class="step_no fa fa-plus"></span>
                            <span class="step_descr">
                                              New<br/>
                                          </span>
                          </a>
                        </li>
                        <li>
                          <a href="#step-3">
                             <span class="step_no fa fa-industry"></span>
                            <span class="step_descr">
                                              Working<br />

                                          </span>
                          </a>
                        </li>
                        <li>
                          <a href="#step-4">
                             <span class="step_no fa fa-street-view"></span>
                            <span class="step_descr">
                                              Nurturing<br />

                                          </span>
                          </a>
                        </li>

                          <li>
                          <a href="#step-5">
                             <span class="step_no fa fa-trophy"></span>
                            <span class="step_descr">
                                              Convert<br />

                                          </span>
                          </a>
                        </li>
                      </ul>
                    
                        
                    <div id="step-1" class="wizard_fixheight">
                    <%    
                                          try {
                        ResultSet resultSet = null;
                        Database db = new Database();
                        try {
                            db.connect(1);
                            String sql;

                                sql = "select id, id_group,id_owner,id_lead_type,title, first_name, last_name, suffix, company, phone, mobilephone, website, "
                                    + "no_of_employee, email, id_industry, id_lead_source, id_rating, address, street, city, state, postal_code, country, "
                                    + "annual_revenue, description, id_lead_status, id_salutation"
                                 +" from t_lead where id="+id;

                           // out.println(sql);
                                
                            resultSet = db.executeQuery(sql);
                            String rowstate = "even";
                                
                            while (resultSet.next()) {
                                v_lead_source =  resultSet.getString("id_lead_source");
                               
  
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
                    %>
        <div class="x_panel">
            <form id="goto_form_step1" class="form-horizontal form-label-left">
                <input type="hidden" id="id" name="id" value="<%=id%>" />
                <input type="hidden" id="actionCode" name="actionCode" value="<%=actionCode%>" />

                <div class="col-md-6">
                    <div class="form-group">
                        <label class="control-label col-md-3 col-sm-3 col-xs-12">Lead Source<span class="required"></span></label>
                        <div class="col-md-9">
                            <select id="p_lead_source" name="p_lead_source" class="select2_single form-control" tabindex="-1">
                                <%
                                    try {
                                        ResultSet resultSet=null;
                                        Database db = new Database();
                                        try {
                                            db.connect(1);
                                            String sql;

                                            sql = "SELECT id ID, code||' - '||name AS DESC "
                                                    + " FROM t_lov  "
                                                    + " where field_name = 'LEAD_SOURCE' "
                                                    + " ORDER BY ordernum ";
                                            resultSet = db.executeQuery(sql);
                                            while (resultSet.next()) {
                                                if (v_lead_source.equalsIgnoreCase(resultSet.getString(1))) {
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
                        <div class="col-md-offset-6">
                                  <button type="submit" class="btn btn-success"><span class="fa fa-check"></span> Save </button>
                                </div>
                </div>
                <div class="col-md-6">
                    <p class="well"><b><span class="fa fa-info"></span></b> Masukan data Sumber Leads.</p>
                </div>
            </form>
        </div>
    </div>
                                 
        <div id="step-2" class="wizard_fixheight">
<%    
                          try {
                        ResultSet resultSet = null;
                        Database db = new Database();
                        try {
                            db.connect(1);
                            String sql;

                                sql = "select id, id_group,id_owner,id_lead_type,title, first_name, last_name, suffix, company, phone, mobilephone, website, "
                                    + "no_of_employee, email, id_industry, id_lead_source, id_rating, address, street, city, state, postal_code, country, "
                                    + "annual_revenue, description, id_lead_status, id_salutation"
                                 +" from t_lead where id="+id;

                           // out.println(sql);
                                
                            resultSet = db.executeQuery(sql);
                            String rowstate = "even";
                                
                            while (resultSet.next()) {
                                v_company =  resultSet.getString("company");
                                v_website =  resultSet.getString("website");
                                v_industry = resultSet.getString("id_industry");
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
                    %>
                    <div class="x_panel">  
                    <form id="goto_form_step2" class="form-horizontal form-label-left">
                      <input type="hidden" id="id" name="id" value="<%=id%>" />
                      <input type="hidden" id="actionCode" name="actionCode" value="<%=actionCode%>" />
                       <div class="col-md-6">
                          <div class="form-group">
                                <label class="control-label col-md-3 col-sm-3 col-xs-12">Company</label>
                                <div class="col-md-9">
                                <!--<div>-->
                                    <input class="form-control col-md-7 col-xs-12 has-feedback-left" id="p_company" name="p_company" type="text" value="<% out.println((v_company == null) ? "" : v_company); %>">
                                    <span class="fa fa-institution form-control-feedback left" aria-hidden="true"></span>
                                </div>
                          </div>
                            
                            
                            <div class="form-group">
                                <label class="control-label col-md-3 col-sm-3 col-xs-12">Website</label>
                                <!--<div>-->
                                <div class="col-md-9">
                                    <input class="form-control has-feedback-left" id="p_website" name="p_website" type="text" value="<% out.println((v_website == null) ? "" : v_website); %>">
                                    <span class="fa fa-globe form-control-feedback left" aria-hidden="true"></span>
                                </div>
                            </div>

                                    
                            <div class="form-group">        
                            <label class="control-label col-md-3 col-sm-3 col-xs-12">Industry<span class="required"></span></label>
                            <div class="col-md-9">
                               <select id="p_industry" name="p_industry" class="select2_single form-control col-md-7" tabindex="-1" required >
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
                                                if (v_industry.equalsIgnoreCase(resultSet.getString(1))) {
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
                                <div class="col-md-offset-6">
                                  <button type="submit" class="btn btn-success"><span class="fa fa-check"></span> Save </button>
                                </div>
                         </div>
    
                           <div class="col-md-6">
                                <p class="well"><b><span class="fa fa-info"></span></b> Masukan data Nama Perusahaan, Alamat Website dan Jenis Industri</p>
                            </div>
                    </form>
                </div>
        </div>
                           
        
                          <!--Step-3-->
                        <div id="step-3" class="wizard_fixheight">
                        <%    
                          try {
                        ResultSet resultSet = null;
                        Database db = new Database();
                        try {
                            db.connect(1);
                            String sql;

                                sql = "select id, id_group,id_owner,id_lead_type, title, first_name, last_name, suffix, company, phone, mobilephone, website, "
                                    + "no_of_employee, email, id_industry, id_lead_source, id_rating, address, street, city, state, postal_code, country, "
                                    + "annual_revenue, description, id_lead_status, id_salutation"
                                 +" from t_lead where id="+id;

                           // out.println(sql);
                                
                            resultSet = db.executeQuery(sql);
                            String rowstate = "even";
                                
                            while (resultSet.next()) {
                                v_title =  resultSet.getString("title");
                                v_email =  resultSet.getString("email");
                                v_phone =  resultSet.getString("phone");
                                v_mobile =  resultSet.getString("mobilephone");
                               
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
                    %>
                    <div class="x_panel">  
                    <form id="goto_form_step3" class="form-horizontal form-label-left">
                      <input type="hidden" id="id" name="id" value="<%=id%>" />
                      <input type="hidden" id="actionCode" name="actionCode" value="<%=actionCode%>" />    
                      <div class="col-md-6">
                      <div class="form-group">
                                <label class="control-label col-md-3 col-sm-3 col-xs-12">Title</label>
                                <div class="col-md-9">
                                    <input class="form-control has-feedback-left" id="p_title" name="p_title" type="text" value="<% out.println((v_lead_title == null) ? "" : v_lead_title); %>">
                                    <span class="fa fa-user form-control-feedback left" aria-hidden="true"></span>
                                </div>
                      </div>
                            
                          <div class="form-group">
                                <label class="control-label col-md-3 col-sm-3 col-xs-12">Email</label>
                                <div class="col-md-9">
                                    <input class="form-control has-feedback-left" id="p_email" name="p_email" type="text" value="<% out.println((v_email == null) ? "" : v_email); %>">
                                    <span class="fa fa-envelope form-control-feedback left" aria-hidden="true"></span>
                                </div>
                          </div>
                            
                          <div class="form-group">
                                <label class="control-label col-md-3 col-sm-3 col-xs-12">Phone</label>
                                <div class="col-md-9">
                                    <input class="form-control has-feedback-left" id="p_phone" name="p_phone" type="text" value="<% out.println((v_phone == null) ? "" : v_phone); %>">
                                    <span class="fa fa-phone form-control-feedback left" aria-hidden="true"></span>
                                </div>
                          </div>

                         <div class="form-group">
                                <label class="control-label col-md-3 col-sm-3 col-xs-12">Mobile Phone</label>
                                <div class="col-md-9">
                                    <input class="form-control has-feedback-left" id="p_mobile" name="p_mobile" type="text" value="<% out.println((v_mobile == null) ? "" : v_mobile); %>">
                                    <span class="fa fa-mobile-phone form-control-feedback left" aria-hidden="true"></span>
                                </div>
                         </div>
                      
                        <div class="col-md-offset-6">
                          <button type="submit" class="btn btn-success"><span class="fa fa-check"></span> Save </button>
                        </div> 
                       </div>     
                       
                       <div class="col-md-6">
                           <p class="well"><b><span class="fa fa-info"></span></b> Masukan data Title, Email, Nomor Telephone dan Nomor Handphone</p>
                       </div>
                    
                    </form>
                    </div>
                    </div>
                     
     
                        <div id="step-4" class="wizard_fixheight">
                     <!--<form class="form-horizontal form-label-left">-->
                     <%    
                          try {
                        ResultSet resultSet = null;
                        Database db = new Database();
                        try {
                            db.connect(1);
                            String sql;

                                sql = "select id, id_group,id_owner,id_lead_type,title, first_name, last_name, suffix, company, phone, mobilephone, website, "
                                    + "no_of_employee, email, id_industry, id_lead_source, id_rating, address, street, city, state, postal_code, country, "
                                    + "annual_revenue, description, id_lead_status, id_salutation"
                                 +" from t_lead where id="+id;

                           // out.println(sql);
                                
                            resultSet = db.executeQuery(sql);
                            String rowstate = "even";
                                
                            while (resultSet.next()) {
                                v_rating =  resultSet.getString("id_rating");
                               
  
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
                    %>
                    <div class="x_panel">
                        <form id="goto_form_step4" class="form-horizontal form-label-left">
                      <input type="hidden" id="id" name="id" value="<%=id%>" />
                      <input type="hidden" id="actionCode" name="actionCode" value="<%=actionCode%>" />
                      <div class="col-md-6">
                         <div class="form-group">
                            <label class="control-label col-md-3 col-sm-3 col-xs-12">Rating<span class="required"></span></label>
                            <div class="col-md-9">
                               <select id="p_rating" name="p_rating" class="select2_single form-control col-md-7" tabindex="-1" required >
                            <%

                                    try {
                                        ResultSet resultSet=null;
                                        Database db = new Database();
                                        try {
                                            db.connect(1);
                                            String sql;

                                            sql = "SELECT id ID, code||' - '||name AS DESC "
                                                    + " FROM t_lov  "
                                                    + " where field_name = 'RATING' "
                                                    + " ORDER BY ordernum ";
                                            resultSet = db.executeQuery(sql);
                                            while (resultSet.next()) {
                                                if (v_rating.equalsIgnoreCase(resultSet.getString(1))) {
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
                             <div class="col-md-offset-6">
                                 <button type="submit" class="btn btn-success"><span class="fa fa-check"></span> Save </button>
                             </div>
                           </div>
                        </div>
                        <div class="col-md-6">
                            <p class="well"><b><span class="fa fa-info"></span></b> Masukan data Title, Email, Nomor Telephone dan Nomor Handphone</p>
                        </div>
                        
                        </form>
                        </div>
                     </div>
                          
                         <div id="step-5" class="wizard_fixheight">
                             <div class="x_panel">
                                <!--<div class="col-sm-offset-5 col-sm-2 text-center">-->
                                    
                                   
                                <div class="form-group">
                                            
                                            <!--<button type="button" class="btn btn-primary" data-toggle="modal" data-target=".bs-example-modal-lg">Test Convert Pop-up</button>-->
                                            <button type="submit" class="btn btn-success col-sm-offset-5 col-sm-2 text-center" data-toggle="modal" data-target="#modal_menu_convert"> Convert Leads* <span class="fa fa-thumbs-up"></span></button>
                                               <div id="modal_menu_convert" class="modal bs-example-modal-lg" tabindex="-1" role="dialog" aria-hidden="true" style="display: none;">
                                                <div class="modal-dialog modal-lg">
                                                  <div class="modal-content">

                                                    <div class="modal-header">
                                                      <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span>
                                                      </button>
                                                      <h4 class="modal-title" id="myModalLabel2">Convert Lead <%=v_first_name%> <%=v_last_name%> to Opportunity</h4>
                                                    </div>
                                                    <div class="modal-body">
                                                        <form id="convert_acc" class="form-horizontal form-label-left">
                                                            
                                                            
                                                            
                                        <!--Insert Account-->
                                        <input type="hidden" id="id" name="id" value="<%=id%>" />
                                        <input type="hidden" id="actionCode" name="actionCode" value="ADD" />
                                        
                                     
                                     
                                        <!--Insert Opportunity-->
                                        
                                       
                                        <input type="hidden" id="p_prob_opp" name="p_prob_opp" value="<%=v_prob_opp%>" />
                                        <input type="hidden" id="p_lead_source_opp" name="p_lead_source_opp" value="<%=v_lead_source%>" />
                                        <input type="hidden" id="p_stage_opp" name="p_stage_opp" value="<%=v_stage_opp%>" />
                                        <input type="hidden" id="p_type_opp" name="p_type_opp" value="<%=v_type_opp%>" />
                                        <input type="hidden" id="p_loss_opp" name="p_loss_opp" value="<%=v_loss_opp%>" />
                                        
                                        
                                        
                                        
                                        
                                            
                                                      <h4>Lead Status</h4>
                                                      
                                                      <div class="col-md-8 col-sm-6 col-xs-12 form-group has-feedback">
                                                                <label class="control-label col-md-3 col-sm-3 col-xs-12">Leads Status*</label>
                                                                <div class="col-md-9">
                                                                    <select id="p_lead_status_cont" name="p_lead_status_cont" class="select2_single form-control" tabindex="-1">
                                                                            <%

                                                                      try {
                                                                         ResultSet resultSet=null;
                                                                         Database db = new Database();
                                                                         try {
                                                                             db.connect(1);
                                                                             String sql;
 
                                                                             sql = "SELECT id ID, code||' - '||name AS DESC "
                                                                                     + " FROM t_lov  "
                                                                                     + " where field_name = 'LEAD_STATUS' and code='04' ";
                                                                             
                                                                              
                                                                             resultSet = db.executeQuery(sql);
                                                                             while (resultSet.next()) {
                                                                                 if (v_lead_status.equalsIgnoreCase(resultSet.getString(1))) {
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
                                                     <p>Convert lead status</p><br/>
                                                      
                                                     <div class="modal-footer text-left"> </div> 
                                                     
                                                    <h4>Account</h4> 
                                                     
                                                            <div class="col-md-8 col-sm-6 col-xs-12 form-group has-feedback">
                                                                <label class="control-label col-md-3 col-sm-3 col-xs-12">Select Account</label>
                                                                <div class="col-md-9">
                                                                    <select id="p_acc_opp" name="p_acc_opp" class="select2_single form-control" tabindex="-1">
                                                                        <option value="0" selected >- NEW ACCOUNT -</option>
                                                                        <%

                                                                     try {
                                                                         ResultSet resultSet=null;
                                                                         Database db = new Database();
                                                                         try {
                                                                             db.connect(1);
                                                                             String sql;
 
                                                                             sql = "SELECT id ID, name "
                                                                                 + " FROM t_account  "
                                                                                 + " ORDER BY ID ";
                                                                             resultSet = db.executeQuery(sql);
                                                                             while (resultSet.next()) {
                                                                                 if (v_acc.equalsIgnoreCase(resultSet.getString(1))) {
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
                                                                <p>Please select account for this opportunity. NEW ACCOUNT will create 1 record as account from lead information</p><br/>
                                                                
                                                            <div class="modal-footer text-left"> </div> 
       
                                                            <h4>Product</h4> 
                                                     
                                                            <div class="col-md-8 col-sm-6 col-xs-12 form-group has-feedback">
                                                                <label class="control-label col-md-3 col-sm-3 col-xs-12">Select Account</label>
                                                                <div class="col-md-9">
                                                                    <select id="p_product_opp" name="p_product_opp" class="select2_single form-control" tabindex="-1">
                                                                        
                                                                        <%

                                                                     try {
                                                                         ResultSet resultSet=null;
                                                                         Database db = new Database();
                                                                         try {
                                                                             db.connect(1);
                                                                             String sql;
 
                                                                             sql = "SELECT id ID, name "
                                                                                 + " FROM t_product  "
                                                                                 + " ORDER BY ID ";
                                                                             resultSet = db.executeQuery(sql);
                                                                             while (resultSet.next()) {
                                                                                 if (v_prod_opp.equalsIgnoreCase(resultSet.getString(1))) {
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
                                                                <p>Please select Product for this opportunity.</p><br/>
                                                            
                                                                 <div class="modal-footer text-left"> </div> 
       
                                                            <h4>Campaign</h4> 
                                                     
                                                            <div class="col-md-8 col-sm-6 col-xs-12 form-group has-feedback">
                                                                <label class="control-label col-md-3 col-sm-3 col-xs-12">Select Account</label>
                                                                <div class="col-md-9">
                                                                    <select id="p_campaign_opp" name="p_campaign_opp" class="select2_single form-control" tabindex="-1">
                                                                        
                                                                        <%

                                                                     try {
                                                                         ResultSet resultSet=null;
                                                                         Database db = new Database();
                                                                         try {
                                                                             db.connect(1);
                                                                             String sql;
 
                                                                             sql = "SELECT id ID, name "
                                                                                 + " FROM t_campaign  "
                                                                                 + " ORDER BY ID ";
                                                                             resultSet = db.executeQuery(sql);
                                                                             while (resultSet.next()) {
                                                                                 if (v_camp_opp.equalsIgnoreCase(resultSet.getString(1))) {
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
                                                                <p>Please select Campaign for this opportunity.</p><br/>
                                                                
                                                                
                                                                <div class="modal-footer text-left"> </div> 
                                                     <h4>Create Opportunity</h4>
                                                     
                                                        <div class="col-md-8 col-sm-6 col-xs-12 form-group has-feedback">
                                                                <label class="control-label col-md-3 col-sm-3 col-xs-12">Opportunity name</label>
                                                                <div class="col-md-9">
                                                                    <input id="p_name_opp" name="p_name_opp" type="text" class="form-control" placeholder="input opportunity name" required>
                                                                </div>
                                                        </div>
                                                     
                                                     <p>Input Name for this opportunity</p><br />
                                     
          
                                                    <div class="modal-footer text-center">
                                                      <button type="button" class="btn btn-primary" data-dismiss="modal"><span class="fa fa-close"></span> Close</button>
                                                      <button type="submit" class="btn btn-success"><span class="fa fa-check"></span> Convert </button>
                                                    </div> 
                                                                
                                                          </form>      
                                                    </div>

                                                  </div>
                                                </div>
                                              </div>

                                        </div> 
                                
                                <!--</div>-->
                                             
                             </div>
                        </div>
                  
                  
                  
                  </div>
                                                                    <button type="button" id="fixheight" class="btn btn-primary" ><span class="fa fa-chevron-circle-down"></span> Show data </button><br/>   
                </div>
           
              
<script src="../vendors/jQuery-Smart-Wizard/js/jquery.smartWizard.js"></script>
<script>
    
    
    $(document).ready(function() {
              
               $("#goto_form_step1").submit(function () {
             
               var statProcess="";
               
               var targetName = $("#editor_p_desc").attr('data-target');
               $('#'+targetName).val($('#editor_p_desc').html());
       

                $.ajax({
                                 type: "POST",
                                 url: "module/leads/leads_list_modify_process_wizard_p1.jsp",
                                 data: $(this).serialize(),
                                 cache:false,
                                 success: function(d) { 
                                     statProcess = $.trim(d);
                                 },
                                 complete: function(){
                                    // $('#loading').hide();
                                     
                                     if (statProcess === "OK") {
                                                
                                                    new PNotify({title:  '<%=actionText%> Data',text: 'SUCCESS: Data has been saved..',type: 'success',styling: 'bootstrap3'});
                                                } else {
                                                    new PNotify({title: '<%=actionText%> Data',text: 'ERROR: Data Not Saved',type: 'error',styling: 'bootstrap3'});
                                                }                                        
                                     }});
                return false;
            });
  
  
                
               $("#goto_form_step2").submit(function () {
             
               var statProcess="";
               var targetName = $("#editor_p_desc").attr('data-target');
               $('#'+targetName).val($('#editor_p_desc').html());
                $.ajax({
                                 type: "POST",
                                 url: "module/leads/leads_list_modify_process_wizard_p2.jsp",
                                 data: $(this).serialize(),
                                 cache:false,
                                 success: function(d) {
                                     statProcess = $.trim(d);
                                 },
                                 complete: function(){
                                     if (statProcess === "OK") {
                                                    new PNotify({title:  '<%=actionText%> Data',text: 'SUCCESS: Data has been saved..',type: 'success',styling: 'bootstrap3'});
                                                } else {
                                                    new PNotify({title: '<%=actionText%> Data',text: 'ERROR: Data Not Saved',type: 'error',styling: 'bootstrap3'});
                                                }
                                     }});
                return false;
                });
    
    
               $("#goto_form_step3").submit(function () {
             
               var statProcess="";
               var targetName = $("#editor_p_desc").attr('data-target');
               $('#'+targetName).val($('#editor_p_desc').html());
                $.ajax({
                                 type: "POST",
                                 url: "module/leads/leads_list_modify_process_wizard_p3.jsp",
                                 data: $(this).serialize(),
                                 cache:false,
                                 success: function(d) {
                                     statProcess = $.trim(d);
                                 },
                                 complete: function(){
                                     if (statProcess === "OK") {
                                                    new PNotify({title:  '<%=actionText%> Data',text: 'SUCCESS: Data has been saved..',type: 'success',styling: 'bootstrap3'});
                                                } else {
                                                    new PNotify({title: '<%=actionText%> Data',text: 'ERROR: Data Not Saved',type: 'error',styling: 'bootstrap3'});
                                                }
                                     }});
                return false;
                });



                $("#goto_form_step4").submit(function () {
             
               var statProcess="";
               var targetName = $("#editor_p_desc").attr('data-target');
               $('#'+targetName).val($('#editor_p_desc').html());
                $.ajax({
                                 type: "POST",
                                 url: "module/leads/leads_list_modify_process_wizard_p4.jsp",
                                 data: $(this).serialize(),
                                 cache:false,
                                 success: function(d) {
                                     statProcess = $.trim(d);
                                 },
                                 complete: function(){
                                     if (statProcess === "OK") {
                                                    new PNotify({title:  '<%=actionText%> Data',text: 'SUCCESS: Data has been saved..',type: 'success',styling: 'bootstrap3'});
                                                } else {
                                                    new PNotify({title: '<%=actionText%> Data',text: 'ERROR: Data Not Saved',type: 'error',styling: 'bootstrap3'});
                                                }
                                     }});
                return false;
                });




                $("#convert_acc").submit(function () {
                
                
           
                $('#modal_menu_convert').modal('hide');
                    $('body').removeClass('modal-open');
                    $('.modal-backdrop').remove();
                
                var statProcess="";
             
                
                $("#maincontent").hide(); 
                $("#loading").show();
                   
                
               $.ajax({
                         type: "POST",
                         url: "module/opp/opp_list_modify_process_conv.jsp",
                         data: $(this).serialize(),
                         cache:false,
                         success: function(d) { 
                                //$("#maincontent").empty();
                                //$("#maincontent").html(d);
                                //$("#maincontent").show(); 
                                statProcess = $.trim(d);

                         },
                         complete: function(){
                                $("#loading").hide();
                               $.ajax({
                                type: "POST",
                                url: "module/opp/opp_list.jsp",
                                data:'',
                                cache:false,
                                success: function(d) { 
                                       $("#maincontent").empty();
                                       $('#maincontent').html(d);
                                       $("#maincontent").show(); 
                                       //statProcess = $.trim(d);

                                },
                                complete: function(){
                                       $('#loading').hide();                                               

                                       if (statProcess === "OK") {
                                                    new PNotify({title: '<%=actionText%> Data',text: 'SUCCESS: Data has been saved..',type: 'success',styling: 'bootstrap3'});
                                                } else {
                                                    new PNotify({title: '<%=actionText%> Data',text: 'ERROR: Data Not Saved <br>'+statProcess,type: 'error',styling: 'bootstrap3'});
                                                }

                                   }
                               }); 
                               

                            }
                        });   
                        
             
                
                return false;
            });


});        
</script>

<script>
      $(document).ready(function() {
        $("#fixheight").click(function() { 
            $("#wizard"). smartWizard("fixHeight"); 
        });
        
        $('#wizard').smartWizard({
            transitionEffect: 'slide',
            noForwardJumping: true,
            selected: <%=v_statpos%>
        });


        $('.buttonPrevious').addClass('btn btn-primary');
        $('.buttonNext').addClass('btn btn-primary');

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