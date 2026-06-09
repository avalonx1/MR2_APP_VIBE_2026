
<%--<%@include page="/UploadServlet2"%>--%>
<%@include file="/includes/check_auth_layer3.jsp"%>
<%@include file="/includes/javascript.jsp"%>
<%--<%@ page contentType="text/html;charset=UTF-8" language="java" %>--%>
<%--<%@ page ="/UploadServlet" %>--%>

<%                
 String action = request.getParameter("action");
 String actionCode = "";
 String actionText = "";
 
 if (action==null) {
     actionCode="ADD";
     actionText="Insert";
 }else {
     actionCode="EDT";
     actionText="Update";
 }
 
 String header_title_act="";
  
 String id="0";
 
 String v_divisi_upload="";
 String v_name_upload="";
 String v_nik_upload="";
 String v_nama_laporan="";
 String v_periode_upload="";
 String v_detail_upload="";
 String v_institusi_upload="";
 String v_id_owner_upload="";
 String v_month="";
 String v_main_rpt="";
 String v_sub_rpt="";
 String v_status="";
 String v_institusi="";
// String v_path="";
 String v_file="";
// String v_path = "/opt/glassfish/RPTRACK/docs"; //prod
 String v_path = "D:/MR2_2022/MR2_data/folder_uat_mr2"; //dev
 String tag="";
 String tag_user="";
 String v_role_code="";
 String v_role_name="";
 String v_date="";
 String v_lap_detail="";
 
           
 if (actionCode.equals("ADD") ) {
     header_title_act="Add";
//     v_id_owner_upload = v_userID;
 } else {
     header_title_act="Edit";
     id  = request.getParameter("id");

      try {
                        ResultSet resultSet = null;
                        Database db = new Database();

                        try {
                            db.connect(1);
                            String sql;
                                 
                                  sql = "select id_view_user_report, divisi, id_report, first_name, employee_id, nama_laporan, periode, detail_periode, institusi, month_sid, main_rpt_id, sub_rpt_id, status, upload_path, file_name, role_code, role_name, laporan_detail, to_char(upload_date,'MM/DD/YYYY') as upload_date from v_user_report_4 where id_view_user_report = "+id;

                            System.out.println("sql di modify = "+sql);
                            System.out.println("id di modify = "+id);

                            resultSet = db.executeQuery(sql);
                            String rowstate = "even";
                                
                            while (resultSet.next()) {
                                
                                 v_divisi_upload = resultSet.getString("divisi");
                                 v_name_upload = resultSet.getString("first_name");
                                 v_nik_upload = resultSet.getString("employee_id");
                                 v_nama_laporan = resultSet.getString("nama_laporan");
                                 v_periode_upload = resultSet.getString("periode");
                                 v_detail_upload = resultSet.getString("detail_periode");
                                 v_institusi = resultSet.getString("institusi");
                                 v_month = resultSet.getString("month_sid");
                                 v_main_rpt = resultSet.getString("main_rpt_id");
                                 v_sub_rpt = resultSet.getString("sub_rpt_id");
                                 v_status = resultSet.getString("status");
//                                 v_path = resultSet.getString("upload_path");"/opt/glassfish/RPTRACK/docs"
                                 v_file = resultSet.getString("file_name");
                                 v_role_code = resultSet.getString("role_code");
                                 v_role_name = resultSet.getString("role_name");
                                 v_lap_detail = resultSet.getString("laporan_detail");
                                 v_date = resultSet.getString("upload_date");
                            }
                            System.out.println("reportnya = " + v_nama_laporan);
                            System.out.println("sub_rept = " + v_sub_rpt);
                            System.out.println("Status = " + v_status);
                            System.out.println("Path file = " + v_path);
                            System.out.println("File name = " + v_file);
                            System.out.println("Username = " + v_nik_upload);
                            System.out.println("Combine = " + v_path +"/"+ v_file);
                            String actText="";
                            
               
                        } catch (SQLException Sqlex) {
//                            out.println("<div class=sql>" + Sqlex.getMessage() + "</div>");
                        } finally {
                            db.close();
//                                if (resultSet != null) resultSet.close(); 
                        }
                        
                        
//                         if (resultSet.getString("file_name")) {
//                         int tag = 0;     
                        if (v_file == null || v_file.isEmpty()){
                         tag = "EXT";
                        } else {
                         tag = "ZERO";
                        };
                        System.out.println("tag = "+tag);
                         
                         if (v_role_code.equals("03") ){
                            tag_user = "MONITOR";
                         } else if (v_role_code.equals("04")){
                            tag_user = "SECURE";
                         } else {
                             tag_user = "UNKNOWN STATUS";
                         };
                         System.out.println("v_role_code = "+v_role_code);
                         System.out.println("tag_user = "+tag_user);
 
                            
                        
                    } catch (Exception except) {
//                        out.println("<div class=sql>" + except.getMessage() + "</div>");
                    } 
 }

