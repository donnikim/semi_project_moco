<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>내 정보 수정</title>
    <script src="https://code.jquery.com/jquery-3.6.1.min.js"></script>
    <style>
        .logo{text-align: center; margin-top: 50px;}
        .enroll{width: 500px; height: 30px; background-color: rgba(212, 216, 224, 0.925); border: none;
                border-radius: 5px; }
        #member{border-collapse: separate; border-spacing: 0 5px;}
        #member input{padding : 0 0 0 10px;}
        #enrollBtn{width: 505px; height: 32px; background-color: #0c70f2; border: none;
                border-radius: 5px; color: white; font-size: 17px; cursor:pointer;} 

        #social{text-align: center; border-collapse: separate; border-spacing: 0 30px;}
        #social td{width: 160px;}
        .socialBtn{width: 140px; height: 50px;}
        select{text-align: center; width: 160px; height: 30px; font-size: 17px;}
        
       	#memberEmail{width: 375px;}
        #checkEmailBtn{width: 118px; height: 35px; border: none; margin-left: 3px;
                border-radius: 5px; color: rgb(124, 121, 121); font-size: 15px; border: 2px solid #0c70f2;}

        .editBtn{width: 155px; height: 32px; background-color: #0c70f2; border: none;
                border-radius: 5px; color: white; font-size: 17px; cursor:pointer;} 
    </style>

