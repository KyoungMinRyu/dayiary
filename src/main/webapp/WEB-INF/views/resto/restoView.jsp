<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>

<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/views/include/head.jsp" %>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.5.0/css/all.css" integrity="sha384-B4dIYHKNBt8Bc12p+WXckhzcICo0wtJAoU8YZTY5qE0Id1GSseTk6S+L3BlXeVIU" crossorigin="anonymous">
   <<link rel="stylesheet" href="http://code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css">
<style>

@font-face {
    font-family: 'SUIT-Regular'; /* 고딕 */
    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_suit@1.0/SUIT-Regular.woff2') format('woff2');
    font-weight: 100;
    font-style: normal;
} 

@font-face {
    font-family: 'SUIT-Regular300'; /* 굵은 글씨*/
    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_suit@1.0/SUIT-Regular.woff2') format('woff2');
    font-weight: 300;
    font-style: normal;
} 


*
{
   font-family : 'SUIT-Regular', sans-serif;
}

body {
    margin: 0;
    padding: 0;
    background: #fffbf4 !important;
    display: grid;
    justify-items: center;
    align-items: center;
    overflow-x: hidden;
}

html {
    scroll-behavior: smooth;
}
*, *::before, *::after {
    box-sizing: border-box;
}
/** main scrollbar **/
::-webkit-scrollbar {
    width: 15px;
}
::-webkit-scrollbar-thumb {
    background: #ffc107;
    border-radius: 15px;
}
::-webkit-scrollbar-track {
    background: #000;
}

#main {
    width: 1400px;
    position: relative;
}


/** section images-slider **/
#images-slider {
    width: 100%;
    margin-top: 47px;
}
.slides {
    width: 1400px;
    display: block;
    position: relative;
}
.slides input {
    display: none;
}
.slide {
    display: none;
    opacity: 0;
    transform: scale(0);
    transition: all 0.7s ease-in-out;
}
.slide img {
    display: block;
    width: 100%;
    max-height: 500px;
    object-fit: cover;
}
.nav label {
    display: none;
    position: absolute;
    top: 50%;
    transform: translateY(-50%);
    cursor: pointer;
    color: rgba(0,0,0,0.5);
}
.nav label:hover {
    color: #ffc107;
}
.prev {
    left: 10px;
}
.next {
    right: 10px;
}
.slide-h1 {
    color: #fff;
    position: absolute;
    top: calc(50% - 20px);
    transform: translateY(-50%);
    margin: 0;
    padding: 0;
    text-align: center;
    width: 100%;
    font-size: 2rem;
    text-shadow: 1px 1px 5px rgba(0,0,0,0.9);
    opacity: 0;
    transform: scale(0);
    transition: all 0.7s ease-in-out;
    font-family: 'SUIT-Regular300', sans-serif;
    font-weight:bold;
    letter-spacing: 3px;
}
.slides input:checked + .slide-container .slide {
    transform: scale(1);
    opacity: 1;
    transition: opacity 1s ease-in-out;
    display: block;
}
.slides input:checked + .slide-container .nav label { 
    display: block; 
}
.slides input:checked + .slide-container .slide-h1 { 
    transform: scale(1);
    opacity: 1;
    transition: opacity 1s ease-in-out;
}
.nav-dots {
    width: 100%;
    height: 15px;
    display: block;
    position: absolute;
    text-align: center;
    bottom: 10px;
}
.nav-dots .nav-dot {
   width: 15px;
   height: 15px;
   margin: 0 4px;
   border-radius: 100%;
   display: inline-block;
   background-color: rgba(0, 0, 0, 0.6);
}

.nav-dots .nav-dot:hover {
   cursor: pointer;
   background-color: #ffc107;
}

input#img-1:checked ~ .nav-dots label#img-dot-1,
input#img-2:checked ~ .nav-dots label#img-dot-2,
input#img-3:checked ~ .nav-dots label#img-dot-3
 {
   background: #ffc107;
}

/** section reservation **/
#reservation {
    position: sticky;
    position: -webkit-sticky;
    top: 79px;
    background: #ffc107;
    width: 100%;
    padding: 10px 0px;
    z-index: 100;
}
.form-reservation {
   <%
   if(com.icia.web.util.CookieUtil.getHexValue(request, "SELLER_ID") == null || com.icia.web.util.CookieUtil.getHexValue(request, "SELLER_ID") == "")
   {
         if(com.icia.web.util.CookieUtil.getHexValue(request, "USER_ID") == null || com.icia.web.util.CookieUtil.getHexValue(request, "USER_ID") == "")
         {   
   %>
          width: 1300px;
   <%   
         }
         else
         {
   %>
         width: 1500px;
   <%
         }
   }
   else
   {
   %>
       width: 1300px;
   <%
   }
   %>
    margin: auto;
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(100px, 1fr));
    grid-gap: 10px;
    padding-left: 20px;
    padding-right: 20px;
}
.form-reservation input, select {
    outline: none;
    border: 2px solid #404040;
    padding: 3px;
    background: none;
    text-align:center;
    background-color:white;
    font-size:17px;
    font-weight:bold;
}

input#limit-person {
    background-color: #d3d3d3;
}

.form-reservation input:focus, select:focus {
    border: 2px solid #000;
}
.form-reservation input::placeholder {
    color: #404040;
}
#btnSubmit {
    outline: none;
    padding: 3px;
    background: #fff;
    cursor: pointer;
    position: relative;
    background-color:#cfffbc;
}

#btnSubmit::before {
    content: '';
    display: block;
    height: 100%;
    background: #000;
    color: #ffc107;
    position: absolute;
    bottom: 0;
    left: 0;
    right: 0;
    top: 0.5px;
    transform-origin: left;
    transform: scale(0, 1);
    transition: transform ease-in-out 500ms;
}
#btnSubmit:hover::before {
    transform: scale(1,1);
}
#btnSubmit b {
    color: #000;
    position: relative;
    transition: all ease-in-out 1s;
}
#btnSubmit:hover b {
    color: #ffc107;
}

