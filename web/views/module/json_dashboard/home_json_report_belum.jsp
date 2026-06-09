<%-- 
    Document   : upload_json_report
    Created on : Sep 2, 2016, 3:00:21 PM
    Author     : Hasemi.Rafsanjani
--%>
<%@include file="../../../includes/check_auth_layer3.jsp"%>
<%
     
        String vLaporan="";
        String vInstitusi="";
        String vStatus="";
        String vLaporanID="";
        String vFile="";
        String vOppval= "2";
        String vMonth="";
        int vFlag = 0;
        int vRole_id= 0;
        int totalRecords = 0;
        String sql = "";
        String vRoles = request.getParameter("vRoles");
                    
          try {
            ResultSet resultSet = null;
            Database db = new Database();

            try {   
            
                db.connect(1);
               
                
                if (vRoles == "01"){
                
                sql = "select count(1) as jml from v_user_report_4";
                resultSet = db.executeQuery(sql);
                totalRecords = 0;
                while (resultSet.next()) {
                    totalRecords = resultSet.getInt("jml");
                }
                
                sql = "select month_sid, first_name ,nama_laporan, laporan_detail, institusi, sub_rpt_id, file_name, flag_active, status, file_name from v_user_report_4 where month_sid = (select max(month_sid) from v_user_report_4) and status is null "
                        + "order by month_sid desc, main_rpt_id asc, sub_rpt_id asc, laporan_detail asc";
                
                resultSet = db.executeQuery(sql);

                } else {
                    
                sql = "select count(1) as jml from v_user_report_4 where id = "+v_userID;                
                resultSet = db.executeQuery(sql);
                totalRecords = 0;
                while (resultSet.next()) {
                    totalRecords = resultSet.getInt("jml");
                }
                sql = "select month_sid, first_name ,nama_laporan, laporan_detail, institusi, sub_rpt_id, file_name, flag_active, status, file_name from v_user_report_4 where month_sid = (select max(month_sid) from v_user_report_4) and id="+v_userID+" and status is null "
                        + "order by month_sid desc, main_rpt_id asc, sub_rpt_id asc, laporan_detail asc";
                
                resultSet = db.executeQuery(sql);
                
                };
                
                String rowidText="";
                
                int row = 0;
                while (resultSet.next()) {
                        
                    
                    vLaporanID=resultSet.getString("sub_rpt_id");   
                    vFile=resultSet.getString("file_name");
                    vStatus=resultSet.getString("status");
                    vLaporan=resultSet.getString("laporan_detail");
                    vInstitusi=resultSet.getString("institusi");
                    vFlag=resultSet.getInt("flag_active");
                    vMonth=resultSet.getString("month_sid");
                    
  
                     if  (vFlag == 0) {
                     vStatus = "<span class='label label-default' >MAIN REPORT  <span class='fa fa-arrow-right'/></span>";
                     } else  if  (vStatus == null || vStatus.isEmpty()){
                    vStatus = "<span class='label label-danger' >BELUM   <span class='fa fa-close'/></span>";
                      } else {
                     vStatus = "<span class='label label-success' >SUDAH   <span class='fa fa-check'/></span>";   
                     };
                     
//                     if (totalRecords <= 1)
//                     { 
//                       resultSet.close();
//                     };
                     
                     System.out.println("vFlag = "+vFlag);
                     System.out.println("tag = "+vFile);
                     
                     if  (vFile == null || vStatus.isEmpty()){
                     vFile = " - ";
                     };

                     
                    
                       
                    %>
                
                    

                      <tr>
                          <!--<td id="Status"><span  class='fa fa-close red'> <%=vStatus%></span></td>-->
                          <td align="center"><%=vStatus%></td>
                          <!--<td id="Status"></td>-->
                          <td><%=vLaporan%></td>
                           <!--<td><%=vLaporanID%></td>-->
                          <td><%=vInstitusi%></td>
                          <!--<td><%=vFile%></td>-->
                          <td><%=vMonth%></td>
                      </tr>
                    
                    <%
                
                        row++;
                        }
               System.out.println("variable vRoles = "+vRoles);
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