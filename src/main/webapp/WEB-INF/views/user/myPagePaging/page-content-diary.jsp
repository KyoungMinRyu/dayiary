<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<%@ page import="com.icia.web.util.CookieUtil" %>
<%@ page import="com.icia.common.util.StringUtil" %>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" type="text/css" href="/resources/css/myPageDiaryList.css">

<%@ include file="/WEB-INF/views/include/head.jsp" %>

<script type="text/javascript">



<% String cookieUserId = CookieUtil.getHexValue(request, "USER_ID");
   String myBoard = (String)request.getAttribute("myBoard");
%>
var myBoard = "1"; 
$(document).ready(function() {
     
    <% if(StringUtil.equals(myBoard, "1"))
       { 
    %>
 
         $("#check_btn").prop("checked", true);
         
     <% } %>    
   
   //글쓰기 버튼 눌렀을때
   $("#btnWrite").on("click", function() 
   {
      document.bbsForm.boardSeq.value = "";
      document.bbsForm.action = "/board/diaryWrite";
      document.bbsForm.submit();
   }); 
   
   //조회버튼 눌렀을때
   $("#btnSearch").on("click", function()
   { 
      document.bbsForm.boardSeq.value = "";
      document.bbsForm.searchType.value = $("#_searchType").val();
      document.bbsForm.searchValue.value = $("#_searchValue").val();
      document.bbsForm.curPage.value = "1";
      document.bbsForm.action = "/board/diaryList";
      document.bbsForm.submit();
   });
   
   //내 다이어리 보기 클릭했을때
    $("#check_btn").on("change", function() 
    {
    var checkbox = $(this);
    var curPage = ""; // 현재 페이지를 1로 설정하거나 필요한 값을 설정하세요.
    var myBoard = "";
    var searchValue = "";
   var searchType = "";
   
   
    if (checkbox.prop("checked"))
    {
        // 내 다이어리 보기 체크박스 체크 시
        myBoard = "1";
        searchValue = "<%= cookieUserId %>";
        searchType = "4";
        curPage = curPage || "1";
    }
    else 
    {
        // 내 다이어리 보기 체크박스 해제 시
        myBoard = "2";
        searchValue = "";
        searchType = "";
        curPage = curPage || "1";
        
    }

    fn_list(curPage, searchType, searchValue, myBoard);
});


 
   
});

function fn_view(boardSeq)
{
   document.bbsForm.boardSeq.value = boardSeq;
   document.bbsForm.action = "/board/diaryView";
   document.bbsForm.submit();
}

function fn_list(curPage, searchType, searchValue, myBoard)
{
    var checkbox = $("#check_btn");
    
    curPage = curPage || "1";  // 현재 페이지가 주어지지 않으면 1로 설정합니다
    if (checkbox.prop("checked"))
    {
       myBoard = "1";
        searchValue = "<%= cookieUserId %>";
        searchType = "4";
        
    }
    else 
    {
          myBoard = "2";
           searchValue = "";
           searchType = "4";
           
    }
    
   
    $.ajax({
        url: "/user/myPagePaging/page-content-diary",
        type: "POST", 
        data: {
            searchType: searchType,  // 필요한 경우 이 값을 설정하세요
            searchValue: searchValue,
            curPage: curPage,
            myBoard: myBoard
        },
        success: function(data) {
            $(".page-contentmain").html(data);
            $("#loading-indicator").hide();
        },
        error: function(error) {
            console.log("Error loading content:", error);
        }
    });
}




</script>

<style type="text/css">
/* input 숨겨준다 */
input#check_btn{
  display:none;
  }

input#check_btn + label{
  cursor:pointer;
  margin-left:50px;
  font-size:18px !important;
  box-shadow: 1px 3px 5px #F47C7C;
 }

input#check_btn + label > span{
  vertical-align: middle;
  padding-left: 10px;
  padding-right: 5px;
  font-weight:bold !important;
 }

