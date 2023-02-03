<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이페이지</title>
<style>
#myPage {
	margin: 120px 0 0 0;
	display: flex;
	flex-direction: column;
	justify-content: center;
	align-items: center;
}

#title {
	padding: 40px 0 15px 0;
	font-size: 25px;
	font-weight: 700;
	color: #000;
	margin: auto;
}

#msg {
	padding-bottom: 20px;
	border-bottom: 2px solid #000;
	font-size: 18px;
	width: 700px;
	margin: auto;
}
#border {
	font-size: 20px;
	font-weight: 0;
	color: #808080;
}

#list {
	/* 	    height: 182px; */
	/* 	    border-top: 1px solid #c0c0c0; */
	/* 	    border-bottom: 1px solid #c0c0c0; */
	font-size: 15px;
	line-height: 10;
	list-style: none;
	display: table;
	margin: auto;
}

#list li {
	float: left;
	margin: 40px 60px;
}

a {
	color: #787878;
	text-decoration: none;
}

.hd {
	width: 700px;
}

.hd>h4 {
	color: #000;
	font-size: 18px;
	font-weight: bold;
	display: inline;
	float: left;
}

.hd>p {
	bottom: 10px;
	right: 10px;
	display: inline;
	float: right;
}

.tb-left {
	text-align: left;
}

.tb-center {
	text-align: center;
}

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
	padding: 16px 0 16px 0;
	border-bottom: 1px solid #dadada;
	vertical-align: middle;
	font-size: 11px;
	color: #252525;
	cursor : pointer;
}
</style>
</head>
<body>

	<div class="container">
		<jsp:include page="/WEB-INF/views/main/nav.jsp" />
	</div>

	<br>
	<br>
	<br>
	<div id="myPage" style="text-align: center;">
		<p id="title">마이페이지</p>
		<p id="msg">안녕하세요. 회원님의 마이페이지입니다.</p>
		<ul id="list">
			<li><a id="more" href="${contextPath}/myBoardListView.my">게시물 관리</a></li>
			<li><a id="more" href="${contextPath}/myScrapListView.my">스크랩</a></li>
			<li><a href="${ contextPath }/editInfo.me">회원정보 수정</a></li>
		</ul>

		<div class="listTable">
			<div class="hd">
				<h4>회원정보</h4>
			</div>
			<br>

			<div class="table">
