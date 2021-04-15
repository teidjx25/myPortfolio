<%@page import="java.util.List"%>
<%@page import="com.exam.vo.MemberVo"%>
<%@page import="com.exam.dao.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
//페이지 지시어

String word = request.getParameter("word");
//pageNum 파라미터값 가져오기 (~페이지 클릭시 요청값이 들어감)
String strPageNum = request.getParameter("pageNum");
//strPageNum 값이 null이면 "1"로 수정하기 (디폴트값을 "1"로 설정)
strPageNum = (strPageNum == null) ? "1" : strPageNum ;

//문자열 페이지번호를 정수형으로 변환하기
int pageNum = Integer.parseInt(strPageNum);


//DAO 객체 준비
MemberDao dao = new MemberDao();

int totalCount = dao.searchcountAll(word); // 전체 멤버의 수


int pageSize = 15;
//시작행 인덱스번호 구하기 수식
int startRow = (pageNum-1) * pageSize;

// 글목록 가져오기
List<MemberVo> list = dao.getMembers(word,startRow, pageSize);



%>


<!DOCTYPE HTML>

<html>
	<head>
		<title>관리자 회원 수정</title>
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
								<h1>관리자 회원 수정 회원수: <%=totalCount %></h1>
								<form action="memberEdit.jsp" class="post">	
								<table id="notice">
									<tr>
										<th scope="col" class="ttitle">회원 아이디</th>
										<th scope="col" class="ttitle" >이름</th>
										<th scope="col" class="ttitle">권한</th>
										<th scope="col" class="ttitle">삭제</th>
									</tr>						
								<%
									if (totalCount > 0) {
										for (MemberVo vo : list) {
											%>
											<tr>
												<td class="left"><a href="memberEditform.jsp?id=<%=vo.getId() %>"><%=vo.getId() %></a></td>
												<td class="left"><%=vo.getName() %></td>
												<td>
													
													<%if( vo.getGm_lev()==0){%>준회원<%} %>
													<%if( vo.getGm_lev()==1){%>정회원<%} %>
													<%if( vo.getGm_lev()==2){%>관리자<%} %>
													
												</td>
												<td><a href="deletepro.jsp?id=<%=vo.getId() %>">삭제</a></td>
											</tr>
											<%
										} // for
									} else { // totalCount == 0
										%>
										<tr>
											<td colspan="5">멤버가 없습니다.</td>
										</tr>
										<%
									}
									%>
								
								</table>
								
								<!-- 검색 -->
								<div class="col-992 col-12-xsmall">
									<input id="word" name="word" placeholder="word" type="search" class="input_box">  <input type="submit" value="Search" class="btn">
									
								</div>
								
								<!-- 페이지 이동 -->
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
												<a href="memberEdit.jsp?pageNum=<%=startPage - pageBlock %>">[이전]</a>
												<%
											}
													
											
											// 페이지블록의 시작페이지부터 끝페이지까지 페이지번호 출력하기
											for (int i=startPage; i<=endPage; i++) {
												%>
												<a href="memberEdit.jsp?pageNum=<%=i %>">
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
												<a href="memberEdit.jsp?pageNum=<%=startPage + pageBlock %>">[다음]</a>
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
			
			
			<script type="text/javascript">
			
				$(".state").change(function() {
				// form태그 자체를 전송하여 값을 변경하는 경우 반복문이 포함되어있어 중복이 발생 >> 비권장
				// => 따라서 옵션에 변화가 일어나는 순간의 값을 가져오는 용도로 변수를 설정하여 넘김
				var id=$(this).attr("name");
				var status=$(this).val();
				// 두 변수를 쿼리스트링으로 처리페이지에게 전달
				location.href="/memberEditPro.jsp?id="+id+"&status="+status;
			});
			</script>
	</body>
</html>