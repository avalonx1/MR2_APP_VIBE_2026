<%@include file="../includes/check_auth_layer3.jsp"%>
<%

    String userID = v_userID;
    String username = v_userName;
    String actionCode = request.getParameter("actionCode");
    String actionDesc = "";
    String formName="Record";
    String tableName="t_upload";
    String seqTableName=tableName+"_seq";
    
    
    String id="0";
    
    if (actionCode.equals("EDT")){
    id = request.getParameter("id");
    }

    String v_month = request.getParameter("p_month");
    String v_main_rpt = request.getParameter("p_main"); 
    String v_laporan = request.getParameter("p_name"); 
    String v_sub_rpt = request.getParameter("p_sub");
    String v_date = request.getParameter("p_date");
//    String v_upload_path=request.getParameter("upload_path");

    
    
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
                    + " id, month_sid, main_rpt_id, nama_laporan, sub_rpt_id, upload_path, "
                    + " MAKER_USERID,MAKER_DT_STAMP,MAKER_TAG,CHECKER_USERID, "
                    + " CHECKER_DT_STAMP,AUTH_STAT,LAST_MODIFIED_DT_STAMP,RECORD_STAT,upload_date) "
                    + " values ( "
                    + " nextval('"+seqTableName+"'),"
                    + ""+v_month+","
                    + "'"+v_main_rpt+"',"
                    + "'"+v_laporan+"', "
                    + "'"+v_sub_rpt+"', "
                    + "'STILL WORKING', "
                    + " "+v_userID+", "
                    + " CURRENT_TIMESTAMP, "
                    + " 'APPLICATION', "
                    + " "+v_userID+", "
                    + " CURRENT_TIMESTAMP,"
                    + " 'A',CURRENT_TIMESTAMP,'O', '"+v_date+"'"    
                    + " )";
                    
                actionDesc="Add";
                
                 db.executeUpdate(sql);
                 System.out.println(sql);
                 System.out.println("v_date = "+v_date);

               }
               
               else {
                   out.println("<div class=alert>" + errorMessage + "</div>");

//                 sql = "update "+tableName+" SET "
//                    +"field_name='"+field_name+"',"
//                    +"code='"+lov_code+"', "
//                    +"name='"+lov_name+"', "
//                    +"ordernum='"+lov_ordernum+"',"
//                    +"LAST_MODIFIED_DT_STAMP=CURRENT_TIMESTAMP "     
//                    +" where id="+id;
//                 
//                 actionDesc="Edit";
                   
//                  db.executeUpdate(sql);
               }
               
               
                   //debug mode            
                                if (v_debugMode.equals("Y")) {
//                                out.println(sql);
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


