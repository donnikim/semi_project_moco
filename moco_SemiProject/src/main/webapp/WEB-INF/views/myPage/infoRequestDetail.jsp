<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시글 요청</title>
<style>
	.total{
			
			display:flex;
			flex-direction:column;
			justify-content:center;
			align-items:center;
	}
	#infoPic{
			display:flex;
			flex-direction:column;
			justify-content:center;
			align-items:center;
			margin-top:40px;
	}
	.infoTable{
			display:flex;
			flex-direction:column;
			justify-content:center;
			align-items:center;
			margin-top:40px;

			margin-left:60px;
			margin-right:60px;
			

	
	}
	#map{
			margin-left:auto;
			margin-right:auto;
			
			width:500px;
			height:500px;
			display:flex;
			flex-direction:column;
			justify-content:center;
			align-items:center;
	}
	
	tr td {
		width:150px;
		border: 1px solid black;
		text-align:center;
	}
	
	#updateBtn{
			display:flex;
			flex-direction:row;
			justify-content:center;
			align-items:center;
	}
	#deleteBtn{
		display:flex;
			flex-direction:row;
			justify-content:center;
			align-items:center;
	}
</style>

</head>
<body>
	<div class="navBar">
		<jsp:include page="/WEB-INF/views/main/nav.jsp"/>
	</div>
	<div class="total" style="margin-top:200px;">
		<h1 id="title">학원 상세 정보</h1>
		<br><br>
		<div class="info" style="width:900px; height:auto; border:1px solid black;padding-bottom:100px;">
			<div id="infoPic">
				<img src="${contextPath }/resources/uploadFiles/${list[0].attmRename}" style="width:400px; height:300px;">
			</div>
			<div style="text-align:center; margin-top:40px;">
				<h1>${info.infoAcademyName }</h1>
			</div>
			<table class="infoTable">
				<tr>
					<td colspan="2" style="width:150px; text-align:center;"><h3>과정명 </h3></td>
					<td colspan="2">${info.infoClassName}</td>
				</tr>
				<tr>
					<td colspan="2" style="width:150px; text-align:center;"><h3>요일 및 시간 </h3></td>
					<td colspan="2">${info.infoPeriod }<br>${info.infoTime }</td>
				</tr>
				<tr>
					<td style="width:100px;"><h3>담당자 성명  </h3></td>
					<td style="width:130px; text-align:center;">${info.infoManager }</td>
					<td><h3>전화번호 </h3></td>
					<td>${info.infoPhone }</td>
				</tr>
				<tr>
					<td colspan="2" style="width:150px; text-align:center;"><h3>구분 </h3></td>
					<td colspan="2">${info.infoCategory}</td>
				</tr>
				<tr>
					<td colspan="2" style="width:150px; text-align:center;"><h3>주소 </h3></td>
					<td colspan="2">${info.infoAddress }</td>
				</tr>
				<tr>
					<td style="width:100px;"><h3>총비용  </h3></td>
					<td style="width:130px; text-align:center;">${info.infoPrice }</td>
					<td><h3>온/오프라인 </h3></td>
					<td>${info.infoOnOff }</td>
				</tr>
			</table>
			<div style="text-align:center; margin-top:40px;">
				<h1>추가 정보</h1>
				<div id="addInfomation" style="width:100%; height:150px"></div>
			
			
			</div>
		    <div style="text-align:center; margin-top:40px;">
				<h1>시간표</h1>
			</div>	
					<div id="infoPic">
				<img src="${contextPath }/resources/uploadFiles/${list[1].attmRename}" style="width:800px; height:500px;">
			</div>			
			 <div style="text-align:center; margin-top:40px;">
				<h1>커리큘럼</h1>
			</div>	
					<div id="infoPic">
				<img src="${contextPath }/resources/uploadFiles/${list[2].attmRename}" style="width:800px; height:500px;">
			</div>
			<div style="text-align:center; margin-top:40px;">
				<h1>지도</h1>
			</div>	
			<div id="map" style="width:500px;height:400px;"></div>
			
				
		</div>
		
	</div>
	<br>
	<div id="updateBtn">
		<button id="confirmInfo">승인</button>&nbsp;&nbsp;&nbsp;
		<button id="rejectInfo">반려</button>&nbsp;&nbsp;&nbsp;
		<button onclick="javascript:history.back();">목록으로</button>
		
		<br><br><br>
	</div>
	
	<hr>
	<footer>
		<jsp:include page="/WEB-INF/views/main/footer.jsp"/>
	</footer>	
	
	
	<input type="hidden" id="infoNum" value="${ info.getInfoNum() }">
	 <hr>
   <footer>
      <jsp:include page="/WEB-INF/views/main/footer.jsp" />
   </footer>
	
<script type="text/javascript" src="https://dapi.kakao.com/v2/maps/sdk.js?appkey=80366d9321f830a9d8775a4d70ed9e43"></script>
	<script>
	
	
      var markerPosition = new kakao.maps.LatLng(${info.infoAddressLat}, ${info.infoAddressLong})
      var mapContainer = document.getElementById('map'), // 지도를 표시할 div  
          mapOption = { 
              center: markerPosition, // 지도의 중심좌표
              level: 3 // 지도의 확대 레벨
          };

      var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다

  	  // 마커가 표시될 위치입니다 
      var markerPosition  = new kakao.maps.LatLng(${info.infoAddressLat}, ${info.infoAddressLong}); 

      // 마커를 생성합니다
      var marker = new kakao.maps.Marker({
          position: markerPosition
      });

      // 마커가 지도 위에 표시되도록 설정합니다
      marker.setMap(map);
  
	</script>
	
	<script>
		window.onload = () => {                                                             
			const addInfo=document.getElementById('addInfomation');
			addInfo.innerHTML='${info.infoAddInfomation}';
			
			document.getElementById('confirmInfo').addEventListener('click', function() {
				const infoNum = document.getElementById('infoNum').value;
				location.href  = '${contextPath}/confirmInfo.my?infoNum='+ infoNum;
				alert("게시글 승인이 완료되었습니다.");
			});
	    		
	    	document.getElementById('rejectInfo').addEventListener('click', function() {
				const infoNum = document.getElementById('infoNum').value;
				location.href  = '${contextPath}/rejectInfo.my?infoNum='+ infoNum;
				alert("게시글 반려가 완료되었습니다.");
	    	});
	    	
	    	
// 	    	document.getElementById('editInfoBtn').addEventListener('click',function(){
// 	    		if(isName && isNickName && isPwd2 && isEmail){
// 					this.type = 'submit';
// 	    			alert('수정 완료되었습니다.');
// 	    		}
// 	    	});
	    	
		}
	</script>
	
</body>
</html>