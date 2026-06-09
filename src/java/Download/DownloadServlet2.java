/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Download;

/**
 *
 * @author 20160038
 */
import java.io.DataInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.Servlet;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class DownloadServlet2 extends HttpServlet implements Servlet {

    static final long serialVersionUID = 1L;
    private static final int BUFSIZE = 4096;
    private String filePath;

    @Override
    public void init() {
        // the file index.jsp is under web application folder
        filePath = getServletContext().getRealPath("") + File.separator + "index.jsp";
        //need to get files from "D:\\uploads";
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String file_loc = request.getParameter("file_loc");
        File file = new File(file_loc);
        int length = 0;
        ServletOutputStream outStream = response.getOutputStream();
        ServletContext context = getServletConfig().getServletContext();
        String mimetype = context.getMimeType(file_loc);

        // sets response content type
        if (mimetype == null) {
            mimetype = "application/octet-stream";
        }
        response.setContentType(mimetype);
        response.setContentLength((int) file.length());
        String fileName = (new File(file_loc)).getName();

        // sets HTTP header
        response.setHeader("Content-Disposition", "attachment; filename=\"" + fileName + "\"");

        byte[] byteBuffer = new byte[BUFSIZE];
        DataInputStream in = new DataInputStream(new FileInputStream(file));

        // reads the file's bytes and writes them to the response stream
        while ((in != null) && ((length = in.read(byteBuffer)) != -1)) {
            outStream.write(byteBuffer, 0, length);
        }

        in.close();
        outStream.close();
    }
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        try {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet DownloadServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet DownloadServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        } finally {
            out.close();
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">   

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}