<!-- 				<table id="info"> -->
<%-- 					<colgroup> --%>
<%-- 						<col width="100"> --%>
<%-- 						<col width="100"> --%>
<%-- 						<col width="100"> --%>
<%-- 						<col width="100"> --%>
<%-- 					</colgroup> --%>
<!-- 					<thead> -->
<!-- 						<tr> -->
<!-- 							<th><div class="tb-center">아이디</div></th> -->
<!-- 							<th><div class="tb-center">이름</div></th> -->
<!-- 							<th><div class="tb-center">닉네임</div></th> -->
<!-- 							<th><div class="tb-center">이메일</div></th> -->
<!-- 						</tr> -->
<!-- 					</thead> -->
<!-- 					<tbody> -->
<!-- 						<tr> -->
<%-- 							<td><div class="tb-center">${ loginUser.memberId }</div></td> --%>
<%-- 							<td><div class="tb-center">${ loginUser.memberName }</div></td> --%>
<%-- 							<td><div class="tb-center">${ loginUser.memberNickName }</div></td> --%>
<%-- 							<td><div class="tb-center">${ loginUser.memberEmail }</div></td> --%>
<!-- 						</tr> -->
<!-- 					</tbody> -->
<!-- 				</table> -->
				<table id="info">
					<colgroup>
						<col width="200">
						<col width="10">
						<col width="300">
					</colgroup>
					<tbody>
						<tr>
							<td><div class="tb-center">아이디</div></td>
							<td id="border">|</td>
							<td><div class="tb-center">${ loginUser.memberId }</div></td>
						</tr>
						<tr>
							<td><div class="tb-center">이름</div></td>
							<td id="border">|</td>
							<td><div class="tb-center">${ loginUser.memberName }</div></td>
						</tr>
						<tr>
							<td><div class="tb-center">닉네임</div></td>
							<td id="border">|</td>
							<td><div class="tb-center">${ loginUser.memberNickName }</div></td>
						</tr>
						<tr>
							<td><div class="tb-center">이메일</div></td>
							<td id="border">|</td>
							<td><div class="tb-center">${ loginUser.memberEmail }</div></td>
						</tr>

					</tbody>
				</table>
			</div>
		</div>

		<br>
		<br>
		<br>



		<div class="listTable">
			<div class="hd">
				<h4>작성한 게시글</h4>
				<p>
					<a id="more" href="#"
						onclick="location.href='${contextPath}/myBoardListView.my'">+</a>
				</p>
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
		    				<th><div class="tb-center">게시판</div></th>
		    				<th><div class="tb-center">게시글</div></th>
		    				<th><div class="tb-center">작성일자</div></th>
		    				<th><div class="tb-center">수정일자</div></th>
		    				<th><div class="tb-center">조회수</div></th>
		    			</tr>
		    		</thead>
					<tbody id="tbody1">
						<c:if test="${ !empty boardPreview }">
							<c:forEach begin="0" end="4" var="i">
								<c:if test="${ !empty boardPreview[i] }">
									<tr>
										<td>${ boardPreview[i].boardNum }</td>
										<td>${ boardPreview[i].boardCategory }게시판</td>
										<td>${ boardPreview[i].boardTitle }</td>
										<td>${ boardPreview[i].boardCreateDate }</td>
										<td>${ boardPreview[i].boardModifyDate }</td>
										<td>${ boardPreview[i].boardView }</td>
									</tr>
								</c:if>
								<c:if test="${ empty boardPreview[i] }">
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
						</c:if>
						<c:if test="${ empty boardPreview }">
							<tr style="height: 300px;">
								<td colspan="6">스크랩한 게시글이 존재하지 않습니다.</td>
							</tr>
						</c:if>
					</tbody>
				</table>
			</div>
		</div>

		<br>
		<br>

		<div class="listTable">
			<div class="hd">
				<h4>스크랩한 게시글</h4>
				<p>
					<a id="more" href="${contextPath}/myScrapListView.my">+</a>
				</p>

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
	    				<th><div class="tb-center">게시판</div></th>
	    				<th><div class="tb-center">게시글</div></th>
	    				<th><div class="tb-center">작성일자</div></th>
	    				<th><div class="tb-center">수정일자</div></th>
	    				<th><div class="tb-center">조회수</div></th>
	    			</tr>
	    		</thead>
					<tbody id="tbody2">
						<c:if test="${ !empty scrapPreview }">
							<c:forEach begin="0" end="4" var="i">
								<c:if test="${ !empty scrapPreview[i] }">
									<tr>
										<td>${ scrapPreview[i].boardNum }</td>
										<td>${ scrapPreview[i].boardCategory }게시판</td>
										<td>${ scrapPreview[i].boardTitle }</td>
										<td>${ scrapPreview[i].boardCreateDate }</td>
										<td>${ scrapPreview[i].boardModifyDate }</td>
										<td>${ scrapPreview[i].boardView }</td>
									</tr>
								</c:if>
								<c:if test="${ empty scrapPreview[i] }">
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
						</c:if>
						<c:if test="${ empty scrapPreview }">
							<tr style="height: 300px;">
								<td colspan="6">스크랩한 게시글이 존재하지 않습니다.</td>
							</tr>
						</c:if>
					</tbody>
				</table>
			</div>
		</div>

		<br><br>

		<div class="listTable">
			<div class="hd">
				<h4>요청한 게시글</h4>
				<p>
					<a id="more" href="${contextPath}/myInfoRequestListView.my">+</a>
				</p>
			</div>
			<br>

			<div class="table">
				<table>
					<colgroup>
		    			<col width="30">
		    			<col width="120">
		    			<col width="250">
		    			<col width="70">
		    			<col width="70">
		    		</colgroup>
	    		<thead id="thead">
	    			<tr>
	    				<th><div class="tb-center">번호</div></th>
	    				<th><div class="tb-center">학원명</div></th>
	    				<th><div class="tb-center">과정명</div></th>
	    				<th><div class="tb-center">요청일자</div></th>
	    				<th><div class="tb-center">처리상태</div></th>
	    			</tr>
	    		</thead>
					<tbody id="tbody3">
						<c:if test="${ !empty infoRequestPreview }">
							<c:forEach begin="0" end="4" var="i">
								<c:if test="${ !empty infoRequestPreview[i] }">
									<tr>
										<td>${ infoRequestPreview[i].infoNum }</td>
										<td>${ infoRequestPreview[i].infoAcademyName }</td>
										<td>${ infoRequestPreview[i].infoClassName }</td>
										<td>${ infoRequestPreview[i].infoCreateDate }</td>
										<td>
						    				<c:if test="${ infoRequestPreview[i].infoApprove == 'R' }">반려</c:if>
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
									</tr>
								</c:if>
							</c:forEach>
						</c:if>
						<c:if test="${ empty infoRequestPreview }">
							<tr style="height: 300px;">
								<td colspan="5">요청 게시글이 존재하지 않습니다.</td>
							</tr>
						</c:if>
					</tbody>
				</table>
			</div>
		</div>

		<br><br>

		<div class="listTable">
			<div class="hd">
				<h4>작성한 댓글</h4>
				<p>
					<a id="more" href="${contextPath}/myReplyListView.my">+</a>
				</p>

			</div>
			<br>

			<div class="table">
				<table>
					<colgroup>
						<col width="90">
						<col width="120">
						<col width="240">
						<col width="90">
					</colgroup>
					<thead id="thead">
						<tr>
							<th><div class="tb-center">번호</div>
							<th><div class="tb-center">게시판</div>
							<th><div class="tb-center">댓글</div>
							<th><div class="tb-center">작성일자</div>
						</tr>
					</thead>
					<tbody id="tbody4">
						<c:if test="${ !empty replyPreview }">
							<c:forEach begin="0" end="4" var='i'>
								<c:if test="${ !empty replyPreview[i] }">
									<tr>
										<td>${ replyPreview[i].boardNum }</td>
										<td>${ replyPreview[i].boardCategory }게시판</td>
										<td>${ replyPreview[i].replyContent }</td>
										<td>${ replyPreview[i].replyCreateDate }</td>
									</tr>
								</c:if>
								<c:if test="${ empty replyPreview[i] }">
									<tr>
										<td style="height: 20px;"></td>
										<td></td>
										<td></td>
										<td></td>
									</tr>
								</c:if>
							</c:forEach>
						</c:if>
						<c:if test="${ empty replyPreview }">
							<tr style="height: 300px;">
								<td colspan="4">작성한 댓글이 존재하지 않니다.</td>
							</tr>
						</c:if>
					</tbody>
				</table>
			</div>
		</div>
		
	</div>


	<br><br><br><br><br><br><br>
	 <hr>
   <footer>
      <jsp:include page="/WEB-INF/views/main/footer.jsp" />
   </footer>
	
	<input type="hidden" id="loginNickName" value="${ loginUser.getMemberNickName() }">

