/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 *
 * @author 20160038
 */

    
import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.OutputStream;
 
import com.jcraft.jsch.Channel;
import com.jcraft.jsch.ChannelSftp;
import com.jcraft.jsch.JSch;
import com.jcraft.jsch.Session;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
 
/**
* @author kodehelp
*
*/


public class Download1 extends HttpServlet {
 
    
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
    
    
String SFTPHOST = "10.55.108.49";
int    SFTPPORT = 22;
String SFTPUSER = "glassfish";
String SFTPPASS = "glassfish123";
String SFTPWORKINGDIR = "/opt/glassfish/RPTRACK/docs";
String file_loc = request.getParameter("p_path");
String file_name = request.getParameter("p_file");
System.out.println("file_name = "+file_name);
String FileData = file_loc +"/"+ file_name;
//String SFTPHOST = "10.20.30.40";
//int    SFTPPORT = 22;
//String SFTPUSER = "username";
//String SFTPPASS = "password";
//String SFTPWORKINGDIR = "/export/home/kodehelp/";
 
Session     session     = null;
Channel     channel     = null;
ChannelSftp channelSftp = null;
 
try{
JSch jsch = new JSch();
session = jsch.getSession(SFTPUSER,SFTPHOST,SFTPPORT);
session.setPassword(SFTPPASS);
java.util.Properties config = new java.util.Properties();
config.put("StrictHostKeyChecking", "no");
session.setConfig(config);
session.connect();
channel = session.openChannel("sftp");
channel.connect();
channelSftp = (ChannelSftp)channel;
channelSftp.cd(SFTPWORKINGDIR);
byte[] buffer = new byte[1024];
//BufferedInputStream bis = new BufferedInputStream(channelSftp.get("data transaksi setoran kliring.xlsx"));
BufferedInputStream bis = new BufferedInputStream(channelSftp.get(file_name));
File newFile = new File("C:\\Users\\20160038\\Downloads\\"+file_name);
OutputStream os = new FileOutputStream(newFile);
BufferedOutputStream bos = new BufferedOutputStream(os);
int readCount;
//System.out.println("Getting: " + theLine);
while( (readCount = bis.read(buffer)) > 0) {
System.out.println("Writing: " );
bos.write(buffer, 0, readCount);
}

Boolean success = true;

     if(success){
      System.out.println("Success!" );
//                                                    new PNotify({title: '<%=actionText%> Data',text: 'SUCCESS: Data has been saved..',type: 'success',styling: 'bootstrap3'});
//                                                } else {
//                                                    new PNotify({title: '<%=actionText%> Data',text: 'ERROR: Data Not Saved',type: 'error',styling: 'bootstrap3'});
//                                                } // The file has been DELETED succesfully
     }
 
//     channel.disconnect();
//     session.disconnect();
     
bis.close();
bos.close();



}catch(Exception ex){
ex.printStackTrace();
}


PrintWriter out = response.getWriter();  
response.setContentType("text/html");  
out.println("<script type=\"text/javascript\">");  
out.println("alert('Horee!! go cek ke Folder Download');");  
out.println("</script>");
response.sendRedirect("views/upload_list.jsp");
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
