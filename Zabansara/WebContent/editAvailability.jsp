<%@page import="model.Content"%>
<%@page import="utility.Constants"%>
<%@page import="model.Role"%>
<%@page import="model.User"%>
<%@page import="model.Term"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%
int termId = Integer.parseInt(request.getParameter("termId"));
Term term = Term.fetchTerm(termId);
User user = User.getCurrentUser(session);
String[] ScheduleTitles = Constants.ScheduleTitles;
int scheduleIdCounter = 1;
if(user != null && user.role == Role.TEACHER){
%>
						<form method="post" action="./availability">
						<input type="hidden" name="command" value="edit"></input>
						<input type="hidden" name="termId" value="<%out.print(term.id);%>"></input>
							<h3>
								<span><%out.print(term.title); %> </span>
							</h3>

							<div class="grid-x">

								<div class="large-12 cell">
									<div class="callout" style="padding: 5px; border: none">

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
											int teacherId = user.id;
											for(int scheduleId = scheduleIdCounter; scheduleId < scheduleIdCounter + 6; scheduleId ++){ %>
												<td class="tg-yw4l">
												<input name="<%out.print("schedule_"+scheduleId);%>" type="checkbox" 
												<%
												if(Term.isTeacherAvailable(termId, teacherId, scheduleId)){
													out.print("checked");
												}
												%>></td>
											<%} %>
												<td class="tg-yw4l" style="width: 85px"><b><%=scheduleTitle %></b></td>
											</tr>
											<%
												scheduleIdCounter += 6;
											} %>
										</table>
									</div>
								</div>
								<div class="large-12 cell"
									style="padding-right: 5px; float: left">
									<input type="submit" class="button" value="ذخيره" style="float: left"/>
								</div>
								<div class="large-12 cell">
									<%
									Content dayTimes = Content.fetchContent(Constants.AvailabilityContentID);
									%>
									<%=dayTimes.content %>
								</div>
								
							</div>
						</form>
						
<%
}
%>
</html>