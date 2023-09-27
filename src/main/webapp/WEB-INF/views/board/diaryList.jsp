<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<%@ page import="com.icia.web.util.CookieUtil" %>
<%@ page import="com.icia.common.util.StringUtil" %>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" type="text/css" href="/resources/css/diaryList.css">
<%@ include file="/WEB-INF/views/include/head.jsp" %>
<script type="text/javascript">

<% String cookieUserId = CookieUtil.getHexValue(request, "USER_ID");
   String myBoard = (String)request.getAttribute("myBoard");
%>

$(document).ready(function() {
     
    <% if(StringUtil.equals(myBoard, "1")) { %>
 
         $("#check_btn").prop("checked", true);
         
     <% } %>    
   
   //글쓰기 버튼 눌렀을때
   $("#btnWrite").on("click", function() {
      document.bbsForm.boardSeq.value = "";
      document.bbsForm.action = "/board/diaryWrite";
      document.bbsForm.submit();
   }); 
   
   //조회버튼 눌렀을때
   $("#btnSearch").on("click", function() { 
      document.bbsForm.boardSeq.value = "";
      document.bbsForm.searchType.value = $("#_searchType").val();
      document.bbsForm.searchValue.value = $("#_searchValue").val();
      document.bbsForm.curPage.value = "1";
      document.bbsForm.action = "/board/diaryList";
      document.bbsForm.submit();
   });
   
   //내 다이어리 보기 클릭했을때
   $("#check_btn").on("change", function() {
       var checkbox = $(this);
       var resultElement = $("#result");

       if (checkbox.prop("checked")) 
       {
         // 내 다이어리 보기 체크박스 체크 시
          document.bbsForm.boardSeq.value = "";
         document.bbsForm.searchType.value = "4";
         document.bbsForm.searchValue.value = "<%= cookieUserId %>";
         document.bbsForm.curPage.value = "1";
         document.bbsForm.myBoard.value = "1";
         document.bbsForm.action = "/board/diaryList";
         document.bbsForm.submit();
       } 
       else 
       {
          // 내 다이어리 보기 체크박스 해제시
          document.bbsForm.boardSeq.value = "";
         document.bbsForm.searchType.value = "";
         document.bbsForm.searchValue.value = "";
         document.bbsForm.curPage.value = "1";
         document.bbsForm.myBoard.value = "2";
         document.bbsForm.action = "/board/diaryList";
         document.bbsForm.submit();
       }
     });
   
});

function fn_view(boardSeq)
{
   document.bbsForm.boardSeq.value = boardSeq;
   document.bbsForm.action = "/board/diaryView";
   document.bbsForm.submit();
}

function fn_list(curPage)
{
   document.bbsForm.boardSeq.value = "";
   document.bbsForm.curPage.value = curPage;
   document.bbsForm.action = "/board/diaryList";
   document.bbsForm.submit();
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
   height: 200px;
   background-image: url('/resources/images/cal.jpg');
   background-repeat: no-repeat;
   background-size: cover;
   background-position: center center;
   margin-top:75px;
}


</style>

</head>

<body>

<%@ include file="/WEB-INF/views/include/navigation.jsp" %>



<div class="container" style="margin-top:160px; height: 1650px;">
   <div class="d-flex">
   
      <div style="width:70%;" class="check_wrap">
      <input type="checkbox" id="check_btn"/>
        <label for="check_btn"><span>내 다이어리 보기<img src="/resources/images/diaryIcon1.png" style="width:40px; height:40px;"></span></label>
      </div>

      <div class="ml-auto input-group" style="width:50%;">
         <select name="_searchType" id="_searchType" class="custom-select" style="width:auto;">
            <option value="">조회 항목</option>
            <option value="1" <c:if test='${searchType eq "1"}'>selected</c:if>>다이어리 제목</option>
            <option value="2" <c:if test='${searchType eq "2"}'>selected</c:if>>다이어리 내용</option>
            <option value="3" <c:if test='${searchType eq "3"}'>selected</c:if>>닉네임</option>
            <option value="4" <c:if test='${searchType eq "4"}'>selected</c:if>>아이디</option>
            <option value="5" <c:if test='${searchType eq "5"}'>selected</c:if>>이름</option>
         </select>
         <input type="text" name="_searchValue" id="_searchValue" value="${searchValue}" class="form-control mx-1" maxlength="20" style="width:auto;ime-mode:active;" placeholder="어떤 다이어리를 찾을까요?" />
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
               <img src="/resources/upload/${mainBoard.fileName}" alt="해당이미지가 upload폴더에 없으면 보이지 않습니다">
               <h2> <span class="highlight-text">${mainBoard.boardTitle}</span></h2>
               <p>${mainBoard.regDate}</p>
               <p>- ${mainBoard.userNickName} -</p>
           </a>
           </div>
           
           
      </c:forEach>
   </c:if>
</div>

   <nav style="padding-top:40px;">
      <ul class="pagination justify-content-center">
<c:if test="${!empty paging}">      
   <c:if test="${paging.prevBlockPage gt 0}">
         <li class="page-item"><a class="page-link" href="javascript:void(0)" onclick="fn_list(${paging.prevBlockPage})">이전블럭</a></li>
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
<footer style="background-color: black; color: lightgray; text-align: center; margin-top:80px; padding: 40px;">
 <a style="font-size:20px; letter-spacing:5px;">《 Dayiary 》 </a> <br>
    &copy; Copyright Dayiary Corp. All Rights Reserved. <br>
    Always with you 🎉 여러분의 일상을 함께합니다.
</footer> 
</body>
</html>