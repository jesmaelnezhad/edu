<%@page import="model.Photo"%>
<%@page import="java.util.List"%>
<%@page import="utility.Message"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html lang="fa" >
  <head>
    <meta charset="utf-8">
    <meta http-equiv="x-ua-compatible" content="ie=edge">
    <meta name="description" content="">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>زبان‌سرا</title>
    <link rel="stylesheet" href="css/foundation.css">
    <link rel="stylesheet" href="css/app.css">
    <script src="js/jquery-3.3.1.min.js"></script>
    <script src="js/vendor/jquery.js"></script>
    <script src="js/vendor/foundation.js"></script>
  	<link rel="stylesheet" href="css/reveal.css">	
	<script type="text/javascript" src="http://code.jquery.com/jquery-1.6.min.js"></script>
	<script type="text/javascript" src="js/jquery.reveal.js"></script>
	
    <link rel="icon" href="img/core-img/favicon.ico">
    <link rel="stylesheet" href="style.css">
	
	 <style type="text/css">
	.tg  {border-collapse:collapse;border-spacing:0;direction:ltr}
	.tg td{font-family:Arial, sans-serif;font-size:12px;padding:5px 5px;border-style:solid;border-width:1px;overflow:hidden;word-break:normal;border-color:black;text-align:center}
	.tg th{font-family:Arial, sans-serif;font-size:12px;font-weight:normal;padding:5px 5px;border-style:solid;border-width:1px;overflow:hidden;word-break:normal;border-color:black;text-align:center}
	.tg .tg-yw4l{vertical-align:top}
	</style>
	
	<script type="text/javascript">
	function validateInputs() {
		if(! document.getElementById("photoTitleInput").value){
			document.getElementById("message").innerHTML = "<label style=\"color:red\">عنوان عكس را وارد کنید.</label>";
			return false;
		}
		if(! document.getElementById("imageFileUpload").value){
			document.getElementById("message").innerHTML = "<label style=\"color:red\">عنوان عكس را وارد کنید.</label>";
			return false;
		}
		return true;
	}
	</script>
  </head>
  <body style="background-color:#000000">

    <!-- <div class="grid-container"> -->

<!-- 
      <div class="grid-x grid-padding-x">
        <div class="large-12 cell">
          <h1>به زبان‌سرا خوش آمدید.</h1>
        </div>
      </div>
-->
<!--  --------------------------------------------- -->

<div dir="rtl">
	<%@include  file="./menu_general.jsp" %>
</div>


<!-- --------------------------------------------- -->

    <!-- ##### Hero Area Start ##### -->
    <section class="hero-area">
        <div class="hero-slides owl-carousel">
			
			<%
			List<Photo> allPhotos = Photo.fetchAllPhotos();
			for(Photo photo : allPhotos){
			%>
            <!-- Single Hero Slide -->
            <div class="single-hero-slide bg-img" style="background-image: url(<%=Photo.getPhotoPath("banners", photo.id, photo.photoName, getServletContext())%>);">
                <div class="container h-100">
                    <div class="row h-100 align-items-center" dir="rtl">
                        <div class="col-12 col-lg-9" dir="rtl">
                            <div class="hero-slides-content" dir="rtl" style="text-align:right">
                                <h2 data-animation="fadeInUp" data-delay="100ms"><%=photo.photoCaption %></h2>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <%
			}
            %>
        </div>
    </section>

<img src="https://trustseal.enamad.ir/logo.aspx?id=97283&amp;p=w57wMx2X8pS9eb2w" alt="" onclick="window.open(&quot;https://trustseal.enamad.ir/Verify.aspx?id=97283&amp;p=w57wMx2X8pS9eb2w&quot;, &quot;Popup&quot;,&quot;toolbar=no, location=no, statusbar=no, menubar=no, scrollbars=1, resizable=0, width=580, height=600, top=30&quot;)" style="cursor:pointer" id="w57wMx2X8pS9eb2w">

    <!-- ##### All Javascript Script ##### -->
    <!-- jQuery-2.2.4 js -->
    <script src="js/jquery/jquery-2.2.4.min.js"></script>
    <!-- Popper js -->
    <script src="js/bootstrap/popper.min.js"></script>
    <!-- Bootstrap js -->
    <script src="js/bootstrap/bootstrap.min.js"></script>
    <!-- All Plugins js -->
    <script src="js/plugins/plugins.js"></script>
    <!-- Active js -->
    <script src="js/active.js"></script>
    <!-- Live Chat Code :: Start of Tawk.to Script -->
    <script>
        var Tawk_API = Tawk_API || {},
            Tawk_LoadStart = new Date();
        (function() {
            var s1 = document.createElement("script"),
                s0 = document.getElementsByTagName("script")[0];
            s1.async = true;
            s1.src = 'https://embed.tawk.to/5b55ea72df040c3e9e0bdf85/default';
            s1.charset = 'UTF-8';
            s1.setAttribute('crossorigin', '*');
            s0.parentNode.insertBefore(s1, s0);
        })();
    </script>
    
    <%
    if(user != null && user.role == Role.ADMIN){
    	
    	%>
    	<center>
    	
    	<div class="large-12 medium-12 cell" style="z-index:3;background-color:#FFFFFF;width:900px;margin-top:100px" dir="rtl">
				<div class="callout">
					<h3>اضافه کردن عکس:</h3>
					<form method="post"
						action="./photos" enctype="multipart/form-data">
						<input type="hidden" name="command" value="add"/>
						<div class="grid-x">
							<div class="large-5 cell">
								<input type="text" placeholder="عنوان عکس" name="title"></input>
							</div>
							<div class="large-2 cell">
								<label >آپلود عکس</label>
							</div>
							<div class="large-4 cell">
							        <input type="file" name="image" id="selectedFile"/>
							</div>
							<div class="large-1 cell">
								<input type="submit" class="button" value="اضافه"
									style="float: left"></input>
							</div>
						</div>
					</form>
					<hr/>
					<h3 style="float:right">لیست عکسها:</h3>
					<hr/>
					<%
					for(Photo photo : allPhotos){
					%>
					<form method="post"
						action="./photos">
						<input type="hidden" name="command" value="remove"/>
						<input type="hidden" name="photoId" value="<%=photo.id%>"/>
					<div class="grid-x" align="right" >
							<div class="large-11 cell" style="background-color:#FFFFFF;height:40px;">
								<div style="margin-top:10px;margin-right:15px;"><%=photo.photoCaption %></div>
							</div>
							<div class="large-1 cell" style="float:left;background-color:#FFFFFF;height:40px;">
								<input type="submit" class="alert button" value="حذف"
									style="float: left"></input>
							</div>
						</div>
					</form>
					<%
					}
					%>
					<hr style="margin:0px;padding:0px;" />
			    </div>
	   </div>
    	
    	</center>
    	
    	<%
    }
    %>


</body>
</html>
