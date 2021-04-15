<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<!--
	Future Imperfect by HTML5 UP
	html5up.net | @ajlkn
	Free for personal and commercial use under the CCA 3.0 license (html5up.net/license)
-->
<html>
	<head>
		<title>로그인</title>
		<meta charset="utf-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
		<link rel="stylesheet" href="/assets/css/main.css" />
	</head>

	<body class="is-preload">

		<!-- Wrapper -->
			<div id="wrapper">
			<%-- head 컨텐트 영역 --%>
			<jsp:include page="/include/tophead.jsp" />
				<!-- Main -->
					<div id="main">

						<!-- Post -->
							<article class="post">
								<header>
									<div class="title">
										<h2><a href="single.html">Company Inpomation</a></h2>
										<p>Lorem ipsum dolor amet nullam consequat etiam feugiat</p>
									</div>
								</header>
								<form action="loginPro.jsp" method="post" id="join">
								
                                <div class="col-6 col-12-xsmall">
                                    아이디<input type="text"  type="text" class="id" name="id" placeholder="id" required/>
                                </div>
                                
                                <div class="col-6 col-12-xsmall">
                                    패스워드<input type="text" type="password" class="pass" name="passwd" id="pass1" placeholder="password" required />
                                </div>
                               
								<label>로그인 상태 유지</label>
								<div class="col-552 col-12-xsmall">
									<input type="checkbox" id="demo-copy"  name="keepLogin" value="true">
									
									<label for="demo-copy">체크하면 10분 동안 로그인이 유지됩니다. </label> <br>
								</div>
							
								
                                <div class="center">
                                <input type="submit" value="로그인" />
                                </div>
                                </form>
                                <br>
                                <br>
                                <br>
							</article>

					</div>
			</div>
		<!-- Scripts -->
			<script src="/assets/js/jquery.min.js"></script>
			<script src="/assets/js/browser.min.js"></script>
			<script src="/assets/js/breakpoints.min.js"></script>
			<script src="/assets/js/util.js"></script>
			<script src="/assets/js/main.js"></script>

	</body>
</html>