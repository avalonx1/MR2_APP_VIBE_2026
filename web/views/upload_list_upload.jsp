<%@include file="/includes/javascript.jsp"%>
<%@include file="/includes/css_load.jsp"%>
<link href="../vendors/google-code-prettify/bin/prettify.min.css" rel="stylesheet">
<link href="../vendors/bootstrap-daterangepicker/daterangepicker.css" rel="stylesheet">

<style>
    body {
        background: linear-gradient(135deg, #5D1689 0%, #310650 100%);
        min-height: 100vh;
        margin: 0;
        padding: 15px;
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    }
    .upload-card {
        background: #ffffff;
        border-radius: 12px;
        box-shadow: 0 8px 32px rgba(0,0,0,0.3);
        max-width: 560px;
        margin: 20px auto;
        overflow: hidden;
    }
    .upload-card-header {
        background: linear-gradient(135deg, #5D1689 0%, #7B1FA2 100%);
        padding: 18px 24px;
        color: white;
        font-size: 1.1em;
        font-weight: 600;
        letter-spacing: 0.5px;
        display: flex;
        align-items: center;
        gap: 10px;
        border-bottom: 3px solid #FFD700;
    }
    .upload-card-header i {
        font-size: 1.3em;
    }
    .upload-card-body {
        padding: 24px;
    }
    .info-grid {
        background: #f8f5fb;
        border-radius: 8px;
        padding: 16px 20px;
        margin-bottom: 20px;
        border-left: 4px solid #7B1FA2;
    }
    .info-grid p {
        margin: 8px 0;
        font-size: 0.95em;
        color: #333;
    }
    .info-grid p b {
        color: #5D1689;
    }
    .form-section {
        margin-bottom: 20px;
    }
    .form-section label {
        font-weight: 600;
        color: #444;
        margin-bottom: 6px;
        display: block;
        font-size: 0.95em;
    }
    .form-section label i {
        margin-right: 6px;
        color: #7B1FA2;
    }
    .input-group-addon {
        background: #7B1FA2;
        color: white;
        border: none;
    }
    .input-group-addon i {
        font-size: 1.1em;
    }
    .form-control {
        border-radius: 6px;
        border: 1px solid #d0d0d0;
        padding: 10px 14px;
        height: auto;
        font-size: 0.95em;
        transition: border-color 0.3s, box-shadow 0.3s;
    }
    .form-control:focus {
        border-color: #7B1FA2;
        box-shadow: 0 0 0 3px rgba(123, 31, 162, 0.15);
    }
    .file-upload-wrapper {
        position: relative;
        margin-bottom: 6px;
    }
    .file-upload-wrapper .custom-file-upload {
        border: 2px dashed #c5b0d6;
        border-radius: 8px;
        padding: 28px 20px;
        text-align: center;
        cursor: pointer;
        transition: all 0.3s;
        background: #faf8fc;
    }
    .file-upload-wrapper .custom-file-upload:hover {
        border-color: #7B1FA2;
        background: #f3edf7;
    }
    .file-upload-wrapper .custom-file-upload i {
        font-size: 2.5em;
        color: #7B1FA2;
        display: block;
        margin-bottom: 8px;
    }
    .file-upload-wrapper .custom-file-upload span {
        color: #666;
        font-size: 0.9em;
    }
    .file-upload-wrapper .custom-file-upload .filename {
        color: #5D1689;
        font-weight: 600;
        margin-top: 6px;
        display: none;
    }
    .file-upload-wrapper input[type="file"] {
        display: none;
    }
    .btn-upload {
        background: linear-gradient(135deg, #5D1689 0%, #7B1FA2 100%);
        border: none;
        border-radius: 8px;
        padding: 12px 24px;
        font-size: 1em;
        font-weight: 600;
        letter-spacing: 0.5px;
        color: white;
        width: 100%;
        transition: all 0.3s;
        box-shadow: 0 4px 15px rgba(93, 22, 137, 0.35);
    }
    .btn-upload:hover {
        transform: translateY(-2px);
        box-shadow: 0 6px 20px rgba(93, 22, 137, 0.45);
        background: linear-gradient(135deg, #6B1A99 0%, #8B24B2 100%);
        color: white;
    }
    .btn-upload:active {
        transform: translateY(0);
    }
    .btn-upload i {
        margin-right: 8px;
    }
    .footer-note {
        text-align: center;
        margin-top: 16px;
        font-size: 0.82em;
        color: #999;
    }
    /* Datepicker customization */
    .daterangepicker {
        border-radius: 10px;
        box-shadow: 0 8px 30px rgba(0,0,0,0.2);
    }
    .daterangepicker td.active, .daterangepicker td.active:hover {
        background-color: #7B1FA2 !important;
    }
    .daterangepicker td.in-range {
        background-color: #e8d5f0 !important;
    }
    .daterangepicker .calendar-table table tr td {
        border-radius: 4px;
    }
</style>

<%
String actionText = "Upload & Konfirmasi";
String v_month = request.getParameter("p_month");
String v_institusi = request.getParameter("p_institusi");
String v_laporan = request.getParameter("p_name");
String v_sub_rpt = request.getParameter("p_sub");
String v_main_rpt = request.getParameter("p_main");
String v_file = request.getParameter("p_file");
String v_nik_upload = request.getParameter("p_nik");
String v_date = request.getParameter("p_date");

System.out.println("NIK user upload = " + v_nik_upload);
System.out.println("Month = " + v_month);
System.out.println("Institusi = " + v_institusi);
System.out.println("Nama report = " + v_laporan);
System.out.println("Main report = " + v_main_rpt);
System.out.println("Sub report = " + v_sub_rpt);
System.out.println("Date Upload  = " + v_date);
System.out.println("Upload file = " + v_file);
%>

<div class="upload-card">
    <div class="upload-card-header">
        <i class="fa fa-cloud-upload"></i>
        Upload & Konfirmasi Dokumen
    </div>

    <div class="upload-card-body">
        <form id="form" action="../Upload_File" method="post" enctype="multipart/form-data">

            <!-- Info Laporan -->
            <div class="info-grid">
                <p><i class="fa fa-file-text-o" style="color:#7B1FA2; width:18px;"></i> Nama Laporan : <b><%=v_laporan%></b></p>
                <p><i class="fa fa-calendar" style="color:#7B1FA2; width:18px;"></i> Bulan : <b><%=v_month%></b></p>
                <p><i class="fa fa-building-o" style="color:#7B1FA2; width:18px;"></i> Tujuan Institusi : <b><%=v_institusi%></b></p>
            </div>

            <!-- Tanggal Upload -->
            <div class="form-section">
                <label><i class="fa fa-calendar-check-o"></i>Submitted Report Date</label>
                <div class="input-group">
                    <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                    <input type="text" class="form-control" id="single_cal1" required="required"
                           name="p_date" placeholder="Pilih tanggal upload"
                           value="<% out.println((v_date == null) ? "" : v_date); %>">
                </div>
            </div>

            <!-- Hidden Fields -->
            <input type="hidden" id="p_sub" name="p_sub" value="<%=v_sub_rpt%>" />
            <input type="hidden" id="p_main" name="p_main" value="<%=v_main_rpt%>" />
            <input type="hidden" id="p_name" name="p_name" value="<%=v_laporan%>" />
            <input type="hidden" id="p_month" name="p_month" value="<%=v_month%>" />
            <input type="hidden" id="p_institusi" name="p_institusi" value="<%=v_institusi%>" />
            <input type="hidden" id="p_nik" name="p_nik" value="<%=v_nik_upload%>" />

            <!-- File Upload -->
            <div class="form-section">
                <label><i class="fa fa-files-o"></i>Pilih File Dokumen</label>
                <div class="file-upload-wrapper">
                    <div class="custom-file-upload" onclick="document.getElementById('filecover').click();">
                        <i class="fa fa-file-pdf-o"></i>
                        <span>Drag & drop file di sini, atau klik untuk memilih</span>
                        <div class="filename" id="filename-display">Tidak ada file dipilih</div>
                    </div>
                    <input type="file" id="filecover" name="filecover" onchange="updateFileName(this)" />
                </div>
            </div>

            <!-- Submit -->
            <button type="submit" class="btn btn-upload">
                <i class="fa fa-upload"></i> UPLOAD & KONFIRMASI
            </button>

            <div class="footer-note">
                <i class="fa fa-info-circle"></i> Pastikan data yang diupload sudah benar
            </div>

        </form>
    </div>
</div>

<script type="text/javascript">
    $(document).ready(function() {
        // Date Range Picker
        $('#single_cal1').daterangepicker({
            singleDatePicker: true,
            calender_style: "picker_1",
            locale: {
                format: 'DD/MM/YYYY',
                daysOfWeek: ['Min', 'Sen', 'Sel', 'Rab', 'Kam', 'Jum', 'Sab'],
                monthNames: ['Januari','Februari','Maret','April','Mei','Juni','Juli','Agustus','September','Oktober','November','Desember']
            }
        });

        // Show datepicker on icon click
        $('.input-group-addon').click(function() {
            $('#single_cal1').focus();
        });
    });

    // Show filename when file selected
    function updateFileName(input) {
        var display = document.getElementById('filename-display');
        if (input.files && input.files.length > 0) {
            var fileName = input.files[0].name;
            var fileSize = (input.files[0].size / 1024).toFixed(1);
            display.textContent = fileName + ' (' + fileSize + ' KB)';
            display.style.display = 'block';
            display.style.color = '#5D1689';
        } else {
            display.textContent = 'Tidak ada file dipilih';
            display.style.display = 'none';
        }
    }
</script>
