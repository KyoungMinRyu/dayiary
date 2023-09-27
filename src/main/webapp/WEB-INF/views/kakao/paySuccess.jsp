<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/views/include/head.jsp" %>
<link rel="stylesheet" href="/resources/css/progress-bar.css" type="text/css">
<script type="text/javascript">
   //현재 paySuccess.jsp화면은 iframe 화면인 것

   $(document).ready(function(){
   parent.kakaoPayResult("${pgToken}"); //현재 paySuccess.jsp의 parent는 payPopUp.jsp이므로 payPopUp.jsp에 있는 kakaoPayResult 함수로 이동한다

      
})
</script>

</head>
<body>

</body>
</html>