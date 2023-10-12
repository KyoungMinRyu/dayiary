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

body
{
   background: #fffbf4 !important;
}

#step-3 {
  position: fixed;
}

.row
{
   font-family: 'SUIT-Regular', sans-serif;
	font-size: 18px;
}

input[type="text"] {
  font-size: 20px !important;
}

</style>


<link rel='stylesheet' href='https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0-beta/css/materialize.min.css'>
<link rel='stylesheet' href='https://fonts.googleapis.com/icon?family=Material+Icons'>
<link rel='stylesheet' href='https://cdnjs.cloudflare.com/ajax/libs/Swiper/4.0.7/css/swiper.min.css'>

<!-- partial -->
<script src='https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js'></script>
<script src='https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0-beta/js/materialize.min.js'></script>
<script src='https://cdnjs.cloudflare.com/ajax/libs/axios/0.16.2/axios.min.js'></script>
<script src='https://dawa.aws.dk/js/autocomplete/dawa-autocomplete2.min.js'></script>
<script src='https://cdnjs.cloudflare.com/ajax/libs/Swiper/4.0.7/js/swiper.min.js'></script>
<script src='https://cdn.jsdelivr.net/npm/vue-awesome-swiper@3.1.2/dist/vue-awesome-swiper.js'></script>


<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script> <!-- 우편번호찾기 (다음주소API) -->
<%@ include file="/WEB-INF/views/include/head.jsp" %>

<script>



var index;
var getName = new RegExp(/^[가-힣a-zA-Z\s]+$/); // 이름 유효성 검사를 위한 정규 표현식 (한글, 영문, 공백 허용)
var getMail = new RegExp(/^[A-Za-z0-9_\.\-]+@[A-Za-z0-9\-]+\.[A-Za-z0-9\-]+/); // 이메일 정규표현식
var getPh = new RegExp(/^01([0|1|6|7|8|9])([0-9]{3,4})([0-9]{4})$/);
var msgArr = 
[ 
   "이메일은 형식에 맞게 입력해 주세요",
   "성함은 한글 또는 영문만 입력해 주세요",
   "전화번호 양식에 맞게 입력해주세요"
];


