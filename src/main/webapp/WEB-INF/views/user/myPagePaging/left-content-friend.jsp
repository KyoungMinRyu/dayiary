<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport"
   content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
<link rel="stylesheet"
   href="https://cdnjs.cloudflare.com/ajax/libs/normalize/5.0.0/normalize.min.css">

<script
   src='https://cdnjs.cloudflare.com/ajax/libs/smooth-scrollbar/8.3.1/smooth-scrollbar.js'></script>
<script
   src='https://cdnjs.cloudflare.com/ajax/libs/smooth-scrollbar/8.3.1/plugins/overscroll.js'></script>
<style>


html {
   position: relative;
   
}

<c:choose>
   <c:when test="${relationalType eq '1'}">
      body {
         font-family: "Roboto", sans-serif;
         font-size: 16px;
         background: #FB929E;
      }
      
      .scroll-list__wrp {
         width: 100%;
         height: 700px;
         overflow: auto;
         padding: 50px;
         background: #FFDFDF;
         margin-bottom: 15px;
         border-radius: 8px;
      }
      
      .scroll-list__item {
         width: 100%;
         height: 155px;
         display: block;
         background: #AEDEFC;
         margin-bottom: 15px;
         border-radius: 8px;
         transition: all 0.35s ease-in-out;
         opacity: 0;
         transform: scale(0.7);
      }
       
      .box-span {   
          display: inline-block;
         height: 65px;
         background: #FFF6F6;
         text-align: center;
         align-items: center;
         justify-content: center;
          border-radius: 10px; /* 박스 모서리 둥글게 만들기 */
      }
      
      .box-span b {
           display: flex;
           align-items: center;
           justify-content: center;
           width: 100%;
           height: 100%;
           color: #AEDEFC;
           font-size: 20px
      }
      
      .btn_tag input[type="button"] {
         background: #FFF6F6; 
         border: none;
          border-radius: 10px; /* 버튼의 모서리 둥글게 만들기 */
          transition: background-color 0.3s; /* 배경색 변화에 트랜지션 적용 */
      }
      
      .btn_tag input[type="button"]:hover {
          background-color: #AEDEFC;
      }
   
   
   </c:when>
   <c:otherwise>
      
      
      .scroll-list__wrp {
         width: 100%;
         height: 700px;
         overflow: auto;
         padding: 50px;
         background: #A2D5F2;
         margin-bottom: 15px;
         border-radius: 8px;
      }
      
      .scroll-list__item {
         width: 100%;
         height: 155px;
         display: block;
         background: #FF7E67;
         margin-bottom: 15px;
         border-radius: 8px;
         transition: all 0.35s ease-in-out;
         opacity: 0;
         transform: scale(0.7);
      }
       
      .box-span {   
          display: inline-block;
         height: 65px;
         background: #FAFAFA;
         text-align: center;
         align-items: center;
         justify-content: center;
          border-radius: 10px; /* 박스 모서리 둥글게 만들기 */
      }
      
      .box-span b {
           display: flex;
           align-items: center;
           justify-content: center;
           width: 100%;
           height: 100%;
           color: #FF7E67;
           font-size: 20px
      }
      
      .btn_tag input[type="button"] {
         background: #FAFAFA; 
         border: none;
          border-radius: 10px; /* 버튼의 모서리 둥글게 만들기 */
          transition: background-color 0.3s; /* 배경색 변화에 트랜지션 적용 */
      }
      
      .btn_tag input[type="button"]:hover {
          background-color: #FF7E67;
      }
   </c:otherwise>
</c:choose>

a, a:hover {
   text-decoration: none;
}

* {
   box-sizing: border-box;
   
}

.wrapper {
   display: flex;
   align-items: center;
   min-height: 100vh;
}

.scroll-list {
   width: 100%;
   max-width: 900px;
   padding: 25px;
   margin-top: 50px;
   margin-left: auto;
   margin-right: auto;
}

@media screen and (max-width: 768px) {
   .scroll-list {
      margin-top: 20px;
   }
}

.scroll-list__wrp .scrollbar-track {
   display: none !important;
}

@media screen and (max-width: 768px) {
   .scroll-list__wrp {
      padding: 25px;
   }
}

.scroll-list__item.item-hide {
   opacity: 0;
   transform: scale(0.7);
}

