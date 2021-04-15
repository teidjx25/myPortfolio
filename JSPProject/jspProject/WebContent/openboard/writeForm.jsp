<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.exam.vo.OpenboardVo"%>
<%@page import="com.exam.dao.OpenboardDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   
<%
String id =(String) session.getAttribute("id");
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
							
								<h1>공개 게시판 주글쓰기</h1>
										<form action="writePro.jsp" method="post" enctype="multipart/form-data">
									<table id="notice">
										<tr>
											<th scope="col" width="200">작성자명</th>
											<td class="left" width="500">
												
												<b><%=id %></b>
											</td>
										</tr>
										<tr>
											<th scope="col">글 패스워드</th>
											<td class="left">
												<input type="password" name = "passwd">
											</td>
										</tr>
										<tr>
											<th scope="col">글제목</th>
								
											<td class="left">
												<input type="text" name = "subject">
											</td>
										</tr>
										<tr>
											<th scope="col">글내용</th>
											<td class="left">
												<textarea rows="13" cols="40" name="content"></textarea>
											</td>
										</tr>
										<tr>
											<th scope="col">파일</th>
											<td class="left">
											<input type="file" name = "filename">
											</td>
										</tr>
									</table>

										<div class="col-552 col-12-xsmall">
											<input type="checkbox" id="demo-copy" name="lock">
											<label for="demo-copy">비밀글로 작성하겠습니다. </label>
										
						                </div>
									
									<div id="table_search">

										<input type="submit" value="글쓰기" class="btn">
										<input type="reset" value="다시쓰기" class="btn">
										<input type="button" value="목록" class="btn" onclick="location.href = 'openboard.jsp'">
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