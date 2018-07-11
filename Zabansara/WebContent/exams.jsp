<%@page import="model.Grade"%>
<%@page import="model.Exam"%>
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
    <script src="js/jquery-3.3.1.min.js"></script>
    <script src="js/vendor/jquery.js"></script>
    <script src="js/vendor/foundation.js"></script>
  	<link rel="stylesheet" href="css/reveal.css">	
	<script type="text/javascript" src="http://code.jquery.com/jquery-1.6.min.js"></script>
	<script type="text/javascript" src="js/jquery.reveal.js"></script>
    <style type="text/css">
.tg  {border-collapse:collapse;border-spacing:0;direction:ltr}
.tg td{font-family:Arial, sans-serif;font-size:12px;padding:5px 5px;border-style:solid;border-width:1px;overflow:hidden;word-break:normal;border-color:black;text-align:center}
.tg th{font-family:Arial, sans-serif;font-size:12px;font-weight:normal;padding:5px 5px;border-style:solid;border-width:1px;overflow:hidden;word-break:normal;border-color:black;text-align:center}
.tg .tg-yw4l{vertical-align:top}
</style>
<script>
	function validateInputs() {
		if(document.getElementById("examTitleInput").value == 0){
			document.getElementById("message").innerHTML = "<label style=\"color:red\">عنوان آزمون را وارد کنید.</label>";
			return false;
		}
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

<!-- ---------------------------------------------- -->
<%
	if (user == null || user.role == Role.TEACHER) {
		response.sendRedirect(request.getContextPath() + "/index.jsp");
		return;
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
	<%
	if(user.role == Role.ADMIN){
		%>
	  <form action="<%out.print(request.getContextPath() + "/exams");%>"
		onsubmit="return validateSelectors()" method="post">
		<input type="hidden" name="command" value="add" />
      <h3>اضافه کردن آزمون جدید:</h3>
      <div class="grid-x ">
	      <div class="large-6 cell" style="padding-left:0px">
		<input type="text" name="examTitle" placeholder="عنوان آزمون را اینجا وارد کنید." />
	      </div>
	      <div class="large-1 cell" style="padding-right:5px" float="left">
			<input type="submit" name="sunmit" value="ذخیره" class="button"/>
	      </div>
      </div>
      </form>
      <hr style="margin:0px;padding:0px" />
		<%
	}
	%>
      <h3>لیست آزمون های عمومی:</h3>
      <div class="grid-x ">
			<table>
			<%
			List<Exam> generalExams = Exam.fetchGeneralExams();
			for(Exam exam : generalExams){
				%>
				<tr style="padding:0px">
					<td style="padding:2px"> <%=exam.title %></td>
					<%
					if(user.role == Role.ADMIN){
						%>
						<td style="padding:2px;float:left" >
								<a href="#" data-reveal-id="examRemoveModal_<%=exam.id %>" class="alert button" style="margin:0px">حذف</a>
								<div id="examRemoveModal_<%=exam.id %>" class="reveal-modal" style="position:fixed;">
										<form
											action="<%out.print(request.getContextPath() + "/exams");%>"
											method="post">
											<input type="hidden" name="command" value="remove" /> 
											<input type="hidden" name="examId" value="<%=exam.id%>" />
											<div class="grid-x ">
												<div class="large-9 cell" style="padding-left: 0px">در صورت حذف آزمون تمام نمرات حذف خواهند شد. آیا
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
						<td style="padding:2px;float:left">
							<a href="#" data-reveal-id="examChangeModal_<%=exam.id %>" class="button" style="margin:0px">تغییر</a>
							<div id="examChangeModal_<%=exam.id %>" class="reveal-modal" style="position:fixed;">
							  <form action="<%out.print(request.getContextPath() + "/exams");%>"
								onsubmit="return validateSelectors()" method="post">
								<input type="hidden" name="command" value="update" />
								<input type="hidden" name="examId" value="<%=exam.id %>" />
						      <div class="grid-x ">
							      <div class="large-10 cell" style="padding-left:0px">
								<input type="text" name="examTitle" placeholder="عنوان آزمون را اینجا وارد کنید." value="<%=exam.title %>" />
							      </div>
							      <div class="large-1 cell" style="padding-right:5px" float="left">
									<input type="submit" name="sunmit" value="تغییر" class="button" onclick="$('#myModal').foundation('reveal', 'close');"/>
							      </div>
						      </div>
						      </form>
							  <a class="close-reveal-modal" aria-label="Close">&#215;</a>
							</div>
						</td>
						<td style="padding:2px;float:left">
							<a href="<%out.print(request.getContextPath() + "/grades.jsp?type=general&command=edit&examId=" + exam.id);%>" class="button" style="margin:0px">وارد کردن نمرات</a>
						</td>
						<td style="padding:2px;float:left">
							<a href="<%out.print(request.getContextPath() + "/grades.jsp?type=general&command=view&examId=" + exam.id);%>" class="success button" style="margin:0px">مشاهده نمرات</a>
						</td>
						<td style="padding:2px;float:left">
							<a href="<%out.print(request.getContextPath() + "/participants.jsp?type=general_exam&examId=" + exam.id);%>" class="success button" style="margin:0px">لیست کلاسی</a>
						</td>
						<%
					}else if(user.role == Role.STUDENT){
						if(Exam.isRegisterredInExam(exam, user)){
							Grade grade = Grade.fetchExamGrade(exam.id, user.id);
							%>
							<td style="padding:2px;float:left" >
								<%
								if(grade == null){
									%>نمره وارد نشده است.<%
								}else{
									out.print(grade.grade + " - " + grade.notes);
								}
								%>
								<a href="<%out.print(request.getContextPath() + "/exams?command=unregister&examId=" + exam.id);%>" class="alert button" style="margin:0px">خروج از آزمون</a>
							</td>
							<%
						}else{
							%>
							<td style="padding:2px;float:left" >
								<a href="<%out.print(request.getContextPath() + "/exams?command=register&examId=" + exam.id);%>" class="success button" style="margin:0px">ثبت‌نام</a>
							</td>							
							<%
						}
					}
					%>
				</tr>				
				<%
			}
			%>
			</table>
      </div>

    </div>

    <script src="js/vendor/jquery.js"></script>
    <script src="js/vendor/what-input.js"></script>
    <script src="js/vendor/foundation.js"></script>
    <script src="js/app.js"></script>
    <script>
 
   $(document).foundation();
       
    </script>
</body>
</html>
