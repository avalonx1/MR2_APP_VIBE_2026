<%@ page language="java" import="Engines.*,Database.*,com.google.gson.*,java.util.*,java.util.regex.*, java.sql.*,javax.naming.*,javax.sql.*,java.math.*, java.lang.String,java.io.*,javax.servlet.*,java.text.*"%>


<%
  String path = request.getContextPath();
  String getProtocol=request.getScheme();
  String getDomain=request.getServerName();
  String getPort=Integer.toString(request.getServerPort());
  String getPath = getProtocol+"://"+getDomain+":"+getPort+path;
  String getAttrHome="/index.jsp?stat_session=1";
  String getAttrDocs="/docs";
  String getHomePath = getPath+getAttrHome;
  String v_mainPath=getHomePath;
  String v_docsPath=getPath+getAttrDocs;

                                                                
          String v_maintenancePath=getPath+"maintenance.jsp";
          String v_userID = (String) session.getAttribute("session_userid");  
          String v_userName = (String) session.getAttribute("session_username");
          String v_employee_id = (String) session.getAttribute("employee_id");
//          String v_userRoleID = (String) session.getAttribute("session_role_id"); 
//          String v_userRoleName = (String) session.getAttribute("session_role_name");
          
//          String v_userGroupID = (String) session.getAttribute("session_group_id"); 
//          String v_userGroupName = (String) session.getAttribute("session_group_name");
          
          String v_userID_parent = (String) session.getAttribute("id_parent");
          String v_phoneExt = (String) session.getAttribute("session_phone_extension");
          String v_title = (String) session.getAttribute("session_title");
          String v_mail = (String) session.getAttribute("session_email");
          String v_firstName = (String) session.getAttribute("session_first_name");
          String v_lastName = (String) session.getAttribute("session_last_name");
          String v_userFullName = v_firstName+" "+v_lastName;
          
          String v_url = request.getParameter("url");
          String v_clientIP = request.getRemoteAddr();
          String v_clientHost = request.getRemoteHost();
          




//security check 1 (session)                             
    if ( ((String) session.getAttribute("session_username") == null && (String) session.getAttribute("session_password") == null) 
    || !request.getMethod().equalsIgnoreCase("post") ) {
        %><script> window.location.href="<%=v_mainPath%>"; </script><%
    } 
 
       
         int v_statMaintenance=0;
         String v_urlID="";
         String v_appName="";
         String v_debugMode="0";
         String v_dokDirPath="";
         String v_fileUploadDir="";
         String v_maxsizeUploadMB="";
         String v_lastIPAddr="";
         String v_lastHost="";
         
         
         int v_homescren_notif=0;
         int v_firstTimeLogin_notif=0;
         int v_NDAConfirmed_notif=0;
         
         auth au = new auth(v_clientIP);
         try {
         v_statMaintenance= au.isMaintenance();
         v_appName=au.getParamValue("APPNAMEURL");
         v_maxsizeUploadMB=au.getParamValue("MAXSIZE_UPLOAD_MB");
                 
        Calendar aCalendar = Calendar.getInstance();
        // add -1 month to current month
        aCalendar.add(Calendar.MONTH, -1);
        // set DATE to 1, so first date of previous month
        aCalendar.set(Calendar.DATE, 1);
        java.util.Date firstDateOfPreviousMonth = aCalendar.getTime();
        DateFormat df = new SimpleDateFormat("yyyyMM");
       
        
         
         v_dokDirPath=au.getParamValue("DOK_DIR_PATH");
         v_debugMode=au.getParamValue("DEBUG_MODE");
         v_fileUploadDir=au.getParamValue("DIR_FILE_UPLOAD");
         v_lastIPAddr = au.getIPAddr(v_userID);
         ;
         v_lastHost = au.getRemoteHost(v_userID);
         
        
         
         
        
         v_userFullName= au.getName(v_userID);
         v_homescren_notif=au.getHomescreenNotifStat(v_userID);
         v_firstTimeLogin_notif=au.getFirstTimeLoginStat(v_userID);
         v_NDAConfirmed_notif=au.getNDAConfirmedStat(v_userID);
         
         
         } catch (SQLException Sqlex) {
         out.println("<div class=sql>" + Sqlex.getMessage() + "</div>");
         } finally {
         au.close();
         }

         
// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ //         
// Check Maintenance
// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ //         
 
         
         if (v_statMaintenance == 1) {
             
             %><script> window.location.href="<%=v_maintenancePath%>"; </script><%
             
         }
         
         
         String v_popup_notif_path="";

         
// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ //         
// notification popup
// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ //         
  
         
         
// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ //         
// Check Login dengan PC Lain
// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ //         

           if (!v_lastIPAddr.equals(v_clientIP)) {
               
               
               
              v_popup_notif_path =getPath+"/views/module/popup_notification/home_base.jsp?";
              v_popup_notif_path += "notifcode=LOGINDUPNTF&act=0&notifcolumn=none&addlinfo="+v_lastIPAddr+"("+v_lastHost+")";
                
             %><script> window.location.href="<%=v_popup_notif_path%>"; </script><%
             
           }
           
           
           
    

%>


