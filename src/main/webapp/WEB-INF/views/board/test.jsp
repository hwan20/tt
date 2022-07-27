<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../common/common.jsp" %>
<%@ include file="../common/nav.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>JStest</title>
</head>
<style>
    input{
        width:50px;
    }

     td{ 
        width:50px; 
        height:30px; 
     } 
</style>
<body>
<div class="container">
    <h3>TEST2-구구단</h3>
    <select id="gugudan">
    </select>
    <button onclick="gugudanBtn();">계산</button>
    <p id="dan"></p>
</div>
<br />
<div class="container">
    <h3>TEST4-색상변경</h3>
    <div id="pTag">
    </div>
    <select id="selNum">
        <option selected>선택</option>
    </select>
    <select id="selCol">
        <option selected>선택</option>
    </select>
    <button onclick="changeCol();">변경</button>
</div>
<br />
<div class="container">
    <h3>TEST6</h3>
<!--     <input id="val" onkeyup="inNum();" type="text" /> -->
    <input id="val" type="text" />
    <button type="button" onclick="btnNum();">선택</button>
    <table border="1" id="graph">
    </table>
</div>
</body>
<script>
$(document).ready(function() {
	guguval="선택";
	selNum="선택";
    selCol="선택";
	guguSelect();
	colChangeList();
});

/* 화면에 동적으로 select 뿌려주기 */
function guguSelect() {
	$("#gugudan").append('<option>선택</option>')
    for(var i=1; i<10; i++){
        $("#gugudan").append('<option value='+i+'>'+i+'단</option>;')
    }
//     $("#gugudan").change(function() { //select가 변경될 때
//         console.log($(this).val()); //변경된 select객체의 값 가져오기
//         console.log($("#gugudan option:selected").text()); //변경된 select객체의 text 가져오기
//     })
};

/* 선택된 select의 값을 가져오기 위해 */
$("#gugudan").on("change",function() {
    guguval = $(this).val();
});

/* 계산 버튼 눌렀을 때 구구단 계산 */
function gugudanBtn() {
//     console.log(guguval);
	gugu_dan="";
    
    if(guguval=="선택"){
        alert("계산할 숫자를 선택하세요.");
    } else {
	    for(var i=1; i<10; i++){
	        gugu_dan += guguval+"x"+i+"="+guguval*i+"<br />";
	    }
    }
    console.log(gugu_dan);
	$("#dan").html(gugu_dan);
};


/* -------------------------- */


/* select리스트의 값을 가져오기 위해 */
// function change() {
// $("#selNum").on("change", function() {
// 	selNum = $("#selNum option:selected").text();
// // 	    console.log(selNum);
// });
	
// $("#selCol").on("change", function(){
// 	selCol = $("#selCol option:selected").text();
// // 	    console.log(selCol);
// })
// }


function colChangeList() {

	/* 색상바뀔 List출력 */
    var pListStr = {one:"첫번째", two:"두번째", three:"세번째", four:"네번째"};
//     console.log(pListStr);
    
    var pList = "";

    //obj로 each돌릴시 index는 key, item은 value 값
   	$.each(pListStr, function(index, item) {
//         console.log("index==", index);
//         console.log("item==", item);
        pList += "<p id="+index+">"+item+"</p>";
    })
//     console.log(pList);
    $("#pTag").html(pList);
//     selNum

    /* 첫 번째 select List */
    var selNumStr = {1:"전체", 2:"첫번째", 3:"두번째", 4:"세번째", 5:"네번째"};
    var selNumVal = {1:"", 2:"0", 3:"1", 4:"2", 5:"3"}; //selNumStr에 번호를 지정해줘서 색을 바꾸기 위해 value에 넣어줌 - selNumStr의 key값으로 하면 안 되나?
//     console.log(selNumStr);
    
    var selNumList = "";
    
    $.each(selNumStr, function(index, item) {
//         console.log("item==", item);
//         console.log("index=="+index);
//         console.log("aaa=="+selNumVal[index]); //selNumVal의 인덱스 번호를 가져오는 것이 아니고 selNumVal[1] 번째를 가져오는 것
        selNumList += "<option value="+selNumVal[index]+">"+item+"</option>";
    })
//     console.log("selNumList=="+selNumList);
    $("#selNum").append(selNumList);

    
    /* 두 번째 select List */
    var selColStr = {1:"빨강", 2:"파랑", 3:"노랑", 4:"초록"};
    var selColVal = {1:"red", 2:"blue", 3:"yellow", 4:"green"}; //selColStr의 인덱스 정해줌
//     console.log(selColStr);
    
    var selColList = "";

    $.each(selColStr, function(index, item) {
        selColList += "<option value="+selColVal[index]+">"+item+"</option>";
    })
//     console.log("selColList=="+selColList);
    $("#selCol").append(selColList);
}


