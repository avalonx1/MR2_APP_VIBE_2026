<%@ page language="java" import="Engines.*,Database.*,java.util.*,java.sql.*,javax.naming.*,javax.sql.*"%>
<%

    String ipLocal = request.getRemoteAddr();

    auth lo = new auth(ipLocal);
    int ismaintenance = 0;
    try {
     ismaintenance= lo.isMaintenance();
    } catch (SQLException Sqlex) {
         out.println(Sqlex.getMessage());
    }finally {
         lo.close();
    }
         
    if (ismaintenance == 1) {
        response.sendRedirect("views/maintenance.jsp");
    } else {
        if ((String) session.getAttribute("session_username") == null && (String) session.getAttribute("session_password") == null) {
            String statSession = request.getParameter("stat_session");
            if (statSession==null) {
//                response.sendRedirect("views/login.jsp");
                response.sendRedirect("views/login_nonldap.jsp");
            }else {
//                response.sendRedirect("views/login.jsp?stat_session=1");
                response.sendRedirect("views/login_nonldap.jsp?stat_session=1");
            }
            
        } else {
            response.sendRedirect("views/index.jsp?menuid=1");
//            response.sendRedirect("views/index_old.jsp?menuid=1");
        }
    }


%>