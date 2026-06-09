
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
//import java.sql.Connection;
//import java.sql.DriverManager;
//import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import Database.*;
//import Engines.*;
import java.sql.ResultSet;
import java.sql.SQLException;
//import javax.servlet.annotation.WebServlet;

/**
*
* @author Semi
*/
@MultipartConfig(fileSizeThreshold=1024*1024*2,
maxFileSize=1024*1024*10,
maxRequestSize=1024*1024*50)



public class UploadServlet extends HttpServlet {
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
protected void processRequest(HttpServletRequest request, HttpServletResponse response)
throws ServletException, IOException {
response.setContentType("text/html;charset=UTF-8");
try (PrintWriter out1 = response.getWriter()) {
HttpSession session=request.getSession();
String name=request.getParameter("fname");
Part filePart = request.getPart("filecover");


String photo="";
String path="D:\\Adhoc_Muamalat_Briefcase\\Upload_Form\\uploadtest";

File file=new File(path);
file.mkdir();
String fileName = getFileName(filePart);

OutputStream out = null;

InputStream filecontent = null;

PrintWriter writer = response.getWriter();
try {
out = new FileOutputStream(new File(path + File.separator
+ fileName));

filecontent = filePart.getInputStream();

int read = 0;
final byte[] bytes = new byte[1024];
while ((read = filecontent.read(bytes)) != -1) {
out.write(bytes, 0, read);

photo=path+"/"+fileName;

}

try {
            ResultSet resultSet=null;
            Database db = new Database();
            db.connect(1);
            String sql;
            sql = "insert into t_upload(id, month_sid, main_rpt_id, nama_laporan, sub_rpt_id, upload_path, "
                    + " maker_userid, maker_dt_stamp, maker_tag, checker_userid, checker_dt_stamp, auth_stat, last_modified_dt_stamp, record_stat)"
                    + " values ( "
                    + " nextval('t_upload_seq'),"
                    + " 'null',"
                    + " 'null',"
                    + " 'null',"
                    + " 'null',"
                    + " '"+photo+"',"
                    + " 1, "
                    + " CURRENT_TIMESTAMP, "
                    + " 'APPLICATION', "
                    + " 1, "
                    + " CURRENT_TIMESTAMP,"
                    + " 'A',CURRENT_TIMESTAMP,'O' "
                    + " )";
//    resultSet = db.executeQuery(sql);
    resultSet = db.executeUpdate(sql);
    int totalRecords =0;
    while (resultSet.next()) {
        totalRecords = resultSet.getInt("jml");
    }
}  catch (SQLException e) {

System.out.println("Connection Failed! Check output console");
e.printStackTrace();
return;

} 


}
catch(Exception e)
{

}
out1.println("<html><body><script>alert('Sucessfully Saved! Check the database and the path!');</script></body></html>");
//out.println("OK");
}
response.sendRedirect("views/upload_list.jsp");
}
@Override
protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
processRequest(req,resp);
}

@Override
protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
processRequest(req,resp);
}
}