$(function() 
{
   
   $("#receiveUserName").on("input", function() 
            {
                var inputText = $(this).val();
                var messageElement = $("#receiveUserNameMsg");
                
                var sanitizedText = inputText.replace(/[0-9]/g, ""); // 숫자 제거

                if (sanitizedText !== inputText) 
                {
                    messageElement.text(msgArr[1]);
                    
                    $(this).off("input"); // 이벤트 핸들러 제거
                    $(this).val(sanitizedText);
                    $(this).on("input", arguments.callee); // 이벤트 핸들러 다시 추가
                } 
                else if (!getName.test(inputText)) 
                {
                    messageElement.text(msgArr[1]);
                }
                else
                {
                    messageElement.html("&nbsp;");
                    $("#hiddenName").val($("#receiveUserName").val());
                }
            });

      $("#receiveUserName").on("focusout", function() 
      {
          $("#receiveUserNameMsg").html("&nbsp;");
      });

    $("#receiveUserEmail").on("input", function() 
     {
          var inputText = $(this).val();
          var messageElement = $("#receiveUserEmailMsg");
          if (!getMail.test(inputText)) 
          {
             
              messageElement.text(msgArr[0]);
          } 
          else
          {
              messageElement.html("&nbsp;");
          }
           
     });   
    
    $("#receiveUserEmail").on("input", function() 
    {
        var inputText = $(this).val();
        var messageElement = $("#receiveUserEmailMsg"); // 변수 정의 추가
        if (!getMail.test(inputText)) 
        {
            messageElement.text("이메일은 형식에 맞게 입력해 주세요");
            $(this).focus(); // 이메일 입력 필드에 포커스를 맞춥니다.
        }
        else 
        {
            messageElement.html("&nbsp;");
        }
    });

    
    
    $("#receiveUserPh").on("input", function() 
          {
              var inputText = $(this).val();
              var messageElement = $("#receiveUserPhMsg");
              if (!getPh.test(inputText)) 
              {
                  messageElement.text(msgArr[2]);
                  var sanitizedText = inputText.replace(/[^0-9]/g, "");
                  
                  $(this).off("input"); // 이벤트 핸들러 제거
                  $(this).val(sanitizedText);
                  $(this).on("input", arguments.callee); // 이벤트 핸들러 다시 추가
              } 
              else
              {
                  messageElement.html("&nbsp;");
              }
          });

     
    $("#detailAddress").on("input", function() 
    {
       $("#userAddMsg").html("&nbsp;");
       $("#hiddenAdd").val($("#roadAddress").val() + " " + $("#detailAddress").val());    
    });         
    
            
    $("#btnPay").on("click", function()
    {         
       $("#btnPay").prop("disabled", true);
       
       if($("#receiveUserName").val() == null || $("#receiveUserName").val() == "")
         {
             $("#receiveUserName").focus();
             alert("받는 분을 입력하세요");
             $("#btnPay").prop("disabled", false);
             return;
         }
       
       if($("#receiveUserEmail").val() == null || $("#receiveUserEmail").val() == "")
         {
             $("#receiveUserEmail").focus();
             alert("이메일을 입력하세요");
             $("#btnPay").prop("disabled", false);
             return;
         }
       
       if(!fn_validateEmail($("#receiveUserEmail").val()))
         {
            alert("이메일 형식이 올바르지 않습니다.");
            $("#receiveUserEmail").focus();
            $("#btnPay").prop("disabled", false);
            return;
         }
      
       if($("#receiveUserPh").val() == null || $("#receiveUserPh").val() == "")
         {
             $("#receiveUserPh").focus();
             alert("연락처를 입력하세요");
             $("#btnPay").prop("disabled", false);
             return;
         }
       if($("#detailAddress").val() == null || $("#detailAddress").val() == "")
         {
             $("#detailAddress").focus();
             alert("주소를 입력하세요");
             $("#btnPay").prop("disabled", false);
             return;
         }
       
       if(!$("#checkBox1").prop("checked"))
        {
           alert("개인정보 수집 및 이용 동의에 체크해주세요.");
           $("#btnPay").prop("disabled", false);
           return;
        }
       if(!$("#checkBox2").prop("checked"))
        {
           alert("개인정보 3자 제공 동의에 체크해주세요.");
           $("#btnPay").prop("disabled", false);
           return;
        }
       if(!$("#checkBox3").prop("checked"))
        {
          alert("전자결제대행 이용 동의에 체크해주세요.");
          $("#btnPay").prop("disabled", false);
           return;
        }
       
       var giftpContent = "${giftpContent}";
       var price = "${price}";
       var userName = "${user.userName}";
       var userPh = "${user.userPh}";
       var giftFileName = "${giftFileName}";
       var productSeq = "${productSeq}";
       
      icia.ajax.post({
         url:"/kakao/payReady2",
         data:{
            itemCode:$("#itemCode").val(),   //productSeq
            itemName:$("#itemName").val(),      
            quantity:$("#quantity").val(),
            totalAmount:$("#totalAmount").val(),
            
            giftFileName: giftFileName,
            userName: userName,
            userPh: userPh,
            price: price,
            productSeq: productSeq,
            giftpContent: giftpContent,
            receiveUserName:$("#receiveUserName").val(),
            roadAddress:$("#roadAddress").val(),
            detailAddress:$("#detailAddress").val(),
            receiveUserPh:$("#receiveUserPh").val(),
            deliveryMsg:$("#deliveryMsg").val()
            
         },
         success:function(response)
         {   
            if(response.code == 0)
            {
               
               //alert("성공");
               var orderId = response.data.orderId;
               var tId = response.data.tId;
               var pcUrl = response.data.pcUrl;
               
               $("#orderId").val(orderId);
               $("#tId").val(tId);
               $("#pcUrl").val(pcUrl);
               
               
               var orderSeq = response.data.orderSeq;  //결재 완료시 ORDER_LIST에 STATUS를 Y로 바꾸기 위해 가져 온 값.
               $("#orderSeq").val(orderSeq);
               
               var giftFileName1 = response.data.giftFileName;
               var userName1 = response.data.userName;
               var userPh1 = response.data.userPh;
               var price1 = response.data.price;
               var productSeq1 = response.data.productSeq;
               var giftpContent1 = response.data.giftpContent;
               var receiveUserName1 = response.data.receiveUserName;
               var roadAddress1 = response.data.roadAddress;
               var detailAddress1 = response.data.detailAddress;
               var receiveUserPh1 = response.data.receiveUserPh;
               var deliveryMsg1 = response.data.deliveryMsg;
               
               $("#giftFileName1").val(giftFileName1);
               $("#userName1").val(userName1);
               $("#userPh1").val(userPh1);
               $("#price1").val(price1);
               $("#productSeq1").val(productSeq1);
               $("#giftpContent1").val(giftpContent1);
               $("#receiveUserName1").val(receiveUserName1);
               $("#roadAddress1").val(roadAddress1);
               $("#detailAddress1").val(detailAddress1);            
               $("#receiveUserPh1").val(receiveUserPh1);
               $("#deliveryMsg1").val(deliveryMsg1);
               
               
               var win = window.open('', 'kakaoPopUp2', 'toolbar=no,location=no,status=no,menubar=no,scrollbars=yes,resizable=no,width=540,height=660,left=650,top=150');
               //window를 새로 오픈하고 kakaoPopUp에서 화면을 보여주라는것      //아래 kakaoForm에 있는 target때문에 위에 kakaoPopUp위치에 action에 있는 url을 띄우는 것
               $("#kakaoForm").submit();
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


   //주문자와 동일버튼 클릭시 자동값 입력
   function fetchUserData() 
   {
     if($('#sameAsUser').is(':checked')) 
     {
       $('#receiveUserName').val("${user.userName}");
       $('#receiveUserEmail').val("${user.userEmail}");
       $('#receiveUserPh').val("${user.userPh}");
       $('#detailAddress').val("${user.userAddress}");
       $('#postcode').val("");
       $('#roadAddress').val("");
       $('#postcode').prop('readonly', true);
       $('#roadAddress').prop('readonly', true);
       
       // 숨기려는 입력 필드와 그 부모 요소를 숨깁니다.
   
     } 
     else
     {
       // 체크박스가 해제된 경우, 필드를 비웁니다.
       $('#receiveUserName').val("");
       $('#receiveUserEmail').val("");
       $('#receiveUserPh').val("");
       $('#detailAddress').val("");
       $('#postcode').val("");
       $('#roadAddress').val("");
       $('#postcode').prop('readonly', false);
       $('#roadAddress').prop('readonly', false);
       // 필드와 부모 요소를 다시 
     }
   }
   
   //4. Daum Postcode service related function
   function getDaumPostcode() {
     
      
      new daum.Postcode
      ({
          oncomplete: function(data) 
           {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
   
                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
              var addr = ''; // 주소 변수
               var extraAddr = ''; // 참고항목 변수
   
                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
               if (data.userSelectedType === 'R') 
               { // 사용자가 도로명 주소를 선택했을 경우
                   addr = data.roadAddress;
               }
               else 
               { // 사용자가 지번 주소를 선택했을 경우(J)
                  addr = data.jibunAddress;
               }
   
                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
               if(data.userSelectedType === 'R')
               {
                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                   if(data.bname !== '' && /[동|로|가]$/g.test(data.bname))
                   {
                       extraAddr += data.bname;
                   }
                   // 건물명이 있고, 공동주택일 경우 추가한다.
                   if(data.buildingName !== '' && data.apartment === 'Y')
                   {
                       extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                   }
               } 
   
                // 우편번호와 주소 정보를 해당 필드에 넣는다.
               document.getElementById('postcode').value = data.zonecode;
               document.getElementById("roadAddress").value = addr;
                // 커서를 상세주소 필드로 이동한다.
               
               $('#detailAddress').val("");
               $("#detailAddress").focus();
                
             }
         }).open();
}

function fn_validateEmail(value)
{
   var emailReg = /^([\w-\.]+@([\w-]+\.)+[\w-]{2,4})?$/;
   
   return emailReg.test(value);
}
   
 
</script>

</head>
<body>
<%@ include file="/WEB-INF/views/include/navigation.jsp" %>
<div id="app" style="margin-top:100px;">
  <div class="header">
      <div class="progress-container hide-on-med-and-up">  
      <div class="progress-bar js-progress-bar"></div>
      </div>   
  </div>
  
  <div class="container wrapper">
    <div class="row hide-on-med-and-up">
      <div class="col s12 m6">
        <div class="card">
          <div class="card-content">
            <p><b>Shipping:</b> {{chosenShippingMethod.name}} - ${{shippingPrice}}</p>
            <p><b>Total:</b> ${{basketTotal}}</p>
            <span class="small-text grey-text text-darken-2 m-top-10 ">Fill out the information below and go directly to payment by clicking the button.</span>
          </div>
        </div>
      </div>
    </div>
    
    <div style="width: 130% !important;"class="row">
      <div class="col s12 m6">
      
        <div class="card" id="step-1" >
              <div class="card-content">
                  <span class="card-title activator grey-text text-darken-4"><b>상품 정보</b></span>
                  <table>
                      <thead>
                          <tr style="font-size : 20px;">
                              <th scope="col" class="text-center" style="width:50%">상품정보</th>
                              <th scope="col" class="text-center" style="width:20%">판매가</th>
                              <th scope="col" class="text-center" style="width:15%">수량</th>
                              <th scope="col" class="text-center" style="width:15%">총구매가</th>
                          </tr>
                      </thead>
                      <tbody>
                          <tr class="cart__list__detail" style="font-size : 18px;">
                            <td style="width:90%; display: flex; align-items: center;">
                              <img src="/resources/upload/${giftFileName}" style="width:100px;" alt="">                             
                              <div style="margin-left: 10px;">
                                  <p style="font-size : 20px; ">${giftpName}</p>
                              </div>
                            </td>
                            <td style="width:20%; white-space: nowrap;">
                                <span class="price">　<fmt:formatNumber value="${price}" pattern="#,###" />원</span>
                            </td>
                            <td style="width:15%; white-space: nowrap;">
                                <span class="quantity">　　　${quantity}</span>
                            </td>
                            <td style="width:25%; white-space: nowrap; text-align : center;">
                                <span class="totalPrice" ><fmt:formatNumber value="${totalPrice}" pattern="#,###" />원</span>
                            </td>
                         </tr>
                      </tbody>
                    </table>
                </div>
            </div>


        <div class="card" id="step-2">
          <div class="card-content">
            <span class="card-title activator grey-text text-darken-4"><b>배송지 정보</b></span>
              <div class="row m-top-15">
               <form class="col s12">
               <br/>
               <label class="d-block m-top-15">
                 <input type="checkbox" id="sameAsUser" onclick="fetchUserData()" class="filled-in" />
                 <span style="font-size: 18px;">주문자정보와 동일</span>
               </label>
                <div class="row">
                  <div class="input-field col s12 l6 m-top-15">
                    <input type="text" name="receiveUserName" id="receiveUserName" maxlength="100" style="ime-mode:active;  font-weight: bold;" value="" class="form-control mb-2" placeholder="받는분" required />
                    <p id="receiveUserNameMsg">  
                   </p> 
                  </div>
                </div> 
                <div class="row">
                  <div class="input-field col s12 l6 m-top-15">
                  <input type="text" name="destination" id="destination" maxlength="100" style="ime-mode:active;  font-weight: bold;" value="" class="form-control mb-2" placeholder="배송지명" required />                      
                   <p id="userdestinationMsg">  
                   ex) 집, 회사
                  </p>
                  </div>
                </div>
                <div class="row"> 
                <div class="input-field col s12 l6 m-top-15">
                  <input type="text" name="receiveUserEmail" id="receiveUserEmail" maxlength="100" style="ime-mode:active;  font-weight: bold;" value="" class="form-control mb-2" placeholder="이메일" required />                      
                  <p id="receiveUserEmailMsg">  
                  </p> 
                </div>
                </div>
                <div class="row">
                   <div class="input-field col s12 l6 m-top-15">
                     <input type="text" name="receiveUserPh" id="receiveUserPh" maxlength="100" style="ime-mode:active;  font-weight: bold;" value="" class="form-control mb-2" placeholder="연락처" required />                      
                     <p id="receiveUserPhMsg">  
                     </p> 
                   </div>
                </div>
                <br/>
                <div class="row">
                   <div class="input-field col s12 l6 m-top-15">
                     <input type="button" onclick="getDaumPostcode()" id="btnSearch" class="btn btn-secondary mb-3 mx-1" value="우편번호 찾기">
                   </div>
                </div>   
                  <div class="row">
                    <div class="input-field col s12 l6 m-top-15">
                        <input type="text" name="postcode" id="postcode" maxlength="100" style="ime-mode:active;  font-weight: bold;" value="" class="form-control mb-2" placeholder="우편번호" required />                      
                    </div>
                    <div class="input-field col s12 l6 m-top-15">
                        <input type="text" name="roadAddress" id="roadAddress" maxlength="100" style="ime-mode:active;  font-weight: bold;" value="" class="form-control mb-2" placeholder="도로명주소" required />                     
                    </div>
                  </div>
                <div class="row m-top-15">
                  <div class="input-field col s12 autocomplete-container">
                    <input type="text" name="detailAddress" id="detailAddress" maxlength="100" style="ime-mode:active;  font-weight: bold;" value="" class="form-control mb-2" placeholder="상세주소" required />                    
                     <p id="userAddMsg">
                  &nbsp;
                     </p>
                  </div>
                </div>
                <div class="row m-top-15">
                  <div class="input-field col s12 autocomplete-container">
                    <input type="text" name="deliveryMsg" id="deliveryMsg" maxlength="100" style="ime-mode:active;  font-weight: bold;" value="" class="form-control mb-2" placeholder="배송메세지" required />                    
                  </div>
                </div>
              </form>
            </div>
          </div>
        </div>
        
      </div>


      <div class="col s12 m6">
      
        <div class="card" id="step-3" >
          <div class="card-content">
           <span class="card-title activator grey-text text-darken-4 m-top-15"><b>결제 상세</b></span>
            <br/> 
            <ul>
              <li>
                <span><b>총 구매수량</b></span>
                <span style="float: right; margin-left: 10px;">${quantity}</span>
              </li>
              <li>
                <span><b>상품금액</b></span>
                 <span style="float: right; margin-left: 10px;"><fmt:formatNumber value="${price}" pattern="#,###" />원</span>
              </li>
              <li>
                <span><b>배송비</b></span>
                 <span style="float: right; margin-left: 10px;">무료</span>
              </li>
            </ul>
          </div>
          <div class="card-action">
            <span><b>최종 결제금액 </b></span>
            <span style="float: right; margin-left: 10px; font-size: 20px;"><b><fmt:formatNumber value="${totalPrice}" pattern="#,###" />원</b></span>
          </div>

          <div class="card-action">
            <p class="payment-info">구매자 동의</p>
            <p>
              <label>
                  <input type="checkbox" id="checkBox1" class="filled-in" />
                  <span>[필수]개인정보 수집 및 이용동의</span>
              </label></p>
            <p>
            <p>
              <label>
                  <input type="checkbox" id="checkBox2" class="filled-in" />
                  <span>[필수]개인정보 3자 제공 동의</span>
              </label></p>
            <p>
              <label>
                <input type="checkbox" id="checkBox3" class="filled-in" />
                <span>[필수]전자결제대행 이용 동의</span>
            </label></p>
            
            <button type="button" id="btnPay" style="background-color: #FFEB00; width:280px; height:70px; border-radius: 20px;">
               <img src="/resources/images/kakaopay.png"> 
            </button>
          </div>
        </div>
        
      </div>
    </div>
  </div>
<form name="payForm" id="payForm" method="post">
    <input type="hidden" name="itemCode" id="itemCode" value="${productSeq}" /> 
    <input type="hidden" name="itemName" id="itemName" value="${giftpName}" /> 
    <input type="hidden" name="quantity" id="quantity" value="${quantity}" />
    <input type="hidden" name="totalAmount" id="totalAmount" value="${totalPrice}" />
    <input type="hidden" name="productSeq" id="productSeq" value="" />
    
    <input type="hidden" name="giftFileName" id="giftFileName" value="" />
    <input type="hidden" name="userName" id="userName" value="" />
    <input type="hidden" name="userPh" id="userPh" value="" />
    <input type="hidden" name="price" id="price" value="" />
    <input type="hidden" name="receiveUserName" id="receiveUserName" value= "" />
    <input type="hidden" name="roadAddress " id="roadAddress " value= "" />
    <input type="hidden" name="detailAddress" id="detailAddress" value= "" />
    <input type="hidden" name="receiveUserPh" id="receiveUserPh" value= "" />
    <input type="hidden" name="deliveryMsg" id="deliveryMsg" value= "" />
 </form>   
 
 <form name="kakaoForm" id="kakaoForm" method="post" target="kakaoPopUp2" action="/kakao/payPopUp2">
    <input type="hidden" name="orderId" id="orderId" value="" />
    <input type="hidden" name="tId" id="tId" value="" />
    <input type="hidden" name="pcUrl" id="pcUrl" value="" />
    <input type="hidden" name="orderSeq" id="orderSeq" value="" />
    
    <input type="hidden" name="giftFileName1" id="giftFileName1" value="" />
    <input type="hidden" name="userName1" id="userName1" value="" />
    <input type="hidden" name="userPh1" id="userPh1" value="" />
    <input type="hidden" name="price1" id="price1" value="" />
    <input type="hidden" name="productSeq1" id="productSeq1" value="" />
    <input type="hidden" name="giftpContent1" id="giftpContent1" value= "" />
    <input type="hidden" name="receiveUserName1" id="receiveUserName1" value= "" />
    <input type="hidden" name="roadAddress1" id="roadAddress1" value= "" />
    <input type="hidden" name="detailAddress1" id="detailAddress1" value= "" />
    <input type="hidden" name="receiveUserPh1" id="receiveUserPh1" value= "" />
    <input type="hidden" name="deliveryMsg1" id="deliveryMsg1" value= "" />
</form>
 
</div>

<footer style="background-color: black; color: lightgray; text-align: center; margin-top:0px; padding: 30px;">
 <a style="font-size:20px; letter-spacing:5px;">《 Dayiary 》 </a> <br>
    &copy; Copyright Dayiary Corp. All Rights Reserved. <br>
    Always with you 🎉 여러분의 일상을 함께합니다.
</footer> 

</body>
</html>