/** section our menu **/
#our-menu {
    width: 100%;
    background: white;
    overflow: hidden;
}
.h1-menu {
    text-align: center;
    color: #ffc107;
    padding-bottom: 10px;
    margin-top:40px;
}
.our-menu-all {
    width: 1280px;
    position: relative;
    margin: auto;
    padding: 20px;
    padding-top: 30px;
}
.our-menu-all input {
    display: none;
}
.our-menu-container {
    display: none;
    text-align: center;
    padding: 20px;
    overflow: hidden;
}
.our-menu-all input:checked + .our-menu .our-menu-container {
    display: grid;
    grid-template-columns: 1fr 1fr;
    grid-gap: 5px;
    margin: 0;
    padding: 0;
}
.a-menu {
    position: absolute;
    top: -10px;
}
.a-menu-label {
    background: #fff;
    cursor: pointer;
    padding: 5px 10px;
    font-weight: 600;
}
.a-menu-label:hover {
    background: #ffc107;
}

.left-menu-container h3, h4 {
    margin: 0;
    font-size: 23px;
}



input#menu-main:checked ~ .a-menu label#a-menu-main,
input#menu-dessert:checked ~ .a-menu label#a-menu-dessert,
input#menu-drinks:checked ~ .a-menu label#a-menu-drinks {
   background: #ffc107;
}
.left-menu {
    display: flex;
    grid-gap: 20px;
    margin: 0;
    padding: 0;
    flex-direction: column;
}
.left-menu-container {
    display: flex;
    grid-template-columns: repeat(3, minmax(100px,1fr));
    background: #fff;
    padding: 10px;
    justify-items: center;
    justify-content: space-between;
    flex-direction: row;
    align-items: center;
}
.left-menu-container img {
    border-radius: 50%;
    object-fit:cover;
}
.left-menu-container h3 {
    margin: 0;
}
.left-menu-container:hover {
    background: #ffc107;
}
.right-menu {
    display: grid;
    grid-template-columns: 1fr;
    grid-gap: 20px;
    margin: 0;
    padding: 0;
}
.right-menu-container {
    display: grid;
    background: #fff;
    align-items: center;
    padding: 10px;
}
.right-menu-container img {
    border-radius: 50%;
}
.right-menu-container h3 {
    margin: 0;
}
.right-menu-container h5 {
    margin: 0;
    color: indianred;
}
.right-menu-container:hover {
    background: #ffc107;
}

/** div img-fixed **/
.img-fixed {
    background: linear-gradient(rgba(0,0,0,0.5),rgba(0,0,0,0.5)), url("/resources/images/resto.jpg");
    background-attachment: fixed;
    background-position: center;
    background-repeat: no-repeat;
    background-size: cover;
    -webkit-backgound-size: cover;
    -o-backgound-size: cover;
    -moz-backgound-size: cover;
    -ms-backgound-size: cover;
    width: 1400px;
    height: 400px;
    display: grid;
    align-items: center;
    justify-items: center;
}
.h1-specialties {
    text-align: center;
    color: #ffc107;
}

/** section specialties **/
#specialties {
    width: 100%;
    background: white;
    display: grid;
    justify-items: center;
    padding-bottom: 20px;
}
.our-specialties-all {
    width: 1280px;
    background: white;
    margin-top: -100px;
    display: grid;
    grid-gap: 20px;
    padding-left: 20px;
    padding-right: 20px;
    padding-top: 20px;
}


.our-specialties {
    display: grid;
    grid-template-columns: repeat(2, minmax(100px,1fr));
    grid-gap: 20px;
}
.our-specialties-container {
    display: grid;
    grid-template-columns: repeat(2, minmax(100px,1fr));
    justify-items: center;
    align-items: center;
    background: #fff;
}

.our-specialties-container:hover {
    color: red;
    background-color: lightgoldenrodyellow;
}

.text {
    display: grid;
    justify-items: center;
    align-items: center;
    text-align: center;
    padding: 0 10px;
}
.text h3 {
    color: #ffc107;
}
.img-our-specialties {
    display: block;
    width: 100%;
    object-fit: cover;
}

/** section GUESTS SAYS **/
#guests-says {
    background: #fff;
    display: grid;
    align-items: center;
    justify-items: center;
    width: 100%;
    padding-top: 80px;
}
#guests-says h1 {
    color: #ffc107;
    margin-bottom:30px;
}
.guests-says-slider-container {
    width: 1280px;
    padding: 20px;
    display: grid;
    position: relative;
}
.guests-says-slider-container::before {
    position: absolute;
    top: 0;
    left: 0;
    content: '';
    width: 100px;
    height: 100%;
    box-shadow: inset 105px 0 70px -60px #fff;
    z-index: 1;
}
.guests-says-slider-container::after {
    position: absolute;
    top: 0;
    right: 0;
    content: '';
    width: 100px;
    height: 100%;
    box-shadow: inset -105px 0 70px -60px #fff;
}
.guests-says-slider {
    display: flex;
    overflow-x: auto;
    -webkit-overflow-scrolling: touch;
    scroll-snap-points-x: repeat(300px);
    scroll-snap-type: mandatory;
}
.guests-says-slider-iner {
    flex-shrink: 0;
    width: 300px;
    margin-right: 20px;
    display: grid;
    align-items: center;
    justify-items: center;
    text-align: center;
}
.guests-says-slider-iner img {
    display: block;
    border-radius: 50%;
    object-fit: cover;
    border: 2px solid #ffc107;
}
.guests-says-slider-iner h2 {
    color: #ffc107;
}
.guests-says-slider::-webkit-scrollbar {
    width: 10px;
    height: 10px;
}
.guests-says-slider::-webkit-scrollbar-thumb {
    background: #ffc107;
    border-radius: 10px;
    visibility: hidden;
}
.guests-says-slider::-webkit-scrollbar-track {
    background: transparent;
}
.guests-says-slider-container:hover .guests-says-slider::-webkit-scrollbar-thumb {
    visibility: visible;
}

