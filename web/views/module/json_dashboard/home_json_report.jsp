<%-- 
    Document   : upload_json_report
    Created on : Sep 2, 2016, 3:00:21 PM
    Author     : Hasemi.Rafsanjani
--%>
<%--<%@include file="../../../includes/javascript.jsp"%>--%>
<%@include file="../../../includes/check_auth_layer3.jsp"%>
<%
     
        String vLaporan="";
        String vInstitusi="";
        String vStatus="";
        String vLaporanID="";
        String vFile="";
        String vOppval= "2";
        int vFlag;
                    
          try {
            ResultSet resultSet=null;
            Database db = new Database();
            try {   
            
                db.connect(1);
                String sql;
                
//                sql = "select name, to_char(amount, 'FMRp 999,999,999,999') as amount from v_opportunity_access_user where stage_code = '01'  and userid = "+v_userID+" order by amount desc limit 5";
//                sql ="select status, laporan, institusi from v_report_list where id_user="+v_userID+" limit 5";
//                sql ="select status, sub_rpt_id, nama_laporan, laporan, institusi, file_name, flag_active  from v_report_list where id_user="+v_userID+" "
//                        + " order by month_sid asc, main_rpt_id asc, sub_rpt_id asc limit 10";
                        
                sql = "select first_name ,nama_laporan, laporan_detail, institusi, sub_rpt_id, file_name, flag_active, status, file_name from v_user_report where userid="+v_userID+" "
                        + "order by month_sid asc, main_rpt_id asc, sub_rpt_id asc, laporan_detail asc";
                
                resultSet = db.executeQuery(sql);
                
                System.out.println(sql);
                
                String rowidText="";
                
                int row = 0;
                while (resultSet.next()) {
                        
//                    if (!resultSet.getString("leads_status_code").equals("04") ) {
  
//                        }
                    
                    vLaporanID=resultSet.getString("sub_rpt_id");   
                    vFile=resultSet.getString("file_name");
                    vStatus=resultSet.getString("status");
                    vLaporan=resultSet.getString("laporan_detail");
                    vInstitusi=resultSet.getString("institusi");
                    vFlag=resultSet.getInt("flag_active");
                       
                     if  (vStatus == null || vStatus.isEmpty()){
                     vStatus = "<span class='label label-danger' >BELUM   <span class='fa fa-close'/></span>";
                     } else if (vFlag == 0) {
                     vStatus = "<span class='label label-default' >MAIN REPORT  <span class='fa fa-arrow-right'/></span>";
                     } else {
                     vStatus = "<span class='label label-success' >SUDAH   <span class='fa fa-check'/></span>";   
                     };
                     System.out.println("tag = "+vStatus);
                     
                     if  (vFile == null || vStatus.isEmpty()){
                     vFile = " - ";
                     };
//                     else {
//                     vFile = "<span class='label label-success'>Sudah</span>";
//                     };
                     System.out.println("tag = "+vFile);
                       
                    %>
                
                    

                      <tr>
                          <!--<th scope="row">1</th>-->
                          <!--<td id="Status"><span  class='fa fa-close red'> <%=vStatus%></span></td>-->
                          <td align="center"><%=vStatus%></td>
                          <!--<td id="Status"></td>-->
                          <td><%=vLaporan%></td>
                           <!--<td><%=vLaporanID%></td>-->
                          <td><%=vInstitusi%></td>
                          <!--<td><%=vFile%></td>-->
                      </tr>

                      
<!--<script>
 var validate = '<%=vStatus%>';
           if (validate === 'CONFIRMED') {
            document.getElementById('Status').innerHTML = "<span  class='fa fa-check green'> <%=vStatus%></span>";
        }
        else if (validate === 'ZERO'){
            document.getElementById('Status').innerHTML = "<span  class='fa fa-remove red'> <%=vStatus%></span>";
        }; 
    
</script>-->
                    
                    <%
                
                        row++;
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