/* label:before에 체크하기 전 상태 CSS */
input#check_btn + label:before{
  content:"";
  display:inline-block;
  width:17px;
  height:17px;
  border:2px solid #F47C7C;
  border-radius: 4px;
  vertical-align:middle;
  margin-left:5px;
  }
  
/* label:before에 체크 된 상태 CSS */  
input#check_btn:checked + label:before{
  background-color:#F47C7C;
  border-color:#F47C7C;
  background-repeat: no-repeat;
  background-position: 50%;
  }

.comment-text {
    position: relative;
    display: inline-block;
    padding-left: 10px; /* 이미지와 텍스트 사이의 간격 조절 */
}
  
.text-overlay {
    position: absolute;
    top: 40%;
    left: 0;
    transform: translateY(-50%);
    margin: 0;
    padding: 0;
    font-size: 16px;
    margin-left:20px;
}



   .header{
      height: 150px;
      background-image: url('/resources/images/cal.jpg');
      background-repeat: no-repeat;
      background-size: cover;
      background-position: center center;
      margin-top:20px;
   }
.container{
 width: auto; height: auto;
    max-width: 100px;
    max-height: 100px;
    margin-top:0px;
    padding-top : 0px;
    
}   




.card {
    border: 1px solid #ddd;
    border-radius: 5px;
    padding: 20px;
    /*padding-bottom : 50px;*/
    margin-bottom: 50px;
    margin-left:20px;
    margin-right:20px;
    flex-basis: calc(33.33% - 40px); /* 한 줄에 3장씩 배치하되 오른쪽 여백을 제외 */
    box-sizing: border-box;
    text-align: center;
    box-shadow: 5px 5px 10px rgba(0, 0, 0, 0.5);
    overflow: visible; /* 추가된 속성 */
}

.card-container {
    padding-left : 0px;
    margin-left : 0px;
}
.card img {
    width: 100%; /* 카드의 너비에 이미지를 맞춥니다. */
    height: 400px; /* 이미지 비율을 유지하면서 높이를 조정합니다. */
    object-fit: cover;
    border-radius: 30px;
    margin-bottom: 10px;
    margin-top:10px;
    
       
      
       
}

.card::before { /*마스킹테이프*/
    content: "";
    position: absolute;
    top: -35px; /* 스티커의 위쪽으로 20px만큼 이동하여 튀어나옴 */
    left: -40px; /* 스티커의 왼쪽으로 20px만큼 이동하여 튀어나옴 */
    width: 175px; /* 스티커의 너비 */
    height: 80px; /* 스티커의 높이 */
    background-image: url('/resources/images/tape.png'); /* 스티커 이미지 파일 경로 */
    background-size: cover;
   
}

