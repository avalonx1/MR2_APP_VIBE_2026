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
                
                sql = "select name, to_char(amount, 'FMRp 999,999,999,999') as amount from v_opportunity_access_user where stage_code = '00'  and userid = "+v_userID+" order by amount desc limit 5";
                resultSet = db.executeQuery(sql);
                
                
                String rowidText="";
                
                int row = 0;
                while (resultSet.next()) {
                    
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