%>

<%
// String tag = resultSet.getString("file_name");     
//                        if  (tag==null || tag.isEmpty()){
//                         tag = '';
//                         } else{
//                         tag = '';
//                         };
// 
// 
%>

<!--<input type="hidden" id="p_file" name="p_file" value="<%=v_file%>" />-->
<!--<input type="hidden" id="p_status" name="p_status" value="<%=v_status%>" />-->

<script>
       var status = '<%=v_status%>';
       if ( status !== 'CONFIRMED') {
            document.getElementById("status").innerHTML = "<b>Belum dikonfirmasi</b>  ";
        };
</script>
<script>
    var validate = '<%=tag%>';
    var validate_user = '<%=tag_user%>';
        if (validate === 'EXT') {
            document.getElementById('UploadBtn').className = "btn btn-primary";
            document.getElementById('UploadBtn').disabled = false;
            document.getElementById('DeleteBtn_modal').disabled = true;
            document.getElementById('DownloadBtn').disabled = true;
            document.getElementById('filen').innerHTML = "<b>File = Tidak Ada</b>";
            document.getElementById('dates').innerHTML = "<b>Submit Date = Belum Submit</b>";
        } else if (validate === 'ZERO'){
            document.getElementById('UploadBtn').disabled = true;
            document.getElementById('UploadBtn').className = "btn btn-dark";
        };
        
//        else if (validate === 'MONITOR') {
//            document.getElementById('UploadBtn').className = "btn btn-dark";
//            document.getElementById('UploadBtn').disabled = true;
//            document.getElementById('DeleteBtn_modal').disabled = true;
//            document.getElementById('filen').innerHTML = "<b>File = Tidak Ada</b>";
//        } else if (validate === 'SECURE'){
//            document.getElementById('UploadBtn').disabled = true;
//            document.getElementById('DeleteBtn_modal').disabled = true;
//            document.getElementById('DownloadBtn').disabled = true;
//            document.getElementById('UploadBtn').className = "btn btn-dark";
//        };
        
        if (validate_user === 'MONITOR') {
            document.getElementById('UploadBtn').className = "btn btn-dark";
            document.getElementById('UploadBtn').disabled = true;
            document.getElementById('DeleteBtn_modal').disabled = true;
            document.getElementById('DownloadBtn').disabled = false;
                if (validate === 'EXT') {
                document.getElementById('DownloadBtn').disabled = true;
                }
        } else if (validate_user === 'SECURE'){
            document.getElementById('UploadBtn').disabled = true;
            document.getElementById('DeleteBtn_modal').disabled = true;
            document.getElementById('DownloadBtn').disabled = true;
            document.getElementById('UploadBtn').className = "btn btn-dark";
        }        
</script>

