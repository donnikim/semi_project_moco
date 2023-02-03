<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="kr">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>게시판</title>
<style>
.table {
   margin: auto;
}

.table td {
   width: 100px;
   text-align: center;
   height: 50px;
}

.table th {
   width: 150px;
   text-align: center;
   width: 325px;
}

#BoardListT {
   border-top: 2px solid black;
   width: 70%;
}

#BoardListT td {
   border-bottom: 1.5px solid black;
   width: 100px;
   height: 50px;
}

#BoardListT th {
   width: 150px;
   text-align: center;
   width: 325px;
}

.BoardList button {
   border: none;
}

#unknown {
   background-color: white;
   font-size: 18px;
   font-weight: 400;
}

#qNa {
   background-color: white;
   font-size: 18px;
   font-weight: 400;
}

#review {
   background-color: white;
   font-size: 18px;
   font-weight: 400;
}

#boardWrite {
   border: none;
   background-color: rgba(149, 156, 171, 0.925);
   color: black;
   border-radius: 10px;
   height: 35px;
   width: 150px;
   text-align: center;
}

#boardWrite:hover {
   background-color: darkblue;
   color: white;
}

#searchText {
   border: none;
   width: 400px;
   height: 25px;
   border-radius: 5px;
   background-color: lightgray;
}

#searchText::placeholder {
   text-align: center;
   color: black;
}

#searchBtn {
   width: 100px;
   height: 30px;
   border: none;
   border-radius: 5px;
   background-color: rgba(149, 156, 171, 0.925);
}

#searchBtn:hover {
   background-color: darkblue;
   color: white;
}

#number {
   text-align: center;
}

#header {
   border: 1px solid black;
}

#footD {
   border: 1px solid black;
}

.pagination li {
   display: inline;
   text-align: center;
}

.page {
   padding-top: 25px;
   text-align: center;
}

.page {
   padding: 3px;
   MARGIN: 3px;
   TEXT-ALIGN: center
}

.page A {
   padding: 5px 8px 4px 8px;
   MARGIN: 2px;
   BORDER: #ccc 1px solid;
   COLOR: #999;
   TEXT-DECORATION: none
}

.page A:hover {
   BORDER: #999 1px solid;
   COLOR: #666;
}

.page A:active {
   BORDER: #999 1px solid;
   COLOR: #666;
}
</style>


