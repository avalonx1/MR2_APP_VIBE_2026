<%-- 
    Document   : opp_list_json_task
    Created on : Sep 2, 2016, 3:00:21 PM
    Author     : Hasemi.Rafsanjani
--%>

<%@include file="../../../includes/check_auth_layer3.jsp"%>
<%
     
        String vName="";
        String vAmount="";
        String vOppval= "2";
        String vTask="";
                    
          try {
            ResultSet resultSet=null;
            Database db = new Database();
            try {   
            
                db.connect(1);
                String sql;
                
                sql = "select name, to_char(amount, 'FMRp 999,999,999,999') as amount from v_opportunity_access_user where stage_code = '03'  and userid = "+v_userID+" order by amount desc limit 5";
//                "SELECT id ID, name FROM t_lov where field_name = 'TASK_TYPE' ORDER BY ID ";
                resultSet = db.executeQuery(sql);
                
                String rowidText="";
                
                int row = 0;
                while (resultSet.next()) {
                        
//                    if (!resultSet.getString("leads_status_code").equals("04") ) {
//                        
//                              
//                        }
                    
                       vName=resultSet.getString("name");
                       vAmount=resultSet.getString("amount");
                       
                       
                       
                    %>
                      
                      <tr>
                          <!--<th scope="row">1</th>-->
                          <td><%=vName%></td>
                          <td><%=vAmount%></td>
                      </tr>
                    
                    
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
<!--" SELECT id, id_owner, subject, description, status, type, priority, calltype, callpurpose, "
                            + " duedate, activity_start, activity_end, activity_duration, id_reff, reff_code, "
                            + " maker_userid, maker_dt_stamp, maker_tag, checker_userid, checker_dt_stamp, auth_stat, last_modified_dt_stamp, record_stat "
                            + " FROM t_task ";-->