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
    textarea{
        resize:vertical;
    }
    #write{
        display: none;
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
				    <th class="col-md-2"><input type="checkbox" id="checkAll" name="checkAll"/>전체선택</th>
					<th class="col-md-1">번호</th>
					<th class="col-md-4">제목</th>
					<th class="col-md-2">작성자</th>
					<th class="col-md-3">날짜</th>
				</tr>
                <tr>
                    <td><button class="btn c" onclick="checkDelete();">선택삭제</button></td>
                </tr>
			</thead>
			<tbody id="ajaxList">
            </tbody>                                                                     
		</table>
		<!-- 아래에 invalid형식으로 작성한 후 특정 버튼을 눌렀을 때 ajax형식으로 실행되도록 -->
	</div>
	<button class="btn btn-success" id="bw" type="button" onclick="writeHide();">글쓰기</button>
</div>
<div class="container" id="write">
    <form id="cf">
        <div class="mb-3">
            <label class='form-label'>제목</label><br />
            <input class='form-control' type='text' id='boardTitle' name='boardTitle' placeholder='제목을 입력하세요.'/><br />
        </div>
        <div class="mb-3">
            <label class='form-label'>작성자</label><br />
            <input class='form-control' type='text' id='boardName' name='boardName' placeholder='제목을 입력하세요.'/><br />
        </div>
        <div class="mb-3">
            <label class="form-label">내용</label>
            <textarea class="form-control" rows="10" id="boardCon" name="boardCon" placeholder="내용을 입력하세요."></textarea>
        </div>
        <button class='btn a' type='button' onclick='boardIns();'>작성</button>
    </form>
</div>
<div class="container" id="detailCon">
</div>
</body>
<script>
//.ready는 페이지가 로딩 되고 클라이언트에서 완전히 읽어들이면 아래 펑션을 실행함? .onload와 비슷한 기능
$(document).ready(function() {
	boardList();
    
});

