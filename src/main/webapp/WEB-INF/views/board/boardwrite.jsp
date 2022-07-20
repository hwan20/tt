<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/common.jsp" %>
<%@ include file="../common/nav.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시글 작성</title>
<style>
	.a{
		background:#00A5FF;
		color:white;
	}
	.b{
		background:#0000FF;
		color:white;
	}
	textarea{
		resize:vertical;
	}	

</style>
<script type="text/javascript">
	window.onload = function(){
		fo1=document.getElementById("cf");
		fo1.onsubmit = function(){
			formCh(this);
			return false;
		}
	}
	
	function formCh(cf){
		inT=document.getElementById("boardTitle");
		inN=document.getElementById("boardName");
		inC=document.getElementById("boardCon");
		if(inT.value==null||inT.value==""){
			alert("제목을 입력해 주세요.");
			inT.focus();
		}else if(inN.value==null||inN.value==""){
			alert("작성자를 입력해 주세요.");
			inN.focus();
		}else if(inC.value==null||inC.value==""){
			alert("내용을 입력해 주세요.");
			inC.focus();
		}else{
			cf.submit();	
		}
	}
</script>
</head>
<body>
<div class="container">
	<h1>게시글 작성</h1>
	<form method="POST" id="cf">
		<div class="mb-3">
			<label class="form-label">제목</label>
			<input class="form-control" type="text" id="boardTitle" name="boardTitle" placeholder="제목을 입력하세요."><br>		
		</div>
		<div class="mb-3">
			<label class="form-label">작성자</label>
			<input class="form-control" type="text" id="boardName" name="boardName" placeholder="작성자를 입력하세요."><br>
		</div>
		<div class="mb-3">
			<label class="form-label">내용</label>
			<!-- <input class="form-control consize" type="text" id="boardCon" name="boardCon" placeholder="내용을 입력하세요."><br> -->
			<textarea class="form-control" id="boardCon" rows="10" name="boardCon" placeholder="내용을 입력하세요."></textarea>
		</div>
		<br>
		<button class="btn a" type="submit" >작성</button>
		<button class="btn b" type="button" onclick="location.href='boardList'">목록</button>
	</form>
</div>
</body>
</html>