<script>
	window.onload = () =>{
		
		const tbody1 =  document.getElementById('tbody1');
		const tds1 = tbody1.querySelectorAll('td');

		for(const td of tds1){
		   		td.addEventListener('click', function(){
		        const trTds = this.parentElement.querySelectorAll('td');
				const boardNum = trTds[0].innerText;
				const nickName = document.getElementById('loginNickName').value;

		        location.href  = '${contextPath}/selectBoard.bo?boardNum=' + boardNum+ "&nickName=" + nickName + "&page=" + 1 ;
			});
		}
		
		const tbody2 =  document.getElementById('tbody2');
		const tds2 = tbody2.querySelectorAll('td');

		for(const td of tds2){
		   		td.addEventListener('click', function(){
		        const trTds = this.parentElement.querySelectorAll('td');
				const boardNum = trTds[0].innerText;
				const nickName = document.getElementById('loginNickName').value;

		        location.href  = '${contextPath}/selectBoard.bo?boardNum=' + boardNum+ "&nickName=" + nickName + "&page=" + 1 ;
			});
		}
		
		const tbody3 =  document.getElementById('tbody3');
		const tds3 = tbody3.querySelectorAll('td');

		for(const td of tds3){
		   		td.addEventListener('click', function(){
		        const trTds = this.parentElement.querySelectorAll('td');
				const infoNum = trTds[0].innerText;

				location.href='${contextPath}/InfoRequestDetail.my?InfoNum=' + infoNum + '&page=' + 1;
			});
		}
		
		const tbody4 =  document.getElementById('tbody4');
		const tds4 = tbody4.querySelectorAll('td');

		for(const td of tds4){
		   		td.addEventListener('click', function(){
		        const trTds = this.parentElement.querySelectorAll('td');
				const boardNum = trTds[0].innerText;
				const nickName = document.getElementById('loginNickName').value;

		        location.href  = '${contextPath}/selectBoard.bo?boardNum=' + boardNum+ "&nickName=" + nickName + "&page=" + 1 ;
			});
		}
	}
</script>

</body>
</html>