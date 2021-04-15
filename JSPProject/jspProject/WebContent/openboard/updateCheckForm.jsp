<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.exam.vo.OpenboardVo"%>
<%@page import="com.exam.dao.OpenboardDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    

<%
// 파라미터값  num  pageNum  가져오기
String num = request.getParameter("num");
String pageNum = request.getParameter("pageNum");
int gm_lev = ((Integer)(session.getAttribute("gm_lev"))).intValue();
%>
<!DOCTYPE HTML>
<html>
	<head>
		<title>Single - Future Imperfect by HTML5 UP</title>
		<meta charset="utf-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
		<link rel="stylesheet" href="/assets/css/main.css" />
	</head>
	<body class="single is-preload">

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
										<h2><a href="#">비밀번호 확인</a></h2>
										<p>Lorem ipsum dolor amet nullam consequat etiam feugiat</p>
									</div>

								</header>
								<span class="image featured"><img src="images/pic01.jpg" alt="" /></span>
								<form action="updateForm.jsp" method="post">
									<input type="hidden" name="gm_lev" value="<%=gm_lev %>">
									<input type="hidden" name="pageNum" value="<%=pageNum %>">
									<input type="hidden" name="num" value="<%=num %>">
									<table id="notice">
										<tr>
											<th scope="col">글 패스워드</th>
											<td class="left">
												<input type="password" name="passwd">
											</td>
										</tr>
									</table>
								
									<div id="contentbutton">
										<input type="submit" value="패스워드 확인" class="btn">
										<input type="reset" value="다시쓰기" class="btn">
										<input type="button" value="목록" class="btn" onclick="location.href = 'openboard.jsp?pageNum=<%=pageNum %>'">
									</div>
									</form>
					

							</article>
						
					</div>

				<!-- Footer -->
					<section id="footer">
						<ul class="icons">
							<li><a href="#" class="icon brands fa-twitter"><span class="label">Twitter</span></a></li>
							<li><a href="#" class="icon brands fa-facebook-f"><span class="label">Facebook</span></a></li>
							<li><a href="#" class="icon brands fa-instagram"><span class="label">Instagram</span></a></li>
							<li><a href="#" class="icon solid fa-rss"><span class="label">RSS</span></a></li>
							<li><a href="#" class="icon solid fa-envelope"><span class="label">Email</span></a></li>
						</ul>
						<p class="copyright">&copy; Untitled. Design: <a href="http://html5up.net">HTML5 UP</a>. Images: <a href="http://unsplash.com">Unsplash</a>.</p>
					</section>

			</div>

		<!-- Scripts -->
			<script src="/assets/js/jquery.min.js"></script>
			<script src="/assets/js/browser.min.js"></script>
			<script src="/assets/js/breakpoints.min.js"></script>
			<script src="/assets/js/util.js"></script>
			<script src="/assets/js/main.js"></script>

	</body>
</html>