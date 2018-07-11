<%@page import="model.Photo"%>
<%@page import="utility.Message"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html class="no-js" lang="fa" dir="rtl">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="x-ua-compatible" content="ie=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>زبان‌سرا</title>
    <link rel="stylesheet" href="css/foundation.css">
    <link rel="stylesheet" href="css/app.css">
    <script src="js/jquery-3.3.1.min.js"></script> 
  </head>
  <body>

    <div class="grid-container">

<!-- 
      <div class="grid-x grid-padding-x">
        <div class="large-12 cell">
          <h1>به زبان‌سرا خوش آمدید.</h1>
        </div>
      </div>
-->
<!-- --------------------------------------------- -->

<div class="large-12 medium-12 cell">
	<%@include file="./menu_general.jsp"%>
</div>

<!-- ---------------------------------------------- -->
<%
User currentUser = User.getCurrentUser(session);
if(currentUser == null){
	response.sendRedirect(request.getContextPath() + "/signin.jsp");
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
	<form method="post" enctype="multipart/form-data" action="<%out.print(request.getContextPath()); %>/profile">
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
      
    </div>

    <script src="js/vendor/jquery.js"></script>
    <script src="js/vendor/what-input.js"></script>
    <script src="js/vendor/foundation.js"></script>
    <script src="js/app.js"></script>
</body>
</html>
