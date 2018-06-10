<%@page import="model.Level"%>
<%@page import="model.TermClass"%>
<%@page import="model.Term"%>
<%@page import="java.util.List"%>
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
    <script src="js/tinymce/tinymce.min.js"></script>
    <script>tinymce.init({ selector:'textarea' });</script>
<style type="text/css">
.tg  {border-collapse:collapse;border-spacing:0;direction:ltr}
.tg td{font-family:Arial, sans-serif;font-size:12px;padding:5px 5px;border-style:solid;border-width:1px;overflow:hidden;word-break:normal;border-color:black;text-align:center}
.tg th{font-family:Arial, sans-serif;font-size:12px;font-weight:normal;padding:5px 5px;border-style:solid;border-width:1px;overflow:hidden;word-break:normal;border-color:black;text-align:center}
.tg .tg-yw4l{vertical-align:top}
</style>
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
<script>
	function changeTerm(selectObject) {
		var value = selectObject.value;
		if (value == 0) {
			document.getElementById("form_container").innerHTML = "";
			return;
		}
		var xhttp = new XMLHttpRequest();
		xhttp.onreadystatechange = function() {
			if (this.readyState == 4 && this.status == 200) {
				document.getElementById("form_container").innerHTML = this.responseText;
			}
		};
		xhttp.open("POST", "addClass.jsp", true);
		xhttp.setRequestHeader("Content-type",
				"application/x-www-form-urlencoded");
		xhttp.send("termId=" + value);
	}
	function onBodyLoad() {
		var termSelector = document.getElementById("termSelectorInput");
		if (termSelector.value != 0) {
			changeTerm(termSelector);
		}
	}

	function updateTeachersList(selectObject, termId) {
		var value = selectObject.value;
		var xhttp = new XMLHttpRequest();
		xhttp.onreadystatechange = function() {
			if (this.readyState == 4 && this.status == 200) {
				document.getElementById("teacherSelectorInput").innerHTML = this.responseText;
			}
		};
		xhttp.open("POST", "teacherSelector.jsp", true);
		xhttp.setRequestHeader("Content-type",
				"application/x-www-form-urlencoded");
		xhttp.send("termId=" + termId + "&scheduleSelector=" + value);
	}
	function validateSelectors() {
		if (document.getElementById("scheduleSelectorInput").value == 0) {
			document.getElementById("addClassMessage").innerHTML = "<label style=\"color:red\">زمان‌بندی را انتخاب کنید</label>";
			return false;
		}
		if (document.getElementById("teacherSelectorInput").value == 0) {
			document.getElementById("addClassMessage").innerHTML = "<label style=\"color:red\">مربي را انتخاب کنید</label>";
			return false;
		}
		if (document.getElementById("genderSelectorInput").value == 0) {
			document.getElementById("addClassMessage").innerHTML = "<label style=\"color:red\">جنسیت را انتخاب کنید</label>";
			return false;
		}
		if (document.getElementById("levelSelectorInput").value == 0) {
			document.getElementById("addClassMessage").innerHTML = "<label style=\"color:red\">سطح را انتخاب کنید</label>";
			return false;
		}
		return true;
	}
