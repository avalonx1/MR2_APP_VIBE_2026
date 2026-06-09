import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.sql.SQLException;
import java.util.Iterator;
import java.util.List;
import Database.Database;
import java.io.PrintWriter;
import java.sql.ResultSet;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUpload;
import org.omg.PortableInterceptor.ForwardRequest;

public class Upload_File extends HttpServlet {

	
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		super.doGet(req, resp);
		prosesRequest(req, resp);
	}
	
	protected void prosesRequest(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
            
             try {
//             (PrintWriter out1 = resp.getWriter()) {
             HttpSession session = req.getSession();
             
            String v_userID = (String)session.getAttribute("session_userid");
            String v_month= req.getParameter("p_month") == null ? "" : req.getParameter("p_month");
            System.out.println("v_month ="+v_month);
            String v_main_rpt = req.getParameter("p_main") == null ? "" : req.getParameter("p_main");
            System.out.println("v_main_rpt = "+v_main_rpt);
            String v_laporan = req.getParameter("p_name") == null ? "" : req.getParameter("p_name");
            System.out.println("v_laporan = "+v_laporan);
            String v_sub_rpt = req.getParameter("p_sub") == null ? "" : req.getParameter("p_sub");
            System.out.println("v_sub_rpt = "+v_sub_rpt);
            String v_nik_upload = req.getParameter("p_nik") == null ? "" : req.getParameter("p_nik");
            System.out.println("v_nik_upload = "+v_nik_upload);
            String v_date = req.getParameter("p_date") == null ? "" : req.getParameter("p_date");
            System.out.println("v_date = "+v_date);

        
            String nameFile = req.getParameter("filecover") == null ? "" : req.getParameter("filecover");
            String strFileName = req.getParameter("strFileName") == null ? "" : req.getParameter("strFileName");
            String status = "";
//            String path = "D:\\shareds";
//            String path = "/opt/glassfish/RPTRACK/docs";
            String path = "D:/MR2_2022/MR2_data/folder_uat_mr2";

		boolean isMultipart = FileUpload.isMultipartContent(req);
		if (!isMultipart){
		} else {
			try {
				DiskFileItemFactory factory = new DiskFileItemFactory();
				ServletFileUpload upload = new ServletFileUpload(factory);
				List items = upload.parseRequest(req);
				Iterator itr = items.iterator();
				while (itr.hasNext()) {
					FileItem xitem = (FileItem) itr.next();
					String fName = "";
					if (xitem.isFormField()) {
                                                System.out.println(" ## "+xitem.getFieldName()+" ## "+xitem.getString());
                                             if(xitem.getFieldName().equals("p_month")){
                                              v_month = xitem.getString();
                                            }else if (xitem.getFieldName().equals("p_main")){
                                              v_main_rpt = xitem.getString();
                                            }else if(xitem.getFieldName().equals("p_name")){
                                              v_laporan = xitem.getString();
                                            }else if(xitem.getFieldName().equals("p_sub")){
                                              v_sub_rpt = xitem.getString();
                                            }else if(xitem.getFieldName().equals("p_nik")){
                                              v_nik_upload = xitem.getString();
                                            }else if(xitem.getFieldName().equals("p_date")){
                                              v_date = xitem.getString();
                                            }
                                             
					} else {
						if (true) {
							List<String> rslt = UploadUtil.uploadFile(xitem, req,path);
							if (rslt.get(0).equalsIgnoreCase("1")) {
									nameFile = rslt.get(1);
                                                                       strFileName = fName;
									status = "1";
							} else {
								System.out.println("GAGAL");
							}
						}else{
							status = "0";
						}
					}
                                        System.out.println("Xitem = "+xitem.getString());
				}
				req.setAttribute("strFileName", strFileName);
				req.setAttribute("nameFile", nameFile);
				req.setAttribute("status", status);
                                

                                Boolean success = true;
                                if(success){
                                try {
                                    Database db = new Database();
                                    ResultSet resultSet = null;
                                    String sql;
                                    String sql2;
                             
                                        try {

                                            db.connect(1);
                                            sql = "insert into t_upload(id, month_sid, main_rpt_id, nama_laporan, sub_rpt_id, file_name, upload_path, "
                                                    + " maker_userid, maker_dt_stamp, maker_tag, checker_userid, checker_dt_stamp, auth_stat, last_modified_dt_stamp, record_stat, employee_id, upload_date)"
                                                    + " values ( "
                                                    + " nextval('t_upload_seq'),"
                                                    + " '"+v_month+"',"
                                                    + " '"+v_main_rpt+"',"
                                                    + " '"+v_laporan+"',"
                                                    + " '"+v_sub_rpt+"',"
                                                    + " '"+nameFile+"',"
                                                    + " '"+path+"',"
                                                    + " 1, "
                                                    + " CURRENT_TIMESTAMP, "
                                                    + " 'APPLICATION', "
                                                    + " 1,"
                                                    + " CURRENT_TIMESTAMP,"
                                                    + " 'A',CURRENT_TIMESTAMP,'O', "
                                                    + " '"+v_nik_upload+"',"
//                                                    + " '"+v_date+"'"
                                                    + " CURRENT_TIMESTAMP"
                                                    + " )";
                                            
                                        System.out.println(sql);
                                        resultSet = db.executeUpdate(sql);
                                        System.out.println(nameFile);
                                        System.out.println("Database insert t_upload Success = "+sql);
                                        
                                       
                                        sql2 = "insert into t_status ("
                                                + " id, month_sid, main_rpt_id, nama_laporan, sub_rpt_id, status_check, "
                                                + " MAKER_USERID,MAKER_DT_STAMP,MAKER_TAG,CHECKER_USERID, "
                                                + " CHECKER_DT_STAMP,AUTH_STAT,LAST_MODIFIED_DT_STAMP,RECORD_STAT) "
                                                + " values ( "
                                                + " nextval('t_status_seq'),"
                                                + " '"+v_month+"',"
                                                + " '"+v_main_rpt+"',"
                                                + " '"+v_laporan+"', "
                                                + " '"+v_sub_rpt+"', "
                                                + " 'CONFIRMED', "
                                                + " "+v_userID+", "
                                                + " CURRENT_TIMESTAMP, "
                                                + " 'APPLICATION', "
                                                + " "+v_userID+", "
                                                + " CURRENT_TIMESTAMP,"
                                                + " 'A',CURRENT_TIMESTAMP,'O'"   
                                                + " )";
                                        
                                        System.out.println(sql2);
                                        resultSet = db.executeUpdate(sql2);
                                        System.out.println("Database insert t_Status success = "+sql2);
                                        
                                        } catch (SQLException e) {
                                        System.out.println("Database insert Failed!!");
                                        e.printStackTrace();
                                        return;
                                        } finally {
                                            db.close();
                                            if (resultSet != null) resultSet.close(); 
                                        }
     
                                } catch (Exception exc) {
				System.out.println("ERROR - Create file");
				exc.printStackTrace();
                                }

                            } else {
                            System.out.println("Engga sukses baca file!!");
                            };
                                
			} 
                        catch (Exception exc) {
			System.out.println("ERROR - Create file");
			exc.printStackTrace();
			}
		  }
               
            } catch(Exception e){
                e.printStackTrace();
                
            }
              getServletContext().getRequestDispatcher("/views/notifikasi.jsp").forward(req, resp);
              
        }
            
        
	public static String getNameFromUpload (String strFileName) {
		String ret = "";
		if (strFileName != null) {
			String[] strBuff;
			strBuff = strFileName.split("_");
			if(strBuff.length>2){
				for ( int i = 2; i < strBuff.length; i++ ) {
					if(i==strBuff.length-1){
						ret += strBuff[i];
					}else{
						ret += strBuff[i]+"_";
					}
				}
			}else{
				for ( int i = 1; i < strBuff.length; i++ ) {
					ret += strBuff[i];
				}
			}
		}
		return ret;
                
	}
        
        
        @Override
        protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        prosesRequest(req,resp); 
            String v_main= req.getParameter("p_main"); 
            String v_sub= req.getParameter("p_sub");
            String v_name= req.getParameter("p_name");
            String v_month= req.getParameter("p_month");
            String v_institusi = req.getParameter("p_institusi");
            String v_file = req.getParameter("p_file");
            String v_nik = req.getParameter("p_nik");
        }
        
        
        
}
