
import Database.Database;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import javax.naming.InitialContext;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;
import javax.sql.DataSource;

/**
*
* @author Semi
*/
@MultipartConfig(fileSizeThreshold=1024*1024*2,
maxFileSize=1024*1024*10,
maxRequestSize=1024*1024*50)


 public class UploadServlet_Prod extends HttpServlet {
    
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
    
  private String message;
 
  public void init() throws ServletException
  {
      // Do required initialization
      message = "Hello World";
            
  }
  

protected void processRequest(HttpServletRequest request, HttpServletResponse response)
throws ServletException, IOException {
response.setContentType("text/html;charset=UTF-8");
try (PrintWriter out1 = response.getWriter()) {
HttpSession session=request.getSession();
//String name=request.getParameter("unname");
Part filePart = request.getPart("filecover");
String path_dev = "";
String path_prod = "";

try {
            Database db = new Database();
            ResultSet resultSet = null;
            String sql;
           
            
                        
                        try {
//                            Database db = new Database();
                            db.connect(1);
                            
                            // Total Leads
                            sql = "select value from t_param where name = 'UPLOAD_LOC_DEV'";
                            resultSet = db.executeQuery(sql);
                            while (resultSet.next()) {
                                path_dev = resultSet.getString("value");
                            }
                            
                            
                            sql = "select value from t_param where name = 'UPLOAD_LOC_PROD'";
                            resultSet = db.executeQuery(sql);
                            while (resultSet.next()) {
                                path_prod = resultSet.getString("value");
                            }


String path_prods="";
//String path="D:/Adhoc_Muamalat_Briefcase/Upload_Form/uploadtest";


//File file=new File(path_dev);
File file=new File(path_prods);
path_prods = "D:\\Task Kantor\\REMINDER APP.csv"; 
file.mkdir();
String fileName = getFileName(filePart);


String v_userID = (String)session.getAttribute("session_userid");
String id="0";
id = request.getParameter("id");
//
String v_month = request.getParameter("p_month");
String v_main_rpt = request.getParameter("p_main"); 
String v_laporan = request.getParameter("p_name");
String v_sub_rpt = request.getParameter("p_sub");
String v_institusi = request.getParameter("p_institusi");
String tag = "laporan_"+v_month+"_"+v_sub_rpt+"_";
        
OutputStream out = null;

InputStream filecontent = null;

PrintWriter writer = response.getWriter();
try {
//out = new FileOutputStream(new File(path_dev + File.separator
out = new FileOutputStream(new File(path_prod + File.separator
//out = new FileOutputStream(new File(getServletContext().getRealPath("/") + path_prod + File.separator
+ fileName));

filecontent = filePart.getInputStream();


int read = 0;
final byte[] bytes = new byte[1024];

while ((read = filecontent.read(bytes)) != -1) {
out.write(bytes, 0, read);

//FileData = path_dev+"/"+fileName;
//FileData = path_dev+"/"+tag+fileName;

//FileData = path_prod+"/"+fileName;

//FileData = path_prod+"/"+tag+fileName;

}

        try {

            db.connect(1);
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
//                    + " '"+path_dev+"',"
                    + " '"+path_prod+"',"
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
    } catch (Exception except) {
        System.out.println("<div class=sql>" + except.getMessage() + "</div>");
    }

} catch(Exception e){}
                        
} catch(Exception e){}

//out1.println ("<html><body><script>alert('Sucessfully Saved! Check the database and the path!');</script></body></html>");
}
}
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