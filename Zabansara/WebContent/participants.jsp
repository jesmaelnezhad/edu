<%@page import="java.util.ArrayList"%>
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
  	<link rel="stylesheet" href="css/reveal.css">	
	<script type="text/javascript" src="http://code.jquery.com/jquery-1.6.min.js"></script>
	<script type="text/javascript" src="js/jquery.reveal.js"></script>
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
			// type
			String type = "";
			if (request.getParameter("type") == null) {
				response.sendRedirect(request.getContextPath() + "/index.jsp");
				return;
			}else{
				type = request.getParameter("type");
			}
			// type has the value of 'class' or 'general_exam'
			TermClass termClass = null;
			Exam exam = null;
			List<User> participants = new ArrayList<>();
			if("class".equals(type)){
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
				if (user.role == Role.TEACHER && user.id != termClass.teacherId){
					request.getSession().setAttribute("message", new Message("شما به اطلاعات این کلاس دسترسی ندارید."));
					response.sendRedirect(request.getContextPath() + "/classes.jsp");
					return;
				}
				participants = TermClass.fetchClassParticipants(classId); 
			}else if("general_exam".equals(type)){
				// examId
				if (request.getParameter("examId") == null) {
					response.sendRedirect(request.getContextPath() + "/exams.jsp");
					return;
				}
				int examId = Integer.parseInt(request.getParameter("examId"));
				exam = Exam.fetchExam(examId);
				if(exam == null){
					request.getSession().setAttribute("message", new Message("امتحان پیدا نشد."));
					response.sendRedirect(request.getContextPath() + "/exams.jsp");
					return;
				}
				participants = Exam.fetchExamParticipants(exam);
			}
			
		%>
	<span id="message"> <%
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
						if("class".equals(type)){
						%>
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
						
						<div class="large-6 cell">
							<a href="./class.jsp?id=<%=termClass.id%>" style="float:left">بازگشت به صفحه‌ی کلاس</a>
						</div>
						
						<%
						}else if("general_exam".equals(type)){
						%>
						<div class="large-6 cell">
							<div class="callout" style="padding: 5px; border: none">
								<span>
									<h4>
										<%=exam.title%>
									</h4>
								</span>
							</div>
						</div>
						
						<div class="large-6 cell">
							<a href="./exams.jsp" style="float:left">بازگشت به صفحه‌ی آزمون‌ها</a>
						</div>
						<%
						}
						%>
						<div class="large-12 cell" id="participants_table_container">
							<hr style="margin: 0px; padding: 0px" />
							<label>لیست ثبت‌نامی‌ها:</label>
							<table>
								<tr style="padding:0px">
									<td style="padding:2px">شماره</td>
									<td style="padding:2px">نام زبان‌آموز</td>
									<td style="padding:2px">شماره زبان‌آموزی</td>
									<%
									if(user.role == Role.ADMIN){
										%>
										<td style="padding:2px"></td>
										<%
									}
									%>
								</tr>
								<%
								int i = 0;
								for(User participant : participants){
								%>
								<tr style="padding:0px" >
									<td style="padding:2px"><%=i+1 %></td>
									<td style="padding:2px"><%=participant.fname + " " + participant.lname %></td>
									<td style="padding:2px"><%=participant.student_id %></td>
									<%
									if(user.role == Role.ADMIN){
										%>
										<td style="padding:2px">
											<a href="#" data-reveal-id="removeRegistrationModal_<%=participant.id %>" 
											class="alert button" style="margin:0px;font-size:12px">
											<%
											if("class".equals(type)){
												%>حذف از کلاس<%
											}else if("general_exam".equals(type)){
												%>حذف از امتحان<%
											}
											%>
											</a>
											<div id="removeRegistrationModal_<%=participant.id %>" class="reveal-modal" style="position:fixed;">
													<form
														action="<%
														if("class".equals(type)){
															out.print(request.getContextPath() + "/register");
														}else if("general_exam".equals(type)){
															out.print(request.getContextPath() + "/exams");
														}

														
														%>"
														method="post">
														<input type="hidden" name="command" value="unregister" />
														<input type="hidden" name="userId" value="<%=participant.id%>" />
														<%
														if("class".equals(type)){
															%><input type="hidden" name="classId" value="<%=termClass.id%>" /><%
														}else if("general_exam".equals(type)){
															%><input type="hidden" name="examId" value="<%=exam.id%>" /><%
														}

														
														%> 
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
										<%
									}
									%>
								</tr>
								<%
									i++;
								}
								%>
							</table>
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
