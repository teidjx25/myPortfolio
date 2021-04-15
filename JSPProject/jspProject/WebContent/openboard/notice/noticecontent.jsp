<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.exam.vo.noticeboardVo"%>
<%@page import="com.exam.dao.NoticeDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%-- 
	*선언부 영역 
	실제 서블릿 클래스로 변환될때
	멤버변수와 메서드 선언으로 변환됨
--%>
<%!
int max = 100;
int decision=1;

//이미지 파일이면(확장자가 jpg, jpeg, gif, png) img태그로 보여주기
// 이미지 파일이 아니면 다운로드 링크걸기
boolean isImage(String filename) {
	boolean isImage = false;
	
	int index = filename.lastIndexOf(".");
	String ext = filename.substring(index + 1); // 확장자 문자열
	
	if (ext.equalsIgnoreCase("jpg") 
			|| ext.equalsIgnoreCase("jpeg")
			|| ext.equalsIgnoreCase("gif")
			|| ext.equalsIgnoreCase("png")) {
		isImage = true;
	} else {
		isImage = false;
	}
	return isImage;
}
%>

<%
// num  pageNum   파라미터값 가져오기
int num = Integer.parseInt(request.getParameter("num"));
String pageNum = request.getParameter("pageNum");



int gm_lev=((session.getAttribute("gm_lev"))==null)?0:((Integer)(session.getAttribute("gm_lev"))).intValue();




// DAO 객체 준비
NoticeDao dao = new NoticeDao();

// 글번호 num에 해당하는 글의 조회수를 1 증가시키기
dao.updateReadcountByNum(num);

// 글번호 num에 해당하는 글한개를 VO로 가져오기
noticeboardVo vo = dao.getnoticeboardByNum(num);
SimpleDateFormat sdf = new SimpleDateFormat("yyyy년 MM월 dd일 hh시mm분 작성");
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
										<!-- 제목 -->
	
										<h2><a href="#">[공지]<%=vo.getSubject() %></a></h2>

										<p>Lorem ipsum dolor amet nullam consequat etiam feugiat</p>
									</div>
									<div class="meta">
										<time class="published" datetime="2015-11-01"><%=sdf.format(vo.getRegDate()) %></time>
										<a href="#" class="author"><span class="name"><%=vo.getName() %></span><img src="/images/avatar.jpg" alt="" /></a>
									</div>
								</header>
								
								<!-- 내용 -->
					
											<p><%=vo.getContent() %></p>

							
								<footer>
									<ul class="stats">
									<!-- 파일 -->
									<% if(gm_lev>1) {
										String filename = vo.getFilename();
										
										if (filename != null) {
											// 이미지 파일이면(확장자가 jpg, jpeg, gif, png) img태그로 보여주기
											// 이미지 파일이 아니면 다운로드 링크걸기
											
											if (isImage(filename)) {
												%>
												<a href="/upload/<%=vo.getFilename() %>">
													<img src="/upload/<%=vo.getFilename() %>" width="100" height="100">
												</a> <br>
												<%
											} else {
												%>
												<a href="/upload/<%=vo.getFilename() %>">
													<%=vo.getFilename() %>
												</a><br>
												<%
											}
										}
									}
										%>
										<li><a href="#">조회수 : <%=vo.getReadcount() %></a></li>
										<li><a href="#" class="icon solid fa-heart">28</a></li>
										<li><a href="#" class="icon solid fa-comment">128</a></li>
									</ul>

								</footer>
								<div class="contentbutton">
										<% if(gm_lev==2){ %>
													<input type="button" value="공지 게시하기" class="btn" onclick="location.href = 'noticePro.jsp?num=<%=num %>&pageNum=<%=pageNum %>&state=1'">
													<input type="button" value="공지 내리기" class="btn" onclick="location.href = 'noticePro.jsp?num=<%=num %>&pageNum=<%=pageNum %>&state=0'">
													<input type="button" value="수정" class="btn" onclick="location.href = '/openboard/updateForm.jsp?num=<%=num %>&pageNum=<%=pageNum %>&notice=1'">
													<input type="button" value="삭제" class="btn" onclick="location.href = '/openboard/deletePro.jsp?num=<%=num %>&pageNum=<%=pageNum %>&notice=1'">
										<% } %>
										<input type="button" value="목록" class="btn" onclick="location.href = '/openboard/notice/noticeboard.jsp?pageNum=<%=pageNum %>'">
								</div>
	
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