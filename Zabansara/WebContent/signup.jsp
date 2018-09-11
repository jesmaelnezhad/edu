<%@page import="model.Role"%>
<%@page import="model.TermClass"%>
<%@page import="utility.Message"%>
<%@page import="model.Level"%>
<%@page import="model.User"%>
<%@page import="model.Term"%>
<%@page import="java.util.List"%>
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
<style type="text/css">
.tg {
	border-collapse: collapse;
	border-spacing: 0;
	direction: ltr
}

.tg td {
	font-family: Arial, sans-serif;
	font-size: 12px;
	padding: 5px 5px;
	border-style: solid;
	border-width: 1px;
	overflow: hidden;
	word-break: normal;
	border-color: black;
	text-align: center
}

.tg th {
	font-family: Arial, sans-serif;
	font-size: 12px;
	font-weight: normal;
	padding: 5px 5px;
	border-style: solid;
	border-width: 1px;
	overflow: hidden;
	word-break: normal;
	border-color: black;
	text-align: center
}

.tg .tg-yw4l {
	vertical-align: top
}
</style>
<script type="text/javascript">
function validateInputs() {
//	if(document.getElementById("roleSelectorInput").value == 0){
//		document.getElementById("messageContainer").innerHTML = "<label style=\"color:red\"></label>";
//		return false;
//	}
	if(! document.getElementById("fnameInput").value){
		document.getElementById("messageContainer").innerHTML = "<label style=\"color:red\">نام را وارد کنید.</label>";
		return false;
	}
	if(! document.getElementById("lnameInput").value){
		document.getElementById("messageContainer").innerHTML = "<label style=\"color:red\">نام خانوادگی را وارد کنید</label>";
		return false;
	}
	if(! document.getElementById("cellphoneInput").value){
		document.getElementById("messageContainer").innerHTML = "<label style=\"color:red\">شماره تلفن را وارد کنید.</label>";
		return false;
	}
	if(! document.getElementById("nationalCodeInput").value){
		document.getElementById("messageContainer").innerHTML = "<label style=\"color:red\">شماره ملی را وارد کنید.</label>";
		return false;
	}
	if(! document.getElementById("emailAddrInput").value){
		document.getElementById("messageContainer").innerHTML = "<label style=\"color:red\">آدرس ایمیل را وارد کنید.</label>";
		return false;
	}
	if(! document.getElementById("idImageFileUpload").value){
		document.getElementById("messageContainer").innerHTML = "<label style=\"color:red\">آپلود عکس کارت ملی الزامیست.</label>";
		return false;
	}
	if(! document.getElementById("photoFileUpload").value){
		document.getElementById("messageContainer").innerHTML = "<label style=\"color:red\">آپلود عکس پرسونلی الزامیست.</label>";
		return false;
	}
	return true;
}
</script>
</head>
<body style="background-color:#000000">


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
    	<center>
    	
    	<div class="large-12 medium-12 cell" style="z-index:3;background-color:#FFFFFF;width:900px;margin-top:100px" dir="rtl">
				<div class="callout">
		<%
		if(user == null || user.role != Role.ADMIN){
			response.sendRedirect("./index.jsp");
			return;
		}
		%>
		<!-- ---------------------------------------------- -->
		<span id="messageContainer">
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
		</span>
		
		<!-- -------------------------------------------- -->
		<!--  ----------------------------------------------- -->

		<div class="grid-x">

			<div class="large-12 medium-12 cell">
				<div class="callout">

					<h3>اضافه کردن کاربر:</h3>
					<form method="post"
						action="./users"
						enctype='multipart/form-data' onsubmit="return validateInputs();">
						<input type="hidden" name="command" value="add"/>
						<div class="grid-x">
							<div class="large-2 cell">
								<select name="role_selector" id="roleSelectorInput"
									onchange="">
									<option value="0">زبان‌آموز</option>
									<option value="1">مربی</option>
									<option value="2">ادمین</option>
								</select>
							</div>
							<div class="large-2 cell">
								<input type="text" placeholder="نام" name="fname" id="fnameInput"></input>
							</div>
							<div class="large-3 cell">
								<input type="text" placeholder="نام خانوادگی" name="lname" id="lnameInput"></input>
							</div>
							<div class="large-2 cell">
								<input type="text" placeholder="شماره تلفن" name="cellphone" id="cellphoneInput"></input>
							</div>
							<div class="large-3 cell">
								<input type="text" placeholder="شماره ملی" name="national_code" id="nationalCodeInput"></input>
							</div>
							<div class="large-4 cell">
								<input type="text" placeholder="آدرس ایمیل" name="email_addr" id="emailAddrInput"></input>
							</div>
							<div class="large-12 cell">
							</div>
							<div class="large-2 cell">
								<label style="padding:5px;" >نام كاربري</label>
								<input type="text" disabled 
								value="<%out.print(User.getNewUserID());%>"></input>
								<input type="hidden" name="username" 
								value="<%out.print(User.getNewUserID());%>"></input>
							</div>
							<div class="large-1 cell" style="margin-right:5px;">
							</div>
							<div class="large-4 cell" style="margin-right:5px;">
								<label style="padding:5px;"for="idImageFileUpload" >آپلود عکس کارت ملی</label>
								<input style="padding:5px;" type="file" name="id_image" id="idImageFileUpload" >
							</div>	
							<div class="large-4 cell" style="margin-right:5px;">
								<label style="padding:5px;" for="photoFileUpload">آپلود عکس پرسنلی</label>
								<input style="padding:5px;" type="file" name="photo" id="photoFileUpload" >
							</div>							
							
							<div class="large-12 cell">
								<input type="submit" class="button" value="ذخیره"
									style="float: left"></input>
							</div>
						</div>
					</form>
				</div>
			</div>
		</div>
		<!--------------------------------------------------- -->
	</div></div></center>

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