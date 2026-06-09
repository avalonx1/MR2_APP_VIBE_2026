<%-- 
    Document   : data_table_test
    Created on : Jul 15, 2016, 9:57:39 PM
    Author     : 20131254
--%>

<%@ page language="java" import="Engines.*,Database.*,java.util.*,java.sql.*,javax.naming.*,javax.sql.*,com.google.gson.*"%>

 <%
         
     
      int displaystart = Integer.parseInt(request.getParameter("start"));
      int displaylength = Integer.parseInt(request.getParameter("length"));
      String search = request.getParameter("search[value]");
      //int columnIdxOrder = Integer.parseInt(request.getParameter("order[i][column]"));
      //String columnDirOrder = request.getParameter("order[1][dir]");
              
      int draw =Integer.parseInt(request.getParameter("draw")) ;
        
                    
          try {
            ResultSet resultSet=null;
            Database db = new Database();
            try {   
            
                db.connect(1);
                String sql;
                
                sql = "select count(1) as jml from data_test2";
                resultSet = db.executeQuery(sql);
                int totalRecords =0;
                while (resultSet.next()) {
                    totalRecords = resultSet.getInt("jml");
                }
                
                sql = "select id,nama,alamat,saldo from data_test2 ";
                
                
                if(!search.equals("")) {
                   
                    sql += "where lower(nama) like('%"+search.toLowerCase()+"%')";
                 }
                
                
                /*
                 if(request.getParameter("order[i][column]")!=null) {
                    int sortcol = columnIdxOrder;
                    sql += " order by "+sortcol+" ";
                    
                    if(!columnDirOrder.equals(""))
                    sql +=columnDirOrder;
                    
                 }
                        */
                                 
                sql += " OFFSET "+displaystart+" LIMIT "+displaylength;
                 
                //System.out.println(sql);
                
                resultSet = db.executeQuery(sql);
                // format returned ResultSet as a JSON array
                JsonObject returnObj = new JsonObject();    
                JsonArray recordsArrayData = new JsonArray();
                
                
          
                int row = 0;
                while (resultSet.next()) {
                        JsonArray recordsArrayContent = new JsonArray();
                        
                        recordsArrayContent.add(new JsonPrimitive(resultSet.getString("id")));
                        recordsArrayContent.add(new JsonPrimitive(resultSet.getString("nama")+" draw:"+draw+" search:"+search));
                        recordsArrayContent.add(new JsonPrimitive(resultSet.getString("alamat")));
                        recordsArrayContent.add(new JsonPrimitive(resultSet.getString("saldo")));
                        recordsArrayData.add(recordsArrayContent);
                        row++;
                        //if(row >= displaystart && row <= (displaystart + displaylength)) {
                       //}
                        }
              
                    returnObj.add("draw", new JsonPrimitive(draw));
                    returnObj.add("recordsTotal", new JsonPrimitive(totalRecords));
                    returnObj.add("recordsFiltered", new JsonPrimitive(totalRecords));
                    returnObj.add("data", recordsArrayData);
                    
                    out.print(returnObj.toString());
                    out.flush();
        
                     } catch (SQLException Sqlex) {
                out.println("<div class=sql>" + Sqlex.getMessage() + "</div>");
            } finally {
                db.close();
                if (resultSet != null) resultSet.close(); 
            }
        } catch (Exception except) {
            out.println("<div class=sql>" + except.getMessage() + "</div>");
        }
          
         
                             
%>
                              