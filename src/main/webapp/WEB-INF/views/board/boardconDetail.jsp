<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/common.jsp" %>
<%@ include file="../common/nav.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>${data.boardNum}번 게시글</title>
<style>
	.a{
		background:#00A5FF;
		color:white;
	}
	.b{
		background:#0000FF;
		color:white;
	}
	.c{
		background: #FF0000;
		color:white;
	}
	table{
		border-collapse: separate;
		border-spacing: 0 15px;
	}
	th{
		padding-right: 10px;
	}
	.container{
		margin-left: 30px;
	}
</style>
</head>
<body>
<div class="container">
	<h1>게시글 상세</h1>
	<table>
		<tr>
			<th>번호</th>
			<td>${data.boardNum }</td>
		</tr>
		<tr>
			<th>제목</th>
			<td>${data.boardTitle }</td>
		</tr>
		<tr>
			<th>작성자</th>
			<td>${data.boardName }</td>
		</tr>
		<tr>
			<th>내용</th>
		</tr>
		<tr>
			<td>${data.boardCon }</td>
		</tr>
	</table>
	<br>
	<button class="btn a" type="button" onclick="location.href='/board/boardupdate?boardNum=${data.boardNum }'">수정</button>
	<button class="btn c"type="button" onclick="location.href='/board/delete?boardNum=${data.boardNum }'">삭제</button>
	<button class="btn b"type="button" onclick="location.href='boardList'">목록</button>
</div>
</body>
</html>