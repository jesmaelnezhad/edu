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
<body style="background-color:#e9e8e8">
<div style="background-image:url('./images/background.jpg');width:1300px;height:100%">
<option value="0">انتخاب استاد</option>
<%
if(request.getParameter("termId") == null || request.getParameter("scheduleSelector") == null){
	return;
}
int termId = Integer.parseInt(request.getParameter("termId"));
int scheduleSelector = Integer.parseInt(request.getParameter("scheduleSelector"));
List<User> teachers = Term.fetchAvailableTeachers(termId, scheduleSelector);
for(User teacher : teachers){
	%><option value="<%out.print(teacher.id); %>"><%out.print(teacher.fname + " " + teacher.lname); %></option><%		
}
%>
</div>
</body>
</html>