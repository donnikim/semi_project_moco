<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>모코 메인페이지</title>
<link rel="stylesheet" href="resources/css/style.css?after">
<style>
#temp {
   height: 100px;
   weight: 100px;
}

#temp2 {
   position: relative;
   top: -20px;
}

.card-img-top {
	height: 15rem;
	object-fit: cover;
}
.infoList {
  	margin-left:100px;
  	z-index: 100;
	display: flex;
	flex-direction: column;
	justify-content: center;
	align-items: center;
}
</style>
<!-- JavaScript Bundle with Popper -->
<!-- CSS only -->
<link
   href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css"
   rel="stylesheet"
   integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65"
   crossorigin="anonymous">
<script
   src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
   integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4"
   crossorigin="anonymous"></script>

</head>
<body>
   <div class="container">
      <jsp:include page="/WEB-INF/views/main/nav.jsp" />
   </div>
   <hr>
   <!-- 배너 -->
   <div class="container2">
      <div class="main-view">
         <ul>
            <li><img src="resources/assets/banner1.png" width="100%" height="auto"  /></li>
            <li><img src="resources/assets/banner2.png" width="100%" height="auto" /></li>
            <li><img src="resources/assets/banner3.png" width="100%" height="auto" /></li>
         </ul>
      </div>
   </div>
   <!-- 정보 게시판 -->
   <h3 style="text-align: center">정보 게시판</h3>
   <div class="infoList">
      <div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 g-3">
         <c:forEach items="${iList }" var="i" begin="0" end="5">
            <div class="col">
               <div class="card shadow-sm" style="width: 25rem">

                  <c:forEach items="${aList }" var="a">
                     <c:if test="${i.infoNum eq a.attmRefboard }">

                        <img src="${contextPath }/resources/uploadFiles/${a.attmRename}"
                           class="card-img-top" alt="...">

                     </c:if>
                  </c:forEach>
                  <div class="card-body">

                     <c:set var="cName" value="${i.infoClassName}" />

                     <h5 class="card-title">${i.infoAcademyName }</h5>
                     <p class="card-text">
                        <b>카테고리</b>:${i.infoCategory}<br> <b>과정</b>:${fn:substring(cName,0,25)}
                        <c:if test="${fn:length(cName) gt 26}">...</c:if>
                     </p>
 					<a class="btn btn-primary" style="width:100%;" >바로 가기</a>
                     <input type="hidden" class="infoId" value="${i.infoNum }">
                     <input type="hidden" class="memberNum" value="${i.memberNum}">
                  </div>
               </div>
            </div>
         </c:forEach>
      </div>
   </div>

   <hr>
   <!-- 자유게시판 -->
   <h3 style="text-align: center">전체 게시판</h3>
   <div class="freecenter">
      <div class="freedisplay" id="area6">
         <div class="freedisplaytitle">
            자유 게시판
            <button type="button"
               style="float: right; border-color: white; box-shadow: none;"
               onclick="location.href='${contextPath}/boardFree.bo'">+</button>
         </div>
         <table class="table" id="BoardListT">
            <tr>
               <td>번호</td>
               <td style="width: 300px;">제목</td>
               <td>작성자</td>
            </tr>
            <tbody id="selectTbody1">
               <c:if test="${ Flist.size() != 0 }">
                  <c:forEach items="${ Flist }" var="b" begin="0" end="4">
                     <c:if test="${ b.boardCategory eq '자유'}">
                        <tr>
                           <c:if test="${ b.boardStatus eq 'Y' }">
                              <td>${ b.boardNum }</td>
                              <td>${ b.boardTitle }</td>
                              <td>${ b.nickName }</td>
                           </c:if>
                        </tr>
                     </c:if>
                  </c:forEach>
               </c:if>
            </tbody>
            <tbody>
               <c:if test="${ Flist.size() == 0 }">
                  <tr>
                     <td colspan="3" style="height: 100px;">게시물이 없습니다.</td>
                  </tr>
               </c:if>
            </tbody>
         </table>
      </div>
      <div class="freedisplay" id="area7">
         <div class="freedisplaytitle">
            Q&A 게시판
            <button type="button"
               style="float: right; border-color: white; box-shadow: none;"
               onclick="location.href='${contextPath}/boardQNA.bo'">+</button>
         </div>
         <table class="table" id="BoardListT">
            <tr>
               <td>번호</td>
               <td style="width: 300px;">제목</td>
               <td>작성자</td>
            </tr>
            <tbody id="selectTbody2">
               <c:if test="${ Qlist.size() != 0 }">
                  <c:forEach items="${ Qlist }" var="b" begin="0" end="4">
                     <c:if test="${ b.boardCategory eq 'QNA'}">
                        <tr>
                           <c:if test="${ b.boardStatus eq 'Y' }">
                              <td>${ b.boardNum }</td>
                              <td>${ b.boardTitle }</td>
                              <td>${ b.nickName }</td>
                           </c:if>
                        </tr>
                     </c:if>
                  </c:forEach>
               </c:if>
            </tbody>
            <tbody>
               <c:if test="${ Qlist.size() == 0 }">
                  <tr>
                     <td colspan="3" style="height: 100px;">게시물이 없습니다.</td>
                  </tr>
               </c:if>
            </tbody>
         </table>
      </div>
      <div class="freedisplay" id="area8">
         <div class="freedisplaytitle">
            후기 게시판
            <button type="button"
               style="float: right; border-color: white; box-shadow: none;"
               onclick="location.href='${contextPath}/boardReview.bo'">+</button>
         </div>
         <table class="table" id="BoardListT">
            <tr>
               <td>번호</td>
               <td style="width: 300px;">제목</td>
               <td>작성자</td>
            </tr>
            <tbody id="selectTbody3">
               <c:if test="${ Rlist.size() != 0 }">
                  <c:forEach items="${ Rlist }" var="b" begin="0" end="4">
                     <c:if test="${ b.boardCategory eq '후기'}">
                        <tr>
                           <c:if test="${ b.boardStatus eq 'Y' }">
                              <td>${ b.boardNum }</td>
                              <td>${ b.boardTitle }</td>
                              <td>${ b.nickName }</td>
                           </c:if>
                        </tr>
                     </c:if>
                  </c:forEach>
               </c:if>
            </tbody>
            <tbody>
               <c:if test="${ Rlist.size() == 0 }">
                  <tr>
                     <td colspan="3" style="height: 100px;">게시물이 없습니다.</td>
                  </tr>
               </c:if>
            </tbody>
         </table>
      </div>
   </div>
   <hr>
   <footer>
      <jsp:include page="/WEB-INF/views/main/footer.jsp" />
   </footer>
   <script>
