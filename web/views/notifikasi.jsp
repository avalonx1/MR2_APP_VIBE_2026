<%@include file="../includes/check_auth_layer3.jsp"%>
<%--<%@include file="../includes/javascript.jsp"%>--%>
<%--<%@include file="/includes/css_load.jsp"%>--%>
<link href="../vendors/google-code-prettify/bin/prettify.min.css" rel="stylesheet">
<style>
body {
    background-color: #93B874;
};
</style>

<body style="background-color:#6b005f; color:white">
    <div class="well" style="">
    <div class="col-md-9 col-sm-9 col-xs-12 col-md-offset-5 text-center aligncenter" align="center" style="height: 300px; font-size: 1.5em;">
        <p></p><br/><br/>
        <h2>UPLOAD DATA BERHASIL</h2>
        <p>Silahkan tekan tombol dibawah dan kembali ke halaman daftar laporan</p>
        <button type="submit" class="btn btn-warning btn-block" onclick="doBack()" align="center" ><span class="fa fa-check" aria-hidden="true"></span> FILE SUKSES TERSIMPAN! </button>
        <br/>
    </div>
    </div>
</body>
      
<script>
    // load previous pages
        function doBack() {
        if (window.opener) {
            window.opener.location.reload();
            window.opener.close();
            window.opener = null;
            }
        self.close();
        };
</script>

</html>
