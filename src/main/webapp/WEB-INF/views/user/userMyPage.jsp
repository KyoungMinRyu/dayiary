<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>



<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/views/include/head.jsp" %>
<meta name="viewport"
   content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
<link rel="stylesheet"
   href="https://cdnjs.cloudflare.com/ajax/libs/normalize/5.0.0/normalize.min.css">

<script
   src='https://cdnjs.cloudflare.com/ajax/libs/smooth-scrollbar/8.3.1/smooth-scrollbar.js'></script>
<script
   src='https://cdnjs.cloudflare.com/ajax/libs/smooth-scrollbar/8.3.1/plugins/overscroll.js'></script>
 <link rel="stylesheet" href="/resources/css/myPagestyle.css">
 <link rel="stylesheet" href="/resources/css/cardstyle.css">
 
 
<!-- jQuery 라이브러리 로드 -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<!-- combined_script.js 로드 -->
<script src="/resources/js/combined_script.js">

window.onload = function() {
    var colors = ['red', 'blue', 'green', 'yellow', 'purple'];
    var taskBoxes = document.querySelectorAll('.task-box');

    
};

</script>
<style>
h2
{
   font-family : 'SUIT-Regular', sans-serif;
}
p
{
   font-family : 'SUIT-Regular', sans-serif
}
.item span {
   font-size: 15px;
}
.task-box-profile{
   position: relative;
  border-radius: 12px;
  width: 50%;
  margin: 20px 0;
  padding: 16px;
  cursor: pointer;
  box-shadow: 2px 2px 4px 0px #ebebeb;
}
body{

   
   
}

h2
{
   font-family : 'SUIT-Regular', sans-serif;
}
p
{
   font-family : 'SUIT-Regular', sans-serif
}
.item span {
   font-size: 15px;
}

.task-box-profile{
   position: relative;
  border-radius: 12px;
  width: 50%;
  margin: 20px 0;
  padding: 16px;
  cursor: pointer;
  box-shadow: 2px 2px 4px 0px #ebebeb;
}

.contain
{
display: flex;
  width: 100%;
  height: 700px;
 
}


.card-myId {
  margin: auto;
  overflow-y: auto;
  position: relative;
  background-color: white;
  transition: 0.3s;
  flex-direction: column;
  border-radius: 10px;
  box-shadow: 0 0 0 8px rgba(255, 255, 255, 0.2);
  height: 700px;
  margin-top: 20px;
  width:100%;
  height: 100%;
}

footer {
    background-color: black;
    color: lightgray;
    text-align: center;
    padding: 40px;
    flex: 2;
    
    flex-direction: column;
    min-width: 120%;
}

 .profile-image-container {
    position: relative;
    width: 100px;
    height: 100px;

  }

  .profile-image {
    width: 100%;
    height: 100%;
    object-fit: cover;
    position: absolute;
    left : 25%;
  }

  .centered-svg {
    position: absolute;
    top: 80%;
    left: 100px;
    transform: translate(-25%, -25%);
    width: 25px;
    height: 25px;
  }


</style>
<script type="text/javascript">
let a = "${yourFriend.relationalType}";

</script>

