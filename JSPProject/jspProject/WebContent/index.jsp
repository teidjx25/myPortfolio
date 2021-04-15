<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.exam.dao.NoticeDao"%>
<%@page import="com.exam.vo.noticeboardVo"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% 
String strPageNum = request.getParameter("pageNum");
//strPageNum 값이 null이면 "1"로 수정하기 (디폴트값을 "1"로 설정)
strPageNum = (strPageNum == null) ? "1" : strPageNum ;
//문자열 페이지번호를 정수형으로 변환하기
int pageNum = Integer.parseInt(strPageNum);

NoticeDao dao = new NoticeDao();
// 글목록 가져오기
List<noticeboardVo> list = dao.getnoticeboards("", 1, 4);
%>
<!DOCTYPE HTML>
<!--
	Future Imperfect by HTML5 UP
	html5up.net | @ajlkn
	Free for personal and commercial use under the CCA 3.0 license (html5up.net/license)
-->
<html>
	<head>
		<title>가상회사 : 삐약이네 만물상</title>
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
										<h2><a href="#">Company Inpomation</a></h2>
										<p>Lorem ipsum dolor amet nullam consequat etiam feugiat</p>
									</div>
									<div class="meta">
										<time class="published" datetime="2020-11-25">November 25, 2020</time>
										<a href="#" class="author"><span class="name">Jane Doe</span><img src="/images/avatar.jpg" alt="" /></a>
									</div>
								</header>
								<a href="#" class="image featured"><img src="/images/mainpage.jpg" alt="" /></a>
								<p>Mauris neque quam, fermentum ut nisl vitae, convallis maximus nisl. Sed mattis nunc id lorem euismod placerat. Vivamus porttitor magna enim, ac accumsan tortor cursus at. Phasellus sed ultricies mi non congue ullam corper. Praesent tincidunt sed tellus ut rutrum. Sed vitae justo condimentum, porta lectus vitae, ultricies congue gravida diam non fringilla.</p>
								<footer>
									<ul class="actions">
										<li><a href="#" class="button large">Continue Reading</a></li>
									</ul>
									<ul class="stats">
										<li><a href="#">General</a></li>
										<li><a href="#" class="icon solid fa-heart">28</a></li>
										<li><a href="#" class="icon solid fa-comment">128</a></li>
									</ul>
								</footer>
							</article>
					</div>
				<!-- Sidebar -->
					<section id="sidebar">
						<!-- Intro -->
							<section id="intro">
								<a href="#" class="logo"><img src="/images/logo.jpg" alt="" /></a>
								<header>
									<h2>삐약이네 만물상</h2>
									<p>신비와 재미를 거래하는 회사.<br> 삐약이네 만물상입니다. <a href="#">거래 회사</a></p>
								</header>
							</section>

						<!-- Mini Posts -->
							<section>
								<div class="mini-posts">
										<% 
										SimpleDateFormat sdf = new SimpleDateFormat("yyyy.MM.dd");
										for (noticeboardVo vo : list) {
											%>
											<article class="mini-post">
												<header>
												<h3><a href="/openboard/notice/noticecontent.jsp?num=<%=vo.getNum() %>&pageNum=<%=pageNum %>"><%=vo.getSubject() %></a></h3>
													<time class="published" datetime=<%=sdf.format(vo.getRegDate()) %>><%=sdf.format(vo.getRegDate()) %></time>
													<a href="#" class="author"><img src="/images/avatar.jpg" alt="" /></a>
												</header>
												<a href="/openboard/notice/noticecontent.jsp?num=<%=vo.getNum() %>&pageNum=<%=pageNum %>" class="image"><img src="/images/pic07.jpg" alt="" /></a>
											</article>
											<%
										} // for
										%>
								</div>
							</section>

			
						<!-- About -->
							<section class="blurb">
								<h2>About</h2>
								<p>Mauris neque quam, fermentum ut nisl vitae, convallis maximus nisl. Sed mattis nunc id lorem euismod amet placerat. Vivamus porttitor magna enim, ac accumsan tortor cursus at phasellus sed ultricies.</p>
								<ul class="actions">
									<li><a href="#" class="button">Learn More</a></li>
								</ul>
							</section>

						<!-- Footer -->
							<section id="footer">
								<ul class="icons">
									<li><a href="#" class="icon brands fa-twitter"><span class="label">Twitter</span></a></li>
									<li><a href="#" class="icon brands fa-facebook-f"><span class="label">Facebook</span></a></li>
									<li><a href="#" class="icon brands fa-instagram"><span class="label">Instagram</span></a></li>
									<li><a href="#" class="icon solid fa-rss"><span class="label">RSS</span></a></li>
									<li><a href="#" class="icon solid fa-envelope"><span class="label">Email</span></a></li>
								</ul>
								<p class="copyright">&copy; Untitled. Design: <a href="http://html5up.net">HTML5 UP</a>. /images: <a href="http://unsplash.com">Unsplash</a>.</p>
							</section>

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