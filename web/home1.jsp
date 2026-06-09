<%@include file="includes/check_auth_layer3.jsp"%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="Free coming soon template with jQuery countdown">
    <meta name="author" content="http://bootstraptaste.com">

    <title>Webuild </title>

    <!-- Bootstrap -->
    <!--<link href="../vendors/welcome/WeBuild/WeBuild/assets/css/bootstrap.css" rel="stylesheet">-->
	<!--<link href="../vendors/welcome/WeBuild/WeBuild/assets/css/bootstrap-theme.css" rel="stylesheet">-->
	<!--<link href="../vendors/welcome/WeBuild/WeBuild/assets/css/font-awesome.css" rel="stylesheet">-->

    <!-- siimple style -->
    <!--<link href="../vendors/welcome/WeBuild/WeBuild/assets/css/style.css" rel="stylesheet">-->
    
    <!-- =======================================================
        Theme Name: WeBuild
        Theme URL: https://bootstrapmade.com/free-bootstrap-coming-soon-template-countdwon/
        Author: BootstrapMade
        Author URL: https://bootstrapmade.com
    ======================================================= -->
  </head>

  <body>

	<div id="wrapper">
		<div class="container">
			<div class="row">
				<div class="col-md-12 ">
                                        <h1><b>In Progress..</b></h1>
					<h2 class="subtitle">We're working hard to improve our website and we'll ready to launch after</h2>
					<div id="countdown" height="100" width="100"></div>
<!--					<form class="form-inline signup" role="form">
					  <div class="form-group col-lg-offset-3">
					    <input type="email" class="form-control col-lg-offset-3" id="exampleInputEmail1" placeholder="Enter your email address">
					  </div>
					  <button type="submit" class="btn btn-theme col-lg-offset-3">Get notified!</button>
					</form>		
                    <div class="social col-lg-6 col-lg-offset-3">
                        <a href="#"><i class="fa fa-facebook" aria-hidden="true"></i></a>
                         <a href="#"><i class="fa fa-twitter" aria-hidden="true"></i></a>
                         <a href="#"><i class="fa fa-google-plus" aria-hidden="true"></i></a>
                         <a href="#"><i class="fa fa-linkedin" aria-hidden="true"></i></a>
                    </div>-->
				</div>
				
			</div>
				
		</div>
	</div>
    <!--<script src="https://code.jquery.com/jquery-1.10.2.min.js"></script>-->
    <!--<script src="../vendors/welcome/WeBuild/WeBuild/assets/js/bootstrap.min.js"></script>-->
	<script src="../vendors/welcome/WeBuild/WeBuild/assets/js/jquery.countdown.min.js"></script>
	<script type="text/javascript">
      $('#countdown').countdown('2017/01/01', function(event) {
        $(this).html(event.strftime('%w weeks %d days <br /> %H:%M:%S'));
      });
    </script>
    
</body>
</html>
