<%@page import="model.ExamType"%>
<%@page import="model.Exam"%>
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

		<!-- ---------------------------------------------- -->
		<%
			request.setCharacterEncoding("UTF-8");
			// command
			String command = "";
			if (request.getParameter("command") == null) {
				command = "view";
			}else{
				command = request.getParameter("command");
			}
			// type
			String type = "";
			if (request.getParameter("type") == null) {
				response.sendRedirect(request.getContextPath() + "/classes.jsp");
				return;
			}else{
				type = request.getParameter("type");
			}
			String examType = "";
			TermClass termClass = null;
			Exam exam = null;
			if("midterm".equals(type) || "final".equals(type) || "participation".equals(type)){
				examType = "class";
				// classId
				if (request.getParameter("classId") == null) {
					response.sendRedirect(request.getContextPath() + "/classes.jsp");
					return;
				}
				int classId = Integer.parseInt(request.getParameter("classId"));
				termClass = TermClass.fetchClass(classId);
				if (termClass == null) {
					request.getSession().setAttribute("message", new Message("کلاس پیدا نشد."));
					response.sendRedirect(request.getContextPath() + "/classes.jsp");
					return;
				}
				if (user == null || user.role == Role.STUDENT) {
					response.sendRedirect(request.getContextPath() + "/index.jsp");
					return;
				}
				if ((user.role == Role.TEACHER && user.id != termClass.teacherId) 
						|| (user.role == Role.ADMIN && "edit".equals(command)) ){
					request.getSession().setAttribute("message", new Message("شما به اطلاعات این کلاس دسترسی ندارید."));
					response.sendRedirect(request.getContextPath() + "/classes.jsp");
					return;
				}
				ExamType eType = Exam.convertFromString(type);
				exam = Exam.fetchClassExam(termClass.id, eType);
				if(exam == null){
					request.getSession().setAttribute("message", new Message("امتحان پیدا نشد."));
					response.sendRedirect(request.getContextPath() + "/class.jsp?id=" + termClass.id);
					return;
				}
			}else{
				// TODO
				examType = "general";
				// TODO: find the requested examId
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
					<div class="grid-x">
						<%
						if("class".equals(examType)){
						%>
						<div class="large-6 cell">
							<div class="callout" style="padding: 5px; border: none">
								<span>
									<h4>
										<%
										if("midterm".equals(type)){
											%>میان‌ترم<%
										}else if("final".equals(type)){
											%>فاینال<%
										}else if("participation".equals(type)){
											%>کلاسی<%
										}
										%>
									</h4>
								</span>
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
						
						<div class="large-6 cell">
							<a href="./class.jsp?id=<%=termClass.id%>" style="float:left">بازگشت به صفحه‌ی کلاس</a>
						</div>
						
						<%
						}else if("general".equals(examType)){
						%>
						
						<%
						}
						%>
						<div class="large-12 cell" id="grades_table_container">
						<hr style="margin: 0px; padding: 0px" />
						<%
						request.getSession().setAttribute("selected_exam", exam);
						if("view".equals(command)){
							%>
								
								<jsp:include page="./examView.jsp" >
								  <jsp:param name="examId" value="<%= exam.id %>" />
								</jsp:include>								
							<%
						}else if("edit".equals(command)){
							%>
								<jsp:include page="./examEdit.jsp" >
								  <jsp:param name="examId" value="<%= exam.id %>" />
								</jsp:include>								
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