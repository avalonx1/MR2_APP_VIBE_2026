<%@include file="../../../includes/check_auth_layer3.jsp"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
        
     
//      int displaystart = Integer.parseInt(request.getParameter("start"));
//      int displaylength = Integer.parseInt(request.getParameter("length"));
//      String search = request.getParameter("search[value]");
        String tableName="t_status";
        String seqTableName=tableName+"_seq";
      //int columnIdxOrder = Integer.parseInt(request.getParameter("order[i][column]"));
     // String columnDirOrder = request.getParameter("order[1][dir]");
      
//      int draw =Integer.parseInt(request.getParameter("draw")) ;
        
        try {
            ResultSet resultSet=null;
            Database db = new Database();
            try {   
            
                db.connect(1);
                String sql;
                
                sql = "insert into t_status (id, month_sid, main_rpt_id, nama_laporan, sub_rpt_id, upload_path, "
                        + "maker_userid, maker_dt_stamp, maker_tag, checker_userid, checker_dt_stamp, auth_stat, last_modified_dt_stamp, record_stat)"
                        + " values ( "
                        + " nextval('"+seqTableName+"'),"
                        + " null,"
                        + " null,"
                        + " null,"
                        + " 'null',"
                        + " null,"
                        + " 'null',"
                        + " CURRENT_TIMESTAMP, "
                        + " 'APPLICATION', "
                        + " "+v_userID+", "
                        + " CURRENT_TIMESTAMP,"
                        + " 'A',CURRENT_TIMESTAMP,'O' "    
                        + " )";
                
                
                resultSet = db.executeQuery(sql);
                int totalRecords =0;
                while (resultSet.next()) {
                    totalRecords = resultSet.getInt("jml");
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


%>