/** section about **/
#about {
    display: grid;
    align-items: center;
    justify-items: center;
    background: white;
    padding-bottom: 20px;
    padding-top:80px;
}
#about h1 {
    color: #ffc107;
}
.about-us {
    width: 1280px;
    padding-left: 20px;
    padding-right: 20px;
    display: grid;
    grid-template-columns: repeat(2, minmax(100px, 1fr));
}
.img-about-us {
    background: #fff;
    display: grid;
    justify-items: center;
    padding: 20px;
}
.img-about-us h1 {
    margin: 0;
}
.img-about-us img {
    display: block;
    border-radius: 50%;
    border: 2px solid #ffc107;
    object-fit: cover;
    max-width: 100%;
}
.about-us-inner {
    display: grid;
    align-items: center;
    justify-items: center;
    background: #fff;
    padding: 20px;
}
.about-us-inner h1 {
    margin: 0;
}
.about-us-info {
    display: grid;
    justify-items: center;
    background: #fff;
    margin-top: 20px;
    padding: 20px;
}
.about-us-info h1 {
    margin: 0;
}
.about-us-info img {
    display: block;
    border: 2px solid #ffc107;
    max-width: 100%;
    border-radius: 50%;
}

#about p {
   font-size:20px;
   margin-bottom:30px;
   margin-top:10px;
   letter-spacing:3px;
}

#about h4 {
   color: steelblue;
   letter-spacing:5px;
}


/** section contact **/
#contact {
    display: grid;
    justify-items: center;
    background: #fff;
    padding-bottom: 20px;
    position: relative;
}
#contact h1 {
    color: #ffc107;
}
.contact {
    width: 1280px;
    padding-left: 20px;
    padding-right: 20px;
    display: grid;
    grid-template-columns: repeat(2, minmax(100px, 1fr));
    grid-gap: 20px;
}
.contact-information {
    display: grid;
}
.contact-information h4 {
    color: #404040;
}
.contact-information h4 span {
    color: #ffc107;
}
.contact-form {
    display: grid;
    grid-gap: 20px;
}
.contact-form input {
    outline: none;
    border: 2px solid #404040;
    padding-left: 10px;
}
.contact-form input:focus {
    border: 2px solid #ffc107;
}
#message {
    outline: none;
    border: 2px solid #404040;
    padding-left: 10px;
}
#message:focus {
    border: 2px solid #ffc107;
}
#btn-contact-form {
    position: relative;
    outline: none;
    border: none;
    background: #ffc107;
    cursor: pointer;
    font-weight: 600;
}
#btn-contact-form::before {
    content: '';
    position: absolute;
    top: 0;
    left: 0;
    height: 100%;
    width: 0;
    background: #000;
    transition: all ease-in-out 500ms;
}
#btn-contact-form:hover::before {
    width: 100%;    
}
#btn-contact-form span {
    position: relative;
    transition: all ease-in-out 1s;
}
#btn-contact-form:hover span {
    color: #ffc107;
}




/** footer **/
#footer {
    display: grid;
    justify-items: center;
    background: #404040;
    text-align: center;
    padding:30px;
}
.footer {
    width: 1280px;
    display: flex;
    justify-items: center;
    align-items: center;
    grid-template-columns: repeat(3, minmax(100px,1fr));
    grid-gap: 20px;
    padding-left: 20px;
    padding-right: 20px;
    color: #fff;
    flex-direction: row;
    justify-content: space-around;
    letter-spacing: 3px;
}
.h1-footer {
    color: #ffc107;
    margin-bottom:30px;
}
.social {
    text-decoration: none;
    color: #ffc107;
    margin-right: 20px;
}
.social:hover {
    color: #000;
}
.back-to-top {
    text-decoration: none;
    font-weight: 600;
    color: #ffc107;
}
.back-to-top:hover {
    color: #000;
}
.p-copyright {
    color: #fff;
}
.link-copyright {
    text-decoration: none;
    color: #fff;
    font-weight: 600;
}
.link-copyright:hover {
    color: #ffc107;
}

#reserve {
   text-align: center;
    display: flex;
    justify-content: flex-start;
    align-items: center;
    font-size:18px;
    font-weight: bold;
    width:200px;
}


/*카카오맵 */

div#mapContainer {
    display: flex;
    flex-direction: column;
    gap: 10px;
}



.floating-button {
    position: fixed;
    bottom: 20px; 
    right: 25px; 
    width: 50px;
    height: 50px; 
    border-radius: 50%;
    background-color: #ffc107; 
    border: 1px solid #ddd;
    text-align: center;
    line-height: 45px;
    cursor: pointer;
    font-size: 20px;
    color: #fff;
}




</style>


<script>


var limitPerson; //ajax 타고 다니면서 값 유동성 있게 바꾸기 위해 전역변수로 선언

