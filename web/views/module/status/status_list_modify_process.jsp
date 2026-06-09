<%@include file="../../../includes/check_auth_layer3.jsp"%>
<%

    String userID = v_userID;
    String username = v_userName;
//    String actionCode = request.getParameter("actionCode");
    String actionCode = "ADD";
    String actionDesc = "";
    String formName="Record";
    String tableName="t_status";
    String seqTableName=tableName+"_seq";
    
    
    String id="0";

    
    String v_month = request.getParameter("p_month");
    String v_main_rpt = request.getParameter("p_main"); 
    String v_laporan = request.getParameter("p_name"); 
    String v_sub_rpt = request.getParameter("p_sub");
//    String v_upload_path=request.getParameter("upload_path");

//    String v_month="";
//    String v_rpt_id=""; 
//    String v_laporan=""; 
//    String v_sub_rpt="";
    
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
                
//               if (actionCode.equals("ADD")) {
                sql = "insert into "+tableName+" ("
                    + " id, month_sid, main_rpt_id, nama_laporan, sub_rpt_id, status_check, "
                    + " MAKER_USERID,MAKER_DT_STAMP,MAKER_TAG,CHECKER_USERID, "
                    + " CHECKER_DT_STAMP,AUTH_STAT,LAST_MODIFIED_DT_STAMP,RECORD_STAT) "
                    + " values ( "
                    + " nextval('"+seqTableName+"'),"
                    + " '"+v_month+"',"
                    + " '"+v_main_rpt+"',"
//                        + " '"+v_main_rpt+"',"
                    + " '"+v_laporan+"', "
                    + " '"+v_sub_rpt+"', "
                    + " 'CONFIRMED', "
                    + " "+v_userID+", "
                    + " CURRENT_TIMESTAMP, "
                    + " 'APPLICATION', "
                    + " "+v_userID+", "
                    + " CURRENT_TIMESTAMP,"
                    + " 'A',CURRENT_TIMESTAMP,'O'"   
                    + " )";
                    
                actionDesc="Add";
                
//                db.executeUpdate(sql);
                 resultSet = db.executeUpdate(sql);
                System.out.println(sql);
//               }
               
//               else {
//                   out.println("<div class=alert>" + errorMessage + "</div>");
////                   
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
               
               
                
                   //debug mode            
//                                if (v_debugMode.equals("Y")) {
////                                out.println(sql);
//                                }
                                
                 
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
<!--<h1 id="blank">HELLO THERE</h1>-->


