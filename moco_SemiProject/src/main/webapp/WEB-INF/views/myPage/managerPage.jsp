<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 페이지</title>
<style>

 	#myPage{ 
 		margin: 120px 0 0 0;
 		display :flex; 
 		flex-direction:column; 
 		justify-content:center; 
 		align-items:center; 
 	} 
	#title { padding: 40px 0 15px 0; font-size: 25px; font-weight:700; color: #000; margin: auto;}
	#msg { padding-bottom: 20px; border-bottom: 2px solid #000; font-size: 18px; width: 700px; margin: auto;}
	
	#list{
/* 	    height: 182px; */
/* 	    border-top: 1px solid #c0c0c0; */
/* 	    border-bottom: 1px solid #c0c0c0; */
	    font-size: 15px;
	    line-height: 10;
	    list-style: none;
	    display: table;
		margin: auto;
		}
	
	#list li {float: left; margin: 40px 60px;}
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

</style>
</head>
<body>

	<div class="container">
		<jsp:include page="/WEB-INF/views/main/nav.jsp"/>
    </div>
    
    <br><br><br>
    <div id="myPage" style="text-align: center;">
    	<p id="title">관리자 페이지</p>
    	<p id="msg">
    		안녕하세요 관리자님, 환영합니다.
    	</p>
    	<ul id="list">
    		<li><a id="more" href="${contextPath}/InfoRequestListView.my">게시글 요청</a></li>
    		<li><a href="${contextPath}/myInfoReportListView.my">신고 관리</a></li>
    		<li><a href="${contextPath}/memberManagement.my">회원관리</a></li>
    		
    	</ul>
	    
	    <div class="listTable">
		    <div class="hd">
		    	<h4>게시글 요청</h4>
		    	<p><a id="more" href="${contextPath}/InfoRequestListView.my">+</a></p>
		    </div>
		    <br>
		    
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
		    			<c:if test="${ !empty infoRequestPreview }">
			    			<c:forEach begin="0" end="4" var="i">
			    				<c:if test="${ !empty infoRequestPreview[i] }">
					    			<tr>
						    			<td>${ infoRequestPreview[i].infoNum } </td>
						    			<td>${ infoRequestPreview[i].infoAcademyName } </td>
						    			<td>${ infoRequestPreview[i].infoClassName }</td>
						    			<td>${ infoRequestPreview[i].infoCreateDate }</td>
						    			<td>${ infoRequestPreview[i].memberName }</td>
						    			<td>
						    				<c:if test="${ infoRequestPreview[i].infoApprove == 'N' }">처리 전</c:if>
						    			</td>
						    		</tr>
						    	</c:if>
						    	<c:if test="${ empty infoRequestPreview[i] }">
					    			<tr>
						    			<td style="height: 20px;"></td>
						    			<td></td>
						    			<td></td>
						    			<td></td>
						    			<td></td>
						    			<td></td>
						    		</tr>
						    	</c:if>
					    	</c:forEach>
					    	<c:if test="${ empty infoRequestPreview }">
					    		<tr style="height: 300px;">
					    			<td colspan="6">게시글 요청이 존재하지 않습니다.</td>
					    		</tr>
					    	</c:if>
					    </c:if>
		    		</tbody>
		    	</table>
		    </div>
	    </div>
	    
	    <br><br>
	    
	   <div class="listTable">
			<div class="hd">
				<h4>게시글 신고 관리</h4>
				<p>
					<a id="more" href="#" onclick="location.href='${contextPath}/myInfoReportListView.my'">+</a>
				</p>
			</div>
			<br>

			<div class="table">
				<table>
					<colgroup>
		               <col width="30">
		               <col width="110">
		               <col width="240">
		               <col width="80">
		               <col width="80">
		            </colgroup>
		            <thead id="thead">
		               <tr>
		                  <th><div class="tb-center">번호</div>
		                  <th><div class="tb-center">카테고리</div>
		                  <th><div class="tb-center">게시글</div>
		                  <th><div class="tb-center">닉네임</div>
		                  <th><div class="tb-center">처리상태</div>
		               </tr>
		            </thead>
					<tbody id="tbody2">
						<c:if test="${ !empty infoRequestPreReport }">
							<c:forEach begin="0" end="4" var="i">
								<c:if test="${ !empty infoRequestPreReport[i] }">
									<tr>
										<td>${ infoRequestPreReport[i].boardNum }</td>
										<td>${ infoRequestPreReport[i].boardCategory }</td>
										<td>${ infoRequestPreReport[i].boardTitle }</td>
										<td>${ infoRequestPreReport[i].nickName }</td>
										<td><c:if test="${ infoRequestPreReport[i].boardReport == 'Y' }">처리 전</c:if></td>
									</tr>
								</c:if>
							</c:forEach>
						</c:if>
					</tbody>
					<tbody>
						<c:if test="${ !empty infoRequestPreReport }">
							<c:if test="${ infoRequestPreReport.size()<4 }">
								<c:forEach begin="0" end="${ 4-infoRequestPreReport.size() }">
									<tr>
										<td style="height: 20px;"></td>
										<td></td>
										<td></td>
										<td></td>
										<td></td>
									</tr>
								</c:forEach>
							</c:if>
						</c:if>
					</tbody>
					<tbody>
						<c:if test="${ empty infoRequestPreReport }">
							<tr style="height: 300px;">
								<td colspan="5">신고된 게시물이 없습니다.</td>
							</tr>
						</c:if>
					</tbody>
				</table>
			</div>
		</div>
	    
    </div>

    <br><br><br><br><br><br><br><br>
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
		
		const tbody2 =  document.getElementById('tbody2');
		const tds2 = tbody2.querySelectorAll('td');
			for(const td of tds2){
			   	td.addEventListener('click', function(){
			       	const trTds = this.parentElement.querySelectorAll('td');
					const boardNum = trTds[0].innerText;
					const nickName = trTds[2].innerText;
	
			    location.href  = '${contextPath}/selectBoard.bo?boardNum=' + boardNum+ "&nickName=" + nickName + "&page=" + 1 ;
			});
		}
	}
</script>

</body>
</html>