<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/views/include/head.jsp" %>
<link rel="stylesheet" href="/resources/css/progress-bar.css" type="text/css">
<style>

@font-face {
    font-family: 'SUIT-Regular'; /* 고딕 */
    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_suit@1.0/SUIT-Regular.woff2') format('woff2');
    font-weight: 100;
    font-style: normal;
} 


*{
  box-sizing:border-box;
  font-family : 'SUIT-Regular', sans-serif;
}

body {
  background-color: #fffbf4 !important;
}

.container {
  padding:0;
  background-color: #FFF; 
  box-shadow: 0 10px 20px rgba(0,0,0,0.19), 0 6px 6px rgba(0,0,0,0.23);
  height: 700px;
  margin-top:150px;
  border-radius : 10px;   
}



/* === CONVERSATIONS === */

.discussions {
  width: 32%;
  height: 700px;
  box-shadow: 0px 8px 10px rgba(0,0,0,0.20);
  overflow: overlay;
  background-color: #fff;
  display: inline-block;
  border-radius : 10px;
}

.discussions .discussion {
  width: 100%;
  height: 90px;
  background-color: #FAFAFA;
  border-bottom: solid 1px #E0E0E0;
  display:flex;
  align-items: center;
  cursor: pointer;
}

.discussions .search {
  display: flex;
  align-items: center;
  justify-content: center;
  color: #4f4f4f;
  background-color: #e3effd;
}

.discussions .search .searchbar {
  height: 40px;
  background-color: #FFF;
  width: 70%;
  padding: 0 20px;
  border-radius: 50px;
  border: 1px solid #EEEEEE;
  display:flex;
  align-items: center;
  cursor: pointer;
}

.discussions .search .searchbar input {
  margin-left: 15px;
  height:38px;
  width:100%;
  border:none;
}

.discussions .search .searchbar *::-webkit-input-placeholder {
    color: #E0E0E0;
}
.discussions .search .searchbar input *:-moz-placeholder {
    color: #E0E0E0;
}
.discussions .search .searchbar input *::-moz-placeholder {
    color: #E0E0E0;
}
.discussions .search .searchbar input *:-ms-input-placeholder {
    color: #E0E0E0;
}

.discussions .message-active {
  width: 98.5%;
  height: 100px;
  background-color: #FFF;
  border-bottom: solid 1px #E0E0E0;
}

.discussions .discussion .photo {
    margin-left:20px;
    display: block;
    width: 50px;
    height: 50px;
    background: #E6E7ED;
    -moz-border-radius: 50px;
    -webkit-border-radius: 50px;
    background-position: center;
    background-size: cover;
    background-repeat: no-repeat;
}

.desc-contact {
  height: 43px;
  width:50%;
  white-space: nowrap;
  overflow: visible;
  text-overflow: ellipsis;
}

.discussions .discussion .name {
  margin: -7px 0 0 20px;
  font-size: 15pt;
  color:#515151;
}

.discussions .discussion .message {
  margin: 6px 0 0 20px;
  font-size: 12pt;
  color:#515151;
}

.discussions .discussion .message2 {
  margin: 6px 0 0 20px;
  font-size: 12pt;
  color:#515151;
}

.timer {
  margin-left: 15%;
  font-size: 13px;
  padding: 3px 8px;
  color: #BBB;
  background-color: #FFF;
  border: 1px solid #E5E5E5;
  border-radius: 15px;
}

.chat {
  width: calc(74% - 85px);
}

.header-chat {
  background-color: #FFF;
  height: 90px;
  box-shadow: 0px 3px 2px rgba(0,0,0,0.100);
  display:flex;
  align-items: center;
  border-radius : 10px;
}

.chat .header-chat .icon {
  margin-left: 30px;
  color:#515151;
  font-size: 14pt;
}

.chat .header-chat .name {
  margin: 0 0 0 20px;
  text-transform: uppercase;
  font-size: 15pt;
  font-weight:bold;
  color:#515151;
}

.chat .header-chat .right {
  position: absolute;
  right: 40px;
}

.chat .messages-chat {
  padding: 25px 35px;
}