.scroll-list__item.item-focus {
   opacity: 1;
   transform: scale(1);
}

.scroll-list__item.item-next {
   opacity: 1;
   transform: scale(1);
}

.scroll-list__item.item-next+.scroll-list__item {
   opacity: 1;
   transform: scale(1);
}

.scroll-list__item:last-child {
   margin-bottom: 155px;
}

.rounded-div {
     width: 155px;
      height: 100%;
      border-radius: 10px; /* 조절 가능한 값을 사용 */
      overflow: hidden; /* 내용이 모서리를 넘어가지 않도록 함 */
      object-fit: cover;
 }

.box {
    display: flex;
    justify-content: space-between;
    width: 750px;
    height: 155px;
   align-items: center;
   justify-content: center;
}



@keyframes shimmer {
    0% {
        background-color: #fff;
    }
    50% {
        background-color: #f199bc;
    }
    100% {
        background-color: #fe4365;
    }
}   

.btn_tag {
    display: flex;   
    justify-content: center; /* 가로 가운데 정렬 */
    align-items: center;
    margin-bottom: 10px;
    border-radius: 10px; /* 버튼의 모서리 둥글게 만들기 */
}

.btn_tag > * {
   margin-right: 10px;
}

.btn_tag select,
.btn_tag input[type="text"] {
    width: 150px;
    border-radius: 10px; /* 버튼의 모서리 둥글게 만들기 */
}

.snowflake {
     color: #FFF6F6;
     font-size: 1.3em; 
}

.text_tag
{
   margin-bottom: 10px;
}


img{
   max-width: 100%;
    height: auto;
}

.task-manager {
   display: flex;
  justify-content: space-between;
  width: 100%;
  max-width: 1200px;
  background: #fff;
  border-radius: 4px;
  box-shadow: 0 0.3px 2.2px rgba(0, 0, 0, 0.011), 0 0.7px 5.3px rgba(0, 0, 0, 0.016), 0 1.3px 10px rgba(0, 0, 0, 0.02), 0 2.2px 17.9px rgba(0, 0, 0, 0.024), 0 4.2px 33.4px rgba(0, 0, 0, 0.029), 0 10px 80px rgba(0, 0, 0, 0.04);
  overflow: hidden;
  max-width: 1600px;
  margin-top: 75px;
}

.item span {
   font-size: 15px;
}


 
h2
{
   font-family : 'SUIT-Regular', sans-serif;
   font-size: 12px;
} 

body {
  margin: 0;
  justify-content: center;
  flex-direction: column;
  overflow-x : hidden; 
  overflow-y : auto;
  width: 100%;
  height: 100%;
  padding: 12px;
  font-family: "DM Sans", sans-serif;
  font-size: 12px;
  background-color : #fffbf4 !important; 
   padding-bottom: 0px;

}
.profile-section {
  flex-shrink: 0; /* 이 부분은 .profile-section을 고정하는 역할을 합니다. */
  
}
ul {
  list-style-type: none;
  padding: 0;
}




