<%@page import="com.ibm.icu.util.StringTokenizer"%>
<%@page import="com.bps.sw.pgw.service.PaymentGatewayImplService"%>
<%@page import="com.bps.sw.pgw.service.IPaymentGateway"%>
<%@page import="model.Level"%>
<%@page import="model.Exam"%>
<%@page import="model.TermClass"%>
<%@page import="model.Photo"%>
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
	
	    <script language="javascript" type="text/javascript">
        function postRefId(refIdValue) {
            var form = document.createElement("form");
            form.setAttribute("method", "POST");
            form.setAttribute("action", "https://bpm.shaparak.ir/pgwchannel/startpay.mellat");
            form.setAttribute("target", "_self");
            var hiddenField = document.createElement("input");
            hiddenField.setAttribute("name", "RefId");
            hiddenField.setAttribute("value", refIdValue);
            form.appendChild(hiddenField);
            document.body.appendChild(form);
            form.submit();
            document.body.removeChild(form);
        }

    </script>
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
String refId = (String)request.getSession().getAttribute("payment_ref_id");
if(refId != null){
	request.getSession().removeAttribute("payment_ref_id");
	%>
	<script language='javascript' type='text/javascript'>postRefId('<%=refId  %>');</script>
	<%
	return;
}
%>
<!-- ----------------------------------------------- -->
<%
User currentUser = User.getCurrentUser(session);
if(currentUser == null){
	response.sendRedirect("./signin.jsp");
	return;
}
request.setCharacterEncoding("UTF-8");
%>
<div class="large-12 medium-12 cell">
<%
//type
String type = "";
TermClass termClass = null;
Exam exam = null;
if(request.getParameter("classId") != null){
	type = "class";
	int id = Integer.parseInt(request.getParameter("classId"));
	termClass = TermClass.fetchClass(id);
	request.getSession().setAttribute("payment_classId", id);
}else if(request.getSession().getAttribute("payment_classId") != null){
	type = "class";
	int id = (Integer)request.getSession().getAttribute("payment_classId");
	termClass = TermClass.fetchClass(id);
}else if(request.getParameter("examId") != null){
	type = "exam";
	int id = Integer.parseInt(request.getParameter("examId"));
	exam = Exam.fetchExam(id);
	request.getSession().setAttribute("payment_examId", id);
}else if(request.getSession().getAttribute("payment_examId") != null){
	type = "exam";
	int id = Integer.parseInt(request.getParameter("examId"));
	exam = Exam.fetchExam(id);
}

if(termClass == null && exam == null){
	response.sendRedirect("./index.jsp");
	return;
}


%>



<%
String msg = (String)request.getSession().getAttribute("bank_response_message");
if(msg != null){
	request.getSession().removeAttribute("bank_response_message");
	%>
	<script language='javascript' type='text/javascript'>alert('<%=msg  %>');</script>
	<%
}
%>

<%
String msg2 = (String)request.getSession().getAttribute("bank_response_message2");
if(msg2 != null){
	request.getSession().removeAttribute("bank_response_message2");
	%>
	<script language='javascript' type='text/javascript'>alert('<%=msg2  %>');</script>
	<%
}
%>

