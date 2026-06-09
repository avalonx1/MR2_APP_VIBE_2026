<%-- 
    Document   : distanceGis
    Created on : Sep 27, 2016, 9:29:30 AM
    Author     : 20160038
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%-- 
    Document   : get_branch_distance
    Created on : Sep 28, 2016, 7:46:28 AM
    Author     : 20131254
--%>

<%@ page language="java" import="Database.*,java.io.*,java.lang.*,java.util.*,java.sql.*,javax.naming.*,javax.sql.*,java.net.*"%>

<html>
    <head>
        <!--<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>-->
        <title>Json test</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
    </head>
    <script src="https://maps.google.com/maps/api/js?key=AIzaSyC1W7fYdH208gYM3e-udMXzMIDT8y77c4o"></script>

    
<%
 
String area = request.getParameter("area");

//        AIzaSyC1W7fYdH208gYM3e-udMXzMIDT8y77c4o
//AIzaSyDi5LP8lkv4riesyBCmfXc29-j09HbC15U
//AIzaSyBdDYYHi-JZrRIpeQvbN9ap9UsGTrzKqWA

          String orig_lat="";
          String orig_long="";
          
          String dest_lat="";
          String dest_long="";
          
          
          String orig_br="";
          String dest_br="";
          
          try {
            ResultSet resultSet=null;
            Database db = new Database();
            try {   
            
                db.connect(4);
                String sql;
                
                
                int row=0;
                int totRecord=0;
                
                sql = " select count(1) as jml "
                    + "from v_branch_distance_final where orig_branch_code<>'000' "
                    +" and orig_branch_code=dest_br_parent "
                    +"and dest_branch_type<>'MB' and orig_branch_type<>'MB' "
                    +"and orig_area='"+area+"' ";
                    

                 out.println(sql);
                 out.println("<br/>");
                 
                    resultSet = db.executeQuery(sql);
                    while (resultSet.next()) {
                                totRecord = resultSet.getInt("jml");
                    }
                
                   
                out.println(totRecord);
                    
                sql = " select orig_branch_code,orig_lat,orig_long,dest_branch_code,dest_lat,dest_long "
                    + "from v_branch_distance_final where orig_branch_code<>'000' "
                    +" and orig_branch_code=dest_br_parent "
                    +"and dest_branch_type<>'MB' and orig_branch_type<>'MB' "
                    +"and orig_area='"+area+"' "
                    +"order by orig_branch_code,dest_branch_code ";

                 out.println(sql);
                 //out.println("<br/>");
                 
                 out.println("hasil select : "+totRecord);
                 
                    resultSet = db.executeQuery(sql);
                    
                    
                    %>
                    
                        <script>
                                function initMap() {
                                 var bounds = new google.maps.LatLngBounds;
                                 var outputDiv = document.getElementById('output');

                    
                    <%
                    
                    while (resultSet.next()) {
                        row++;
                      
                        orig_lat = resultSet.getString("orig_lat");
                        orig_long = resultSet.getString("orig_long");
                        
                        dest_lat = resultSet.getString("dest_lat");
                        dest_long=resultSet.getString("dest_long");
                        
                        orig_br = resultSet.getString("orig_branch_code");
                        dest_br = resultSet.getString("dest_branch_code");
                        
                        %>
                      
                    
                                 var origin = {lat: <%=orig_lat%>, lng: <%=orig_long%>};
                                 var destination = {lat: <%=dest_lat%>, lng: <%=dest_long%>};

                                 var geocoder = new google.maps.Geocoder;

                                 var service = new google.maps.DistanceMatrixService;
                                 service.getDistanceMatrix({
                                   origins: [origin],
                                   destinations: [destination],
                                   travelMode: 'DRIVING',
                                   unitSystem: google.maps.UnitSystem.METRIC,
                                   avoidHighways: false,
                                   avoidTolls: false
                                 }, function(response, status) {
                                   if (status !== 'OK') {
                                     alert('Error was: ' + status);
                                   } else {
                                     var originList = response.originAddresses;
                                     var destinationList = response.destinationAddresses;
                                     
                                     //outputDiv.innerHTML = '';
                                     
                                      for (var i = 0; i < originList.length; i++) {
                                       var results = response.rows[i].elements;

                                       for (var j = 0; j < results.length; j++) {

                                         outputDiv.innerHTML += "insert into branch_distance_google(area,orig_br_code,dest_br_code,distance,duration) values ('<%=area%>','<%=orig_br%>','<%=dest_br%>',"+results[j].distance.value+","+results[j].duration.value+");" + "<br>";
                                         
                                     
                                       }
                                     }
                                   }
                                 });
                               
           
                            
                            <%
//                    out.println(row);
                    }
                    
                  
               
                    
                    %>
                            
                            }


                             </script>
                            
                            <%
      
             } catch (SQLException Sqlex) {
                    out.println("<div class=sql>" + Sqlex.getMessage() + "</div>");
                } finally {
                    db.close();
                        if (resultSet != null) resultSet.close(); 
                }
            } catch (Exception except) {
                out.println("<div class=sql>" + except.getMessage() + "</div>");
            }
          
//   https://maps.googleapis.com/maps/api/distancematrix/json?units=metric&origins=&destinations=-6.18018,106.62130|-6.18018,106.62133&key=AIzaSyDi5LP8lkv4riesyBCmfXc29-j09HbC15U
  
         
            
 %>

 
  <!--<body onload="getDistance(),initMap()">-->
        <body onload="initMap()">
        <div>Branch DIstance Data</div>
        
        <div id="output"></div>
        
    </body>
</html>