$(document).ready(function() {


      $("#orderDate").datepicker({
           dateFormat:"yy-mm-dd",
           maxDate : "+3m",
           minDate : "+1d",
           
           //휴무일 설정
           beforeShowDay: function(date) {
              var restoOffDay = document.bbsForm.restoOff.value; // 휴무일을 가져옴 (예: '월,화')
               var dayOfWeek = date.getDay(); // 현재 날짜의 요일 (0: 일요일, 1: 월요일, ...)

               // 휴무일에 해당하는 요일이면 선택 불가능하게 처리
               if (restoOffDay.includes('일') && dayOfWeek === 0) {
                   return [false];
               }
               if (restoOffDay.includes('월') && dayOfWeek === 1) {
                   return [false];
               }
               if (restoOffDay.includes('화') && dayOfWeek === 2) {
                   return [false];
               }
               if (restoOffDay.includes('수') && dayOfWeek === 3) {
                   return [false];
               }
               if (restoOffDay.includes('목') && dayOfWeek === 4) {
                   return [false];
               }
               if (restoOffDay.includes('금') && dayOfWeek === 5) {
                   return [false];
               }
               if (restoOffDay.includes('토') && dayOfWeek === 6) {
                   return [false];
               }
               
               // 기본적으로는 모든 날짜 선택 가능
               return [true];
           }
          
       });
      
      <%
      if(com.icia.web.util.CookieUtil.getHexValue(request, "USER_ID") != null && com.icia.web.util.CookieUtil.getHexValue(request, "USER_ID") != "")
      {
      %>
      $("#btnSubmit").on("click", function() 
      {
            if($.trim($("#orderDate").val()).length <= 0)
         {
            alert("예약 날짜를 선택하세요.");
            $("#orderDate").focus();
            return;
         }
            if($.trim($("#orderTime").val()).length <= 0)
         {
            alert("예약 시간을 선택하세요.");
            return;
         }
            var orderPersonValue = $.trim($("#orderPerson").val());
            if (orderPersonValue.length === 0 || isNaN(orderPersonValue) || parseInt(orderPersonValue) <= 0) 
            {
                alert("예약 인원을 올바르게 입력하세요.");
                $("#orderPerson").focus();
                return;
            }
            if($("#orderPerson").val() > limitPerson)
            {
               alert("예약 인원이 잔여좌석 수보다 많습니다.");
               $("#orderPerson").val(0);
               $("#orderPerson").focus();
               return;
            }
            if(confirm("입력하신 정보로 예약하시겠습니까?") == false)
            {
               return;   
            }
            else
            {
               //일단 예약건 'W'(결제대기중) 상태로 인서트함.
               var formData = 
                     {
                     orderDate:$("#orderDate").val(),
                     orderTime:$("#orderTime").val(),
                     orderPerson:$("#orderPerson").val(),
                     restoName:$("#restoName").val(),
                     rSeq:document.bbsForm.rSeq.value 
                  };
               
            $.ajax
            ({
               type:"POST",
               url:"/resto/restoReservationProc",
               data:formData,
               beforeSend:function(xhr)
               {
                  xhr.setRequestHeader("AJAX", "true");
               },
               success:function(response)
               {
                  if(response.code == 0)
                  {
                     document.getElementById("orderSeq").value = response.msg; //결제대기건 주문번호 reservationForm에 저장
                     
                     if(confirm("예약금 결제를 진행하시겠습니까?") == true)
                     {
                           //카카오페이 결제 시작
                           var win = window.open('/kakao/pay', 'pay', 
                           'toolbar=no,location=no,status=no,menubar=no,scrollbars=yes,resizable=no,width=540,height=700,left=650,top=150');
                        document.reservationForm.action = '/kakao/pay'; // 폼의 action 설정
                        document.reservationForm.target = 'pay'; // 폼의 target 설정
                        document.reservationForm.submit(); 
                        //결제 성공했을 경우 fn_payComplete()함수로 이동해서 예약건 DB등록 실행함
                     }
                     else
                     {
                        alert("예약 대기 상태입니다. 1시간 이내 결제하셔야 예약이 확정됩니다.");                           
                     }
                     
                     
                  }
                  else if(response.code == 400)
                  {
                     alert("파라미터 값이 올바르지 않습니다.");
                  }
                  else if(response.code == 404)
                  {
                     alert("해당 레스토랑을 찾을 수 없습니다.");
                  }
                  else
                  {
                     alert("예약 진행 중 오류가 발생하였습니다.");
                  }
               
               },
               error:function(error)
               {
                  icia.common.error(error);
                  alert("예약 진행 중 오류가 발생하였습니다.");
               }
            });
            }
      });
      <%   
      }
      else
      {
      %>   
         $("#btnSubmit").on("click", function() 
         {
            window.location.href = "/resto/noneUserRestoReservationProc";
         });
      <%
      }
      %>
      
      
      
      
      
      function formatPrice(price) {
          return price.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
      }

      // 금액 요소를 찾아서 형식을 변경
      var priceElements = document.querySelectorAll('.price-element');
      priceElements.forEach(function(element) {
          var price = element.textContent;
          element.textContent = formatPrice(price);
      });
      
      
      
});


function fn_view(rSeq) //베스트매장 클릭 시 거기로 이동
{
   location.href = '/resto/restoView?rSeq=' + rSeq;
}


function checkDate() { //예약시간 선택 전, 날짜가 먼저 선택되었는지 체크
    var orderDate = document.getElementById("orderDate").value;
    
    if (orderDate == "") 
    {
       alert("예약 날짜를 먼저 선택해주세요.");
       document.getElementById("orderTime").selectedIndex = 0;
       document.getElementById("orderDate").focus();
       return;
    }
    else
    {
       orderTimeAjax(); //문제가 없다면 시간별로 잔여좌석 체크해주는 ajax 함수 호출
    }
}

function checkTime() { //예약인원 입력 전, 날짜와 시간이 먼저 선택되었는지 체크
    var orderTime = document.getElementById("orderTime").value;
    
    if (orderTime === "Time") {
       alert("예약 시간을 먼저 선택해주세요.");
       document.getElementById("orderPerson").value = "";
       return;
    }
    else { //문제가 없다면 총 금액 계산해주는 함수 호출
       totalPrice();
    }
}

function checkLast() {
   var orderDate = document.getElementById("orderDate").value;
   var orderTime = document.getElementById("orderTime").value;
   
   if(orderTime !== "Time" && orderDate != "")
   {
      orderTimeAjax();
   }

}


