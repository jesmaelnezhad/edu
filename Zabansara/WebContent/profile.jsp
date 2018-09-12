<%@page import="model.Photo"%>
<%@page import="utility.Message"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html lang="fa">
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
  </head>
  <body style="background-color:#e9e8e8">


<!-- 
      <div class="grid-x grid-padding-x">
        <div class="large-12 cell">
          <h1>به زبان‌سرا خوش آمدید.</h1>
        </div>
      </div>
-->
<!-- --------------------------------------------- -->

<div dir="rtl">
	<%@include  file="./menu_general.jsp" %>
</div>


<!-- --------------------------------------------- -->
<div style="background-image:url('./images/background.jpg');width:1300px;height:100%">
    	<center>
    	
    	<div class="large-12 medium-12 cell" style="z-index:3;background-color:#FFFFFF;width:900px;margin-top:100px;border:none;" dir="rtl">
				<div class="callout" style="border:none;">

<!-- ---------------------------------------------- -->
<%
User currentUser = User.getCurrentUser(session);
if(currentUser == null){
	response.sendRedirect("./signin.jsp");
	return;
}
%>
<div class="large-12 medium-12 cell">
      <h3>اطلاعات کاربر:</h3>
	<div class="grid-x ">
		<div class="large-9 cell">
			<div class="grid-x">
				<div class="large-4 cell">
					<label>نام:</label>
					<%out.print(user.fname + " " + user.lname); %>
				</div>
				<div class="large-4 cell">
					<label>سطح دسترسی:</label>
					<%
						switch(user.role){
						case ADMIN:
							out.print("ادمین"); 
							break;
						case TEACHER:
							out.print("مربی"); 
							break;
						case STUDENT:
							out.print("زبان‌آموز"); 
							break;
						}
					%>
				</div>
				<div class="large-4 cell">
					<label>شماره زبان‌آموزی:</label>
					<%out.print(user.student_id); %>
				</div>
				<div class="large-4 cell">
					<label>شماره تلفن:</label>
					<%out.print(user.cellphone_number); %>
				</div>
				<div class="large-4 cell">
					<label>شماره ملی:</label>
					<%out.print(user.national_code); %>
				</div>
				<div class="large-4 cell">
					<label>آدرس ایمیل:</label>
					<%out.print(user.email_addr); %>
				</div>
				<div class="large-4 cell" style="margin-top:10px">
					<a href="<%out.print(Photo.getPhotoPath("users", user.id, user.photoName, request.getServletContext())); %>">مشاهده عکس کارت ملی</a>
				</div>
			</div>
		</div>
		<div class="large-3 cell">
			<img src="<%out.print(Photo.getPhotoPath("users", user.id, user.photoName2, request.getServletContext())); %>" />
		</div>
	</div>
	<hr style="margin:0px;padding:0px"/>
	<h5>تغییر رمز عبور:</h5>
	<form method="post" enctype="multipart/form-data" action="./profile">
		<input type="hidden" name="command" value="passchange"/>
		<% 
		if(session.getAttribute("message") != null){
			%><label style="color:<% out.print(((Message)session.getAttribute("message")).color);%>;">
			<%
			out.print(((Message)session.getAttribute("message")).message);
			session.removeAttribute("message");
			%>
			</label>
			<%
		}
		%>
		<div class="grid-x ">
				<%
				if(! User.isCurrentUserSecondary(request.getSession())){
					%>
					<div class="large-3 cell">
						<input type="password" placeholder="رمز فعلی" name="current_password" />
					</div>
					<%
				}
				%>
				<div class="large-3 cell">
					<input type="password" placeholder="رمز جدید" name="new_password" />
				</div>
				<div class="large-3 cell">
					<input type="password" placeholder="تکرار رمز جدید" name="new_password2"/>
				</div>
				<div class="large-3 cell">
					<input type="submit" class="button" value="تغییر" style="float:left" ></input>
				</div>
		</div>
	</form>
	
</div>



<!-- ---------------------------------------------- -->
      
    </div></div></center>
    </div>

    <script src="js/vendor/jquery.js"></script>
    <script src="js/vendor/what-input.js"></script>
    <script src="js/vendor/foundation.js"></script>
    <script src="js/app.js"></script>
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
</body>
</html>
