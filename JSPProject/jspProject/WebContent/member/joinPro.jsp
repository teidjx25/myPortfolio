<%@page import="java.sql.Timestamp"%>
<%@page import="com.exam.vo.MemberVo"%>
<%@page import="com.exam.dao.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- post전송 파라미터값 한글처리 --%>
<% request.setCharacterEncoding("utf-8");%>

<%--VO 객체 준비 --%>
<% MemberVo memberVo = new MemberVo(); %>


<%--파라미터값을 찿아서 vo객체에 저장--%>

<%
memberVo.setId(request.getParameter("id")); 
memberVo.setPassword(request.getParameter("passwd"));
memberVo.setName(request.getParameter("name")); 
memberVo.setEmail(request.getParameter("email"));
memberVo.setAddress(request.getParameter("address"));
memberVo.setTel(request.getParameter("tel"));
memberVo.setAge(Integer.parseInt(request.getParameter("age")));
memberVo.setGm_lev(0);
memberVo.setGm_area(1);
%>

<%--현재 날짜 시간 정보 설정 --%>
<% memberVo.setRegDate(new Timestamp(System.currentTimeMillis())); %>


<%--DAO 객체 준비--%>
<%MemberDao memberDao =new MemberDao();%>
<%-- 회원가입 메서드 호출 --%>
<%memberDao.addMember(memberVo);%>

<%--로그인 페이지를 요청하게 하는 응답을 줌 --%>
<%// response.sendRedirect("login.jsp");%>

<%--↑↑의 자바스크립트로 만든 리다이렉트↓↓--%>
<script>
	alert('회원가입 성공!'); /* 확인 버튼을 누르면 jsp페이지로 요청 해버림  */
	location.href = 'login.jsp';
</script>



