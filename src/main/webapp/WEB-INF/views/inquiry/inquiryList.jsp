<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ page import="com.icia.web.util.CookieUtil" %>
<%@ page import="com.icia.common.util.StringUtil" %>
<%!
String cookieIdd= null;
String cookieSellerIdd = null;
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

*
{
   font-family: 'SUIT-Regular', sans-serif;
}
body {
   
     background-color: #fffbf4 !important;
     display: flex;
    flex-direction: column;
}

html {
height : 100%;
}

footer {
   position:fixed;
    bottom: 0;
    width: 100%;
}


.bold {

    font-weight: bold;
}

.container {

     background-color: rgba(255, 255, 255, 0.7) !important;   /* 게시판 테두리 투명도 */
     border-radius: 10px;                            /* 게시판 테두리 라운드 */
     padding-top: 30px;                               /* 게시판 내부내용 상단에서 띄우기 */
     padding-bottom: 10px;
     max-width: 1300px !important;
     font-size:18px;
     margin-bottom:80px;
     flex: 1;
     height: auto;
     border: 1px solid black;
}



</style>
<%@ include file="/WEB-INF/views/include/head.jsp" %>
<script>

$(document).ready(function() {

   
      $("#btnWrite").on("click", function() {
         document.bbsForm.qnaSeq.value = "";
         document.bbsForm.action = "/inquiry/inquiryWriteForm";
         document.bbsForm.submit();
      });
   
   
      $("#btnSearch").on("click", function() {
         document.bbsForm.qnaSeq.value = "";
         document.bbsForm.searchCategory.value = $("#_searchCategory").val();
         document.bbsForm.searchType.value = $("#_searchType").val();
         document.bbsForm.searchValue.value = $("#_searchValue").val(); 
         document.bbsForm.curPage.value = "1";
         document.bbsForm.action = "/inquiry/inquiryList";
         document.bbsForm.submit();
      });
   });

function fn_view(qnaSeq, orderGubun, userId)
{
         document.bbsForm.qnaSeq.value = qnaSeq;
         document.bbsForm.orderGubun.value = orderGubun;
         document.bbsForm.userId.value = userId;
         document.bbsForm.action = "/inquiry/inquiryView";
         document.bbsForm.submit();
}
   