@-webkit-keyframes snowflakes-fall{0%{top:-10%}100%{top:100%}}
@-webkit-keyframes snowflakes-shake{0%{-webkit-transform:translateX(0px);transform:translateX(0px)}50%{-webkit-transform:translateX(80px);transform:translateX(80px)}100%{-webkit-transform:translateX(0px);transform:translateX(0px)}}
@keyframes snowflakes-fall{0%{top:-10%}100%{top:100%}}
@keyframes snowflakes-shake{0%{transform:translateX(0px)}50%{transform:translateX(80px)}100%{transform:translateX(0px)}}.snowflake{position:fixed;top:-10%;z-index:9999;-webkit-user-select:none;-moz-user-select:none;-ms-user-select:none;user-select:none;cursor:default;-webkit-animation-name:snowflakes-fall,snowflakes-shake;-webkit-animation-duration:10s,3s;-webkit-animation-timing-function:linear,ease-in-out;-webkit-animation-iteration-count:infinite,infinite;-webkit-animation-play-state:running,running;animation-name:snowflakes-fall,snowflakes-shake;animation-duration:10s,3s;animation-timing-function:linear,ease-in-out;animation-iteration-count:infinite,infinite;animation-play-state:running,running}.snowflake:nth-of-type(0){left:1%;-webkit-animation-delay:0s,0s;animation-delay:0s,0s}.snowflake:nth-of-type(1){left:10%;-webkit-animation-delay:1s,1s;animation-delay:1s,1s}.snowflake:nth-of-type(2){left:20%;-webkit-animation-delay:6s,.5s;animation-delay:6s,.5s}.snowflake:nth-of-type(3){left:30%;-webkit-animation-delay:4s,2s;animation-delay:4s,2s}.snowflake:nth-of-type(4){left:40%;-webkit-animation-delay:2s,2s;animation-delay:2s,2s}.snowflake:nth-of-type(5){left:50%;-webkit-animation-delay:8s,3s;animation-delay:8s,3s}.snowflake:nth-of-type(6){left:60%;-webkit-animation-delay:6s,2s;animation-delay:6s,2s}.snowflake:nth-of-type(7){left:70%;-webkit-animation-delay:https://proxy.everskies.com/a/https://proxy.everskies.com/a/2.5s,1s;animation-delay:https://proxy.everskies.com/a/https://proxy.everskies.com/a/2.5s,1s}.snowflake:nth-of-type(8){left:80%;-webkit-animation-delay:1s,0s;animation-delay:1s,0s}.snowflake:nth-of-type(9){left:90%;-webkit-animation-delay:3s,https://proxy.everskies.com/a/https://proxy.everskies.com/a/1.5s;animation-delay:3s,https://proxy.everskies.com/a/https://proxy.everskies.com/a/1.5s}

</style>
<script>
$(document).ready(function () 
{
     var Scrollbar = window.Scrollbar;

     Scrollbar.use(window.OverscrollPlugin);

     var customScroll = Scrollbar.init(document.querySelector('.js-scroll-list'), 
     {
       plugins: 
       {
            overscroll: true
       }
     });

     var listItem = $('.js-scroll-list-item');

     listItem.eq(0).addClass('item-focus');
     listItem.eq(1).addClass('item-next');

     customScroll.addListener(function (status) 
     {

       var $content = $('.js-scroll-content');
   
       var viewportScrollDistance = 0;
   
   
       viewportScrollDistance = status.offset.y;
       var viewportHeight = $content.height();
       var listHeight = 0;
       var $listItems = $content.find('.js-scroll-list-item');
       for (var i = 0; i < $listItems.length; i++) 
       {
            listHeight += $($listItems[i]).height();
       }

       var top = status.offset.y;
       // console.log(top);
       var visibleCenterVertical = 0;
       visibleCenterVertical = top;
   
       var parentTop = 1;
       var $lis = $('.js-scroll-list-item');
       var $focusLi;
       for (var i = 0; i < $lis.length; i++) 
       {
            var $li = $($lis[i]);
            var liTop = $li.position().top;
            var liRelTop = liTop - parentTop;   
            var distance = 0;
            var distance = Math.abs(top - liRelTop);
            var maxDistance = $('.js-scroll-content').height() / 2;
            var distancePercent = distance / (maxDistance / 100);
   

            if (liRelTop + $li.parent().scrollTop() > top) 
            {
              if (!$li.hasClass('item-focus')) 
              {
                   $li.prev().addClass('item-hide');
                   $lis.removeClass('item-focus');
                   $lis.removeClass('item-next');
              }
              $li.removeClass('item-hide');
              $li.addClass('item-focus');
              $li.next().addClass('item-next');
              break;
            }
       }
     });
 
      $("#btnSearch").on("click", function() 
   {
       var yourId = "";
       var searchType = $("#_searchType").val();
       var searchValue = $("#_searchValue").val();
        var listType = "";


          $.ajax({
              type: "POST",
              url: "/user/myPagePaging/left-content-friend",
              data: {
                  yourId: yourId,
                  searchType: searchType,
                  searchValue: searchValue,
                  listType: listType
              },
              success: function(response) {
                  // 서버에서 반환된 HTML을 페이지에 삽입
                  // (예: 'left-content-friend' 섹션에 대한 선택자가 필요함)
                  $('.page-contentmain').html(response);
              },
              error: function(jqXHR, textStatus, errorThrown) {
                  console.error("AJAX 요청 실패: " + textStatus);
              }
          });
      });   
   
   $("#btnList").on("click", function() 
   {
      var yourId = "";
      var searchType = "";
       var searchValue = "";
        var listType = "0";


          $.ajax({
              type: "POST",
              url: "/user/myPagePaging/left-content-friend",
              data: {
                  yourId: yourId,
                  searchType: searchType,
                  searchValue: searchValue,
                  listType: listType
              },
              success: function(response) {
                  // 서버에서 반환된 HTML을 페이지에 삽입
                  // (예: 'left-content-friend' 섹션에 대한 선택자가 필요함)
                  $('.page-contentmain').html(response);
              },
              error: function(jqXHR, textStatus, errorThrown) {
                  console.error("AJAX 요청 실패: " + textStatus);
              }
          });
   });
   
   $("#btnCheckRes").on("click", function() 
   {
      var yourId = "";
      var searchType = "";
       var searchValue = "";
        var listType = "1";


          $.ajax({
              type: "POST",
              url: "/user/myPagePaging/left-content-friend",
              data: {
                  yourId: yourId,
                  searchType: searchType,
                  searchValue: searchValue,
                  listType: listType
              },
              success: function(response) {
                  // 서버에서 반환된 HTML을 페이지에 삽입
                  // (예: 'left-content-friend' 섹션에 대한 선택자가 필요함)
                  $('.page-contentmain').html(response);
              },
              error: function(jqXHR, textStatus, errorThrown) {
                  console.error("AJAX 요청 실패: " + textStatus);
              }
          });
      });   
   
   $("#btnCheckReq").on("click", function() 
   {
       var yourId = "";
       var searchType = "";
        var searchValue = "";
         var listType = "2";


          $.ajax({
              type: "POST",
              url: "/user/myPagePaging/left-content-friend",
              data: {
                  yourId: yourId,
                  searchType: searchType,
                  searchValue: searchValue,
                  listType: listType
              },
              success: function(response) {
                  // 서버에서 반환된 HTML을 페이지에 삽입
                  // (예: 'left-content-friend' 섹션에 대한 선택자가 필요함)
                  $('.page-contentmain').html(response);
              },
              error: function(jqXHR, textStatus, errorThrown) {
                  console.error("AJAX 요청 실패: " + textStatus);
              }
          });
      });   
   
   $("#btnMyFriendList").on("click", function() 
   {
       var yourId = "";
       var searchType = "";
       var searchValue = "";
       var listType = "3";


       $.ajax({
           type: "POST",
           url: "/user/myPagePaging/left-content-friend",
           data: {
               yourId: yourId,
               searchType: searchType,
               searchValue: searchValue,
               listType: listType
           },
           success: function(response) {
               // 서버에서 반환된 HTML을 페이지에 삽입
               // (예: 'left-content-friend' 섹션에 대한 선택자가 필요함)
              $('.page-contentmain').html(response);
           },
           error: function(jqXHR, textStatus, errorThrown) {
               console.error("AJAX 요청 실패: " + textStatus);
           }
       });
   });

    
    <c:choose>
      <c:when test="${relationalType eq 1}">
         $("#btnFriend").on("click", function() 
         {
            document.friendForm.relationalType.value = "0";
               document.friendForm.action = "/friend/friendList";
             document.friendForm.submit();
            });
      </c:when>
      <c:otherwise>
         $("#btnCouple").on("click", function() 
         {   
            document.friendForm.relationalType.value = "1";
            document.friendForm.action = "/friend/friendList";
             document.friendForm.submit();
            });   
      </c:otherwise>
   </c:choose>   
});

function fn_view(yourId)
{
   document.friendForm.yourId.value = yourId;
   document.friendForm.action = "/friend/yourPage";
      document.friendForm.submit();
}

function fn_list()
{
   document.friendForm.yourId.value = "";
   document.friendForm.action = "/friend/friendList";
      document.friendForm.submit();
}
</script>
</head>
<body>

<div class="snowflakes">
   <div class="wrapper" style=" padding-bottom: 500px; height: 1200px;">
      <div class="scroll-list">
      <div class="btn_tag" style="margin-bottom: 10px">
         <c:choose>
            <c:when test="${relationalType eq '1'}">
               <input type="button" id="btnFriend" value="친구등록" style="height: 38px; margin-left: 8px;">
            </c:when>
            <c:otherwise>
               <input type="button" id="btnCouple" value="연인등록" style="height: 38px; margin-left: 8px;">
            </c:otherwise>
         </c:choose>
         <input type="button" id="btnList" value="유저 목록" style="height: 38px;">
         <input type="button" id="btnCheckRes" value="받은 친구 요청" style="height: 38px;">
         <input type="button" id="btnCheckReq" value="보낸 친구 요청" style="height: 38px;">
         <input type="button" id="btnMyFriendList" value="내 친구" style="height: 38px;">
         <select name="_searchType" id="_searchType" class="" style="width: 80px; height: 38px;">
               <option value="0" <c:if test='${searchType eq "0"}'>selected</c:if>>전체</option>
               <option value="1" <c:if test='${searchType eq "1"}'>selected</c:if>>아이디</option>
               <option value="2" <c:if test='${searchType eq "2"}'>selected</c:if>>닉네임</option>
               <option value="3" <c:if test='${searchType eq "3"}'>selected</c:if>>이메일</option>
            </select>
            <input type="text" name="_searchValue" id="_searchValue" value="${searchValue}" class="form-control mx-1" maxlength="20" style="width: 200px; height: 38px" placeholder="조회값을 입력하세요." />
            <img src="/resources/images/search.png" id="btnSearch" style="width: 38px; height: 38px;">
      </div>
      <div class="text_tag" style="margin-left: 115px;">
         <b>
            프로필   
         </b>
         <b style="margin-left: 198px;">
            닉네임
         </b>
         <b style="margin-left: 150px;">
            가입일
         </b>
         <b style="margin-left: 100px;">
            친구수
         </b>
         
      </div>
         <div class="scroll-list__wrp js-scroll-content js-scroll-list">      
            <c:if test="${!empty list}">
               <c:forEach var="friend" items="${list}" varStatus="status">
                  <c:choose>
                     <c:when test="${friend.relationalType eq '1'}">
                        <div class="scroll-list__item js-scroll-list-item" onclick="fn_view('${friend.userId}')">
                           <div class="box" style="animation: shimmer 3s infinite;">
                              <span style="width: 155px; height: 100%;">
                                 <img alt="" class="rounded-div" src="${friend.fileName}" style="width: 135px; height: 135px; margin-left: 10px; margin-top: 10px;">
                              </span>
                              <span class="box-span " style="margin-left: 45px; width: 250px;">
                                 <b>
                                    ${friend.userNickName}
                                 </b>
                              </span>
                              <span  class="box-span" style="margin-left: 20px; width: 120px;">
                                 <b>
                                    ${friend.regDate}
                                 </b>
                              </span>
                              <span  class="box-span" style="margin-left: 35px; width: 100px;">
                                 <b>
                                    ${friend.friendCnt}
                                 </b>
                              </span>
                           </div>
                        </div>
                     </c:when>
                     <c:otherwise>
                        <div class="scroll-list__item js-scroll-list-item" onclick="fn_view('${friend.userId}')">   
                           <div class="box">
                              <span style="width: 155px; height: 100%;">
                                 <img alt="" class="rounded-div" src="${friend.fileName}" style="width: 135px; height: 135px; margin-left: 10px; margin-top: 10px;">
                              </span>
                              <span class="box-span " style="margin-left: 45px; width: 250px;">
                                 <b>
                                    ${friend.userNickName}
                                 </b> 
                              </span>
                              <span  class="box-span" style="margin-left: 20px; width: 120px;">
                                 <b>
                                    ${friend.regDate}
                                 </b>
                              </span>
                              <span  class="box-span" style="margin-left: 35px; width: 100px;">
                                 <b> 
                                    ${friend.friendCnt}
                                 </b>
                              </span>
                           </div>
                        </div>      
                     </c:otherwise>
                  </c:choose>
                           
               </c:forEach>
            </c:if>    
            <c:if test="${list.size() > 3}">
               <div class="scroll-list__item js-scroll-list-item"></div>
            </c:if>  
         </div>
         
      </div>
   </div>
</div>
<form name="friendForm" id="friendForm" method="post">
   <input type="hidden" name="yourId" value="" />
   <input type="hidden" name="relationalType" value="${relationalType}" />
   <input type="hidden" name="listType" value="${listType}" />
   <input type="hidden" name="searchType" value="${searchType}" />
   <input type="hidden" name="searchValue" value="${searchValue}" />
</form>   

</body>
</html>