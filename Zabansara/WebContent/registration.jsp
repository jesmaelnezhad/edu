<%@page import="utility.Constants"%>
<%@page import="model.Content"%>
<%@page import="utility.Message"%>
<%@page import="model.Level"%>
<%@page import="model.Term"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html  lang="fa">
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

<script>
function changeClasses() {
	var termValue = document.getElementById("termSelectorInput").value;
	var levelValue = document.getElementById("levelSelectorInput").value;
	var genderValue = document.getElementById("genderSelectorInput").value;
	var xhttp = new XMLHttpRequest();
	xhttp.onreadystatechange = function() {
		if (this.readyState == 4 && this.status == 200) {
			document.getElementById("classes_table_container").innerHTML = this.responseText;
		}
	};
	xhttp.open("POST", "classSelector.jsp", true);
	xhttp.setRequestHeader("Content-type",
			"application/x-www-form-urlencoded");
	var parameters = "";
	if(termValue != 0){
		parameters += "termId=" + termValue;
	}
	if(levelValue != 0){
		if(parameters == ""){
			parameters += "levelId=" + levelValue;
		}else{
			parameters += "&levelId=" + levelValue;
		}
		
	}
	if(genderValue != 0){
		if(parameters == ""){
			parameters += "gender=" + genderValue;
		}else{
			parameters += "&gender=" + genderValue;	
		}
	}
	xhttp.send(parameters);
}
function onBodyLoad(){
	changeClasses();
}
</script>

  </head>
<body onload="onBodyLoad();" style="background-color:#e9e8e8">


<div dir="rtl">
	<%@include  file="./menu_general.jsp" %>
</div>


<!-- --------------------------------------------- -->
<div style="background-image:url('./images/background.jpg');width:1300px;height:100%">
    	<center>
    	
    	<div class="large-12 medium-12 cell" style="z-index:3;background-color:#FFFFFF;width:900px;margin-top:100px;border:none;" dir="rtl">
				<div class="callout" style="border:none;">

		<!-- ---------------------------------------------- -->
		
		<%
		if (user == null) {
			response.sendRedirect("./index.jsp");
			return;
		}
		int selected_termId = 0;
		if(session.getAttribute("selected_termId") != null){
			selected_termId = (Integer)session.getAttribute("selected_termId");
			session.removeAttribute("selected_termId");
		}
		%>
		<span id="messageContainer">
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
		</span>
		<div class="grid-x ">
			<div class="large-12 cell">
				<div class="callout" style="border:none;">
					<h3>ثبت نام در کلاس‌ها</h3>
					<!--  <label>اطلاعات زبان‌آموز</label>
					<div class="grid-x">
						<div class="large-4 cell" style="padding-left: 0px">
							<input type="text" placeholder="نام" />
						</div>
						<div class="large-4 cell" style="padding-left: 0px">
							<input type="text" placeholder="نام خانوادگی" />
						</div>
						<div class="large-4 cell"
							style="padding-right: 5px; padding-left: 0px">
							<label for="exampleFileUpload" class="button">آپلود عکس
								کارت ملی</label> <input type="file" id="exampleFileUpload"
								class="show-for-sr">
						</div>

					</div>
					<hr style="margin: 0px; padding: 0px; margin-bottom: 5px" /> -->

					<label>انتخاب کلاس</label>
					<div class="grid-x">
						<div class="large-3 cell" style="padding-left: 0px">
							<select name="term_selector" id="termSelectorInput"
								onchange="changeClasses();">
								<option value="0">انتخاب ترم</option>
								<%
									List<Term> terms = Term.fetchAllTerms();
									for (Term term : terms) {
								%>
								<option value="<%out.print(term.id);%>"
									<%if (selected_termId == term.id) {
										out.print("selected");
									}%>
								>
									<%
										out.print(term.title);
									%>
								</option>
								<%
									}
								%>
							</select>
						</div>
						<div class="large-3 cell" style="padding-left: 0px">
							<select name="levelId" id="levelSelectorInput"
								onchange="changeClasses();">
								<option value="0">انتخاب سطح</option>
								<%
									List<Level> levels = Level.fetchAllLevels();
									for (Level l : levels) {
								%>
								<option value="<%out.print(l.id);%>">
									<%
										out.print(l.title);
									%>
								</option>
								<%
									}
								%>
							</select>
						</div>
						<div class="large-3 cell" style="padding-left: 0px">
							<select name="gender" id="genderSelectorInput"
									onchange="changeClasses();">
								<option value="0">دخترانه یا پسرانه؟</option>
								<option value="1">دخترانه</option>
								<option value="2">پسرانه</option>
								<option value="3">مختلط</option>
							</select>
						</div>
						<div class="large-12 cell" id="classes_table_container">


						</div>
						<div class="large-12 cell">
							<%
							Content dayTimes = Content.fetchContent(Constants.AvailabilityContentID);
							%>
							<%=dayTimes.content %>
						</div>


					</div>
				</div>
			</div>
		</div>

	</div></div></center>
</div>
	<!-- ------------------------------- -->
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