<%
String msg3 = (String)request.getSession().getAttribute("bank_response_message3");
if(msg3 != null){
	request.getSession().removeAttribute("bank_response_message3");
	%>
	<script language='javascript' type='text/javascript'>alert('<%=msg3  %>');</script>
	<%
}
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
<%
if(type.equals("class")){
%>
<h3>ثبت نام در کلاس</h3>

<div class="grid-x ">

	<table>
	<tr>
		<td>نام</td>
		<td><%out.print(user.fname + " " + user.lname); %></td>
	</tr>
	<tr>
		<td>شماره زبان‌آموزی</td>
		<td><%out.print(user.student_id); %></td>
	</tr>
	<tr>
		<td>سطح</td>
		<td>
		<%
			Level level = Level.fetchLevel(termClass.levelId);
			out.print(level.title);
		%>
		</td>
	</tr>
	<tr>
		<td>زمان</td>
		<td>
<%
			switch (termClass.scheduleId) {
			case 6:
		%>روزهای زوج - صبح - شیفت ۱<%
			break;
			case 5:
		%>روزهای زوج - صبح - شیفت ۲<%
			break;
			case 4:
		%>روزهای زوج - صبح - شیفت ۳<%
			break;
			case 3:
		%>روزهای زوج - بعد از ظهر - شیفت ۱<%
			break;
			case 2:
		%>روزهای زوج - بعد از ظهر - شیفت ۲<%
			break;
			case 1:
		%>روزهای زوج - بعد از ظهر - شیفت ۳<%
			break;
			case 12:
		%>روزهای فرد - صبح - شیفت ۱<%
			break;
			case 11:
		%>روزهای فرد - صبح - شیفت ۲<%
			break;
			case 10:
		%>روزهای فرد - صبح - شیفت ۳<%
			break;
			case 9:
		%>روزهای فرد - بعد از ظهر - شیفت ۱<%
			break;
			case 8:
		%>روزهای فرد - بعد از ظهر - شیفت ۲<%
			break;
			case 7:
		%>روزهای فرد - بعد از ظهر - شیفت ۳<%
			break;
			case 18:
		%>یکشنبه سه‌شنبه - صبح - شیفت ۱<%
			break;
			case 17:
		%>یکشنبه سه‌شنبه - صبح - شیفت ۲<%
			break;
			case 16:
		%>یکشنبه سه‌شنبه - صبح - شیفت ۳<%
			break;
			case 15:
		%>یکشنبه سه‌شنبه - بعد از ظهر - شیفت ۱<%
			break;
			case 14:
		%>یکشنبه سه‌شنبه - بعد از ظهر - شیفت ۲<%
			break;
			case 13:
		%>یکشنبه سه‌شنبه - بعد از ظهر - شیفت ۳<%
			break;
			case 24:
		%>شنبه چهارشنبه - صبح - شیفت ۱<%
			break;
			case 23:
		%>شنبه چهارشنبه - صبح - شیفت ۲<%
			break;
			case 22:
		%>شنبه چهارشنبه - صبح - شیفت ۳<%
			break;
			case 21:
		%>شنبه چهارشنبه - بعد از ظهر - شیفت ۱<%
			break;
			case 20:
		%>شنبه چهارشنبه - بعد از ظهر - شیفت ۲<%
			break;
			case 19:
		%>شنبه چهارشنبه - بعد از ظهر - شیفت ۳<%
			break;
			case 30:
		%>پنج‌شنبه جمعه - صبح - شیفت ۱<%
			break;
			case 29:
		%>پنج‌شنبه جمعه - صبح - شیفت ۲<%
			break;
			case 28:
		%>پنج‌شنبه جمعه - صبح - شیفت ۳<%
			break;
			case 27:
		%>پنج‌شنبه جمعه - بعد از ظهر - شیفت ۱<%
			break;
			case 26:
		%>پنج‌شنبه جمعه - بعد از ظهر - شیفت ۲<%
			break;
			case 25:
		%>پنج‌شنبه جمعه - بعد از ظهر - شیفت ۳<%
			break;
			}
		%>
		</td>
	</tr>	
	<tr>
		<td>جنسیت</td>
		<td>
		<%
		switch(termClass.gender){
		case BOYS:
			out.print("پسران");
			break;
		case GIRLS:
			out.print("دختران");
			break;
		case BOTH:
			out.print("مختلط");
			break;
		}
		%>
		</td>
	</tr>
	
	<tr>
		<td>استاد</td>
		<td>
			<%
			User teacher = User.fetchUser(termClass.teacherId);
			out.print(teacher.fname + " " + teacher.lname); 
			%>
		</td>
	</tr>
	
	<tr>
		<td><b>مبلغ پرداختی</b></td>
		<td>
			<b>
					<%
					int price = level.price;
					out.print(price + " ریال"); 
					%>
			</b>
		</td>
	</tr>
	
	<tr>
		<td></td>
		<td   style="float:left">
			<a href="<%="./pay?command=pay&price="+level.price+"&classId="+termClass.id %>" class="success button" style="margin:0px">پرداخت</a>
		</td>
	</tr>
	</table>
	
	
</div>
<%
}else if(type.equals("exam")){
%>
<h3>ثبت نام در آزمون <%=exam.title %></h3>

<div class="grid-x ">

	<table>
	<tr>
		<td>نام</td>
		<td><%out.print(user.fname + " " + user.lname); %></td>
	</tr>
	<tr>
		<td>شماره زبان‌آموزی</td>
		<td><%out.print(user.student_id); %></td>
	</tr>

	
	<tr>
		<td><b>مبلغ پرداختی</b></td>
		<td>
			<b>
					<%
					int price = exam.price;
					out.print(price + " ریال"); 
					%>
			</b>
		</td>
	</tr>
	
	<tr>
		<td></td>
		<td   style="float:left">
			<a href="<%="./pay?command=pay&price="+exam.price+"&examId="+exam.id %>" class="success button" style="margin:0px">پرداخت</a>
		</td>
	</tr>
	</table>
	
	
</div>

<%
}
%>
	
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