</head>
<body>
	<jsp:include page="../main/nav.jsp"/>
   	<br><br><br><br><br><br><br><br><br><br>

    <form action='${ contextPath }/updateMember.me' method="POST">
	    <table style="margin: auto;" id="member">
	        <tr>
	            <td><label for="memberId">아이디</label>
	            	<label class="check" id="checkId"></label>
	            </td>
	        </tr>
	        <tr>
	            <td><input type="text" class="enroll" name="memberId" id="memberId" readonly value="${ loginUser.memberId }"></td>
	        </tr>
	        <tr>
	        </tr>
	        <tr>
	            <td><label for="memberPwd">새 비밀번호</label>
	            	<label class="check" id="checkRegPwd"></label></td>
	        </tr>
	        <tr>
	            <td><input type="password" class="enroll" name="memberPwd" id="memberPwd"></td>
	        </tr>
	        <tr>
	        	<td style="text-align:right;"><span id="regExpPwd" style="display:none;">6~12자 영문, 숫자, 특수기호 한가지 이상 포함해야합니다.</span></td>
	        </tr>	        
	        <tr>
	            <td><label for="memberPwd2">* 비밀번호 확인</label>
	            	<label class="check" id="checkPwd"></label></td>
	        </tr>
	        <tr>
	            <td><input type="password" class="enroll" name="memberPwd2" id="memberPwd2"></td>
	        </tr>
	        <tr>
	            <td><label for="memberName">* 이름</label>
					<label class="check" id="checkName"></label></td>
	        </tr>
	        <tr>
	            <td><input type="text" class="enroll" name="memberName" id="memberName" required value="${ loginUser.memberName }"></td>
	        </tr>
	        <tr>
	        	<td style="text-align:right;"><span id="regExpName" style="display:none;">2자 이상의 영문 대소문자, 한글만 가능합니다.</span></td>
	        </tr>	        
	        <tr>
	            <td><label for="memberNickName">* 닉네임</label>
	            	<label class="check" id="checkNickName"></label>
	            </td>
	        </tr>
	        <tr>
	            <td><input type="text" class="enroll" name="memberNickName" id="memberNickName" required value="${ loginUser.memberNickName }"></td>
	        </tr>
	        <tr>
	        	<td style="text-align:right;"><span id="regExpNickName" style="display:none;">2자 이상의 영문 대소문자, 한글만 가능합니다.</span></td>
	        </tr>	        
            <tr>
                <td><label for="memberEmail">* 이메일</label>
                	<label class="check" id="searchEmail"></label></td>
            </tr>
            <tr>
                <td><input type="email" class="enroll" name="memberEmail" id="memberEmail" required value=${ loginUser.memberEmail }>
                	<button type="button" id="checkEmailBtn" disabled="disabled">인증번호 전송</button>
                </td>
            </tr>
            <tr>
                <td>
	                <input type="text" class="enroll" name="checkEmail" id="checkEmail" placeholder="인증번호 6자리를 입력해주세요" maxlength="6" disabled="disabled">
		         	<br><label class="check" id="resultEmail"></label>
                </td>
            </tr>	 
	        <tr>
	            <td>
	            <br>
	            <button type="button" class="editBtn" id="editInfoBtn">수정하기</button>&nbsp;&nbsp;&nbsp;&nbsp;
	            <button type="reset" class="editBtn" id="resetBtn" onclick="location.href='${ contextPath }/editInfo.me'">초기화</button>&nbsp;&nbsp;&nbsp;&nbsp;
	            <button type="submit" class="editBtn" id="deleteMemberBtn">탈퇴하기</button></td>
	        </tr>
	
	    </table>
    
    </form>
	<hr>
    	<footer>
			<jsp:include page="/WEB-INF/views/main/footer.jsp" />
		</footer>
    <script>
    	window.onload =()=>{
    		
    		let isPwd2 = true;
    		let isName = true;
    		let isNickName = true;
    		let isEmail = true;
    		
    		// 비밀번호 정규표현식
    		const pwd1 = document.getElementById('memberPwd');
    		const pwd2 = document.getElementById('memberPwd2');
    		const regExp2 = /^(?=.*[a-zA-z])(?=.*[0-9])(?=.*[$`~!@$!%*#^?&\\(\\)\-_=+]).{5,11}$/
//     		const regExp3 = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[$@$!%*#?&])[A-Za-z\d$@$!%*#?&]{5,11}$/
    		if(pwd1.value.trim() == ''){
				isPwd2 = true;}
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
    		});
    		
    		
    		// 비밀번호 일치 확인
    		pwd2.addEventListener('change', function(){
	    		if(pwd1.value == pwd2.value){
	    			console.log('일치');
	    			checkPwd.innerText = '비밀번호가 일치합니다';
	    			checkPwd.style.color = 'green';
	    			isPwd2 = true;
	    			
	    		} else {
	    			console.log('불일치');
	    			checkPwd.innerText = '비밀번호가 일치하지 않습니다.';
	    			checkPwd.style.color = 'red';
	    			isPwd2 = false;
	    		}
    			
    		});
    		
    		// 이름
    		document.getElementById('memberName').addEventListener('change',function(){
    			
    			const regExp3 =  /^[a-zA-Zㄱ-힣][a-zA-Zㄱ-힣 ]{1,}$/;
    			
    			if(this.value == '${ loginUser.memberName }'){
       				checkName.innerText = '';
    			}else{
	       			if(regExp3.test(this.value)){
	       				checkName.innerText = '사용 가능한 이름입니다.';
	       				checkName.style.color = 'green';
	       				isName = true;
	       			} else {
	       				checkName.innerText = '알맞은 이름을 입력하세요.'
	       				checkName.style.color = 'red';
	       				isName = false;
	       			}
    			}
    		});
    		
    		
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
    							if(this.value == '${ loginUser.memberNickName }'){
	    							checkNickName.innerText = '';
	    							isNickName = true;
    							}else{
	    							checkNickName.innerText = '이미 사용중인 닉네임입니다.'
	        						checkNickName.style.color = 'red';
	    							isNickName = false;
    							}
        					}
    					},
    					error:(data)=>{
    						console.log(data);
    					}
    				});
    			}
    		});

    		
    		// 이메일 중복확인
    		document.getElementById('checkEmail').style.display='none';
			document.getElementById('memberEmail').addEventListener('change',function(){
    			document.getElementById('checkEmail').style.display='';
				const email = document.getElementById('memberEmail').value;
				console.log(email);
				const searchEmail = document.getElementById('searchEmail');
				const checkEmailBtn = document.getElementById('checkEmailBtn');
				const regExp5 = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i
				
				$.ajax({
					type: 'get',
					url: '${contextPath}/searchEmail.me',
					data: {memberEmail:email},
					success:(data)=>{
						console.log(data);
						if(data.trim() == 'yes' && regExp5.test(this.value)){
							checkEmailBtn.disabled = false;
							checkEmailBtn.style.cursor = 'pointer';
							checkEmailBtn.style.color = 'black';
							searchEmail.innerText = '사용 가능한 이메일입니다.';
							searchEmail.style.color = 'green';
							isEmail = true;
						} else if(data.trim() == 'yes' && !regExp5.test(this.value)){
							checkEmailBtn.disabled = true;
							checkEmailBtn.style.color = 'lightgray';
							searchEmail.innerText = '알맞은 이메일을 입력하세요.'
							searchEmail.style.color = 'red';
							isEmail = false;
						} else if(data.trim() == 'no'){
					    		document.getElementById('checkEmail').style.display='none';
								checkEmailBtn.disabled = true;
								checkEmailBtn.style.color = 'lightgray';
							if(this.value == '${ loginUser.memberEmail }'){
								searchEmail.innerText = ''
								isEmail = true;
							}else{
								searchEmail.innerText = '이미 가입된 이메일입니다.'
								searchEmail.style.color = 'red';
								isEmail = false;
							}
						}
					},
					error:(data)=>{
						console.log(data);
					}
					
				})
			});
    		
    		// 인증번호 보내기
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
					},
					error:(data)=>{
						console.log(data);
					}
					
				})
			});
			
    		// 인증번호 확인
			document.getElementById('checkEmail').addEventListener('change',function(){
				const inputEmail = this.value;
				const resultEmail = document.getElementById('resultEmail');
				const editInfoBtn = document.getElementById('editInfoBtn');
				
				if(inputEmail == code){
					resultEmail.innerText = '인증번호가 일치합니다.';
					resultEmail.style.color = 'green';
					editInfoBtn.disabled = false;
				} else{
					resultEmail.innerText  = '인증번호가 불일치합니다.';
					resultEmail.style.color = 'red';
					editInfoBtn.disabled = true;
				}
			});
    		
    		// 회원가입 버튼 활성화
			document.getElementById('editInfoBtn').addEventListener('click',function(){
	    		if(isName && isNickName && isPwd2 && isEmail){
					this.type = 'submit';
	    			alert('수정 완료되었습니다.');
				}else {
	    			alert('수정 폼에 맞춰주세요.');
	    			if(!isName){
						document.getElementById('memberName').focus();
					} else if(!isNickName){
						document.getElementById('memberNickName').focus();
					} else if(!isPwd2){
						document.getElementById('memberPwd2').focus();
					} else if(!isEmail){
						document.getElementById('memberEmail').focus();
					}
				}

			});
    		
//     		정규표현식 나타내기
    		document.getElementById('memberPwd').addEventListener('focusin',function(){
    			document.getElementById('regExpPwd').style.display='';
    		});
    		document.getElementById('memberPwd').addEventListener('focusout',function(){
    			document.getElementById('regExpPwd').style.display='none';
    		});
    		
    		document.getElementById('memberName').addEventListener('focusin',function(){
    			document.getElementById('regExpName').style.display='';
    		});
    		document.getElementById('memberName').addEventListener('focusout',function(){
    			document.getElementById('regExpName').style.display='none';
    		});
    		
    		document.getElementById('memberNickName').addEventListener('focusin',function(){
    			document.getElementById('regExpNickName').style.display='';
    		});
    		document.getElementById('memberNickName').addEventListener('focusout',function(){
    			document.getElementById('regExpNickName').style.display='none';
    		});
    		
			document.getElementById('deleteMemberBtn').addEventListener('click', ()=>{
				if(confirm('정말로 탈퇴하시겠습니까?')){
					location.href= '${contextPath}/deleteMember.me';
				}
			});
    	}

			
    </script>
</body>
</html>