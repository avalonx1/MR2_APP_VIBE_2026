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
  
// int id;
 String id="0";
 String v_nama_divisi="";
 String v_id_divisi="";
 String v_id = "";
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

                                 sql = "select id, divisi, div_id  from t_divisi where id="+id;
                                                      
                            resultSet = db.executeQuery(sql);
                            String rowstate = "even";
                                
                            while (resultSet.next()) {
                  
                                v_nama_divisi = resultSet.getString("divisi");
                                v_id_divisi = resultSet.getString("div_id");
                                v_id = resultSet.getString("id");

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
               <h3><i class="fa fa-group"></i> Division </h3>
              </div>
              </div>
            </div>
            <div class="clearfix"></div>
            
            
            <div class="col-md-12 col-xs-12">
                <div class="x_panel">
                  <div class="x_title">
                    <h2><%=actionText%> Division + </h2>
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
                        <label class="control-label col-md-3 col-sm-3 col-xs-12">Division Code</label>
                        <div class="col-md-9 col-sm-9 col-xs-12">
                            <input id="p_id_divisi" name="p_id_divisi" required="true" type="text" class="form-control col-md-7 col-xs-12"  placeholder="Max.3 digit" maxlength="3" size="3" value="<% out.println((v_id_divisi == null) ? "" : v_id_divisi); %>" >
                        </div>
                      </div>
                    
                      <div class="form-group">
                        <label class="control-label col-md-3 col-sm-3 col-xs-12">Division Name</label>
                        <div class="col-md-9 col-sm-9 col-xs-12">
                            <input id="p_nama_divisi" name="p_nama_divisi" required="true" type="text" class="form-control col-md-7 col-xs-12"  placeholder="Input name" value="<% out.println((v_nama_divisi == null) ? "" : v_nama_divisi); %>" >
                        </div>
                        <a href="divisi_list.jsp"></a>
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
        
            $("#goto_back").click(function() {
                                 $("#loading").show();
                                $.ajax({
                                 type: "POST",
                                 url: "module/divisi/divisi_list.jsp",
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
                                 url: "module/divisi/divisi_list_modify_process.jsp",
                                 data: $(this).serialize(),
                                 cache:false,
                                 success: function(d) {
                                    statProcess = $.trim(d);
                                 },
                                 complete: function(){
                                     
                                      $.ajax({
                                            type: 'POST',
                                            url: "module/divisi/divisi_list.jsp",
                                            data: "",
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
