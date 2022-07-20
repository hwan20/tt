<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../common/common.jsp" %>
<%@ include file="../common/nav.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판</title>
<style>
	.container{
		margin-left: 30px;
	}
</style>
</head>
<body>
<div class="container">
	<h1>게시판</h1>
	<div class="table1">
		<table class="table table-striped">
			<thead>
				<tr>
					<th class="col-md-1">번호</th>
					<th class="col-md-7">제목</th>
					<th class="col-md-2">작성자</th>
					<th class="col-md-2">날짜</th>
				</tr>
			</thead>
			<tbody>
	  			<c:forEach var="tmp" items="${list}">
					<tr>
						<td>${tmp.boardNum}</td>
						<td><!-- ${path} -->
							<a href="/board/boardconDetail?boardNum=${tmp.boardNum }">${tmp.boardTitle}</a>
						</td>
						<td>${tmp.boardName}</td>
						<td>${tmp.boardDate}</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
		<button class="btn btn-success" type="button" onclick="location.href='boardwrite'">글쓰기</button>
	</div>
</div>
</body>
</html>