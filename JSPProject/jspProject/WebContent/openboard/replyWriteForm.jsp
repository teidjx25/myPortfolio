<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.exam.vo.OpenboardVo"%>
<%@page import="com.exam.dao.OpenboardDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   
<%
//reRef reLev reSeq pageNum 파라미터값 가져오기
String reRef = request.getParameter("reRef");
String reLev = request.getParameter("reLev");
String reSeq = request.getParameter("reSeq");
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
							
							
							
									<form action="replyWritePro.jsp" method="post" enctype="multipart/form-data">
											<%-- multipart란 글의 모든 내용을 바이트 단위로 쪼개어 번호를 붙여서 여러 바이트를 보내고 번호순대로 재조립함 --%>
											<input type="hidden" name="reRef" value="<%=reRef %>">
											<input type="hidden" name="reLev" value="<%=reLev %>">
											<input type="hidden" name="reSeq" value="<%=reSeq %>">
											<input type="hidden" name="pageNum" value="<%=pageNum %>">
									<table id="notice">
										<tr>
											<th scope="col" width="200">작성자명</th>
											<td class="left" width="500">
												<input type="text" name = "name">
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



									<div id="table_search">

				
				
									<input type="submit" value="답글쓰기" class="btn">
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