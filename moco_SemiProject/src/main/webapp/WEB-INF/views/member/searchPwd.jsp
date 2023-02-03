<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>비밀번호 찾기</title>
<style>
.logo {
	text-align: center;
	margin-top: 50px;
}

.findPwd {
	width: 500px;
	height: 40px;
	background-color: rgba(212, 216, 224, 0.925);
	border: none;
	border-radius: 5px;
}

.findPwdBtn {
	width: 505px;
	height: 42px;
	border: none;
	border-radius: 5px;
	color: rgb(124, 121, 121);
	font-size: 20px;
	border: 2px solid #0c70f2;
}

#member {
	border-collapse: separate;
	border-spacing: 0 10px;
}

#member input {
	padding: 0 0 0 10px;
}

.search {
	border-style: none;
	height: 50px;
	border-color: rgba(187, 191, 197, 0.986);
	color: #0c70f2;
	font-weight: bold;
	border-radius: 5px;
	width: 130px;
	font-size: 16px;
}

#searchPwd {
	background-color: #0c70f2;
	color: white;
}

#btnBar {
	text-align: center;
	margin-right: 240px;
}

#findDiv {
	text-align: center;
}

button:hover {
	cursor: pointer;
}
</style>
</head>
<body>
	<div class="logo">
		<a href="${contextPath }"> <img src="resources/assets/moco.png"
			width="250px">
		</a>
	</div>
	<div id="btnBar">
		<button class="search" id="searchId" style="margin: auto;"
			onclick="location.href='${contextPath}/searchIdView.me'">아이디
			찾기</button>
		<button class="search" id="searchPwd" style="margin: auto;"
			onclick="location.href='${contextPath}/searchPwdView.me'">비밀번호
			찾기</button>
	</div>
	<br>
	<h1 style="text-align: center;">비밀번호 변경</h1>
	<h4 style="text-align: center;">새로운 비밀번호를 설정해주세요.</h4>
	<form action="${ contextPath }/updatePwd.me" method="post">

		<table style="margin: auto;" id="member">
			<tr>
				<td><label for="memberPwd">새 비밀번호</label> <label class="check"
					id="checkRegPwd"></label></td>
			</tr>
			<tr>
				<td><input type="password" class="findPwd" name="memberPwd"
					id="memberPwd"></td>
			</tr>
			<tr>
				<td style="text-align: right;">
				<span id="regExpPwd" style="display: none;">6~12자 영문, 숫자, 특수기호 한가지 이상 포함해야합니다.</span></td>
			</tr>
			<tr>
				<td><label for="memberPwd2">비밀번호 확인</label> <label
					class="check" id="checkPwd"></label></td>
			</tr>
			<tr>
				<td><input type="password" class="findPwd" name="memberPwd2"
					id="memberPwd2" required></td>
			</tr>
			<tr>
				<td><br>
				<button onclick="location.href='${contextPath}/loginView.me'"
						class="findPwdBtn" disabled="disabled" id="updatePwd">비밀번호
						변경</button></td>
			</tr>
		</table>
		<input type="hidden" value='${ pwdMember.memberId }' name="memberId">
	</form>

	<script>
    	window.onload =()=>{

    		// 비밀번호 정규표현식
    		const pwd1 = document.getElementById('memberPwd');
    		const pwd2 = document.getElementById('memberPwd2');
    		const regExp2 = /^(?=.*[a-zA-z])(?=.*[0-9])(?=.*[$`~!@$!%*#^?&\\(\\)\-_=+]).{5,11}$/
//     		const regExp3 = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[$@$!%*#?&])[A-Za-z\d$@$!%*#?&]{5,11}$/
    		
    		const checkRegPwd = document.getElementById('checkRegPwd');
    		const checkPwd = document.getElementById('checkPwd');
    		
    		pwd1.addEventListener('change',function(){
    			if(regExp2.test(this.value)){
    				checkRegPwd.innerText = '사용 가능한 비밀번호입니다.';
    				checkRegPwd.style.color = 'green';  
    				isPwd = true;
    			} else {
    				checkRegPwd.innerText = '알맞은 비밀번호를 입력하세요.'
    				checkRegPwd.style.color = 'red';
    				isPwd = false;
    			}
    		})    		
    		
    		
    		// 비밀번호 확인
    		
    		pwd2.addEventListener('change', function(){
	    		if(pwd1.value == pwd2.value){
	    			console.log('일치');
	    			checkPwd.innerText = '비밀번호가 일치합니다';
	    			checkPwd.style.color = 'green';
	    			document.getElementById('updatePwd').disabled=false;
	    		} else {
	    			console.log('불일치');
	    			checkPwd.innerText = '비밀번호가 일치하지 않습니다.';
	    			checkPwd.style.color = 'red';
	    			document.getElementById('updatePwd').disabled=true;
	    		}
    		});
    	}

		document.getElementById('memberPwd').addEventListener('focusin',function(){
			document.getElementById('regExpPwd').style.display='';
		});
		document.getElementById('memberPwd').addEventListener('focusout',function(){
			document.getElementById('regExpPwd').style.display='none';
		});
    </script>

</body>
</html>