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
  
 String v_name_prod="";
 String v_code_prod="";
 String v_desc_prod="";
 
 
           
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

                                 
                                 sql = " select id,name,code,description "
                                         + "from t_product where id="+id;
                            
                                   
         
                           // out.println(sql);
                                
                            resultSet = db.executeQuery(sql);
                            String rowstate = "even";
                                
                            while (resultSet.next()) {
                                
                                
                                v_name_prod = resultSet.getString("name");
                                v_code_prod = resultSet.getString("code");
                                v_desc_prod = resultSet.getString("description");
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
               <h3><i class="fa fa-cubes"></i> New Product </h3>
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
                        <label class="control-label col-md-3 col-sm-3 col-xs-12">Name Product *</label>
                        <div class="col-md-9 col-sm-9 col-xs-12">
                            <input id="p_name_prod" required="true" name="p_name_prod" type="text" class="form-control col-md-7 col-xs-12"   placeholder="Input product name" value="<% out.println((v_name_prod == null) ? "" : v_name_prod); %>" >
                        </div>
                      </div>
                        <div class="form-group">
                        <label class="control-label col-md-3 col-sm-3 col-xs-12">Product Code *</label>
                        <div class="col-md-9 col-sm-9 col-xs-12">
                          <input id="p_code_prod" required="true" name="p_code_prod" type="text" class="form-control col-md-7 col-xs-12"  placeholder="Input code product" value="<% out.println((v_code_prod == null) ? "" : v_code_prod); %>" >
                        </div>
                      </div>
                                          
                     <div class="form-group">
                        <label class="control-label col-md-3 col-sm-3 col-xs-12" >Description Product</label>
                         <div class="col-md-9 col-sm-9 col-xs-12">
                            <textarea id="p_desc_prod" name="p_desc_prod" class="resizable_textarea form-control"><% out.println((v_desc_prod == null) ? "" : v_desc_prod); %></textarea>
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
                                 url: "module/product/product_list.jsp",
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
                                 url: "module/product/product_list_modify_process.jsp",
                                 data: $(this).serialize(),
                                 cache:false,
                                 success: function(d) {
                                     $("#maincontent").empty();
                                     $("#maincontent").html(d);
                                     $("#maincontent").show();
                                 },
                                 complete: function(){
                                     
                                      $.ajax({
                                            type: 'POST',
                                            url: "module/product/product_list.jsp",
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
    <!-- /Datatables -->