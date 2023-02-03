<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>MOCO</title>
    <script src="https://code.jquery.com/jquery-3.6.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3" crossorigin="anonymous"></script>
   <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">
<style>
        #footD{border: 1px solid black;}

        table#tableT{margin-left: auto; margin-right: auto;}
        table{text-align: center;}
        table th, td{height: 40px; padding:5px; width: 70px; text-align: center; border: 1px solid black;}
        table th{font-weight: 750;}
        table td{text-align: left;}
        #writer{width: 200px; text-align: left;}

        input{border: 0.5px solid lightgray; border-radius: 3px; height: 30px;}
        input:focus{ outline: none !important; border-color: rgb(106, 140, 153); box-shadow: 0 0 10px rgb(180, 185, 187);}
        textarea:focus{outline: none !important; border-color: rgb(106, 140, 153); box-shadow: 0 0 10px rgb(180, 185, 187);}

        #tableT{margin-right: 10%;}
        
        button{border: none; background-color: rgba(100, 102, 104, 0.925); color: white;
            width: 100px;  height: 30px; border-radius: 5px; font-size: 15px; font-weight: 300;
        }
        button:hover{background-color: rgb(104, 81, 81); color: white;}
        #goList{background-color: lightgray; color: black;}
        #goList:hover{background-color: rgb(104, 81, 81); color: white;}

        #title{width: 500px;}

        textarea{border: 1px solid lightgray; background-color: white; border-radius: 5px; resize: none;}
        
        .filebox label {
        display: inline-block;
        padding: .5em .75em;
        color: white;
        font-size: inherit;
        line-height: normal;
        vertical-align: middle;
        background-color: rgb(106, 140, 153);
        cursor: pointer;
        border: 1px solid #ebebeb;
        border-bottom-color: #e2e2e2;
        border-radius: .25em;
      }
      .filebox label:hover{
            background-color: aliceblue;
            color:black
      }
      .filebox input[type="file"] {  /* 파일 필드 숨기기 */
        position: absolute;
        width: 1px;
        height: 1px;
        padding: 0;
        margin: -1px;
        overflow: hidden;
        clip:rect(0,0,0,0);
        border: 0;
      }
      
      #viewCount{
         background-color: white;
         border: none;
         width: 30px;
      }
      
      input.anonymity{
         width: 20px;
         height: 20px; 
      }
      
      #category{
         height: 30px;
         width: 250px;
         border-radius: 5px;
      }      
      
         .detailTable{margin: auto; text-align: center;}
      .detailTable th{border-bottom: 3px solid lightgray;}
      .detailTable td{border-bottom: 3px solid lightgray;}
      
      #bookmark{
        display: block;
        margin-left: auto;
        margin-right: auto;
        width: 35%;
      }
      
      #siren{
        display: block;   
        margin-left: auto;
        margin-right: auto;
        width: 50%;
      }
    </style>
