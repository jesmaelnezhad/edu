<%@page import="model.AboutUs"%>
<%@page import="model.Photo"%>
<%@page import="utility.Message"%>
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
    <link rel="stylesheet" href="css/reveal.css">	
	<script type="text/javascript" src="http://code.jquery.com/jquery-1.6.min.js"></script>
	<script type="text/javascript" src="js/jquery.reveal.js"></script>
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
if(request.getParameter("id") != null){
	int id = Integer.parseInt(request.getParameter("id"));
	AboutUs aboutus = AboutUs.fetchAboutUs(id);
	if(aboutus == null){
		request.getSession().setAttribute("message", new Message("این درباره ما یافت نشد."));
		response.sendRedirect(request.getContextPath() + "/aboutus.jsp");
		return;
	}
	%>

    <center>
     <img src="<%=Photo.getPhotoPath("aboutus", aboutus.id, aboutus.photoName, request.getServletContext())%>"/>
    </center>

<%
}else{

if(user != null && user.role == Role.ADMIN){
%>
<form method="post" enctype="multipart/form-data" action="<%out.print(request.getContextPath()); %>/aboutus">
<input type="hidden" name="command" value="save"/>
      <h3>اضافه کردن درباره ما جدید:</h3>
      <div class="grid-x ">
	      <div class="large-5 cell" style="padding-left:0px">
		<input type="text" placeholder="عنوان منو را اینجا وارد کنید." name="menu_item"/>
	      </div>
	      <div class="large-3 cell" style="padding-right:5px;padding-left:0px">
		<input type="file" id="photoFileUpload" name="photo_file">
	      </div>
	      <div class="large-1 cell" style="padding-right:5px" float="left">
		<input type="submit" class="button" value="ذخیره" />
	      </div>
      </div>
</form>

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
      <h3>لیست منوهای درباره ما:</h3>
      <div class="grid-x ">
			<table>
<% 
List<AboutUs> aboutUsList = AboutUs.fetchAllAboutUs();
for(AboutUs aboutus : aboutUsList){
%>
				<tr style="padding:0px">
					<td style="padding:2px"><%out.print(aboutus.menu_item); %></td>
	<%
	if(user != null && user.role == Role.ADMIN){
	%>
					<td style="padding:2px;float:left" >
						<a href="#" data-reveal-id="aboutusRemoveModal_<%=aboutus.id %>" class="alert button" style="margin:0px">حذف</a>
						<div id="aboutusRemoveModal_<%=aboutus.id %>" class="reveal-modal" style="position:fixed;">
								<form
									action="<%out.print(request.getContextPath() + "/aboutus");%>"
									method="post">
									<input type="hidden" name="command" value="remove" /> <input
										type="hidden" name="aboutusId" value="<%=aboutus.id%>" />
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
					<td style="padding:2px;float:left">
							<a href="#" data-reveal-id="aboutusChangeModal_<%=aboutus.id %>" class="button" style="margin:0px">تغییر</a>
							<div id="aboutusChangeModal_<%=aboutus.id %>" class="reveal-modal" style="position:fixed;">
								<form method="post" enctype="multipart/form-data"
									action="<%out.print(request.getContextPath());%>/aboutus">
									<input type="hidden" name="command" value="update" /> <input
										type="hidden" name="aboutusId" value="<%=aboutus.id%>" />
										<label>تغییر درباره ما:</label>
									<div class="grid-x">
											<label>عنوان منو:</label>
									      <div class="large-12 cell" style="padding-left:0px">
										<input type="text" placeholder="عنوان منو را اینجا وارد کنید." name="menu_item" value="<%=aboutus.menu_item%>"/>
									      </div>
									      <div class="large-10 cell" style="padding-right:5px;padding-left:0px">
												<input type="file" id="photoFileUpload" name="photo_file">
									      </div>
									      <div class="large-1 cell" style="padding-right:5px" float="left">
										<input type="submit" class="button" value="ذخیره" />
									      </div>
									</div>
								</form>
								<a class="close-reveal-modal" aria-label="Close">&#215;</a>
							</div>
					</td>
	<%
	}
	%>
					<td style="padding:2px;float:left">
					<a href="<%=request.getContextPath() + "/aboutus.jsp?id=" + aboutus.id  %>" class="success button" style="margin:0px">مشاهده درباره ما</a>
					</td>
				</tr>
<%
}
%>
			</table>
      </div>

<%
}
%>

<%
}
%>

</div>
<!-- ---------------------------------------------- -->
      
    </div>

    <script src="js/vendor/jquery.js"></script>
    <script src="js/vendor/what-input.js"></script>
    <script src="js/vendor/foundation.js"></script>
    <script src="js/app.js"></script>
</body>
</html>