.chat .messages-chat .message {
  display:flex;
  align-items: center;
  margin-bottom: 8px;
}

.chat .messages-chat .message .photo {
    display: block;
    width: 45px;
    height: 45px;
    background: #E6E7ED;
    -moz-border-radius: 50px;
    -webkit-border-radius: 50px;
    background-position: center;
    background-size: cover;
    background-repeat: no-repeat;
}

.chat .messages-chat .text {
  margin: 0 20px;
  background-color: #f6f6f6;
  padding: 15px;
  border-radius: 12px;
  letter-spacing:2px;
  font-size: 22px;
}

.text-only {
  margin-left: 45px;
}

.time {
  font-size: 15px;
  color:lightgrey;
  margin-bottom:10px;
  margin-left: 65px;
  letter-spacing:1.5px;
}

.response-time {
  float: right;
  margin-right: 40px !important;
}

.response {
  float: right;
  margin-right: 0px !important;
  margin-left:auto; /* flexbox alignment rule */
}

.response .text {
  background-color: #e3effd !important;
}

.footer-chat {
  width: calc(65% - 66px);
  height: 80px;
  display:flex;
  align-items: center;
  position:absolute;
  bottom: 0;
  background-color: transparent;
  border-top: 2px solid #EEE;
  
}

.chat .footer-chat .icon {
  margin-left: 30px;
  color:#C0C0C0;
  font-size: 14pt;
}

.chat .footer-chat .send {
  color:#fff;
  background-color: #4f6ebd;
  position: absolute;
  right: 50px;
  padding: 12px 12px 12px 12px;
  border-radius: 50px;
  font-size: 14pt;
}

.chat .footer-chat .name {
  margin: 0 0 0 20px;
  text-transform: uppercase;
  font-size: 13pt;
  color:#515151;
}

.chat .footer-chat .right {
  position: absolute;
  right: 40px;
}

.write-message {
  border:none !important;
  width:60%;
  height: 50px;
  margin-left: 20px;
  padding: 10px;
}


.clickable {
  cursor: pointer;
}

p.\32 2 {
    text-align: end;
    font-size: 10px;
    color: lightgrey;
    margin-bottom: 10px;
    margin-right: 20px;
    letter-spacing: 1.5px;
}

.messages-chat
{
   overflow: auto;
    height: 608px;
}

</style>
<script type="text/javascript">

$(document).ready(function() {
   
    $(".message2").each(function() {
      var messageText = $(this).text();
      if (messageText.length > 15) 
      { // 메시지 텍스트가 13글자를 넘어가면 "...."으로 처리
        var shortenedText = messageText.substring(0, 15) + "....";
        $(this).text(shortenedText);
      }
    });
  
});

var postList;
var cookieUserId;

