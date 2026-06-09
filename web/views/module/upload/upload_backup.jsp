<%-- 
    Document   : upload_backup
    Created on : Oct 26, 2016, 2:44:53 PM
    Author     : 20160038
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<form action="UploadServlet_backup" method="post" enctype="multipart/form-data"> <br><br>
<table>
<tr>
<td>UserName: </td>
<td width='10px'></td>
<td><input type="text" name="unname"/></td>
</tr>

<tr>
<td>Upload: </td>
<td width='10px'></td>
<td><input type="file" name="filecover" value="Upload"/></td>
</tr>
<tr>
<td><input type="submit" value="submit"></td>
</tr>
</table>
</form>