window.onload=()=>{
   
   const tbody1 =  document.getElementById('selectTbody1');
   const tbody2 =  document.getElementById('selectTbody2');
   const tbody3 =  document.getElementById('selectTbody3');
   
   const tds1 = tbody1.querySelectorAll('td');
   const tds2 = tbody2.querySelectorAll('td');
   const tds3 = tbody3.querySelectorAll('td');
   
   const divs = document.getElementsByClassName('card');
   
   // 게시글 목록 추가
   for(const td of tds1){
      td.addEventListener('click', function(){
         const trTds = this.parentElement.querySelectorAll('td');
         const boardNum = trTds[0].innerText;
         const nickName = trTds[2].innerText;

         location.href  = '${contextPath}/selectBoard.bo?boardNum='+ boardNum+ "&nickName=" + nickName + "&page=" + ${pi.currentPage};
      });
   }
   
   for(const td of tds2){
      td.addEventListener('click', function(){
         const trTds = this.parentElement.querySelectorAll('td');
         const boardNum = trTds[0].innerText;
         const nickName = trTds[2].innerText;

         location.href  = '${contextPath}/selectBoard.bo?boardNum='+ boardNum+ "&nickName=" + nickName + "&page=" + ${pi.currentPage};
      });
   }
   
   for(const td of tds3){
      td.addEventListener('click', function(){
         const trTds = this.parentElement.querySelectorAll('td');
         const boardNum = trTds[0].innerText;
         const nickName = trTds[2].innerText;

         location.href  = '${contextPath}/selectBoard.bo?boardNum='+ boardNum+ "&nickName=" + nickName + "&page=" + ${pi.currentPage};
      });
   }
   
   for(const div of divs){
      div.addEventListener('click',function(){
         const input = this.querySelectorAll('input');
         
         const infoNum=input[0].value;
         const infoMem=input[1].value;
         
         location.href='${contextPath}/selectAttm.in?infoNum='+infoNum+'&infoMem='+infoMem+'&page='+${pi.currentPage};
         
         
      });
   }
 }
</script>
</body>
</html>