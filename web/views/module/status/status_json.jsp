<%@include file="../../../includes/check_auth_layer3.jsp"%>
<%

    String userID = v_userID;
    String username = v_userName;
    String actionCode = request.getParameter("actionCode");
    String actionDesc = "";
//    String formName="Record";
    String tableName="t_status_check";
    String seqTableName=tableName+"_seq";
    
    
    String id="0";
    
    if (actionCode.equals("EDT")){
    id = request.getParameter("id");
    }
    
  
    
    boolean validate = true;
    String errorMessage = "";
    
    if (validate) {
        try {
            ResultSet resultSet=null;
            Database db = new Database();
            
            
            
            try {
                db.connect(1);
                String sql;
                
//                sql = "select count(1) as jml from t_status_check";
//                resultSet = db.executeQuery(sql);
//                int totalRecords = 0;
//                while (resultSet.next()) {
//                    totalRecords = resultSet.getInt("jml");
//                    };
                
                
               if (actionCode.equals("ADD")) {
                sql = "insert into "+tableName+" ("
                    + " id, month_sid, main_rpt_id, nama_laporan, sub_rpt_id, maker_userid, maker_dt_stamp, maker_tag, checker_userid, checker_dt_stamp, "
                    + " auth_stat, last_modified_dt_stamp, record_stat, status_check)"
                    + " values ( "
                    + " nextval('"+seqTableName+"'),"
                    
                    + " null, null, null,"
    
                        
                    + " "+v_userID+", "
                    + " CURRENT_TIMESTAMP, "
                    + " 'APPLICATION', "
                    + " "+v_userID+", "
                    + " CURRENT_TIMESTAMP,"
                    + " 'A',CURRENT_TIMESTAMP,'O',"
                    + " 'Confirm' "    
                    + " )";
                    
                actionDesc="Add";
                
              
                 
               db.executeUpdate(sql);
               
              
                 out.println("OK");
                 
                 
               }else {

                 sql = "update "+tableName+" SET "
                     +" id = null, "
                     + "month_sid = 'null',"
                     + "main_rpt_id = 'null' ,"
                     + "nama_laporan = 'null', "
                     + "sub_rpt_id = null,"
                     + "status_check = 'Confirm'"

                     +"LAST_MODIFIED_DT_STAMP=CURRENT_TIMESTAMP "     
                     +" where id="+id;
                 
                 actionDesc="Edit";
                   
                 db.executeUpdate(sql);
               out.println("OK");
               }
               
               //debug mode            
                        if (v_debugMode.equals("1")) {
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



<!--
public static void UpdateIsData(int eid)  
{  
    if (eid != null)  
    {  
        try  
        {  
            string data = string.Empty;  
            var con = new SqlConnection(Constr);  
            // Chenge Staus For check  
            var q = "Select status from ReportData Where id='" + eid + "'";  
            var command = new SqlCommand(q, con);  
            con.Open();  
            SqlDataReader readData = command.ExecuteReader();  
            while (readData.Read())  
            {  
                data = readData["status"].ToString();  
                con.Close();  
                if (data == "False")  
                {  
                    using (var con2 = new SqlConnection(Constr))  
                    {  
                        var query = "update ReportData set Status='True' where id='" + eid + "'";  
                        con2.Open();  
                        var cmd = new SqlCommand(query, con2);  
                        cmd.ExecuteNonQuery();  
                        con2.Close();  
                    }  
                }  
                else  
                {  
                    using (var con1 = new SqlConnection(Constr))  
                    {  
                        var query = "update ReportData set Status='False' where id='" + eid + "'";  
                        con1.Open();  
                        var cmd = new SqlCommand(query, con1);  
                        cmd.ExecuteNonQuery();  
                        con1.Close();  
                    }  
                }  
            }  
        }  
        catch (Exception)  
        {  
        }  
    }  
}  
-->

