<%@include file="../../../includes/check_auth_layer3.jsp"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%

      int displaystart = Integer.parseInt(request.getParameter("start"));
      int displaylength = Integer.parseInt(request.getParameter("length"));
      String search = request.getParameter("search[value]");
      
      int draw =Integer.parseInt(request.getParameter("draw")) ;
      ;

      String id = "";
      int vRole_id= 0;
       int totalRecords =0;

          try {
            ResultSet resultSet=null;
            Database db = new Database();
            try {   
            
                db.connect(1);
                String sql;
                
                sql = " select userid, first_name, role_id, role_name from v_report_list where userid ="+v_userID;

                 resultSet = db.executeQuery(sql);
                  while (resultSet.next()) {
                    vRole_id = resultSet.getInt("role_id");
                }

                 if (vRole_id == 1){
                       sql = " select DISTINCT (sub_rpt_id)as id, divisi, nama_laporan, laporan, status, flag_active from v_report_list where status is null "
                             + " GROUP BY sub_rpt_id, divisi, nama_laporan, laporan, status, flag_active";

//                              + "order by month_sid asc, main_rpt_id asc, sub_rpt_id asc, laporan_detail asc";
                      resultSet = db.executeQuery(sql);
                      System.out.println("SYS ADMIN ROLE = "+sql);
                 }else{
                     sql = "select first_name ,nama_laporan, laporan_detail, institusi, sub_rpt_id, file_name, flag_active, status, file_name from v_user_report where userid="+v_userID+" and status is null ";
                      resultSet = db.executeQuery(sql); 
                      System.out.println("USER ROLE = "+sql);
                 };

                 
                  if (vRole_id == 1){
                      sql = "select count(1) as jml from v_user_report";                
                        resultSet = db.executeQuery(sql);
                       
                        while (resultSet.next()) {
                            totalRecords = resultSet.getInt("jml");
                        }
                  }else{
                sql = "select count(1) as jml from v_user_report where userid = "+v_userID;                
                resultSet = db.executeQuery(sql);
//                        int totalRecords =0;
                        while (resultSet.next()) {
                            totalRecords = resultSet.getInt("jml");
                        }
                };
                 
                 
                System.out.println("v_userID upload list = "+v_userID);
                
                System.out.println("id = "+id);
                
                if(!search.equals("")) {
                   
                    sql += " and lower(laporan) like('%"+search.toLowerCase()+"%') ";
                 }
                
//                sql += " order by 1 ";
                sql += " order by sub_rpt_id, divisi, nama_laporan, laporan, status asc, flag_active asc";
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

                while (resultSet.next()) 

                {                    
                        JsonObject fieldColumnObj = new JsonObject();  
                         
                        rowidText = "rowid_"+resultSet.getString("id");
                        confText = "";
                        if ((resultSet.getInt("flag_active") == 0)) {
                         confText += "<span class='label label-default' >MAIN REPORT  <span class='fa fa-arrow-right'/></span>";
                        } else if ((resultSet.getString("status") == null) || resultSet.getString("status").isEmpty()){
                         confText += "<span class='label label-danger' >BELUM   <span class='fa fa-close'/></span>";
                        } else {
                         confText += "<span class='label label-success' >SUDAH   <span class='fa fa-check'/></span>";
                        };
                        fieldColumnObj.add("DT_RowId",new JsonPrimitive(rowidText));
//                        fieldColumnObj.add("status",new JsonPrimitive(((resultSet.getString("status") == null) ? "BELUM" : resultSet.getString("status"))));
                        fieldColumnObj.add("status",new JsonPrimitive(confText));
                        fieldColumnObj.add("laporan",new JsonPrimitive(((resultSet.getString("laporan") == null) ? "N/A" : resultSet.getString("laporan"))));
                        fieldColumnObj.add("divisi",new JsonPrimitive(((resultSet.getString("divisi") == null) ? "N/A" : resultSet.getString("divisi"))));

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