<%@include file="../../../includes/check_auth_layer3.jsp"%>
<%  
              
    String id = request.getParameter("id");
    String recstat=request.getParameter("recstat");
    String recstatname="";
    String tableName="t_account";
    String sql;
    
        try {
            ResultSet resultSet = null;
            Database db = new Database();
            try {
                db.connect(1);
                    
                
                if (recstat.equals("1")) {
                sql = "update "+tableName+" set RECORD_STAT='C',LAST_MODIFIED_DT_STAMP=CURRENT_TIMESTAMP where ID=" + id + " ";
                
                 recstatname="deactivated";

                    
                } else {
                sql = "update "+tableName+" set RECORD_STAT='O',LAST_MODIFIED_DT_STAMP=CURRENT_TIMESTAMP where ID=" + id + " ";
                
                 recstatname="activated";
                 
                }
                
               System.out.println(sql);
                
                //debug mode            
                        if (v_debugMode.equals("1")) {
                        out.println("<div class=sql>"+sql+"</div>");
                        }
                        
                db.executeUpdate(sql);
                out.print("SUCCESS");
                    
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