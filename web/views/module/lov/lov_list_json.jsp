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
                
                sql = "select count(1) as jml from t_lov";
                resultSet = db.executeQuery(sql);
                int totalRecords =0;
                while (resultSet.next()) {
                    totalRecords = resultSet.getInt("jml");
                }
                
                sql = "select id,field_name,code,name,description,ordernum,record_stat from v_lov ";
                
                
                if(!search.equals("")) {
                   
                    sql += "where lower(field_name) like('%"+search.toLowerCase()+"%') ";
                    sql += "or lower(code) like('%"+search.toLowerCase()+"%') ";
                    sql += "or lower(name) like('%"+search.toLowerCase()+"%') ";
                 }
                
                
                /*
                 if(request.getParameter("order[i][column]")!=null) {
                    int sortcol = columnIdxOrder;
                    sql += " order by "+sortcol+" ";
                    
                    if(!columnDirOrder.equals(""))
                    sql +=columnDirOrder;
                    
                 }
                        */
                
                //sql += " order by 1 ";
                sql += " OFFSET "+displaystart+" LIMIT "+displaylength;
                
                     //debug mode            
                                if (v_debugMode.equals("Y")) {
                                System.out.println(sql);
                                }
                                
                
                resultSet = db.executeQuery(sql);
                // format returned ResultSet as a JSON array
                JsonObject returnObj = new JsonObject();    
                JsonArray recordsArrayData = new JsonArray();
                
                
                
                String actText="";
                String hiddenScriptText="";
                String rowidText="";
                
                int row = 0;
                while (resultSet.next()) {
                        JsonObject fieldColumnObj = new JsonObject();  
                        
                        
                                     
                                     
              
                        actText = "<a  id='view_"+resultSet.getString("id")+"' class='btn btn-primary btn-xs'><i class='fa fa-folder'></i> View </a>";
                        actText += "<a  id='edit_"+resultSet.getString("id")+"' class='btn btn-info btn-xs'><i class='fa fa-pencil'></i> Edit </a>";
                       
                        actText += "<a  class='btn btn-danger btn-xs' data-toggle='modal' data-target='#confirm-delete_"+resultSet.getString("id")+"' ><i class='fa fa-trash-o'></i> Delete </a>";
                        
                        hiddenScriptText = "<div id='confirm-delete_"+resultSet.getString("id")+"' class='modal fade confirm-delete' tabindex='-1' role='dialog' aria-hidden='true'>  ";
                                
                                
                        hiddenScriptText += " <div class='modal-dialog modal-lg'>  ";
                        hiddenScriptText += "  <div class='modal-content'>  ";

                        hiddenScriptText += "    <div class='modal-header'>  ";
                        hiddenScriptText += "      <button type='button' class='close' data-dismiss='modal'><span aria-hidden='true'>×</span>  ";
                        hiddenScriptText += "      </button>  ";
                        hiddenScriptText += "      <h4 class='modal-title'>Confirmation</h4>  ";
                        hiddenScriptText += "    </div>  ";
                        hiddenScriptText += "    <div class='modal-body'>  ";
                        hiddenScriptText += "      <h4></h4>  ";
                        hiddenScriptText += "      <p>Are You Sure want to delete that record? </p>  ";
                        hiddenScriptText += "      <p class='info-id'> Delete ID : "+resultSet.getString("id")+"</p>  ";
                        hiddenScriptText += "    </div>  ";
                        hiddenScriptText += "    <div class='modal-footer'>  ";
                        hiddenScriptText += "      <button type='button' class='btn btn-default' data-dismiss='modal'>Cancel</button>  ";
                        hiddenScriptText += "      <button id='delete_"+resultSet.getString("id")+"'  type='button' class='btn btn-danger btn-ok' data-dismiss='modal' >Delete</button>  ";
                        hiddenScriptText += "    </div>  ";

                        hiddenScriptText += "  </div>  ";
                        hiddenScriptText += " </div>  ";
                        hiddenScriptText += " </div>  ";
                        
                        
                        hiddenScriptText += "<script> ";
                        
                        
                        
                        hiddenScriptText += " $('#edit_"+resultSet.getString("id")+"').click(function() { ";
                       
                         
                        hiddenScriptText += " $.ajax({  ";
                        hiddenScriptText += "    type: 'POST', ";
                        hiddenScriptText += "    url: 'module/lov/lov_list_modify.jsp', ";
                        hiddenScriptText += "    data: {id:"+resultSet.getString("id")+",action:2}, ";
                        hiddenScriptText += "    cache:false, ";
                        hiddenScriptText += "    success: function(d) { ";
                        hiddenScriptText += "      $('#maincontent').empty(); ";
                        hiddenScriptText += "      $('#maincontent').html(d); ";
                        hiddenScriptText += "      $('#maincontent').show(); ";
                        hiddenScriptText += "    },   ";
                        hiddenScriptText += "    complete: function(){ ";
                        hiddenScriptText += "      ";
                        hiddenScriptText += "    }});   ";
                        hiddenScriptText += "  ";
                        
                        hiddenScriptText += "}); ";
                        
                        hiddenScriptText += " ";
                        
                        
                        
                        hiddenScriptText += " $('#delete_"+resultSet.getString("id")+"').click(function() { ";
                        hiddenScriptText += " $('#confirm-delete_"+resultSet.getString("id")+"').modal('hide'); ";

                        hiddenScriptText += " $.ajax({  ";
                        hiddenScriptText += "    type: 'POST', ";
                        hiddenScriptText += "    url: 'module/lov/lov_list_modify_recstat_del.jsp', ";
                        hiddenScriptText += "    data: {id:"+resultSet.getString("id")+"}, ";
                        hiddenScriptText += "    cache:false, ";
                        hiddenScriptText += "    success: function(d) { ";
                        hiddenScriptText += "      ";
                        
                        hiddenScriptText += "    ";
                        hiddenScriptText += " }, ";
                        hiddenScriptText += " complete: function(){ ";
                        hiddenScriptText += "  ";
                        hiddenScriptText += "  ";
                        hiddenScriptText += "  $('#rowid_"+resultSet.getString("id")+"').closest('tr').hide();  ";
                        hiddenScriptText += "    new PNotify({title: 'Action Status',text: 'Data "+resultSet.getString("field_name")+" "+resultSet.getString("name")+" has been deleted.. ',type: 'success',styling: 'bootstrap3'});  ";
                        hiddenScriptText += " }});   ";
                        hiddenScriptText += " return false; ";
                        hiddenScriptText += "}); ";
                        
                        hiddenScriptText += " ";
                        hiddenScriptText += "</script> ";
                        
                        actText += hiddenScriptText;
                       
                        
                        //actText = "aaa";
                        rowidText = "rowid_"+resultSet.getString("id");
                        
                        fieldColumnObj.add("DT_RowId",new JsonPrimitive(rowidText));
                        fieldColumnObj.add("action",new JsonPrimitive(actText));
                        
                        
                        fieldColumnObj.add("field_name",new JsonPrimitive(((resultSet.getString("field_name") == null) ? "N/A" : resultSet.getString("field_name"))));
                        fieldColumnObj.add("code",new JsonPrimitive(((resultSet.getString("code") == null) ? "N/A" : resultSet.getString("code"))));
                        fieldColumnObj.add("name",new JsonPrimitive(((resultSet.getString("name") == null) ? "N/A" : resultSet.getString("name"))));
                        fieldColumnObj.add("description",new JsonPrimitive( ((resultSet.getString("description") == null) ? "N/A" : resultSet.getString("description")) ));
                        fieldColumnObj.add("record_stat",new JsonPrimitive(resultSet.getString("record_stat")));
                        
                        
                        
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
                 