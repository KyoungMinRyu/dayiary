<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<%@ page import="com.icia.web.util.CookieUtil" %>
<%@ page import="com.icia.common.util.StringUtil" %>
<%!
String cookieIdd= "";
String cookieSellerIdd ="";
%>
<%
cookieIdd = CookieUtil.getHexValue(request, "USER_ID");
cookieSellerIdd = CookieUtil.getHexValue(request, "SELLER_ID");

if(cookieIdd != null && cookieIdd != "") 
{
   if(com.icia.common.util.StringUtil.equals(cookieIdd, "adm"))
   {
      cookieIdd = "adm"; 
   }
}

%>
<!DOCTYPE html>
<html>
<head>
<style>
@font-face {
    font-family: 'SUIT-Regular'; /* 고딕 */
    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_suit@1.0/SUIT-Regular.woff2') format('woff2');
    font-weight: 100;
    font-style: normal;
} 

@font-face {
    font-family: 'SUIT-Regular300'; /* 굵은 글씨*/
    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_suit@1.0/SUIT-Regular.woff2') format('woff2');
    font-weight: 300;
    font-style: normal;
} 

*
{
   font-family: 'SUIT-Regular', sans-serif;
}

body {
   
     background-color: #fffbf4 !important;
    background-size: cover; 
}

.bold {
    font-weight: bold;
    font-size:20px;
}

td{
    font-size:20px;
}

.container {

     background-color: rgba(255, 255, 255, 0.7) !important;   /* 게시판 테두리 투명도 */
     border-radius: 10px;                            /* 게시판 테두리 라운드 */
     padding-top: 30px;                               /* 게시판 내부내용 상단에서 띄우기 */
     padding-bottom: 10px;
     max-width: 1300px !important;
     max-height:650px;
     border: 1px solid black;
}

@keyframes blink-effect { 50% { opacity: 0; } } 
   .blink { 
    animation: blink-effect 2s step-end infinite; 
    /* 
        animation-name: blink-effect; 
        animation-duration: 2; 
        animation-iteration-count:infinite; 
        animation-timing-function:step-end; 
    */ 
}


footer {
   position:fixed;
    bottom: 0;
    width: 100%;
}




</style>
<%@ include file="/WEB-INF/views/include/head.jsp" %>
<script type="text/javascript">
$(document).ready(function() {
    
      $("#btnWrite").on("click", function() {
         document.bbsForm.bbsSeq.value = "";
         document.bbsForm.action = "/notice/noticeWriteForm";
         document.bbsForm.submit();
      });
      
      $("#btnSearch").on("click", function() {
         document.bbsForm.bbsSeq.value = "";
         document.bbsForm.searchType.value = $("#_searchType").val();
         document.bbsForm.searchValue.value = $("#_searchValue").val(); 
         document.bbsForm.curPage.value = "1";
         document.bbsForm.action = "/notice/adminNotice";
         document.bbsForm.submit();
      });
});


function fn_view(bbsSeq)
{   
   document.bbsForm.bbsSeq.value = bbsSeq;
   document.bbsForm.action = "/notice/noticeView";
   document.bbsForm.submit();
}

function fn_list(curPage)
{
   document.bbsForm.bbsSeq.value = "";
   document.bbsForm.curPage.value = curPage;   
   document.bbsForm.action = "/notice/adminNotice";
   document.bbsForm.submit();
}
</script>
</head>
<body>
<%
   if(com.icia.common.util.StringUtil.equals(cookieIdd, "adm"))
   {
%>
   <%@ include file="/WEB-INF/views/include/adminNavi.jsp" %>
<%
   }
   else
   {
%>
   <%@ include file="/WEB-INF/views/include/navigation.jsp" %>
<%
   }
%>

