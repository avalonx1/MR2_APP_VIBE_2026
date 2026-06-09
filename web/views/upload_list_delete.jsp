<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@page import="java.io.File"%>
<%@include file="/includes/check_auth_layer3.jsp"%>
<%

//String filepath = request.getParameter("filepath");
//String filename = request.getParameter("filename");
String v_month = request.getParameter("month_rpt"); 
String v_main_rpt = request.getParameter("main_rpt");  
String v_sub_rpt = request.getParameter("sub_rpt"); 

  String file_loc = request.getParameter("file_loc");
  String file_name = request.getParameter("file_name");
//  String tag = "laporan_"+v_month+"_"+v_sub_rpt+"_";

//String FileData = file_loc +"/"+ file_name;
//File f=new File(file_loc+"/"+tag+file_name);
File f=new File(file_loc+"/"+file_name);

String sql;
String sql2;

        try {
                ResultSet resultSet = null;
                Database db = new Database();
                        try {
                            
                            
                            db.connect(1);
                            sql = " delete from t_upload where month_sid = '"+v_month+"' and main_rpt_id = '"+v_main_rpt+"' and sub_rpt_id = '"+v_sub_rpt+"';"
                                    + " delete from t_status where month_sid = '"+v_month+"' and main_rpt_id = '"+v_main_rpt+"' and sub_rpt_id = '"+v_sub_rpt+"' ";
                            System.out.println("Delete ALL = "+sql);
                            resultSet = db.executeQuery(sql);
                            resultSet.close();
                            
                            

//                            db.connect(1);  
//                            sql2 = " delete from t_status where month_sid = '"+v_month+"' and main_rpt_id = '"+v_main_rpt+"' and sub_rpt_id = '"+v_sub_rpt+"'; ";
//                            System.out.println("Delete t_status = "+sql2);
//                            resultSet = db.executeQuery(sql2);
//                            resultSet.close();
                           
//                            String rowstate = "even";

                        } catch (SQLException Sqlex) {
//                            out.println("<div class=sql>" + Sqlex.getMessage() + "</div>");
                        } finally {
                            db.close();
//                                if (resultSet != null) resultSet.close(); 
                        }
                    } catch (Exception except) {
//                        out.println("<div class=sql>" + except.getMessage() + "</div>");
                    }
                    
                    if(f.delete())
                    out.println("Sucessfully deleted file");
                    else
                    out.println("Error in deleting file");


%>





