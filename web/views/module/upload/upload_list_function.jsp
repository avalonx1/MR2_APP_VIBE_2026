<%@ page language="java" import="Engines.*,Database.*,java.util.*,java.util.regex.*, java.sql.*,java.sql.*,javax.naming.*,javax.sql.*,java.math.*, java.lang.String,java.io.*,javax.servlet.*,java.text.*"%>
<%
    
      String v_clientIP = request.getRemoteAddr();
      String v_userID = (String) session.getAttribute("session_userid");
    
    
        String id="0";
        id = request.getParameter("id");
        //
        String v_month = request.getParameter("p_month");
        String v_main_rpt = request.getParameter("p_main"); 
        String v_laporan = request.getParameter("p_name");
        String v_sub_rpt = request.getParameter("p_sub");
        
//        String fileName = getFileName(filePart);
        
      
      String v_fileUploadDir="D:/Adhoc_Muamalat_Briefcase/Upload_Form/uploadtest";
      double v_maxsizeUploadMB = 2; 
      auth au = new auth(v_clientIP);
        
//          try {
        
         //   v_fileUploadDir=au.getParamValue("DIR_FILE_UPLOAD");
         //   v_maxsizeUploadMB = Double.parseDouble(au.getParamValue("MAXSIZE_UPLOAD_MB")); 
         // } catch (SQLException Sqlex) {
         // out.println("<div class=sql>" + Sqlex.getMessage() + "</div>");
         // } finally {
         // au.close();
         // } 

         //mulai upload
           String saveFile = new String();
            String contentType = request.getContentType();
            
            if ( (contentType !=null ) &&  (contentType.indexOf("multipart/form-data") >=0 )){
            DataInputStream in = new DataInputStream(request.getInputStream());
            
             int formDataLength = request.getContentLength();
            boolean reachMaxFilesize = false;
            
            if ((formDataLength/1024/1024)>v_maxsizeUploadMB) {
                    reachMaxFilesize = true;
                    
                    %>
                                <script type="text/javascript">
                                    alert("File too large.. Maximum Size Allowed : <%=v_maxsizeUploadMB%> MB, Your File Size : <%=Math.round(formDataLength/1024/1024)%> MB");
                                    window.close();
                                </script>
                     <%
                    
                } else {
            
            byte dataBytes[] = new byte[formDataLength];
            int byteRead = 0;
            int totalBytesRead = 0;
            
            while (totalBytesRead < formDataLength ) {
                byteRead = in.read(dataBytes, totalBytesRead, formDataLength);
                totalBytesRead += byteRead;
                
            }
             
            String file = new String(dataBytes,"CP1256");
            String contentSearch = new String(dataBytes,"CP1256");
            String contentValue = new String();
            String fileExt = new String();
            String filenameonly = new String();
            
            saveFile = file.substring(file.indexOf("filename=\"") + 10 );
            saveFile = saveFile.substring(0,saveFile.indexOf("\n"));
            saveFile = saveFile.substring(saveFile.indexOf("\\") + 1 , saveFile.indexOf("\""));
            saveFile = saveFile.replace(" ", "_");

            fileExt = saveFile.substring(saveFile.indexOf(".")+1);
            filenameonly = saveFile.substring(1,saveFile.length()-fileExt.length()-1);

            boolean filenotExist = false;
            
            if (saveFile.length()>0) {
                filenotExist = true;
            }
            
            double bytes = saveFile.length();
            double kilobytes = (bytes / 1024);
            double megabytes = (kilobytes / 1024);
            
            String saveFileOri = saveFile;
            String tag_code = "lap_remainder_";

            if (filenotExist) {
             //insert to db doc map
                
            
            boolean checkFileFormat = true;

                 if (checkFileFormat && !reachMaxFilesize) {

                                          
                    contentValue = contentSearch.substring(contentSearch.indexOf("form-data; name=\"id\"") + 21);
                    contentValue = contentValue.substring(0,contentValue.indexOf("-")-1);
                    contentValue = contentValue.trim();
                    int idact = Integer.parseInt(contentValue);

                saveFile = tag_code+"_"+idact+"_"+saveFile;
                    
                boolean checkFileBefore = false;
                
                                            
                if (!checkFileBefore) {
                
                            int lastiIndex = contentType.lastIndexOf("=");

                            String boundary = contentType.substring(lastiIndex +1, contentType.length());

                            int pos;

                            pos = file.indexOf("filename=\"");
                            pos = file.indexOf("\n",pos) + 1;
                            pos = file.indexOf("\n",pos) + 1;
                            pos = file.indexOf("\n",pos) + 1;

                            int boundaryLocation = file.indexOf(boundary,pos) - 4;

                            int startPos = ((file.substring(0,pos)).getBytes("CP1256")).length;
                            int endPos = ((file.substring(0,boundaryLocation)).getBytes("CP1256")).length;

                            String saveFileFull = v_fileUploadDir+"/"+ saveFile;

                            File ff = new File(saveFileFull);

                            try {

                                FileOutputStream fileOut = new FileOutputStream(ff);
                                fileOut.write(dataBytes, startPos,(endPos - startPos));
                                fileOut.flush();
                                fileOut.close();

                            } catch(Exception e) {
                                out.println(e);
                            }
                                                         
                        if (ff.exists()) {

                                %>
                                <script type="text/javascript">
                                    alert("Upload Success..");
                                    window.close();
                                </script>
                                <%
                                }else {
                                
                                %>
                                <script type="text/javascript">
                                    alert("Upload Failed..");
                                    window.close();
                                </script>
                                <%
                                }//end upload file

                                }
                                 else {

                                     //Upload File 
                        int lastiIndex = contentType.lastIndexOf("=");
                        String boundary = contentType.substring(lastiIndex +1, contentType.length());
                        int pos;

                        pos = file.indexOf("filename=\"");
                        pos = file.indexOf("\n",pos) + 1;
                        pos = file.indexOf("\n",pos) + 1;
                        pos = file.indexOf("\n",pos) + 1;

                        int boundaryLocation = file.indexOf(boundary,pos) - 4;

                        int startPos = ((file.substring(0,pos)).getBytes("CP1256")).length;
                        int endPos = ((file.substring(0,boundaryLocation)).getBytes("CP1256")).length;

                        String SaveFileFull = v_fileUploadDir+"/"+ saveFile;
                        
                        File ff = new File(SaveFileFull);

                        try {

                            FileOutputStream fileOut = new FileOutputStream(ff);
                            fileOut.write(dataBytes, startPos,(endPos - startPos));
                            fileOut.flush();
                            fileOut.close();


                        } catch(Exception e) {
                            out.println(e);
                        }
                        
                                %>
                                <script type="text/javascript">
                                    alert("File <%=saveFileOri%> Overwritten..");
                                    window.close();
                                </script>
                                <%
                               

                    }
                } else {
                                %>
                                <script type="text/javascript">
//                                    
                                    window.close();
                                </script>
                                <%
                    }//end checkFileFormat

                
//                } catch (SQLException Sqlex) {
//                out.println("<div class=sql>" + Sqlex.getMessage() + "</div>");
//            } finally {
//                db.close();
//                if (resultSet != null) resultSet.close(); 
//            }
//            } catch (Exception except) {
//            out.println("<div class=sql>" + except.getMessage() + "</div>");
//            }
             
                 
        try {

            ResultSet resultSet=null;
            Database db = new Database();
//            Statement stmt=db.createStatement();
            db.connect(1);
            String sql;
            sql = "insert into t_upload(id, month_sid, main_rpt_id, nama_laporan, sub_rpt_id, upload_path, "
                    + " maker_userid, maker_dt_stamp, maker_tag, checker_userid, checker_dt_stamp, auth_stat, last_modified_dt_stamp, record_stat)"
                    + " values ( "
                    + " nextval('t_upload_seq'),"
                    + " '"+v_month+"',"
                    + " '"+v_main_rpt+"',"
                    + " '"+v_laporan+"',"
                    + " '"+v_sub_rpt+"',"
                    + " '"+filename+"',"
                    + " 1, "
                    
                    
//                    + " nextval('t_upload_seq'),"
//                    + " 'null',"
//                    + " 'null',"
//                    + " '"+name+"',"
//                    + " 'null',"
//                    + " '"+filename+"',"
//                    + " 1, "
                    
                    
//                    + " nextval('t_upload_seq'),"
//                    + " 'null',"
//                    + " 'null',"
//                    + " 'null',"
//                    + " 'null',"
//                    + " '"+fileName+"',"
//                    + " 1, "
                    
                    
                    + " CURRENT_TIMESTAMP, "
                    + " 'APPLICATION', "
                    + " 1,"
                    + " CURRENT_TIMESTAMP,"
                    + " 'A',CURRENT_TIMESTAMP,'O' "
                    + " )";
            
            
//            + " nextval('t_upload_seq'),"
//                    + " 'null',"
//                    + " 'null',"
//                    + " '"+name+"',"
//                    + " 'null',"
//                    + " '"+photo+"',"
//                    + " 1, "
            
            
//            resultStmt = con.createStatement();

//rs = resultStmt.executeQuery(SQLStatement);
    resultSet = db.executeUpdate(sql);
//    resultSet = db.executeUpdate(sql);
    System.out.println(sql);
    
  
    } catch (SQLException e) {

    System.out.println("Connection Failed! Check output console");
    e.printStackTrace();
    return;

    }
                 
            }
        }
    }
            
%>