<%@page import="utility.Message"%>
<%@page import="model.Level"%>
<%@page import="model.Term"%>
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
<body onload="onBodyLoad();">

	<div class="grid-container">

		<!-- --------------------------------------------- -->

		<div class="large-12 medium-12 cell">
			<%@include file="./menu_general.jsp"%>
		</div>

		<!-- ---------------------------------------------- -->
		
		<%
		if (user == null) {
			response.sendRedirect(request.getContextPath() + "/index.jsp");
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
				<div class="callout">
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


					</div>
				</div>
			</div>
		</div>

	</div>

	<!-- ------------------------------- -->
	<script src="js/vendor/jquery.js"></script>
	<script src="js/vendor/what-input.js"></script>
	<script src="js/vendor/foundation.js"></script>
	<script src="js/app.js"></script>

</body>
</html>