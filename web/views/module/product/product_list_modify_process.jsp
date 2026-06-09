<%@include file="../../../includes/check_auth_layer3.jsp"%>
<%

    String userID = v_userID;
    String username = v_userName;
    String actionCode = request.getParameter("actionCode");
    String actionDesc = "";
    String formName="Record";
    String tableName="t_product";
    String seqTableName=tableName+"_seq";
    
    
    String id="0";
    
    if (actionCode.equals("EDT")){
    id = request.getParameter("id");
    }
    
    String v_name_prod=request.getParameter("p_name_prod");
    String v_code_prod=request.getParameter("p_code_prod");
    String v_desc_prod=request.getParameter("p_desc_prod");

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
                    +"id,name,code,description,"
                    +"MAKER_USERID, MAKER_DT_STAMP, MAKER_TAG, CHECKER_USERID, "
                    +"CHECKER_DT_STAMP, AUTH_STAT, LAST_MODIFIED_DT_STAMP, RECORD_STAT  ) "
                    +"values ( "
                    + "nextval('"+seqTableName+"'),"
                    + "'"+v_name_prod+"',"
                    + "'"+v_code_prod+"',"
                    + "'"+v_desc_prod+"',"
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
                   
                 sql = "update "+tableName+" SET "
                    +"name='"+v_name_prod+"',"
                    +"code='"+v_code_prod+"',"
                    +"description='"+v_desc_prod+"', "
                    +"LAST_MODIFIED_DT_STAMP=CURRENT_TIMESTAMP "     
                    +" where id="+id;
                 
                 
//                     sql = "update "+tableName+" SET "
//                    + "id_lead_status=7,"
//                    + "id_lead_source="+v_lead_source+","
//                    + "LAST_MODIFIED_DT_STAMP=CURRENT_TIMESTAMP "     
//                    + "where id="+id;
                 
                 
                 actionDesc="Edit";
//                   System.out.println(sql);
                  db.executeUpdate(sql);
               }
               
               System.out.println(sql);
               //debug mode            
                        if (v_debugMode.equals("1")) {
                        System.out.println(sql);
                        }
                        
               System.out.println(sql);
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


