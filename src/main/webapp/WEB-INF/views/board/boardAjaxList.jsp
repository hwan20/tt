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
			<tbody id="ajaxList">
            </tbody>                                                                     
		</table>
		<!-- <button class="btn btn-success" type="button" onclick="location.href='boardwrite'">글쓰기</button> -->
		<!-- 아래에 invalid형식으로 작성한 후 특정 버튼을 눌렀을 때 ajax형식으로 실행되도록 -->
	</div>
	<button class="btn btn-success" type="button">글쓰기</button>
</div>
<div class="container" id="detailCon">

</div>		
</body>
<script>
//.ready는 페이지가 로딩 되고 클라이언트에서 완전히 읽어들이면 아래 펑션을 실행함? .onload와 비슷한 기능
$(document).ready(function() {
	boardList();
	
});
$("#ajaxList").on("click", ".boardT", function(){
// 	동적으로 추가된 태그에 이벤트 동작되지 않음. $(부모 태그).on("이벤트", "자식 태그", function(){})으로 작성
    var getBoardNum = $(this).attr("data-value");
//     console.log(getBoardNum);
    boardAjaxcDetail(getBoardNum);
});


/* 게시물 리스트 */
function boardList() {
	console.log("ajax");
//list로 넘어오는 데이터를 어떻게 출력하지?

    $.ajax({
        type:"get",
        url:"/board/boardAjaxListSel", //데이터 요청할 url
        dataType:"json", //서버에서 리턴되는 데이터의 타입
        //async:flase, //ajax를 동기식으로 바꾸어줌
        success:function(data) {
//            넘어온 데이터 확인하기
//            https://steemit.com/kr-dev/@cheonmr/json-stringify
//            JSON.stringify( ) //obj타입으로 넘어오는 데이터를 JS에서 읽을 수 있는 형식으로 바꿔줌
//            console.log(data);
//            a = JSON.stringify(data);
//            console.log(a); //배열 오브젝트로 전달 -> 반복문 돌려서 확인
//            for(i=0; i<data.length; i++){
//                console.log(data[i].boardTitle);
//            }
            
            var h = "";
//             for(var i = 0; i < data.length; i ++) {
//                 h += "<tr>";
//                 h += "<td>"+data[i].boardNum+"</td>";
//                 h += "<td>"+data[i].boardTitle+"</td>";
//                 h += "<td>"+data[i].boardName+"</td>";
//                 h += "<td>"+data[i].boardDate+"</td>";
//                 h += "</tr>";
//             }
//             $("#ajaxList").html(h);
//             $("#ajaxList").append(h);는 계속 추가가 됨 

            //펑션에서 받은 data를 넘겨주고 반복 횟수, 조건문을 적어줌
            $.each(data, function(index, item) {
//                  console.log(index);
	             h += "<tr>";
	             h += "<td>"+item.boardNum+"</td>";
// 	             h += "<td id=\"boardT\">"+"<a href=\"/board/boardAjaxcDetail?boardNum="+item.boardNum+"\">"+item.boardTitle+"</a>"+"</td>";
// 	             h += "<td>"+"<a id=\"boardT\" href=\"#"+item.boardNum+"\">"+item.boardTitle+"</a>"+"</td>";
	             h += "<td>"+"<a class=boardT href=# data-value="+item.boardNum+">"+item.boardTitle+"</a>"+"</td>";
	             h += "<td>"+item.boardName+"</td>";
	             h += "<td>"+item.boardDate+"<button class='btn' id='conDelete();'>삭제</button>"+"</td>";
	             h += "</tr>";
            })
            $("#ajaxList").html(h);
        },
        error:function() {
            alert("error");
        }
    });
};



/* 게시글 삭제 */
$("#conDelete").on("click", function(){
	$.ajax({
	    type:"get",
	    url:"/board/boardAjaxDelete",
	    
	})
})


/* 게시물 작성 */
/* $(#btn).on("click", function(){
    둘 중 뭘 사용?
	$(#btn).click(function(){
	   append.html(); //해서 추가하면 될듯
})
	
} */


/* 게시글 보기 */
//함수를 새로 작성한 후 controller에 데이터를 넘겨주고 받기
//1번째 데이터를 선택하면 controller에 넘겨서 받아오기
//숨겨놨다가 선택된 데이터와 함께 화면 뿌려주는 식
function boardAjaxcDetail(getBoardNum){
    $.ajax({
        type:"get",
        url:"/board/boardAjaxcDetail",
        dataType:"json",
        data:{"getBoardNum":getBoardNum}, //서버로 보낼 데이터 //controller로 게시글에 해당하는 숫자를 넘겨 데이터를 받고 쿼리문에 해당하는 게시글 넘겨주기?
        success:function(data){
            
//         	여기에 상세 글 페이지를 작성 후 버튼을 누르면 보이게
//             console.log(data);
//             빈 문자열에 데이터를 넣어준 후 html에 뿌려줌
            var ajaxDetail="";
            ajaxDetail+="<table id=\"ta\">";
           	ajaxDetail+="<tr>";
         	ajaxDetail+="<th>번호</th>";
         	ajaxDetail+="<tr>";
         	ajaxDetail+="</tr>";
           	ajaxDetail+="<td>"+data.boardNum+"</td>";
           	ajaxDetail+="</tr>";
           	ajaxDetail+="<tr>";
           	ajaxDetail+="<th>제목</th>";
           	ajaxDetail+="</tr>";
           	ajaxDetail+="<tr>";
            ajaxDetail+="<td>"+data.boardTitle+"</td>";
            ajaxDetail+="</tr>";
           	ajaxDetail+="<tr>";
           	ajaxDetail+="<th>작성자</th>";
           	ajaxDetail+="</tr>";
           	ajaxDetail+="<tr>";
            ajaxDetail+="<td>"+data.boardName+"</td>";
            ajaxDetail+="</tr>";
            ajaxDetail+="<tr>";
           	ajaxDetail+="<th>내용</th>";
           	ajaxDetail+="</tr>";
           	ajaxDetail+="<tr>";
           	ajaxDetail+="<td>"+data.boardCon+"</td>";
           	ajaxDetail+="</tr>";
           	ajaxDetail+="</table> <br>";
           	ajaxDetail+="<button class=\"btn\" id=\"bt\" onclick=\"clo();\">닫기</button>";
            $("#detailCon").html(ajaxDetail);
        },
        error:function(error){
            console.log(error);
        }
    });
};

function clo(){
	if($("#detailCon").css("display")!="none"){
		$("#ta").hide();
		$("#bt").hide();
	}else{
	    $("#ta").show();
	    $("#bt").show();
	}
}


</script>
</html>