/* 게시글 삭제 버튼 관리를 위한*/
//동적으로 생성된 버튼에 .click 이벤트를 사용하면 작동하지 않음. 페이지가 최초로 로드되었을 때 선언되었던 요소에 한해 작동하기 때문.
//이럴 떄는 .on 이벤트를 사용하고 안에 click이벤트를 넣어준다
$("#ajaxList").on("click", "#conDelete", function(){
//  이것도 하나의 함수에 넣을 수 있나??
	var getBoardNum = $(this).attr("value");
//  	console.log(getBoardNum);
   if(confirm("삭제하시겠습니까?")){
	    conDelete(getBoardNum);
   }
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
//            JSON.stringify( ) //obj타입으로 넘어오는 데이터를 JS에서 읽을 수 있는 문자열 형식으로 바꿔줌
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
// 	            h += "<td><input type='checkbox' onclick='check(this);' value="+item.boardNum+"></td>";
	            h += "<td><input type='checkbox' name='check' onclick='chkB();' value="+item.boardNum+"></td>";
	            h += "<td>"+item.boardNum+"</td>";
	            h += "<td>"+"<a class=\"boardT\" href=# onclick='boardAjaxcDetail("+item.boardNum+");'>"+item.boardTitle+"</a>"+"</td>";
// 	            h += "<td>"+"<a class=\"boardT\" href=# data-value="+item.boardNum+">"+item.boardTitle+"</a>"+"</td>";
	            h += "<td>"+item.boardName+"</td>";
// 	            h += "<td>"+item.boardDate+"<button class='btn' onclick=\"conDelete();\">삭제</button>"+"</td>";
                h += "<td>"+item.boardDate+"<button class=\"btn c\" id=\"conDelete\" value="+item.boardNum+">삭제</button></td>";
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
function conDelete(getBoardNum) {
// 	var getBoardNum = $(this).attr("data-value");
//     alert(getBoardNum);
//     alert("타입=="+typeof(getBoardNum)); //String타입
    $.ajax({
        type:"get",
        url:"/board/boardAjaxDelete",
        dataType:"text",
        data:{"getBoardNum":getBoardNum},
        success:function(data) {
            console.log("data====="+data);
            boardList();
        },
        error(error) {
            console.log(error);
        }
    });
};


/* 체크박스로 선택해서 삭제 */
function checkDelete(){
//  선택된 체크박스의 값을 받아오고 체크박스 배열에 넣어놓고 console과 alert로 출력	
	var chk_arr = [];
	
// 	'check'는 checkbox이름
//  name선택자는 배열로 처리하니 each반복문을 돌면서 하나씩 뽑아줌
    $("input[name='check']:checked").each(function() {
        var chk = $(this).val(); 
        console.log(chk);
        chk_arr.push(chk); //반복문 돌면서 checkbox의 값을 chk_arr변수에 입력해줌
    });
    
//     console.log(chk_arr);

    if(chk_arr==""){
        alert("삭제할 대상을 체크하여 주십시오.");
        console.log("삭제할 대상을 체크하여 주십시오.");
    }else{
        alert(chk_arr);
        console.log(chk_arr);
    }

//     console.log(typeof(chk_arr));

    $.ajax({
        type:"GET",
        url:"/board/boardCbDelete",
        data:{chk_arr:chk_arr},
        datatype:"text",
        success:function(data){
            console.log("data=="+data);
        	boardList();
        },
        error:function(error){
            console.log(error);
        }
    });
};


/* 전체 선택 체크박스를 누르면 모든 체크박스가 선택되도록 */
$("#checkAll").click(function(){
    if($("#checkAll").is(":checked")){
        $("input[name='check']").prop("checked", true);
        //.prop에 대한 설명 https://devyj.tistory.com/26
    } else {
        $("input[name='check']").prop("checked", false);
    }
});


/* 모든 체크박스를 선택하면 전체 선택 체크박스 자동 선택 */
function chkB(){
    var checkCBox = $("input[name='check']").length;
    var totalCBox = $("input[name='check']:checked").length;
//     console.log("cb=="+checkCBox);
//     console.log("tb=="+totalCBox);
    if(totalCBox == checkCBox) {
        $("#checkAll").prop("checked", true);
    } else {
        $("#checkAll").prop("checked", false);
    }
};


/* 게시글 작성 */
function boardIns() {
    var boardTitle = $("#boardTitle").val();
    var boardName = $("#boardName").val();
    var boardCon = $("#boardCon").val();
    console.log("boardTitle==="+boardTitle);
    console.log("boardName==="+boardName);
    console.log("boardCon==="+boardCon);

    if(boardTitle == "") {
        alert("제목이 없습니다")
        return false;
    }
    if(boardName == "") {
        alert("작성자 명이 없습니다")
        return false;
    }
    if(boardCon == "") {
        alert("내용이 없습니다")
        return false;
    }
    var data = {
        boardTitle,
        boardName,
        boardCon
    }
    console.log("데이터=="+data);
    console.log("타입=="+typeof(data)); //obj타입
    console.log(JSON.stringify(data));
    var formData = $("#cf").serialize();
    
    console.log("formData===="+formData);
    $.ajax({
        type:"post",
        url:"/board/boardAjaxWrite",
        dataType:"text", //작성된 게시글을 String형태로 받아오니 text타입
//         data:data, //1번, boardTitle, Name, Con의 데이터를 배열로 묶어서 전달하는 방법
//         data:JSON.stringify(data), //2번, 1번의 데이터를 JSON문자열로 변환하여 전달 JSON.stringify(data)
//         contentType: "application/json; charset=utf-8", //JSON문자열로 변환하여 controller에 전달할 때 사용하지 않으면 null값이 뜬다
        data:formData, //3번form태그로 전달할 때 serialize로 변환 후 사용할 경우
        success:function(data) {
            console.log("data====="+data);
            boardList(); //등록한 게시글을 보기 위해 boardList함수를 다시 실행시킴
            $("#boardTitle").val(""); //input에 입력한 데이터를 등록 후 초기화
            $("#boardName").val("");
            $("#boardCon").val("");
            
        },
        error:function(error) {
            console.log(error);
        }
    }); 
};


function writeHide(){
    if($("#write").css("display")=="none"){
    	$("#write").show();
    }else{
        $("#write").hide();
    }
//     $("#write").toggle();
};

/* 게시글 보기 */
//함수를 새로 작성한 후 controller에 데이터를 넘겨주고 받기
//1번째 데이터를 선택하면 controller에 넘겨서 받아오기
//숨겨놨다가 선택된 데이터와 함께 화면 뿌려주는 식
function boardAjaxcDetail(getBoardNum) {
	console.log("getBoardNum====="+getBoardNum);
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
           	ajaxDetail+="<tr><th>번호</th><tr>";
         	ajaxDetail+="</tr><td>"+data.boardNum+"</td></tr>";
           	ajaxDetail+="<tr><th>제목</th></tr>";
           	ajaxDetail+="<tr><td>"+data.boardTitle+"</td></tr>";
           	ajaxDetail+="<tr><th>작성자</th></tr>";
           	ajaxDetail+="<tr><td>"+data.boardName+"</td></tr>";
            ajaxDetail+="<tr><th>내용</th></tr>";
           	ajaxDetail+="<tr><td>"+data.boardCon+"</td></tr>";
           	ajaxDetail+="</table> <br>";
           	ajaxDetail+="<button class=\"btn b\" id=\"bt\" onclick=\"clo();\">닫기</button>";
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
};
</script>
</html>