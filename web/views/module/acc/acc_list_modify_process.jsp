<%@include file="../../../includes/check_auth_layer3.jsp"%>
<%

    String userID = v_userID;
    String username = v_userName;
    String actionCode = request.getParameter("actionCode");
    String actionDesc = "";
    String formName="Record";
    String tableName="t_account";
    String seqTableName=tableName+"_seq";
    
    
    String id="0";
    
    if (actionCode.equals("EDT")){
    id = request.getParameter("id");
    }
    
    String v_name=request.getParameter("p_name_acc");
    String v_phone=request.getParameter("p_phone_acc");
    String v_description=request.getParameter("p_desc_acc");
    
    String v_address=request.getParameter("p_address_acc");
    String v_country=request.getParameter("p_country_acc");
    String v_street=request.getParameter("p_street_acc");
    String v_city=request.getParameter("p_city_acc");
    String v_state=request.getParameter("p_state_acc");
    String v_postal=request.getParameter("p_postal_acc");
    
    String v_b_address=request.getParameter("p_b_address_acc");
    String v_b_country=request.getParameter("p_b_country_acc");
    String v_b_street=request.getParameter("p_b_street_acc");
    String v_b_city=request.getParameter("p_b_city_acc");
    String v_b_state=request.getParameter("p_b_state_acc");
    String v_b_postal=request.getParameter("p_b_postal_acc");
 
    String v_annual=request.getParameter("p_annual_acc");
    String v_website=request.getParameter("p_website_acc");
    String v_industry=request.getParameter("p_industry_acc");
    String v_emp=request.getParameter("p_emp_acc");
    String v_id_owner=request.getParameter("p_id_owner");
    String v_id_member=request.getParameter("p_id_member");
    
    
    
    
    //convert
    
    
    //VALIDATION
    boolean validate = true;
    String errorMessage = "";
    
    
    
    
    if (validate) {
        try {
            ResultSet resultSet=null;
            Database db = new Database();
            try {
                db.connect(1);
                String sql;
                

                 
               if (actionCode.equals("ADD")) {
                sql = "insert into "+tableName+" ("
                    + " id, name, id_owner,id_member, id_parent, website, phone, id_industry, no_of_employees, description, address_b, street_b, city_b, state_b, "
                    + " postal_code_b, country_b, address_s, street_s, city_s, state_s, postal_code_s, country_s, annual_revenue,"
                    + " MAKER_USERID,MAKER_DT_STAMP,MAKER_TAG,CHECKER_USERID, "
                    + " CHECKER_DT_STAMP,AUTH_STAT,LAST_MODIFIED_DT_STAMP,RECORD_STAT  ) "
                    + " values ( "
                    + " nextval('"+seqTableName+"'),"
                    + "'"+v_name+"',"
                    + " "+v_id_owner+", "
                    + " "+v_id_member+", " 
                    + " 0, " 
                    + "'"+v_website+"',"
                    + "'"+v_phone+"',"
                    + " "+v_industry+","
                    + " "+v_emp+","
                    + "'"+v_description+"',"
                    + "'"+v_b_address+"', "
                    + "'"+v_b_street+"', "
                    + "'"+v_b_city+"', "
                    + "'"+v_b_state+"', "
                    + "'"+v_b_postal+"', "
                    + "'"+v_b_country+"', "
                    + "'"+v_address+"', "
                    + "'"+v_street+"', "
                    + "'"+v_city+"', "
                    + "'"+v_state+"', "
                    + "'"+v_postal+"', "
                    + "'"+v_country+"', "
                    + ""+v_annual+", "
                    + " "+v_userID+", "
                    + " CURRENT_TIMESTAMP, "
                    + " 'APPLICATION', "
                    + " "+v_userID+", "
                    + " CURRENT_TIMESTAMP,"
                    + " 'A',CURRENT_TIMESTAMP,'O' "    
                    + " )";
                    
                actionDesc="Add";
                
              
                 
               db.executeUpdate(sql);
               
              
                 out.println("OK");
                 
                 
               }else {

                 sql = "update "+tableName+" SET "
                     + "id_owner="+v_id_owner+","
                     +"id_member="+v_id_member+","
                     +"name='"+v_name+"',"
                     +"website='"+v_website+"',"
                     +"phone='"+v_phone+"',"
                     +"id_industry='"+v_industry+"',"
                     +"no_of_employees='"+v_emp+"',"
                     +"description='"+v_description+"', "
                     +"address_b='"+v_b_address+"', "
                     +"street_b='"+v_b_street+"',"
                     +"city_b='"+v_b_city+"',"
                     +"state_b='"+v_b_state+"',"
                     +"postal_code_b='"+v_b_postal+"',"
                     +"country_b='"+v_b_country+"',"
                     +"address_s='"+v_address+"', "
                     +"street_s='"+v_street+"',"
                     +"city_s='"+v_city+"',"
                     +"state_s='"+v_state+"',"
                     +"postal_code_s='"+v_postal+"',"
                     +"country_s='"+v_country+"',"
                     +"annual_revenue="+v_annual+","
                     +"LAST_MODIFIED_DT_STAMP=CURRENT_TIMESTAMP "     
                     +" where id="+id;
                 
                 actionDesc="Edit";
                   
                  db.executeUpdate(sql);
               out.println("OK");
               }
               
               //debug mode            
                        if (v_debugMode.equals("1")) {
                        System.out.println(sql);
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


