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
<link rel="stylesheet" href="css/reveal.css">	
<script type="text/javascript" src="http://code.jquery.com/jquery-1.6.min.js"></script>
<script type="text/javascript" src="js/jquery.reveal.js"></script>
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
							<td style="padding: 2px;">
							<a
								href="<%out.print(request.getContextPath());%>/signin?secondaryLogin=true&userId=<%out.print(u.id);%>"
								class="button" style="margin: 0px;font-size:12px">ورود به حساب</a>
								
															<a href="#" data-reveal-id="userChangeModal_<%=u.id%>"
								class="button" style="margin: 0px;font-size:12px">تغییر</a>
								<div id="userChangeModal_<%=u.id%>" class="reveal-modal"
									style="position: fixed;">
									<form method="post"
										action="<%out.print(request.getContextPath());%>/users"
										enctype='multipart/form-data'
										onsubmit="return validateInputs();">
										<input type="hidden" name="command" value="update" />
										<input type="hidden" name="userId" value="<%=u.id %>" />
										<div class="grid-x">
											<div class="large-3 cell">
												<select name="role_selector" id="roleSelectorInput"
													onchange="">
													<option value="0"<%=(u.role == Role.STUDENT?"selected":"") %>>زبان‌آموز</option>
													<option value="1" <%=(u.role == Role.TEACHER?"selected":"") %>>مربی</option>
													<option value="2" <%=(u.role == Role.ADMIN?"selected":"") %>>ادمین</option>
												</select>
											</div>
											<div class="large-3 cell">
												<input type="text" placeholder="نام" name="fname"
													id="fnameInput" value="<%=u.fname%>"></input>
											</div>
											<div class="large-4 cell">
												<input type="text" placeholder="نام خانوادگی" name="lname"
													id="lnameInput" value=<%=u.lname%> ></input>
											</div>
											<div class="large-3 cell">
												<input type="text" placeholder="شماره تلفن" name="cellphone"
													id="cellphoneInput" value=<%=u.cellphone_number%> ></input>
											</div>
											<div class="large-4 cell">
												<input type="text" placeholder="شماره ملی"
													name="national_code" id="nationalCodeInput" value=<%=u.national_code%> ></input>
											</div>
											<div class="large-5 cell">
												<input type="text" placeholder="آدرس ایمیل"
													name="email_addr" id="emailAddrInput" value=<%=u.email_addr%>></input>
											</div>
											<div class="large-12 cell"></div>
											<div class="large-3 cell">
												<label style="padding: 5px;">نام كاربري</label> <input
													type="text" disabled
													value="<%=u.username%>"></input>
											</div>
											<div class="large-2 cell" style="margin-right: 5px;"></div>
											<div class="large-5 cell" style="margin-right: 5px;">
												<label style="padding: 5px;" for="idImageFileUpload">آپلود
													عکس کارت ملی</label> <input style="padding: 5px;" type="file"
													name="id_image" id="idImageFileUpload">
											</div>
											<div class="large-5 cell" style="margin-right: 5px;">
												<label style="padding: 5px;" for="photoFileUpload">آپلود
													عکس پرسنلی</label> <input style="padding: 5px;" type="file"
													name="photo" id="photoFileUpload">
											</div>

											<div class="large-12 cell">
												<input type="submit" class="button" value="ذخیره"
													style="float: left"></input>
											</div>
										</div>
									</form>
									<a class="close-reveal-modal" aria-label="Close">&#215;</a>
								</div>
																
								<a href="#" data-reveal-id="userRemoveModal_<%=u.id %>" class="alert button" style="margin:0px;font-size:12px">حذف</a>
								<div id="userRemoveModal_<%=u.id %>" class="reveal-modal" style="position:fixed;">
										<form
											action="<%out.print(request.getContextPath() + "/users");%>"
											method="post">
											<input type="hidden" name="command" value="remove" /> 
											<input type="hidden" name="userId" value="<%=u.id%>" />
											<div class="grid-x ">
												<div class="large-9 cell" style="padding-left: 0px">آیا
													اطمینان دارید؟</div>
												<div class="large-1 cell" style="padding-right: 5px"
													float="left">
													<input type="submit" name="sunmit" value="بله، حذف کن."
														class="button"
														onclick="$('#myModal').foundation('reveal', 'close');" />
												</div>
											</div>
										</form>
										<a class="close-reveal-modal" aria-label="Close">&#215;</a>
								</div>
							</td>
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