<%@page import="java.util.List"%>
<%@page import="com.exam.vo.MemberVo"%>
<%@page import="com.exam.dao.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%


String id = request.getParameter("id");

//DAO 객체 준비
MemberDao dao = new MemberDao();

MemberVo mvo= dao.getMemberById(id);


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
								<h1>관리자 회원 수정 정보</h1>
								<form action="memberEditPro.jsp" class="post">	
								<input type="hidden" name="id" value="<%=mvo.getId() %>">
								<table id="notice">
									<tr>
										<th scope="col" class="ttitle">분류</th>
										<th scope="col" class="ttitle" >내용</th>
									</tr>						
											<tr>
												<td class="left">아이디</td>
												<td class="left"><%=mvo.getId() %></td>
												
											</tr>
											<tr>
												<td class="left">이름</td>
												<td class="left"><%=mvo.getName() %></td>
											</tr>
																						<tr>
												<td class="left">가입일자</td>
												<td class="left"><%=mvo.getRegDate()%></td>
											</tr>
											<tr>
												<td class="left">이메일</td>
												<td class="left"><%=mvo.getEmail() %></td>
											</tr>
											<tr>
												<td class="left">관리 레벨</td>
												<td>
													<select class="state" name="state">
														<option value="0" <%if( mvo.getGm_lev()==0){%>selected<%} %>>준회원</option>
														<option value="1" <%if( mvo.getGm_lev()==1){%>selected<%} %>>정회원</option>
														<option value="2" <%if( mvo.getGm_lev()==2){%>selected<%} %>>관리자</option>
													</select>
												</td>
											</tr>
		
								
								</table>
								
										<button type="submit" class="btn">수정 제출</button>
							

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