<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
   <style>
@font-face {
    font-family: 'SUIT-Regular'; /* 고딕 */
    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_suit@1.0/SUIT-Regular.woff2') format('woff2');
    font-weight: 100;
    font-style: normal;
} 

      body {
          margin: 0 auto; /* 가운데 정렬 */
          display:flex;
         flex-direction: column;
         align-items: center;
         font-family: 'SUIT-Regular', sans-serif;
         overflow-x: hidden;
          background-color: #fffbf4 !important;
         }
   
   </style>

   <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <meta charset="UTF-8">
    <title>Dayiary</title>


    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.12.1/jquery-ui.min.js"></script>
    <script src="https://kit.fontawesome.com/20962f3e4b.js" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/bxslider/4.2.12/jquery.bxslider.min.js"></script>
    <script>
    
    $(document).ready(function(){
        $("#homebtn").on("click", function() {         
            window.location.href = "/gift/giftList"; 
        }); 

        $("#buylistbtn").on("click", function() {         
            window.location.href = "/user/userOrderList";
        }); 

        // 금액을 쉼표로 구분된 문자열로 변환하는 함수
        function formatPrice(price) {
            return price.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
        }

        // 금액 요소를 찾아서 형식을 변경
        var priceElements = document.querySelectorAll('.price-element');
        priceElements.forEach(function(element) {
            var price = element.textContent;
            element.textContent = formatPrice(price);
        });
        
        var contactElements = document.querySelectorAll('.contact-element');
        contactElements.forEach(function(element) {
            var contact = element.textContent.replace(/-/g, ''); // 기존 하이픈 제거
            if(contact.length === 11) { // 11자리 연락처인 경우
                var formattedContact = contact.replace(/(\d{3})(\d{4})(\d{4})/, '$1-$2-$3');
                element.textContent = formattedContact;
            }
        });
        
    });
    
    
    function fn_movePage(productSeq)
    {
       
         window.location.href = "/gift/giftView?productSeq=" + productSeq;
      
    }