<div class="x_panel">
<div class="x_content">
   <input type="hidden" id="p_file" name="p_file" value="<%=v_file%>" />
   <div class="col-md-12 col-xs-12">
            <div class="page-title">
              <div class="title_left">
               <h3><i class="fa fa-file-text-o"></i> Report Detail </h3>
              </div>
              </div>
            </div>
            <div class="clearfix"></div>
            
            <span class='label label-inverse'>BELUM <span class='fa fa-close'/></span>
            <div class="col-md-12 col-xs-12">
                <div class="x_panel">

                  <div class="x_content">
                    <br />
                    
                    <!-- FORM -->
                    <!--<form action="UploadServlet" method="post" enctype="multipart/form-data" class="form-horizontal form-label-left">-->
                        
                    <!--<form  method="post" enctype="multipart/form-data" class="form-horizontal form-label-left" action="#target" onsubmit="return checkForm(this);">-->
                    <form id="form_laporan" method="post" enctype="multipart/form-data" class="form-horizontal form-label-left">
                        <!--<form id="goto_submitModifyForm" class="form-horizontal form-label-left">-->
                    <input type="hidden" id="sub_rpt_id" name="id" value="<%=id%>" />
                    <input type="hidden" id="actionCode" name="actionCode" value="<%=actionCode%>" />
                    <input type="hidden" id="p_main" name="p_main" value="<%=v_main_rpt%>" />
                    <input type="hidden" id="p_sub" name="p_sub" value="<%=v_sub_rpt%>" />
                    <input type="hidden" id="p_name" name="p_name" value="<%=v_nama_laporan%>" />
                    <input type="hidden" id="p_month" name="p_month" value="<%=v_month%>" />
                    <input type="hidden" id="p_institusi" name="p_institusi" value="<%=v_institusi%>" />
                    <input type="hidden" id="p_file" name="p_file" value="<%=v_file%>" />
                    <input type="hidden" id="p_nik" name="p_nik" value="<%=v_nik_upload%>" />
    
                      <div class="form-group">
                        
                      <!--<h2 color="grey">PIC Report <%=v_name_upload%></h2>-->
                                             
                      <h2><p class="lead">Laporan <%=v_lap_detail%> (<%=v_month%>)</p></h2>
                      
                    <div class="col-md-12 col-xs-12">
                           <!--<div class="well">-->
                          <div class="table-responsive">
                            <table class="table">
                              <tbody>
                                <tr>
                                  <th style="width:50%">Nama user upload : </th>
                                  <td class="green"><b> <%=v_name_upload%></b></td>
                                </tr>
                                <tr>
                                  <th>NIK user upload : </th>
                                  <td><%=v_nik_upload%></td>
                                </tr>
                                <tr>
                                  <th style="width:50%">Month: </th>
                                  <td><b> <%=v_month%></b></td>
                                </tr>
                                <tr>
                                  <th>Divisi: </th>
                                  <td><%=v_divisi_upload%></td>
                                </tr>
                                <tr>

                                  <th>Laporan : </th>
                                  <td class="green"><b><%=v_lap_detail%></b></td>
                                </tr>
                                <tr>
                                  <th>Periode : </th>
                                  <td><%=v_periode_upload%></td>
                                </tr>
                                
                                <tr>
                                  <th>Institusi :</th>
                                  <td><%=v_institusi%></td>
                                </tr>
                                <tr>
                                  <th>Konfirmasi : </th>
                                  <td>
                                      <p id="status" class="green"><b>Sudah dikonfirmasi</b></p>
                                  </td>
                                </tr>
                                
                        </div>
                                
                              </tbody>
                            </table>
                                <div>
                              
                            </div>  
                          </div>      
                        </div>
                </div>         
                </form>
                    <!--<div class="ln_solid"></div>-->
<!--                        <div >
                           <form id="confirm_status">
                                    <input type="hidden" id="file_loc" name="file_loc" value="<%=v_path%>" />
                                    <input type="hidden" id="file_name" name="file_name" value="<%=v_file%>" />
                                    <input type="hidden" id="sub_rpt_id" name="id" value="<%=id%>" />
                                    <input type="hidden" id="actionCode" name="actionCode" value="<%=actionCode%>" />
                                    <input type="hidden" id="p_main" name="p_main" value="<%=v_main_rpt%>" />
                                    <input type="hidden" id="p_sub" name="p_sub" value="<%=v_sub_rpt%>" />
                                    <input type="hidden" id="p_name" name="p_name" value="<%=v_nama_laporan%>" />
                                    <input type="hidden" id="p_month" name="p_month" value="<%=v_month%>" />
                                    <input type="hidden" id="p_path" name="p_path" value="<%=v_path%>" />
                                    <button id="button_confirm" type="submit" name="button_confirm" class="btn btn-dark btn-block" led="true"><span class="fa fa-check" aria-hidden="true"></span> Konfirmasi </budisabtton>
                            </form>   
                        </div>-->
                    <div class="ln_solid"></div>
                
                                  
                  <!--</div>-->
                        <!--</div>-->
                <div class="well col-md-12 col-xs-12">
                    <!--<div class="x_content">-->
                    
                      
                    
                    
                        
                    <h2><span class="fa fa-check-square-o" aria-hidden="true"></span> Submit & Upload File </h2><br/>
                    <!--<div class="well-sm">-->