</head>
<body>
   <header>
      <jsp:include page="/WEB-INF/views/main/nav.jsp" />
   </header>
   <br>
   <br>
   <br>
   <br>
   <br>
   <br>
   <hr>
   <div class="BoardList">
      <table class="table" id="CategoryT">
         <tr style="height: 50px;">
            <c:if test="${ !empty loginUser }">
               <th>
                  <button type="button" id="boardWrite"
                     onclick="location.href='${contextPath}/boardWrite.bo'">
                     + &emsp;게시글 작성</button>
               </th>
            </c:if>
               <c:if test="${ boardCategory == 'main' }">
               <th>
                  <button type="button" id="free" onclick="location.href='${contextPath}/boardFree.bo'">자유게시판</button>
               </th>
               <th>
                  <button type="button" id="unknown" onclick="location.href='${contextPath}/boardUnKnown.bo'">익명게시판</button>
               </th>
               <th>
                  <button type="button" id="Q&A" onclick="location.href='${contextPath}/boardQNA.bo'">Q & A 게시판</button>
               </th>
               <th>
                  <button type="button" id="review" onclick="location.href='${contextPath}/boardReview.bo'">후기 게시판</button>
               </th>
               </c:if>
               <c:if test="${ boardCategory == '자유' }">
               <th>
                  <button type="button" id="free" onclick="location.href='${contextPath}/boardFree.bo'" style="background-color:black; color:white;">자유게시판</button>
               </th>
               <th>
                  <button type="button" id="unknown" onclick="location.href='${contextPath}/boardUnKnown.bo'">익명게시판</button>
               </th>
               <th>
                  <button type="button" id="Q&A" onclick="location.href='${contextPath}/boardQNA.bo'">Q & A 게시판</button>
               </th>
               <th>
                  <button type="button" id="review" onclick="location.href='${contextPath}/boardReview.bo'">후기 게시판</button>
               </th>
               </c:if>
               <c:if test="${ boardCategory == '익명' }">
                  <th>
                  <button type="button" id="free" onclick="location.href='${contextPath}/boardFree.bo'">자유게시판</button>
               </th>
               <th>
                  <button type="button" id="unknown" onclick="location.href='${contextPath}/boardUnKnown.bo'" style="background-color:black; color:white;">익명게시판</button>
               </th>
               <th>
                  <button type="button" id="Q&A" onclick="location.href='${contextPath}/boardQNA.bo'">Q & A 게시판</button>
               </th>
               <th>
                  <button type="button" id="review" onclick="location.href='${contextPath}/boardReview.bo'">후기 게시판</button>
               </th>
               </c:if>
               <c:if test="${ boardCategory == 'QNA' }">
                  <th>
                  <button type="button" id="free" onclick="location.href='${contextPath}/boardFree.bo'">자유게시판</button>
               </th>
               <th>
                  <button type="button" id="unknown" onclick="location.href='${contextPath}/boardUnKnown.bo'">익명게시판</button>
               </th>
               <th>
                  <button type="button" id="Q&A" onclick="location.href='${contextPath}/boardQNA.bo'" style="background-color:black; color:white;">Q & A 게시판</button>
               </th>
               <th>
                  <button type="button" id="review" onclick="location.href='${contextPath}/boardReview.bo'">후기 게시판</button>
               </th>
               </c:if>
               <c:if test="${ boardCategory == '후기' }">
                  <th>
                  <button type="button" id="free" onclick="location.href='${contextPath}/boardFree.bo'">자유게시판</button>
               </th>
               <th>
                  <button type="button" id="unknown" onclick="location.href='${contextPath}/boardUnKnown.bo'">익명게시판</button>
               </th>
               <th>
                  <button type="button" id="Q&A" onclick="location.href='${contextPath}/boardQNA.bo'">Q & A 게시판</button>
               </th>
               <th>
                  <button type="button" id="review" onclick="location.href='${contextPath}/boardReview.bo'" style="background-color:black; color:white;">후기 게시판</button>
               </th>
               </c:if>
         </tr>
      </table>
      <br>
      <table class="table" id="BoardListT">
         <tr style="height: 50px;">
            <td colspan="6"><select id="searchCondition"
               name="searchCondition">
                  <c:if test="${ boardCategory ne '익명' }">
                  <option value="writer">작성자</option>
                  </c:if>
                  <option value="title" selected>제목</option>
                  <option value="content">내용</option>
            </select> <input type="search" id="searchText" name="searchName"
               placeholder="검색어를 입력하세요">
               <button type="button" id="searchBtn" onclick="searchBoard();">검색하기</button>
               <input type="hidden" id="boardCategory" value="${ boardCategory }">
            </td>
         </tr>
         <tr>
            <td>글 번호</td>
            <c:if test="${ boardCategory eq 'main' }">
               <td>카테고리</td>
            </c:if>
            <td style="width: 500px;">글 제목</td>
            <td>작성자</td>
            <td>작성일자</td>
            <td>조회수</td>
         </tr>
         <tbody id="selectTbody">
            <c:forEach items="${ list }" var="b">
               <tr>
                     <td>${ b.boardNum }</td>
                     <c:if test="${ boardCategory eq 'main' }">
                        <td>${ b.boardCategory }</td>
                     </c:if>
                     <td>${ b.boardTitle }</td>
                     <c:if test="${ b.boardAnonymity eq 'N'}">
                        <td>${ b.nickName }</td>
                     </c:if>
                     <c:if test="${b.boardAnonymity ne 'N'}">
                        <c:if test="${ boardCategory eq '익명' }">
                           <td>익명</td>
                        </c:if>
                     </c:if>
                     <td>${ b.boardModifyDate }</td>
                     <td>${ b.boardView }</td>
               </tr>
            </c:forEach>
         </tbody>
      </table>
   </div>
   <div class="page">
      <ul class="pagination">
         <li class="page-item"><c:url var="goBack" value="${ loc }">
               <c:if test="${pi.currentPage>1 }">
                  <c:param name="searchCondition" value="${ searchCondition }"></c:param>
                  <c:param name="searchValue" value="${ searchValue }"></c:param>
                  <c:param name="boardCategory" value="${ boardCategory }"></c:param>
                  <c:param name="boardAnonymity" value="${ boardAnonymity }"></c:param>
                  <c:param name="page" value="${ pi.currentPage-1 }"></c:param>
               </c:if>
            </c:url> <a class="page-link" href="${ goBack }" aria-label="Previous">
               <span aria-hidden="true">&laquo;</span>
         </a></li>
         <c:forEach begin="${ pi.startPage }" end="${ pi.endPage }" var="p">
            <c:url var="goNum" value="${ loc }">
               <c:param name="searchCondition" value="${ searchCondition }"></c:param>
                  <c:param name="searchValue" value="${ searchValue }"></c:param>
                  <c:param name="boardCategory" value="${ boardCategory }"></c:param>
                  <c:param name="boardAnonymity" value="${ boardAnonymity }"></c:param>
                  <c:param name="page" value="${ p }"></c:param>
            </c:url>
            <li class="page-item"><a class="page-link" href="${ goNum }">${ p }</a></li>
         </c:forEach>
         <li class="page-item"><c:url var="goNext" value="${ loc }">
               <c:if test="${pi.endPage > pi.currentPage }">
                  <c:param name="searchCondition" value="${ searchCondition }"></c:param>
                  <c:param name="searchValue" value="${ searchValue }"></c:param>
                  <c:param name="boardCategory" value="${ boardCategory }"></c:param>
                  <c:param name="boardAnonymity" value="${ boardAnonymity }"></c:param>
                  <c:param name="page" value="${ pi.currentPage+1 }"></c:param>
               </c:if>
            </c:url> <a class="page-link" href="${ goNext }" aria-label="Next"> <span
               aria-hidden="true">&raquo;</span>
         </a></li>
      </ul>
   </div>
   <hr>
   <footer>
      <jsp:include page="/WEB-INF/views/main/footer.jsp" />
   </footer>

   <script>
    window.onload=()=>{
            
      const tbody =  document.getElementById('selectTbody');
       
       const tds = tbody.querySelectorAll('td');
      
      // 게시글 목록 추가
       for(const td of tds){
          td.addEventListener('click', function(){
             const trTds = this.parentElement.querySelectorAll('td');
             const boardNum = trTds[0].innerText;
             const nickName = trTds[3].innerText;
             location.href  = '${contextPath}/selectBoard.bo?boardNum='+ boardNum+ "&nickName=" + nickName + "&page=" + ${pi.currentPage};
          });
       }
    }
    
    const searchBoard = () =>{
         
         const searchCondition = document.getElementById('searchCondition').value;
         const searchValue = document.getElementById('searchText').value;
         const boardCategory = document.getElementById('boardCategory').value;
         var boardAnonymity =null;
         if(boardCategory !='익명'){
            boardAnonymity = "N"
         }
         if(boardCategory =='익명'){
            boardAnonymity = "Y"
         }
         
         location.href='${contextPath}/Search.bo?searchCondition='+searchCondition+"&searchValue=" + searchValue+"&boardCategory=" + boardCategory+"&boardAnonymity="+boardAnonymity;

      }
      
   </script>
</body>
</html>