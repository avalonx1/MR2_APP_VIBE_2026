<%@include file="../../../includes/check_auth_layer3.jsp"%>
<%
        
     
      int displaystart = Integer.parseInt(request.getParameter("start"));
      int displaylength = Integer.parseInt(request.getParameter("length"));
      String search = request.getParameter("search[value]");
      //int columnIdxOrder = Integer.parseInt(request.getParameter("order[i][column]"));
     // String columnDirOrder = request.getParameter("order[1][dir]");
      
              
      int draw =Integer.parseInt(request.getParameter("draw")) ;
        
                    
          try {
            ResultSet resultSet=null;
            Database db = new Database();
            try {   
            
                db.connect(1);
                String sql;
                
                sql = "select count(1) as jml from t_roles";
                resultSet = db.executeQuery(sql);
                int totalRecords =0;
                while (resultSet.next()) {
                    totalRecords = resultSet.getInt("jml");
                }
                
                sql = "select id, role_code, role_name, role_description, hierarchy_flag, role_level from t_roles ";

                if(!search.equals("")) {
                   
                    sql += " where ( lower(role_name) like('%"+search.toLowerCase()+"%') ";
                    sql += "or lower(role_code) like('%"+search.toLowerCase()+"%') ";
                    sql += "or lower(role_description) like('%"+search.toLowerCase()+"%') ";
                    sql += ")";
                    
                 }
                
                
                sql += " order by 1 ";
                sql += " OFFSET "+displaystart+" LIMIT "+displaylength;
                
                 //debug mode            
                        if (v_debugMode.equals("1")) {
                        System.out.println(sql);
                        }
                
                resultSet = db.executeQuery(sql);
                // format returned ResultSet as a JSON array
                JsonObject returnObj = new JsonObject();    
                JsonArray recordsArrayData = new JsonArray();

                String actText="";
                String rowidText="";
                
                int row = 0;
                while (resultSet.next()) {
                        JsonObject fieldColumnObj = new JsonObject();  
                                  
              
                        actText = "<a  id='view_"+resultSet.getString("id")+"' class='btn btn-primary btn-xs'><i class='fa fa-folder'></i> View </a>";
                        actText += "<a  id='edit_"+resultSet.getString("id")+"' class='btn btn-info btn-xs'><i class='fa fa-pencil'></i> Edit </a>";
                        actText += "<a  class='btn btn-danger btn-xs' data-toggle='modal' data-target='#confirm-delete_"+resultSet.getString("id")+"' ><i class='fa fa-trash-o'></i> Delete </a>";
                        
                       
                        
                        actText += "<div id='confirm-delete_"+resultSet.getString("id")+"' class='modal fade confirm-delete' tabindex='-1' role='dialog' aria-hidden='true'>  ";
                                
                                
                        actText += " <div class='modal-dialog modal-lg'>  ";
                        actText += "  <div class='modal-content'>  ";

                        actText += "    <div class='modal-header'>  ";
                        actText += "      <button type='button' class='close' data-dismiss='modal'><span aria-hidden='true'>×</span>  ";
                        actText += "      </button>  ";
                        actText += "      <h4 class='modal-title'>Confirmation</h4>  ";
                        actText += "    </div>  ";
                        actText += "    <div class='modal-body'>  ";
                        actText += "      <h4></h4>  ";
                        actText += "      <p>Are You Sure want to delete that record? </p>  ";
                        actText += "      <p class='info-id'> Delete Name: "+resultSet.getString("role_name")+"</p>  ";
                        actText += "    </div>  ";
                        actText += "    <div class='modal-footer'>  ";
                        actText += "      <button type='button' class='btn btn-default' data-dismiss='modal'>Cancel</button>  ";
                        actText += "      <button id='delete_"+resultSet.getString("id")+"'  type='button' class='btn btn-danger btn-ok' data-dismiss='modal' >Delete</button>  ";
                        actText += "    </div>  ";

                        actText += "  </div>  ";
                        actText += " </div>  ";
                        actText += " </div>  ";
                        actText += "<script> ";

                        actText += " $('#edit_"+resultSet.getString("id")+"').click(function() { ";
                       
                        actText += " $.ajax({  ";
                        actText += "    type: 'POST', ";
                        actText += "    url: 'module/roles/roles_list_modify.jsp', ";
                        actText += "    data: {id:"+resultSet.getString("id")+",action:2}, ";
                        actText += "    cache:false, ";
                        actText += "    success: function(d) { ";
                        actText += "      $('#maincontent').empty(); ";
                        actText += "      $('#maincontent').html(d); ";
                        actText += "      $('#maincontent').show(); ";
                        actText += "    },   ";
                        actText += "    complete: function(){ ";
                        actText += "      ";
                        actText += "    }});   ";
                        actText += "  ";
                        
                        actText += "}); ";
                        
                        actText += " ";
            
                        actText += " $('#delete_"+resultSet.getString("id")+"').click(function() { ";
                          actText += " $('#confirm-delete_"+resultSet.getString("id")+"').modal('hide'); ";
                        actText += " $.ajax({  ";
                        actText += "    type: 'POST', ";
                        actText += "    url: 'module/roles/roles_list_modify_recstat_del.jsp', ";
                        actText += "    data: {id:"+resultSet.getString("id")+"}, ";
                        actText += "    cache:false, ";
                        actText += "    success: function(d) { ";
                        actText += "      ";
                        actText += "    new PNotify({title: 'Action Status',text: 'Data "+resultSet.getString("role_name")+" "+resultSet.getString("role_name")+" has been deleted.. ',type: 'success',styling: 'bootstrap3'});  ";
                        actText += "    ";
                        actText += " }, ";
                        actText += " complete: function(){ ";
                        actText += "  ";
                        actText += "  ";
                        actText += "  $('#rowid_"+resultSet.getString("id")+"').closest('tr').hide();  ";
                        actText += " }});   ";
                        actText += " return false; ";
                        actText += "}); ";
                        actText += " ";
                        actText += "</script> ";
                        
                        //actText = "aaa";
                        rowidText = "rowid_"+resultSet.getString("id");
                        
                        fieldColumnObj.add("DT_RowId",new JsonPrimitive(rowidText));
                        fieldColumnObj.add("action",new JsonPrimitive(actText));
                        fieldColumnObj.add("role_code",new JsonPrimitive(((resultSet.getString("role_code") == null) ? "N/A" : resultSet.getString("role_code"))));
                        fieldColumnObj.add("role_name",new JsonPrimitive(((resultSet.getString("role_name") == null) ? "N/A" : resultSet.getString("role_name"))));
                        fieldColumnObj.add("role_description",new JsonPrimitive(((resultSet.getString("role_description") == null) ? "N/A" : resultSet.getString("role_description"))));
                        fieldColumnObj.add("hierarchy_flag",new JsonPrimitive(((resultSet.getString("hierarchy_flag") == null) ? "N/A" : resultSet.getString("hierarchy_flag"))));
                        fieldColumnObj.add("role_level",new JsonPrimitive(((resultSet.getString("role_level") == null) ? "N/A" : resultSet.getString("role_level"))));

                        
                        
                        recordsArrayData.add(fieldColumnObj);
                        row++;
                        //if(row >= displaystart && row <= (displaystart + displaylength)) {
                       //}
                        }
              
                    returnObj.add("draw", new JsonPrimitive(draw));
                    returnObj.add("recordsTotal", new JsonPrimitive(totalRecords));
                    returnObj.add("recordsFiltered", new JsonPrimitive(totalRecords));
                    returnObj.add("data", recordsArrayData);
                    
                    out.print(returnObj.toString());
                    out.flush();
        
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
                 