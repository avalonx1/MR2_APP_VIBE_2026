<!--<meta content="text/html;charset=utf-8" http-equiv="Content-Type">-->
<!--<meta content="utf-8" http-equiv="encoding">-->
<meta charset="US-ASCII">
<form action="/UploadServlet2" method="post" enctype="multipart/form-data">
<%--<%@ page contentType="text/html;charset=UTF-8" language="java" %>--%> 
 <br><br>
<table>
      <tr>
                 <td>UserName:  </td>
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