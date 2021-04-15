<%@page import="java.io.File"%>
<%@page import="com.exam.vo.noticeboardVo"%>
<%@page import="com.exam.dao.NoticeDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
// 포스트 전송 파라미터값 한글처리
request.setCharacterEncoding("utf-8");


//파라미터값 pageNum num passwd 가져오기
String pageNum = request.getParameter("pageNum");
int num = Integer.parseInt(request.getParameter("num"));

String passwd= request.getParameter("passwd");

int state = request.getParameter("state")==null?0:Integer.parseInt(request.getParameter("state"));

//DAO 객체 준비

NoticeDao dao =new NoticeDao();


// 글게시하기
dao.updateStateByNum(num, state);
//0이면 글 내림
//1이면 글 올림

//글목록 페이지로 리다이렉트 시키기
response.sendRedirect("noticeboard.jsp?pageNum=" +pageNum);




%>
