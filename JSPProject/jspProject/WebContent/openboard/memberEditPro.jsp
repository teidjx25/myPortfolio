<%@page import="com.exam.dao.MemberDao"%>
<%@page import="com.exam.vo.MemberVo"%>
<%@page import="java.io.File"%>
<%@page import="com.exam.vo.OpenboardVo"%>
<%@page import="com.exam.dao.OpenboardDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
// 포스트 전송 파라미터값 한글처리
request.setCharacterEncoding("utf-8");

String id = request.getParameter("id");
int state = Integer.parseInt(request.getParameter("state"));

System.out.println("id : "+ id+" state : "+ state);


//DAO 객체 준비

MemberDao dao =new MemberDao();
MemberVo mvo = dao.getMemberById(id);

mvo.setGm_lev(state);


dao.updatePromotionMember(mvo);


//글목록 페이지로 리다이렉트 시키기
response.sendRedirect("memberEdit.jsp");
%>
