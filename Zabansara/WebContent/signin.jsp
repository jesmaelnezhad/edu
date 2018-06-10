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
  <script>
  
  </script>
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
<div class="large-12 medium-12 cell">
	<div class="grid-x ">
		<div class="large-4 cell">
		</div>
		<div class="large-4 cell" >
			<div class="callout" style="border:none">
				<form method="post" action="<%out.print(request.getContextPath()); %>/signin">
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
					<input type="text" placeholder="نام کاربری" name="username"></input>
					<input type="password" placeholder="رمز عبور" name="password"></input>
					<input type="submit" class="button" value="ورود" style="float:left" ></input>
				</form>
			</div>
		</div>
		<div class="large-4 cell">
		</div>
	</div>
</div>


<!-- ---------------------------------------------- -->
      
    </div>

    <script src="js/vendor/jquery.js"></script>
    <script src="js/vendor/what-input.js"></script>
    <script src="js/vendor/foundation.js"></script>
    <script src="js/app.js"></script>
</body>
</html>