</head>
<body>
<link href="https://fonts.googleapis.com/css?family=DM+Sans:400,500,700&display=swap" rel="stylesheet">
<%@ include file="/WEB-INF/views/include/navigation.jsp" %>
<div class="task-manager">
  <div class="left-bar">
    <div class="upper-part">
      <div class="actions">
        <div class="circle"></div>
        <div class="circle-2"></div>
      </div>
    </div>
    <div class="left-content">
    
      <button class="small-button" onclick="loadleftContent('프로필')" style="height : 36px;">
      <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="#000000" stroke-width="2" stroke-linecap="butt" stroke-linejoin="bevel"><path d="M20 9v11a2 2 0 0 1-2 2H6a2 2 0 0 1-2-2V9"/><path d="M9 22V12h6v10M2 10.6L12 2l10 8.6"/></svg>
        

      </button>
      <button class="home-button" onclick="BackHome()" style="height : 36px;">
     <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="#000000" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
          <path d="M15 3h4a2 2 0 0 1 2 2v14a2 2 0 0 1-2 2h-4M10 17l5-5-5-5M13.8 12H3"/>
        </svg>
      </button>
    <ul class="profile-section">
        <div class="profile-section1">
          <div class="profile-image-container">
    <img src="${url}" alt="Profile Image" class="profile-image" style="cursor: pointer;">
    <svg onclick="showPopupProfileImg()" class="centered-svg" xmlns="http://www.w3.org/2000/svg" width="5" height="5" viewBox="0 0 24 24" fill="none" stroke="#000000" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" style="cursor: pointer;">
    
    <path fill="white" d="M19.4 15a1.65 1.65 0 0 0 .33 1.82l.06.06a2 2 0 0 1 0 2.83 2 2 0 0 1-2.83 0l-.06-.06a1.65 1.65 0 0 0-1.82-.33 1.65 1.65 0 0 0-1 1.51V21a2 2 0 0 1-2 2 2 2 0 0 1-2-2v-.09A1.65 1.65 0 0 0 9 19.4a1.65 1.65 0 0 0-1.82.33l-.06.06a2 2 0 0 1-2.83 0 2 2 0 0 1 0-2.83l.06-.06a1.65 1.65 0 0 0 .33-1.82 1.65 1.65 0 0 0-1.51-1H3a2 2 0 0 1-2-2 2 2 0 0 1 2-2h.09A1.65 1.65 0 0 0 4.6 9a1.65 1.65 0 0 0-.33-1.82l-.06-.06a2 2 0 0 1 0-2.83 2 2 0 0 1 2.83 0l.06.06a1.65 1.65 0 0 0 1.82.33H9a1.65 1.65 0 0 0 1-1.51V3a2 2 0 0 1 2-2 2 2 0 0 1 2 2v.09a1.65 1.65 0 0 0 1 1.51 1.65 1.65 0 0 0 1.82-.33l.06-.06a2 2 0 0 1 2.83 0 2 2 0 0 1 0 2.83l-.06.06a1.65 1.65 0 0 0-.33 1.82V9a1.65 1.65 0 0 0 1.51 1H21a2 2 0 0 1 2 2 2 2 0 0 1-2 2h-.09a1.65 1.65 0 0 0-1.51 1z"></path>
   <circle  cx="12" cy="12" r="3"></circle>
   </svg>

