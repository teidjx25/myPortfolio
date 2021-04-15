<%@page import="com.exam.vo.MemberVo"%>
<%@page import="com.exam.dao.MemberDao"%>
<%@page import="com.exam.dao.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
 <%
//로그인 상태유지용 쿠키정보 가져오기
Cookie[] cookies=request.getCookies();

if(cookies != null){
	//쿠키 이름이 "id"인 쿠키객체 찿기
	
	for(Cookie cookie : cookies){
		if (cookie.getName().equals("id")){
			String id=cookie.getValue();
			//로그인 인증 처리(세션에 id값 저장)
			session.setAttribute("id",id);
			
		}
	}//for
}





//세션값 가져오기
String id =(String) session.getAttribute("id");
			
//member gm_lev,gm_area 가져오기
int gm_lev = 0;
int gm_area = 0;	

//null값이면 오류를 발생시키니 if문 추가
if(session.getAttribute("gm_lev") != null){
 gm_lev = ((Integer)(session.getAttribute("gm_lev"))).intValue();
 gm_area =((Integer)(session.getAttribute("gm_area"))).intValue();
}
//System.out.println("gm_lev  : "+gm_lev);
//세션값 있으면 ..님 반가워요 [로그아웃] [회원가입] 없어짐
//세션값 없으면 [로그인] [회원가입]
		
		


%>   
				<!-- Header -->
					<header id="header">

						<h1><a href="/index.jsp">삐약이네 만물상</a></h1>
						<nav class="links">
							<ul>
								<li><a href="/index.jsp">회사 메인</a></li>
								<li><a href="/openboard/openboard.jsp?gm_lev=<%=gm_lev%>">직원게시판</a></li>
								<li><a href="/openboard/notice/noticeboard.jsp?gm_lev=<%=gm_lev%>">공지게시판</a></li>
								<%if(gm_lev==2){%><li><a href="/openboard/memberEdit.jsp">(관리자)직원 권한 수정</a></li><%} %>
								
								
								
							</ul>
						</nav>

						<nav class="main">
							<ul>
								<li class="search">
									<a class="fa-search" href="#search">Search</a>
									<form id="search" method="get" action="#">
										<input type="text" name="query" placeholder="Search" />
									</form>
								</li>
								<li class="menu">
									<a class="fa-bars" href="#menu">Menu</a>
								</li>
							</ul>
						</nav>
					</header>

				<!-- Menu -->
					<section id="menu">

						<!-- Search -->
							<section>
								<form class="search" method="get" action="#">
									<input type="text" name="query" placeholder="Search" />
								</form>
							</section>

						<!-- Links -->
							<section>
								<ul class="links">
								
									<li>
										<a href="/index.jsp">
											<h3>회사 메인</h3>
											<p>홈페이지로 돌아갑니다.</p>
										</a>
									</li>
									<li>
										<a href="/openboard/openboard.jsp?gm_lev=<%=gm_lev%>">
											<h3>게시판</h3>
											<p>게시판으로 이동합니다.</p>
										</a>
									</li>
									<li>
										<a href="/openboard/notice/noticeboard.jsp?gm_lev=<%=gm_lev%>">
											<h3>공지게시판</h3>
											<p>공지사항 게시판입니다.</p>
										</a>
									</li>
									<%if(gm_lev==2){%>
									<li>
										<a href="/openboard/memberEdit.jsp">
											<h3>(관리자)직원 권한 수정</h3>
											<p>관리자 전용! 회원 권한 수정 페이지</p>
										</a>
									</li>
	
									<%} %>
								</ul>
							</section>

						<!-- Actions -->
							<section>
								<ul class="actions stacked">
								<%
									  if(id!=null){
									%>  <%if(gm_lev==2){%>
											<li> 운영자 계정! </li>
											<%}else if(gm_lev==1){ %>
											<li> 정회원 계정 </li>	<%
												}else{ %>
												<li> 운영자에게 문의하세요! </li>	<%
												}%>
										<li><%=id %>님 반갑습니다</li>
										<li><a href="/member/logout.jsp" class="button large fit">로그아웃</a></li>
									<% 
									  }else{
										
										  %>
										  	<li><a href="/member/login.jsp" class="button large fit">로그인</a></li> 
										    <li><a href="/member/joinform.jsp" class="button large fit">회원가입</a></li>
										  <%
									  }
										  %>
	
									
								</ul>
							</section>

					</section>

