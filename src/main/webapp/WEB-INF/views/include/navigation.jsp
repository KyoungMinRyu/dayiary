<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<%!
Cookie cookieUser = null;
Cookie cookieSeller = null;
com.icia.web.model.Friend user = null;
String seller = null;

String cookieId = "";
%>
<%
cookieUser = com.icia.web.util.CookieUtil.getCookie(request, (String)request.getAttribute("AUTH_COOKIE_NAME"));
cookieSeller = com.icia.web.util.CookieUtil.getCookie(request, "SELLER_ID");
if(cookieUser != null)
{
   cookieId = com.icia.web.util.CookieUtil.getHexValue(request, cookieUser.getName());
   user = (com.icia.web.model.Friend)session.getAttribute(cookieId);
}
else if(cookieSeller != null)
{
   cookieId = com.icia.web.util.CookieUtil.getHexValue(request, cookieSeller.getName());
   seller = (String)session.getAttribute(cookieId);
}
%>
<style>
@font-face {
  font-family: 'dayiary'; /* 야채장수 */
  src: url('../resources/css/dayiary.ttf') format('truetype'); /* 폰트 파일의 경로 및 형식 */
}
@font-face {
  font-family: 'dayiary2'; /* 와일드 */
  src: url('../resources/css/dayiary2.ttf') format('truetype'); /* 폰트 파일의 경로 및 형식 */
 }
 
@font-face {
    font-family: 'SUIT-Regular'; /* 고딕 */
    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_suit@1.0/SUIT-Regular.woff2') format('woff2');
    font-weight: 100;
    font-style: normal;
} 
  
.navbar {
  display: flex;
  justify-content: center;
  align-items: center;
  height: 80px; 
  background-color:black;
  text-decoration: none;
  position: fixed; 
  top: 0; 
  left: 0; 
  width: 100%; 
  z-index:99;
}

.nav-list
{
  display: flex;
  gap:100px;
  font-family: 'SUIT-Regular', cursive; 
  font-size: 20px;
  text-decoration: none;
  letter-spacing: 2px;
  color: #fff;
  list-style: none;
  margin-bottom:0;
  margin-top:0;
  padding:0;
}

.nav-list li a {
  color: white; /* 링크 글자 색상을 흰색으로 설정 */
  text-decoration: none; /* 밑줄 제거 */
  margin-bottom:0;
  margin-top:0;
  padding:0;
}

.nav-list a:hover {
  color: #ffc107; /* 마우스 오버시 색상 변경 */
}

/* right 요소(로그인,로그아웃,프로필)을 상단의 맨 오른쪽에 배치 */
.right {
  display: flex;
  position: absolute; 
  top:20px;
  right: 50px;
  list-style: none;
  font-size:20px;
  margin-bottom:0;
  margin-top:0;
  padding:0;
}

.right li a {
  color: white;
  text-decoration: none; /* 텍스트 데코레이션 없앰 */
  font-size:20px;

}

/* Dayiary 로고. 상단 고정 */
.textcontainer {
  padding: 40px 0;
  text-align: center;
  max-height: calc(100vh - 40px); /* 패딩을 뺀 사용 가능한 높이 계산 */
  flex: 1; /* 사용 가능한 수직 공간을 확장합니다. */
  display: flex;
  justify-content: center;
  align-items: flex-start; /* 내용을 상단으로 정렬합니다. */
  position: fixed; /* 고정 위치 */
  top: -35px; /* 왼쪽 상단에 고정 */
  left: 40px;
  width: 100%;
  height: 100%;
  background-color: rgba(0, 0, 0, 0.7); /* Optional background color */
   z-index: 100;
}

.waviy-container {
  position: fixed;
  top: 10;
  left: 0;
}

.waviy {
  position: relative;
  -webkit-box-reflect: below -20px linear-gradient(transparent, rgba(0, 0, 0, 0.6));
  font-size: 50px;
  font-weight: bold;
  letter-spacing: 4px; /
  margin-left: 20px; /* 여백을 주기 위한 설정 */
  top: -50px; /* 웹 페이지 상단으로 20px 위로 올리기 */
}

.waviy span {
  font-family: 'dayiary', cursive; 
  position: relative;
  display: inline-block;
  color: #ffffff;
  animation: waviy 1s infinite;
  animation-delay: calc(0.1s * var(--i));
}

@keyframes waviy {
  0%, 40%, 100% {
    transform: translateY(0);
  }
  20% {
    transform: translateY(-20px);
  }
}