</script>


    
    </script>
    <link rel="stylesheet" href="https://ajax.googleapis.com/ajax/libs/jqueryui/1.12.1/themes/smoothness/jquery-ui.css">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css"/>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/bxslider/4.2.12/jquery.bxslider.css">
    <style>
        #product > .complete > article {
            margin-top: 16px;
        }
        #product > .complete > .message > h2 {
            font-size: 32px;
            font-weight: bold;
            text-align: center;
            color: #555;
            padding: 20px;
        }
        #product > .complete > .message > h2 > i {
            font-size: 26px;
        }
        #product > .complete > .message > p {
            font-size: 18px;
            font-weight: bold;
            padding: 10px;
            text-align: center;
        }
        #product > .complete > article {
            margin-top: 16px;
        }
        #product > .complete > article > h1 {
            font-weight: bold;
            font-size: 14px;
            color: #111;
            padding: 6px 0;
        }
        #product > .complete table {
            width: 100%;
            border-collapse: collapse;
            border-spacing: 0;
            border-top: 2px solid #000;
        }
        #product > .complete table tr {
            border-bottom: 1px solid #d3d3d3;
        }
        #product > .complete table tr > th {
            padding: 12px 0;
            background: #fff;
            color: #383838;
            font-size: 0.95em;
            text-align: center;
            letter-spacing: -0.1em;
        }
        /* 상품정보 */
        #product > .complete > .info > table tr > th:last-child {
            width: 200px;
        }
        #product > .complete > .info table tr > td {
            text-align: center;
        }
        #product > .complete > .info table tr > td:last-child {
            color: #ff006c;
            font-weight: bold;
            text-align: right;
        }
        #product > .complete > .info table tr > td > article {
            overflow: hidden;
            padding: 6px;
        }
        #product > .complete > .info table tr > td img {
            float: left;
            width: 80px;
        }
        #product > .complete > .info table tr > td div {
            margin-left: 10px;
            text-align: left;
            overflow: hidden;
        }
        #product > .complete > .info table tr > td div > p {
            text-align: left;
            color: #777;
            margin-top: 4px;
        }
        #product > .complete > .info .total > td > table {
            border: none;
        }
        #product > .complete > .info .total > td > table tr {
            border: none;
        }
        #product > .complete > .info .total > td > table td {
            text-align: right;
            color: #111;
            background: #f2f2f2;
            font-weight: normal;
            border-bottom: none;
            padding: 10px;
            box-sizing: border-box;
        }
        #product > .complete > .info .total > td > table tr:last-child span {
            font-weight: bold;
            color: #ff006c;
        }
        /* 결제정보 */
        #product > .complete > .payment table tr > td:nth-child(1) {
            width: 160px;
            background: #f2f2f2;
        }
        #product > .complete > .payment table tr > td {
            padding: 10px;
            box-sizing: border-box;
        }
        #product > .complete > .payment table tr > td:nth-child(3) {
            width: 200px;
            background: #f2f2f2;
        }


        /* 주문정보 */
        #product > .complete > .order table tr > td {
            padding: 10px;
            box-sizing: border-box;
        }
        #product > .complete > .order > table tr > td:nth-child(1) {
            width: 160px;
            background: #f2f2f2;
        }
        #product > .complete > .order table tr > td:nth-child(2) {
            width: auto;
        }
        #product > .complete > .order table tr > td:nth-child(3) {
            width: 100px;
            text-align: right;
            vertical-align: middle;
            background: #f2f2f2;
        }
        #product > .complete > .order table tr > td:nth-child(4) {
            width: 100px;
            text-align: right;
            vertical-align: middle;
            background: #f2f2f2;
        }
        #product > .complete > .order table span {
            font-weight: bold;
            color: #ff006c;
        }
        
        /* 배송정보 */
        #product > .complete > .delivery table tr > td:nth-child(1) {
            width: 160px;
            background: #f2f2f2;
        }
        #product > .complete > .delivery table tr > td {
            padding: 10px;
            box-sizing: border-box;
        }
        #product > .complete > .delivery table tr > td:nth-child(3) {
            width: 200px;
            background: #f2f2f2;
        }
        /* 꼭 알아두세요 */
        #product > .complete > .alert {
            width: 100%;
            background-color: #f7f7f7;
            padding: 10px;
            padding-left: 24px;
            color: #999;
            box-sizing: border-box;
        }
        #product > .complete > .alert > h1 {
            margin-left: -12px;
        }
        #product > .complete > .alert > ul {
            list-style: inherit;
        }
        #product > .complete > .alert > ul > li {
            line-height: 20px;
        }
        #product > .complete > .alert > ul > li > span {
            position: relative;
            left: -6px;
        }
    </style>
