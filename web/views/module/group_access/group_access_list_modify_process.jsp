<%@include file="../../../includes/check_auth_layer3.jsp"%>
<%

    String userID = v_userID;
    String username = v_userName;
    String actionCode = request.getParameter("actionCode");
    String actionDesc = "";
    String formName="Record";
    String tableName="t_group_access";
    String seqTableName=tableName+"_seq";
    
    
    String id="0";
    
    if (actionCode.equals("EDT")){
    id = request.getParameter("id");
    }

    String v_group_id=request.getParameter("p_group_id");
    String v_member_id=request.getParameter("p_member_id");

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
                
                //out.println("<div class=info>" +cabangGroupID +username+ "</div>");
                
               if (actionCode.equals("ADD")) {
                sql = "insert into "+tableName+" ("
                    + " id, group_id, member_id, "
                    + " MAKER_USERID, MAKER_DT_STAMP, MAKER_TAG, CHECKER_USERID, "
                    + " CHECKER_DT_STAMP, AUTH_STAT, LAST_MODIFIED_DT_STAMP, RECORD_STAT  ) "
                    + " values ( "
                    + "nextval('"+seqTableName+"'),"
                    + " "+v_group_id+" ,"
                    + " "+v_member_id+","
                    + " "+v_userID+", "
                    + " CURRENT_TIMESTAMP, "
                    + " 'APPLICATION', "
                    + " "+v_userID+", "
                    + " CURRENT_TIMESTAMP,"
                    + " 'A',CURRENT_TIMESTAMP,'O' "    
                    + " )";
                    
                actionDesc="Add";
                System.out.println(sql);
                 db.executeUpdate(sql);
                 
                 
               }else {
                   
                sql = " update "+tableName+" SET "
                    +" group_id='"+v_group_id+"',"
                    +" member_id='"+v_member_id+"',"
                    +" LAST_MODIFIED_DT_STAMP=CURRENT_TIMESTAMP "     
                    +" where id="+id;

                 
                 actionDesc="Edit";
                  db.executeUpdate(sql);
               }
               
               //debug mode            
                        if (v_debugMode.equals("1")) {
                        System.out.println(sql);
                        }
                        
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
        
        
    } else {
        out.println("<div class=alert>" + errorMessage + "</div>");
    }

  
%>