</div>



            <input id="profileImageInput" type="buton" style="display:none;" accept="image/*" onclick="showPopupProfileImg()">

            <h3 class="profile-name">${user.userNickName}
            
                <div class="setting-myprofilef">
                  
                </div>

            </h3>
            <div class="profile-under">
            <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="#000000" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M16 4h2a2 2 0 0 1 2 2v14a2 2 0 0 1-2 2H6a2 2 0 0 1-2-2V6a2 2 0 0 1 2-2h2"></path><rect x="8" y="2" width="8" height="4" rx="1" ry="1"></rect></svg>
            <button onclick="loadleftContent('다이어리')" style="height : 36px;">
              <p>다이어리 수 : ${friend.diaryCnt}</p>
            </button>
            </br>
            <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="#000000" stroke-width="2" stroke-linecap="butt" stroke-linejoin="bevel"><path d="M17 21v-2a4 4 0 0 0-4-4H5a4 4 0 0 0-4 4v2"></path><circle cx="9" cy="7" r="4"></circle><path d="M23 21v-2a4 4 0 0 0-3-3.87"></path><path d="M16 3.13a4 4 0 0 1 0 7.75"></path></svg>
            <button onclick="loadleftContent('친구관리')" style="height : 36px;"> 
             <c:choose>
             <c:when test="${friend.friendCnt == 0}">
             <p>친구 수 : ${friend.friendCnt}</p>
             </c:when>
             <c:when test="${friend.friendCnt != 0}">
             <p>친구 수 : ${friend.friendCnt}</p>
             </c:when>
             </c:choose>
          </button>
          </br>
          <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="#000000" stroke-width="2" stroke-linecap="butt" stroke-linejoin="bevel"><path d="M21.5 12H16c-.7 2-2 3-4 3s-3.3-1-4-3H2.5"/>
            <path d="M5.5 5.1L2 12v6c0 1.1.9 2 2 2h16a2 2 0 002-2v-6l-3.4-6.9A2 2 0 0016.8 4H7.2a2 2 0 00-1.8 1.1z"/>
          </svg>
        <button onclick="loadleftContent('쪽지')" style="height : 36px;">
          <p>받은 쪽지 수 : ${fromCount}</p>
        </button>
      </div>
        </div>
        <hr class="profile-divider">  <!-- This is the separating line -->
        
       
    </ul>
    <div class="content-item">
      <ul class="action-list">
         <li class="item active" onclick="loadleftContent('프로필')">
          <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="#000000" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
            <path d="M5.52 19c.64-2.2 1.84-3 3.22-3h6.52c1.38 0 2.58.8 3.22 3"/>
            <circle cx="12" cy="10" r="3"/><circle cx="12" cy="12" r="10"/>
          </svg>
             <span>프로필</span>
        </li>
        <li class="item" onclick="loadleftContent('다이어리')">
          <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="#000000" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M16 4h2a2 2 0 0 1 2 2v14a2 2 0 0 1-2 2H6a2 2 0 0 1-2-2V6a2 2 0 0 1 2-2h2"></path><rect x="8" y="2" width="8" height="4" rx="1" ry="1"></rect></svg>
          <span>다이어리</span>
        </li>
         <li class="item" onclick="loadleftContent('캘린더')">
         <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="#000000" stroke-width="2" stroke-linecap="butt" stroke-linejoin="bevel"><rect x="3" y="4" width="18" height="18" rx="2" ry="2"></rect><line x1="16" y1="2" x2="16" y2="6"></line><line x1="8" y1="2" x2="8" y2="6"></line><line x1="3" y1="10" x2="21" y2="10"></line></svg>
          <span>캘린더</span>
        </li>
        <li class="item" onclick="loadleftContent('결제내역')">
          <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="#000000" stroke-width="2" stroke-linecap="butt" stroke-linejoin="bevel"><rect x="2" y="4" width="20" height="16" rx="2"/><path d="M7 15h0M2 9.5h20"/></svg>
          <span>결제내역</span>
        </li>
        <li class="item" onclick="loadleftContent('친구관리')">
          <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none"
            stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"
            class="feather feather-users">
            <path d="M17 21v-2a4 4 0 0 0-4-4H5a4 4 0 0 0-4 4v2" />
            <circle cx="9" cy="7" r="4" />
            <path d="M23 21v-2a4 4 0 0 0-3-3.87" />
            <path d="M16 3.13a4 4 0 0 1 0 7.75" /></svg>
          <span>친구관리</span>
        </li>
        <li class="item" onclick="loadleftContent('쪽지')">
          <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="#000000" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
            <path d="M21 15a2 2 0 0 1-2 2H7l-4 4V5a2 2 0 0 1 2-2h14a2 2 0 0 1 2 2z">

            </path>
          </svg>
          <span>쪽지</span>
        </li>
         <li class="item" onclick="loadleftContent('문의사항')">
          <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="none" stroke="currentColor"
            stroke-linecap="round" stroke-linejoin="round" stroke-width="2" class="feather feather-inbox"
            viewBox="0 0 24 24">
            <path d="M22 12h-6l-2 3h-4l-2-3H2" />
            <path
              d="M5.45 5.11L2 12v6a2 2 0 0 0 2 2h16a2 2 0 0 0 2-2v-6l-3.45-6.89A2 2 0 0 0 16.76 4H7.24a2 2 0 0 0-1.79 1.11z" />
          </svg>
          <span>문의사항</span>
        </li>
         <li class="item" onclick="loadleftContent('내 정보수정')">
            <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="#000000" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><circle cx="12" cy="12" r="3"></circle><path d="M19.4 15a1.65 1.65 0 0 0 .33 1.82l.06.06a2 2 0 0 1 0 2.83 2 2 0 0 1-2.83 0l-.06-.06a1.65 1.65 0 0 0-1.82-.33 1.65 1.65 0 0 0-1 1.51V21a2 2 0 0 1-2 2 2 2 0 0 1-2-2v-.09A1.65 1.65 0 0 0 9 19.4a1.65 1.65 0 0 0-1.82.33l-.06.06a2 2 0 0 1-2.83 0 2 2 0 0 1 0-2.83l.06-.06a1.65 1.65 0 0 0 .33-1.82 1.65 1.65 0 0 0-1.51-1H3a2 2 0 0 1-2-2 2 2 0 0 1 2-2h.09A1.65 1.65 0 0 0 4.6 9a1.65 1.65 0 0 0-.33-1.82l-.06-.06a2 2 0 0 1 0-2.83 2 2 0 0 1 2.83 0l.06.06a1.65 1.65 0 0 0 1.82.33H9a1.65 1.65 0 0 0 1-1.51V3a2 2 0 0 1 2-2 2 2 0 0 1 2 2v.09a1.65 1.65 0 0 0 1 1.51 1.65 1.65 0 0 0 1.82-.33l.06-.06a2 2 0 0 1 2.83 0 2 2 0 0 1 0 2.83l-.06.06a1.65 1.65 0 0 0-.33 1.82V9a1.65 1.65 0 0 0 1.51 1H21a2 2 0 0 1 2 2 2 2 0 0 1-2 2h-.09a1.65 1.65 0 0 0-1.51 1z"></path>
                        </svg>
            <span>내 정보수정</span>
          </li>
         
      </ul>
      </div>
      
    </div>
  </div>

  
  <div class="page-content">
    <div class="content-categories">
      <div class="label-wrapper">
        <input class="nav-item" name="nav" type="radio" id="opt-1" checked>
        <label class="category" for="opt-1" onclick="loadContent('프로필')">프로필</label>
      </div>
      <c:choose>
      <c:when test="${yourFriend.relationalType eq '1'}">
      <div class="label-wrapper">
        <input class="nav-item" name="nav" type="radio" id="opt-2">
        <label class="category" for="opt-2" onclick="loadContent('연인상태')">연인상태</label>
      </div>
      </c:when>
      <c:otherwise>
       <div class="label-wrapper">
        <input class="nav-item" name="nav" type="radio" id="opt-2">
        <label class="category" for="opt-2" onclick="loadleftContent('친구관리')">친구관리</label>
      </div>
      </c:otherwise>
      </c:choose>
      <div class="label-wrapper">
        <input class="nav-item" name="nav" type="radio" id="opt-3">
        <label class="category" for="opt-3" onclick="loadContent('다이어리')">다이어리</label>
      </div>
      <div class="label-wrapper">
        <input class="nav-item" name="nav" type="radio" id="opt-4">
        <label class="category" for="opt-4" onclick="loadContent('좋아요')">좋아요</label>
      </div>
    </div>
    <div class="page-contentmain">
       <div class="contain">
    <div class="card card-myId" data-state="#about" style="height: 100%">
  <div class="card-header">
  <c:choose>
     <c:when test="${myGen eq '0' || user.userGen eq '0'}">
    <div class="card-cover" style="background-color: #4cc0f1d6;"></div>
    </c:when>
    <c:otherwise>
    <div class="card-cover" style="background-color: pink;"></div>
    </c:otherwise>
  </c:choose>
    <img class="card-avatar" src="${url}" alt="avatar" />
    <h1 class="card-fullname">${user.userNickName}</h1>
    <h2 class="card-jobtitle" style="font-size: 15px;">${user.userName}</h2>
  </div>
  <div class="card-main">
    <div class="card-section is-active" id="about" style="margin-left: 20px;">
      <div class="card-content">
        <div class="card-subtitle">내 정보</div>
        <p class="card-desc">
          <br />
          <div class="profilecard-id" style="text-align: center;">
               <b style="font-size : 20px;">아이디 : ${user.userId} </b>
          </div></br>
          <div class="profilecard-name" style="text-align: center;">
               <b style="font-size : 20px;">이름 : ${user.userName} </b>
          </div></br>
          <div class="profilecard-nickname" style="text-align: center;">
               <b style="font-size : 20px;">닉네임 : ${user.userNickName} </b>
          </div></br>
          <div class="profilecard-ph" style="text-align: center;">
              <b style="font-size : 20px;">연락처 : ${user.userPh} </b>
          </div></br>
          <div class="profilecard-email" style="text-align: center;">
   
               <b style="font-size : 20px;">이메일 : ${user.userEmail} </b>
          </div></br>
          <div class="profilecard-regdate" style="text-align: center;">
               <b style="font-size : 20px;">가입일 : ${user.regDate} </b>
          </div></br>
        </p>
      </div>
    </div>
  </div>
