<%@page import="model.News"%>
<%@page import="java.util.List"%>
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
    <script src="js/tinymce/tinymce.min.js"></script>
    <script>tinymce.init({ selector:'textarea' });</script>
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
		<%@include  file="./menu_general.jsp" %>
      </div>

<!-- ---------------------------------------------- -->
<div class="large-12 medium-12 cell">

<%
if(user != null && user.role == Role.ADMIN){
%>
<form method="post" enctype="multipart/form-data" action="<%out.print(request.getContextPath()); %>/news">
<input type="hidden" name="command" value="save"/>
      <h3>اضافه کردن مطلب جدید:</h3>
      <div class="grid-x ">
	      <div class="large-9 cell" style="padding-left:0px">
		<input type="text" placeholder="عنوان مطلب را اینجا وارد کنید." name="title"/>
	      </div>
	      <div class="large-2 cell" style="padding-right:5px;padding-left:0px">
		<label for="photoFileUpload" class="button">آپلود عکس</label>
		<input type="file" id="photoFileUpload" class="show-for-sr" name="photo_file">
	      </div>
	      <div class="large-1 cell" style="padding-right:5px" float="left">
		<input type="submit" class="button" value="ذخیره" />
	      </div>
	      <div class="large-12 cell">
		   <textarea name="news_content">
		   <%
		   String newsContent = (String)session.getAttribute("news_content");
		   if(newsContent != null){
			   session.removeAttribute("news_content");
			   out.print(newsContent);
		   }else{
			   %>
		   متن خبر جدید را اینجا وارد کنید.
			   <%
		   }
		   %>
		   </textarea>
	      </div>
      </div>
</form>
<%
}
%>
      <h3>لیست مطالب:</h3>
      <div class="grid-x ">
			<table>
<% 
List<News> newsList = News.fetchAllNews();
for(News news : newsList){
%>
				<tr style="padding:0px">
					<td style="padding:2px"><%out.print(news.title); %></td>
	<%
	if(user != null && user.role == Role.ADMIN){
	%>
					<td style="padding:2px;float:left" ><a href="#" class="alert button" style="margin:0px">حذف</a></td>
					<td style="padding:2px;float:left"><a href="#" class="button" style="margin:0px">تغییر</a></td>
	<%
	}
	%>
					<td style="padding:2px;float:left"><a href="#" class="success button" style="margin:0px">مشاهده مطلب</a></td>
				</tr>
<%
}
%>
			</table>
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
