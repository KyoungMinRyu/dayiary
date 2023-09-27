<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/views/include/head.jsp" %>
<style>

@font-face {
    font-family: 'Hahmlet-Regular';
    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2110@1.0/Hahmlet-Regular.woff2') format('woff2');
    font-weight: normal;
    font-style: normal;
}

@font-face {
    font-family: 'SUIT-Regular'; /* 고딕 */
    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_suit@1.0/SUIT-Regular.woff2') format('woff2');
    font-weight: 100;
    font-style: normal;
} 
 
.carousel-item {
  height: 100vh;
  min-height: 300px;
  background: no-repeat center center scroll;
  -webkit-background-size: cover;
  -moz-background-size: cover;
  -o-background-size: cover;
  background-size: cover;
}

.carousel-caption {
  bottom: 580px;
}

.carousel-caption h5 {
  font-size: 55px;
  text-transform: uppercase;
  margin-top: 25px;
  font-family: 'Hahmlet-Regular', sans-serif;
  letter-spacing: 5px;
  margin-bottom:25px;
  text-shadow: 1px 1px 1px rgba(1, 1, 1, 0.5); 
}

.carousel-caption p {
  width: 75%;
  margin: auto;
  font-size: 20px;
  line-height: 1.9;
  font-family: 'SUIT-Regular', sans-serif;
  text-shadow: 1px 1px 1px rgba(1, 1, 1, 0.5); 
  letter-spacing:1.5px;
}

.navbar-light .navbar-brand {
  color: #fff;
  font-size: 25px;
  text-transform: uppercase;
  font-weight: bold;
  letter-spacing: 2px;
}

.carousel-inner {
  transition: transform 1s !important; 
}


.carousel-control-next-icon, .carousel-control-prev-icon
{
   width: 50px;
   height: 70px;
}


</style>
 <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
  </head>
<body>
<%@ include file="/WEB-INF/views/include/navigation.jsp" %>
<div id="carouselExampleIndicators" class="carousel slide" data-ride="carousel">
  <ol class="carousel-indicators">
    <li data-target="#carouselExampleIndicators" data-slide-to="0" class="active"></li>
    <li data-target="#carouselExampleIndicators" data-slide-to="1"></li>
  </ol>
  <div class="carousel-inner">
    <div class="carousel-item active">
      <a href="/resto/restoList">
      <img class="d-block w-100" src="/resources/images/resto.jpg" alt="First slide">
      <div class="carousel-caption d-none d-md-block">
        <h5>《 RESTORAUNT 》</h5>
        <p>데이어리의 레스토랑 예약 서비스로 당신의 기념일을 장식하세요.</p>
        <p>맛있는 요리와 아름다운 분위기가 함께 어우러진 곳에서 특별한 추억을 선사합니다.</p>
      </div>
      </a>
    </div>
    <div class="carousel-item">
      <a href="/gift/giftList">
      <img class="d-block w-100" src="/resources/images/gift.png" alt="Second slide">
      <div class="carousel-caption d-none d-md-block" >
        <h5>《 PRESENT 》</h5>
        <p>데이어리의 선물 구매 서비스로 당신의 마음을 표현하세요.</p>
        <p>상대방에게 감동과 기쁨을 안겨줄 수 있는 다양한 선물들이 마련되어 있습니다.</p>
      </div>
    </div>
      </a>
  </div>
  
  <a class="carousel-control-prev" href="#carouselExampleIndicators" role="button" data-slide="prev">
    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
    <span class="sr-only">Previous</span>
  </a>
  <a class="carousel-control-next" href="#carouselExampleIndicators" role="button" data-slide="next">
    <span class="carousel-control-next-icon" aria-hidden="true"></span>
    <span class="sr-only">Next</span>
  </a>
</div>


</body>

</html>