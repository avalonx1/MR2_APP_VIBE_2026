import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.sql.SQLException;
import java.util.Iterator;
import java.util.List;
import Database.Database;
import java.io.File;
import java.io.PrintWriter;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;



public class Download_File extends HttpServlet {

	
//	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
//			throws ServletException, IOException {
//		super.doGet(req, resp);
//		prosesRequest(req, resp);
//	}
	
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    try {
//        String filename = (String) request.getAttribute("fileName");
        String file_loc = request.getParameter("p_path");
        String file_name = request.getParameter("p_file");
        //InputStream file_name = request.getPart("p_file").getInputStream();
        String FileData = file_loc +"/"+ file_name;
        response.setContentType("application/octet-stream");
        response.setHeader("Content-Disposition",
                "attachment;filename="+file_name);

        File file = new File(FileData);
        FileInputStream fileIn = new FileInputStream(file);
        ServletOutputStream out = response.getOutputStream();

        byte[] outputByte = new byte[(int)file.length()];
        //copy binary contect to output stream
        while(fileIn.read(outputByte, 0, (int)file.length()) != -1)
            {
            out.write(outputByte, 0, (int)file.length());
            }
        } catch (Exception ex) {
        }
    }
}
        
        
       

