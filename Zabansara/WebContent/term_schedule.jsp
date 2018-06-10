<%@page import="model.Term"%>
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
<style type="text/css">
.tg {
	border-collapse: collapse;
	border-spacing: 0;
	direction: ltr
}

.tg td {
	font-family: Arial, sans-serif;
	font-size: 12px;
	padding: 5px 5px;
	border-style: solid;
	border-width: 1px;
	overflow: hidden;
	word-break: normal;
	border-color: black;
	text-align: center
}

.tg th {
	font-family: Arial, sans-serif;
	font-size: 12px;
	font-weight: normal;
	padding: 5px 5px;
	border-style: solid;
	border-width: 1px;
	overflow: hidden;
	word-break: normal;
	border-color: black;
	text-align: center
}

.tg .tg-yw4l {
	vertical-align: top
}
</style>
<script>
	function changeTerm(selectObject) {
		var value = selectObject.value;
		if (value == 0) {
			document.getElementById("form_container").innerHTML = "";
			return;
		}
		var xhttp = new XMLHttpRequest();
		xhttp.onreadystatechange = function() {
			if (this.readyState == 4 && this.status == 200) {
				document.getElementById("form_container").innerHTML = this.responseText;
			}
		};
		xhttp.open("POST", "termScheduleTable.jsp", true);
		xhttp.setRequestHeader("Content-type",
				"application/x-www-form-urlencoded");
		xhttp.send("termId=" + value);
	}
	function onBodyLoad() {
		var termSelector = document.getElementById("termSelectorInput");
		if (termSelector.value != 0) {
			changeTerm(termSelector);
		}
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
			<%@include file="./menu_general.jsp"%>
		</div>

		<!-- ---------------------------------------------- -->
		<%
			int selected_termId = 0;
			if (session.getAttribute("selected_termId") != null) {
				selected_termId = (Integer) session.getAttribute("selected_termId");
				session.removeAttribute("selected_termId");
			}
		%>
		<div class="large-12 medium-12 cell">
			<div class="callout">
				<div class="grid-x ">

					<div class="large-9 cell">
						<h3>زمانبندی ترم‌ها</h3>
					</div>
					<div class="large-3 cell">
						<select name="term_selector" id="termSelectorInput"
							onchange="changeTerm(this);">
							<option value="0">انتخاب ترم</option>
							<%
								List<Term> terms = Term.fetchAllTerms();
								for (Term term : terms) {
							%>
							<option value="<%out.print(term.id);%>"
								<%if (selected_termId == term.id) {
					out.print("selected");
				}%>>
								<%
									out.print(term.title);
								%>
							</option>
							<%
								}
							%>
						</select>
					</div>
					<div class="large-12 cell" id="form_container"></div>
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
