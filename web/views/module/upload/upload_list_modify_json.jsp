<%-- 
    Document   : upload_list_modify_json
    Created on : Oct 31, 2016, 9:20:32 AM
    Author     : 20160038
--%>

<%@include file="../includes/check_auth_layer3.jsp"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
        
     
      int displaystart = Integer.parseInt(request.getParameter("start"));
      int displaylength = Integer.parseInt(request.getParameter("length"));
      String search = request.getParameter("search[value]");
      //int columnIdxOrder = Integer.parseInt(request.getParameter("order[i][column]"));
     // String columnDirOrder = request.getParameter("order[1][dir]");
      
      int draw =Integer.parseInt(request.getParameter("draw")) ;
      String id = "";
      id  = request.getParameter("id");
      
        
                    
          try {
            ResultSet resultSet=null;
            Database db = new Database();
            try {   
            
                db.connect(1);
                String sql;
                
//                sql = "select count(1) as jml from v_report";
//                sql = "select count(1) as jml from v_report_list where id_user="+v_userID;
                sql = "select count(1) as jml from v_report_list_2 where id_user="+v_userID;                
//                sql = "select count(1) as jml from v_report where name ='Citra Kurniawati'";
                resultSet = db.executeQuery(sql);
                int totalRecords =0;
                while (resultSet.next()) {
                    totalRecords = resultSet.getInt("jml");
                }
                                
//                sql = "select id, divisi, name, nik, laporan, periode, detail_p, institusi from v_report";
//                sql = "select id, divisi, name, nik, laporan, periode, detail_p, institusi from v_report_list where id_user="+v_userID;
                sql = "select distinct nama_laporan, id, month_sid, divisi, periode, institusi from v_report_list where id_user="+v_userID;
//                System.out.println(sql);
                
                if(!search.equals("")) {
                   
                    sql += " where lower(divisi) like('%"+search.toLowerCase()+"%') ";
                    sql += "or lower(name) like('%"+search.toLowerCase()+"%') ";
                    sql += "or lower(periode) like('%"+search.toLowerCase()+"%') ";
                    sql += "or lower(institusi) like('%"+search.toLowerCase()+"%') ";    
                 }
                
                sql += " order by 1 ";
                sql += " OFFSET "+displaystart+" LIMIT "+displaylength;
                
                System.out.println(sql);
                
                resultSet = db.executeQuery(sql);
                // format returned ResultSet as a JSON array
                JsonObject returnObj = new JsonObject();    
                JsonArray recordsArrayData = new JsonArray();

                String actText="";
                String upload="";
                String confText="";
                String rowidText="";
                
                int row = 0;
                while (resultSet.next()) {
                        JsonObject fieldColumnObj = new JsonObject();  
                                  
              
//                        actText = "<a  id='upload_"+resultSet.getString("id")+"' class='btn btn-primary btn-xs'><i class='fa fa-upload'></i> Upload </a>";
                        actText = "<a  id='view_"+resultSet.getString("id")+"' class='btn btn-info btn-xs'><i class='fa fa-eye'></i> View </a>";
//                        actText = "<a  class='btn btn-danger btn-xs' data-toggle='modal' data-target='#confirm-delete_"+resultSet.getString("id")+"' ><i class='fa fa-trash-o'></i> Delete </a>";

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
                        actText += "      <p class='info-id'> Delete Name: "+resultSet.getString("name")+"</p>  ";
                        actText += "      <p class='info-id'> WARNING!! Opportunity related to this account will be deleted.</p>  ";
                        actText += "    </div>  ";
                        actText += "    <div class='modal-footer'>  ";
                        actText += "      <button type='button' class='btn btn-default' data-dismiss='modal'>Cancel</button>  ";
                        actText += "      <button id='delete_"+resultSet.getString("id")+"'  type='button' class='btn btn-danger btn-ok' data-dismiss='modal' >Delete</button>  ";
                        actText += "    </div>  ";
                        actText += "  </div>  ";
                        actText += " </div>  ";
                        actText += " </div>  ";
                        actText += "<script> ";
                        actText += " $('#view_"+resultSet.getString("id")+"').click(function() { ";
                        actText += " $.ajax({  ";
                        actText += "    type: 'POST', ";
                        actText += "    url: '../upload_list_modify.jsp', ";
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
                        actText += "</script> ";

                        confText = "<input id='#confirm_"+resultSet.getString("id")+"' type='submit' value='Confirm' ></input>";
                        
                        confText += "<script>";
                        confText += "  $(document).ready(function(){";
                        confText += " $('#confirm_"+resultSet.getString("id")+"').click(function() { ";
                        confText += "    $('input:submit').click(function(){";
                        confText += "       $('p').text('Form submiting.....');";
                        confText += "       $('input:submit').attr('disabled', true);})";
                       
                        confText += " $.ajax({  ";
                        confText += "    type: 'POST', ";
                        confText += "    url: 'module/status/status_confirm.jsp', ";
                        confText += "    data: {id:"+resultSet.getString("id")+",action:2}, ";
                        confText += "    cache:false, ";
                        confText += "    success: function(d) { ";
                        confText += "      $('#maincontent').empty(); ";
                        confText += "      $('#maincontent').html(d); ";
                        confText += "      $('#maincontent').show(); ";
                        confText += "    },   ";
                        confText += "    complete: function(){ ";
                        confText += "      ";
                        confText += "    }});   ";
                        confText += "  ";
                        
                        confText += "  }); ";                       
                        confText += "});";


//                        confText += "</script>";

                        confText += "</script>";                            

                        upload = "<form action='module/upload/process.jsp' method='post' enctype='multipart/form-data'>";
                        upload += "<input type='file' name='fname'/>";
                        upload += "<input type='submit' value='Upload'>";
                        upload += "</form>";
                        upload += "<script>";
                        upload += " $('#delete_"+resultSet.getString("id")+"').click(function() { ";
                        
                        upload += " $('#confirm-delete_"+resultSet.getString("id")+"').modal('hide'); ";
                          
                        upload += " $.ajax({  ";
                        upload += "    type: 'POST', ";
                        upload += "    url: 'module/acc/acc_list_modify_recstat_del.jsp', ";
                        upload += "    data: {id:"+resultSet.getString("id")+"}, ";
                        upload += "    cache:false, ";
                        upload += "    success: function(d) { ";
                        upload += "      ";
                        upload += "    new PNotify({title: 'Action Status',text: 'Data "+resultSet.getString("name")+" has been deleted.. ',type: 'success',styling: 'bootstrap3'});  ";
                        upload += "    ";
                        upload += " }, ";
                        upload += " complete: function(){ ";
                        upload += "  ";
                        upload += "  ";
                        upload += "  $('#rowid_"+resultSet.getString("id")+"').closest('tr').hide();  ";
                        upload += " }});   ";
                        upload += " return false; ";
                        upload += "}); ";
                        upload += " ";
                        upload += "</script>";

                        rowidText = "rowid_"+resultSet.getString("id");
                        
                        fieldColumnObj.add("DT_RowId",new JsonPrimitive(rowidText));
                        fieldColumnObj.add("action",new JsonPrimitive(actText));
//                        fieldColumnObj.add("confirm",new JsonPrimitive(confText));
//                        fieldColumnObj.add("upload",new JsonPrimitive(upload));
                        fieldColumnObj.add("month_sid",new JsonPrimitive(((resultSet.getString("month_sid") == null) ? "N/A" : resultSet.getString("month_sid"))));
                        fieldColumnObj.add("divisi",new JsonPrimitive(((resultSet.getString("divisi") == null) ? "N/A" : resultSet.getString("divisi"))));
                        fieldColumnObj.add("nama_laporan",new JsonPrimitive(((resultSet.getString("nama_laporan") == null) ? "N/A" : resultSet.getString("nama_laporan"))));
                        fieldColumnObj.add("periode",new JsonPrimitive(((resultSet.getString("periode") == null) ? "N/A" : resultSet.getString("periode"))));                        
                        fieldColumnObj.add("institusi",new JsonPrimitive(((resultSet.getString("institusi") == null) ? "N/A" : resultSet.getString("institusi"))));
                        
                        
                        recordsArrayData.add(fieldColumnObj);
                        row++;
                        
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
                 
