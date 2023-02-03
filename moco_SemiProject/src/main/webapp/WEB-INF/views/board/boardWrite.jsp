<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>게시글 글쓰기</title>
    <script src="https://code.jquery.com/jquery-3.6.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3" crossorigin="anonymous"></script>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">
    
    <style>
        #footD{border: 1px solid black;}

        table#tableT{margin-left: auto; margin-right: auto;}
        table{text-align: center;}
        table th, td{height: 40px; padding:5px; width: 70px; text-align: left; border: 1px solid black;}
        table th{font-weight: 750;}
        table td{text-align: left;}
        #writer{width: 100px; text-align: left;}

        input{border: 0.5px solid lightgray; border-radius: 3px; height: 30px;}
        input:focus{ outline: none !important; border-color: rgb(106, 140, 153); box-shadow: 0 0 10px rgb(180, 185, 187);}
        textarea:focus{outline: none !important; border-color: rgb(106, 140, 153); box-shadow: 0 0 10px rgb(180, 185, 187);}

        #tableT{margin-right: 10%;}
        
        button{border: none; background-color: rgba(100, 102, 104, 0.925); color: white;
            width: 100px;  height: 30px; border-radius: 5px; font-size: 15px; font-weight: 300;
        }
        button:hover{background-color: rgb(104, 81, 81); color: white;}
        #goList{background-color: lightgray; color: black;}
        #goList:hover{background-color: rgb(104, 81, 81); color: white;}

        #title{width: 500px;}

        textarea{border: 1px solid lightgray; background-color: white; border-radius: 5px; resize: none;}
        
        .filebox label {
		  display: inline-block;
		  padding: .5em .75em;
		  color: white;
		  font-size: inherit;
		  line-height: normal;
		  vertical-align: middle;
		  background-color: rgb(106, 140, 153);
		  cursor: pointer;
		  border: 1px solid #ebebeb;
		  border-bottom-color: #e2e2e2;
		  border-radius: .25em;
		}
		.filebox label:hover{
            background-color: aliceblue;
            color:black
		}
		.filebox input[type="file"] {  /* 파일 필드 숨기기 */
		  position: absolute;
		  width: 1px;
		  height: 1px;
		  padding: 0;
		  margin: -1px;
		  overflow: hidden;
		  clip:rect(0,0,0,0);
		  border: 0;
		}
		
		#viewCount{
			background-color: white;
			border: none;
			width: 30px;
		}
		
		input.anonymity{
			width: 20px;
			height: 20px; 
		}
		
		#category{
			height: 30px;
			width: 250px;
			border-radius: 5px;
		}
		
		.upload-name{
			width: 550px;
		}
		
    </style>
