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
<%
   // 개행문자(줄바꿈문자) 값을 저장한다.
   pageContext.setAttribute("newLine", "\n");
%>
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
html
{
   height: 100%;
}

*
{
   font-family: 'SUIT-Regular', sans-serif;
}


body {
   
     background-color: #fffbf4;   
}
.container {

     background-color: rgba(255, 255, 255, 0.7) !important;   /* 게시판 테두리 투명도 */
     border-radius: 10px;                            /* 게시판 테두리 라운드 */
     padding-top: 30px;   
     max-width: 1300px !important;
     margin-bottom:80px;
}

pre {
    word-wrap: break-word; /* 줄바꿈 처리 */
    white-space: pre-wrap; /* 공백 처리 */
    font-family: 'SUIT-Regular', sans-serif;
    max-width: 100%; /* 최대 너비 설정 */
    overflow-x: auto; /* 내용이 넘칠 경우 스크롤 표시 */
}

footer {
    bottom: 0;
    width: 100%;
    height: auto;
}

</style>
<script type="text/javascript">
$(document).ready(function() {

   $("#btnList").on("click", function() {
      document.bbsForm.action = "/notice/adminNotice";
      document.bbsForm.submit();
   });

   $("#btnUpdate").on("click", function() {
      document.bbsForm.action = "/notice/noticeUpdateForm";   
      document.bbsForm.submit();
   });
   
   $("#btnDelete").on("click", function() {   
      if(confirm("공지글을 삭제하시겠습니까?") == true)      //브라우저상 yes눌렀을 시 true!      
      {
        $.ajax({
           type:"POST",
           url:"/notice/delete",
           data:{
              bbsSeq:<c:out value="${bbsSeq}" />
           },
           datatype:"JSON",
           beforeSend:function(xhr)
           {
              xhr.setRequestHeader("AJAX", "true");
           },
           success:function(response)
           {
              if(response.code == 0)
              {
                 alert("공지글이 삭제되었습니다.");
                 location.href = "/notice/adminNotice";
              }
              else if(response.code == 400)
              {
                 alert("입력 값이 올바르지 않습니다.");
              }
              else if(response.code == 404)
              {
                 alert("해당 공지글을 찾을 수 없습니다.");
                 location.href = "/notice/adminNotice";
              }   
              else
              {
                 alert("공지글 삭제시 오류가 발생하였습니다.");
              }
           },
           error:function(xhr, status, error)
           {
              icia.common.error(error);
           }
        }); 
      }
   });
   
});
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
   <h1>공지사항</h1>
   <div class="row" style="margin-right:0; margin-left:0;">
      <table class="table">
         <thead>
            <tr class="table-active">
              <th scope="col" style="width:60%; font-weight: bold; font-size: 25px; padding-bottom:20px;">
                  <c:out value="${adminNotice.bbsTitle}" />
           </th>
           <th scope="col" style="width:40%; text-align: right;">
             <div style="float: right; font-size:20px;">
                 작성자&nbsp;&nbsp;:&nbsp;&nbsp;&nbsp;<c:out value="${adminNotice.userName}" />
                 <img src="../resources/images/MGR.png" style="width: 35px; height: 25px; padding-bottom: 3px;"class="blink"></br>
                 작성일&nbsp;&nbsp;:&nbsp;&nbsp;&nbsp;<c:out value="${adminNotice.regDate}" />                     
             </div>
           </th>
            </tr>
         </thead>
         <tbody>
            <tr style="font-size: 25px; height:500px;">
               <td colspan="2"><pre><c:out value="${adminNotice.bbsContent}" /></pre></td>
            </tr>
         </tbody>
         <tfoot>
         <tr>
               <td colspan="2"></td>
           </tr>
         </tfoot>
      </table>
   </div>
   
   <button type="button" id="btnList" class="btn btn-secondary">목록</button>
<c:if test="${noticeAdmin eq 'Y'}">  
   <button type="button" id="btnUpdate" class="btn btn-secondary">수정</button>
   <button type="button" id="btnDelete" class="btn btn-secondary">삭제</button>
</c:if>   
   <br/>
   <br/>
</div>

<form name="bbsForm" id="bbsForm" method="post">
   <input type="hidden" name="bbsSeq" value="${bbsSeq}" />
   <input type="hidden" name="searchType" value="${searchType}" />
   <input type="hidden" name="searchValue" value="${searchValue}" />
   <input type="hidden" name="curPage" value="${curPage}" />
</form>
<footer style="background-color: black; color: lightgray; text-align: center; margin-top:80; padding: 30px;">
 <a style="font-size:20px; letter-spacing:5px;">《 Dayiary 》 </a> <br>
    &copy; Copyright Dayiary Corp. All Rights Reserved. <br>
    Always with you 🎉 여러분의 일상을 함께합니다.
</footer> 
</body>
</html>