.page-content {
   padding-top : 0px;
   
}
.task-manager {
   display: flex;
  justify-content: space-between;
  width: 100%;
  height: 90vh;
  background: #fff;
  border-radius: 4px;
  box-shadow: 0 0.3px 2.2px rgba(0, 0, 0, 0.011), 0 0.7px 5.3px rgba(0, 0, 0, 0.016), 0 1.3px 10px rgba(0, 0, 0, 0.02), 0 2.2px 17.9px rgba(0, 0, 0, 0.024), 0 4.2px 33.4px rgba(0, 0, 0, 0.029), 0 10px 80px rgba(0, 0, 0, 0.04);
  overflow: hidden;
   margin-top: 75px;
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

.left-content {
  padding: 40px;
  margin-top: 0px;
  height: 100%; 
  display: flex;
  flex-direction: column;
}

.left-content {
  padding: 40px;
  margin-top: 0px;
  height: 100%; 
  display: flex;
  flex-direction: column;
  width : 229px;
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


.item span {
   font-size: 15px;
}

button {
  border: none;
  background: none;
  cursor: pointer;
  font-family :  sans-serif;
}
.profile-section {
  flex-shrink: 0; /* 이 부분은 .profile-section을 고정하는 역할을 합니다. */
  
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
</style>

</head>

<body style="width: 1358px;">
<div class="container">
   <div class="d-flex">
   
      <div style="width:50%;" class="check_wrap">
      <input type="checkbox" id="check_btn"/>
        <label for="check_btn"><span>내 다이어리 보기<img src="/resources/images/diaryIcon1.png" style="width:40px; height:40px;"></span></label>
      </div>

      <div class="ml-auto input-group" style="width:50%; margin-right: 150px" >
         <select name="_searchType" id="_searchType" class="custom-select" style="width:30px;">
            <option value="">조회 항목</option>
            <option value="1" <c:if test='${searchType eq "1"}'>selected</c:if>>다이어리 제목</option>
            <option value="2" <c:if test='${searchType eq "2"}'>selected</c:if>>다이어리 내용</option>
            <option value="3" <c:if test='${searchType eq "3"}'>selected</c:if>>닉네임</option>
            <option value="4" <c:if test='${searchType eq "4"}'>selected</c:if>>아이디</option>
            <option value="5" <c:if test='${searchType eq "5"}'>selected</c:if>>이름</option>
         </select>
         <input type="text" name="_searchValue" id="_searchValue" value="${searchValue}" class="form-control mx-1" maxlength="20" style="width:50px; ime-mode:active;" placeholder="어떤 다이어리를 찾을까요?" />
         <button type="button" id="btnSearch" class="btn mb-3 mx-1">조회
         <img src="/resources/images/search.png" style="width:25px; height:22px;"></button>
         <button type="button" id="btnWrite" class="btn mb-3">작성하기
         <img src="/resources/images/diaryWrite.png" style="width:25px; height:22px;"></button>
      </div>
    </div>

<div class="card-container">
   <c:if test="${!empty list}">      <!--list 객체가 비어있지 않을때 실행-->
      <c:forEach var="mainBoard" items="${list}">            
           <div class="card">
           <a href="javascript:void(0)" onclick="fn_view(${mainBoard.boardSeq})">
               <img src="/resources/upload/${mainBoard.fileName}" alt="noImage">
               <h2> <span class="highlight-text">${mainBoard.boardTitle}</span></h2>
               <p>${mainBoard.regDate}</p>
               <p>- ${mainBoard.userNickName} -</p>
           </a>
           </div>
           
           
      </c:forEach>
   </c:if>
</div>

   <nav >
      <ul class="pagination justify-content-center" style="width: 85%;" >
<c:if test="${!empty paging}">      
   <c:if test="${paging.prevBlockPage gt 0}">
         <li class="page-item"><a class="page-link" href="javascript:void(0)" onclick="fn_list(${paging.prevBlockPage}, myBoard)">이전블럭</a></li>
   </c:if>
   
   <c:forEach var="i" begin="${paging.startPage}" end="${paging.endPage}">
      <c:choose>
         <c:when test="${i ne curPage}">
         <li class="page-item"><a class="page-link" href="javascript:void(0)" onclick="fn_list(${i})">${i}</a></li>
            </c:when>
            <c:otherwise> <!-- otherwise:디폴트.모든조건이 거짓일 경우 실행 -->
         <li class="page-item active"><a class="page-link" href="javascript:void(0)" style="cursor:default;">${i}</a></li>
            </c:otherwise>
         </c:choose>
      </c:forEach>
      
      <c:if test="${paging.nextBlockPage gt 0}">
         <li class="page-item"><a class="page-link" href="javascript:void(0)" onclick="fn_list(${paging.nextBlockPage})">다음블럭</a></li>
   </c:if>
</c:if>
      </ul>
   </nav>
   
   <form name="bbsForm" id="bbsForm" method="post">
      <input type="hidden" name="boardSeq" value="" />
      <input type="hidden" name="searchType" value="${searchType}" />
      <input type="hidden" name="searchValue" value="${searchValue}" />
      <input type="hidden" name="curPage" value="${curPage}" />
      <input type="hidden" name="myBoard" value="<%= myBoard %>" />
   </form>
</div>
 
</body>
</html>