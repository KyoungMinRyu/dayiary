<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/views/include/head.jsp" %>
<link rel="stylesheet" href="/resources/css/progress-bar.css" type="text/css">
<script type="text/javascript">
$(document).ready(function() {
    
   $("#btnPay").on("click", function() {
      $("#btnPay").prop("disabled", true);
      
      icia.ajax.post({
         
         url:"/kakao/payReady",
         data:{
            itemName:$("#itemName").val(),
            quantity:Number($("#quantity").val().replaceAll(",", "").replace("명", "")),
            totalAmount:Number($("#totalAmount").val().replaceAll(",", "").replace("원", "")),
            orderId:$("#orderId").val()
         },
         success:function(response)
         {
            if(response.code == 0)
            {
               //alert("성공");
               //var orderId = response.data.orderId;
               var tId = response.data.tId;
               var pcUrl = response.data.pcUrl;
               
               //$("#orderId").val(orderId);
               $("#tId").val(tId);
               $("#pcUrl").val(pcUrl);
               
               var win = window.open('', 'kakaoPopUp', 
               'toolbar=no,location=no,status=no,menubar=no,scrollbars=yes,resizable=no,width=540,height=660,left=650,top=150');
               
               $("#kakaoForm").submit();
         
               
               $("#btnPay").prop("disabled", false);
            }
            else
            {
               alert("오류가 발생하였습니다.");
               $("#btnPay").prop("disabled", false);
            }
         },
         error:function(error)
         {
            icia.common.error(error);
            $("#btnPay").prop("disabled", false);
         }
         
      });
      
      
   });
   

});



function movePage()
{
   var orderSeq = document.getElementById("orderId").value;
   opener.payComplete(orderSeq); //결제 완료했으니 restoView로 돌아가서 예약건 결제대기중(W)->예약완료(Y)로 업데이트하는 함수 호출
    window.close();
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
    height: 600px;
    background-color: white;
    margin-top: 50px;
    font-size: 25px;
    padding:20px;
}

input#itemName, input#quantity, input#totalAmount
{
   width: 300px !important;
   margin-bottom:15px !important;
   font-size:18px;
}

h2
{
   margin-top:30px;
   margin-bottom:50px;
}

.btn-primary {
    color: #fff;
    background-color: #ff9600;
    border-color: #ff9600;
}

.btn-primary:hover {
    color: #fff;
    background-color: black;
    border-color: black;
}

button
{
   margin-top:20px;
}


</style>
</head>
<body>
<div class="container">
   <h2>예약금을 결제해 주세요.</h2>
   <form name="payForm" id="payForm" method="post">
      레스토랑명<input type="text" name="itemName" id="itemName" maxlength="50" class="form-control mb-2" placeholder="레스토랑명" value="${itemName}" readonly/>
      예약 인원<input type="text" name="quantity" id="quantity" maxlength="3" class="form-control mb-2" placeholder="수량" value="<fmt:formatNumber value="${quantity}" pattern="#,###"/>명" readonly />
      총 예약금<input type="text" name="totalAmount" id="totalAmount" maxlength="10" class="form-control mb-2" placeholder="금액" value="<fmt:formatNumber value="${totalAmount}" pattern="#,###"/>원" readonly/>
      <div class="form-group row">
         <div class="col-sm-12">
            <button type="button" id="btnPay" class="btn btn-primary" title="카카오페이">카카오페이 결제</button>
         </div>
      </div>
   </form>
  <form name="kakaoForm" id="kakaoForm" method="post" target="kakaoPopUp" action="/kakao/payPopUp">
      <input type="hidden" name="orderId" id="orderId" value="${orderSeq}" />
      <input type="hidden" name="tId" id="tId" value="" />
      <input type="hidden" name="pcUrl" id="pcUrl" value="" />
   </form>
    
    
</div>
</body>
</html>