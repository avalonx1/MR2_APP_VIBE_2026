<%@include file="../includes/check_auth_layer3.jsp"%>
<%--<%@page contentType="text/html" pageEncoding="UTF-8"%>--%>
<%

      int displaystart = Integer.parseInt(request.getParameter("start"));
      int displaylength = Integer.parseInt(request.getParameter("length"));
      String search = request.getParameter("search[value]");
      //int columnIdxOrder = Integer.parseInt(request.getParameter("order[i][column]"));
     // String columnDirOrder = request.getParameter("order[1][dir]");
      
      int draw =Integer.parseInt(request.getParameter("draw")) ;
      
//      int v_flag;
      String id = "";
      
      
//      id  = request.getParameter("id");

          try {
            ResultSet resultSet=null;
            Database db = new Database();
            try {   
            
                db.connect(1);
                String sql;

                sql = "select count(1) as jml from v_user_report_4 where id = "+v_userID;                
//                sql = "select count(1) as jml from v_report where name ='Citra Kurniawati'";
                resultSet = db.executeQuery(sql);
                int totalRecords =0;
                while (resultSet.next()) {
                    totalRecords = resultSet.getInt("jml");
                }

//                      sql= "select id_report AS id, sub_rpt_id, divisi, name, nik, laporan, nama_laporan, periode, detail_p, institusi, month_sid from v_report_list where id_user= "+v_userID; 
//                 sql= "select id_view_user_report as id, flag_active, laporan_detail, divisi, month_sid, status from v_user_report where userid="+v_userID;
                 sql= "select id_view_user_report as id, flag_active, laporan_detail, divisi, month_sid, status, upload_date from v_user_report_4 where id="+v_userID;

//                sql = "select distinct nama_laporan, id, name, month_sid, divisi, periode, institusi from v_report_list where id_user="+v_userID;
                
                System.out.println("v_userID upload list = "+v_userID);
                
                System.out.println("id = "+id);
                
                if(!search.equals("")) {
                    sql += " and lower(laporan_detail) like('%"+search.toLowerCase()+"%') ";
                 }
                
//                sql += " order by 1 ";
                sql += " order by month_sid desc, sub_rpt_id asc, main_rpt_id asc";
                sql += " OFFSET "+displaystart+" LIMIT "+displaylength;
                 resultSet = db.executeQuery(sql);
//                vStatus = resultSet.getString("status");
//                vFlag = resultSet.getInt("flag_active");
                
                System.out.println("sql di upload list = "+sql);
                
                
//                int vFlag;
                System.out.println("v_userID = "+v_userID);

                JsonObject returnObj = new JsonObject();    
                JsonArray recordsArrayData = new JsonArray();

                String actText="";
                String confText="";
                String confText2="";
                String mainText="";
                String rowidText="";
                int vFlag = 0;
                String vStatus = request.getParameter("status");
                String span="<span class='label label-danger' >BELUM   <span class='fa fa-close'/></span>";

                int row = 0;
               
//                int var1 = 50;

                while (resultSet.next()) 

                {                    
                        JsonObject fieldColumnObj = new JsonObject(); 
                        
                        actText = " ";
                        if ((resultSet.getInt("flag_active") == 1)) {
                         actText += "<a  id='view_"+resultSet.getString("id")+"' class='btn btn-primary btn-block btn-xs'><i class='fa fa-eye'></i><b> OPEN DETAIL </b></a>";
                        } else {
                         actText += "<a  class='btn btn-upload btn-block btn-xs' disabled><i class='fa fa-ban' ></i><b> MAIN REPORT </b></a>";
                        };
//                        actText +="<a  id='view_"+resultSet.getString("id")+"' class='btn btn-info btn-xs'><i class='fa fa-eye'></i> Edit </a>";
                        actText += "<script> ";                        

                        actText += " $('#view_"+resultSet.getString("id")+"').click(function() { ";
                        actText += " $.ajax({  ";
                        actText += "    type: 'POST', ";
                        actText += "    url: 'upload_list_modify.jsp', ";
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

                        rowidText = "rowid_"+resultSet.getString("id");

                        confText = " ";
//                        if ((resultSet.getString("status") == null) || resultSet.getString("status").isEmpty()) {
//                         confText += "<span class='label label-danger' >BELUM   <span class='fa fa-close'/></span>";
//                        } else if ((resultSet.getInt("flag_active") == 1)){
//                         confText += "<span class='label label-default' >MAIN REPORT  <span class='fa fa-arrow-right'/></span>";
//                        } else {
//                         confText += "<span class='label label-success' >SUDAH   <span class='fa fa-check'/></span>";
//                        };
                        
                        if ((resultSet.getInt("flag_active") == 0)) {
                         confText += "<span class='label label-default' >MAIN REPORT  <span class='fa fa-arrow-right'/></span>";
                        } else if ((resultSet.getString("status") == null) || resultSet.getString("status").isEmpty()){
                         confText += "<span class='label label-danger' >BELUM   <span class='fa fa-close'/></span>";
                        } else {
                         confText += "<span class='label label-success' >SUDAH   <span class='fa fa-check'/></span>";
                        };
                        
                        
                        
//                        confText = "";
//                        confText += " "+span+" ";
//                        
//                        confText += "<script> ";
//                        confText += " if ("+resultSet.getString("status")+" == null || "+resultSet.getString("status")+".isEmpty()){ ";
//                        confText += " "+span+" = '<span class='label label-danger' >BELUM   <span class='fa fa-close'/></span>';";
//                        confText += "} else if ("+resultSet.getInt("flag_active")+" == 0) {";
//                        confText += " "+span+" = '<span class='label label-default' >MAIN REPORT  <span class='fa fa-arrow-right'/></span>';";
//                        confText += "} else {";
//                        confText += " "+span+"= '<span class='label label-success' >SUDAH   <span class='fa fa-check'/></span>';";
//                        confText += "};";
//                        confText += "</script> ";
//                        
//                        confText2 += "<script> ";
//                        confText2 += " if ("+resultSet.getString("status")+" == 'CONFIRMED'){ ";
//                        confText2 += " "+resultSet.getString("status")+" = 'SUDAH'";
//                        confText2 += "}; ";
//                        confText2 += "</script> ";

                        fieldColumnObj.add("DT_RowId",new JsonPrimitive(rowidText));
                        fieldColumnObj.add("action",new JsonPrimitive(actText));
                        fieldColumnObj.add("status",new JsonPrimitive(confText));
//                        fieldColumnObj.add("status",new JsonPrimitive(((resultSet.getString("status") == null) ? "BELUM" : resultSet.getString("status"))));
                        fieldColumnObj.add("laporan_detail",new JsonPrimitive(((resultSet.getString("laporan_detail") == null) ? "N/A" : resultSet.getString("laporan_detail"))));
//                        fieldColumnObj.add("divisi",new JsonPrimitive(((resultSet.getString("divisi") == null) ? "N/A" : resultSet.getString("divisi"))));
                        fieldColumnObj.add("month_sid",new JsonPrimitive(((resultSet.getString("month_sid") == null) ? "N/A" : resultSet.getString("month_sid"))));
                        fieldColumnObj.add("upload_date",new JsonPrimitive(((resultSet.getString("upload_date") == null) ? "N/A" : resultSet.getString("upload_date"))));
                        
//                        fieldColumnObj.add("status",new JsonPrimitive(confText2));
                                     
//                        fieldColumnObj.add("institusi",new JsonPrimitive(((resultSet.getString("institusi") == null) ? "N/A" : resultSet.getString("institusi"))));
                        recordsArrayData.add(fieldColumnObj);
                        row++;
//                        if (v_flag == 0) {
//                        fieldColumnObj.add("action",new JsonPrimitive(mainText));
//                        }                         
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