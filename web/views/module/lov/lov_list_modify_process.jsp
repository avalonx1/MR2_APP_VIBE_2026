<%@include file="../../../includes/check_auth_layer3.jsp"%>
<%

    String userID = v_userID;
    String username = v_userName;
    String actionCode = request.getParameter("actionCode");
    String actionDesc = "";
    String formName="Record";
    String tableName="t_lov";
    String seqTableName=tableName+"_seq";
    
    
    String id="0";
    
    if (actionCode.equals("EDT")){
    id = request.getParameter("id");
    }
    
    String field_name=request.getParameter("field_name");
    String lov_code=request.getParameter("lov_code");
    String lov_name=request.getParameter("lov_name");
    String lov_ordernum=request.getParameter("lov_ordernum");
   

    
    
    //VALIDATION
    boolean validate = true;
    String errorMessage = "";
    
    
    if (field_name.equals("")){
    field_name="NULL";
    validate = false;
    errorMessage += "- Field field_name tidak boleh null <br>";
    }
    
    if (lov_code.equals("")){
    lov_code="NULL";
    validate = false;
    errorMessage += "- Field lov_code tidak boleh null <br>";
    }
    
    
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
                    +"id, field_name,code,name,ordernum,"
                    +"MAKER_USERID,MAKER_DT_STAMP,MAKER_TAG,CHECKER_USERID, "
                    +"CHECKER_DT_STAMP,AUTH_STAT,LAST_MODIFIED_DT_STAMP,RECORD_STAT  ) "
                    +"values ( "
                    + "nextval('"+seqTableName+"'),"
                    + "'"+field_name+"',"
                    + "'"+lov_code+"',"
                    + "'"+lov_name+"', "
                    + "'"+lov_ordernum+"', "
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
                    +"field_name='"+field_name+"',"
                    +"code='"+lov_code+"', "
                    +"name='"+lov_name+"', "
                    +"ordernum='"+lov_ordernum+"',"
                    +"LAST_MODIFIED_DT_STAMP=CURRENT_TIMESTAMP "     
                    +" where id="+id;
                 
                 actionDesc="Edit";
                   
                  db.executeUpdate(sql);
               }
               
               
                   //debug mode            
                                if (v_debugMode.equals("Y")) {
                                System.out.println(sql);
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
        
        
    } else {
        out.println("<div class=alert>" + errorMessage + "</div>");
    }

  
%>


