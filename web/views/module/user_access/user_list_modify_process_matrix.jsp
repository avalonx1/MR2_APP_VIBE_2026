
<%@include file="../../../includes/check_auth_layer3.jsp"%>
<%

    String userID = v_userID;
    String username = v_userName;
    String actionCode = request.getParameter("actionCode");
    String actionDesc = "";
    String formName="Record";
    String tableName="t_user_matrix";
    String seqTableName=tableName+"_seq";
    String dates = "0";
    
    String id="0";
    
    if (actionCode.equals("EDT")){
    id = request.getParameter("id");
    }
    
    String v_rolem_user = request.getParameter("p_role_user_matrix");
    String v_groupm_user = request.getParameter("p_group_user_matrix");
    
    //VALIDATION
    boolean validate = true;
    String errorMessage = "";
    

    if (validate) {
        try {
            ResultSet resultSet=null;
            Database db = new Database();
            try {
                db.connect(1);
                String sql;
                
               if (actionCode.equals("ADD")) {
                sql = "insert into "+tableName+" ("
                + " id, userid, group_id, role_id, "
                + " MAKER_USERID, MAKER_DT_STAMP, MAKER_TAG, CHECKER_USERID, "
                + " CHECKER_DT_STAMP, AUTH_STAT, LAST_MODIFIED_DT_STAMP, RECORD_STAT ) "
                + " values ( "
                + " nextval('"+seqTableName+"'),"        
                + " " + v_userID + ", "
                + " " + v_groupm_user + ","
                + " " + v_rolem_user + ","
                + " " + v_userID + ", "
                + " CURRENT_TIMESTAMP, "
                + " 'APPLICATION', "
                + " "+v_userID+", "
                + " CURRENT_TIMESTAMP,"
                + " 'A',CURRENT_TIMESTAMP,'O' "
                + " )";
                    
                
                
                actionDesc="Add";

                db.executeUpdate(sql);
                out.println(sql);
                  
                out.println(v_userID);
                out.println(v_groupm_user);
                out.println(v_rolem_user);
                 
               }else {

                 sql = "update "+tableName+" SET "
                    +"group_id= " +v_groupm_user+ ","
                    +"role_id= " +v_rolem_user+ ","
                    +"LAST_MODIFIED_DT_STAMP=CURRENT_TIMESTAMP "     
                    +"where id="+id;
                 
                 actionDesc="Edit";
                   
                 db.executeUpdate(sql);
                 out.println(sql);
               }
               
               
               //debug mode            
                        if (v_debugMode.equals("1")) {
                        out.println("<div class=sql>"+sql+"</div>");
                        }
                        out.println("OK");
//                     System.out.println(sql);

                //out.println("<div class=info>"+actionDesc+" "+formName+" Success<br></div>");
                     
                   
                 
            } catch (SQLException Sqlex) {
                out.println("<div class=sql>" + Sqlex.getMessage() + "</div>");
            } finally {
                db.close();
                if (resultSet != null) resultSet.close(); 
            }
        } catch (Exception except) {
            out.println("<div class=sql>" + except.getMessage() + "</div>");
        }
        
        
    } else {
        out.println("<div class=alert>" + errorMessage + "</div>");
    }

%>


