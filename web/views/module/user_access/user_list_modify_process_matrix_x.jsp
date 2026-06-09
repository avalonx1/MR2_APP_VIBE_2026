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
String Username="";

if (actionCode.equals("EDT")){
id = request.getParameter("id");
}

username = request.getParameter("username");

//String v_uname_user = request.getParameter("p_uname_user");
String v_rolem_user = request.getParameter("p_role_user_matrix");
String v_groupm_user = request.getParameter("p_group_user_matrix");
//String v_altname_user = request.getParameter("p_altname_user");
//String v_title_user = request.getParameter("p_title_user");
//String v_gender_user = request.getParameter("p_gender_user");
// String v_empid_user =request.getParameter("p_empid_user");
//String v_phones_user = request.getParameter("p_phones_user");
//String v_pass_user = request.getParameter("p_pass_user");
//String v_birthday_user = request.getParameter("p_birthday_user");


//String emp_id = request.getParameter("p_empid_user");
//String group_id = request.getParameter("p_group_user");
//String role_id = request.getParameter("p_role_user");
//String email=request.getParameter("email");
// String notification_msg=request.getParameter("notification_msg");

//VALIDATION
boolean validate = true;
String errorMessage = "";


//out.println("<div class=info>" +cabangGroupID +username+ "</div>");

	
if (validate) {
try {
ResultSet resultSet=null;
Database db = new Database();
try {
db.connect(1);
String sql;


if (actionCode.equals("ADD")) {

String stat_user = "0";
sql = " id, userid, group_id, role_id " +
      " from t_user_matrix; " +
      " WHERE id='"+id+"' ";
resultSet = db.executeQuery(sql);
while (resultSet.next()) {
stat_user="1";

if (v_debugMode.equals("1")) {
out.println("<div class=sql>"+sql+"</div>");
}

}





sql = "insert into "+tableName+" ("
+ " id, userid, group_id, role_id, "
+ " MAKER_USERID, MAKER_DT_STAMP, MAKER_TAG, CHECKER_USERID, "
+ " CHECKER_DT_STAMP, AUTH_STAT, LAST_MODIFIED_DT_STAMP, RECORD_STAT ) "
+ " values ( "
+ "nextval('"+seqTableName+"'),"        
+ " "+ v_groupm_user +","
+ " "+ v_rolem_user +","

//+ "'" + AttrFirstName + "',"
//+ "'" + AttrLastName + "',"
//+ "'" + v_altname_user+ "',"
//+ "'" + AttrTitle+ "', "
//+ "'" + AttrIPPhone+ "' "

//+ "'" + AttrEmail + "',"
//+ " " + v_birthday_user+ ", '','','','','','',"
+ " " + v_userID+ ", "
+ " CURRENT_TIMESTAMP, "
+ " 'APPLICATION', "
+ " "+v_userID+", "
+ " CURRENT_TIMESTAMP,"
+ " 'A',CURRENT_TIMESTAMP,'O' "
+ " )";


} else {
out.println("<div class=warning>User " + username + " is not registered in LDAP Active Directory, please check on LDAP Database first. <br></div>");
}

}else {
out.println("<div class=warning>User " + username + " already created, please check again. <br></div>");
}


actionDesc="Add";
System.out.println(sql);
db.executeUpdate(sql);
} else {


ldapActiveDirectory ldap = new ldapActiveDirectory(v_clientIP);
boolean isActiveLDAP = ldap.isRegisterLDAP(username);

if (isActiveLDAP) {

String AttrFirstName=ldap.getFirstName(username).replace("'", "''");;
String AttrLastName=ldap.getLastName(username).replace("'", "''");;
String AttrEmail=ldap.getEmail(username).replace("'", "''");;
String AttrTitle=ldap.getTitle(username).replace("'", "''");;
String AttrIPPhone=ldap.getIPPhone(username).replace("'", "''");;


sql = " update "+tableName+" SET "
//+" username='"+v_uname_user+"',"
+" first_name ='" + AttrFirstName + "',"
+" last_name ='" + AttrLastName + "' ,"
+" alt_username='"+v_altname_user+"', "
+" title='" + AttrTitle + "' ,"
+" email='" + AttrEmail + "' ,"
+" phone_number = '" + AttrIPPhone + "' ,"
+" gender = '"+v_gender_user+"', "
+" LAST_MODIFIED_DT_STAMP=CURRENT_TIMESTAMP "
+" where id="+id;


actionDesc="Edit";
// System.out.println(sql);
db.executeUpdate(sql);
}

//System.out.println(sql);
//debug mode
//if (v_debugMode.equals("1")) {
//System.out.println(sql);
//}
//
//System.out.println(sql);
//out.println("<div class=info>"+actionDesc+" "+formName+" Success<br></div>");

}
} catch (SQLException Sqlex) {
out.println("<div class=sql>" + Sqlex.getMessage() + "</div>");
} finally {
db.close();
if (resultSet != null) resultSet.close();
}
} catch (Exception except) {
out.println("<div class=sql>" + except.getMessage() + "</div>");
}


} else {
out.println("<div class=alert>" + errorMessage + "</div>");
}


%>