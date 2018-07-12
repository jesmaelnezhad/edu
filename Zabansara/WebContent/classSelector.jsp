<%@page import="utility.Constants"%>
<%@page import="model.TermClass"%>
<%@page import="model.Gender"%>
<%@page import="model.User"%>
<%@page import="model.Term"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>
<%
String [] ScheduleTitles = Constants.ScheduleTitles;
int scheduleIdCounter = 1;
%>
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
		<%
		for(String scheduleTitle : ScheduleTitles){
		%>
		<tr>
			<%
			for(int scheduleId=scheduleIdCounter; scheduleId < scheduleIdCounter + 6; scheduleId++){
			%>
				<td class="tg-yw4l" >
					<%
					int termId = 0;
					if(request.getParameter("termId") != null){
						termId = Integer.parseInt(request.getParameter("termId"));
					}
					int levelId = 0;
					if(request.getParameter("levelId") != null){
						levelId = Integer.parseInt(request.getParameter("levelId"));
					}
					Gender gender = null;
					int genderId = 0;
					if(request.getParameter("gender") != null){
						genderId = Integer.parseInt(request.getParameter("gender"));
						switch(genderId){
						case 1:
							gender = Gender.GIRLS;
							break;
						case 2:
							gender = Gender.BOYS;
							break;
						case 3:
							gender = Gender.BOTH;
							break;
						}
					}
					List<TermClass> termClasses = TermClass.searchClasses(scheduleId, termId, levelId, gender);
					for(TermClass c: termClasses){
						User teacher = User.fetchUser(c.teacherId);
						%>
							<a class="button" style="padding:5px;margin:5px"  href="register?classId=<%out.print(c.id); %>" >
							<%out.print(teacher.lname); %> - <%out.print(TermClass.getClassSize(c.id)); %>
							</a>
						<%
					}
					%>
				</td>
			<%
			}
			%>
			<td class="tg-yw4l" style="width: 85px"><b><%=scheduleTitle %></b></td>
		</tr>
		<%
			scheduleIdCounter += 6;
		} %>
	</table>

</body>
</html>