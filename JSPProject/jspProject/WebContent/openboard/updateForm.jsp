<%@page import="com.exam.vo.noticeboardVo"%>
<%@page import="com.exam.dao.NoticeDao"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.exam.vo.OpenboardVo"%>
<%@page import="com.exam.dao.OpenboardDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   

<%
//post 전송 파라미터값 한글처리
request.setCharacterEncoding("utf-8");

//공지사항,일반 게시글 판단용
int notice = request.getParameter("notice")==null?0:Integer.parseInt(request.getParameter("notice"));
//아이디 세션값
String id =(String) session.getAttribute("id");
int gm_lev = ((Integer)(session.getAttribute("gm_lev"))).intValue();

System.out.println("폼 notice  : "+notice);


// 파라미터값  pageNum  num  passwd  가져오기
String pageNum = request.getParameter("pageNum");
int num = Integer.parseInt(request.getParameter("num"));

OpenboardDao dao = new OpenboardDao();

	if(notice<1){
	String passwd = request.getParameter("passwd");
	
	
	
	
	// DAO 객체 준비
	
	
	// 글번호에 해당하는 패스워드 비교하기
	boolean isCorrect = dao.isPasswdCorrect(num, passwd);
	
	// 패스워가 불일치하면 "글 패스워드가 틀림"  뒤로가기
	if (!isCorrect) {
		%>
		<script>
			alert('글 패스워드가 틀립니다. 다시 입력하세요.');
			history.back();
		</script>
		<%
		return;
	}
	
	}
//글번호에 해당하는 글정보 한개 가져오기
OpenboardVo vo = dao.getOpenboardByNum(num);

NoticeDao ndao= new NoticeDao();
noticeboardVo mvo= ndao. getnoticeboardByNum(num);

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
										<form action="updatePro.jsp" method="post" enctype="multipart/form-data">
											<input type="hidden" name="pageNum" value="<%=pageNum %>">
											<input type="hidden" name="num" value="<%=num %>">
											<input type="hidden" name="notice" value="<%=notice %>">
									<table id="notice">
										<tr>
											<th scope="col" width="200">작성자명</th>
											<td class="left" width="500">
												<input type="text" name="name" value="<%=id %>" readonly="readonly">
												
											</td>
										</tr>
										<tr>
												<% if(notice<1){%>
												<th scope="col">글 패스워드</th>
												<td class="left">
												<input type="password" name="passwd" value="<%=vo.getPasswd() %>">
												<%}%>
											</td>
										</tr>
										<tr>
											<th scope="col">글제목</th>
											<td class="left">
												<% if(notice<1){%>
												<input type="text" name="subject" value="<%=vo.getSubject() %>">
												<%}else{ %>
												<input type="text" name="subject" value="<%=mvo.getSubject() %>">
												<%} %>
												
											</td>
										</tr>
										<tr>
											<th scope="col">글내용</th>
											<td class="left">
												<% if(notice<1){%>
													<textarea rows="13" cols="40" name="content"><%=vo.getContent() %></textarea>
												<%}else{ %>
													<textarea rows="13" cols="40" name="content"><%=mvo.getContent() %></textarea>
												<%} %>
											
											</td>
										</tr>
										<tr>
											<th scope="col">파일</th>
											<td class="left">
											
												<% if(notice<1){
													
												if (vo.getFilename() == null) {
													%>
													<input type="file" name="filename">
													<%
												} else { // vo.getFilename() != null
													%>
													<div class="oldFileArea">
														<%=vo.getFilename() %>
														<span class="btnDelFile">X</span>
													</div>
													<input type="hidden" name="oldFilename" value="<%=vo.getFilename() %>">
													<%	//x를 누르면 oldFilename에 hidden속성을 주어 있던걸 감춰버리고 if (vo.getFilename() == null)를 통해 새로운 파일을 담도록 만듬
														//감춰버리는건 밑에 제이쿼리로 처리 ↓↓↓↓↓↓↓↓↓↓↓↓
														}
												%>
												<%}else{ 					
													if (mvo.getFilename() == null) {
													%>
													<input type="file" name="filename">
													<%
												} else { // vo.getFilename() != null
													%>
													<div class="oldFileArea">
														<%=mvo.getFilename() %>
														<span class="btnDelFile">X</span>
													</div>
													<input type="hidden" name="oldFilename" value="<%=mvo.getFilename() %>">
													<%	//x를 누르면 oldFilename에 hidden속성을 주어 있던걸 감춰버리고 if (vo.getFilename() == null)를 통해 새로운 파일을 담도록 만듬
														//감춰버리는건 밑에 제이쿼리로 처리 ↓↓↓↓↓↓↓↓↓↓↓↓
														}
												%>
													
												<%} %>
												
												
											</td>
										</tr>
									</table>



									<div id="table_search">

										<input type="submit" value="글쓰기" class="btn">
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
	

			<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
			<script>
			// 제이쿼리는 css 선택자 문법으로 대상을 선택해서 기능을 연결하는 용도 등으로 사용
			$('span.btnDelFile').click(function () {
				// 이벤트 소스 : 이벤트가 발생한 대상
				//   제이쿼리에서는 이벤트 핸들러 함수 내부에서 항상 this로 참조됨
				
				// 여기서 this는 클릭한 자기자신인 span태그가 됨
				
				// hidden타입 input태그의 name속성값을 delFilename으로 수정하기
				$(this).closest('div').next().prop('name', 'delFilename');
				
				// 가장 가까운 상위요소 중에 td요소를 기준으로 가장앞의 자식요소로 file 타입 input 추가하기
				$(this).closest('td').prepend('<input type="file" name="filename">');
				
				// 가장 가까운 div 요소를 삭제하기
				$(this).closest('div').remove();
			});
			
			
			</script>
	</body>
</html>