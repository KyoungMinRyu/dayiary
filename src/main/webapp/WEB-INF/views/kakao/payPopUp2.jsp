<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/views/include/head.jsp" %>
<link rel="stylesheet" href="/resources/css/progress-bar.css" type="text/css">
<script type="text/javascript">

function kakaoPayResult2(pgToken)
{
	$("#pgToken").val(pgToken);
	
	document.kakaoForm.action = "/kakao/payResult2";
	document.kakaoForm.submit();
}

window.onbeforeunload = function() {
    window.opener.location.reload();
}

</script>

</head>
<body>	<!-- pay.jsp후 controller를 거쳐서 가져온 값을 아래에 각각 담고 iframe으로 QR코드페이지를 나타내주는 것, 결제 하면 KAKAOPAY측에서 사용자에게 approval Url로 redirect해주는 데 해주는 주소는 ${pcUrl}로 해준다, 이떄 pgToken값도 보냄 -->
<iframe width="100%" height="650" src="${pcUrl}" frameborder="0" allowfullscreen=""></iframe>
<form name="kakaoForm" id="kakaoForm" method="post">
	<input type="hidden" name="orderId" id="orderId" value="${orderId}" />
	<input type="hidden" name="tId" id="tId" value="${tId}" />
	<input type="hidden" name="userId" id="userId" value="${userId}" />
	<input type="hidden" name="pgToken" id="pgToken" value="" />
	<input type="hidden" name="orderSeq" id="orderSeq" value="${orderSeq}" />
	<input type="hidden" name="giftFileName" id="giftFileName" value="${giftFileName}" />
	<input type="hidden" name="userName" id="userName" value="${userName}" />
	<input type="hidden" name="userPh" id="userPh" value="${userPh}" />
	<input type="hidden" name="price" id="price" value="${price}" />
	<input type="hidden" name="productSeq" id="productSeq" value="${productSeq}" />
	<input type="hidden" name="giftpContent" id="giftpContent" value="${giftpContent}" />
	<input type="hidden" name="receiveUserName" id="receiveUserName" value="${receiveUserName}" />
	<input type="hidden" name="receiveAddress" id="receiveAddress" value="${receiveAddress}" />
	<input type="hidden" name="receiveUserPh" id="receiveUserPh" value="${receiveUserPh}" />
	<input type="hidden" name="deliveryMsg" id="deliveryMsg" value="${deliveryMsg}" />
</form>
</body>
</html>