function totalPrice() {
     var orderPersonInput = document.getElementById('orderPerson');
     var resultTextBox = document.getElementById('resultTextBox');
     var depositInput = document.getElementById('deposit');
     
     var restoDeposit = parseFloat(depositInput.value); // 예약금을 숫자로 변환
     var orderPerson = parseFloat(orderPersonInput.value); // 예약 인원을 숫자로 변환
     
     if (!isNaN(orderPerson)) 
     {
        if(orderPerson > 0)
        {
             var totalDeposit = restoDeposit * orderPerson;
             resultTextBox.value = orderPerson + '인 : ' + totalDeposit.toLocaleString() +'원';
        }
        else
        {
            alert("한명 이상의 예약자를 입력해주세요.");
            resultTextBox.value = '';
            document.getElementById('orderPerson').value = '';
            document.getElementById('orderPerson').focus;
        }
     }
     else 
     {
       resultTextBox.value = '';
     }
     
}


function orderTimeAjax() { //날짜,시간별 잔여좌석수 가져오기 위한 ajax 호출
   var rSeq = document.bbsForm.rSeq.value;
    var orderDate = $("#orderDate").val();
    var orderTime = $("#orderTime").val();
    
    limitPerson = document.bbsForm.limitPerson.value;
    

    $.ajax({
        type: "POST",  
        url: "/resto/limitPersonCheck", 
        data: 
        {
             rSeq,
             orderDate,
             orderTime
        }, 
        beforeSend:function(xhr)
         {
            xhr.setRequestHeader("AJAX", "true");
         },
        success: function(response) 
        {
           if(response.code == 0)
         {
                document.getElementById('limit-person').value = "잔여좌석 : " + (limitPerson - response.data) + "석";
                limitPerson = (limitPerson - response.data);
         }
         else if(response.code == 400)
         {
            console.log("ajax 오류 400");
         }
         else if(response.code == 500)
         {
            console.log("ajax 500 : 아마 다른 예약인원이 없나봐 ");
            document.getElementById('limit-person').value = "잔여좌석 : " + (limitPerson - response.data) + "석";
            limitPerson = (limitPerson - response.data);
         }

        },
        error: function(error) 
        {
           icia.common.error(error);
           console.log("ajax 에러");
        }
    }); 
}


function payComplete(orderSeq) //결제 성공했으니 결제대기중(W)->결제완료(Y) 상태로 업데이트
{
    $.ajax({
        type:"POST",
        url:"/resto/restoReservationUpdate",
        data:
        {
          orderSeq: orderSeq
        },
        success:function(response)
        {
           if(response.code == 0)
           {
              alert("예약이 확정 되었습니다.");
              document.reservationForm.target = ""; 
              document.reservationForm.orderSeq = orderSeq; 
              document.reservationForm.action = "/resto/restoReserv";
              document.reservationForm.submit(); 
           }
           else if(response.code == 400)
           {
              alert("파라미터 값이 올바르지 않습니다.");
           }
           else if(response.code == 404)
           {
              alert("주문정보를 찾을 수 없습니다.");
              location.reload();
           }
           else
           {
              alert("알 수 없는 오류가 발생하였습니다.");
           }
        },
        error:function(xhr, status, error)
        {
           icia.common.error(error);
        }
        
      });
      
}

function btnList()
{
   location.href = "/resto/restoList";   
}

function fn_reversal(checkFavorite, rSeq)
{
   if(checkFavorite === 0 || checkFavorite === 1)
   {
      let formData = 
       {
         checkFavorite: checkFavorite,
         rSeq: rSeq
       };
      
      $.ajax
       ({
           type: "POST",
           url: "/resto/reversalFavorite",
           data: formData,
           success: function(response)
           {
              if(response.code == 0)
              {
                 let checkFavoriteBox = $("#checkFavoriteBox");
                 checkFavoriteBox.html("");
                 if(checkFavorite == 0) // insert
                 { 
                    checkFavoriteBox.html("<b onclick='fn_reversal(" + Number(response.data.cnt) + ", \"" + response.data.rSeq + "\")' style='font-size: 32px; color: red;'>♥</b>");
                 }
                 else if(checkFavorite == 1) // delete
                 {
                    checkFavoriteBox.html("<b onclick='fn_reversal(" + Number(response.data.cnt) + ", \"" + response.data.rSeq + "\")' style='font-size: 32px;'>♡</b>");
                 }
                 else
                 {
                    return;
                 }
              }
              else if(response.code == 500)
              {
                 alert("서버에서 오류가 발생하였습니다.");
              }
              else
              {
                 return;
              }
           },
           error: function(xhr, status, error) 
           {
               console.log(error);
           }
       });  
   }
   else
   {
      return;
   }
}

function fn_moveList()
{
    document.bbsForm.action = "/resto/restoList";
    document.bbsForm.submit();
}
</script>


</head>
<body>

<%@ include file="/WEB-INF/views/include/navigation.jsp" %>

 <section id="main">
  
    <!-- section images-slider -->
    <section id="images-slider">
   
        <div class="slides">

            
<c:if test="${not empty restoInfo.restoFileList}">
    <c:forEach var="fileList" items="${restoInfo.restoFileList}" varStatus="status">
        <c:set var="i" value="${status.index}" />
      <c:set var="restoFileListSize" value="${restoInfo.restoFileList.size()}" />
        
        <input type="radio" name="radio-btn" id="img-${i}" ${i == 0 ? 'checked' : ''} />
        <div class="slide-container">
            <div class="slide">
                <img src="/resources/upload/${fileList.fileName}">
            </div>
            <h1 class="slide-h1">MAKE A RESERVATION FOR 《 ${restoInfo.restoName} 》</h1>
            <div class="nav">
                <label for="img-${(i - 1 + restoFileListSize) % restoFileListSize}" class="prev"><i class="fas fa-chevron-circle-left fa-3x"></i></label>
                <label for="img-${(i + 1) % restoFileListSize}" class="next"><i class="fas fa-chevron-circle-right fa-3x"></i></label>
            </div>
        </div>
    </c:forEach>
