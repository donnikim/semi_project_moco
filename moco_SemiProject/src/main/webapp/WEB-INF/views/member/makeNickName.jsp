<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>로그인</title>
    <script src="https://code.jquery.com/jquery-3.6.1.min.js"></script>
    <style>
        .logo{text-align: center; margin-top: 50px;}
        .login{width: 500px; height: 40px; background-color: rgba(212, 216, 224, 0.925); border: none;
                border-radius: 5px; }
        #loginBtn{width: 505px; height: 42px; background-color: #0c70f2; border: none;
                border-radius: 5px; color: white; font-size: 20px; cursor:pointer;} 
        #member{border-collapse: separate; border-spacing: 0 10px;}
        #member input{padding : 0 0 0 10px;}
        #searchBtn{background-color: white; border: none; }
        #searchBtn:hover{text-decoration: underline; font-weight: bold; cursor:pointer; }
        #social{text-align: center; border-collapse: separate; border-spacing: 0 30px;}
        #social td{width: 160px;}
        .socialBtn{width: 140px; height: 50px;}
        #enrollBtn{width: 505px; height: 42px; background-color: #0c70f2; border: none;
                border-radius: 5px; color: white; font-size: 17px; cursor:pointer;}
        #enrollBtn:hover{cursor:pointer;}
    </style>
</head>
<body>
    <div class="logo">
        <a href="${contextPath }">
        <img src="resources/assets/moco.png" width="250px">
        </a>
    </div>
    <h1 style="text-align: center;">MOCO에 오신 것을 환영합니다</h1>
    <h4 style="text-align: center;">MOCO는 소프트웨어 개발자를 위한 지식공유 플랫폼입니다</h4>
    <h4 style="text-align: center;">닉네임을 설정해주세요</h4>

    <form action="${contextPath}/login.me" method="post">

        <table style="margin: auto;" id="member">
            <tr>
                <td><label for="memberNickName">닉네임</label>
	            	<label class="check" id="checkNickName"></label>
            </tr>
            <tr>
                <td><input type="text" class="login" name="memberNickName" id="memberNickName" required></td>
            </tr>
	        <tr>
	        	<td style="text-align:right;"><span id="regExpNickName" style="display:none;">2자 이상의 영문 대소문자, 한글만 가능합니다.</span></td>
	        </tr>	            
	        <tr>
	            <td><br><button type="button" id="enrollBtn" disabled="disabled">회원가입</button></td>
	        </tr>
        </table>
    </form>        

<script>
	window.onload =()=>{
		
		// 닉네임 중복 확인
		document.getElementById('memberNickName').addEventListener('change',function(){
			const checkNickName = document.getElementById('checkNickName');
			const regExp4 = /^[a-zA-Zㄱ-힣][a-zA-Zㄱ-힣 ]{1,}$/;
			
			if(this.value.trim() == ''){
				checkNickName.innerText = '닉네임을 입력해주세요.';
				checkNickName.style.color = 'red';
			}else{
				$.ajax({
					url: '${contextPath}/checkNickName.me',
					data: {nickName: this.value},
					success:(data)=>{
						console.log(data);
						if(data.trim() == 'yes' && regExp4.test(this.value)){
							checkNickName.innerText = '사용 가능한 닉네임입니다.';
							checkNickName.style.color = 'green';
							isNickName = true;
						} else if(data.trim() == 'yes' && !regExp4.test(this.value)){
							checkNickName.innerText = '알맞은 닉네임을 입력하세요.'
							checkNickName.style.color = 'red';
							isNickName = false;
						} else if(data.trim() == 'no'){
							checkNickName.innerText = '이미 사용중인 닉네임입니다.'
    						checkNickName.style.color = 'red';
							isNickName = false;
    					}
					},
					error:(data)=>{
						console.log(data);
					}
				});
			}
		});
				
	}

</script>
</body>
</html>