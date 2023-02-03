<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>모코_게시글 요청</title>
	<style>
	
		#info{
				margin-top:100px;
				margin-bottom:100px;
				display:flex;
				flex-direction:column;
				justify-content:center;
				align-items:center;
		}
		.context{
	
			display:flex;
			flex-direction:column;
			justify-content:center;
			text-align:center;
			width:1000px;
			height:300px;
		}
		
		#infoBtn{
				display:flex;
				flex-direction:rows;
				justify-content:center;
				align-items:center;
				background-color:transparent;
				margin-bottom:100px;
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
	<div id="info" style="margin-top:200px;">
		<div id="header">
		<h1>&lt;&lt;정보 게시글 요청&gt;&gt;</h1>
		</div>
		<div>
		<form>
			<fieldset>
			<div class="context">
			<h1> 게시글 등록이 완료되었습니다. <br>게시글은 관리자가 확인 후 정보게시판에 등록 됩니다. <br>감사합니다.:) </h1>
			</div>
				<div id="infoBtn">
					<button style="width:100px; height:50px;" type="button" onclick="location.href='${contextPath}/infoList.in'">목록으로</button>&nbsp;&nbsp;&nbsp;
					<button style="width:100px; height:50px;" type="button" onclick="location.href='${contextPath}/home.do'"> 홈으로</button></div>
		
			</fieldset>
		
		</form>
		
		</div>
		
	</div>
	<hr>
		<footer>
			<jsp:include page="/WEB-INF/views/main/footer.jsp" />
		</footer>
	

</body>
</html>