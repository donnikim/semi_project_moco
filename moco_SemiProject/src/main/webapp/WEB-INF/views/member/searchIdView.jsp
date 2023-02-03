<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>아이디 찾기</title>
    <script src="https://code.jquery.com/jquery-3.6.1.min.js"></script>
    
    <style>
        .logo{text-align: center; margin-top: 50px;}
        .findId{width: 500px; height: 40px; background-color: rgba(212, 216, 224, 0.925); border: none;
                border-radius: 5px; }
        #searchIdBtn{width: 505px; height: 42px; border: none;
                border-radius: 5px; color: rgb(124, 121, 121); font-size: 20px; border: 2px solid #0c70f2;} 
        #member{border-collapse: separate; border-spacing: 0 10px;}
        .search{border-style: none; height: 50px; border-color: rgba(187, 191, 197, 0.986); color: #0c70f2; font-weight: bold; border-radius: 5px;
                width: 130px; font-size: 16px;}
        #searchId{background-color: #0c70f2; color:white;}
        #member input{padding : 0 0 0 10px;}
        #btnBar{text-align: center; margin-right: 240px;}
        button:hover{cursor: pointer;}
 		#memberEmail{width: 375px;}
        #checkEmailBtn{width: 118px; height: 35px; border: none; margin-left: 3px;
                border-radius: 5px; color: rgb(124, 121, 121); font-size: 15px; border: 2px solid #0c70f2;}
		#checkEmail{width: 375px;}
        #checkCodeBtn{width: 118px; height: 35px; border: none; margin-left: 3px;
                border-radius: 5px; color: rgb(124, 121, 121); font-size: 15px; border: 2px solid #0c70f2; cursor: pointer}        

    </style>
</head>
<body>
    <div class="logo">
        <a href="${contextPath }">
        <img src="resources/assets/moco.png" width="250px">
        </a>
    </div>

    <div id="btnBar">
        <button type="button" class="search" id="searchId" style="margin: auto;" onclick="location.href='${contextPath}/searchIdView.me'">아이디 찾기</button>
        <button type="button" class="search" id="searchPwd" style="margin: auto;" onclick="location.href='${contextPath}/searchPwdView.me'">비밀번호 찾기</button>
        
    </div>
    <br>
    <h1 style="text-align: center;">아이디 찾기</h1>
    <h4 style="text-align: center;">이름, 가입 이메일을 이용해서 비밀번호를 확인하실수 있습니다.</h4>


    <form action="${contextPath}/searchId.me" method="post">
        <div id="searchIdBox">
            <table style="margin:auto;" id="member">
                <tr>
                    <td><label for="memberName">이름</label>
                </tr>
                <tr>
                    <td><input type="text" class="findId" name="memberName" id="memberName" required></td>
                </tr>
	            <tr>
	                <td><label for="memberEmail">이메일</label>
	                	<label class="check" id="searchEmail"></label></td>
	            </tr>
                <tr>
                    <td><input type="email" class="findId" name="memberEmail" id="memberEmail" required>
                    	<button type="button" id="checkEmailBtn">인증번호 전송</button>
                    </td>
                </tr>
                <tr>
                    <td>
                    <input type="text" class="findId" name="checkEmail" id="checkEmail" placeholder="인증번호 6자리를 입력해주세요" maxlength="6" disabled="disabled">
		                <button type="button" id="checkCodeBtn">인증번호 확인</button>                    
		            	<br><label class="check" id="resultEmail">
	            	</label>
                    </td>
                </tr>
                <tr>
                    <td><br><button id="searchIdBtn" disabled="disabled">아이디 찾기</button></td>
                </tr>
            </table>
        </div>
	</form>

	<script>
		window.onload = () =>{
    		// 이메일 정규표현식
			document.getElementById('memberEmail').addEventListener('change',function(){
				const searchEmail = document.getElementById('searchEmail');
				const checkEmailBtn = document.getElementById('checkEmailBtn');
				const regExp5 = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i
				
				if(regExp5.test(this.value)){
					checkEmailBtn.disabled = false;
					checkEmailBtn.style.cursor = 'pointer';
					checkEmailBtn.style.color = 'black';
					searchEmail.innerText = ''
				} else if(!regExp5.test(this.value)){
					checkEmailBtn.disabled = true;
					checkEmailBtn.style.color = 'lightgray';
					searchEmail.innerText = '알맞은 이메일을 입력하세요.'
					searchEmail.style.color = 'red';
				}
			});
			
			// 인증메일 전송
    		document.getElementById('checkEmail').style.display='none';
    		document.getElementById('checkCodeBtn').style.display='none';
			document.getElementById('checkEmailBtn').addEventListener('click',function(){
				const email = document.getElementById('memberEmail').value;
				console.log(email);
				const checkEmail = document.getElementById('checkEmail');
				
				$.ajax({
					type: 'get',
					url: '${contextPath}/checkEmail.me',
					data: {memberEmail:email},
					success:(data)=>{
						console.log(data);
						checkEmail.disabled = false;
						code = data;
						alert('인증번호가 전송되었습니다.');
						document.getElementById('checkCodeBtn').style.color = 'black';
						document.getElementById('checkEmail').style.display='';
			    		document.getElementById('checkCodeBtn').style.display='';
					},
					error:(data)=>{
						console.log(data);
					}
					
				})
			});
			
			// 인증번호 확인
			document.getElementById('checkCodeBtn').addEventListener('click',function(){
				const inputEmail = document.getElementById('checkEmail').value;
				const resultEmail = document.getElementById('resultEmail');
				
				if(inputEmail == code){
					resultEmail.innerText = '인증번호가 일치합니다.';
					resultEmail.style.color = 'green';
					document.getElementById('searchIdBtn').disabled = false;
				} else{
					resultEmail.innerText  = '인증번호가 불일치합니다.';
					resultEmail.style.color = 'red';
					document.getElementById('searchIdBtn').disabled = true;
				}
			});
			
		}
			
	</script>

</body>
</html>