<div class="container" style="margin-top:150px">

   <div class="d-flex">
      <div style="width:50%;">
         <h1>공지사항</h1>
      </div>
      <div class="ml-auto input-group" style="width:50%;">
         <select name="_searchType" id="_searchType" class="custom-select" style="width:auto;">
            <option value="">조회 항목</option>
            <option value="1" <c:if test='${searchType eq "1"}'>selected</c:if>>제목</option>
            <option value="2" <c:if test='${searchType eq "2"}'>selected</c:if>>내용</option>
         </select>
         <input type="text" name="_searchValue" id="_searchValue" value="${searchValue}" class="form-control mx-1" maxlength="20" style="width:auto;ime-mode:active;" placeholder="조회값을 입력하세요." />
         <button type="button" id="btnSearch" class="btn btn-secondary mb-3 mx-1">조회</button>
      </div>
    </div>
    
   <div style="overflow: auto; max-height: 400px;">
      <table class="table table-hover">
         <thead>
         <tr style="background-color: #dee2e6; font-size:20px;">
            <th scope="col" class="text-center" style="width:10%"></th>
            <th scope="col" class="text-center" style="width:55%">제목</th>
            <th scope="col" class="text-center" style="width:10%">작성자</th>
            <th scope="col" class="text-center" style="width:15%">작성일</th>
         </tr>
         </thead>
         <tbody>
       
      <c:if test="${!empty list}">
          <c:forEach var="adminNotice" items="${list}" varStatus="status">        
              <tr>   
                  <c:choose>
                      <c:when test="${adminNotice.status eq 'Y'}">
                          <td class="text-center"><img src="../resources/images/notice.png" style="width: 25px; height: 25px;" class="blink"></td>
                          <td class="bold">
                              <a href="javascript:void(0)" onclick="fn_view(${adminNotice.bbsSeq})">  
                                  ${adminNotice.bbsTitle}
                              </a>
                          </td>
                      </c:when>
                      <c:otherwise>
                          <td class="text-center"></td>
                          <td>
                              <a href="javascript:void(0)" onclick="fn_view(${adminNotice.bbsSeq})"  style="color:black !important;">  
                                  ${adminNotice.bbsTitle}
                              </a>
                          </td>
                      </c:otherwise>
                  </c:choose>
                  <td class="text-center">${adminNotice.userName}</td>
                  <td class="text-center">${adminNotice.regDate.substring(0,10)}</td>
              </tr>
          </c:forEach>
      </c:if>

         </tbody>
         <tfoot>
         <tr>
               <td colspan="5"></td>
           </tr>
         </tfoot>
      </table>
   </div>
   
   <nav>
      <ul class="pagination justify-content-center">
<c:if test="${!empty paging}">      
   <c:if test="${paging.prevBlockPage gt 0}">   
         <li class="page-item"><a class="page-link" href="javascript:void(0)" onclick="fn_list(${paging.prevBlockPage})">◁이전</a></li>
   </c:if>
   
   <c:forEach var="i" begin="${paging.startPage}" end="${paging.endPage}"> 
      <c:choose>
      <c:when test="${i ne curPage}">   <!-- ne는 같지 않을때 의미 -->
         <li class="page-item"><a class="page-link" href="javascript:void(0)" onclick="fn_list(${i})">${i}</a></li> 
        </c:when>                                                         
        <c:otherwise> 
         <li class="page-item active"><a class="page-link" href="javascript:void(0)" style="cursor:default;">${i}</a></li>
      </c:otherwise>
      </c:choose>
   </c:forEach>
      <c:if test="${paging.nextBlockPage gt 0}">
         <li class="page-item"><a class="page-link" href="javascript:void(0)" onclick="fn_list(${paging.nextBlockPage})">다음▷</a></li>
   </c:if>
</c:if>
      </ul>
   </nav>
   
   <c:if test="${user.userId eq 'adm'}" >
   <button type="button" id="btnWrite" class="btn btn-secondary mb-3">공지글 작성</button>
   </c:if>
   
   <form name="bbsForm" id="bbsForm" method="post">
      <input type="hidden" name="bbsSeq" value="" />
      <input type="hidden" name="searchType" value="${searchType}" />
      <input type="hidden" name="searchValue" value="${searchValue}" />
      <input type="hidden" name="curPage" value="${curPage}" />
   </form>
</div>
<footer style="background-color: black; color: lightgray; text-align: center; margin-top:80px; padding: 30px;">
 <a style="font-size:20px; letter-spacing:5px;">《 Dayiary 》 </a> <br>
    &copy; Copyright Dayiary Corp. All Rights Reserved. <br>
    Always with you 🎉 여러분의 일상을 함께합니다.
</footer> 
</body>
</html>