<!--                    <div class="col-md-6 col-sm-6 col-xs-12 form-group has-feedback">
                            <label class="control-label col-md-3 col-sm-3 col-xs-12">Submitted Date</label>
                            <div class="col-md-9 col-sm-9 col-xs-12">
                                <input type="text" class="form-control has-feedback-left" id="single_cal1" required="required" name="p_date" placeholder="Insert Date" aria-describedby="inputSuccess2Status4" value="<% out.println((v_date == null) ? "" : v_date); %>" >
                                <span class="fa fa-calendar form-control-feedback left" aria-hidden="true"></span>
                                <span id="inputSuccess2Status4" class="sr-only">(success)</span>
                            </div>
                      </div>-->
                    
                    
                    
                    <!--========-->
                    <div>
                        <input type="hidden" id="p_institusi" name="p_institusi" value="<%=v_institusi%>" />
                        <input type="hidden" id="p_file" name="p_file" value="<%=v_file%>" />
                        <input type="hidden" id="sub_rpt_id" name="id" value="<%=id%>" />
                        <input type="hidden" id="p_main" name="p_main" value="<%=v_main_rpt%>" />
                        <input type="hidden" id="p_sub" name="p_sub" value="<%=v_sub_rpt%>" />
                        <input type="hidden" id="p_month" name="p_month" value="<%=v_month%>" />
                        <input type="hidden" id="p_path" name="p_path" value="<%=v_path%>" />
                        <input type="hidden" id="p_nik" name="p_nik" value="<%=v_nik_upload%>" />
                        
                        
                        
                        <button id="UploadBtn" type="button" class="btn btn-block btn-primary" value="Upload" data-toggle="tooltip" data-placement="right" title="" data-original-title="Click to submit" onclick="return openPage_upload('upload_list_upload.jsp?p_sub=<%=v_sub_rpt%>&p_main=<%=v_main_rpt%>&p_name=<%=v_nama_laporan%>&p_month=<%=v_month%>&p_institusi=<%=v_institusi%>&p_file=<%=v_file%>&p_path=<%=v_path%>&p_nik=<%=v_nik_upload%>')"><span class="fa fa-external-link" aria-hidden="true"></span> Upload File & Confirm</button>
                        <!--<button id="UploadBtn" type="button" class="btn btn-primary btn-block" onclick="return popup()" value="Upload"><span class="fa fa-upload" aria-hidden="true"></span> Upload File Development</button>-->
                        <!--<button id="UploadBtn" type="button" class="btn btn-block btn-danger" value="Upload" data-toggle="tooltip" data-placement="right" title="" data-original-title="Click to submit" onclick=""><span class="fa fa-external-link" aria-hidden="true"></span> Upload Popup Test</button>-->
                        
                    </div><br/>
                    
                    <div class="well">
                        <!--<p id="filen" ><b></b></p>--> 
                        <p id="dates"><b>Submit Date = <span class="green"><%=v_date%></span></b></p> 
                        <p id="filen"><b>File = <span class="green"><%=v_file%></span></b></p> 
                    </div>
                    
   
