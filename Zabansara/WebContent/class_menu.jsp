<%@page import="model.Role"%>
<%@page import="model.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="fa">
<%
User user = User.getCurrentUser(session);
if(request.getParameter("classId") == null){
	return;
}
int classId = Integer.parseInt(request.getParameter("classId"));
if(user == null){
		if (user == null) {
			response.sendRedirect(request.getContextPath() + "/index.jsp");
			return;
		}
} else if (user.role == Role.ADMIN) {
%>
<ul style="font-size:14px" class="dropdown menu" data-dropdown-menu>
	<li><a href="">ميانترم</a>
		<ul class="menu vertical">
			<li><a  href="./grades.jsp?classId=<%=classId%>&type=midterm&command=view">مشاهده</a></li>
		</ul></li>
	<li><a href="">پایان‌ترم</a>
		<ul class="menu vertical">
			<li><a href="./grades.jsp?classId=<%=classId%>&type=final&command=view">مشاهده</a></li>
		</ul></li>
	<li><a href="">نمرات کلاسی</a>
		<ul class="menu vertical">
			<li><a href="./grades.jsp?classId=<%=classId%>&type=participation&command=view">مشاهده</a></li>
		</ul></li>
	<li><a href="./participants.jsp?type=class&classId=<%=classId%>">لیست کلاسی</a></li>

</ul>

<%
	} else if (user.role == Role.TEACHER) {
%>
<ul style="font-size:14px" class="dropdown menu" data-dropdown-menu>
	<li><a href="">ميانترم</a>
		<ul class="menu vertical">
			<li><a  href="./grades.jsp?classId=<%=classId%>&type=midterm&command=view">مشاهده</a></li>
			<li><a href="./grades.jsp?classId=<%=classId%>&type=midterm&command=edit">تغییر</a></li>
		</ul></li>
	<li><a href="">پایان‌ترم</a>
		<ul class="menu vertical">
			<li><a href="./grades.jsp?classId=<%=classId%>&type=final&command=view">مشاهده</a></li>
			<li><a href="./grades.jsp?classId=<%=classId%>&type=final&command=edit">تغییر</a></li>
		</ul></li>
	<li><a href="">نمرات کلاسی</a>
		<ul class="menu vertical">
			<li><a href="./grades.jsp?classId=<%=classId%>&type=participation&command=view">مشاهده</a></li>
			<li><a href="./grades.jsp?classId=<%=classId%>&type=participation&command=edit">تغییر</a></li>
		</ul></li>
	<li><a href="./participants.jsp?type=class&classId=<%=classId%>">لیست کلاسی</a></li>
</ul>
	
	
	<%
} else if(user.role == Role.STUDENT){
	%>
	<%
} else{
	// not possible
}


%>

	
</html>
