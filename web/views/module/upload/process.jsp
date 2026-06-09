<%-- 
    Document   : process
    Created on : Oct 7, 2016, 3:48:47 PM
    Author     : 20160038
--%>

<%@page import="com.oreilly.servlet.MultipartRequest" %>

<%

    MultipartRequest m = new MultipartRequest(request, "D:/Adhoc_Muamalat_Briefcase/Upload_Form/uploadtest");

    out.println("Successfully Uploaded..");
    
%> 