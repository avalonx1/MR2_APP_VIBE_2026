<%-- 
    Document   : newjsp
    Created on : Sep 29, 2016, 10:39:45 AM
    Author     : 20160038
--%>

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
            
                        <script>
                                function initMap() {
                                 var bounds = new google.maps.LatLngBounds;
                                 var outputDiv = document.getElementById('output');


//orig_lat	orig_long	dest_branch_code	dest_lat	dest_long
//0.77989	127.38312	842	-0.62683	127.47743



                                var origin = {lat: 0.77989, lng: 127.38312};
                                 var destination = {lat: -0.62683, lng: 127.47743};
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

                                         outputDiv.innerHTML += "insert into branch_distance_google(area,orig_br_code,dest_br_code,distance,duration) values ("+results[j].distance.value+","+results[j].duration.value+");" + "<br>";
                                         
                                     
                                       }
                                     }
                                   }
                                 });
                               
           

                            }


                             </script>
                            
                         

 
  <!--<body onload="getDistance(),initMap()">-->
        <body onload="initMap()">
        <div>Branch DIstance Data</div>
        
        <div id="output"></div>
        
    </body>
</html>
