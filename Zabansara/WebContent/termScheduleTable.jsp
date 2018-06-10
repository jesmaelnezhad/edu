<%@page import="model.Term"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%
int termId = Integer.parseInt(request.getParameter("termId"));
Term term = Term.fetchTerm(termId);
%>
            <h3><span><%out.print(term.title); %> </span></h3>

            <div class="grid-x">

		<div class="large-12 cell">
		  <div class="callout" style="padding:5px;border:none">

			<table>
				<tr style="padding:0px">
					<td style="padding:2px"><strong>اتفاقات ترم</strong></td>
					<td style="padding:2px"><strong>تاریخ</strong></td>

				</tr>
				<tr style="padding:0px" >
					<td style="padding:2px">شروع ترم</td>
					<td style="padding:2px"><%out.print(term.termStart); %></td>
				</tr>
				<tr>
					<td style="padding:2px">شروع کلاس‌ها</td>
					<td style="padding:2px"><%out.print(term.classesStart); %></td>
				</tr>
				<tr>
					<td style="padding:2px">شروع فاینال‌ها</td>
					<td style="padding:2px"><%out.print(term.finalsStart); %></td>
				</tr>
								<tr>
					<td style="padding:2px">پایان ترم</td>
					<td style="padding:2px"><%out.print(term.termEnd); %></td>
				</tr>
			</table>
		  </div>
		</div>


            </div>
</html>