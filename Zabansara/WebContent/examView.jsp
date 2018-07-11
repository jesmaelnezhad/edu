<%@page import="model.Grade"%>
<%@page import="model.User"%>
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
<%
request.setCharacterEncoding("UTF-8");
if (request.getParameter("examId") == null) {
	return;
}
int examId = Integer.parseInt(request.getParameter("examId"));
Exam exam = null;
if(request.getSession().getAttribute("selected_exam") != null){
	exam = (Exam)request.getSession().getAttribute("selected_exam");
	request.getSession().removeAttribute("selected_exam");
}else{
	exam = Exam.fetchExam(examId);
}
%>
			<label>لیست نمرات:</label>
			<table>
				<tr style="padding:0px">
					<td style="padding:2px">شماره</td>
					<td style="padding:2px">نام دانشجو</td>
					<td style="padding:2px">نمره</td>
					<td style="padding:2px">توضیحات</td>
				</tr>
				<%
				List<User> examParticipants = Exam.fetchExamParticipants(exam);
				for(int i = 0; i < examParticipants.size(); ++i){
					User participant = examParticipants.get(i);
					Grade g = Grade.fetchExamGrade(exam.id, participant.id);
				%>
				<tr style="padding:0px" >
					<td style="padding:2px"><%=i+1 %></td>
					<td style="padding:2px"><%=participant.fname + " " + participant.lname %></td>
					<td style="padding:2px"><%=(g==null?"--":g.grade) %></td>
					<td style="padding:2px"><%=(g==null?"--":g.notes) %></td>
				</tr>
				<%
				}
				%>
			</table>
</html>
