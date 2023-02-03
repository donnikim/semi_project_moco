<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시글 요청</title>
<style>

 	.listTable{ 
 		margin: 200px 0 0 0;  /*위에 간격 추가*/
 		display :flex; 
 		flex-direction:column; 
 		justify-content:center; 
 		align-items:center; 
 	} 
 	a { color: #787878; text-decoration: none;}

	.hd {width: 700px;}
 	.hd>h4 { color: #000; font-size: 18px; font-weight: bold; display: inline; float: left; }
 	.hd>p {bottom: 10px; right: 10px;  display: inline; float: right;}
	
	.tb-left {text-align: left;}
	.tb-center {text-align: center;}

	.table table {
		clear: left;
		clear: right;
	    border-top: 2px solid #6f6f6f;
	    width: 700px;
	    border-collapse: collapse;
	    table-layout: fixed;
	}
	.table thead th {
	    border-left: 1px solid #e1e1e1;
	}
	.table thead th {
	    padding: 7px 0 8px;
	    border: 1px solid #e1e1e1;
/* 	    border-width: 1px 0; */
	    line-height: 19px;
	    font-size: 11px;
	    font-weight: 500;
	    color: #252525;
	}
	tbody td {
	    padding: 16px 0 20px 0;
	    border-bottom: 1px solid #dadada;
	    vertical-align: middle;
	    font-size: 11px;
	    color: #252525;
	   	cursor: pointer;
	}
	
	#number{text-align: center; font-size: 11px; color: #252525;}
	
	/* 	게시글 리스트 만들면서 추가 */
	.pagination{
		font-size: 15px;
	    list-style: none;
	    display: table;
		margin: auto;
		margin-bottom: 200px;
	}
	.pagination li {float: left; margin: 20px 12px;}
	td {text-align: center;}

</style>
</head>
<body>
	<div class="container">
		<jsp:include page="/WEB-INF/views/main/nav.jsp"/>
    </div>
    
     <div class="listTable">
		    <div class="hd">
		    	<h4>게시글 요청</h4>
		    </div>
		    
		    <div class="table">
		    	<table>
					<colgroup>
		    			<col width="30">
		    			<col width="100">
		    			<col width="230">
		    			<col width="60">
		    			<col width="60">
		    			<col width="60">
		    		</colgroup>
		    		<thead id="thead">
		    			<tr>
		    				<th><div class="tb-center">번호</div></th>
		    				<th><div class="tb-center">학원명</div></th>
		    				<th><div class="tb-center">과정명</div></th>
		    				<th><div class="tb-center">요청일자</div></th>
		    				<th><div class="tb-center">요청자</div></th>
		    				<th><div class="tb-center">처리상태</div></th>
		    			</tr>
		    		</thead>		    	
		    		<tbody id="tbody1">
	    			<c:forEach items="${ infoRequestList }" var="iR">
			    		<tr>
			    			<td>${ iR.infoNum }</td>
			    			<td>${ iR.infoAcademyName }</td>
			    			<td>${ iR.infoClassName }</td>
			    			<td>${ iR.infoCreateDate}</td>
			    			<td>${ iR.memberName }</td>
			    			<td>처리 전</td>
			    		</tr>	
	    			</c:forEach>
	    			<c:if test="${ empty infoRequestList }">
						<tr style="height: 600px;">
							<td colspan="5">게시글 요청이 존재하지 않습니다.</td>
						</tr>
					</c:if>
	    		</tbody>
	    	</table>
	    </div>
    </div>
    
    	    			
    <c:if test="${ !empty infoRequestList }">
    <nav aria-label="Standard pagination example" style="float: right;">
    	<ul class="pagination">
	         <li class="page-item">
	         	<c:url var="goBack" value="${ loc }">
	         		<c:param name="page" value="${ pi.currentPage-1 }"></c:param>
	         	</c:url>
	         	<a class="page-link" href="${ goBack }" aria-label="Previous">
	         		<span aria-hidden="true">&laquo;</span>
	           	</a>
	         </li>
	         <c:forEach begin="${ pi.startPage }" end="${ pi.endPage }" var="p">
	         	<c:url var="goNum" value="${ loc }">
	         		<c:param name="page" value="${ p }"></c:param>
	         	</c:url>
	         	<li class="page-item"><a class="page-link" href="${ goNum }">${ p }</a></li>
	         </c:forEach>
	         <li class="page-item">
	         	<c:url var="goNext" value="${ loc }">
	         		<c:param name="page" value="${ pi.currentPage+1 }"></c:param>
	         	</c:url>
	         	<a class="page-link" href="${ goNext }" aria-label="Next">
	         		<span aria-hidden="true">&raquo;</span>
	         	</a>
         	</li>
 		</ul>
    </nav>
    </c:if>
    <br><br><br><br>
     <hr>
   <footer>
      <jsp:include page="/WEB-INF/views/main/footer.jsp" />
   </footer>
    
    

<script>
	window.onload = () =>{
		
		const tbody1 =  document.getElementById('tbody1');
		const tds1 = tbody1.querySelectorAll('td');
		
		for(const td of tds1){
			td.addEventListener('click', function(){
				const trTds = this.parentElement.querySelectorAll('td');
				console.log(trTds[0]);
				const InfoNum = trTds[0].innerText;
				location.href='${contextPath}/selectAttm.my?InfoNum=' + InfoNum + '&page=' + 1;

			});
		}
	}
</script>
    
    

</body>
</html>