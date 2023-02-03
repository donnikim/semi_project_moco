<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>MOCO > 게시글 수정</title>
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
      
    </style>
</head>
<body>
   <div id="header">
      <jsp:include page="/WEB-INF/views/main/nav.jsp" />
   </div>
   <br><br><br><br><br><br>
   <br><br><br>
    <div id="tableD">
         <form method="post" id="updateForm" enctype="multipart/form-data">
			<table id="tableT">
				<tr>
					<th>제목</th>
					<td colspan="6" style="width: 400px;"><input type="text"
						id="title" name="boardTitle" value="${ b.boardTitle }"> <input
						type="hidden" name="boardNum" value="${ b.boardNum }"> <input
						type="hidden" name="page" value="${ page }"></td>
					<th colspan="2" style="text-align: left; width: 10px;">카테고리</th>
					<td colspan="3"><select id="category" name="boardCategory">
							<option value="자유"
								<c:if test="${ b.boardCategory eq '자유' }">selected</c:if>>자유</option>
							<option value="Q&A"
								<c:if test="${ b.boardCategory eq 'Q&A' }">selected</c:if>>Q&A</option>
							<option value="후기"
								<c:if test="${ b.boardCategory eq '후기' }">selected</c:if>>후기</option>
					</select></td>
				</tr>
				<tr>
					<th>작성자</th>
					<td colspan="3" style="text-align: left;"><input type="text"
						id="write" name="boardWriter" readonly
						value="${ loginUser.memberNickName }"> <input
						type="hidden" name="nickName"
						value="${ loginUser.memberNickName }"> <input
						type="hidden" name="memberNum" value="${ loginUser.memberNum }">
					</td>
					<th>작성일</th>
					<td colspan="2" style="text-align: left;"><input type="text"
						id="date" name="boardModifiyDate" readonly> <input
						type="hidden" name="boardCreateDate"
						value="${ b.boardCreateDate }"></td>
					<th colspan="2" style="text-align: right;">조회수</th>
					<td style="text-align: right; width: 10px;"><input type="text"
						style="border: none; background: none;" name="boardView"
						value="${ b.boardView }"></td>
					<th style="text-align: right;">익명</th>
					<td style="width: 20px;"><input type="checkbox" id="anonymity"
						class="anonymity" name="boardAnonymity"
						<c:if test="${ b.boardAnonymity eq 'on' }">checked</c:if>>
					</td>
				</tr>
				<tr>
					<td colspan="12" style="text-align: center;"><textarea
							id="content" cols="130" rows="30" name="boardContent">${ b.boardContent }</textarea>
					</td>
				</tr>
				<tr>
					<th>
						<button type="button" class="fileBtn" id="addFile">파일추가</button>
						</button>
					</th>
					<td colspan="9"><c:forEach items="${ alist }" var="a">
							<h5>
								<a
									href="${ contextPath }/resources/uploadFiles/${ a.attmRename }"
									download="${ a.attmOriginName }"> ${ a.attmOriginName } </a>
								<button type="button" class="deleteFile"
									id="delete-${ a.attmRename }/${ a.attmLevel }">
									삭제 OFF
<!-- 									삭제 버튼을 눌렀을때 hidden deleteAttm에 파일에 대한 정보가 담김 -->
								</button>
								<input type="hidden" name="deleteAttm">
							</h5>
							<br>
						</c:forEach></td>
				</tr>
				<tr>
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
						<button type="button" id="goUpdate">수정하기</button>
					</td>
					<td></td>
					<td colspan="6">
						<button type="button" id="delete">삭제하기</button>
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
					<p class="mb-0">삽입하지 않고 작성하시겠습니까?</p>
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
      window.onload=()=>{
         document.getElementById('date').value = new Date().toISOString().substring(0, 10);
         console.log('${ b.boardAnonymity}');
         console.log('${b.boardCategory}');
         console.log(typeof('${b.memberNum}'));
         
//          // 게시글 삭제
         const form = document.getElementById('updateForm');
         const deleteBtn = document.getElementById('delete');
         deleteBtn.addEventListener('click', ()=>{
            if(confirm("게시글을 삭제하시겠습니까?")){
            		const allDel = document.getElementsByClassName("deleteFile");
            		for(const del of allDel){
            			const nextHidden = del.nextElementSibling;
            			console.log(nextHidden);
    					nextHidden.value = del.id.split("-")[1];
    					console.log(nextHidden.value);
            		}
               	form.action = '${contextPath}/delete.bo';
               	form.submit();
            }
         });
         
//          // 수정하기
//          const updateBtn = document.getElementById('goUpdate');
//          updateBtn.addEventListener('click', ()=>{
//             form.action="${contextPath}/updateBoard.bo" ;
//             form.submit();
//          });
         
         // 파일 추가 버튼 눌렀을때
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
		
		// 삭제 OFF
		const delBtns = document.getElementsByClassName("deleteFile");
			for(const btn of delBtns){
				btn.addEventListener('click', function(){
//	 				console.log(this);
				const nextHidden = this.nextElementSibling;
				console.log(nextHidden);
				
				if(nextHidden.value == ''){
					// 삭제를 안한다면
					this.style.background = 'black';
					this.style.color = 'white';
					this.innerText = '삭제 ON';
					nextHidden.value = this.id.split("-")[1];
				}else{ 
					// 삭제 버튼이 눌린 상태 삭제ON
					this.style.background = 'none';
					this.style.color = 'black';
					this.innerText = '삭제 OFF';
					nextHidden.removeAttribute('value');
				}
				console.log(nextHidden);
			});
		}
			
			
		document.getElementById('goUpdate').addEventListener('click',()=>{
			console.log("goUpdate 클릭");
			const files = document.getElementsByName('file');
			console.log(files);
			
			let isEmpty = true;
			for(const f of files){
			   if(f.value !=''){
			      isEmpty=false;
			   }
			}
			
			// 파일을 다 지웠을 때 로직
			let isAllRemove = true;
			for(const btn of delBtns){
				if(btn.innerText == '삭제 OFF'){
			  		isAllRemove = false;
			 	}
			}

			if(isEmpty && isAllRemove){
				$('#modalChoice').modal('show');
			} else {
				form.action = "${ contextPath }/updateBoard.bo";
				form.submit();
			}
		});
	
		document.getElementById('moveBoard').addEventListener('click',()=>{
			form.action = "${ contextPath }/updateBoard.bo";
		   	form.submit();   
		});
      }
   </script>
</body>
</html>