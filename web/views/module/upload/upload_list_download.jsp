<%--<%@ page contentType="text/html;charset=UTF-8" language="java" %>--%>

<%@page import="java.io.File"%>
<%@page import="javax.servlet.ServletOutputStream"%>
<%    
  
  String file_loc = request.getParameter("p_path");
  System.out.println("p_path-nya = "+ file_loc);
  String file_name = request.getParameter("p_file");
  
  
  
//  response.setContentType("APPLICATION/OCTET-STREAM"); 
  response.setContentType("application/octet-stream");
  response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"); 
  response.setContentType("image/jpeg");
  response.setHeader("content-disposition","attachment; filename=\"" +file_name+ "\"");  
  String FileData = file_loc +"/"+ file_name;
  
  
//  java.io.FileInputStream fileInputStream=new java.io.FileInputStream(file_loc +"/"+ file_name);  
//  java.io.FileInputStream fileInputStream = new java.io.FileInputStream(FileData);
    java.io.FileInputStream fileInputStream = new java.io.FileInputStream(new File(FileData));
//  java.io.FileOutputStream fos = new java.io.FileOutputStream(FileData);
  
  System.out.println("All = "+ FileData);
  System.out.println("this download loc param = "+file_loc);
  System.out.println("and this download file name param = "+file_name);
  
  
//  ServletOutputStream out = response.getOutputStream();
  
  int i = 0;   
  while ((i=fileInputStream.read()) != -1) {   
   
  }   
  out.write(i); 
  out.flush();
  out.close();

  fileInputStream.close();   
//  fileInputStream.flush();
  
%> 





