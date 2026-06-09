/**
 *
 * @author 20160038
 */

import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class download_rpt extends HttpServlet{

  private static final int BYTES_DOWNLOAD = 1024;

  public void doGet(HttpServletRequest request,
   HttpServletResponse response) throws IOException{
        String file_loc = request.getParameter("file_loc");
	response.setContentType("text/plain");
//	response.setHeader("Content-Disposition","attachment;filename= D:/Adhoc_Muamalat_Briefcase/Upload_Form/uploadtest/test_download.doc");
        response.setHeader("Content-Disposition","attachment;filename= " + file_loc);
	ServletContext ctx = getServletContext();
	InputStream is = ctx.getResourceAsStream("/test_download.doc");

	int read=0;
	byte[] bytes = new byte[BYTES_DOWNLOAD];
	OutputStream os = response.getOutputStream();

	while((read = is.read(bytes))!= -1){
		os.write(bytes, 0, read);
	}
	os.flush();
	os.close();
   }
}