</head>
<body>
	<div id="header">
		<jsp:include page="/WEB-INF/views/main/nav.jsp" />
	</div>
	<br><br><br><br><br><br>
	<br><br><br>
    <div id="tableD">
       	<form action="${contextPath }/insertAttm.bo" method="post" id="writeForm" enctype="multipart/form-data">
			<table id="tableT">
			     <tr>
			         <th>제목</th>
			         <td colspan="6" style="width:400px;">
			             <input type="text" id="title" name="boardTitle">
			         </td>
			         <th colspan="2" style="text-align: left; width: 10px;">카테고리</th>
			         <td colspan="4">
			         	<select id="category" name="boardCategory">
			         		<option value="자유" selected>자유</option>
			         		<option value="QNA">Q&A</option>
			         		<option value="후기">후기</option>
			         	</select>
			         </td>
			     </tr>
			     <tr>
			         <th>작성자</th>
			         <td colspan="3" style="text-align: left;">
			             <input type="text" id="write" name="boardWriter" readonly value="${ loginUser.memberNickName }">
			         </td>
			         <th>작성일</th>
			         <td colspan="2" style="text-align: left;">
			             <input type="text" id="date" name="boardCreateDate" readonly>
			         </td>
			         <th colspan="2" style="text-align: right;">조회수</th>
			         <td style="text-align: right; width: 10px;">
			             0
			         </td>
			         <th style="text-align: right; width: 20px;">익명</th>
			         <td style="width:20px;">
			         	<input type="checkbox" id="anonymity" class="anonymity" name="boardAnonymity">
			         </td>
			     </tr>
			     <tr>
			         <td colspan="13" style="text-align: center;">
			             <textarea id="content" cols="130" rows="30" name="boardContent"></textarea>
			         </td>
			     </tr>
				<tr>
					<th><button type="button" class="fileBtn" id="addFile">파일추가</button></th>
					<td colspan="12">
						<div id="fileArea">
							<div class="mb-3">
								<input type="file" class="form-control form-control-lg"
									name="file">
							</div>
						</div>
					</td>
				</tr>
				<tr>
					<td colspan="5" style="text-align: right;">
						<button type="button" id="goWrite">쓰기</button>
					</td>
					<td></td>
					<td colspan="7">
						<button type="button" id="goList">목록</button>
					</td>
				</tr>
			</table>
		</form>
    </div>
    <br><br><br><br><br><br>
    <div id="footD"><jsp:include page="/WEB-INF/views/main/footer.jsp" /></div>
	<div class="modal fade" tabindex="-1" role="dialog" id="modalChoice">
		<div class="modal-dialog" role="document">
			<div class="modal-content rounded-3 shadow">
				<div class="modal-body p-4 text-center">
					<h3 class="mb-0">첨부파일이 삽입되지 않았습니다.</h3>
					<p class="mb-0">작성된 글은 일반 게시판으로 옮겨집니다.</p>
				</div>
				<div class="modal-footer flex-nowrap p-0">
					<button type="button"
						class="btn btn-lg btn-link fs-6 text-decoration-none col-6 m-0 rounded-0 border-end"
						id="moveBoard">
						<strong>네</strong>
					</button>
					<button type="button"
						class="btn btn-lg btn-link fs-6 text-decoration-none col-6 m-0 rounded-0"
						data-bs-dismiss="modal">아니오</button>
				</div>
			</div>
		</div>
	</div>
	<script>
		document.getElementById('date').value = new Date().toISOString().substring(0, 10);
		
// 		// 파일 삽입 시 파일 이름 출력하기
// 		$(document).ready(function(){
// 		  	var fileTarget = $('.filebox .upload-hidden');

// 		  	fileTarget.on('change', function(){  // 값이 변경되면
// 		    if(window.FileReader){  // modern browser
// 	      		var filename = $(this)[0].files[0].name;
// 		    } else {  // old IE
// 	      		var filename = $(this).val().split('/').pop().split('\\').pop();  // 파일명만 추출
// 		    }
// 		    console.log(filename);
		    
// 		    // 추출한 파일명 삽입
// 		    $('.upload-name').val(filename);
// 		  });
// 		}); 
		
		// 파일 삽입 시 attm에 파일 넣기
		window.onload=()=>{
			const fileArea = document.querySelector('#fileArea');
			console.log(fileArea);
			document.getElementById('addFile').addEventListener('click', ()=>{
				console.log("addFile 버튼 눌림");
				const newDiv = document.createElement('div');
				newDiv.classList.add('mb-3');
				newDiv.innerHTML = '<input type="file" class="form-control form-control-lg" name="file">';
				
				console.log(newDiv);
				
				fileArea.append(newDiv);
			});
		}
		
		// 파일 삽입할때 보내기
		const form = document.getElementById('writeForm');
		document.getElementById('goWrite').addEventListener('click', ()=>{
			const files = document.getElementsByName('file');
			console.log(files);
			
			let isEmpty = true;
			
			for(const f of files){
			   if(f.value !=''){
			      isEmpty=false;
			   }
			}
			console.log("isEmpty : "+ isEmpty);
			
			if(isEmpty){
				$('#modalChoice').modal('show');
	 	  	} else {
		      	form.submit();
	   		}
		});
		
		document.getElementById('moveBoard').addEventListener('click',()=>{
		   form.submit();   
		});

	</script>
</body>
</html>