</script>
</head>
<body onload="onBodyLoad()">

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
			request.setCharacterEncoding("UTF-8");
			if (request.getParameter("id") == null) {
				response.sendRedirect(request.getContextPath() + "/classes.jsp");
				return;
			}
			int classId = Integer.parseInt(request.getParameter("id"));
			TermClass termClass = TermClass.fetchClass(classId);
			if (termClass == null) {
				request.getSession().setAttribute("message", new Message("کلاس پیدا نشد."));
				response.sendRedirect(request.getContextPath() + "/classes.jsp");
				return;
			}
			if (user == null) {
				response.sendRedirect(request.getContextPath() + "/index.jsp");
				return;
			}
			if (user.role == Role.TEACHER && user.id != termClass.teacherId) {
				request.getSession().setAttribute("message", new Message("شما به اطلاعات این کلاس دسترسی ندارید."));
				response.sendRedirect(request.getContextPath() + "/classes.jsp");
				return;
			}
			if (user.role == Role.STUDENT && !TermClass.isRegisterred(user.id, termClass.id)) {
				request.getSession().setAttribute("message", new Message("شما به اطلاعات این کلاس دسترسی ندارید."));
				response.sendRedirect(request.getContextPath() + "/classes.jsp");
				return;
			}
		%>
	<span id="addClassMessage"> <%
 	if (session.getAttribute("message") != null) {
 %><label
		style="color:<%out.print(((Message) session.getAttribute("message")).color);%>;">
			<%
				out.print(((Message) session.getAttribute("message")).message);
					session.removeAttribute("message");
			%>
	</label> <%
 	}
 %>
	</span>
		<div class="grid-x ">
			<div class="large-12 cell">
				<div class="callout">
					<h3>اطلاعات کلاس</h3>
					<hr style="margin: 0px; padding: 0px" />
					<div class="grid-x">
						<div class="large-6 cell">
							<div class="callout" style="padding: 5px; border: none">
								<span>
									<label>سطح:</label>
									<h5>
										<%
											Level level = Level.fetchLevel(termClass.levelId);
											out.print(level.title);
										%>
									</h5>
								</span> <span>
									<label>زمان:</label>
									<h5>
										<%
											switch (termClass.scheduleId) {
											case 6:
										%>روزهای زوج - صبح - شیفت ۱<%
											break;
											case 5:
										%>روزهای زوج - صبح - شیفت ۲<%
											break;
											case 4:
										%>روزهای زوج - صبح - شیفت ۳<%
											break;
											case 3:
										%>روزهای زوج - بعد از ظهر - شیفت ۱<%
											break;
											case 2:
										%>روزهای زوج - بعد از ظهر - شیفت ۲<%
											break;
											case 1:
										%>روزهای زوج - بعد از ظهر - شیفت ۳<%
											break;
											case 12:
										%>روزهای فرد - صبح - شیفت ۱<%
											break;
											case 11:
										%>روزهای فرد - صبح - شیفت ۲<%
											break;
											case 10:
										%>روزهای فرد - صبح - شیفت ۳<%
											break;
											case 9:
										%>روزهای فرد - بعد از ظهر - شیفت ۱<%
											break;
											case 8:
										%>روزهای فرد - بعد از ظهر - شیفت ۲<%
											break;
											case 7:
										%>روزهای فرد - بعد از ظهر - شیفت ۳<%
											break;
											}
										%>
									</h5>
								</span> 
								<span>
									<label>استاد:</label>
									<h5>
									<%
									User teacher = User.fetchUser(termClass.teacherId);
									out.print(teacher.fname + " " + teacher.lname); 
									%></h5>
								</span>
							</div>
						</div>
							<%
							if(user.role == Role.STUDENT){
								%>
								<div class="large-2 cell"></div>
								<div class="large-4 cell">
									<table>
										<tr style="padding: 0px">
											<td style="padding: 2px;border-bottom:double"><strong>نمرات کلاسی</strong></td>
											<td style="padding: 2px;border-bottom:double">--</td>
											<td style="padding: 2px;border-bottom:double"></td>
										</tr>
										<tr>
											<td style="padding: 2px;border-bottom:double"><strong>میان‌ترم</strong></td>
											<td style="padding: 2px;border-bottom:double">--</td>
											<td style="padding: 2px;border-bottom:double"></td>
										</tr>
										<tr>
											<td style="padding: 2px;border-bottom:double"><strong>فاینال</strong></td>
											<td style="padding: 2px;border-bottom:double">--</td>
											<td style="padding: 2px;border-bottom:double"></td>
										</tr>
									</table>
								</div>
							<%
							}else{
							%>
						<div class="large-6 cell">
							<div class="callout"
								style="padding: 5px; border: none; float: left">
								<jsp:include page="./class_menu.jsp" >
								  <jsp:param name="classId" value="<%= classId %>" />
								</jsp:include>
							</div>
						</div>
							<%
							}
							%>

						<div class="large-12 cell">
						<hr style="margin: 0px; padding: 0px" />
						<%
						if(user.role == Role.TEACHER){
							%>
							<h5>مطالب صفحه‌ی کلاس:</h5>
							<form method="post" action="<%out.print(request.getContextPath()); %>/class">
							<input type="hidden" name="command" value="editContent"></input>
							<input type="hidden" name="classId" value="<%out.print(termClass.id);%>"></input>
							<div class="callout" style="padding: 5px; border: none">
								<div class="grid-x">
									<div class="large-12 cell"
										style="padding-right: 5px; float: left">
										<input style="float:left" type="submit" name="submit" class="button" value="ذخیره"/>
									</div>
									<div class="large-12 cell">
										<textarea name="content"><%out.print(termClass.content); %></textarea>
									</div>

								</div>
							</div>
							</form>
							<%
						}else{
							%>
							<div class="callout" style="padding: 5px; border: none">
								<div class="grid-x">
									<div class="large-12 cell">
										<%out.print(termClass.content); %>
									</div>

								</div>
							</div>
							<%
						}
						%>
						</div>


					</div>
				</div>
			</div>
		</div>



	</div>

	<script src="js/vendor/jquery.js"></script>
	<script src="js/vendor/what-input.js"></script>
	<script src="js/vendor/foundation.js"></script>
	<script src="js/app.js"></script>
</body>
</html>
