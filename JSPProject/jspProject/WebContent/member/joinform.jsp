<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

	<head>
		<title>게시글</title>
		<meta charset="utf-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
		<link rel="stylesheet" href="/assets/css/main.css" />
	</head>

	<body class="is-preload">

		<!-- Wrapper -->
			<div id="wrapper">
			<%-- head 컨텐트 영역 --%>
			<jsp:include page="/include/tophead.jsp" />

    <section>
        <h3>회원 가입</h3>
        <form id="join" action="joinPro.jsp" method="post" name="frm" onsubmit="return checkId();">
           		 <div class="row gtr-uniform">
				<div class="col-6 col-12-xsmall">
                    아이디<input type="text"  type="text" class="id" name="id" placeholder="id" required/>
				</div>
				<div class="col-6 col-12-xsmall">
					<br>
                    <input type="submit" value="아이디중복체크" onclick="winopen()"/>
                </div>

				<div class="col-6 col-12-xsmall">
		
                    비밀번호		<input type="password" class="pass" name="passwd" id="pass1" placeholder="password" required />
				</div>
				<div class="col-6 col-12-xsmall">
                    비밀번호 재입력<input type="password" class="pass" id="pass2" onkeyup="checkPasswd()" required/>
                    <span id="messagePasswd"></span>
				</div>

				<div class="col-6 col-12-xsmall">
                    이름<input type="text"  name="name" id="demo-name" value="" placeholder="이름" required/>
				</div>
				
				<div class="col-992 col-12-xsmall">
                    이메일<input type="email" class="email" name="email" placeholder="이메일" required/>
				</div>
				<div class="col-992 col-12-xsmall">
                    주소<input type="text" class="address" name="address"  placeholder="주소" />
				</div>
				<div class="col-552 col-12-xsmall">
                    연락번호<input type="tel" class="phone" name="tel" placeholder="전화번호" required/>
				</div>
				<div class="col-552 col-12-xsmall">
                    나이<input type="tel" class="age" name="age" />
                </div>
                
				
          
                <div class="col-12">
                    <ul class="actions">
                        <li><input type="submit" value="등록" /></li>
						<li><input type="reset" value="재작성" /></li>
			
                    </ul>
                </div>
            </div>
        </form>
    </section>
    </div>
		
		
<script>
function winopen() {
	let id = document.frm.id.value;
	
	if (id == '') {
		alert('아이디를 입력 후 중복확인을 해주세요');
		document.frm.id.focus();
		return;
	}
	
	// 새창 열어서 아이디중복확인 jsp요청  window.open()
	open('joinIdDupCheck.jsp?id=' + id, 'dupCheck', 'width=500,height=400');
} // winopen


// 패스워드 입력상자 pass1, pass2, messagePasswd 문서객체 참조하기
let pass1 = document.getElementById('pass1');
let pass2 = document.getElementById('pass2');
let spanPasswd = document.getElementById('messagePasswd');

function checkPasswd() {
	if (pass1.value == pass2.value) {
		spanPasswd.innerHTML = '패스워드가 일치합니다.';
		spanPasswd.style.color = 'green';
	} else {
		spanPasswd.innerHTML = '패스워드 불일치!';
		spanPasswd.style.color = 'red';
	}
	

} // checkPasswd

function checkId(){
	let id = frm.id.value.trim();
	//아이디 글자수가 3개이상 12개 이하가 아니면 submit 허용안함
	if(!(id.length >=3 && id.length<=12)){
		alert('아이디 글자수는 3자 이상 12자 이하만 가능합니다.')
		frm.id.select();
		
		return false;
	}
	
	//return true;
} //checkId


</script>		
		
		<!-- Scripts -->
			<script src="/assets/js/jquery.min.js"></script>
			<script src="/assets/js/browser.min.js"></script>
			<script src="/assets/js/breakpoints.min.js"></script>
			<script src="/assets/js/util.js"></script>
			<script src="/assets/js/main.js"></script>
			
			
			
</body>
</html>