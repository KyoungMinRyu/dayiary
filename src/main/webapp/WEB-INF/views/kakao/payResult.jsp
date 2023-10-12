<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/views/include/head.jsp" %>
<link rel="stylesheet" href="/resources/css/progress-bar.css" type="text/css">
<script type="text/javascript">
setTimeout(function() {
    window.close();
}, 2000);


function fn_paySuccess()
{
    opener.movePage(); //pay의 movePage함수 호출   
}


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
   width:540px;
   background-color:#fffbf4;
}

.container
{
   width: 90%;
    height: 550px;
    background-color: white;
    margin-top: 50px;
    font-size: 20px;
    padding:20px;
}

h2
{
   margin-top:30px;
   margin-bottom:50px;
}



</style>
</head>
<body>
<div class="container">
<c:choose>
     <c:when test="${!empty kakaoPayApprove}">
      <h2>카카오페이 결제 완료되었습니다.</h2>
       예약번호: ${kakaoPayApprove.partner_order_id}<br/>
       레스토랑명: ${kakaoPayApprove.item_name}<br/>
       예약인원: <fmt:formatNumber value="${kakaoPayApprove.quantity}" pattern="#,###"/>명<br/>
       결제금액: <fmt:formatNumber value="${kakaoPayApprove.amount.total}" pattern="#,###"/>원<br/>
       결제방법: ${kakaoPayApprove.payment_method_type}<br/>
<script>fn_paySuccess();</script>
     </c:when>  
     <c:otherwise>  
      <h2>카카오페이 결제 중 오류가 발생하였습니다.</h2>
    </c:otherwise>
</c:choose>
</div>
</body>
</html>