</head>
<body>
<%@ include file="/WEB-INF/views/include/navigation.jsp" %>
<div class="container" style="background-color:white; " >
    <div id="wrapper">
      
        <main id="product" style="width:1200px;">
            
            <section class="complete" style="padding-left:30px; padding-right:30px;">
                <nav>
                    <p style="margin-top: 30px;">
                    <br/>
                       <a href="/index">DAYIARY</a> > <a href="/index/event">EVENT</a> > <a href="/gift/giftList">PRESENT</a> > 주문완료
                     
                    </p>
                </nav>
                <article class="message">
                    <h2>
                        매일을 다이어리처럼 기록하는 고객님! <br> 주문이 완료되었습니다. 행복한 쇼핑 되셨나요?
                    </h2>
                    <p>
                        고객님과 함께한 이 순간을 소중히 여깁니다. 언제든지 Dayiary와 함께하세요 🎁
                    </p>

                </article>

                <!-- 상품정보 -->
                <article class="info">
                    <h1>상품정보</h1>
                    <table border="0">
                        <tr>
                            <th style="width: 500px;">상품명</th>
                            <th>상품금액</th>
                            <th>할인금액</th>
                            <th>수량</th>
                            <th>주문금액</th>
                        </tr>
                        <tr>
                            <td>
                                <article>
                                   <img src="/resources/upload/${giftFileName}" onclick="fn_movePage('${productSeq}')" style="width:110px; cursor: pointer;" alt="">
                                    <div>
                                        <b>
                                       <a style="font-size: 30px; cursor: pointer;" onclick="fn_movePage('${productSeq}')">${giftpName}</a><br/>
                                 <a style="font-size: 15px;">${giftpContent}</a>
                                        </b>
                                    </div>
                                </article>
                            </td>
                            <td class="price-element">${price}원</td>
                            <td>0원</td>
                            <td>${quantity}</td>
                            <td class="price-element" style="text-align: center;">${totalPrice}원</td>
                        </tr>
                    </table>
                </article>

                <!-- 결제정보 -->
                <article class="payment">
                    <h1>결제정보</h1>
                    <table border="0">
                        <tr>
                            <td>총 상품금액</td>
                                        <td>
                                            <span class="price-element" style="font-size: large;">${totalPrice}원</span>
                                        </td>
                        </tr>
                        <tr>
                            <td>총 할인금액</td>
                                        <td >
                                            <span style="font-size: large;">0원</span>
                                        </td>
                        </tr>
                        <tr>
                           
                            <td>배송비</td>
                            <td>
                                <span style="font-size: large;">무료배송</span>
                            </td>
                        </tr>
                        <tr>
                            
                            <td style="font-size: large;">총 결제금액</td>
                                        <td>
                                            <span class="price-element" style="font-size: larger; color: red;">${totalPrice}원</span>
                                        </td>
                        </tr>
                    </table>
                </article>

                <!-- 주문정보 -->
                <article class="order">
                    <h1>주문정보</h1>
                    <table border="0">
                        <tr>
                            <td>주문번호</td>
                            <td>${orderSeq}</td>
                            
                        </tr>
                        <tr>
                            <td>결제방법</td>
                            <td>${payMethod}</td>
                        </tr>
                        <tr>
                            <td>주문자</td>
                            <td>${userName}</td>
                        </tr>
                        <tr>
                            <td>연락처</td>
                            <td class="contact-element">${userPh}</td>
                        </tr>
                    </table>
                </article>
                <!-- 배송정보 -->
                <article class="delivery">
                    <h1>배송정보</h1>
                    <table border="0">
                        <tr>
                            <td>수령인</td>
                            <td>${receiveUserName}</td>
                           
                        </tr>
                        <tr>
                            <td>연락처</td>
                            <td class="contact-element">${receiveUserPh}</td>
                         
                        </tr>
                        <tr>
                            <td>배송지 주소</td>
                            <td>${receiveAddress}</td>
                           
                        </tr>
                        <tr>
                            <td>배송 요청사항</td>
                            <td>${deliveryMsg}</td>
                          
                        </tr>
                    </table>
                </article>
                <!-- 꼭 알아두세요 -->
             
            </section>
        </main>
        <footer style="width:1200px;">
          <div style="text-align: center; padding: 20px;">
              <button id="homebtn" style="background-color: #4CAF50; /* Green */
                            border: none;
                            color: white;
                            padding: 15px 32px;
                            text-align: center;
                            text-decoration: none;
                            display: inline-block;
                            font-size: 16px;
                            margin: 4px 2px;
                            cursor: pointer;">홈</button>
              <button id="buylistbtn"  style="background-color: #008CBA; /* Blue */
                            border: none;
                            color: white;
                            padding: 15px 32px;
                            text-align: center;
                            text-decoration: none;
                            display: inline-block;
                            font-size: 16px;
                            margin: 4px 2px;
                            cursor: pointer;">구매 내역</button>
          </div>
      </footer>
    </div>
</div>
<footer style="background-color: black; color: lightgray; text-align: center; margin-top:0px; padding: 30px; width:100%;">
 <a style="font-size:20px; letter-spacing:5px;">《 Dayiary 》 </a> <br>
    &copy; Copyright Dayiary Corp. All Rights Reserved. <br>
    Always with you 🎉 여러분의 일상을 함께합니다.
</footer>     
</body>
</html>