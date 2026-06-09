<%@include file="/includes/check_auth_layer3.jsp"%>
<%
     
        String vLaporan="";
        String vInstitusi="";
        String vStatus="";
        String vLaporanID="";
        String vFile="";
        String vOppval= "2";
        String vTag="";
        String vName="";
        String vRoles="";
        String vMonth = "";
        int vRole_id= 0;
        
        String username = (String)session.getAttribute("session_first");
        int vFlag;
                    
          try {
            ResultSet resultSet=null;
            Database db = new Database();
            try {   
            
                db.connect(1);
                String sql;
                String sql2;
               
                
//                sql = "select count(1) as jml from v_lead_access_user where userid = "+v_userID+"";
//                            resultSet = db.executeQuery(sql);
//                            while (resultSet.next()) {
//                                v_count_lead = resultSet.getInt("jml");
//                            }
//                            System.out.println("Total Leads = "+v_count_lead);

//                sql = "select nama_laporan, laporan_detail, institusi, sub_rpt_id, file_name, flag_active, status, file_name from v_user_report where userid="+v_userID+" order by month_sid asc, main_rpt_id asc, sub_rpt_id asc, laporan_detail asc";
//                 sql = " select userid, first_name, role_id, role_name from v_user_matrix where userid ="+v_userID;
                 sql = " select id, first_name, div_id, role_code, role_name from v_user_matrix where id ="+v_userID;
  
                db.executeQuery(sql);


                int row = 0;

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

<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <!--<meta http-equiv="X-UA-Compatible" content="IE=edge">-->
    

    <title> Aplikasi Remainder </title>
  
  </head>

  <div class="bg agile">
     	<div class="container">
		<!--<h2 class="blue"> Report Remainder App is under construction</h2><br/><br/>-->
                <div class="title_left"><br/><br/>
                <!--<h3><b>Aplikasi Report Reminder Muamalat</b></h3>-->
                <h2> </h2><br/>
                <h2><b><i>Assalamu'alaikum warahmatullahi wabarakatuh</i></b></h2> 
                <h2>Selamat datang <b><%=v_firstName%></b> di Aplikasi Report Reminder Muamalat.</h2>
                <!--<h2>Anda terdaftar sebagai <b><%=vRoles%></b> </h2>-->
                
                <br/><br/>
                </div>
               <!--//  <p id="filen" > Download SOP Aplikasi MR2 = <span class="fa fa-file-word-o"> SOP Muamalat Report Reminder (MR2).doc </span></p>-->
                <!--<button id="DownloadBtn" type="button" class="btn btn-primary" onclick="return openPagedownload('upload_list_download_Fix.jsp?p_path="/opt/glassfish/RPTRACK/docs/&p_file=SOP Muamalat Report Reminder (MR2).doc)"><span class="fa fa-download" aria-hidden="true"></span> Download File</button>-->

 <!--<div class="row">-->
 
<!--<div class="col-md-12 col-sm-12 col-xs-12 x_panel">
             <div class="">
                <div class="page-title x_title">              
        <div class="" > 
                <div class="x_content">
                    <p class="text-muted font-13 m-b-30"></p>
                    <table id="datatable_belum" class="select-checkbox shoting_disabled table table-striped table-bordered dt-responsive nowrap" cellspacing="0" width="100%" >
                        width="100%"
                        <table id="datatable"  class="table-striped" cellspacing="0"  width="100%" >
                        <thead>
                        <tr>
                          <th>Konfirmasi</th>
                          <th>Nama Laporan</th>
                          <th>Divisi</th>
                         </tr>
                      </thead>                      
                    </table>
                  </div>
              </div>
</div>
                 </div>
                </div>-->

<!--<div class="col-md-12 col-sm-12 col-xs-12 x_panel">
                <div class="page-title x_title">
             <div class="">
                    <div class="x_title">
                  <h2>Laporan yang belum DT</h2>
                  <div class="clearfix"></div>
                </div>
        <div class="" > 
                <div class="x_content">
                    <p class="text-muted font-13 m-b-30"></p>
                    <table id="datatable_belum" class="select-checkbox shoting_disabled table table-striped table-bordered dt-responsive nowrap" cellspacing="0"  width="100%" >
                    <table id="datatable_belum"  class="table-striped"   cellspacing="0"  width="100%" >
                        <thead>
                        <tr>
                          <th>Konfirmasi DT</th>
                          <th>Nama Laporan</th>
                          <th>Divisi</th>
                         </tr>
                      </thead>                      
                    </table>
                </div>
              </div>
            </div>
       </div>
    </div>-->
                <!--================MILESTONE=================-->
                
                 
         <div class="col-md-12 col-sm-4 col-xs-12">
              <div class="x_panel" style="font-size: 1em;">
                <div class="x_title">
                  <h2>Laporan yang belum disubmit bulan <%=vMonth%></h2>
                  <div class="clearfix"></div>
                </div>
                <div class="x_content">
                  <table class="table table-bordered table-hover table-striped">
                      <thead>
                        <tr style="background-color: #5E6974; color: white;">
                          <th>Status</th>
                          <th>Report Name</th>
                          <th>Institution</th>
                          <th>Month</th>
                        </tr>
                      </thead>
                      <tbody id="table_belum">

                      </tbody>
                    </table>
                </div>
              </div>
            </div><br/><br/>
            
            <div class="col-md-12 col-sm-4 col-xs-12">
              <div class="x_panel" style="font-size: 1em;">
                <div class="x_title">
                  <h2>Laporan yang sudah disubmit bulan <%=vMonth%></h2>
                  <div class="clearfix"></div>
                </div>
                <div class="x_content">
                  <table class="table table-bordered table-hover table-striped">
                      <thead>
                        <tr style="background-color: #5E6974; color: white;">
                          <th>Status</th>
                          <th>Report Name</th>
                          <th>Institution</th>
                          <th>Month</th>
                        </tr>
                      </thead>
                      <tbody id="table_sudah">
                      </tbody>
                    </table>
                </div>
              </div>
            </div>
        </div>
    </div>

        

    <!--<script>-->
    
         <script language="javascript" type="text/javascript">
                $(document).ready(function(){
                          $.ajax({
                          type: "POST",
                          url: "module/json_dashboard/home_json_report_belum.jsp",
                          data: '',
         //                data: {vRoles:"01"},
                          cache:false,
                          success: function(d) {
                              $("#table_belum").empty();
                              $('#table_belum').html(d);
                              $("#table_belum").show();

                          },
                          complete: function(){
                          }});

                          $.ajax({
                          type: "POST",
                          url: "module/json_dashboard/home_json_report_sudah.jsp",
                          data: '',
                          cache:false,
                          success: function(d) {
                              $("#table_sudah").empty();
                              $('#table_sudah').html(d);
                              $("#table_sudah").show();

                          },
                          complete: function(){

                              }});

               $('#datatable_belum').DataTable({
                     processing: true,
                     serverSide: true,
                     searching: true,
                     scrollX: true,
                     scrollCollapse: false,
                     select: true,
                     dom: "Bfrtip",
                     lengthMenu: [
                                 [ 10, 25, 50, 100 ],
                                 [ '10 rows', '25 rows', '50 rows', '100 rows' ]
                     ],
                     buttons: [  
                             {
                               extend: 'csv',
                               exportOptions: {
         //                        columns: [2,3,4,5,6]
                                 columns: [  "status", "laporan", "divisi"]
                                }
                             },
         //                    'csv'
                             'excel'
                     ],
                     responsive: true,
                     ajax: {url:'module/json_dashboard/home_json_belum_datatable.jsp',type: 'POST'},
                     "bFilter": true,
                     columns: [
                         { "data": "status" },
                         { "data": "laporan" },
                         { "data": "divisi" }
                         ]
                     }); 
              });
       </script>

       
</html>
