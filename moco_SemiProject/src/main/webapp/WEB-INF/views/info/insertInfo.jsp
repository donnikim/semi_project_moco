<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>요청한 게시글 조회</title>
	<style>
	
		#info{
				margin-top:100px;
				display:flex;
				flex-direction:column;
				justify-content:center;
				align-items:center;
		}
		#header{
				margin-top:100px;
				margin-bottom:50px;
		
		}
	
	
		table td{
			text-align:right;
	
		}
	
	
		table {
	
				  border-spacing: 25px;
				  border-collapse: separate;
				}
	
	
		#infoBtn{
				display:flex;
				flex-direction:rows;
				justify-content:center;
				align-items:center;
				margin-top:50px;
				margin-bottom:50px;
				background-color:transparent;
		}
	
	
	</style>
		<script src="resources/jQuery/jquery-3.6.1.min.js"></script>
		<script src="resources/Js/summernote/summernote-lite.js"></script>
		<script src="resources/Js/summernote/lang/summernote-ko-KR.js"></script>
		
		<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.css" rel="stylesheet">

	
<body>
	<div class="navBar">
	<jsp:include page="/WEB-INF/views/main/nav.jsp"/>
	</div>
	<div id="info">
		<div id="header">
		<h1>&lt;&lt;정보 게시글 요청&gt;&gt;</h1>
		</div>
		
		<form action="${contextPath}/writeInfo.in" method="POST" enctype="multipart/form-data" id="attmForm">
		
		<fieldset>
				
				<table>
					<tr>
						<td>과정명*:</td>
						<td><input type="text" style="width:300px; height:30px;" name="infoClassName" required></td>
						<td>학원명*:</td>
						<td><input type="text" style="width:300px; height:30px;" name="infoAcademyName"required></td>	
					</tr>
					<tr>
						<td>기간명*:</td>
						<td><input type="text" style="width:300px; height:30px;" name="infoPeriod" required></td>
						<td>요일 및 시간*:</td>
						<td><input type="text" style="width:300px; height:30px;" name="infoTime" required></td>	
					</tr>
					<tr>
						<td>담당자 성명*:</td>
						<td><input type="text" style="width:300px; height:30px;" name="infoManager" required></td>
						<td>구분*:</td>
						<td>
							<select style="width:300px; height:30px;" name="infoCategory" required>
								<option>--구분--</option>
								<option>국비학원</option>
								<option>부트캠프</option>
							</select>
						</td>
					</tr>
						<tr>
						<td>전화번호*:</td>
						<td><input type="text" style="width:300px; height:30px;" name="infoPhone" required value="${ info.infoPhone }"></td>
						<td>주소*:</td>
						<td><input type="text" id="address_kakao" style="width:300px; height:30px;" name="infoAddress" readonly value="${ info.infoAddress }" /></td>	
					</tr>
						<tr>
						<td>총 비용*:</td>
						<td><input type="text" style="width:300px; height:30px;" name="infoPrice" required value="${ info.infoPrice }"></td>
						<td>온/오프라인*:</td>
						<td>
							<select style="width:300px; height:30px;" name="infoOnOff" required value="${ info.infoManager }">
								<option>--구분--</option>
								<option <c:if test="${ info.infoOnOff == '온라인' }">selected</c:if>>온라인</option>
								<option <c:if test="${ info.infoOnOff == '오프라인' }">selected</c:if>>오프라인</option>
								<option <c:if test="${ info.infoOnOff == '온/오프라인 혼합' }">selected</c:if>>온/오프라인 혼합</option>
							</select>
						</td>	
					</tr>
					<tr>
						<td>선발 절차*:</td>
						<td colspan="4"><input type="text" style="width:750px; height:30px;" name="infoDetail" required value="${ info.infoDetail }"></td>
					</tr>
					<tr>
						<td><label>업체사진*:</label></td>
						<td><input type="file" accept=".png,.jpg" name="file" ></td>
					</tr>
					<tr>
						<td><label>시간표*:</label></td>
						<td><input type="file" accept=".png,.jpg" name="file" ></td>
					</tr>
					<tr>
						<td><label>커리큘럼*:</label></td>
						<td><input type="file" accept=".png,.jpg" name="file" ></td>
					</tr>
				</table>
				<div id="addText" style="text-align:center;"><h3>부가정보</h3></div>		
				<textarea id="summernote" name="infoAddInfomation">${ info.infoAddInfomation }</textarea>
		
		
		</fieldset>
		
		<div id="infoBtn">
		<button style="width:100px; height:50px;">게시글 요청</button>&nbsp;&nbsp;&nbsp;
		<button style="width:100px; height:50px;" onclick="javascript:history.back();">목록으로</button>
		</div>
		
		

	</form>
	</div>
	<hr>
	<footer>
		<jsp:include page="/WEB-INF/views/main/footer.jsp"/>
	</footer>
		<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
		<script>
			window.onload = function(){
			    document.getElementById("address_kakao").addEventListener("click", function(){ //주소입력칸을 클릭하면
			        //카카오 지도 발생
			        new daum.Postcode({
			            oncomplete: function(data) { //선택시 입력값 세팅
			                document.getElementById("address_kakao").value = data.address; // 주소 넣기
			                document.querySelector("input[name=address_detail]").focus(); //상세입력 포커싱
			            }
			        }).open();
			    });
				/* const form = document.getElementById('attmForm'); 
				document.getElementById('submitAttm').addEventListener('click',()=>{
					const files= document.getElementsByName('file');
					
					let isEmpty=true;
					for(const f of files){
						if(f.value!=''){
							isEmpty=false;
						}
					}
				}); */
				$('#summernote').summernote({
					  height: 300,                 // 에디터 높이
					  minHeight: null,             // 최소 높이
					  maxHeight: null,             // 최대 높이
					  focus: true,                  // 에디터 로딩후 포커스를 맞출지 여부
					  lang: "ko-KR",					// 한글 설정
					  placeholder: '최대 2048자까지 쓸 수 있습니다'	//placeholder 설정
			          
				});	
				
			}
		</script>


</body>
</html>