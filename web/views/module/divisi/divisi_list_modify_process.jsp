<%@include file="../../../includes/check_auth_layer3.jsp"%>
<%

    String userID = v_userID;
    String username = v_userName;
    String actionCode = request.getParameter("actionCode");
    String actionDesc = "";
    String formName="Record";
    String tableName="t_divisi";
    String seqTableName=tableName+"_seq";
    
    String id="0";
    
    if (actionCode.equals("EDT")){
    id = request.getParameter("id");
    }
    
    String v_nama_divisi=request.getParameter("p_nama_divisi");
    String v_id_divisi=request.getParameter("p_id_divisi");

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
                    +"id, divisi, div_id,"
                    +"MAKER_USERID, MAKER_DT_STAMP, MAKER_TAG, CHECKER_USERID, "
                    +"CHECKER_DT_STAMP, AUTH_STAT, LAST_MODIFIED_DT_STAMP, RECORD_STAT  ) "
                    +"values ( "
                    + "nextval('"+seqTableName+"'),"
                    + "'"+v_nama_divisi+"',"
                    + "'"+v_id_divisi+"',"
                    + " 1, "
                    + " CURRENT_TIMESTAMP, "
                    + " 'APPLICATION', "
                    + " 1,"
                    + " CURRENT_TIMESTAMP,"
                    + " 'A',CURRENT_TIMESTAMP,'O') ";

                actionDesc="Add";
                System.out.println("Insert = "+sql);
                db.executeUpdate(sql);                
                 
               }else {
                   
                 sql = " update "+tableName+" SET"
                     +" divisi='"+v_nama_divisi+"',"
                     +" div_id='"+v_id_divisi+"',"
                         + "MAKER_USERID = 1, "
                    + " MAKER_DT_STAMP = CURRENT_TIMESTAMP, "
                    + " MAKER_TAG = 'APPLICATION', "
                    + " CHECKER_USERID = 1,"
                    + " CHECKER_DT_STAMP = CURRENT_TIMESTAMP, AUTH_STAT = 'A', LAST_MODIFIED_DT_STAMP = CURRENT_TIMESTAMP, RECORD_STAT = 'O'"
//                    + " ,"
//                    + " 'A',CURRENT_TIMESTAMP,'O') ";
                     +" where id="+id;

                actionDesc="Edit";
                System.out.println("Update = "+sql);
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