</c:if>

            

<c:if test="${empty restoInfo.restoFileList}">         
            <input type="radio" name="radio-btn" id="img-1" checked />
            <div class="slide-container">
                <div class="slide">
                    <img src="https://source.unsplash.com/KejgVx9bVTc/1920x600">
                </div>
                <h1 class="slide-h1">MAKE A RESERVATION FOR 《 ${restoInfo.restoName} 》</h1>
                <div class="nav">
                   <label for="img-3" class="prev"><i class="fas fa-chevron-circle-left fa-3x"></i></label>
                <label for="img-2" class="next"><i class="fas fa-chevron-circle-right fa-3x"></i></label>
                </div>
            </div>
            
            <input type="radio" name="radio-btn" id="img-2" checked />
            <div class="slide-container">
                <div class="slide">
                    <img src="https://source.unsplash.com/KejgVx9bVTc/1920x600">
                </div>
                <h1 class="slide-h1">MAKE A RESERVATION FOR 《 ${restoInfo.restoName} 》</h1>
                <div class="nav">
                   <label for="img-1" class="prev"><i class="fas fa-chevron-circle-left fa-3x"></i></label>
                <label for="img-3" class="next"><i class="fas fa-chevron-circle-right fa-3x"></i></label>
                </div>
            </div>
            
            <input type="radio" name="radio-btn" id="img-3" checked />
            <div class="slide-container">
                <div class="slide">
                    <img src="https://source.unsplash.com/zaiEh-8mznM/1920x600">
                </div>
                <h1 class="slide-h1">MAKE A RESERVATION FOR 《 ${restoInfo.restoName} 》</h1>
                <div class="nav">
                   <label for="img-2" class="prev"><i class="fas fa-chevron-circle-left fa-3x"></i></label>
                <label for="img-1" class="next"><i class="fas fa-chevron-circle-right fa-3x"></i></label>
                </div>
            </div>
</c:if>
 
 
 
        </div>
   
    </section>

        
    <!-- section reservation -->
    <section id="reservation">
        <form class="form-reservation" name="reservationForm" id="reservationForm" method="post">
       <div id="reserve" style="text-align:center">${restoInfo.restoName}</div>
          <c:if test="${!empty restoInfo.restoOff}">
            <input type="text" id="orderDate" name="orderDate" style="font-weight:bold;" placeholder=" 예약 날짜 (${restoInfo.restoOff} 휴무)" onchange="checkLast()">
            </c:if>
            <c:if test="${empty restoInfo.restoOff}">
            <input type="text" id="orderDate" name="orderDate" style="font-weight:bold;" placeholder=" 예약 날짜" onchange="checkLast()">
            </c:if>
            <select id="orderTime" name="orderTime" style="font-weight:bold;" onchange="checkDate()">
                <option value="Time" disabled selected>예약 시간(잔여좌석)</option>
            	<c:if test="${!empty restoInfo.restoOpen}">
	                <c:set var="openHour" value="${(restoInfo.restoOpen).substring(0, 2)}" />
	                <c:set var="closeHour" value="${(restoInfo.restoClose).substring(0, 2) - 1}" />
	                    <c:choose>
	                    	<c:when test="${Integer.parseInt(closeHour) < 10}">
	                    		<c:forEach var="hour" begin="${Integer.parseInt(openHour)}" end="23">
			                    	<c:if test="${hour < 12}">
			                        	<option value="${hour}${(restoInfo.restoOpen).substring(2)}"> 오전 ${hour}${(restoInfo.restoOpen).substring(2)} </option>
			                      	</c:if>
			                      	<c:if test="${hour >= 12}">
			                        	<option value="${hour}${(restoInfo.restoOpen).substring(2)}"> 오후 ${hour}${(restoInfo.restoOpen).substring(2)}</option>
			                    	</c:if>
			                    </c:forEach>
			                    
			                    <c:forEach var="hour" begin="0" end="${Integer.parseInt(closeHour)}">
			                    	<option value="0${hour}${(restoInfo.restoOpen).substring(2)}"> 오전 0${hour}${(restoInfo.restoOpen).substring(2)} </option>
			                    </c:forEach>
			                </c:when>
	                    	<c:otherwise>
	                    		<c:forEach var="hour" begin="${Integer.parseInt(openHour)}" end="${Integer.parseInt(closeHour)}">
			                    	<c:if test="${hour < 12}">
			                        	<option value="${hour}${(restoInfo.restoOpen).substring(2)}"> 오전 ${hour}${(restoInfo.restoOpen).substring(2)} </option>
			                      	</c:if>
			                      	<c:if test="${hour >= 12}">
			                        	<option value="${hour}${(restoInfo.restoOpen).substring(2)}"> 오후 ${hour}${(restoInfo.restoOpen).substring(2)}</option>
			                    	</c:if>
			                    </c:forEach>
	                    	</c:otherwise>
	                    </c:choose>
	            </c:if>                
            </select>

         <input type="text" id="limit-person" style="font-weight:bold;" value="잔여좌석 : ${restoInfo.limitPerson}석" readonly>
         <input type="number" id="orderPerson" name="orderPerson" style="font-weight:bold;" placeholder="예약 인원 입력" oninput="checkTime()" >
            
            <input type="text" id="resultTextBox" placeholder="예약금 : 1인 <fmt:formatNumber value="${restoInfo.restoDeposit}" pattern="#,###"/>원" style="background-color:lightGray;" readonly>
            
         <!-- 카카오페이에 보낼 값들 -->
         <input type="hidden" name="restoName" value="${restoInfo.restoName}" /> 
         <input type="hidden" id="deposit" name="deposit" value="${restoInfo.restoDeposit}">
         <input type="hidden" id="orderSeq" name="orderSeq" value="">
            
            
           <%
          if(com.icia.web.util.CookieUtil.getHexValue(request, "SELLER_ID") == null || com.icia.web.util.CookieUtil.getHexValue(request, "SELLER_ID") == "")
          {
          %>   
               <button type="button" id="btnSubmit"><b>예약하기</b></button>
               <%
             if(com.icia.web.util.CookieUtil.getHexValue(request, "USER_ID") != null && com.icia.web.util.CookieUtil.getHexValue(request, "USER_ID") != "")
             {
             %>
                   <div  id="checkFavoriteBox" style="width: 32px;">
                     <c:choose>
                         <c:when test="${checkFavorite eq 0}">
                            <b onclick="fn_reversal(${checkFavorite}, '${restoInfo.rSeq}')" style="font-size: 32px;">♡</b>
                         </c:when>
                         <c:otherwise>
                            <b onclick="fn_reversal(${checkFavorite}, '${restoInfo.rSeq}')" style="font-size: 32px; color: red;">♥</b>
                         </c:otherwise>
                      </c:choose>
                  </div>
            <%
             }
          }
            %>
            <input type="hidden" name="orderSeq" value="">
        </form>
    </section> 
    


    
