<%@page import="com.exam.vo.noticeboardVo"%>
<%@page import="com.exam.dao.NoticeDao"%>
<%@page import="com.exam.dao.MemberDao"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.exam.vo.OpenboardVo"%>
<%@page import="java.util.List"%>
<%@page import="com.exam.dao.OpenboardDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>	
<%
	int gm_lev=((session.getAttribute("gm_lev"))==null)?0:((Integer)(session.getAttribute("gm_lev"))).intValue();
	
	int gm_area =(request.getParameter("gm_area")== null)? 0:Integer.parseInt(request.getParameter("gm_area"));
	
	
	String word = request.getParameter("word");
	//pageNum 파라미터값 가져오기 (~페이지 클릭시 요청값이 들어감)
	String strPageNum = request.getParameter("pageNum");
	//strPageNum 값이 null이면 "1"로 수정하기 (디폴트값을 "1"로 설정)
	strPageNum = (strPageNum == null) ? "1" : strPageNum ;
	//문자열 페이지번호를 정수형으로 변환하기
	int pageNum = Integer.parseInt(strPageNum);
	
	//DAO 객체 준비
	OpenboardDao dao = new OpenboardDao();
	MemberDao mdao = new MemberDao();
	NoticeDao Ndao = new NoticeDao();
	
	int totalCount = dao.countAll(word); // 전체 글갯수
	
	
	int pageSize = 15;
	//시작행 인덱스번호 구하기 수식
	int startRow = (pageNum-1) * pageSize;
	
	
	
	int noticeCount = Ndao.countnotice(); 
	List<noticeboardVo> Noticelist = Ndao.getOpenNotice();
	
	// 글목록 가져오기
	List<OpenboardVo> list = dao.getOpenboards(word,startRow, pageSize);
	
%>
<!DOCTYPE HTML>

<html>
	<head>
		<title>게시판</title>
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
							<form action="openboard.jsp" class="post">
								<header>
									<div class="title">
										<h2><a href="single.html">일반게시판</a></h2>
										<p>보드게임과 관련해서 소통해요! 현재 <%=totalCount %>개의 글이 있습니다.</p>
									</div>

								</header>
								<h1>Notice</h1>
									
								<table id="notice">
									<tr>
										<th scope="col" class="tno">글번호</th>
										<th scope="col" class="ttitle">제목</th>
										<th scope="col" class="twrite">작성자</th>
										<th scope="col" class="tdate">작성일</th>
										<th scope="col" class="tread">조회</th>
					
									</tr>
									
									<%
									if (noticeCount>0){
										SimpleDateFormat sdf = new SimpleDateFormat("yyyy.MM.dd");
										for (noticeboardVo Nvo : Noticelist) {
											%>
											<tr>
												<td><%=Nvo.getNum() %></td>
												<td class="left">
												<a href="/openboard/notice/noticecontent.jsp?num=<%=Nvo.getNum() %>&pageNum=<%=pageNum %>">
												
					
													<b>[공지]<%=Nvo.getSubject() %></b>
													
													</a>
												</td>
												<td><%=Nvo.getName() %></td>
												<td><%=sdf.format(Nvo.getRegDate()) %></td>
												<td><%=Nvo.getReadcount() %></td>
												
											</tr>
											<%
										}
										
									}
									if (totalCount > 0) {
										SimpleDateFormat sdf = new SimpleDateFormat("yyyy.MM.dd");
										
										for (OpenboardVo vo : list) {
											%>
											<tr>
												<td><%=vo.getNum() %></td>
												<td class="left">
												<a href="content.jsp?num=<%=vo.getNum() %>&pageNum=<%=pageNum %>&lockstate=<%=vo.getLockState()%>">
												<span class="deletespace" style="width: 20px"></span>
												<%
												if(vo.getLockState()==2){
													%>
													💥 관리자가 삭제한 글입니다.
													<%
													}
													else if(vo.getLockState()==1){
													%>
													🔒 잠긴 글입니다.
													<%
													
												}else{
												if(vo.getReLev() >0){
													for(int i=1; i< vo.getReLev(); i++){
													%>
													 <span>&nbsp;&nbsp;</span>
														<%
													}
													%>
													<img src="/images/re.gif">
													<%
												}
												%>
													<%=vo.getSubject() %>
													<%} %>
													</a>
												</td>
												<td><%=vo.getName() %></td>
												<td><%=sdf.format(vo.getRegDate()) %></td>
												<td><%=vo.getReadcount() %></td>
												
											</tr>
											<%
										} // for
									} else { // totalCount == 0
										%>
										<tr>
											<td colspan="5">게시판 글이 없습니다.</td>
										</tr>
										<%
									}
									%>
									
							                  
								</table>
								
								<div class="col-992 col-12-xsmall">
									<input id="word" name="word" placeholder="word" type="search" class="input_box">  <input type="submit" value="Search" class="btn">
									<%if(gm_lev>0){ %>
									<input type="button" value="글쓰기" class="btn" onclick ="location.href ='writeForm.jsp'">
									<%} %>
								</div>
								
								
								<div class="clear"></div>
								<div id="page_control">
										<% 
										if(totalCount>0){
											//글이 한개이상 있으면 총페이지 갯수 구함
											//글50개. 한페이지에 보여줄 글 갯수 10개.50/10 -> 5페이지
											//글 55개. 한페이지에 보여줄 글 갯수 10개. 55/10 ->5+1페이지
											
											//int pageCount = (totalCount / pageSize)+((totalCount % pageSize == 0)?0:1);
											int pageCount = (int)Math.ceil((double)totalCount / pageSize);
											//화면에 보여줄 페이지번호의 갯수 설정
											int pageBlock=10;
											
											
								
											// 페이지블록의 시작페이지 번호 구하기
											// 1~10 11~20 21~30
											//		시작페이지 번호
											// 1~10 -> 1
											// 11~20 ->11
											// 21~30 ->21
											// 페이지블록의 시작페이지 번호 구하기 수식
											int startPage = ((pageNum/pageBlock) - (pageNum%pageBlock == 0? 1 : 0)) * pageBlock + 1;
											// 페이지블록의 끝페이지번호 구하기
											int endPage = startPage +pageBlock -1;
											if(endPage > pageCount){
												endPage = pageCount;
												
											}
											
											// [이전]
											if (startPage > pageBlock) {
												%>
												<a href="openboard.jsp?pageNum=<%=startPage - pageBlock %>">[이전]</a>
												<%
											}
													
											
											// 페이지블록의 시작페이지부터 끝페이지까지 페이지번호 출력하기
											for (int i=startPage; i<=endPage; i++) {
												%>
												<a href="openboard.jsp?pageNum=<%=i %>">
												
												<%
												if (i == pageNum) {
													%>
													<span style="font-weight: bold; color: red;"><%=i %></span>
													<%
												} else {
													%><%=i %><%
												}
												%>
												</a>
												<%
											}
											
											// [다음]
											if (endPage < pageCount) {
												%>
												<a href="openboard.jsp?pageNum=<%=startPage + pageBlock %>">[다음]</a>
												<%
											}
										}
										%>
									</div>
									</form>
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