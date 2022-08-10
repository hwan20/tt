<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../common/common.jsp" %>
<%@ include file="../common/nav.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
    .calYearMon{
        text-align : center;
        font-size : 3rem;
    }
    .colToday{
        background-color : #FFA07A;
    }


     #calDate td:nth-child(1){
         background-color : #ffc0cb;
     }
    #calDate td:nth-child(7){
        background-color : #9370DB;
    }

</style>
</head>
<body>
<div class="container">
	<!-- 여기에 년도와 달 표시하기 -->
	<div class="calYearMon">
	   <b id="year"></b><br />
	   <a href="#" id="preMon">&#60;</a>
	   <b id="mon"></b>
	   <a href="#" id="nextMon">&#62;</a>
	</div>
	<table class="table table-striped" id="calendar">
	    <thead>
            <tr id="calDay">
            </tr>
	    </thead>
        <!-- table안에 tbody도 동적으로 넣으면 부트스트랩이 안 먹히는 듯? -->
	    <tbody id="calDate">
	    </tbody>
	</table>
</div>
</body>
<script>
// $(document).ready(function(){}) 와 같음
$(function(){
//누른 날짜의 popup창 띄우기 - td에 a로 popup창 뜨는 이벤트 함수 주기?
//지정한 날짜의 데이터 정보 입력하기 - popup에 입력된 데이터를 controller에 전달해서 입력하기?
	buildCalendar()
	
})


var today = new Date();
var date = new Date();


function buildCalendar() {
    	
    dayOfWeekStr = "";
    dayOfWeek = {
            1:"일", 2:"월", 3:"화", 4:"수", 5:"목", 6:"금", 7:"토" 
    };
    $.each(dayOfWeek, function(index, item){
//     console.log("item=="+item);
        dayOfWeekStr += "<th>"+item+"</th>";
    })
// console.log(dayOfWeekStr);
    $("#calDay").html(dayOfWeekStr);

//  https://dororongju.tistory.com/116 date함수 설명
    nowYear = today.getFullYear(); // 현재 연도
    nowMonth = today.getMonth(); // 현재 월 - 1월은 0으로 나옴
    firstDay = new Date(nowYear,nowMonth,1).getDay(); // 현재 년도와 월의 1일이 있는 요일 - 일요일=0, 월요일=1, 화요일=2 ...
    firstDate = new Date(nowYear,nowMonth,1).getDate(); // 현재 월의 1일
    lastDate = new Date(nowYear,nowMonth+1,0).getDate(); // 현재 월의 마지막 일수
    
//     console.log("nowYear="+nowYear);
//     console.log("nowMonth="+(nowMonth+1));
//     console.log("firstDate="+firstDate);
//     console.log("firstDay="+firstDay);
//     console.log("lastDate="+lastDate);
    
    $("#year").html(nowYear);
    $("#mon").html(nowMonth+1);
    
//  윤년 적용 - 알아서 적용되나?
//  if((nowYear%4==0 && nowYear % 100 !=0) || nowYear%400==0) {
//      lastDate[1]=29;
//  }

    
    
    var calDateData = "";

    calDateData += "<tr>";
//  이번 달 1일의 요일까지 빈 공간을 만들어줌 - 일요일:0
    for (i=0; i<firstDay; i++) {
        calDateData += "<td></td>";
    }

//  이번 달의 일수까지 반복문을 돌리면서 날짜를 출력해줌
    for (i=1; i<=lastDate; i++){
        plusDate = new Date(nowYear,nowMonth,i).getDay(); //  
//      console.log("plusDate=="+plusDate);
        if (plusDate == 0) {
            calDateData += "</tr>";
            calDateData += "<tr>";
        } 
//      else if (plusDate == 6) {
//          calDateData += "</tr>";
//      }   
        calDateData += "<td class='date'>"+i+"</td>";
    }


//  마지막 주의 빈칸을 넣기 위해 다음 달이 시작하는 요일의 값을 가져옴 - 만약 값이 2(화요일)이면 6까지 빈값을 출력, 0(일요일)이면 반복하여 출력하지 않기
    firstDay2 = new Date(nowYear,nowMonth+1,1).getDay();
//     console.log("다음 달 1일의 요일=="+firstDay2);
    
//  이번 달 1일의 요일까지 빈 공간을 만들어줌 - 일요일:0
    for (i=firstDay2; i<=6; i++) {
        if(firstDay2==0){ //다음 달이 시작하는 요일이 일요일이면 반복문 동작 X하도록
            break;
        } else {
            calDateData += "<td></td>";
        }
    }



//  console.log(calDateData);
    $("#calDate").append(calDateData);

    
//  빈 값인 토요일 일요일에는 색을 넣지 않기
//  td의 값이 null일 경우 백그라운드 색 없게 하게
//  첫 번째 일요일이 빈 값이면 색을 없애기 위해
//  a=$("#calDate td:first").html();
    a=$("#calDate td:eq(0)").html();
//  a=$("#calDate td:first").text();
//     a=$("td:first").html();
//     console.log("first td=="+a);

//  마지막 토요일이 빈 값이면 색을 없애기 위해
    b=$("#calDate tr:last td:last").html();
//  b=$("tr").last().html();
//     console.log("last td=="+b);

    if(a=="") {
//         console.log("a=aaaa");
        $("#calDate").find("td:eq(0)").css("background-color", "white");
    }
    if(b=="") {
//         console.log("b=aaaa");
        $("#calDate").find("tr:last td:last").css("background-color", "white");           
    }
    

//  오늘 날짜 표시
    $(".date").each(function(index){
//      console.log("td date="+index);
//      console.log("nowYear1="+nowYear);
//      console.log("nowYear2="+date.getFullYear());
//      console.log("nowMonth1="+nowMonth);
//      console.log("nowMonth2="+date.getMonth());
//      console.log("date1="+(".date").eq(index).text());
//      console.log("date2="+date.getDate());
//         현재 연도와 표시된 연도 && 현재 달과 표시된 달 && td에 표시된 값과 현재 날의 값을 비교
        if(nowYear==date.getFullYear() && nowMonth==date.getMonth() && $(".date").eq(index).text()==date.getDate()) {
//          값이 같으면 해당 인덱스에 colToday 라는 클래스를 생성 -> css에서 색을 표시해주려고
            $(".date").eq(index).addClass('colToday');
//          console.log("???=="+$(".date").eq(index).addClass('colToday'));
        }
    })


}

//     이전 달
$("#preMon").click(function() { 
    //td, tr 삭제 순서 상관 X
//     $("#calendar > tbody > td").remove();
//     $("#calendar > tbody > tr").remove();
    $("#calDate > tr").remove();
    $("#calDate > td").remove();
    today = new Date ( today.getFullYear(), today.getMonth()-1, today.getDate());
    buildCalendar();
})
    
//     다음 달
$("#nextMon").click(function(){
//     $("#calendar > tbody > td").remove();
//     $("#calendar > tbody > tr").remove();
    $("#calDate > td").remove();
    $("#calDate > tr").remove();
    today = new Date ( today.getFullYear(), today.getMonth()+1, today.getDate());
    buildCalendar();
}) 


// 날짜를 눌렀을 때 popup창이 뜨도록 하기
// 팝업창은 어떤걸로? 모달창? https://velog.io/@keywookim/What-is-%EB%AA%A8%EB%8B%AC-or-%ED%8C%9D%EC%97%85
$("#calDate").on("click", "td", function(){
// 	console.log($(this).text());
//     window.open(); //https://m.blog.naver.com/dasol825/220672901113
})





</script>
</html>