/* 버튼 눌렀을 때 색상 변경 */
function changeCol() {
	var selNum = $("#selNum").val(); //select로 선택한 글자의 value값을 가져옴
// 	console.log(selNum);
	var selCol = $("#selCol").val(); //select로 선택한 색의 value로 정해준 색을 가져옴
// 	console.log(selCol);
	$("#pTag").find("p").removeAttr("style"); //find태그는 정한 요소를 찾아옴 - id가 pTag인 요소 안에 있는 p요소들을 찾아오고 removeAttr을 이용해서 style을 초기화시켜줌 
	if(selNum == "") {
		$("#pTag").find("p").css("color", selCol);
	} else {
		$("#pTag").find("p").eq(selNum).css("color", selCol);
	}

    if(selNum == "선택"){
//         console.log(selList);
//         console.log("변경할 글자를 선택해 주세요.");
        alert("변경할 글자를 선택해 주세요.");
    } else if (selCol == "선택") {
        alert("변경할 색상을 선택해 주세요.");
    }
	
//     } else if(selNum == "전체") {
// //         console.log(selList);
//         var pTag = $("p");
// //         console.log(pTag.text());

//         if(selCol == "선택"){
//             alert("변경할 색상을 선택해 주세요.");
//         } else if(selCol == "빨강") {
//         	pTag.css("color", "red");
//         } else if(selCol == "파랑") {
//         	pTag.css("color", "blue");
//         } else if(selCol == "노랑") {
//         	pTag.css("color", "yellow");
//         } else if(selCol == "초록") {
//         	pTag.css("color", "green");
//         }
//     } else if(selNum == "첫번째") {
// //         console.log(selList);
//         var a = $("#one");
        
//         if(selCol == "선택"){
//             alert("변경할 색상을 선택해 주세요.");
//         } else if(selCol == "빨강") {
//             a.css("color", "red");
//         } else if(selCol == "파랑") {
//         	a.css("color", "blue");
//         } else if(selCol == "노랑") {
//         	a.css("color", "yellow");
//         } else if(selCol == "초록") {
//         	a.css("color", "green");
//         }
            
//     } else if(selNum == "두번째") {
// //     	console.log(selList);
//         var b = $("#two");

//         if(selCol == "선택"){
//             alert("변경할 색상을 선택해 주세요.");
//         } else if(selCol == "빨강") {
//             b.css("color", "red");
//         } else if(selCol == "파랑") {
//             b.css("color", "blue");
//         } else if(selCol == "노랑") {
//             b.css("color", "yellow");
//         } else if(selCol == "초록") {
//             b.css("color", "green");
//         }
        
//     } else if(selNum == "세번째") {
// //     	console.log(selList);
//         var c = $("#three");

//         if(selCol == "선택"){
//             alert("변경할 색상을 선택해 주세요.");
//         } else if(selCol == "빨강") {
//             c.css("color", "red");
//         } else if(selCol == "파랑") {
//             c.css("color", "blue");
//         } else if(selCol == "노랑") {
//             c.css("color", "yellow");
//         } else if(selCol == "초록") {
//             c.css("color", "green");
//         }

//     } else if(selNum == "네번째") {
// //     	console.log(selList);
//         var d = $("#four");

//         if(selCol == "선택"){
//             alert("변경할 색상을 선택해 주세요.");
//         } else if(selCol == "빨강") {
//             d.css("color", "red");
//         } else if(selCol == "파랑") {
//             d.css("color", "blue");
//         } else if(selCol == "노랑") {
//             d.css("color", "yellow");
//         } else if(selCol == "초록") {
//             d.css("color", "green");
//         }
//     }
}


/* -------------------------- */

//     input으로 입력받은 숫자를 뽑아온 후 해당 숫자만큼 반복문 돌려서 표를 만들면 될듯??
// function inNum() {
// 	var inputVal = $("#val").val();
// 	console.log(inputVal);
// }

function btnNum() {
// 	console.log("ddddd");
    var v = $("#val").val();
//     console.log("%%%=="+v%4); // 1, 2, 3은 1, 2, 3 그대로 반환
    console.log("입력되는 v=="+v);
    var v4 = 0;
    
//  입력되는 v값이 4의 배수가 안 될 때 나머지 x가 들어갈 칸을 구하기 위해 사용 - 5가 입력되도 3칸은 x로 채우니 총 8칸이 필요하니까
    if((4-v%4) != 4) { // v=1일 때  3, v=2일 때 2, v=3일 때 1을 반환 - x가 되는 칸을 만들기 위해 if문 사용 - 4칸일 때는필요 없음 
        v4 = (4-v%4); // v에 5나 1이 입력되면 v4에 3이 입력 - 3칸만큼 x를 입력
	    console.log("if문 실행되고 나서 v4=="+v4);
    }
//  입력되는 v값과 x가 들어갈 v4값을 더한만큼 반복문을 돌림
	v = Number(v) + Number(v4);
    console.log("v와 v4를 더한 v=="+v);

    var h = "";
	for(var i = 1; i <= v; i ++) {
//      i = 1 or 5 처럼  첫 행이 시작될 때 tr을 열어줌
	    if((i%4) == 1) {
		    h += "<tr>";
		}
// 	    else if가 아니라 다음 if문을 수행
//      v+v4-v4 즉 입력받은 v가 v+v4만큼 돌아가는 반복문의 i값보다 작으면 x를 아니면 i값을 넣어줌 
		if((v-v4) < i) {
		    h += "<td>X</td>";
		} else { //
		    h += "<td>"+i+"</td>";
		}
//      1행에 4개의 칸만 있으니 i를 4로 나눴을 때 해당 행이 종료되도록
	    if((i%4) == 0) {
		    h += "</tr>";
		}
	}
	$("#graph").html(h);
	
// 	var inputVal = $("#val").val();
// //     console.log(inputVal);
// //     값을 4로 나눈 몫을 올려서 tr을 만들고
//     var trNum = Math.ceil(inputVal/4);
//     console.log(trNum);
//     var graphList = "";
// //     var tdList = "";
//     var tdNum = 1;

// //     2중 포문 돌려서 위에 포문으로는 tr, 아래 포문으로는 td 넣어서 돌리기?
    
//     for(var i=1; i<=trNum; i++){
//         graphList += "<tr>";
//         for(var j=1; j<5; j++) { 
//         	if(tdNum <= inputVal) {
//         		graphList += "<td>"+tdNum+"</td>"
//                 tdNum++;
//         	} else{
//         		graphList += "<td>x</td>";
//         	}
//         }       
//         graphList += "</tr>";
//     }
    
//     $("#graph").html(graphList);
}




</script>
</html>