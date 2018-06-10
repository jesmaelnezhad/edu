<%@page import="model.Level"%>
<%@page import="java.util.List"%>
<%@page import="model.Term"%>
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
<%
if(user == null || user.role != Role.ADMIN){
	response.sendRedirect(request.getContextPath() + "/index.jsp");
	return;
}
%>
<!-- ---------------------------------------------- -->
<% 
if(session.getAttribute("message") != null){
	%><label style="color:<% out.print(((Message)session.getAttribute("message")).color);%>;">
	<%
	out.print(((Message)session.getAttribute("message")).message);
	session.removeAttribute("message");
	%>
	</label>
	<%
}
%>
<div class="grid-x ">
        <div class="large-12 cell">
          <div class="callout">
            <h3>ترم‌ها و سطوح </h3>
            <div class="grid-x">

		<div class="large-6 cell">
		<form method="post" enctype="multipart/form-data" action="<%out.print(request.getContextPath()); %>/terms">
			<input type="hidden" name="command" value="add"/>
		  <div class="callout" style="padding:5px;border:none">
		    <label>اضافه کردن ترم:</label>
		    <div class="grid-x">
		      <div class="large-6 cell" style="padding-left:0px">
			<input type="text" placeholder="نام ترم را وارد کنید." name="title"/>
		      </div>
		      <div class="large-6 cell" style="padding-left:0px">
		        <input type="text" placeholder="تاریخ شروع ترم" name="term_start"/>
		      </div>
		      <div class="large-6 cell" style="padding-left:0px">
		        <input type="text" placeholder="تاریخ شروع کلاس‌ها"  name="classes_start"/>
		      </div>
		      <div class="large-6 cell" style="padding-left:0px">
		        <input type="text" placeholder="تاریخ شروع فاينال ها" name="finals_start"/>
		      </div>
		      <div class="large-6 cell" style="padding-left:0px">
		        <input type="text" placeholder="تاریخ پایان ترم"  name="term_end"/>
		      </div>
		      <div class="large-2 cell" style="padding-right:5px">
				<input type="submit" class="button" value="ذخیره" style="float:left" ></input>
		      </div>
		    </div><hr style="margin:0px;padding:0px"/>
			<label>لیست ترم‌ها:</label>
			<table>
<% 
List<Term> termsList = Term.fetchAllTerms();
for(Term term : termsList){
%>
				<tr style="padding:0px">
					<td style="padding:2px"><%out.print(term.title); %></td>
					<td style="padding:2px;float:left" ><a href="#" class="alert button" style="margin:0px">حذف</a></td>
					<td style="padding:2px;float:left"><a href="#" class="button" style="margin:0px">تغییر</a></td>
					<td style="padding:2px;float:left"><a href="#" class="success button" style="margin:0px">زمان‌بندی</a></td>
				</tr>
<%
}
%>
			</table>
		  </div>
		  </form>
		</div>

		<div class="large-6 cell">
<form method="post" enctype="multipart/form-data" action="<%out.print(request.getContextPath()); %>/levels">
<input type="hidden" name="command" value="add"/>
		  <div class="callout" style="padding:5px;border-left:none;border-top:none;border-bottom:none">
		    <label>اضافه کردن سطح:</label>
	            <div class="grid-x">
		      <div class="large-9 cell" style="padding-left:0px">
		        <input type="text" placeholder="نام سطح را وارد کنید." name="title"/>
		      </div>
		      <div class="large-2 cell" style="padding-right:5px">
		        <input type="submit" class="button" value="ذخیره" style="float:left" ></input>
		      </div>
		    </div><hr style="margin:0px;padding:0px"/>
			<label>لیست سطوح:</label>
			<table>
<% 
List<Level> levelsList = Level.fetchAllLevels();
for(Level level : levelsList){
%>
				<tr style="padding:0px">
					<td style="padding:2px"><%out.print(level.title); %></td>
					<td style="padding:2px;float:left" ><a href="#" class="alert button" style="margin:0px">حذف</a></td>
					<td style="padding:2px;float:left"><a href="#" class="button" style="margin:0px">تغییر نام</a></td>
				</tr>
<%
}
%>
			</table>



		  </div>
</form>
		</div>

            </div>
          </div>
        </div>
      </div>



<!-- ---------------------------------------------- -->
      
    </div>

    <script src="js/vendor/jquery.js"></script>
    <script src="js/vendor/what-input.js"></script>
    <script src="js/vendor/foundation.js"></script>
    <script src="js/app.js"></script>
</body>
</html>