<div class="col-md-6 col-sm-6 col-xs-12">
                <form>
                    <input type="hidden" id="p_institusi" name="p_institusi" value="<%=v_institusi%>" />
                    <input type="hidden" id="p_file" name="p_file" value="<%=v_file%>" />
                    <input type="hidden" id="sub_rpt_id" name="id" value="<%=id%>" />
                    <input type="hidden" id="p_main" name="p_main" value="<%=v_main_rpt%>" />
                    <input type="hidden" id="p_sub" name="p_sub" value="<%=v_sub_rpt%>" />
                    <input type="hidden" id="p_month" name="p_month" value="<%=v_month%>" />
                    <input type="hidden" id="p_path" name="p_path" value="<%=v_path%>" />
                    <input type="hidden" id="p_nik" name="p_nik" value="<%=v_nik_upload%>" />
                    <!--<button id="DeleteBtn" type="submit" class="btn btn-danger" method="get" onclick="return openPage_delete('upload_list_delete.jsp?file_loc=<%=v_path%>&file_name=<%=v_file%>')"><span class="fa fa-close" aria-hidden="true"></span> Delete File</button>-->     
                    <!--<button id="DeleteBtn" type="button" class="btn btn-danger btn-block" method="get" onclick="deletePop()" onclick="return openPage_delete('upload_list_delete.jsp?file_loc=<%=v_path%>&file_name=<%=v_file%>&month_rpt=<%=v_month%>&main_rpt=<%=v_main_rpt%>&sub_rpt=<%=v_sub_rpt%>')"><span class="fa fa-close" aria-hidden="true"></span> Delete File</button>-->     
                    <button id="DeleteBtn_modal" type="button" class='btn btn-danger btn-block' data-toggle='modal' data-target='#ConfirmDelete' ><i class='fa fa-trash-o'></i> Delete </button>
                <div id='ConfirmDelete' class='modal fade confirm-delete' tabindex='-1' role='dialog' aria-hidden='true'> 
                        <div class='modal-dialog modal-lg'>  
                         <div class='modal-content'>  
                           <div class='modal-header'>  
                             <button type='button' class='close' data-dismiss='modal'>
                                 <span aria-hidden='true'><span class="fa fa-close" aria-hidden="true"></span></span>  
                             </button>  
                             <h4 class='modal-title'>Confirmation</h4>  
                           </div>  
                           <div class='modal-body'>  
                             <h4></h4>  
                             <p>Are You Sure want to delete this file? </p>  
                             <p class='info-id'> File : "<%=v_file%>"</p>  
                           </div>  
                           <div class='modal-footer'>  
                             <button type='button' class='btn btn-primary' data-dismiss='modal'>Cancel</button>  
                             <!-- <button id='delete_"+resultSet.getString("id")+"'  type='button' class='btn btn-danger btn-ok' data-dismiss='modal' >Delete</button>  -->
                             <button id="DeleteBtn" type="button"  data-dismiss='modal' class="btn btn-danger" method="get" onclick="return openPage_delete('upload_list_delete.jsp?file_loc=<%=v_path%>&file_name=<%=v_file%>&month_rpt=<%=v_month%>&main_rpt=<%=v_main_rpt%>&sub_rpt=<%=v_sub_rpt%>')"><span class="fa fa-close" aria-hidden="true"></span> Delete File</button> 
                           </div>  
                         </div>  
                        </div>
                </div>
                </form> 
                
                </div>   

                <div class="col-md-6 col-sm-6 col-xs-12">

                <form>
                    <!--<input type="hidden" id="p_institusi" name="p_institusi" value="<%=v_institusi%>" />-->
                    <input type="hidden" id="p_path" name="p_path" value="<%=v_path%>" />
                    <input type="hidden" id="p_file" name="p_file" value="<%=v_file%>" />
                    <button id="DownloadBtn" type="button" class="btn btn-primary btn-block" onclick="return openPagedownload('upload_list_download_Fix.jsp?p_path=<%=v_path%>&p_file=<%=v_file%>')"><span class="fa fa-download" aria-hidden="true"></span> Download File</button>
                    <!--<button id="DownloadBtn" type="submit" class="btn btn-primary btn-block"><span class="fa fa-download" aria-hidden="true"></span> Download File Servlet</button>-->
                </form>
                </div>
                    <!--======-->
                    
                    

                    
<!--    <form id="form" action="../Download_File" method="post" enctype="multipart/form-data">
   
        <div class="well">
            <input type="hidden" id="p_sub" name="p_sub" value="<%=v_sub_rpt%>" />
            <input type="hidden" id="p_main" name="p_main" value="<%=v_main_rpt%>" />
            
            <input type="hidden" id="p_month" name="p_month" value="<%=v_month%>" />
            <input type="hidden" id="p_institusi" name="p_institusi" value="<%=v_institusi%>" />
            <input type="hidden" id="p_nik" name="p_nik" value="<%=v_nik_upload%>" />
        <table>
            <tr>
                <td>Pilih File : </p><input type="file" name="filecover" value="Upload"/></td>

            </tr>          
        </table>
        </div>
            
            <button type="submit" class="btn btn-primary btn-block"><span class="fa fa-upload" aria-hidden="true"></span> Upload file</button>      
            
    </form>-->
    </div>
                    
                    
               </div>
               </div>
                </div>
                </div>
                      <div class="form-group">
                        <div class="col-md-offset-5">
                          <button id="goto_back" type="button" class="btn btn-danger" data-toggle="tooltip" data-placement="right" title="" data-original-title="Tooltip right"><span class="fa fa-remove" aria-hidden="true"></span> Back </button><br/><br/>
                        </div>
                      </div>
                </div>
                
              </div>
