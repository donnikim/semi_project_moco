<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>nav</title>

<style>
@import url('https://fonts.googleapis.com/css2?family=Do+Hyeon&display=swap');

body {
	font-family: 'Do Hyeon', sans-serif;
	color: #222;
	font-size: 25px;
	background-color: white;
	}

header {
	font-family: 'Do Hyeon', sans-serif;
	font-size: 25px;
	background: white;
	box-shadow: 5px 0 15px rgba(0, 0, 0, 0.15);
	width: 100%;
	position: fixed;
	top: 0;
	left: 0;
	right: 0;
	z-index: 555;
}

.navlogin input {
	margin: 5px;
}

.navlogin p {
	margin-top: -100px;
	text-align: right;
}

#login {

	float: right;
	
}

#enroll {
	
	float: right;
}
#logout{
	float:right;
}

nav {
	/* border: 1px solid red; */
	width: 100%;
	margin: auto;
	
}

nav>div {
	/* border: 1px solid #000; */
	height: 70px;
	line-height: 50px;
	
}

.gnb a {
	text-decoration: none;
	color: #222;
}

.gnb {
	display: inline-block;
	width: 100%;
	text-align: center;
	
}

.gnb a {
	margin: 100px;
}
.gnb a:hover {
	font-weight:bold;
	font-size:30px;
}


</style>


</head>
<body>
	<c:set value="${ pageContext.servletContext.contextPath }"
		var="contextPath" scope="application" />
	<!-- header 영역 -->
	<header>
		<!-- 상단 nav bar -->
		<nav>
			<!-- 제목, 로그인 -->
			<div class="navlogin" style="text-align:center;">
			 <img src="resources/assets/moco.png" id="logo" style="cursor:pointer" onclick="location.href='${contextPath}'">
				<!-- 로그인 아닐시 -->
				<c:if test="${ empty loginUser }">
				<span>
					<button type="button" id="enroll" class="btn btn-primary" onclick="location.href='${contextPath}/enrollView.me'">회원가입</button>
				</span>
		
				<span>
					<button type="button" id="login" class="btn btn-success" onclick="location.href='${contextPath}/loginView.me'">로그인</button>
				</span>
				</c:if>
				<!-- 로그인 일시 -->
				<c:if test="${ !empty loginUser }">
					
					<p>
						${ loginUser.memberNickName }님 환영합니다.
						<button class="btn btn-dark btn-lg" type="button" id="logout"
							onclick="location.href='${contextPath}/logout.me'">로그아웃</button>
					</p>
					
				</c:if>
			</div>
			<hr>
			<!-- 목차 -->
			<div class="gnb">
			
				<a href="${contextPath }">홈으로</a> 
				<a href="${contextPath }/list.bo">전체게시판</a> 
					<a href="${contextPath }/infoList.in">정보게시판</a>
				<!-- 로그인이 아닐시 -->
				<c:if test="${ empty loginUser }">
					<a href="#" style="display: none">마이페이지</a>
				</c:if>
				<!-- 로그인 일시 -->
				<c:if test="${ !empty loginUser }">
					<c:if test="${loginUser.memberIsAdmin eq 'Y' }">
						<a href="#"
							onclick="location.href='${contextPath}/managerPageView.my'">관리자페이지</a>
					</c:if>
					<c:if test="${loginUser.memberIsAdmin eq 'N' }">
						<a href="#" onclick="location.href='${contextPath}/myPageView.my'">마이페이지</a>
					</c:if>
				</c:if>
				
			</div>
		</nav>
	</header>
</body>
</html>