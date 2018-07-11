<%@page import="model.Photo"%>
<%@page import="java.util.List"%>
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
    <script src="js/vendor/jquery.js"></script>
    <script src="js/vendor/foundation.js"></script>
  	<link rel="stylesheet" href="css/reveal.css">	
	<script type="text/javascript" src="http://code.jquery.com/jquery-1.6.min.js"></script>
	<script type="text/javascript" src="js/jquery.reveal.js"></script>
    <style type="text/css">
.tg  {border-collapse:collapse;border-spacing:0;direction:ltr}
.tg td{font-family:Arial, sans-serif;font-size:12px;padding:5px 5px;border-style:solid;border-width:1px;overflow:hidden;word-break:normal;border-color:black;text-align:center}
.tg th{font-family:Arial, sans-serif;font-size:12px;font-weight:normal;padding:5px 5px;border-style:solid;border-width:1px;overflow:hidden;word-break:normal;border-color:black;text-align:center}
.tg .tg-yw4l{vertical-align:top}
</style>
	
	<script type="text/javascript">
	function validateInputs() {
		if(! document.getElementById("photoTitleInput").value){
			document.getElementById("message").innerHTML = "<label style=\"color:red\">عنوان عكس را وارد کنید.</label>";
			return false;
		}
		if(! document.getElementById("imageFileUpload").value){
			document.getElementById("message").innerHTML = "<label style=\"color:red\">عنوان عكس را وارد کنید.</label>";
			return false;
		}
		return true;
	}
	</script>
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
<div class="orbit" role="region" aria-label="Information Pictures" data-orbit>
  <div class="orbit-wrapper">
    <div class="orbit-controls">
      <button class="orbit-previous"><span class="show-for-sr">Previous Slide</span>&#9664;&#xFE0E;</button>
      <button class="orbit-next"><span class="show-for-sr">Next Slide</span>&#9654;&#xFE0E;</button>
    </div>
    <ul class="orbit-container">
<% 
List<Photo> photos  = Photo.fetchAllPhotos();
for(Photo photo : photos){
%>
      <li class="orbit-slide">
        <figure class="orbit-figure">
          <img class="orbit-image" src="<%=Photo.getPhotoPath("banners", photo.id, photo.photoName, request.getServletContext()) %>" alt="Space">
          <figcaption class="orbit-caption"><%=photo.photoCaption %></figcaption>
        </figure>
      </li>
<%
}
%>
    </ul>
  </div>
</div>

</div>
<!-- ---------------------------------------------- -->
<%
if(user != null && user.role == Role.ADMIN){
%>
	<span id="message"> <%
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

		<div class="large-12 cell">
		  <div class="callout" style="padding:5px;border:none">
		    <label>اضافه کردن عکس:</label>
				<form method="post" enctype="multipart/form-data"
					action="<%out.print(request.getContextPath());%>/photos"
					onsubmit="return validateInputs();">
					<input type="hidden" name="command" value="add" />
					<div class="grid-x">
						<div class="large-5 cell" style="padding-left: 0px">
							<input type="text" id="photoTitleInput"
								placeholder="عنوان عکس را وارد کنید." name="title" />
						</div>
						<div class="large-4 cell" style="margin-right: 5px;">
							<input style="padding: 5px;" type="file" name="image"
								id="imageFileUpload">
						</div>
						<div class="large-2 cell" style="padding-right: 5px">
							<input type="submit" class="button" value="اضافه"
								style="float: left"></input>
						</div>
					</div>
					<hr style="margin: 0px; padding: 0px" />
				</form>
				<label>لیست عکس‌ها:</label>
			<table>
<% 
for(Photo photo : photos){
%>
				<tr style="padding:0px">
					<td style="padding:2px"><%=photo.photoCaption %></td>
					<td style="padding:2px;float:left" >
						<a href="#" data-reveal-id="photoRemoveModal_<%=photo.id %>" class="alert button" style="margin:0px">حذف</a>
						<div id="photoRemoveModal_<%=photo.id %>" class="reveal-modal" style="position:fixed;">
								<form
									action="<%out.print(request.getContextPath() + "/photos");%>"
									method="post">
									<input type="hidden" name="command" value="remove" /> <input
										type="hidden" name="photoId" value="<%=photo.id%>" />
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
				</tr>
<%
}
%>
			</table>
		  </div>

		</div>
		
		<%
}
%>
      
    </div>

    <script src="js/vendor/jquery.js"></script>
    <script src="js/vendor/what-input.js"></script>
    <script src="js/vendor/foundation.js"></script>
    <script src="js/app.js"></script>
</body>
</html>
