<%@include file="../../../includes/check_auth_layer3.jsp"%>
<%  
              
    String id = request.getParameter("id");
    String tableUser="t_user";
    String tableMatrix="t_user_matrix";
    String sql;
    
        try {
            ResultSet resultSet = null;
            Database db = new Database();
            try {
                db.connect(1);
                 
                sql = "delete from "+tableUser+" where ID = "+id;
                
                //debug mode            
                        if (v_debugMode.equals("1")) {
                       System.out.println(sql);
                        }
                
                db.executeUpdate(sql);
                
                sql = "delete from "+tableMatrix+" where userid ="+id;
                
                
                //debug mode            
                        if (v_debugMode.equals("1")) {
                       System.out.println(sql);
                        }
                        
                db.executeUpdate(sql);
                out.print("OK");
                    
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