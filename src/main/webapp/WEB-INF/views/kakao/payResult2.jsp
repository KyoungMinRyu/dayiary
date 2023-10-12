<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<!DOCTYPE html>
<html>
<head>
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
   background-color:#fffbf4 !important;
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
<%@ include file="/WEB-INF/views/include/head.jsp" %>
<link rel="stylesheet" href="/resources/css/progress-bar.css" type="text/css">
<script type="text/javascript">


$(document).ready(function() {
   
   
    var payMethod = "${kakaoPayApprove2.payment_method_type}";
    var giftpName = "${kakaoPayApprove2.item_name}";
    var quantity = "${kakaoPayApprove2.quantity}";
    var totalPrice = "${kakaoPayApprove2.amount.total}";
    var pgToken = "${pgToken}";
    
    document.getElementById("payMethod").value = payMethod;
     document.getElementById("giftpName").value = giftpName;
     document.getElementById("quantity").value = quantity;
     document.getElementById("totalPrice").value = totalPrice;
     document.getElementById("pgToken").value = pgToken;
     
      // completeForm 폼 요소 가져오기
     var completeForm = document.getElementById("completeForm");
     
     // completeForm의 모든 입력 필드 값을 URL 파라미터로 추가할 객체 생성
     var params = new URLSearchParams();
     for (var i = 0; i < completeForm.elements.length; i++) {
       var field = completeForm.elements[i];
       if (field.name) {
         params.append(field.name, field.value);
       }
     }
     
     // URL 파라미터를 문자열로 변환하여 URL에 추가
     var url = "/kakao/payComplete?" + params.toString();
     
     // 새로운 페이지로 이동
     opener.location.href = url;
     
     //2초뒤 팝업창 닫기
     setTimeout(function() {
           window.close();
       }, 2000);
  
});


</script>
</head>
<body>
<div class="container">
<c:choose>
     <c:when test="${!empty kakaoPayApprove2}">
      <h2 style="margin-bottom:50px;">카카오페이 결제 완료되었습니다.</h2>
       주문번호: ${orderSeq}<br/>
       상품명 : ${kakaoPayApprove2.item_name}<br/>
       결제금액: ${kakaoPayApprove2.amount.total}<br/>
       결제방법: ${kakaoPayApprove2.payment_method_type}<br/>
     </c:when>  
     <c:otherwise>  
      <h2>카카오페이 결제 중 오류가 발생하였습니다.</h2>
    </c:otherwise>
</c:choose>
</div>

<form name="completeForm" id="completeForm" method="post">
   <input type="hidden" name="pgToken" id="pgToken" value="" />      <!-- 토큰 값-->
   <input type="hidden" name="giftFileName" id="giftFileName" value="${giftFileName}" />      <!-- 상품사진 -->
   <input type="hidden" name="orderSeq" id="orderSeq" value="${orderSeq}" />      <!-- 주문번호 -->
   <input type="hidden" name="userName" id="userName" value="${userName}" />      <!-- 주문자이름 -->
   <input type="hidden" name="userPh" id="userPh" value="${userPh}" />            <!-- 주문자연락처 -->
   <input type="hidden" name="price" id="price" value="${price}" />            <!-- 개당 상품금액 -->
   <input type="hidden" name="productSeq" id="productSeq" value="${productSeq}" />            <!-- 상품 번호 -->
   <input type="hidden" name="quantity" id="quantity" value="" />               <!-- 상품수량 -->
   <input type="hidden" name="totalPrice" id="totalPrice" value="" />              <!-- 총금액 -->
   <input type="hidden" name="payMethod" id="payMethod" value="" />              <!-- 결재수단 -->
   <input type="hidden" name="giftpName" id="giftpName" value="" />            <!-- 상품명 -->
   <input type="hidden" name="giftpContent" id="giftpContent" value="${giftpContent}" />  <!-- 상품설명 -->
   <input type="hidden" name="receiveUserName" id="receiveUserName" value="${receiveUserName}" /> <!-- 수취인이름 -->
   <input type="hidden" name="receiveAddress" id="receiveAddress" value="${receiveAddress}" />    <!-- 배송지주소 -->
   <input type="hidden" name="receiveUserPh" id="receiveUserPh" value="${receiveUserPh}" />      <!-- 수취인연락처 -->
   <input type="hidden" name="deliveryMsg" id="deliveryMsg" value="${deliveryMsg}" />            <!-- 배송메세지 -->
</form>

</body>
</html>