function fn_msgView(yourId)
{
     $.ajax({
           type: "POST",  
           url: "/post/postList", 
           data: 
           {
                yourId : yourId
           }, 
           beforeSend:function(xhr)
            {
               xhr.setRequestHeader("AJAX", "true");
            },
           success: function(response)
           {
              if(response.code == 0)
              {
                 cookieUserId = response.msg;
                  postList = response.data;
                  
                let show = "";
                let makeTag = "";
                let inputTag = $(".messages-chat");
                  
                  for(let i = 0; i < postList.length; i++)
                {
                     document.querySelector('#chatName').innerHTML = 
                        "<img src='" + postList[i].fileName + "' alt='' style='width:50px; height:40px; object-fit:cover;'class='pricing-img'> &nbsp;" + postList[i].userNickName;
                     
                   if(postList[i].toUserId !== cookieUserId)
                   {
                      makeTag = 
                         "<div class='message'><div class='photo' style='background-image: url(" + postList[i].fileName + ");'></div>"
                          + "<p class='text'>" + postList[i].msgContent + "</p></div><p class='time'>" + postList[i].sendDate + "</p>";
                   }
                   else
                   {
                      makeTag = 
                            "<div class='message text-only'><div class='response'><p class='text'>" + postList[i].msgContent + "</p></div>"
                             +"</div><p class='22'>" + postList[i].sendDate + "</p>";
                   }
                    show = show + makeTag;
                   makeTag = "";
                }
                  
                 show = show + "<br>"
                 inputTag.html(show);
                  
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



let selectedDiscussion = null;

function toggleDiscussionColor(element, i) {
    // 이전에 선택한 discussion의 배경색을 원래 색상으로 되돌립니다.
    if (selectedDiscussion) {
        selectedDiscussion.style.backgroundColor = ''; // 빈 문자열로 설정하여 기본 스타일로 돌립니다.
    }
    
    // 현재 선택한 discussion의 배경색을 변경합니다.
    element.style.backgroundColor = '#d9d9d9'; // 원하는 배경색으로 변경
    
    // 현재 선택한 discussion를 selectedDiscussion 변수에 저장합니다.
    selectedDiscussion = element;
    
   document.querySelector('#timer' + i).textContent = '💌';   
   document.querySelector('#timer' + i).style.backgroundColor = '';   
    
}


</script>
</head>
<body>
<%@ include file="/WEB-INF/views/include/navigation.jsp" %>

  <div class="container">
    <div class="row">
    

      <section class="discussions">
        
        
        <div class="discussion search">
        <h2 style="letter-spacing:10px;">📪POST</h2>
          <!--
          <div class="searchbar">
            <i class="fa fa-search" aria-hidden="true"></i>
            <input type="text" placeholder="Search..."></input>
          </div>
          -->
        </div>
        
        

<c:if test="${!empty currentList}">
   <c:forEach var="currentList" items="${currentList}" varStatus="i">   
        <div class="discussion" onclick="toggleDiscussionColor(this, '${i.index}'); fn_msgView('${currentList.fromUserId eq cookieUserId ? currentList.toUserId : currentList.fromUserId}')">
          <div class="photo" style="background-image: url(${currentList.fileName});">
          </div>
          <div class="desc-contact">
            <p class="name">${currentList.userNickName}</p>
            <p class="message2" id="thirteen">${currentList.msgContent}</p>
          </div>
     <c:choose>
     <c:when test="${currentList.toUserId eq cookieUserId}">     
          <div class="timer" id="timer${i.index}">💌</div>
     </c:when>
     <c:when test="${currentList.status eq 'Y'}">
          <div class="timer" id="timer${i.index}">💌</div>
     </c:when>
     <c:otherwise>
          <div class="timer" id="timer${i.index}" style="background-color:pink;">📧</div>
     </c:otherwise>
     </c:choose>
        </div>
   </c:forEach>
</c:if> 
 
<c:if test="${empty currentList}">
        <div class="discussion">
          <div class="desc-contact">
            <p class="message">아직 주고받은 쪽지가 없습니다.</p>
          </div>
        </div>
</c:if>  
      </section>
      
      
      
      <section class="chat">
        <div class="header-chat">
          <i class="icon fa fa-user-o" aria-hidden="true"></i>
          <p class="name" id="chatName"><img src="/resources/images/post.png" alt="" style="width:50px; height:35px;"class="pricing-img"> </p>
          <i class="icon clickable fa fa-ellipsis-h right" aria-hidden="true"></i>
        </div>
        

        <div class="messages-chat">
        </div>
       
       
      </section>
    </div>
  </div>
</body>
<script>

function handle(e){
    if(e.keyCode === 13){
      var content = document.getElementById("text-content").value;
      var html="<p class='text-bubble sent'>" + content + "</p>";
      $(html).appendTo(".current");

      var objDiv = document.getElementById("conversation-area");
      objDiv.scrollTop = objDiv.scrollHeight;
      document.getElementById("text-content").value = "";

    }

    return false;
}
$("#text-input").submit(function(e) {
    e.preventDefault();
});


$(".chip").click(function(){
  var selector = $(this).attr('id');
  var name = "";
  selector = selector.slice(-1);
  selector = "convo-"+selector;
  $(".conversation").removeClass('current');
  $("#"+selector).addClass("current");
  name = $("#"+selector).attr('title');
  $("#current-contact h3").html(name);
});
</script>
</html>