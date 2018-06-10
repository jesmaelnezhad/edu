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

<html class="no-js" lang="fa" dir="rtl">
<head>
<meta charset="utf-8">
<meta http-equiv="x-ua-compatible" content="ie=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>زبان‌سرا</title>
<link rel="stylesheet" href="css/foundation.css">
<link rel="stylesheet" href="css/app.css">
<script src="js/jquery-3.3.1.min.js"></script>
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
		<%
			if (user == null || user.role != Role.ADMIN) {
				response.sendRedirect(request.getContextPath() + "/index.jsp");
				return;
			}
			request.setCharacterEncoding("UTF-8");
			String fnameSearch = request.getParameter("fnameSearch");
			String lnameSearch = request.getParameter("lnameSearch");
		%>
		<!-- -------------------------------------------- -->
		<!--  ----------------------------------------------- -->

		<div class="grid-x">

			<div class="large-12 medium-12 cell">
				<div class="callout">
					<h3>لیست افراد:</h3>
					<form method="post"
						action="<%out.print(request.getContextPath());%>/users.jsp">
						<div class="grid-x">
							<div class="large-4 cell">
								<input type="text" placeholder="جستجوی نام" name="fnameSearch"></input>
							</div>
							<div class="large-6 cell">
								<input type="text" placeholder="جستجوی نام خانوادگی"
									name="lnameSearch"></input>
							</div>
							<div class="large-2 cell">
								<input type="submit" class="button" value="جستجو"
									style="float: left"></input>
							</div>
						</div>
					</form>
					<table>
						<tr style="padding: 0px">
							<td style="padding: 2px">نقش</td>
							<td style="padding: 2px">نام کاربری</td>
							<td style="padding: 2px">نام</td>
							<td style="padding: 2px">تلفن</td>
							<td style="padding: 2px">آدرس ایمیل</td>
							<td style="padding: 2px">شماره ملی</td>
							<td style="padding: 2px">شماره زبان‌آموزی</td>
							<td style="padding: 2px"></td>
						</tr>
						<%
						List<User> users = User.fetchAllUsers(fnameSearch, lnameSearch);
						for(User u : users) {
						%>
						<tr style="padding: 0px;font-size:12px">
							<td style="padding: 2px">
								<%
									switch (u.role) {
										case ADMIN:
								%>ادمین<%
									break;
										case STUDENT:
								%>زبان‌آموز<%
									break;
										case TEACHER:
								%>مربی<%
									break;
										}
								%>
							</td>
							<td style="padding: 2px">
								<%
									out.print(u.username);
								%>
							</td>
							<td style="padding: 2px">
								<%
									out.print(u.fname + " " + u.lname);
								%>
							</td>
							<td style="padding: 2px">
								<%
									out.print(u.cellphone_number);
								%>
							</td>
							<td style="padding: 2px">
								<%
									out.print(u.email_addr);
								%>
							</td>
							<td style="padding: 2px">
								<%
									if (u.national_code != null) {
											out.print(u.national_code);
										}
								%>
							</td>
							<td style="padding: 2px">
								<%
									if (u.student_id != null) {
											out.print(u.student_id);
										}
								%>
							</td>
							<td style="padding: 2px;"><a
								href="<%out.print(request.getContextPath());%>/signin?secondaryLogin=true&userId=<%out.print(u.id);%>"
								class="button" style="margin: 0px;font-size:12px">ورود به حساب</a>
								<a href="#"
								class="alert button" style="margin: 0px;font-size:12px">حذف</a></td>
						</tr>
						<%
						}
						%>
					</table>

				</div>
			</div>
		</div>
		<!--------------------------------------------------- -->
	</div>

	<script src="js/vendor/jquery.js"></script>
	<script src="js/vendor/what-input.js"></script>
	<script src="js/vendor/foundation.js"></script>
	<script src="js/app.js"></script>


</body>
</html>