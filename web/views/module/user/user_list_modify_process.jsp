<%@include file="../../../includes/check_auth_layer3.jsp"%>
<%

String userID = v_userID;
String username = v_userName;
String actionCode = request.getParameter("actionCode");
String actionDesc = "";
String formName="Record";
String tableName="t_user";
String seqTableName=tableName+"_seq";
String id="0";

if (actionCode.equals("EDT")){
id = request.getParameter("id");
}


String v_uname_user = request.getParameter("p_username");
System.out.print("p_username = "+v_uname_user);
//String v_altname_user = request.getParameter("p_altname_user");
String v_divisi_user = request.getParameter("p_divisi_user");
System.out.print("p_divisi_user = "+v_divisi_user);
String v_role_user = request.getParameter("p_role_user");
System.out.print("p_role_user = "+v_role_user);
//String v_birthday_user = request.getParameter("p_birthday_user");
//String v_phone_user = request.getParameter("p_phone_user");
//String v_id_parent = request.getParameter("p_id_parent");


        //VALIDATION
//        boolean validate = true;
//        String errorMessage = "";
//
//	boolean cusername = Pattern.matches("[\\w]+", username);



//if (validate) {
        try {
        ResultSet resultSet=null;
        Database db = new Database();
            try {
            db.connect(1);
            String sql;

             if (actionCode.equals("ADD")) {
//
//            String stat_user = "0";
//            sql = "SELECT id, username, password, first_name, last_name, alt_username, title, phone_number, gender " +
//            " from T_USER " +
//            " WHERE id='"+v_uname_user+"'";
//            
//            resultSet = db.executeQuery(sql);
//            
//            if (v_debugMode.equals("1")) {
//            System.out.print(sql);
//            }
//            
//            while (resultSet.next()) {
//            stat_user="1";
//            }


//        if (stat_user.equals("0")) {
//
//            boolean isEligibleLdap = false;
            ldapActiveDirectory ldap = new ldapActiveDirectory(v_clientIP);
//            boolean isActiveLDAP = ldap.isRegisterLDAP(v_uname_user);


//            if (isActiveLDAP) {
//
//
            String AttrFirstName=ldap.getFirstName(v_uname_user).replace("'", "''");
            String AttrLastName=ldap.getLastName(v_uname_user).replace("'", "''");
            String AttrEmail=ldap.getEmail(v_uname_user).replace("'", "''");
            String AttrTitle=ldap.getTitle(v_uname_user).replace("'", "''");
            String AttrIPPhone=ldap.getIPPhone(v_uname_user).replace("'", "''");
            
            sql = "insert into "+tableName+" ("
            + " id, username, password, first_name, last_name, employee_id, alt_username, title, phone_extension, phone_number, gender, email, birthday,"
            + " MAKER_USERID, MAKER_DT_STAMP, MAKER_TAG, CHECKER_USERID, "
            + " CHECKER_DT_STAMP, AUTH_STAT, LAST_MODIFIED_DT_STAMP, RECORD_STAT, image_path, div_id, role_code ) "
            + " values ( "
            + "nextval('"+seqTableName+"'),"
            + "'"+ v_uname_user +"',"
            + " UPPER(md5('" + username+ "')),"
            + "'" + AttrFirstName + "',"
            + "'" + AttrLastName + "',"
            + "'"+ v_uname_user +"',"
//            + "'',"
//            + "'',"
//            + "'',"
            + "'',"
            + "'" + AttrTitle + "', "
            + "'" + AttrIPPhone + "', "         
//            + "'',"
//            + "'',"
            + "'',"
            + "'',"
            + "'" + AttrEmail + "',"
            + "null,"
            + " " + v_userID + ", "
            + " CURRENT_TIMESTAMP, "
            + " 'APPLICATION', "
            + " "+v_userID+", "
            + " CURRENT_TIMESTAMP,"
            + " 'Y',CURRENT_TIMESTAMP,'O','images/man.png', "
                    + " '"+ v_divisi_user +"', "  
                    + " '"+ v_role_user +"' " 
            + " )";
            System.out.print("Insert user = "+sql);
            
//            } else {
//            out.println("User " + username + " is not registered in LDAP Active Directory, please check on LDAP Database first. <br>");
//            }
//
//            } else {
//            out.println("User " + username + " already created, please check again. <br>");
//            }
            
            
           db.executeUpdate(sql);
           
            actionDesc="Add";
      
//         if (v_debugMode.equals("1")) {
//            System.out.print(sql);
//            }
//        db.executeUpdate(sql);
        
             } else {

                
//           boolean isEligibleLdap = false;
//            ldapActiveDirectory ldap = new ldapActiveDirectory(v_clientIP);
//            boolean isActiveLDAP = ldap.isRegisterLDAP(v_uname_user);


//             System.out.print("AAAAA "+v_uname_user + isActiveLDAP);
             
//            if (isActiveLDAP) {


//            String AttrFirstName=ldap.getFirstName(v_uname_user).replace("'", "''");;
//            String AttrLastName=ldap.getLastName(v_uname_user).replace("'", "''");;
//            String AttrEmail=ldap.getEmail(v_uname_user).replace("'", "''");;
//            String AttrTitle=ldap.getTitle(v_uname_user).replace("'", "''");;
//            String AttrIPPhone=ldap.getIPPhone(v_uname_user).replace("'", "''");;
             

                sql = " update "+tableName+" SET "
//                +" userid ='"+v_uname_user+"', "
                +" div_id ='"+v_divisi_user+"', "
                +" role_code ='"+v_role_user+"', "
                +" LAST_MODIFIED_DT_STAMP=CURRENT_TIMESTAMP "
                +" where id="+id;
                
                System.out.print("update divisi ="+sql);
                db.executeUpdate(sql);

              actionDesc="Edit";
        
//            if (v_debugMode.equals("1")) {
//            System.out.print(sql);
//            }
//        db.executeUpdate(sql); 
//       
//        System.out.print("aa"+sql);
//        
//            }
        }

        
    out.print("OK");

    } catch (SQLException Sqlex) {
    out.println("<div class=sql>" + Sqlex.getMessage() + "</div>");
    } finally {
    db.close();
    if (resultSet != null) resultSet.close();
    } 



    } catch (Exception except) {
    out.println("<div class=sql>" + except.getMessage() + "</div>");
    } 


//} else {
//out.println("<div class=alert>" + errorMessage + "</div>");
//}

%>