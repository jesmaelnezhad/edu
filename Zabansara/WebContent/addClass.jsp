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
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script>

</script>
</head>
<body>
	<%
		if (request.getParameter("termId") == null) {
			return;
		}
		int termId = Integer.parseInt(request.getParameter("termId"));
		User user = User.getCurrentUser(session);
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
	<%
		if (user != null && user.role == Role.ADMIN) {
	%>
	<form action="<%out.print(request.getContextPath() + "/class");%>"
		onsubmit="return validateSelectors()" method="post">
		<input type="hidden" name="command" value="add" /> <input
			type="hidden" name="termId" value="<%out.print(termId);%>" /> <label>اضافه
			کردن کلاس:</label>
		<div class="grid-x">
			<div class="large-4 cell" style="padding-left: 0px">
				<select name="scheduleId" id="scheduleSelectorInput"
					onchange="updateTeachersList(this,<%out.print(termId);%>);">
					<option value="0">انتخاب زمان کلاس</option>
					<option value="6">روزهای زوج - صبح - شیفت ۱</option>
					<option value="5">روزهای زوج - صبح - شیفت ۲</option>
					<option value="4">روزهای زوج - صبح - شیفت ۳</option>
					<option value="3">روزهای زوج - بعد از ظهر - شیفت ۱</option>
					<option value="2">روزهای زوج - بعد از ظهر - شیفت ۲</option>
					<option value="1">روزهای زوج - بعد از ظهر - شیفت ۳</option>
					<option value="12">روزهای فرد - صبح - شیفت ۱</option>
					<option value="11">روزهای فرد - صبح - شیفت ۲</option>
					<option value="10">روزهای فرد - صبح - شیفت ۳</option>
					<option value="9">روزهای فرد - بعد از ظهر - شیفت ۱</option>
					<option value="8">روزهای فرد - بعد از ظهر - شیفت ۲</option>
					<option value="7">روزهای فرد - بعد از ظهر - شیفت ۳</option>
				</select>
			</div>
			<div class="large-4 cell" style="padding-left: 0px">
				<select name="teacherId" id="teacherSelectorInput">
					<option value="0">انتخاب استاد</option>
				</select>
			</div>
			<div class="large-3 cell" style="padding-left: 0px">
				<select name="gender" id="genderSelectorInput">
					<option value="0">دختران یا پسران</option>
					<option value="girls">دختران</option>
					<option value="boys">پسران</option>
					<option value="both">مختلط</option>
				</select>
			</div>

			<div class="large-3 cell" style="padding-left: 0px">
				<select name="levelId" id="levelSelectorInput">
					<option value="0">انتخاب سطح</option>
					<%
						List<Level> levels = Level.fetchAllLevels();
							for (Level l : levels) {
					%>
					<option value="<%out.print(l.id);%>">
						<%
							out.print(l.title);
						%>
					</option>
					<%
						}
					%>
				</select>
			</div>
			<div class="large-7 cell" style="padding-left: 0px">
				<input type="text" name="notes" placeholder="توضیحات" />
			</div>

			<div class="large-2 cell" style="padding-right: 5px">
				<input type="submit" class="button" style="float: left"
					value="ذخیره" />
			</div>
		</div>
	</form>
	<hr style="margin: 0px; padding: 0px" />
	<!-- -------------------------------------------- -->

	<h5>زمان‌های آمادگی اساتید</h5>
	<div class="grid-x">

		<div class="large-12 cell">

			<table class="tg">
				<thead>
					<th class="tg-yw4l" colspan="3"><b>بعد از ظهر</b></th>
					<th class="tg-yw4l" colspan="3"><b>صبح</b></th>
					<th class="tg-yw4l"></th>
				</thead>
				<thead>
					<td class="tg-yw4l">شیفت ۳</td>
					<td class="tg-yw4l">شیفت ۲</td>
					<td class="tg-yw4l">شیفت ۱</td>
					<td class="tg-yw4l">شیفت ۳</td>
					<td class="tg-yw4l">شیفت ۲</td>
					<td class="tg-yw4l">شیفت ۱</td>
					<td class="tg-yw4l"></td>
				</thead>
				<tr>
					<%
						for (int scheduleId = 1; scheduleId < 7; scheduleId++) {
					%>
					<td class="tg-yw4l" id="even_2_3">
						<%
							List<User> availableTeachers = Term.fetchAvailableTeachers(termId, scheduleId);
									for (int i = 0; i < availableTeachers.size(); ++i) {
						%><div>
							<%
								out.print(availableTeachers.get(i).lname);
							%>
						</div> <%
 	if (i != availableTeachers.size() - 1) {
 %><hr style="margin: 0px; padding: 0px" /> <%
 	}
 			}
 %>

					</td>
					<%
						}
					%>
					<td class="tg-yw4l" style="width: 85px"><b>روزهای زوج</b></td>
				</tr>
				<tr>
					<%
						for (int scheduleId = 7; scheduleId < 13; scheduleId++) {
					%>
					<td class="tg-yw4l" id="even_2_3">
						<%
							List<User> availableTeachers = Term.fetchAvailableTeachers(termId, scheduleId);
									for (int i = 0; i < availableTeachers.size(); ++i) {
						%><div>
							<%
								out.print(availableTeachers.get(i).lname);
							%>
						</div> <%
 	if (i != availableTeachers.size() - 1) {
 %><hr style="margin: 0px; padding: 0px" /> <%
 	}
 			}
 %>

					</td>
					<%
						}
					%>
					<td class="tg-yw4l" style="width: 85px"><b>روزهای فرد</b></td>
				</tr>
			</table>
		</div>


	</div>

	<%
		}
	%>
	<!-- -------------------------------------------- -->
	<!--  ----------------------------------------------- -->
	<label>لیست کلاس‌ها:</label>
	<table>
		<tr style="padding: 0px">
			<td style="padding: 2px">سطح</td>
			<td style="padding: 2px">زمان</td>
			<td style="padding: 2px">استاد</td>
			<td style="padding: 2px">جنسیت</td>
			<td style="padding: 2px">تعداد دانشجو</td>
			<td style="padding: 2px">توضیحات</td>
			<%
				if (user != null && user.role == Role.ADMIN) {
			%><td style="padding: 2px"></td>
			<%
				}
			%>
			<td style="padding: 2px"></td>
		</tr>
		<%
			List<TermClass> termClasses = null;
			if (user != null && user.role == Role.ADMIN) {
				termClasses = TermClass.fetchAllClasses(termId);
			} else if (user != null && user.role == Role.TEACHER) {
				termClasses = TermClass.fetchTeacherClasses(termId, user.id);
			} else if (user != null && user.role == Role.STUDENT) {
				termClasses = TermClass.fetchStudentClasses(termId, user.id);
			}
			for (TermClass termClass : termClasses) {
				Level level = Level.fetchLevel(termClass.levelId);
				User teacher = User.fetchUser(termClass.teacherId);
		%>
		<tr style="padding: 0px">
			<td style="padding: 2px">
				<%
					out.print(level == null ? "" : level.title);
				%>
			</td>
			<td style="padding: 2px">
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
			</td>
			<td style="padding: 2px">
				<%
					out.print(teacher == null ? "" : teacher.fname + " " + teacher.lname);
				%>
			</td>
			<td style="padding: 2px">
				<%
					switch (termClass.gender) {
						case BOYS:
							out.print("پسران");
							break;
						case GIRLS:
							out.print("دختران");
							break;
						case BOTH:
							out.print("مختلط");
							break;
						}
				%>
			</td>
			<td style="padding: 2px">
				<%
					out.print(TermClass.getClassSize(termClass.id));
				%>
			</td>
			<td style="padding: 2px">
				<%
					out.print(termClass.note == null ? "" : termClass.note);
				%>
			</td>
			<%
				if (user != null && user.role == Role.ADMIN) {
			%>
			<td style="padding: 2px; float: left">
				<a href="#" data-reveal-id="classRemoveModal_<%=termClass.id %>" class="alert button" style="margin:0px">حذف</a>
				<div id="classRemoveModal_<%=termClass.id %>" class="reveal-modal" style="position:fixed;">
						<form
							action="<%out.print(request.getContextPath() + "/class");%>"
							method="post">
							<input type="hidden" name="command" value="remove" /> 
							<input type="hidden" name="classId" value="<%=termClass.id%>" />
							<input type="hidden" name="termId" value="<%=termId %>" />
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
			<td style="padding: 2px; float: left"><a
				href="<%out.print(request.getContextPath() + "/class.jsp?id=" + termClass.id);%>" class="success button"
				style="margin: 0px">مشاهده</a></td>
		</tr>
		<%
			}
		%>
	</table>
	<!--------------------------------------------------- -->

</body>
</html>