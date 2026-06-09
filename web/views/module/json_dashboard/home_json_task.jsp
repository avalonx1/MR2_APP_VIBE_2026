<%-- 
    Document   : opp_list_json_task
    Created on : Sep 2, 2016, 3:00:21 PM
    Author     : Hasemi.Rafsanjani
--%>

<%@include file="../../../includes/check_auth_layer3.jsp"%>
<%
     
        String vSubject="";
        String vDescription="";
        String vOppval= "2";
        String vTask="";
                    
          try {
            ResultSet resultSet=null;
            Database db = new Database();
            try {   
            
                db.connect(1);
                String sql;
                
                sql = "select subject, description from t_task";
//                "SELECT id ID, name FROM t_lov where field_name = 'TASK_TYPE' ORDER BY ID ";
                resultSet = db.executeQuery(sql);
                
                String rowidText="";
                
                int row = 0;
                while (resultSet.next()) {
                        
//                    if (!resultSet.getString("leads_status_code").equals("04") ) {
//                        
//                            
//                        }
                    
                       vSubject=resultSet.getString("subject");
                       vDescription=resultSet.getString("description");
                       
                       
                       
                    %>
                    
<!--                     <li>
                      <div class="block">
                        <div class="tags">
                          <a href="" class="tag">
                            <span>call</span>
                          </a>
                        </div>
                        <div class="block_content">
                          <h2 class="title">
                                          <p><%=vSubject%></p>
                                      </h2>
                          <div class="byline">
                            20 hours ago by <a> Dhika Rizky </a>
                          </div>
                          <p class="excerpt"><%=vDescription%>
                          </p>
                        </div>
                      </div>
                    </li>
-->

                    
                    <li>
                        <div class="block">
                          <div class="block_content">
                            <h2 class="title">
                                <a> <%=vSubject%> </a>
                                          </h2>
                            <div class="byline">
                              <span>1 hours ago</span> by <a>Sam</a>
                            </div>
                            <p class="excerpt"><%=vDescription%> <a>Read&nbsp;More</a>
                            </p>
                          </div>
                        </div>
                      </li>
                    
                    
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