</head>
<body>
   <div id="header">
      <jsp:include page="/WEB-INF/views/main/nav.jsp" />
   </div>
   <br><br><br><br><br><br>
   <br><br><br>
   <div id="tableD">
      <form method="post" id="detailForm">
         <table id="tableT">
            <tr>
               <th>제목</th>
               <td colspan="6" style="width: 400px;"><input type="text"
                  id="title" name="boardTitle" readonly value="${ b.boardTitle }">
                  <input type="hidden" name="boardNum" value="${ b.boardNum }">
                  <input type="hidden" name="page" value="${ page }" >
                  <input type="hidden" name="scrap" id="scrap" value="NN">
                  <input type="hidden" id = "boardDetailNum" value=${b.boardNum }>
                  <input type="hidden" name="mNum" value="${ loginUser.memberNum }">
               </td>
               <th colspan="2" style="width: 10px;">카테고리</th>
               <td colspan="3" style="text-align: center;"><c:if
                     test="${ b.boardAnonymity eq 'N' }">
                     ${b.boardCategory }
                  </c:if> <c:if test="${ b.boardAnonymity ne 'N' }">
                     익명
                  </c:if></td>
            </tr>
            <tr>
               <th>작성자</th>
               <td colspan="3" style="text-align: left;"><input type="text"
                  id="write" name="boardWriter" readonly
                  <c:if test="${ b.boardAnonymity eq 'N'}">value="${ b.nickName }"</c:if>
                  <c:if test="${ b.boardAnonymity ne 'N' }">value="익명"</c:if>>
                  <input type="hidden" name="anonickName" value="${ b.nickName }">
               </td>
               <th>작성일</th>
               <td colspan="2" style="text-align: left;"><input type="text"
                  id="date" name="boardCreateDate" readonly value="${ b.boardModifyDate }"></td>
               <th colspan="2" style="text-align: center;">조회수</th>
               <td style="text-align: center; width: 10px;">${b.boardView }</td>
               <c:if test="${ loginUser ne null }">
                  <c:if test="${ loginUser.memberIsAdmin eq 'N' }">
                     <td>
                        <c:if test="${ scrapRList[0].boardNum eq b.boardNum }">
                           <img src="resources/assets/bookmark_check.png" id="bookmark">
                        </c:if>
                        <c:if test="${ scrapRList[0].boardNum ne b.boardNum }">
                           <img src="resources/assets/bookmark.png" id="bookmark">
                        </c:if>
                     </td>
                     <c:if test="${  b.boardReport eq 'Y' }">
                        <td><img src="resources/assets/siren_check.png" id="siren"></td>
                  </c:if>
                  <c:if test="${  b.boardReport eq 'N' }">
                        <td><img src="resources/assets/siren.png" id="siren"></td>
                  </c:if>
                 
                  </c:if>
               </c:if>
            </tr>
            <tr>
               <td colspan="12" style="text-align: center;"><textarea
                     id="content" cols="130" rows="30" name="boardContent" readonly>${ b.boardContent }</textarea>
               </td>
            </tr>

            <!-- foreach문 돌려서 첨부파일 뿌려야함 -->
            <tr>
               <th style="width: 80px;">첨부 파일</th>
               <td colspan="11">
                  <c:forEach items="${ alist }" var="a">
                     <div class="card-body">
                        <h5 class="card-title">
                           <a href="${ contextPath }/resources/uploadFiles/${ a.attmRename }" download="${ a.attmOriginName }"> 
                              ${ a.attmOriginName } 
                           </a>
                        </h5>
                     </div>
                  </c:forEach>
               </td>
            </tr>


            <tr>
             	<c:if test="${ loginUser.memberNickName eq b.nickName && loginUser.memberIsAdmin ne 'Y' }">
						<td colspan="12" style="text-align: center;">
							<button id="updateForm" onclick="${contextPath}/updateForm.bo">수정</button>
							&emsp;&emsp; &emsp;&emsp;
							<button type="button" id="goList">목록</button>
						</td>
					</c:if>
					<c:if test="${ loginUser.memberNickName ne b.nickName && loginUser.memberIsAdmin ne 'Y' }">
						<td colspan="12" style="text-align: center;">
							<button type="button" id="goList">목록</button>
						</td>
					</c:if>
             
             
               <c:if test="${ loginUser.memberIsAdmin eq 'Y'}">
                     <td colspan="11" style="text-align: center;">
                     <button id="report" type="button">신고처리</button>
                     &emsp;&emsp; &emsp;&emsp;
                     <button id="goList">목록</button>
                     
                  </td>
               </c:if>
            </tr>
         </table>

         <br>
         <table class="detailTable">
            <c:if test="${ !empty loginUser }">
               <tr>
                  <td style="text-align: center;"><textarea id="replyContent" cols="80" rows="5"></textarea></td>
                  <td><button id="replySubmit">등록하기</button></td>
               </tr>
            </c:if>
            <tr>
               <td colspan="2" style="width:880px;"><b>댓글(${ rCount })</b></td>
            </tr>
         </table>
         <!-- 댓글 출력 부분 -->
         <!-- 댓글 개수가 0개보다 크면 -->
         <c:if test="${ rCount > 0 }">
            <table class="detailTable">
               <!-- 댓글 닉네임(100px), 댓글 내용(400px), 댓글 작성일자(150px) 출력  -->
                  <tr>
                     <th>작성자</th>
                     <th>내용</th>
                     <th>작성일자</th>
                  </tr>
                  <tbody id="replyTbody">
                     <c:forEach items="${ list }" var="r">
                        <tr>
                           <c:if test="${ r.replyAnonymity eq 'Y' }">
                              <td style="width: 50px; text-align: center;">익명</td>
                           </c:if>
                           <c:if test="${ r.replyAnonymity eq 'N' }">
                              <td style="width: 50px; text-align: center;">${ r.nickName}</td>
                           </c:if>
                           <td style="width: 700px;">${ r.replyContent }</td>
                           <td style="width: 90px; text-align: center;">${ r.replyModifyDate }</td>
                        </tr>
                     </c:forEach>
                  </tbody>
            </table>
         </c:if>
      </form>

   </div>
   <br><br><br><br><br><br>
    <div id="footD"><jsp:include page="/WEB-INF/views/main/footer.jsp" /></div>

   <script>
      window.onload=()=>{
         // 게시판 수정
         const upd = document.getElementById('updateForm');
         const form = document.getElementById('detailForm');
         if(upd != null){
            upd.addEventListener('click',()=>{
               form.action = '${contextPath}/updateForm.bo';
               form.submit();
            });
         }
         if(${ !empty loginUser }){
            //       댓글 등록
            document.getElementById('replySubmit').addEventListener('click', ()=>{
               console.log("댓글 버튼 확인");
               $.ajax({
                     url: '${contextPath}/insertReply.bo',
                     data: {replyContent:document.getElementById('replyContent').value,
                        boardNum: ${b.boardNum}, nickName: '${loginUser.memberId}',
                        replyAnonymity: '${ b.boardAnonymity }', memberNum: '${ loginUser.memberNum}'},
                     success:(data)=>{
                        console.log(data);
                        const tbody = document.getElementById('replyTbody');
//                            console.log(tbody);
                        tbody.innerText = '';
                           
                        for(const r of data){
                           const writerTd = document.createElement('td');
                           writerTd.innerText = r.nickName;
                              
                           const contentTd = document.createElement('td');
                           contentTd.innerText = r.replyContent;
                              
                           const dateTd = document.createElement('td');
                           dateTd.innerText = r.replyModifyDate;
                              
                           tr.append(writerTd);
                           tr.append(contentTd);
                           tr.append(dateTd);
                              
                           tbody.append(tr);
                        }
                        // 입력 후 댓글 창 초기화
                        document.getElementById('replyContent').value = "";
                     },
                     error:(data)=>{
                        console.log(data);
                     }
                  });
               });
         }
         // 스크랩   
         const scrap = document.getElementById('scrap');
         if('${loginUser.memberIsAdmin}' == 'N'){
            const bmarkBtn = document.getElementById('bookmark');
            bmarkBtn.addEventListener('click', ()=>{
               const check = bmarkBtn.src;
               if(check.includes("bookmark_check")){
                  // 북마크 비활성화 상태
                  console.log("비활성화");
                  bmarkBtn.src = "resources/assets/bookmark.png";
                  scrap.value = 'NN';
                  console.log(scrap.value);
               }else{
                  // 북마크 활성화 상태
                  console.log("활성화");
                  bmarkBtn.src = "resources/assets/bookmark_check.png"; 
                  scrap.value = 'Y';
                  console.log(scrap.value);
               }
            });
         }
         
         // 목록으로 가기
         const gobtn = document.getElementById('goList');
         gobtn.addEventListener('click', ()=>{
               gobtn.setAttribute("type", "button");
            if(scrap.value == 'Y'){
               gobtn.setAttribute("type", "submit");
               form.action = "${ contextPath }/insertScrap.bo";
               form.submit;
               
               scrap.value="N";
            }else if(scrap.value == 'N' || scrap.value == 'NN'){
               form.action = history.back();
                    form.submit;
            }
         });
         
         if(${loginUser.memberIsAdmin eq 'Y'}){
             const reportBtn = document.getElementById('report');
              
              reportBtn.addEventListener('click', ()=>{
                  
                  const boardDetailNum = document.getElementById('boardDetailNum').value;
                  
                  if(window.confirm("최종 신고 처리를 하시겠습니까?")){
                     // 관리자 최종 신고처리
                     location.href="${contextPath}/reportBoardAdmin.bo?boardDetailNum="+boardDetailNum;
                     alert("신고처리가 정상적으로 처리되었습니다.");
                     
                    
                  }else{
                     //  관리자 신고 취소
                      location.href="${contextPath}/reportBoardAdmin2.bo?boardDetailNum="+boardDetailNum;
                     alert("신고처리를 취소하였습니다.");
                  }
               });
           }
		         
         if(${ !empty loginUser && loginUser.memberIsAdmin ne 'Y' }){
             
      
          const smarkBtn = document.getElementById('siren');
          
          smarkBtn.addEventListener('click', ()=>{
             
             const check = smarkBtn.src;
             const boardDetailNum = document.getElementById('boardDetailNum').value;
             
             if(check.includes("siren_check")){
                 // 게시글 신고
                smarkBtn.src = "resources/assets/siren.png";
             }else{
                //  게시글 신고 확인
                smarkBtn.src = "resources/assets/siren_check.png";
             location.href="${contextPath}/reportBoard.bo?boardDetailNum="+boardDetailNum;
             }
             });
          }
         
         
         
         
         
         
         
         
     
         
         
      }
   </script>
</body>
</html>