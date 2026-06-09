<%@include file="../../../includes/check_auth_layer3.jsp"%>
<%

    String userID = v_userID;
    String username = v_userName;
    String actionCode = request.getParameter("actionCode");
    String actionDesc = "";
    String formName="Record";
    String tableName="t_roles";
    String seqTableName=tableName+"_seq";
    
    
    String id="0";
    
    if (actionCode.equals("EDT")){
    id = request.getParameter("id");
    }
    
    String v_name_prod=request.getParameter("p_name_role");
    String v_code_prod=request.getParameter("p_code_role");
    String v_desc_prod=request.getParameter("p_desc_role");
    String v_level_role=request.getParameter("p_level_role");
    String v_hirarchy_flag=request.getParameter("p_hirarchy_flag");
    
            

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
                    +"id,role_name,role_code,role_description,"
                    +"MAKER_USERID, MAKER_DT_STAMP, MAKER_TAG, CHECKER_USERID, "
                    +"CHECKER_DT_STAMP, AUTH_STAT, LAST_MODIFIED_DT_STAMP, RECORD_STAT  ) "
                    +"values ( "
                    + "nextval('"+seqTableName+"'),"
                    + "'"+v_name_prod+"',"
                    + "'"+v_code_prod+"',"
                    + "'"+v_desc_prod+"',"
                    + "'"+v_hirarchy_flag+"',"
                    + " "+v_level_role+","
                    + " "+v_userID+", "
                    + " CURRENT_TIMESTAMP, "
                    + " 'APPLICATION', "
                    + " "+v_userID+", "
                    + " CURRENT_TIMESTAMP,"
                    + " 'A',CURRENT_TIMESTAMP,'O' "    
                    + " )";
                    
                actionDesc="Add";
               
                db.executeUpdate(sql);
                 
                 
               }else {
                   
                 sql = "update "+tableName+" SET "
                    +"role_name='"+v_name_prod+"',"
                    +"role_code='"+v_code_prod+"',"
                    +"role_description='"+v_desc_prod+"', "
                    +"hierarchy_flag='"+v_desc_prod+"', "
                    +"role_level="+v_level_role+", "
                    +"LAST_MODIFIED_DT_STAMP=CURRENT_TIMESTAMP "     
                    +" where id="+id;
                 
                 
                 actionDesc="Edit";
                
                 db.executeUpdate(sql);
               }
               
                   //debug mode            
                        if (v_debugMode.equals("1")) {
                        System.out.println(sql);
                        }
               out.println("OK");
                 
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