<!-- section our menu -->
<section id="our-menu">
   <h1 class="h1-menu"> ─ M E N U ─</h1>
   <div class="our-menu-all">
        
<input type="radio" name="radio-menu" id="menu-drinks" checked />
      <div class="our-menu">
           <div class="our-menu-container">
                       
<c:if test="${!empty restoInfo.menuList}">      <!--list 객체가 비어있지 않을때 실행-->   
   <c:forEach var="menuList" items="${restoInfo.menuList}" varStatus="status">       
            <div class="left-menu">     
           <div class="left-menu-container">
              <img src="/resources/upload/${menuList.fileName}" style="width:95px; height:95px; margin-left:50px;">
             <h3>${menuList.menuName}</h3> 
              <h3 class="price"><a class="price-element">${menuList.menuPrice}</a>원</h3>
           </div>
           </div>
           <div class="right-menu-container">
              <h5 style="margin-bottom:0px !important;">${menuList.menuContent}</h5> 
           </div>
    </c:forEach>
</c:if>
           </div>
      </div>

<c:if test="${empty restoInfo.menuList}">      <!--list 객체가 비어있지 않을때 실행-->   
           <div class="left-menu-container">
              <img src="https://picsum.photos/70/70/?image=312">
              <h3>아직 등록된 메뉴가 없습니다</h3> 
              <h1 class="price">${menuList.menuPrice}</h1>
           </div>
</c:if>
                 </div>
              
</section>          
 

    
    <!-- section GUESTS SAYS -->
    <section id="guests-says">
        <h1>ㅡ REVIEW ㅡ</h1>
        <div class="guests-says-slider-container">
            <div class="guests-says-slider">
                
<c:if test="${!empty reviewList}">      <!--list 객체가 비어있지 않을때 실행-->   
   <c:forEach var="reviewList" items="${reviewList}" varStatus="status">                   
                <div class="guests-says-slider-iner">
                    <img src="${reviewList.fileName}" style="width:104px; height:104px; margin-bottom:15px;">
                    <p style="font-size:18px;">${reviewList.reviewContent}</p>
         
        <div class="review" style="display:flex;">              
            <c:set var="starCount" value="${reviewList.reviewScore}" />

            <c:choose>
                <c:when test="${(starCount % 2) eq 0}"> <!-- 별점이 짝수일 경우 (꽉찬별만 있을때) -->
                   <c:forEach var="i" begin="1" end="${starCount / 2}">
                    <img src="/resources/images/fullStar.png" style="width:35px; height:35px; border:none !important;" alt="Full Star">
                    </c:forEach>
                    <c:forEach var="i" begin="1" end="${5 - (starCount / 2)}">
                    <img src="/resources/images/emptyStar.png" style="width:35px; height:35px; border:none !important;" alt="Empty Star">
                    </c:forEach>
                </c:when>
                
                <c:otherwise>
                   <c:forEach var="i" begin="1" end="${starCount / 2}"> <!-- 별점이 홀수일 경우 (반개별 필요) -->
                    <img src="/resources/images/fullStar.png" style="width:35px; height:35px; border:none !important;" alt="Full Star">
                    </c:forEach>
                    <img src="/resources/images/halfStar.png" style="width:35px; height:35px; border:none !important;" alt="Half Star">
                    <c:forEach var="i" begin="1" end="${5 - (starCount / 2)}">
                    <img src="/resources/images/emptyStar.png" style="width:35px; height:35px; border:none !important;" alt="Empty Star">
                    </c:forEach>
                </c:otherwise>
            </c:choose>
         </div>         
                    
                    <h4>${reviewList.userNickName}</h4>
                    <p style="color:gray;">${reviewList.regDate.substring(0,10)} 등록</p>
                </div>
   </c:forEach>
   
