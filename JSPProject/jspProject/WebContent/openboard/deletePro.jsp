<%@page import="com.exam.vo.noticeboardVo"%>
<%@page import="com.exam.dao.NoticeDao"%>
<%@page import="java.io.File"%>
<%@page import="com.exam.vo.OpenboardVo"%>
<%@page import="com.exam.dao.OpenboardDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
// 포스트 전송 파라미터값 한글처리
request.setCharacterEncoding("utf-8");

//로그인 세션에서 준회원,정회원,관리자 레벨을 가져옴
int level = ((Integer)(session.getAttribute("gm_lev"))).intValue();


//파라미터값 pageNum num passwd 가져오기
String pageNum = request.getParameter("pageNum");
int num = Integer.parseInt(request.getParameter("num"));
String passwd= request.getParameter("passwd");

//잠금,삭제,삭제표시 판단용
int decision = request.getParameter("decision")==null?0:Integer.parseInt(request.getParameter("decision"));
//공지사항,일반 게시글 판단용
int notice = request.getParameter("notice")==null?0:Integer.parseInt(request.getParameter("notice"));

System.out.println("notice " + notice);
//DAO 객체 준비
OpenboardDao dao =new OpenboardDao();
NoticeDao Ndao= new NoticeDao();


//공지글인지 일반글인지 먼저 판단
if(notice>0){
	//공지글이면
	noticeboardVo nvo= Ndao.getnoticeboardByNum(num);
	// 첨부파일 존재여부 확인해서 있으면 삭제하기
	String filename =nvo.getFilename();
	if(filename !=null){ //첨부파일 있으면
		//실제 업로드 되어있는 경로 구하기
		String realPath = application.getRealPath("/upload");
		//File 객체 준비
		File file = new File(realPath, filename);
		if (file.exists()){	//해당 경로에 파일이 존재하는지 확인
			file.delete();//파일 삭제하기
		}
	}

	// DB 테이블 삭제
		Ndao.deleteByNum(num);


	
	//글목록 페이지로 리다이렉트 시키기
	response.sendRedirect("openboard.jsp?pageNum=" +pageNum);
}else{
	//운영레벨이 2보다 작으면 패스워드 비교
		if(level<2){
			//패스워드가 일치 하지 않을 때
			
			//본인글 확인용 패스워드 비교하기
			boolean isCorrect = dao.isPasswdCorrect(num, passwd);
			
			if(!isCorrect){ //isCorrect==false
				%>
				<script>
					alert('글 패스워드 틀림. 다시 입력하세요');
					history.back(); //뒤로가기.  앞으로가기는 forward()		
				</script>	
				<%
				return;	//여기서 완전 종료
			} 
			
			// 패스워드가 일치 할 때
			// 글번호에 해당하는 글내용 가져오기(첨부파일 정보 확인을 위해서)
			OpenboardVo vo= dao.getOpenboardByNum(num);
			// 첨부파일 존재여부 확인해서 있으면 삭제하기
			String filename =vo.getFilename();
			if(filename !=null){ //첨부파일 있으면
				//실제 업로드 되어있는 경로 구하기
				String realPath = application.getRealPath("/upload");
				//File 객체 준비
				File file = new File(realPath, filename);
				if (file.exists()){	//해당 경로에 파일이 존재하는지 확인
					file.delete();//파일 삭제하기
				}
			}
			
			// DB 테이블 글내용 삭제하기
			dao.deleteByNum(num);
			
			//글목록 페이지로 리다이렉트 시키기
			response.sendRedirect("openboard.jsp?pageNum=" +pageNum);
		}else{
			OpenboardVo vo= dao.getOpenboardByNum(num);
			// 첨부파일 존재여부 확인해서 있으면 삭제하기
			String filename =vo.getFilename();
			if(filename !=null){ //첨부파일 있으면
				//실제 업로드 되어있는 경로 구하기
				String realPath = application.getRealPath("/upload");
				//File 객체 준비
				File file = new File(realPath, filename);
				if (file.exists()){	//해당 경로에 파일이 존재하는지 확인
					file.delete();//파일 삭제하기
				}
			}
		
			// DB 테이블 글내용 방향성 결정
			//decision 값에 따라 잠금상태, 삭제표시(권한없는 사람에게는 안보임),진짜 삭제
			if(decision==1){
				//삭제
				dao.deleteByNum(num);
			}else if(decision==2){
				//잠금
				dao.updatelockstateByNum(num,decision);
			}else{
				//잠금해제
				dao.updatelockstateByNum(num,0);
			}
			//글목록 페이지로 리다이렉트 시키기
			response.sendRedirect("openboard.jsp?pageNum=" +pageNum);
		}

}
	



%>
