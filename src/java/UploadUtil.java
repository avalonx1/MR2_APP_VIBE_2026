import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.lang.ArrayUtils;

public class UploadUtil {
	public static List<String> uploadFile(FileItem item, HttpServletRequest request, String additionFileLoc) {
		File mUploadedDir;
		Date date = new Date();
		List<String> uploadResult = new ArrayList<String>();
		uploadResult.add(0, "0");
		SimpleDateFormat sdf = new SimpleDateFormat("ddMMyyyy");
		
			String newNamaFile = item.getName();
//			HttpSession ssn = request.getSession();
//			if (ssn != null) {
//				newNamaFile = ssn.getId() + "_" + sdf.format(date) + "_" + item.getName().replaceAll("[^a-zA-Z0-9\\.]", "_");
//			} else {
//				newNamaFile = sdf.format(date) + "_" + item.getName();
//			}

			OutputStream out = null;
			InputStream filecontent = null;
			try {
				File dirHeaderFile = new File(additionFileLoc);
				if (!dirHeaderFile.exists()) {
					dirHeaderFile.mkdirs();
				}
				mUploadedDir = new File("" + dirHeaderFile);
				out = new FileOutputStream(new File(mUploadedDir + File.separator + newNamaFile));
				filecontent = item.getInputStream();
				int read = 0;
				final byte[] bytes = new byte[1024];
				while ((read = filecontent.read(bytes)) != -1) {
					out.write(bytes, 0, read);
				}
				System.out.println("New file " + newNamaFile + " created at " + dirHeaderFile.getPath().toString());
				uploadResult.add(0, "1");
				uploadResult.add(1, newNamaFile);
			} catch (Exception e) {
				System.err.println("File " + newNamaFile + " gagal diupload");
				uploadResult.add(1, "File " + newNamaFile + " gagal diupload");
				e.printStackTrace();
			} finally {
				if (out != null) {
					try {
						out.close();
                                                out.flush();
					} catch (IOException e) {
						e.printStackTrace();
					}
				}
				if (filecontent != null) {
					try {
						filecontent.close();
                                                out.flush();
					} catch (IOException e) {
						e.printStackTrace();
					}
				}
			}

		return uploadResult;
	}


	/** @param item
	 * @return */
//	public static Boolean cekFile(FileItem item) {
//		// Allow File Types
//		String[] uploadType = { "pdf,jpeg,jpg" };
//		String allowTypes = "pdf,jpeg,jpg";
////                String[] uploadType = { "doc,docx,csv,xlsx,xls,pdf,jpeg,jpg,PNG,png" };
////		String allowTypes = "doc,docx,csv,xlsx,xls,pdf,jpeg,jpg,PNG,png";
//		if (allowTypes != null && allowTypes != "") {
//			uploadType = allowTypes.split(",");
//		}
//
//		// Allow File Size
//		Integer allowMBSize = 10;
//		String allowMBSizes = "10";
//		if (allowMBSizes != null && allowMBSizes != "") {
//			allowMBSize = new Integer(allowMBSizes);
//		}
//
//		Boolean isAllowType = false;
//		Boolean isAllowSize = false;
//
//		long byteSizes = item.getSize();
//		String ctype = item.getContentType();
//		String mimeType = ctype.substring(ctype.lastIndexOf("/") + 1, ctype.length()).toLowerCase().replace("\"", "");
//
//		isAllowType = ArrayUtils.contains(uploadType, mimeType);
//		if (!isAllowType) {
//			System.out.println("File type not allowed !, allow file types is " + uploadType.toString());
//		}
//
//		if (allowMBSize.intValue() > 0) {
//			allowMBSize = (allowMBSize * 1000) * 1024;
//			isAllowSize = byteSizes <= allowMBSize ? true : false;
//			if (byteSizes <= allowMBSize) {
//				isAllowSize = true;
//			} else {
//				System.err.println("File size is bigger than allow size. Allow file size is : " + allowMBSize + " MB");
//			}
//		} else {
//			isAllowSize = true;
//			System.out.println("Ignoring file size due to maximum size is not set !");
//		}
//		if (isAllowType == true && isAllowSize == true) {
//			return true;
//		} else {
//			return false;
//		}
//	}
}