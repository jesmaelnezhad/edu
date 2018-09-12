<%@page import="model.Level"%>
<%@page import="java.util.List"%>
<%@page import="model.Term"%>
<%@page import="utility.Message"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html lang="fa" >
  <head>
    <meta charset="utf-8">
    <meta http-equiv="x-ua-compatible" content="ie=edge">
    <meta name="description" content="">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>زبان‌سرا</title>
    <link rel="stylesheet" href="css/foundation.css">
    <link rel="stylesheet" href="css/app.css">
    <script src="js/jquery-3.3.1.min.js"></script>
    <script src="js/vendor/jquery.js"></script>
    <script src="js/vendor/foundation.js"></script>
  	<link rel="stylesheet" href="css/reveal.css">	
	<script type="text/javascript" src="http://code.jquery.com/jquery-1.6.min.js"></script>
	<script type="text/javascript" src="js/jquery.reveal.js"></script>
	
    <link rel="icon" href="img/core-img/favicon.ico">
    <link rel="stylesheet" href="style.css">
	
	 <style type="text/css">
	.tg  {border-collapse:collapse;border-spacing:0;direction:ltr}
	.tg td{font-family:Arial, sans-serif;font-size:12px;padding:5px 5px;border-style:solid;border-width:1px;overflow:hidden;word-break:normal;border-color:black;text-align:center}
	.tg th{font-family:Arial, sans-serif;font-size:12px;font-weight:normal;padding:5px 5px;border-style:solid;border-width:1px;overflow:hidden;word-break:normal;border-color:black;text-align:center}
	.tg .tg-yw4l{vertical-align:top}
	</style>
  </head>
  <body style="background-color:#e9e8e8">


<!-- 
      <div class="grid-x grid-padding-x">
        <div class="large-12 cell">
          <h1>به زبان‌سرا خوش آمدید.</h1>
        </div>
      </div>
-->
<!-- --------------------------------------------- -->
<!--  --------------------------------------------- -->

<div dir="rtl">
	<%@include  file="./menu_general.jsp" %>
</div>


<!-- --------------------------------------------- -->
<div style="background-image:url('./images/background.jpg');width:1300px;height:100%">
    	<center>
    	
    	<div class="large-12 medium-12 cell" style="z-index:3;background-color:#FFFFFF;width:900px;margin-top:100px;border:none;" dir="rtl">
				<div class="callout" style="border:none;">
