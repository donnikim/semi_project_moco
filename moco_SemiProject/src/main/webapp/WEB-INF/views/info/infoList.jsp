<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!doctype html>
<html lang="en">

<head>
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">

<title>모코_정보게시판</title>
 <link rel="stylesheet" href="resources/css/style.css?after">
<style>
.infoList {
	z-index: 100;
	display: flex;
	flex-direction: column;
	justify-content: center;
	align-items: center;
}

.infomation {
  
  	background-image: linear-gradient(0deg, rgba(0, 0, 0, 0.5), rgba(0, 0, 0, 0.5)), url("https://t1.daumcdn.net/cfile/tistory/99DFED4A6010BC5C09");
	margin-top: 160px;
	background-color: pink;
	width: 100%;
	height: 250px;
	background-position: center;
	background-size: cover;
	color: white;
	display: flex;
	flex-direction: column;
	justify-content: center;
	align-items: center;
}

.infomation>button {
	width: 200px;
	height: 50px;
	background-color: transparent;
	color: white;
	border-radius: 50px;
	border: 1px solid white;
	margin-top: 10px;
}

.pagination {
	display: flex;
	flex-direction: rows;
	justify-content: center;
	align-items: center;
}

.infomation>button:hover {
	border: 5px solid white;
	font-weight: bold;
}

.btn btn-primary {
	display: flex;
	flex-direction: column;
	justify-content: center;
	align-items: center;
}

.category {
	margin-top: 30px;
	margin-bottom: 30px;
	display: flex;
	flex-direction: rows;
	justify-content: center;
	align-items: center;
}

table {
	border-spacing: 25px;
	border-collapse: separate;
}

.card-img-top {
	height: 15rem;
	object-fit: cover;
}

.col {
	display: flex;
	flex-direction: rows;
	justify-content: center;
	align-items: center;
}
</style>
<!-- CSS only -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65"
	crossorigin="anonymous">
<!-- JavaScript Bundle with Popper -->
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4"
	crossorigin="anonymous"></script>
</head>
 <link rel="stylesheet" href="resources/css/style.css?after">



<body>
	<div class="navBar">
		<jsp:include page="/WEB-INF/views/main/nav.jsp" />
	</div>
	<main>
	<div class='infomation'>
		<h1>정보게시판</h1>
		<c:if test="${!empty loginUser }">
			<button onclick="location.href='${contextPath}/insertInfo.in'">게시글
				요청</button>
		</c:if>
	</div>
	
	<div class="category">

		<button class="btn-secondary" type="button" onclick="location.href='${contextPath}/infoList.in'"> 최신순 </button>&nbsp;&nbsp;
		<button class="btn-secondary" type="button" onclick="location.href='${contextPath}/selectCount.in'"> 조회순 </button>

	</div>
	
	<div class="album py-5 bg-light">
	
		<div class="container">
		<div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 g-3">
			<c:forEach items="${iList}" var="i">
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
								<b>카테고리</b>:${i.infoCategory}<br>
								<b>과정</b>:${fn:substring(cName,0,25)}
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
	<br><br><br>
		<nav aria-label="Standard pagination example" style="float: center;">
			<ul class="pagination">
				<li class="page-item">
					<c:url var="goBack" value="${ loc }">
						<c:param name="page" value="${ pi.currentPage-1 }"></c:param>
					</c:url> <a class="page-link" href="${ goBack }" aria-label="Previous">
						<span aria-hidden="true">&laquo;</span>
				</a></li>
				<c:forEach begin="${ pi.startPage }" end="${ pi.endPage }" var="p">
					<c:url var="goNum" value="${ loc }">
						<c:param name="page" value="${ p }"></c:param>
					</c:url>
					<li class="page-item"><a class="page-link" href="${ goNum }">${ p }</a></li>
				</c:forEach>
				<li class="page-item"><c:url var="goNext" value="${ loc }">
						<c:param name="page" value="${ pi.currentPage+1 }"></c:param>
					</c:url> <a class="page-link" href="${ goNext }" aria-label="Next">
					 <span aria-hidden="true">&raquo;</span>
				</a>
				</li>
			</ul>
		</nav>
	</div>
	</div>


	<hr>
	<footer>
		<jsp:include page="/WEB-INF/views/main/footer.jsp" />
	</footer>
	</main>
	<script>
      window.onload=()=>{
         const divs = document.getElementsByClassName('card');
         
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