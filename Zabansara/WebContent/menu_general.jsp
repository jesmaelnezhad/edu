<%@page import="model.Role"%>
<%@page import="model.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="fa">
<%
User user = User.getCurrentUser(session);
if(user == null){
%>
	<div class="top-bar">
	  <div class="top-bar-left">
	    <ul class="dropdown menu" data-dropdown-menu>
	      <li class="menu-text">زبان سرا</li>
			<li><a href="./index.jsp">صفحه‌ی اصلی</a></li>
			<li><a href="./news.jsp">مطالب و خبرها</a></li>
			<li><a href="./aboutus.jsp">درباره ما</a></li>
			<li><a href="./contactus.jsp">ارتباط به ما</a></li>

		</ul>
	  </div>
	  <div class="top-bar-right">
	    <ul class="menu">
	      <li><a type="button" class="button" href="signin.jsp" >ورود به سایت</a></li>
	    </ul>
	  </div>
	</div>
<%	
} else if(user.role == Role.ADMIN){
	%>
	<div class="top-bar">
	  <div class="top-bar-left">
	    <ul class="dropdown menu" data-dropdown-menu>
	      <li class="menu-text">زبان سرا</li>
			<li><a href="./index.jsp">صفحه‌ی اصلی</a></li>
			<li><a href="./news.jsp">مطالب و خبرها</a></li>
			<li><a href="">کاربر</a>
				<ul class="menu vertical">
					<li><a href="./profile.jsp">اطلاعات کاربر</a></li>
					<li><a href="./signup.jsp">عضویت در سایت</a></li>
					<li><a href="users.jsp">لیست کاربر‌ها</a></li>
				</ul></li>
			<li><a href="">آموزشی</a>
				<ul class="menu vertical">
					<li><a href="./terms.jsp">ترم‌ها و سطوح</a></li>
					<li><a href="./classes.jsp">کلاس‌ها</a></li>
					<li><a href="./term_schedule.jsp">زمان‌بندی امتحانات و ترم</a></li>
					<li><a href="./exams.jsp">آزمون‌های عمومی</a></li>
				</ul></li>
			<li><a href="./aboutus.jsp">درباره ما</a></li>
			<li><a href="./contactus.jsp">ارتباط به ما</a></li>

		</ul>
	  </div>
	  <div class="top-bar-right">
	    <ul class="menu">
	      	      <li>
	      	<a type="button" class="button" 
	      			href="<%out.print(request.getContextPath()); %>/signout" >
	      			<%
	      			if(User.isCurrentUserSecondary(session)){
	      				%>خروج از حساب کاربر<%
	      			}else{
	      				%>خروج از سیستم<%	      				
	      			}
	      			%>
	      	</a>
	      </li>
	    </ul>
	  </div>
	</div>
	
	<%
} else if(user.role == Role.TEACHER){
	%>
		<div class="top-bar">
	  <div class="top-bar-left">
	    <ul class="dropdown menu" data-dropdown-menu>
	      <li class="menu-text">زبان سرا</li>
			<li><a href="./index.jsp">صفحه‌ی اصلی</a></li>
			<li><a href="./profile.jsp">اطلاعات مربی</a></li>
			<li><a href="./classes.jsp">کلاس‌ها</a></li>
			<li><a href="">زمان‌بندی</a>
				<ul class="menu vertical">
					<li><a href="./availability.jsp">اعلام آمادگی</a></li>
					<li><a href="./term_schedule.jsp">تقویم ترم</a></li>
					<li><a href="./term_schedule.jsp">زمان‌بندی امتحانات و ترم</a></li>
				</ul></li>
			<li><a href="./news.jsp">مطالب و خبرها</a></li>
			<li><a href="./aboutus.jsp">درباره ما</a></li>
			<li><a href="./contactus.jsp">ارتباط به ما</a></li>

		</ul>
	  </div>
	  <div class="top-bar-right">
	    <ul class="menu">
	      	      <li>
	      	<a type="button" class="button" 
	      			href="<%out.print(request.getContextPath()); %>/signout" >
	      			<%
	      			if(User.isCurrentUserSecondary(session)){
	      				%>خروج از حساب کاربر<%
	      			}else{
	      				%>خروج از سیستم<%	      				
	      			}
	      			%>
	      	</a>
	      </li>
	    </ul>
	  </div>
	</div>
	
	
	<%
} else if(user.role == Role.STUDENT){
	%>
	
		<div class="top-bar">
	  <div class="top-bar-left">
	    <ul class="dropdown menu" data-dropdown-menu>
	      <li class="menu-text">زبان سرا</li>
			<li><a href="./index.jsp">صفحه‌ی اصلی</a></li>
			<li><a href="./news.jsp">مطالب و خبرها</a></li>
			<li><a href="./profile.jsp">اطلاعات کاربر</a></li>
			<li><a href="">آموزشی</a>
				<ul class="menu vertical">
					<li><a href="./registration.jsp"WebContent/menu_general.jsp"">ثبت‌نام</a></li>
					<li><a href="./classes.jsp">کلاس‌ها</a></li>
					<li><a href="./term_schedule.jsp">زمان‌بندی امتحانات و ترم</a></li>
					<li><a href="./exams.jsp">آزمون‌های عمومی</a></li>
				</ul></li>
			<li><a href="./aboutus.jsp">درباره ما</a></li>
			<li><a href="./contactus.jsp">ارتباط به ما</a></li>

		</ul>
	  </div>
	  <div class="top-bar-right">
	    <ul class="menu">
	      <li>
	      	<a type="button" class="button" 
	      			href="<%out.print(request.getContextPath()); %>/signout" >
	      			<%
	      			if(User.isCurrentUserSecondary(session)){
	      				%>خروج از حساب کاربر<%
	      			}else{
	      				%>خروج از سیستم<%	      				
	      			}
	      			%>
	      	</a>
	      </li>
	    </ul>
	  </div>
	</div>
	<%
} else{
	// not possible
}


%>

	
</html>