<%
if(user == null || user.role != Role.ADMIN){
	response.sendRedirect("./index.jsp");
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
          <div class="callout" style="border:none;">
            <h3>ترم‌ها و سطوح </h3>
            <div class="grid-x">

		<div class="large-6 cell">
		  <div class="callout" style="padding:5px;border:none">
		  <form method="post" enctype="multipart/form-data" 
		  action="./terms">
			<input type="hidden" name="command" value="add"/>
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
		    </div>
		    </form>
		    <hr style="margin:0px;padding:0px"/>
			<label>لیست ترم‌ها:</label>
			<table>
<% 
List<Term> termsList = Term.fetchAllTerms();
for(Term term : termsList){
%>
				<tr style="padding:0px">
					<td style="padding:2px"><%out.print(term.title); %></td>
					<td style="padding:2px;float:left" >
						<a href="#" data-reveal-id="termRemoveModal_<%=term.id %>" class="alert button" style="margin:0px">حذف</a>
						<div id="termRemoveModal_<%=term.id %>" class="reveal-modal" style="position:fixed;">
								<form
									action="<%out.print("./terms");%>"
									method="post">
									<input type="hidden" name="command" value="remove" /> <input
										type="hidden" name="termId" value="<%=term.id%>" />
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
							<a href="#" data-reveal-id="termChangeModal_<%=term.id %>" class="button" style="margin:0px">تغییر</a>
							<div id="termChangeModal_<%=term.id %>" class="reveal-modal" style="position:fixed;">
								<form method="post" enctype="multipart/form-data"
									action="./terms">
									<input type="hidden" name="command" value="update" /> <input
										type="hidden" name="termId" value="<%=term.id%>" />
										<label>تغییر ترم:</label>
									<div class="grid-x">
										<div class="large-6 cell" style="padding-left: 0px">
											<label>نام ترم:</label>
											<input type="text" placeholder="نام ترم را وارد کنید."
												name="title" value="<%=term.title%>"/>
										</div>
										<div class="large-6 cell" style="padding-left: 0px">
											<label>تاریخ شروع ترم:</label>
											<input type="text" placeholder="تاریخ شروع ترم"
												name="term_start" value="<%=term.termStart%>"/>
										</div>
										<div class="large-6 cell" style="padding-left: 0px">
											<label>تاریخ شروع کلاس‌ها:</label>
											<input type="text" placeholder="تاریخ شروع کلاس‌ها"
												name="classes_start" value="<%=term.classesStart%>"/>
										</div>
										<div class="large-6 cell" style="padding-left: 0px">
											<label>تاریخ شروع فاينال‌ها:</label>
											<input type="text" placeholder="تاریخ شروع فاينال ها"
												name="finals_start" value="<%=term.finalsStart%>" />
										</div>
										<div class="large-6 cell" style="padding-left: 0px">
											<label>تاریخ پایان ترم:</label>
											<input type="text" placeholder="تاریخ پایان ترم"
												name="term_end" value="<%=term.termEnd%>" />
										</div>
										<div class="large-6 cell" style="padding-right: 5px;margin-top:25px">
											<input type="submit" class="button" value="تغییر"
												style="float: left"></input>
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

		<div class="large-6 cell">
		  <div class="callout" style="padding:5px;border-left:none;border-top:none;border-bottom:none">
		  	<form method="post" enctype="multipart/form-data" action="./levels">
			<input type="hidden" name="command" value="add"/>
		    <label>اضافه کردن سطح:</label>
	        <div class="grid-x">
		      <div class="large-5 cell" style="padding-left:0px">
		        <input type="text" placeholder="نام سطح را وارد کنید." name="title"/>
		      </div>
		      <div class="large-4 cell" style="padding-left:0px">
		        <input type="text" placeholder="هزینه." name="price"/>
		      </div>
		      <div class="large-2 cell" style="padding-right:5px">
		        <input type="submit" class="button" value="ذخیره" style="float:left" ></input>
		      </div>
		    </div>
		    </form>
		    <hr style="margin:0px;padding:0px"/>
			<label>لیست سطوح:</label>
			<table>
<% 
List<Level> levelsList = Level.fetchAllLevels();
for(Level level : levelsList){
%>
				<tr style="padding:0px">
					<td style="padding:2px"><%out.print(level.title); %></td>
					<td style="padding:2px"><%out.print(level.price); %></td>
					<td style="padding:2px;float:left" >
						<a href="#" data-reveal-id="levelRemoveModal_<%=level.id %>" class="alert button" style="margin:0px">حذف</a>
						<div id="levelRemoveModal_<%=level.id %>" class="reveal-modal" style="position:fixed;">
								<form
									action="<%out.print("./levels");%>"
									method="post">
									<input type="hidden" name="command" value="remove" /> <input
										type="hidden" name="levelId" value="<%=level.id%>" />
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
							<a href="#" data-reveal-id="levelChangeModal_<%=level.id %>" class="button" style="margin:0px">تغییر</a>
							<div id="levelChangeModal_<%=level.id %>" class="reveal-modal" style="position:fixed;">
							  <form action="<%out.print("./levels");%>"
								onsubmit="return validateSelectors()" method="post">
								<input type="hidden" name="command" value="update" />
								<input type="hidden" name="levelId" value="<%=level.id %>" />
						      <div class="grid-x ">
							      <div class="large-6 cell" style="padding-left:0px">
								<input type="text" name="levelTitle" placeholder="عنوان سطح را اینجا وارد کنید." value="<%=level.title %>" />
							      </div>
							      <div class="large-4 cell" style="padding-left:0px">
								<input type="text" name="levelPrice" placeholder="هزینه سطح را اینجا وارد کنید." value="<%=level.price %>" />
							      </div>
							      <div class="large-1 cell" style="padding-right:5px" float="left">
									<input type="submit" name="sunmit" value="تغییر" class="button" onclick="$('#myModal').foundation('reveal', 'close');"/>
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

            </div>
          </div>
        </div>
      </div>



<!-- ---------------------------------------------- -->
      
    </div></div></center>
    
    </div>

    <script src="js/vendor/jquery.js"></script>
    <script src="js/vendor/what-input.js"></script>
    <script src="js/vendor/foundation.js"></script>
    <script src="js/app.js"></script>
    <!-- ##### All Javascript Script ##### -->
    <!-- jQuery-2.2.4 js -->
    <script src="js/jquery/jquery-2.2.4.min.js"></script>
    <!-- Popper js -->
    <script src="js/bootstrap/popper.min.js"></script>
    <!-- Bootstrap js -->
    <script src="js/bootstrap/bootstrap.min.js"></script>
    <!-- All Plugins js -->
    <script src="js/plugins/plugins.js"></script>
    <!-- Active js -->
    <script src="js/active.js"></script>
    <!-- Live Chat Code :: Start of Tawk.to Script -->
    <script>
        var Tawk_API = Tawk_API || {},
            Tawk_LoadStart = new Date();
        (function() {
            var s1 = document.createElement("script"),
                s0 = document.getElementsByTagName("script")[0];
            s1.async = true;
            s1.src = 'https://embed.tawk.to/5b55ea72df040c3e9e0bdf85/default';
            s1.charset = 'UTF-8';
            s1.setAttribute('crossorigin', '*');
            s0.parentNode.insertBefore(s1, s0);
        })();
    </script>
</body>
</html>
