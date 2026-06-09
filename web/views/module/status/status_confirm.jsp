<%@include file="../../../includes/check_auth_layer3.jsp"%>
<%                
    String id = request.getParameter("id");
    String tableName="t_status";
    String sql;
    
        try {
            ResultSet resultSet = null;
            Database db = new Database();
            try {
                db.connect(1);
                 
//                sql = "delete from "+tableName+" where ID=" + id + " ";
                sql = "update "+tableName+" set status_check= 'CHECKED' where ID= "+ id +" ";
                
                //debug mode            
                if (v_debugMode.equals("1")) {
                out.println("<div class=sql>"+sql+"</div>");
                }
                
                db.executeUpdate(sql);
                out.println(sql);
                 
//                sql = "delete from t_opportunity where id_account="+id+" ";
                
                //debug mode            
                if (v_debugMode.equals("1")) {
                out.println("<div class=sql>"+sql+"</div>");
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