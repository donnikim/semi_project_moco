<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>회원가입</title>
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
        #checkEmailBtn{width: 118px; height: 30px; border: none; margin-left: 3px;
                border-radius: 5px; color: rgb(124, 121, 121); font-size: 15px; border: 2px solid #0c70f2;}
        #checkEmail{width: 375px;}
        #checkCodeBtn{width: 118px; height: 30px; border: none; margin-left: 3px;
                border-radius: 5px; color: rgb(124, 121, 121); font-size: 15px; border: 2px solid #0c70f2; cursor: pointer}        
        
    </style>

</head>
<body>
    <div class="logo">
        <a href="${contextPath}">
        <img src="resources/assets/moco.png" width="250px">
        </a>
    </div>
    <form action="${ contextPath }/insertMember.me" method="POST" id='insertForm'>
       <table style="margin: auto;" id="member">
           <tr>
               <td><label for="memberId">아이디</label>
                  <label class="check" id="checkId"></label>
               </td>
           </tr>
           <tr>
               <td><input type="text" class="enroll" name="memberId" id="memberId" required></td>
           </tr>
           <tr>
              <td style="text-align:right;"><span id="regExpId" style="display:none;">6~12자 영문 대소문자, 숫자만 가능합니다.(영문으로 시작)</span></td>
           </tr>
           <tr>
               <td><label for="memberPwd">비밀번호</label>
                  <label class="check" id="checkRegPwd"></label></td>
           </tr>
           <tr>
               <td><input type="password" class="enroll" name="memberPwd" id="memberPwd" required></td>
           </tr>
           <tr>
              <td style="text-align:right;"><span id="regExpPwd" style="display:none;">6~12자 영문, 숫자, 특수기호 한가지 이상 포함해야합니다.</span></td>
           </tr>           
           <tr>
               <td><label for="memberPwd2">비밀번호 확인</label>
                  <label class="check" id="checkPwd"></label></td>
           </tr>
           <tr>
               <td><input type="password" class="enroll" name="memberPwd2" id="memberPwd2" required></td>
           </tr>
           <tr>
               <td><label for="memberName">이름</label>
               <label class="check" id="checkName"></label></td>
           </tr>
           <tr>
               <td><input type="text" class="enroll" name="memberName" id="memberName" required></td>
           </tr>
           <tr>
              <td style="text-align:right;"><span id="regExpName" style="display:none;">2자 이상의 영문 대소문자, 한글만 가능합니다.</span></td>
           </tr>           
           <tr>
               <td><label for="memberNickName">닉네임</label>
                  <label class="check" id="checkNickName"></label>
               </td>
           </tr>
           <tr>
               <td><input type="text" class="enroll" name="memberNickName" id="memberNickName" required></td>
           </tr>
           <tr>
              <td style="text-align:right;"><span id="regExpNickName" style="display:none;">2자 이상의 영문 대소문자, 한글만 가능합니다.</span></td>
           </tr>           
            <tr>
                <td><label for="memberEmail">이메일</label>
                   <label class="check" id="searchEmail"></label></td>
            </tr>
            <tr>
                <td><input type="email" class="enroll" name="memberEmail" id="memberEmail" required>
                   <button type="button" id="checkEmailBtn" disabled="disabled">인증번호 전송</button>
                </td>
            </tr>
            <tr>
                <td>
                   <input type="text" class="enroll" name="checkEmail" id="checkEmail" placeholder="인증번호 6자리를 입력해주세요" maxlength="6" disabled="disabled">
                   <button type="button" id="checkCodeBtn">인증번호 확인</button>
                  <br><label class="check" id="resultEmail">
                     </label>
                </td>
            </tr>    
           <tr>
               <td><br><br><button type="button" id="enrollBtn">회원가입</button></td>
           </tr>
   
       </table>
    
    </form>
    
    <script>
    
    
       window.onload =()=>{
          
          let isId, isPwd, isPwd2, isName, isNickName, isEmail, isEmailCheck = false;
          // 아이디 중복 확인
          document.getElementById('memberId').addEventListener('change',function(){
             
             const checkId = document.getElementById('checkId')

             const regExp1 = /^[a-zA-Z][a-zA-Z0-9]{5,11}$/;
            
             if(this.value.trim() == ''){
                checkId.innerText = '아이디를 입력해주세요'
                checkId.style.color = 'red';
             }else{
                $.ajax({
                   url: '${contextPath}/checkId.me',
                   data: {id:this.value},
                   success: (data)=>{
                      console.log(data);
                      if(data.trim() == 'yes' && regExp1.test(this.value)){
                         checkId.innerText = '사용 가능한 아이디입니다.';
                         checkId.style.color = 'green';
                         isId = true;
                      } else if(data.trim() == 'yes' && !regExp1.test(this.value)) {
                         checkId.innerText = '알맞은 아이디를 입력하세요.'
                         checkId.style.color = 'red';
                         isId = false;
                      } else if(data.trim() == 'no'){
                         checkId.innerText = '이미 사용중인 아이디입니다.'
                          checkId.style.color = 'red';
                         isId = false;
                       }
                   },
                   error: (data)=>{
                      console.log(data);
                   }
                });
             }
          });
          
          // 비밀번호 정규표현식
          const pwd1 = document.getElementById('memberPwd');
          const pwd2 = document.getElementById('memberPwd2');
          const regExp2 = /^(?=.*[a-zA-z])(?=.*[0-9])(?=.*[$`~!@$!%*#^?&\\(\\)\-_=+]).{5,11}$/
//           const regExp3 = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[$@$!%*#?&])[A-Za-z\d$@$!%*#?&]{5,11}$/
          
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
             
                if(regExp3.test(this.value)){
                   checkName.innerText = '사용 가능한 이름입니다.';
                   checkName.style.color = 'green';
                   isName = true;
                } else {
                   checkName.innerText = '알맞은 이름을 입력하세요.'
                   checkName.style.color = 'red';
                   isName = false;
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
          
          
          // 이메일 중복확인
         document.getElementById('memberEmail').addEventListener('change',function(){
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
                     checkEmailBtn.disabled = true;
                     checkEmailBtn.style.color = 'lightgray';
                     searchEmail.innerText = '이미 가입된 이메일입니다.'
                     searchEmail.style.color = 'red';
                     isEmail = false;
                  } else {
                    searchEmail.innerText = '이미 가입된 이메일입니다.'
                  }
               },
               error:(data)=>{
                  console.log(data);
               }
               
            })
         });
          
          // 인증번호 보내기
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
               isEmailCheck = true;
            } else{
               resultEmail.innerText  = '인증번호가 불일치합니다.';
               resultEmail.style.color = 'red';
               isEmailCheck = false;
            }
         });
          
          
          // 회원가입 버튼 활성화
         document.getElementById('enrollBtn').addEventListener('click',function(){
            const enrollBtn = document.getElementById('enrollBtn');
            
             if(isId && isPwd && isPwd2 && isName && isNickName && isEmail && isEmailCheck){
                document.getElementById('insertForm').submit();
             } else {
               alert('회원가입 폼에 맞춰주세요.');
               if(!isId){
                  document.getElementById('memberId').focus();
               }else if(!isPwd){
                  document.getElementById('memberPwd').focus();
               }else if(!isPwd2){
                  document.getElementById('memberPwd2').focus();
               }else if(!isName){
                  document.getElementById('memberName').focus();
               }else if(!isNickName){
                  document.getElementById('memberNickName').focus();
               }else if(!isEmail){
                  document.getElementById('memberEmail').focus();
               }else if(!isEmailCheck){
                  document.getElementById('checkEmail').focus();
               }
             }
         });
          
//           정규표현식 나타내기
          document.getElementById('memberId').addEventListener('focusin',function(){
             document.getElementById('regExpId').style.display='';
          });
          document.getElementById('memberId').addEventListener('focusout',function(){
             document.getElementById('regExpId').style.display='none';
          });
          
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
          
       }

         
    </script>
</body>
</html>