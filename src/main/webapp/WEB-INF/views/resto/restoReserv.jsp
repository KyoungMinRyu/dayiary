<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/views/include/head.jsp" %>
<link rel="stylesheet" href="/resources/css/progress-bar.css" type="text/css">
<script type="text/javascript">
$(document).ready(function() {
   
	let date = "${orderDate}"; 
	const cnt = ${quantity};
	const restoName = "${itemName}";
	let time = "${orderTime}";
	const orderSeq = "${orderSeq}";
	
	date = date.replaceAll("-", "");
	
	date = date.replaceAll(".", "");
	
	time = time.replaceAll(":", "");
	
	time = time.replaceAll(" ", "");
	
	let showTime = time.substr(0, 2) + ":" + time.substr(-2);
	
	let title = restoName + "에서 " + showTime + "에 예약이 있습니다.";
	let content = restoName + "에서 " + showTime + "에 " + cnt + "명 예약이 있습니다."
	let year = date.substr(0, 4);
	let month = date.substr(4, 2);
	let day = date.substr(6, 2);
	
	let formData = 
    {
      year: year,
      month: month,
      day: day,
      calTitle: title,
      calContent: content,
      calTime: time,
      orderSeq: orderSeq
    };
	
	
	$.ajax
    ({
        type: "POST",
        url: "/anniversary/addAnniversary",
        data: formData,
        error: function(xhr, status, error) 
        {
            console.log(error);
        }
    }); 
	
	
   $("#btnList").on("click", function() {
         location.href = "/resto/restoList";
   });
   
   
   
});



</script>
<style>

@font-face {
    font-family: 'SUIT-Regular'; /* 고딕 */
    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_suit@1.0/SUIT-Regular.woff2') format('woff2');
    font-weight: 100;
    font-style: normal;
} 

*
{
   font-family : 'SUIT-Regular', sans-serif;
}


body
{
   width:100%;
    background-image: url("/resources/images/resto.jpg");
    background-size: cover;
    background-repeat: no-repeat; 
}


#cc
{
   width: 90%;
    background-color: white !important;
    margin-top: 100px;
    font-size: 20px;
    padding:20px;
    height:700px;
    border-radius:20px;
}

h2
{
   margin-top:30px;
   margin-bottom:50px;
}

button
{
   margin-top:10px;
}

#btnContainer
{
   display: flex;
    align-items: center;
    flex-direction: column;

}

</style>
</head>
<body>
<div class="container" id="cc" style="height:730px;">
    <h2 style="text-align:center; font-weight:bold;">
       매일을 다이어리처럼 기록하는 고객님! <br>《 ${itemName} 》 예약이 완료되었습니다.
   </h2>
   <p style="text-align:center;">
       고객님과 함께한 이 순간을 소중히 여깁니다. 언제든지 Dayiary와 함께하세요 🍷    
   </p>
   <h4>《 예약 정보 》</h4>
      레스토랑명<input type="text" name="itemName" id="itemName" maxlength="50" class="form-control mb-2" value="${itemName}" readonly/>
      예약 날짜<input type="text" name="orderDate" id="orderDate" maxlength="50" class="form-control mb-2" value="${orderDate}" readonly/>
      예약 시간<input type="text" name="orderTime" id="orderTime" maxlength="50" class="form-control mb-2" value="${orderTime}" readonly/>
      예약 인원<input type="text" name="quantity" id="quantity" maxlength="3" class="form-control mb-2" placeholder="수량" value="${quantity}명" readonly />
      총 예약금<input type="text" name="totalAmount" id="totalAmount" maxlength="10" class="form-control mb-2" placeholder="금액" value="<fmt:formatNumber value="${totalAmount}" pattern="#,###"/>원" readonly/>
<div id="btnContainer">
<button id="btnList" type="button" style="margin-top:20px;">리스트로 돌아가기</button>
</div>
</div>

</body>
</html>