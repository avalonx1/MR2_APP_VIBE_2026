<%--<%@ page contentType="text/html;charset=UTF-8" language="java" %>--%>
<%@page import="javax.faces.context.ExternalContext"%>
<%@page import="javax.faces.context.FacesContext"%>
<%@page import="java.io.File"%>
<%@page import="java.io.OutputStream"%>
<%    
  int BUFFER_SIZE = 4096; 
  String file_loc = request.getParameter("p_path"); //PROD
  System.out.println("p_path-nya = "+ file_loc);
  String file_name = request.getParameter("p_file");

//  response.setContentType("APPLICATION/OCTET-STREAM");
  response.setContentType("application/octet-stream");
//  response.setContentType("application/ms-excel");
//  response.setContentType("application/vnd.ms-excel");
  response.setContentType("application/msword");
  response.setContentType("application/xlsx");
  response.setContentType("application/csv");
  response.setContentType("application/docx");
  response.setContentType("application/doc");
//  response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"); 
//  response.setContentType("image/jpeg");
  response.setHeader("Content-Disposition","attachment; filename=\"" +file_name+ "\"");  

  String FileData = file_loc +"/"+ file_name;
    
  ServletContext ctx = getServletContext();
    java.io.FileInputStream fileInputStream = new java.io.FileInputStream(FileData);
    
    
//    java.io.InputStream is = ctx.getResourceAsStream(FileData);
    
    ServletOutputStream out1 = response.getOutputStream();
    
    byte[] buffer = new byte[BUFFER_SIZE];
                int bytesRead = 0;
                 
                while ((bytesRead = fileInputStream.read(buffer)) != -1) {
                    out1.write(buffer, 0, bytesRead);
                }
    
//    byte[] outputByte = new byte[(int)file_name.length()];
//        //copy binary contect to output stream
//        while(fileInputStream.read(outputByte, 0, (int)file_name.length()) != -1)
//        {
//        out.write(outputByte, 0, (int)file_name.length());
//        }
  
  System.out.println("All = "+ FileData);
  System.out.println("this download loc param = "+file_loc);
  System.out.println("and this download file name param = "+file_name);
  
  int i;   
  while ((i=fileInputStream.read()) != -1) {  
//    out.write(i);   
          out1.write(i);   
  }   
  out1.write(i); 
  out1.close(); 
  fileInputStream.close();   
%> 
<!--
import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.OutputStream;
 
import com.jcraft.jsch.Channel;
import com.jcraft.jsch.ChannelSftp;
import com.jcraft.jsch.JSch;
import com.jcraft.jsch.Session;
 
/**
* @author kodehelp
*
*/
public class DownloadFix {
 
/**
*
*/
public DownloadFix() {
// TODO Auto-generated constructor stub
}
 
/**
* @param args
*/
public static void main(String[] args) {
String SFTPHOST = "10.20.30.40";
int    SFTPPORT = 22;
String SFTPUSER = "username";
String SFTPPASS = "password";
String SFTPWORKINGDIR = "/export/home/kodehelp/";
 
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
BufferedInputStream bis = new BufferedInputStream(channelSftp.get("Test.java"));
File newFile = new File("C:/Test.java");
OutputStream os = new FileOutputStream(newFile);
BufferedOutputStream bos = new BufferedOutputStream(os);
int readCount;
//System.out.println("Getting: " + theLine);
while( (readCount = bis.read(buffer)) > 0) {
System.out.println("Writing: " );
bos.write(buffer, 0, readCount);
}
bis.close();
bos.close();
}catch(Exception ex){
ex.printStackTrace();
}
 
}
 
}

-->

