<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<!DOCTYPE html>
<html>
<head>


 
 <link rel="stylesheet" href="/resources/css/cardstyle.css">
 <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/normalize/5.0.0/normalize.min.css">
<!-- jQuery 라이브러리 로드 -->




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


.contain
{
display: flex;
  width: 100%;
  height: 1200px;
}


.card-myId {
 
  margin: auto;
  overflow-y: hidden;
  position: relative;
  background-color: white;
  transition: 0.3s;
  flex-direction: column;
  border-radius: 10px;
  box-shadow: 0 0 0 8px rgba(255, 255, 255, 0.2);
  height : 100%;
  margin-top: 20px;
  width:100%;

}

.card-main
{
   height: 700px;
}



.profile-section1 {
  flex-shrink: 0; /* 이 부분은 .profile-section을 고정하는 역할을 합니다. */

}
.card[data-state="#about"] {
  height: 900px;
}

</style>
</head>
<body>
<div class="contain">
    <div class="card card-myId" data-state="#about" style="height: 700px;">
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
    
</body>
</html>