function fn_list(curPage)
{
         document.bbsForm.qnaSeq.value = "";
         document.bbsForm.curPage.value = curPage;
         document.bbsForm.action = "/inquiry/inquiryList";
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
<div class="container" style="margin-top:150px;">
   <div class="d-flex">
      <div style="width:50%;">
         <h1>문의사항</h1>   
      </div>
<%
   if(cookieIdd != null)
   {
%>
      <div class="ml-auto input-group" style="width:50%;">
         <select id="_searchCategory" name="_searchCategory" class="custom-select" style="width:auto;">
               <option value="">카테고리 항목</option>
               <option value="0" >사전문의</option>
               <option value="1" <c:if test="${searchCategory == 'R'}">selected</c:if>>예약</option>
              <option value="2" <c:if test="${searchCategory == 'P'}">selected</c:if>>선물</option>
        </select></br>

        <select name="_searchType" id="_searchType" class="custom-select" style="width:auto;">
                 <option value="">조회 항목</option>
               <option value="1" <c:if test='${searchType eq "1" and inquiryBoard.qnaIndent == 0}'>selected</c:if>>제목</option>
               <option value="2" <c:if test='${searchType eq "2" and inquiryBoard.qnaIndent == 0}'>selected</c:if>>내용</option>
        </select>
         
        <input type="text" name="_searchValue" id="_searchValue" value="${searchValue}" class="form-control mx-1" maxlength="20" style="width:auto;ime-mode:active;" placeholder="조회값을 입력하세요." />
        <button type="button" id="btnSearch" class="btn btn-secondary mb-3 mx-1">조회</button>
      </div>
    </div>
    
   <table class="table table-hover">
     <thead>
         <tr style="background-color: #dee2e6;">
             <th scope="col" class="text-center" style="width:10%">카테고리</th>
            <th scope="col" class="text-center" style="width:15%">답변상태</th>
            <th scope="col" class="text-center" style="width:40%">문의글 제목</th>
            <th scope="col" class="text-center" style="width:20%">작성자</th>
            <th scope="col" class="text-center" style="width:25%">작성일</th>
         </tr>
      </thead>
   
        <tbody>
        <c:if test="${!empty list}">
           <c:forEach var="inquiryBoard" items="${list}" varStatus="status">      
             <tr>
             <c:set var="gubun2" value="${fn:substring(inquiryBoard.qnaTitle, 0, 5)}"/> 
            <c:choose>
               <c:when test="${(gubun2 eq '[구매전]' or gubun2 eq '[예약전]') and inquiryBoard.qnaIndent == 0}">
                <td class="text-center"><strong style="font-weight: bold;">[사전문의]</strong></td>
              </c:when>
              <c:when test="${(gubun2 eq '[구매전]' or gubun2 eq '[예약전]') and inquiryBoard.qnaIndent > 0}">
                <td class="text-center"></td>
              </c:when>
              <c:when test="${fn:contains(inquiryBoard.rSeq, 'R') and inquiryBoard.qnaIndent == 0}">
                 <td class="text-center"><strong style="font-weight: bold;">[예약]</strong></td>
              </c:when>
              <c:when test="${fn:contains(inquiryBoard.rSeq, 'R') and inquiryBoard.qnaIndent > 0}">
                 <td class="text-center"></td>
              </c:when>
              <c:when test="${fn:contains(inquiryBoard.productSeq, 'P') and inquiryBoard.qnaIndent == 0}">
                <td class="text-center"><strong style="font-weight: bold;">[선물]</strong></td>
              </c:when>
              <c:when test="${fn:contains(inquiryBoard.productSeq, 'P') and inquiryBoard.qnaIndent > 0}">
                <td class="text-center"></td>
              </c:when>
            </c:choose>
             
         <c:if test="${inquiryBoard.replyStatus eq 'N'}" >
           <c:choose>
             <c:when test="${inquiryBoard.qnaIndent == 0}" >
               <td class="text-center">[답변대기중]</td>
             </c:when>
             <c:when test="${inquiryBoard.qnaIndent > 0}" >
               <td class="text-center"></td>
             </c:when>
           </c:choose>
          </c:if>   
            <c:if test="${inquiryBoard.replyStatus eq 'Y'}" >
           <c:choose>
             <c:when test="${inquiryBoard.qnaIndent == 0}" >
                 <td class="text-center">[답변완료]</td>
              </c:when>
              <c:when test="${inquiryBoard.qnaIndent > 0}" >
                <td class="text-center"></td>
             </c:when>
            </c:choose> 
            </c:if>
             
           <td> 
            <a href="javascript:void(0)" onclick="fn_view(${inquiryBoard.qnaSeq}, '${inquiryBoard.orderGubun}', '${inquiryBoard.userId}')">
             <c:if test="${inquiryBoard.qnaIndent > 0}">
              <img src="/resources/images/icon_reply.png" style="margin-left:${inquiryBoard.qnaIndent}em; width: 25px; height: 25px;" class="blink">
             </c:if>      
           <c:out value="${inquiryBoard.qnaTitle}" />
          </a>
          </td>
    
           
            <c:choose>
              <c:when test="${inquiryBoard.qnaIndent % 2 eq 0}">
                 <td class="text-center">${inquiryBoard.userName}</td>
            </c:when>
              <c:when test="${fn:contains(inquiryBoard.rSeq, 'R') and (inquiryBoard.qnaIndent % 2 eq 1)}" >
               <td class="text-center">${inquiryBoard.orderedName}</td>
               </c:when>
                <c:when test="${fn:contains(inquiryBoard.productSeq, 'P') and (inquiryBoard.qnaIndent % 2 eq 1)}" >
              <td class="text-center">${inquiryBoard.orderedName} 판매자</td>
             </c:when>
             </c:choose>
         
         
            <td class="text-center">${inquiryBoard.regDate.substring(0,10)}</td>
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

   <nav>
     <ul class="pagination justify-content-center">
        <c:if test="${!empty paging}">   
         <c:if test="${paging.prevBlockPage gt 0}">        
          <li class="page-item"><a class="page-link" href="javascript:void(0)" onclick="fn_list(${paging.prevBlockPage})" title="이전 블럭">&laquo;</a></li>
          </c:if>
         <c:forEach var="i" begin="${paging.startPage}" end="${paging.endPage}">
         <c:choose>  
          <c:when test="${i ne curPage}">
            <li class="page-item"><a class="page-link" href="javascript:void(0)" onclick="fn_list(${i})">${i}</a></li>
        </c:when>
        <c:otherwise>
            <li class="page-item active"><a class="page-link" href="javascript:void(0)" style="cursor:default;">${i}</a></li>
        </c:otherwise>
       </c:choose>
       </c:forEach>
       <c:if test="${paging.nextBlockPage gt 0}">          
            <li class="page-item"><a class="page-link" href="javascript:void(0)" onclick="fn_list(${paging.nextBlockPage})" title="다음 블럭">&raquo;</a></li>
        </c:if>
       </c:if>   
     </ul>
   </nav>
<%
   }
   else if(cookieSellerIdd != null)
   {
%>  
    <div class="ml-auto input-group" style="width:50%;">
         <select id="_searchCategory" name="_searchCategory" class="custom-select" style="width:auto;">
               <option value="">카테고리 항목</option>
               <option value="0" >사전문의</option>
               <option value="1" <c:if test="${searchCategory == 'R'}">selected</c:if>>예약</option>
              <option value="2" <c:if test="${searchCategory == 'P'}">selected</c:if>>선물</option>
        </select></br>

         <select name="_searchType" id="_searchType" class="custom-select" style="width:auto;">
            <option value="">조회 항목</option>
            <option value="1" <c:if test='${searchType eq "1" and inquiryBoard.qnaIndent == 0}'>selected</c:if>>제목</option>
            <option value="2" <c:if test='${searchType eq "2" and inquiryBoard.qnaIndent == 0}'>selected</c:if>>내용</option>
         </select>
         
         <input type="text" name="_searchValue" id="_searchValue" value="${searchValue}" class="form-control mx-1" maxlength="20" style="width:auto;ime-mode:active;" placeholder="조회값을 입력하세요." />
         <button type="button" id="btnSearch" class="btn btn-secondary mb-3 mx-1">조회</button>
    </div>

    
   <table class="table table-hover">
     <thead>
      <tr style="background-color: #dee2e6;">
          <th scope="col" class="text-center" style="width:10%">카테고리</th>
         <th scope="col" class="text-center" style="width:15%">답변상태</th>
         <th scope="col" class="text-center" style="width:45%">문의글 제목</th>
         <th scope="col" class="text-center" style="width:20%">작성자</th>
         <th scope="col" class="text-center" style="width:25%">작성일</th>
      </tr>
     </thead>
     
     <tbody>
      <c:if test="${!empty list}">
      <c:forEach var="inquiryBoard" items="${list}" varStatus="status">      
       <tr>
        <c:set var="gubun2" value="${fn:substring(inquiryBoard.qnaTitle, 0, 5)}"/> 
        <c:choose>
         <c:when test="${(gubun2 eq '[구매전]' or gubun2 eq '[예약전]') and inquiryBoard.qnaIndent == 0}">
           <td class="text-center"><strong style="font-weight: bold;">[사전문의]</strong></td>
        </c:when>
        <c:when test="${(gubun2 eq '[구매전]' or gubun2 eq '[예약전]') and inquiryBoard.qnaIndent > 0}">
           <td class="text-center"></td>
        </c:when>
        <c:when test="${fn:contains(inquiryBoard.rSeq, 'R') and inquiryBoard.qnaIndent == 0}">
            <td class="text-center"><strong style="font-weight: bold;">[예약]</strong></td>
        </c:when>
        <c:when test="${fn:contains(inquiryBoard.rSeq, 'R') and inquiryBoard.qnaIndent > 0}">
            <td class="text-center"></td>
        </c:when>
        <c:when test="${fn:contains(inquiryBoard.productSeq, 'P') and inquiryBoard.qnaIndent == 0}">
           <td class="text-center"><strong style="font-weight: bold;">[선물]</strong></td>
        </c:when>
        <c:when test="${fn:contains(inquiryBoard.productSeq, 'P') and inquiryBoard.qnaIndent > 0}">
           <td class="text-center"></td>
        </c:when>
       </c:choose>
     
        <c:if test="${inquiryBoard.replyStatus eq 'N'}" >
        <c:choose>
          <c:when test="${inquiryBoard.qnaIndent == 0}" >
             <td class="text-center">[답변대기중]</td>
          </c:when>
          <c:when test="${inquiryBoard.qnaIndent > 0}" >
             <td class="text-center"></td>
          </c:when>
         </c:choose>
        </c:if>   
        <c:if test="${inquiryBoard.replyStatus eq 'Y'}" >
        <c:choose>
          <c:when test="${inquiryBoard.qnaIndent == 0}" >
             <td class="text-center">[답변완료]</td>
          </c:when>
          <c:when test="${inquiryBoard.qnaIndent > 0}" >
             <td class="text-center"></td>
          </c:when>
         </c:choose> 
        </c:if>
        
        <td> 
         <a href="javascript:void(0)" onclick="fn_view(${inquiryBoard.qnaSeq}, '${inquiryBoard.orderGubun}', '${inquiryBoard.userId}')">
          <c:if test="${inquiryBoard.qnaIndent > 0}">
            <img src="/resources/images/icon_reply.png" style="margin-left:${inquiryBoard.qnaIndent}em; width: 25px; height: 25px;" class="blink">
          </c:if>      
        <c:out value="${inquiryBoard.qnaTitle}" />
       </a>
       </td>
    
       <c:choose>
       <c:when test="${inquiryBoard.qnaIndent % 2 eq 0}">
            <td class="text-center">${inquiryBoard.userName}</td>
       </c:when>
       <c:when test="${fn:contains(inquiryBoard.rSeq, 'R') and inquiryBoard.qnaIndent % 2 eq 1}">
          <td class="text-center">${inquiryBoard.orderedName}</td>
       </c:when>
       <c:when test="${fn:contains(inquiryBoard.productSeq, 'P') and inquiryBoard.qnaIndent % 2 eq 1}">
          <td class="text-center">${inquiryBoard.orderedName} 판매자</td>
       </c:when>
      </c:choose>
        
       <td class="text-center">${inquiryBoard.regDate.substring(0,10)}</td>
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
   
   <nav>
      <ul class="pagination justify-content-center">
       <c:if test="${!empty paging}">   
        <c:if test="${paging.prevBlockPage gt 0}">        
           <li class="page-item"><a class="page-link" href="javascript:void(0)" onclick="fn_list(${paging.prevBlockPage})" title="이전 블럭">&laquo;</a></li>
        </c:if>
      
        <c:forEach var="i" begin="${paging.startPage}" end="${paging.endPage}">
         <c:choose>  
          <c:when test="${i ne curPage}">
             <li class="page-item"><a class="page-link" href="javascript:void(0)" onclick="fn_list(${i})">${i}</a></li>
        </c:when>
        <c:otherwise>
             <li class="page-item active"><a class="page-link" href="javascript:void(0)" style="cursor:default;">${i}</a></li>
        </c:otherwise>
       </c:choose>
       </c:forEach>
       <c:if test="${paging.nextBlockPage gt 0}">          
             <li class="page-item"><a class="page-link" href="javascript:void(0)" onclick="fn_list(${paging.nextBlockPage})" title="다음 블럭">&raquo;</a></li>
        </c:if>
       </c:if>   
      </ul>
   </nav>
<%
   }
   if(!StringUtil.equals(cookieIdd, "adm") && StringUtil.isEmpty(cookieSellerIdd))
   {
%>
   <button type="button" id="btnWrite" class="btn btn-secondary mb-3">문의글 쓰기</button>
<%
   }   
%>
   <form name="bbsForm" id="bbsForm" method="post">
      <input type="hidden" name="qnaSeq" value="" />
      <input type="hidden" name="orderGubun" value="" />
      <input type="hidden" name="userId" value="" />
      <input type="hidden" name="searchCategory" value="${searchCategory}" />
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