</div>

</div>     
    </div>
  </div>
  
  <div class="right-bar">
    <div class="top-part">
      <div class="header__avatar">
      <img src="${url}" alt="Profile Image" style="border-radius: 50%; width: 35px; height: 35px;  border: 0.5px solid black;  /* Add a black border */">
        <div class="dropdown">
         <ul class="dropdown__list">
          <li class="dropdown__list-item" onclick="loadleftContent('프로필')">
           <span class="dropdown__icon">
            <i class="far fa-user" >
            </i>
           </span>
           <span class="dropdown__title">
            내 프로필
           </span>
          </li>
          <li class="dropdown__list-item" onclick="loadleftContent('내 정보수정')">
           <span class="dropdown__icon">
            <i class="far fa-userupdate">
            </i>
           </span>
           <span class="dropdown__title">
            내 정보수정
           </span>
          </li>
          <li class="dropdown__list-item" onclick="loadleftContent('결제내역')">
           <span class="dropdown__icon">
            <i class="fas fa-clipboard-list">
            </i>
           </span>
           <span class="dropdown__title">
            결제 내역
           </span>
          </li>
            <li class="dropdown__list-item" onclick="location.href='/user/logout';">
          <span class="dropdown__icon">
              <i class="fas fa-sign-out-alt"></i>
          </span>
          <span class="dropdown__title">로그아웃</span>
        </li>
         </ul>
        </div>
       </div>
    
    </div>
    
    
    <div class="header">일정</div>
  <div class="right-content">
  <c:if test="${not empty selectcouple0}">
    <c:forEach var="item" items="${selectcouple0}" varStatus="status">

        <!-- 현재 날짜를 가져옵니다. -->
        <c:set var="currentDate" value="${currentDate}" />
        
        <!-- item.anniversaryDate를 문자열로 처리합니다. -->
        <c:set var="anniversaryDate" value="${item.anniversaryDate}" />

        <!-- anniversaryDate가 현재 날짜 이후라면 항목을 표시합니다. -->
        <c:if test="${anniversaryDate ge currentDate}">
            <c:set var="colorIndex" value="${status.index % 4}" />
            <c:choose>
                <c:when test="${colorIndex == 0}">
                    <c:set var="colorClass" value="red" />
                </c:when>
                <c:when test="${colorIndex == 1}">
                    <c:set var="colorClass" value="blue" />
                </c:when>
                <c:when test="${colorIndex == 2}">
                    <c:set var="colorClass" value="green" />
                </c:when>
                <c:when test="${colorIndex == 3}">
                    <c:set var="colorClass" value="yellow" />
                </c:when>
            </c:choose>
            
        <div class="task-box ${colorClass}" onclick="gocalendar('${item.anniversaryDate}')">
    <div class="description-task">
        <div class="time">
        
            <!-- 날짜 포맷 -->
            <c:set var="dateString" value="${item.anniversaryDate}" />
            
            
          <fmt:parseDate var="parsedDate" value="${dateString}" pattern="yyyy/MM/dd" />
         <fmt:formatDate value="${parsedDate}" pattern="yyyy/MM/dd" />

            <!-- 시간 포맷 -->
          <c:if test="${not empty item.anniversaryTime and item.anniversaryTime != 'null'}">
          <c:set var="hours" value="${fn:substring(item.anniversaryTime, 0, 2)}" />
          <c:set var="minutes" value="${fn:substring(item.anniversaryTime, 2, 4)}" />
          <c:set var="formattedTime" value="${hours}:${minutes}" />
          ${formattedTime}
         </c:if>



        </div>
        <div class="task-name">${item.anniversaryTitle}</div>
    </div>
    <div class="more-button">                
    </div>
    <div class="members">
        <c:choose>
            <c:when test="${item.sharedStatus eq 'Shared'}">
                <img src="${url}" alt="member" style="width: 35px; height: 35px;">
                <img src="${item.fileName}" alt="member" style="width: 35px; height: 35px;">
            </c:when>
            <c:otherwise>
                <img src="${url}" alt="member" style="width: 35px; height: 35px;">
            </c:otherwise>
        </c:choose>
    </div>
</div>

        </c:if>
    
    
</c:forEach>
    </c:if>
     <c:if test="${empty selectcouple0}">
        <div class="no-schedule-message">
           <b>등록된 일정이 없습니다.</b> 
        </div>
    </c:if>

</div>

  </div>
</div>
<footer style="background-color: black; color: lightgray; text-align: center; margin-top:80px; padding: 40px;">
 <a style="font-size:25px; letter-spacing:5px;">《 Dayiary 》 </a><br />
    &copy; Copyright Dayiary Corp. All Rights Reserved. <br>
    Always with you 🎉 여러분의 일상을 함께합니다.
</footer> 
<!-- partial -->
 
</body>
</html>   