</c:if>

   <c:if test="${empty reviewList}">
    <div class="guests-says-slider-iner">
                  <p>해당 레스토랑에 리뷰가 없습니다.</p>
     </div>
   </c:if>
               
                
            </div>
        </div>
    </section>
    
    
        <section id="about">
        <h1> ㅡ Information ㅡ</h1>
        
        <div id="mapContainer">
        <div id="map" style="width:900px;height:400px; margin-top:30px; margin-bottom:10px;">
       </div>
       
        <div>
        <h4>< 매장 주소 ></h4>
        <p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ${restoInfo.restoAddress}</p>
        <h4>< 연락처 ></h4>
        <p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${restoInfo.restoPh}</p>
        <h4>< 영업시간 ></h4>
        <c:if test="${!empty restoInfo.restoOff}">
        <p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${restoInfo.restoOpen} - 
        ${restoInfo.restoClose}  (${restoInfo.restoOff} 정기휴무)</p>
        </c:if>
        <c:if test="${empty restoInfo.restoOff}">
        <p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${restoInfo.restoOpen} - 
        ${restoInfo.restoClose} (연중무휴)</p>
        </c:if>
        </div>
        
        </div>
        
    
    </section>
    
    
    
        <!-- div img-fixed -->
    <div class="img-fixed">
      <h1 class="h1-specialties"> Best! 예약 인기 매장</h1>
    </div>
    
    <!-- section specialties -->
    <section id="specialties">
       <div class="our-specialties-all">
       <div class="our-specialties">
       
<c:if test="${!empty bestRestoList}">
   <c:forEach var="bestRestoList" items="${bestRestoList}" varStatus="status"> 
           <div class="our-specialties-container" onclick="fn_view('${bestRestoList.rSeq}')" style="cursor: pointer;">
            <div class="text">
              <h2> ${bestRestoList.restoName}</h2>
              <p>클릭하여 이동하기</p>
              <h3>${bestRestoList.cnt}명이 선택한 매장</h3>
            </div>
            <img class="img-our-specialties" src="/resources/upload/${bestRestoList.fileName}" style="width:330px; height:230px;">
           </div>
   </c:forEach> 
</c:if>          
          
           
        </div>
        
       </div>
    </section>
    
    
    



    
    
    
    
    
    <!-- section footer -->
    <footer id="footer">
        <div class="footer">
            <div class="fooer-b">
                <h1 class="h1-footer"> 예약 정책</h1>
                <p>- 당일 예약은 불가하며 3달 이내로만 예약하실 수 있습니다.</p>
                <p>- 예약금은 각 매장에서 자율 책정한 것으로 매장마다 상이합니다.</p>
                <p>- 예약금은 매장 이용 후 총 결제금액에서 차감됩니다.</p>
                <p>- 예약일 이전 환불 시에는 포인트로 전액 환불됩니다.</p>
                <p>- 예약 후 노쇼 시에는 예약금 환불이 불가합니다.</p>
                <p>- 문의사항은 각 매장 연락처 또는 QnA 게시판을 이용해주시기 바랍니다.</p>
                <p style="color:cadetblue; letter-spacing:8px;"> * Reservation - Dayiary *</p>
               
            </div>
        </div>
    </footer>
</section> 

<div class="floating-button" onclick="fn_moveList()">
	<img src="/resources/images/fList.png" style="width: 30px; height: 30px;" title="리스트로 이동">	
</div>

<form name="bbsForm" id="bbsForm" method="post">
   <input type="hidden" name="rSeq" value="${restoInfo.rSeq}" />
   <input type="hidden" name="searchTypeLocation" value="${searchTypeLocation}" />
   <input type="hidden" name="searchTypeShop" value="${searchTypeShop}" />
   <input type="hidden" name="searchTypeFood" value="${searchTypeFood}" />
   <input type="hidden" name="searchTypeDate" value="${searchTypeDate}" />
   <input type="hidden" name="curPage" value="${curPage}" />
   <input type="hidden" name="restoOff" value="${restoInfo.restoOff}" />
   <input type="hidden" name="restoAddress" value="${restoInfo.restoAddress}" />
   <input type="hidden" name="limitPerson" value="${restoInfo.limitPerson}" />
</form>



<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=4a04a7800af6a179ffbd86544d9316b9&libraries=services"></script>
<script>
      var container = document.getElementById('map');
      var options = {
         center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
         level: 2 // 지도의 확대 레벨
      };

      // 지도를 생성합니다   
      var map = new kakao.maps.Map(container, options);
      
      // 주소-좌표 변환 객체를 생성합니다
      var geocoder = new kakao.maps.services.Geocoder();
      
      //bbsForm에 넣어둔 매장주소 가져와서 변수에 담기
      var restoAdd = document.bbsForm.restoAddress.value;
      
      // 주소로 좌표를 검색합니다
      geocoder.addressSearch(restoAdd, function(result, status) {

          // 정상적으로 검색이 완료됐으면 
           if (status === kakao.maps.services.Status.OK) {

              var coords = new kakao.maps.LatLng(result[0].y, result[0].x);

              // 결과값으로 받은 위치를 마커로 표시합니다
              var marker = new kakao.maps.Marker({
                  map: map,
                  position: coords
              });

              // 인포윈도우로 장소에 대한 설명을 표시합니다
              var infowindow = new kakao.maps.InfoWindow({
                  content: '<div style="width:150px;text-align:center;padding:6px 0;">매장 위치</div>'
              });
              infowindow.open(map, marker);

              // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
              map.setCenter(coords);
          } 
      });    
      
      // 일반 지도와 스카이뷰로 지도 타입을 전환할 수 있는 지도타입 컨트롤을 생성합니다
      var mapTypeControl = new kakao.maps.MapTypeControl();

      // 지도에 컨트롤을 추가해야 지도위에 표시됩니다
      // kakao.maps.ControlPosition은 컨트롤이 표시될 위치를 정의하는데 TOPRIGHT는 오른쪽 위를 의미합니다
      map.addControl(mapTypeControl, kakao.maps.ControlPosition.TOPRIGHT);

      // 지도 확대 축소를 제어할 수 있는  줌 컨트롤을 생성합니다
      var zoomControl = new kakao.maps.ZoomControl();
      map.addControl(zoomControl, kakao.maps.ControlPosition.RIGHT);
      
      
      
      
      
   </script>
</body>
</html>