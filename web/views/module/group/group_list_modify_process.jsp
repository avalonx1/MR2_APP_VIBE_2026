<%@include file="../../../includes/check_auth_layer3.jsp"%>
<%

    String userID = v_userID;
    String username = v_userName;
    String actionCode = request.getParameter("actionCode");
    String actionDesc = "";
    String formName="Record";
    String tableName="t_group";
    String seqTableName=tableName+"_seq";
    
    
    String id="0";
    
    if (actionCode.equals("EDT")){
    id = request.getParameter("id");
    }
    

    String v_name_group=request.getParameter("p_name_group");
    String v_desc_group=request.getParameter("p_desc_group");
    String v_code_group=request.getParameter("p_code_group");
    String v_type_group=request.getParameter("p_type_group");

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
                    + " id, group_code, group_name, group_description, id_group_type, "
                    + " MAKER_USERID, MAKER_DT_STAMP, MAKER_TAG, CHECKER_USERID, "
                    + " CHECKER_DT_STAMP, AUTH_STAT, LAST_MODIFIED_DT_STAMP, RECORD_STAT  ) "
                    + " values ( "
                    + "nextval('"+seqTableName+"'),"
                    + "'"+v_code_group+"',"
                    + "'"+v_name_group+"',"
                    + "'"+v_desc_group+"',"
                    + " "+v_type_group+","    
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
                   
                sql = " update "+tableName+" SET "
                    +" group_code='"+v_code_group+"',"
                    +" group_name='"+v_name_group+"',"
                    +" group_description='"+v_desc_group+"',"
                    +" id_group_type="+v_type_group+", "
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


