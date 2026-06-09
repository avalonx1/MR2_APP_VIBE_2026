
import Database.Database;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

/**
*
* @author Semi
*/
@MultipartConfig(fileSizeThreshold=1024*1024*2, //2MB
maxFileSize=1024*1024*10, //10MB
maxRequestSize=1024*1024*50) //50MB


 public class UploadServlet_view extends HttpServlet {
    
    private String message;
    private String getFileName(final Part part) {
    final String partHeader = part.getHeader("content-disposition");

        for (String content : part.getHeader("content-disposition").split(";")) {
            if (content.trim().startsWith("filename")) {
            return content.substring(
            content.indexOf('=') + 1).trim().replace("\"", "");
            }
        }
        return null;
        }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    response.setContentType("text/html;charset=UTF-8");
    
    
    String v_main= request.getParameter("p_main"); 
    String v_sub= request.getParameter("p_sub");
    String v_name= request.getParameter("p_name");
    String v_month= request.getParameter("p_month");
    String v_institusi = request.getParameter("p_institusi");
//    String v_file_param = request.getParameter("p_file");
//    System.out.println("file part filecover = "+v_file_param);

    OutputStream out = null;
    InputStream filecontent = null; 
    
    
    
    try 
    (PrintWriter out1 = response.getWriter()) {
    HttpSession session=request.getSession();
    //String name=request.getParameter("unname");
    
    
//     Part filePart = request.getPart("filecover");
//    System.out.println("file part filecover = "+filePart);
    
    Part filePart = request.getPart("filecover");
        if (filePart != null) {
            // prints out some information for debugging
            System.out.println(filePart.getName());
            System.out.println(filePart.getSize());
            System.out.println(filePart.getContentType());

            // obtains input stream of the upload file
            filecontent = filePart.getInputStream();
        }

    
    String fileName = getFileName(filePart);
    System.out.println("file-nya fileName = "+fileName);
    

//    filecontent = filePart.getInputStream(); 
//    System.out.println("file content-nya = "+filecontent);
    

    String path_dev = "";
    String path_prod = "";
    String FileData="";
    
    try {
            Database db = new Database();
            ResultSet resultSet = null;
            String sql;
                        try {
                            db.connect(1);
//
//                            sql = "select value from t_param where name = 'UPLOAD_LOC_DEV'";
//                            resultSet = db.executeQuery(sql);
//                            while (resultSet.next()) {
//                                path_dev = resultSet.getString("value");
//                            }
//                            
                            sql = "select value from t_param where name = 'UPLOAD_LOC_PROD'";
                            resultSet = db.executeQuery(sql);
                            
                            while (resultSet.next()) {
                                path_prod = resultSet.getString("value");
                                System.out.println("Path prod db = "+path_prod);
                            }
    
    } catch (Exception except) {
    }
    
    
    
//   #GET FILE

    
//    PrintWriter writer = response.getWriter();
//    
//    try {
//        out = new FileOutputStream(new File(path_prod + File.separator + fileName));
//        } catch (Exception except) {
//          System.out.println("Error throw = "+except.getMessage());
//        } 


//    File file = new File("D:\\Task Kantor\\REMINDER APP.csv");
//    File file = new File("D:/Task Kantor/REMINDER APP.csv");
//        File file = new File(".").getAbsoluteFile();
                        
//      String fileName2 = "D:\\Task Kantor";                        
      String fileName2 = "";  
                            
        File file = new File(fileName2);
//        System.out.println("Path file = "+file);
        
//        file.mkdir();
//        String FileSource = file.getAbsolutePath()+fileName;
//        System.out.println("++File Absoulte path = "+FileSource);
        String FileSource_2 = file.getCanonicalPath()+"\\"+fileName;
        System.out.println("++File Canonical = "+"\\"+FileSource_2);
//        String FileSource_3 = file.getPath()+fileName;
//        System.out.println("++File Get Path = "+FileSource_3);
//    file.mkdir();
//    File file = new file.getAbsolutePath();
//    String f;
//    
//    File file = new File(f);
//    f = file.getAbsolutePath();
//    File file=new File(FileData);
    
    
    System.out.println("file exist = "+file.exists());
    System.out.println("::File Absolute dir Sumber = "+file.getAbsolutePath().toString());
    
    String file_loc = file.getAbsolutePath();
//    String parentDir = file.getParent();
    System.out.println("ParentDir / directory Sumber = "+file_loc);
    
    
    
    
//    ==================END SOURCE======================
 
//    #Target Path
//    FileData = path_prod+"/"+fileName;
//    FileData = path_prod_2;
//    FileData = path_prod_2+fileName;
//    System.out.println("Target Data = "+FileData);
//        FileData = path_dev+"/"+fileName;
//        FileData = path_dev+"/"+tag+fileName;
//        FileData = path_prod+"/"+tag+fileName;

       
//    String Target = "/opt/glassfish/RPTRACK/docs";
//    System.out.println("Target Data = "+Target);
    
    
    byte fileContent[] = new byte[(int) file.length()];
    FileInputStream fin;

        
    try {
        fin = new FileInputStream(fileName2);
        System.out.println("Inputstream file = "+fileName2);
        fin.read(fileContent);
        SFTPutils sftpUtils = new SFTPutils();
        sftpUtils.setHostName("10.55.108.49");
        sftpUtils.setHostPort("22");
        sftpUtils.setUserName("glassfish");
        sftpUtils.setPassWord("glassfish123");
        sftpUtils.setDestinationDir("/opt/glassfish/RPTRACK/docs");
        String result = "";

        result = sftpUtils.uploadFileToFTP(fileName, fin, true);
        System.out.println("Result file upload: " + result);

        } catch (Exception except) {
          System.out.println("Error Catch neh = "+except.getMessage());
        } 

        String v_userID = (String)session.getAttribute("session_userid");
        String id="0";
        id = request.getParameter("id");

        
        String v_main_rpt = request.getParameter("p_main"); 
        String v_laporan = request.getParameter("p_name");
        String v_sub_rpt = request.getParameter("p_sub");

        String tag = "laporan_"+v_month+"_"+v_sub_rpt+"_";

//        try {
//        out = new FileOutputStream(new File(path_dev + File.separator
//        out = new FileOutputStream(new File(path_prod + File.separator + fileName));

//        filecontent = filePart.getInputStream();

        int read = 0;
        final byte[] bytes = new byte[1024];

        while ((read = filecontent.read(bytes)) != -1) {
        out.write(bytes, 0, read);
        }


        try {

            db.connect(7);
            sql = "insert into t_upload(id, month_sid, main_rpt_id, nama_laporan, sub_rpt_id, file_name, upload_path, "
                    + " maker_userid, maker_dt_stamp, maker_tag, checker_userid, checker_dt_stamp, auth_stat, last_modified_dt_stamp, record_stat)"
                    + " values ( "
                    + " nextval('t_upload_seq'),"
                    + " '"+v_month+"',"
                    + " '"+v_main_rpt+"',"
                    + " '"+v_laporan+"',"
                    + " '"+v_sub_rpt+"',"
                    + " '"+fileName+"',"
//                    + " '"+tag+fileName+"',"
                    + " '"+path_dev+"',"
//                    + " '"+path_prod+"',"
                    + " 1, "
                    + " CURRENT_TIMESTAMP, "
                    + " 'APPLICATION', "
                    + " 1,"
                    + " CURRENT_TIMESTAMP,"
                    + " 'A',CURRENT_TIMESTAMP,'O' "
                    + " )";
    
        resultSet = db.executeUpdate(sql);
        System.out.println(sql);
        System.out.println(fileName);


        } catch (SQLException e) {
        System.out.println("Connection Failed! Check output console");
        e.printStackTrace();
        return;
        } 
        
//        } catch (SQLException e) {
//        System.out.println("Connection Failed! Check output console");
//        e.printStackTrace();
//        return;
//        }
    
    

} catch(Exception e){
System.out.println("Error Bro");
}
}
    }
//} catch(Exception e){}


//out1.println ("<html><body><script>alert('Sucessfully Saved! Check the database and the path!');</script></body></html>");

@Override
protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
processRequest(req,resp); 
    String v_main= req.getParameter("p_main"); 
    String v_sub= req.getParameter("p_sub");
    String v_name= req.getParameter("p_name");
    String v_month= req.getParameter("p_month");
    String v_institusi = req.getParameter("p_institusi");
    String v_file = req.getParameter("p_file");
}

@Override
protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
    processRequest(req,resp);
    }
}