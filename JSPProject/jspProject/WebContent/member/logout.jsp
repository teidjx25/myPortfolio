<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%--세션에 저장된 특정값 삭제--%>

<%//session.removeAttribute("id"); %>

<%--세션값 초기화(세션에 저장된 모든 정보 삭제)--%>

<%session.invalidate(); %>




<%--로그인 상태유지용 쿠키가 존재하면 삭제처리--%>

<%
Cookie[] cookies =request.getCookies();

if (cookies != null){
	for(Cookie cookie :cookies){
		//쿠키이름이 "id"인 쿠키를 삭제하도록 유효기간을 0으로 설정
		if(cookie.getName().equals("id")){
			cookie.setMaxAge(0);	//쿠키 삭제 의도롤 유효기간 0 설정
			cookie.setPath("/");	//경로 설정 유의!
			response.addCookie(cookie);
		}
	}
}
%>


<%--"로그 아웃 됨" index.jsp로 이동--%>

<script>
	alert('로그아웃됨');
	location.href='/index.jsp'; 
</script>