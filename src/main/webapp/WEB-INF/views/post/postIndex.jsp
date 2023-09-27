<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/views/include/head.jsp" %>
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
   background-color: #fffbf4 !important;
   overflow-x:hidden;
}

.background {
  padding: 0 25px 25px;
  position: relative;
  width: 100%;
}

.background::after {
  content: '';
  background: #60a9ff;
  background: -moz-linear-gradient(top, #60a9ff 0%, #4394f4 100%);
  background: -webkit-linear-gradient(top, #60a9ff 0%,#4394f4 100%);
  background: linear-gradient(to bottom, #60a9ff 0%,#4394f4 100%);
  filter: progid:DXImageTransform.Microsoft.gradient( startColorstr='#60a9ff', endColorstr='#4394f4',GradientType=0 );
  height: 350px;
  left: 0;
  position: absolute;
  top: 0;
  width: 100%;
  z-index: 1;
}

@media (min-width: 900px) {
  .background {
    padding: 0 0 25px;
  }
}

.container {
  margin-top: 120px;
  padding: 50px 0 0;
  max-width: 960px;
  width: 100%;
}

.panel {
  background-color: #fff;
  border-radius: 10px;
  padding: 15px 25px;
  position: relative;
  width: 100%;
  z-index: 10;
}

.pricing-table {
  box-shadow: 0px 10px 13px -6px rgba(0, 0, 0, 0.08), 0px 20px 31px 3px rgba(0, 0, 0, 0.09), 0px 8px 20px 7px rgba(0, 0, 0, 0.02);
  display: flex;
  flex-direction: column;
}

@media (min-width: 900px) {
  .pricing-table {
    flex-direction: row;
  }
}

.pricing-table * {
  text-align: center;
}

.pricing-plan {
  border-bottom: 1px solid #e1f1ff;
  padding: 25px;
  display: flex;
  flex-direction: column;
  align-items: center;
}

.pricing-plan:last-child {
  border-bottom: none;
}

@media (min-width: 900px) {
  .pricing-plan {
    border-bottom: none;
    border-right: 1px solid #e1f1ff;
    flex-basis: 100%;
    padding: 25px 50px;
  }

  .pricing-plan:last-child {
    border-right: none;
  }
}

.pricing-img {
  margin: 0 auto; /* 이미지를 가운데로 정렬하는 스타일 */
  max-width: 100%;
  display: block; /* 이미지를 블록 요소로 변경하여 가운데 정렬 적용 */
}

.pricing-header {
  color: #888;
  font-weight: 600;
  letter-spacing: 3px;
}

.pricing-features {
  color: #016FF9;
  font-weight: 600;
  letter-spacing: 1px;
  margin: 30px 0 25px;
  height: 100px;
  list-style-type: none;
  padding:0px;
}

.pricing-features-item {
  border-top: 1px solid #e1f1ff;
  font-size: 20px;
  line-height: 1.5;
  padding: 15px 0;
}

.pricing-features-item:last-child {
  border-bottom: 1px solid #e1f1ff;
}

.pricing-button {
  border: 1px solid #9dd1ff;
  border-radius: 10px;
  color: #348EFE;
  display: inline-block;
  margin: 25px 0;
  padding: 15px 35px;
  text-decoration: none;
  transition: all 150ms ease-in-out;
}

.pricing-button:hover,
.pricing-button:focus {
  background-color: #e1f1ff;
}

.pricing-button.is-featured {
  background-color: #48aaff;
  color: #fff;
}

.pricing-button.is-featured:hover,
.pricing-button.is-featured:active {
  background-color: #269aff;
}

#imgContainer
{
   width:130px;
   height:150px;
   display: flex;
    flex-direction: column;
    justify-content: center;
    margin-bottom:8px;
}

#searchInput, #searchResult, #btnSearch
{
   font-size: 17px;
   margin-right:10px;
   letter-spacing:2px;
}


#user
{
    display: flex;
    flex-direction: row;
    justify-content: flex-start;
    gap:35px;
}








/*여기부턴 send 메세지 부분*/

body {
  margin: 0;
  display: grid;
  place-items: center;
  background: #ECEFFC;
}

.btn {
  position: relative;
  padding: 8px 24px;
  font-size: 100%;
  color: white;
  text-decoration: none;
  background-color: hsl(var(--hue), 100%, 41%);
  border: 1px solid hsl(var(--hue), 100%, 41%);
  border-radius: 5px;
  outline: transparent;
  overflow: hidden;
  cursor: pointer;
  user-select: none;
  white-space: nowrap;
  transition: 0.3s;
}

.btn:hover {
  background: hsl(var(--hue), 100%, 31%);
}

.btn-primary {
  --hue: 171;
}

.btn-info {
  --hue: 204;
}

.btn-success {
  --hue: 141;
}

.btn-danger {
  --hue: 348;
}

.btn-shock {
  background: transparent;
  border-color: transparent;
  overflow: visible;
}

.btn-shock:hover {
  color: hsl(var(--hue), 100%, 41%);
}

.btn-shock::before,
.btn-shock::after {
  position: absolute;
  content: "";
  top: -1px;
  left: -1px;
  right: -1px;
  bottom: -1px;
  border: inherit;
  border-radius: inherit;
  transition: 0.3s;
}

.btn-shock::before {
  z-index: -1;
  background: hsl(var(--hue), 100%, 41%);
}

.btn-shock::after {
  z-index: -2;
  background: white;
  border-color: hsl(var(--hue), 100%, 41%);
  transform: scale(0.5);
}

.btn-shock:hover::before {
  opacity: 0;
  transform: scale(1.2);
}

.btn-shock:hover::after {
  transform: scale(1);
}

.card {
  position: relative;
  display: flex;
  flex-direction: column;
  padding: 10px;
  font-family: Lato, sans-serif;
  background: white;
  border-radius: 10px;
  box-shadow: 0 0px 0.6px rgba(0, 0, 0, 0.028),
    0 0px 1.3px rgba(0, 0, 0, 0.04),
    0 0px 2.5px rgba(0, 0, 0, 0.05),
    0 0px 4.5px rgba(0, 0, 0, 0.06),
    0 0px 8.4px rgba(0, 0, 0, 0.072),
    0 0px 20px rgba(0, 0, 0, 0.1);
  overflow: hidden;
  opacity: 0;
  transform: scale(0.6);
  animation: bump-in 0.5s forwards;
  z-index:10000;
  justify-content: flex-end;
  width: 700px;
  height: 400px;
  font-size:18px;
}

.card .hint {
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  display: flex;
  justify-content: center;
  align-items: center;
}

.card .hint h2 {
  z-index: 2;
  font-size: 2em;
  color: transparent;
  user-select: none;
  transition: 1.5s 0.5s;
}

.card .hint::before,
.card .hint::after {
  position: absolute;
  content: '';
  top: 0;
  left: 0;
  z-index: 1;
  width: 100%;
  height: 100%;
  background: hsl(var(--hue), 100%, 31%);
  transform: rotate(-90deg);
  transform-origin: left top;
  transition: transform cubic-bezier(0.785, 0.135, 0.15, 0.86) 0.5s;
}

.card .hint::after {
  transition-delay: 0.1s;
}

.card.sent .hint h2 {
  color: white;
}

.card.sent .hint::before,
.card.sent .hint::after {
  transform: rotate(0);
}

.card.sent .hint::before {
  background: white;
}

.card.sent .hint::after {
  --hue: 141;
}

.card .textarea {
  appearance: none;
  height: 240px;
  padding: 10px;
  font-size: 100%;
  font-family: inherit;
  letter-spacing: 0.1em;
  color: #7f8c8d;
  background: #eeeeee;
  border: none;
  border-radius: 5px;
  transition: 0.5s;
  opacity: 0;
  transform: translateY(20px);
  animation: float-in 0.8s 0.5s forwards;
}

.card .textarea:focus {
  box-shadow: inset 0 0px 0.3px rgba(0, 0, 0, 0.028),
    inset 0 0px 0.7px rgba(0, 0, 0, 0.04),
    inset 0 0px 1.3px rgba(0, 0, 0, 0.05),
    inset 0 0px 2.2px rgba(0, 0, 0, 0.06),
    inset 0 0px 4.2px rgba(0, 0, 0, 0.072),
    inset 0 0px 10px rgba(0, 0, 0, 0.1);
  outline: none;
}

.card .multi-button {
  display: grid;
  grid-template-columns: repeat(3, 1fr);
  gap: 8px;
  margin-top: 10px;
}

.card .multi-button .btn {
  font-weight: bold;
  opacity: 0;
  transform: translateY(20px);
  animation: float-in 0.8s forwards;
}

.card .multi-button .btn:nth-child(1) {
  animation-delay: 0.5s;
}

.card .multi-button .btn:nth-child(2) {
  animation-delay: 0.7s;
}

.card .multi-button .btn:nth-child(3) {
  animation-delay: 0.9s;
}

@keyframes bump-in {
  50% {
    transform: scale(1.05);
  }

  to {
    opacity: 1;
    transform: scale(1);
  }
}

@keyframes float-in {
  to {
    opacity: 1;
    transform: translateY(0);
  }
}


form.card
{
    display: flex;
    top: -500px;
}






</style>

<script>


$(document).ready(function() {
   
   
    //작성하기버튼(pricing-button)을 눌렀을때
    $("#btnWrite").on("click", function () {
       
       if($.trim($("#searchResult").text()).length <= 0) //받는사람 입력 안했으면 돌려보냄
       {
          alert("받는 사람을 먼저 선택하세요.");
          return;
       }
       else   //입력했으면 메세지창 띄워줌
       {
         let card = $(".card");
         card.css("display", "flex");
       }
    });
    
    
    // 캔슬버튼을 눌렀을때
    $("#cancel").on("click", function () {
       
         let card = $(".card");
         card.css("display", "none");
    });
    
    
    //전송 버튼 눌렀을때
    $("#send").on("click", function() {
      
        //보낼 메세지에 아무것도 적지 않았을때
      if($.trim($("#textarea").val()).length <= 0) 
      {
          $(".card").css("display", "flex");
         alert("내용을 입력하세요.");
         return;
      }
      else //적었으면 쪽지 DB에 인서트하고 편지보내는 효과 실행
      {
         
         $.ajax({
             type: "POST",  
             url: "/post/sendPost", 
             data: 
             {
                  yourId : $("#yourId").val(),
                  msgContent : $("#textarea").val()
             }, 
             beforeSend:function(xhr)
              {
                 xhr.setRequestHeader("AJAX", "true");
              },
             success: function(response)
             {
                if(response.code == 0)
                {
                    $(".card").addClass("sent"); //쪽지보내는 효과 실행
                     setTimeout(function() 
                     {
                      $(".card").removeClass("sent"),
                     $(".card").css("display", "none"); //1.5초 뒤 창 닫음
                    } , 2000);
                }
                else if(response.code == 500)
                {
                   alert(response.data);
                }
                else if(response.code == 400)
                {
                   alert(response.data);
                }
                else if(response.code == 404)
                {
                   alert(response.data);
                }
                else if(response.code == 100)
                {
                   alert(response.data);
                }
                else   
                {
                   alert("알 수 없는 오류가 발생하였습니다.");
                }
                
             },
             error: function(xhr, status, error) 
             {
                 console.log(error);
             }
             
         });
         
      }
      
    });
      
     

    
    
    
    
    
    
    
    
   

   
   //유저 찾기 버튼 눌렀을때
  $("#btnSearch").on("click", function() {

       $.ajax({
           type: "POST",  
           url: "/post/searchUser", 
           data: 
           {
                searchInput : $("#searchInput").val()
           }, 
           beforeSend:function(xhr)
            {
               xhr.setRequestHeader("AJAX", "true");
            },
           success: function(response) 
           {
              if(response.code == 0)
            {
                 document.getElementById("userImage").src = response.data.fileName;
                 document.getElementById('userImage').style.display = 'inline';
                   document.getElementById('searchResult').innerText = response.data.userNickName;
                   document.getElementById('fromUser').innerText = "< " + response.data.userNickName + " > 님에게";
                   document.getElementById('yourId').value = response.data.userId; //유저아이디값 기억했다가 서버에 보내려고 히든타입에 담아둔거
            }
            else if(response.code == 400)
            {
               console.log("ajax 오류 400");
               alert("찾으려는 아이디를 입력해주세요.");
            }
            else if(response.code == 500)
            {
               alert("일치하는 사용자가 없습니다. 정확한 아이디를 입력해 주세요.");
            }

           },
           error: function(error) 
           {
              icia.common.error(error);
              console.log("ajax 에러");
           }
       }); 
       
     });
   
   
  
}); 






</script>

</head>
<body>
<%@ include file="/WEB-INF/views/include/navigation.jsp" %>
<div class="container">
  <div class="panel pricing-table">

    <div class="pricing-plan">
    <div id="imgContainer">
      <img src="/resources/images/post.png" alt="" class="pricing-img">
    </div>
      <h2 class="pricing-header">내 쪽지함</h2>
      <ul class="pricing-features">
        <li class="pricing-features-item">받은 쪽지 ${fromCount}개</li>
        <li class="pricing-features-item">보낸 쪽지 ${toCount}개</li>
      </ul>
      <a href="/post/postBox" class="pricing-button is-featured" id="btnMove">이동</a>
    </div>

    <div class="pricing-plan">
    <div id="imgContainer">
      <img src="/resources/images/send2.png" alt="" class="pricing-img">
    </div>
      <h2 class="pricing-header">쪽지 보내기</h2>
      <ul class="pricing-features" id="right">
        <li class="pricing-features-item">
         <div id="user">
         <div>받는 사람:</div>
            <div>
            <img id="userImage" src="" alt="noImage" style="width:35px; height:35px; display: none;">
            <span id="searchResult" style="border:none;"></span>
            <input type="hidden" id="yourId">
            </div>
         </div>
      </li>
        <li class="pricing-features-item"><input type="text" id="searchInput" placeholder="유저 아이디를 입력하세요"><button id="btnSearch">검색</button></li>
      </ul>
      <div>
   </div>
      <a href="#/" class="pricing-button" id="btnWrite">작성하기</a>
    </div>

  </div>
</div>



<form class="card" action="javascript:void(0);"  style="display: none;">
  <div class="hint">
    <h2>쪽지를 보냈어요!</h2>
  </div>
  <span id="fromUser" style="font-size: 25px; margin-bottom: 20px;"></span>
  <textarea class="textarea" id="textarea" placeholder="보내고 싶은 메시지를 작성해 보세요!"></textarea>
  <div class="multi-button">
    <button class="btn btn-danger btn-shock" id="cancel">취소</button>
    <button class="btn btn-info btn-shock" type="reset" id="reset">내용 지우기</button>
    <button class="btn btn-success btn-shock" type="button" id="send">전송</button>
  </div>
</form>  

</body>
</html>