</div>




<script>
    function deletePop() {
    var r = confirm("Hapus file ini?");
    if (r === true) {
        openPage_delete('upload_list_delete.jsp?file_loc=<%=v_path%>&file_name=<%=v_file%>&month_rpt=<%=v_month%>&main_rpt=<%=v_main_rpt%>&sub_rpt=<%=v_sub_rpt%>');
//        txt = "You pressed OK!";
    } else {
//        txt = "You pressed Cancel!";
    }
};
    
        function openPagedownload(pageURL)
            {
            window.location.href = pageURL;
//            window.open = pageURL;
            return false;
        };
    
         function openPage_delete(pageURL)
            {
            window.location.href = pageURL;
//            return false;
        };
       
        function openPage_upload(pageURL)
            {
            var width = 980;
            var height = 515;
            var left = (screen.width - width)/2;
            var top = (screen.height - height)/2;
            var params = 'width='+width+', height='+height;
            params += ', top='+top+', left='+left;
            params += ', directories=no';
            params += ', location=no';
            params += ', menubar=no';
            params += ', resizable=no';
            params += ', scrollbars=no';
            params += ', status=no';
            params += ', toolbar=no';
            newwin = window.open(pageURL,'windowname5', params);
//          if (window.focus) {newwin.focus();
//                }
//            return false;
        };
        
        function notifikasi(){
//            window.location.href = "views/upload_list.jsp";
            window.location.href = "../../../upload_list.jsp";
            new PNotify({title: 'Data',text: 'SUCCESS: Data has been uploaded..',type: 'success',styling: 'bootstrap3'});
        };
         function doModal(){
            $('#ConfirmDelete').modal('hide');
                 preventDefault();
        };
        
</script>

<script type="text/javascript">
     $(document).ready(function() {   
            
        $("#confirm_status").submit(function(ev) {
                    $.ajax({
                     type: "POST",
                     url: "module/status/status_list_modify_process.jsp",
                     data: $(this).serialize(),
                     cache: false,
                     success: function(d) {
                         $("#maincontent").empty();
                         $("#maincontent").html(d);
                         $("#maincontent").show();                            
                     },
                     complete: function(){
                         $("#loading").hide();
                         $.ajax({
                            type: 'POST',
                            url: "upload_list.jsp",
                            data: '',
                            success: function(d) {
                                $("#maincontent").empty();
                                $('#maincontent').html(d);
                                $("#maincontent").show();                
                            },
                            complete: function(){
                                $('#loading').hide();

                                if (statProcess === "OK") {
                                    new PNotify({title: '<%=actionText%> Data',text: 'SUCCESS: Data has been Confirmed..',type: 'success',styling: 'bootstrap3'});
                                } else {
                                    new PNotify({title: '<%=actionText%> Data',text: 'ERROR: Data Not Saved <br>'+statProcess,type: 'error',styling: 'bootstrap3'});
                                }
                            }
                            });
                      }});
                      ev.preventDefault();
                return false;
            });
            

            $("#goto_back").click(function() {
                                $("#loading").show();
                                $.ajax({
                                 type: "POST",
                                 url: "upload_list.jsp",
                                 data: "",
                                 cache:false,
                                 success: function(d) {
                                     $("#maincontent").empty();
                                     $("#maincontent").html(d);
                                     $("#maincontent").show();
                                 },
                                 complete: function(){
                                     $("#loading").hide();
                                  }
                              });
            });
        });
</script>
<!--<script type="text/javascript">
     $(document).ready(function() {
        $('#single_cal1').daterangepicker({
            singleDatePicker: true,
            calender_style: "picker_1"
            }, function(start, end, label) {
            console.log(start.toISOString(), end.toISOString(), label);
            });
    });
</script>-->