.confetti > .particle {
  opacity: 0;
  position: absolute;
  animation: confetti 3s ease-in infinite;
}

.confetti > .particle.c1 {
  background-color: rgba(255, 200, 255, 0.7); /* 보라색 */
}

.confetti > .particle.c2 {
  background-color: rgba(156, 39, 176, 0.6); /* 핑크 */
}

.confetti > .particle.c3 {
  background-color: rgba(255, 223, 186, 0.7); /* 파스텔노랑색 */
}


@keyframes confetti {
  0% {
    opacity: 0;
    transform: translateY(0%) rotate(0deg);
  }
  10% {
    opacity: 1;
  }
  35% {
    transform: translateY(-800%) rotate(270deg);
  }
  80% {
    opacity: 1;
  }
  100% {
    opacity: 0;
    transform: translateY(2000%) rotate(1440deg);
  }
}

b
{
   font-family: 'sans-serif' !important;
}


#center {
  display: flex;
  align-items: center;
}
</style>


<%      
if(cookieUser != null)
{
%>
   <!-- 로고 -->
   <div style="display: flex; align-items: center;">
     <a href="/">
        <div class="textcontainer" style="width: max-content; font-family: 'dayiary', sans-serif;">
          <!-- 꽃가루 효과를 적용한 폰트 영역 -->
          <div class="waviy-container" style="position: relative;">
            <div class="waviy waviy-container confetti" style="display: flex; gap: 4px; position: absolute; top: 0; left: 0;"> <!-- .confetti 클래스 추가 -->
              <span class="confetti" style="--i:1; font-size: 60px;">D</span> <!-- .confetti 클래스 추가 -->
              <span class="confetti" style="--i:2; font-size: 60px;">A</span> <!-- .confetti 클래스 추가 -->
              <span class="confetti" style="--i:3; font-size: 60px;">Y</span> <!-- .confetti 클래스 추가 -->
              <span class="confetti" style="--i:4">i</span> <!-- .confetti 클래스 추가 -->
              <span class="confetti" style="--i:5">a</span> <!-- .confetti 클래스 추가 -->
              <span class="confetti" style="--i:6">r</span> <!-- .confetti 클래스 추가 -->
              <span class="confetti" style="--i:7">y</span> <!-- .confetti 클래스 추가 -->
            </div>
          </div>
        </div>
     </a>
   </div>
   <%
   if(!com.icia.common.util.StringUtil.equals(cookieId, "adm"))
   {
   %>
      <!-- 메뉴 -->
      <div class="navbar">
          <ul class="nav-list">
            <li><a href="/notice/adminNotice">Notice</a></li>
            <li><a href="/index/event">Event</a></li>
            <li><a href="/board/diaryList">Diary</a></li>
            <li><a href="/calender/calender">Calendar</a></li>
            <li><a href="/friend/friendList">Friendship</a></li>
            <li><a href="/inquiry/inquiryList">QnA</a></li>
            <li><a href="/post/postIndex">Post</a></li>
           </ul>
         <ul class="right">
        <a href="/user/userMyPage">
          <li><img alt="" src="<%= user.getFileName() %>" style="width: 30px; height: 30px; vertical-align: middle;">
           <b style="color: #FFF; text-decoration: underline; margin-left: 5px; display: inline-block; vertical-align: middle; margin-top: -5px;"><%= user.getUserNickName() %></b></li>
        </a>
          <li style="margin-left: 20px;"><a href="/user/logout">
             <img alt="" src="/resources/images/logout3.png" style="width: 70px; height: 60px; margin-top:-15px;"></a></li>
   <%
   }
}
else if(cookieSeller != null)
{
%>
   <!-- 판매자 일 때 -->
   <!-- 로고 -->
   <div style="display: flex; align-items: center;">
     <a href="/index/sellerIndex">
        <div class="textcontainer" style="width: max-content; font-family: 'dayiary', sans-serif;">
          <!-- 꽃가루 효과를 적용한 폰트 영역 -->
          <div class="waviy-container" style="position: relative;">
            <div class="waviy waviy-container confetti" style="display: flex; gap: 4px; position: absolute; top: 0; left: 0;"> <!-- .confetti 클래스 추가 -->
              <span class="confetti" style="--i:1; font-size: 65px;">D</span> <!-- .confetti 클래스 추가 -->
              <span class="confetti" style="--i:2; font-size: 65px;">A</span> <!-- .confetti 클래스 추가 -->
              <span class="confetti" style="--i:3; font-size: 65px;">Y</span> <!-- .confetti 클래스 추가 -->
              <span class="confetti" style="--i:4">i</span> <!-- .confetti 클래스 추가 -->
              <span class="confetti" style="--i:5">a</span> <!-- .confetti 클래스 추가 -->
              <span class="confetti" style="--i:6">r</span> <!-- .confetti 클래스 추가 -->
              <span class="confetti" style="--i:7">y</span> <!-- .confetti 클래스 추가 -->
            </div>
          </div>
        </div>
     </a>
   </div>
   <div class="navbar">
       <ul class="nav-list">
         <li><a href="/notice/adminNotice">Notice</a></li>
         <li><a href="/resto/restoList">Restaurant</a></li>
         <li><a href="/gift/giftList">Gift</a></li>
         <li><a href="/inquiry/inquiryList">QnA</a></li>
        </ul>
      <ul class="right">
     <a href="/seller/sellerMyPage">
        <li id="center">
            <img src="../resources/images/sellerfile.png"  style="width: 30px; height: 30px; margin-right:-5px;" >
          <b style="color: #FFF; text-decoration: underline; margin-left: 5px; display: inline-block; vertical-align: middle; margin-top: -5px;" id="sellerProFileShopName"><%= seller %></b>
       </li>
     </a>
     <li style="margin-left: 20px;">
        <a href="/seller/logout">
          <img alt="" src="/resources/images/logout3.png" style="width: 70px; height: 60px; margin-top:-15px;">
       </a>
     </li>
<%
}
else
{
%>
   <!-- 로고 -->
   <div style="display: flex; align-items: center;"> 
     <a href="/">
        <div class="textcontainer" style="width: max-content; font-family: 'dayiary', sans-serif;">
          <!-- 꽃가루 효과를 적용한 폰트 영역 -->
          <div class="waviy-container" style="position: relative;">
            <div class="waviy waviy-container confetti" style="display: flex; gap: 4px; position: absolute; top: 0; left: 0;"> <!-- .confetti 클래스 추가 -->
              <span class="confetti" style="--i:1; font-size: 60px;">D</span> <!-- .confetti 클래스 추가 -->
              <span class="confetti" style="--i:2; font-size: 60px;">A</span> <!-- .confetti 클래스 추가 -->
              <span class="confetti" style="--i:3; font-size: 60px;">Y</span> <!-- .confetti 클래스 추가 -->
              <span class="confetti" style="--i:4">i</span> <!-- .confetti 클래스 추가 -->
              <span class="confetti" style="--i:5">a</span> <!-- .confetti 클래스 추가 -->
              <span class="confetti" style="--i:6">r</span> <!-- .confetti 클래스 추가 -->
              <span class="confetti" style="--i:7">y</span> <!-- .confetti 클래스 추가 -->
            </div>
          </div>
        </div>
     </a>
   </div>
   <!-- 메뉴 -->
      <div class="navbar">
          <ul class="nav-list">
            <li><a href="/notice/adminNotice">Notice</a></li>
            <li><a href="/index/event">Event</a></li>
            <li><a href="/calender/calender">Calendar</a></li>
           </ul>
         <ul class="right">
        <li>
           <a href="/user/login">
                <img alt="" src="/resources/images/login.png" style="width: 70px; height: 60px; margin-top:-10px;">
             </a>
          </li>
<%
}
%>
    </ul>
</div>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
function initparticles() {
   confetti();
}

function confetti() {
   $.each($(".confetti"), function(){ // .confetti 클래스 대상으로 꽃가루 추가
      var confetticount = ($(this).width()/50)*2;
      for(var i = 0; i <= confetticount; i++) {
         $(this).append('<span class="particle c' + $.rnd(1,3) + '" style="top:' + $.rnd(10,50) + '%; left:' + $.rnd(0,100) + '%;width:' + $.rnd(6,8) + 'px; height:' + $.rnd(3,4) + 'px;animation-delay: ' + ($.rnd(0,30)/10) + 's;"></span>');
      }
   });
}

jQuery.rnd = function(m,n) {
   m = parseInt(m);
   n = parseInt(n);
   return Math.floor( Math.random() * (n - m + 1) ) + m;
}

$(document).ready(function() {
  // 페이지가 로드되면 꽃가루 효과를 적용합니다.
  initparticles();
});
</script>