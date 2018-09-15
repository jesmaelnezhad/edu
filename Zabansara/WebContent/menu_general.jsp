<%@page import="java.util.List"%>
<%@page import="model.AboutUs"%>
<%@page import="model.Role"%>
<%@page import="model.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

     <div id="preloader">
        <i class="circle-preloader"></i>
    </div> 
<%
User user = User.getCurrentUser(session);
if(user == null){
%>
    <!-- ##### Header Area Start ##### -->
    <header class="header-area">
        <!-- Navbar Area -->
        <div class="fitness-main-menu">
            <div class="classy-nav-container breakpoint-off" style="background-image: url('../images/top_background.jpg');">
                <div class="container">
                    <!-- Menu -->
                    <nav class="classy-navbar justify-content-between" id="fitnessNav">

                        <!-- Nav brand -->
                        
						
                        <!-- Navbar Toggler -->
                        <div class="classy-navbar-toggler">
                            <span class="navbarToggler"><span></span><span></span><span></span></span>
                        </div>

                        <!-- Menu -->
                        <div class="classy-menu">

                            <!-- close btn -->
                            <div class="classycloseIcon">
                                <div class="cross-wrap"><span class="top"></span><span class="bottom"></span></div>
                            </div>

                            <!-- Nav Start -->
                            <div class="classynav">
                             	<!-- Call Button -->
                                <a type="button" class="button" style="background-color:#dddddd">زبانسرا</a>
                                <ul>
                                    <li><a href="./index.jsp">صفحه‌ی اصلی</a></li>
									<li><a href="./policies.jsp">قوانین و مقررات</a></li>
									<li><a href="./news.jsp">مطالب و خبرها</a></li>
									<li><a href="">درباره ما&nbsp; &nbsp;</a>
										<div class="megamenu">
										<ul class="dropdown">
										<%
										List<AboutUs> aboutusList = AboutUs.fetchAllAboutUs();
										for(AboutUs aboutus : aboutusList){
										%>
											<li><a style="font-size:12px" href="./aboutus.jsp?id=<%=aboutus.id%>"><%=aboutus.menu_item %></a></li>
										<%
										}
										%>
										</ul></div></li>
									<li ><a href="">ارتباط با ما&nbsp; &nbsp;</a>		
											<div class="megamenu" >	
													<ul class="dropdown">
														<li><a style="font-size:12px" href="./contactusbrief.jsp"> ارتباط با ما</a></li>
														<li><a style="font-size:12px" href="./complains.jsp"> ثبت شکایات</a></li>
														<li><a style="font-size:12px" href="./contactus.jsp"> آموزشگاه زبان‌سرای شیراز</a></li>
														<li><a style="font-size:12px" href="https://www.instagram.com/zabansara.shz/"> صفحه‌ی اینستاگرم</a></li>
													</ul></div></li>
                                </ul>

                               

                            </div>
                            <!-- Nav End -->
                        </div>
                    
                    	<a type="button" class="button" href="signin.jsp" style="background-color:#dddddd" >ورود به سایت</a>
                    </nav>
                </div>
            </div>
        </div>
    </header>

<%	
} else if(user.role == Role.ADMIN){
	%>
	    <!-- ##### Header Area Start ##### -->
    <header class="header-area">
        <!-- Navbar Area -->
        <div class="fitness-main-menu">
            <div class="classy-nav-container breakpoint-off" style="background-image: url('../images/top_background.jpg');">
                <div class="container">
                    <!-- Menu -->
                    <nav class="classy-navbar justify-content-between" id="fitnessNav">

                        <!-- Nav brand -->
                        
						
                        <!-- Navbar Toggler -->
                        <div class="classy-navbar-toggler">
                            <span class="navbarToggler"><span></span><span></span><span></span></span>
                        </div>

                        <!-- Menu -->
                        <div class="classy-menu">

                            <!-- close btn -->
                            <div class="classycloseIcon">
                                <div class="cross-wrap"><span class="top"></span><span class="bottom"></span></div>
                            </div>

                            <!-- Nav Start -->
                            <div class="classynav">
                             	<!-- Call Button -->
                                <a type="button" class="button" >زبانسرا</a>
                               
                                <ul >
									<li><a href="./index.jsp">صفحه‌ی اصلی</a></li>
									<li><a href="./news.jsp">مطالب و خبرها</a></li>
									<li><a href="">کاربر&nbsp; &nbsp;</a>
									<div class="megamenu">
										<ul class="dropdown">
											<li><a href="./profile.jsp">اطلاعات کاربر</a></li>
											<li><a href="./signup.jsp">عضویت در سایت</a></li>
											<li><a href="users.jsp">لیست کاربر‌ها</a></li>
										</ul></div></li>
									<li><a href="">آموزشی&nbsp; &nbsp;</a>
										<div class="megamenu">
										<ul class="dropdown">
											<li><a href="./terms.jsp">ترم‌ها و سطوح</a></li>
											<li><a href="./classes.jsp">کلاس‌ها</a></li>
											<li><a href="./term_schedule.jsp">زمان‌بندی امتحانات و ترم</a></li>
											<li><a href="./exams.jsp">آزمون‌های عمومی</a></li>
										</ul></div></li>
									<li><a href="">درباره ما&nbsp; &nbsp;</a>
									<div class="megamenu">
										<ul class="dropdown">
											<li><a href="./aboutus.jsp">مدیریت صفحات درباره ما</a></li>
										<%
										List<AboutUs> aboutusList = AboutUs.fetchAllAboutUs();
										for(AboutUs aboutus : aboutusList){
										%>
											<li><a href="./aboutus.jsp?id=<%=aboutus.id%>"><%=aboutus.menu_item %></a></li>
										<%
										}
										%>
										</ul></div></li>
									<li><a href="">ارتباط با ما&nbsp; &nbsp;</a>	
									<div class="megamenu">			
										<ul class="dropdown">
											<li><a href="./contactusbrief.jsp">تماس با ما</a></li>
											<li><a href="./complains.jsp">ثبت شکایات</a></li>
											<li><a style="font-size:12px" href="./contactus.jsp">آموزشگاه زبان‌سرای شیراز</a></li>
											<li><a href="https://www.instagram.com/zabansara.shz/">صفحه‌ی اینستاگرم</a></li>
										</ul></div></li>
						
								</ul>

                               

                            </div>
                            <!-- Nav End -->
                        </div>
                    
                    		<a type="button" class="button" 
					      			href="./signout" >
					      			<%
					      			if(User.isCurrentUserSecondary(session)){
					      				%>خروج از حساب کاربر<%
					      			}else{
					      				%>خروج از سیستم<%	      				
					      			}
					      			%>
					      	</a>
                    </nav>
                </div>
            </div>
        </div>
    </header>

	
	<%
} else if(user.role == Role.TEACHER){
	%>
	
		    <!-- ##### Header Area Start ##### -->
    <header class="header-area">
        <!-- Navbar Area -->
        <div class="fitness-main-menu">
            <div class="classy-nav-container breakpoint-off" style="background-image: url('../images/top_background.jpg');">
                <div class="container">
                    <!-- Menu -->
                    <nav class="classy-navbar justify-content-between" id="fitnessNav">

                        <!-- Nav brand -->
                        
						
                        <!-- Navbar Toggler -->
                        <div class="classy-navbar-toggler">
                            <span class="navbarToggler"><span></span><span></span><span></span></span>
                        </div>

                        <!-- Menu -->
                        <div class="classy-menu">

                            <!-- close btn -->
                            <div class="classycloseIcon">
                                <div class="cross-wrap"><span class="top"></span><span class="bottom"></span></div>
                            </div>

                            <!-- Nav Start -->
                            <div class="classynav">
                             	<!-- Call Button -->
                                <a type="button" class="button" >زبانسرا</a>
								<ul>
									<li><a href="./index.jsp">صفحه‌ی اصلی</a></li>
									<li><a href="./profile.jsp">اطلاعات مربی</a></li>
									<li><a href="./classes.jsp">کلاس‌ها</a></li>
									<li><a href="">زمان‌بندی&nbsp; &nbsp;</a>
									<div class="megamenu">
										<ul class="dropdown">
											<li><a href="./availability.jsp">اعلام آمادگی</a></li>
											<li><a href="./term_schedule.jsp">تقویم ترم</a></li>
											<li><a style="font-size:12px"  href="./term_schedule.jsp">زمان‌بندی امتحانات و ترم</a></li>
										</ul></div></li>
									<li><a href="./news.jsp">مطالب و خبرها</a></li>
									<li><a href="">درباره ما&nbsp; &nbsp;</a>
									<div class="megamenu">
										<ul class="dropdown">
										<%
										List<AboutUs> aboutusList = AboutUs.fetchAllAboutUs();
										for(AboutUs aboutus : aboutusList){
										%>
											<li><a style="font-size:12px"  href="./aboutus.jsp?id=<%=aboutus.id%>"><%=aboutus.menu_item %></a></li>
										<%
										}
										%>
										</ul></div></li>
									<li><a href="">ارتباط با ما&nbsp; &nbsp;</a>		
									<div class="megamenu">		
										<ul class="dropdown">
											<li><a href="./contactusbrief.jsp">تماس با ما</a></li>
											<li><a href="./complains.jsp">ثبت شکایات</a></li>
											<li><a style="font-size:12px"  href="./contactus.jsp">آموزشگاه زبان‌سرای شیراز</a></li>
											<li><a href="https://www.instagram.com/zabansara.shz/">صفحه‌ی اینستاگرم</a></li>
										</ul></div></li>
						
								</ul>

                               

                            </div>
                            <!-- Nav End -->
                        </div>
                    
                    		<a type="button" class="button" 
					      			href="./signout" >
					      			<%
					      			if(User.isCurrentUserSecondary(session)){
					      				%>خروج از حساب کاربر<%
					      			}else{
					      				%>خروج از سیستم<%	      				
					      			}
					      			%>
					      	</a>
                    </nav>
                </div>
            </div>
        </div>
    </header>

	
	
	<%
} else if(user.role == Role.STUDENT){
	%>
	
		
		    <!-- ##### Header Area Start ##### -->
    <header class="header-area">
        <!-- Navbar Area -->
        <div class="fitness-main-menu">
            <div class="classy-nav-container breakpoint-off" style="background-image: url('../images/top_background.jpg');">
                <div class="container">
                    <!-- Menu -->
                    <nav class="classy-navbar justify-content-between" id="fitnessNav">

                        <!-- Nav brand -->
                        
						
                        <!-- Navbar Toggler -->
                        <div class="classy-navbar-toggler">
                            <span class="navbarToggler"><span></span><span></span><span></span></span>
                        </div>

                        <!-- Menu -->
                        <div class="classy-menu">

                            <!-- close btn -->
                            <div class="classycloseIcon">
                                <div class="cross-wrap"><span class="top"></span><span class="bottom"></span></div>
                            </div>

                            <!-- Nav Start -->
                            <div class="classynav">
                             	<!-- Call Button -->
                                <a type="button" class="button" >زبانسرا</a>
                                
                                <ul>
									<li><a href="./index.jsp">صفحه‌ی اصلی</a></li>
									<li><a href="./news.jsp">مطالب و خبرها</a></li>
									<li><a href="./profile.jsp">اطلاعات کاربر</a></li>
									<li><a href="">آموزشی&nbsp; &nbsp;</a>
									<div class="megamenu">
										<ul class="dropdown">
											<li><a href="./registration.jsp">ثبت‌نام</a></li>
											<li><a href="./classes.jsp">کلاس‌ها</a></li>
											<li><a style="font-size:12px" href="./term_schedule.jsp">زمان‌بندی امتحانات و ترم</a></li>
											<li><a href="./exams.jsp">آزمون‌های عمومی</a></li>
										</ul></div></li>
									<li><a href="">درباره ما&nbsp; &nbsp;</a>
									<div class="megamenu">
										<ul class="dropdown">
										<%
										List<AboutUs> aboutusList = AboutUs.fetchAllAboutUs();
										for(AboutUs aboutus : aboutusList){
										%>
											<li><a style="font-size:12px" href="./aboutus.jsp?id=<%=aboutus.id%>"><%=aboutus.menu_item %></a></li>
										<%
										}
										%>
										</ul></div></li>
									<li><a href="">ارتباط با ما&nbsp; &nbsp;</a>	
									<div class="megamenu">			
										<ul class="dropdown">
											<li><a href="./contactusbrief.jsp">تماس با ما</a></li>
											<li><a href="./complains.jsp">ثبت شکایات</a></li>
											<li><a style="font-size:12px" href="./contactus.jsp">آموزشگاه زبان‌سرای شیراز</a></li>
											<li><a href="https://www.instagram.com/zabansara.shz/">صفحه‌ی اینستاگرم</a></li>
										</ul></div></li>
						
								</ul>

                            </div>
                            <!-- Nav End -->
                        </div>
                    
                    		<a type="button" class="button" 
					      			href="./signout" >
					      			<%
					      			if(User.isCurrentUserSecondary(session)){
					      				%>خروج از حساب کاربر<%
					      			}else{
					      				%>خروج از سیستم<%	      				
					      			}
					      			%>
					      	</a>
                    </nav>
                </div>
            </div>
        </div>
    </header>
	

	<%
} else{
	// not possible
}


%>

   
	
