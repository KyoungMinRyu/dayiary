<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
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
<%
   // 개행문자 값을 저장한다.
   pageContext.setAttribute("newLine", "\n");
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
}

.bold {

    font-weight: bold;
}

.container {

     background-color: rgba(255, 255, 255, 0.7) !important;   /* 게시판 테두리 투명도 */
     border-radius: 10px;                            /* 게시판 테두리 라운드 */
     padding-top: 30px;                               /* 게시판 내부내용 상단에서 띄우기 */
     max-width: 1300px !important;
     padding-bottom: 10px;
     font-size: 18px;
}

.table-active, .table-active>td, .table-active>th 
{
    background-color: rgb(255 240 87 / 3%) !important;
}

.form-control:disabled, .form-control[readonly] {
    background-color: #ffffff !important;
}


<c:if test="${empty inquiryBoard.inquiryBoardFile}">

footer {
  
  position : fixed;
  bottom : 0;
  width : 100%;
   
}

</c:if>
</style>
<%@ include file="/WEB-INF/views/include/head.jsp" %>
<script type="text/javascript">
$(document).ready(function() {
   
      var cookieIdd = document.getElementById("cookieIdd").value;
      var cookieSellerIdd = document.getElementById("cookieSellerIdd").value;
      var userId = "${inquiryBoard.userId}";
      //alert("================== " + "${inquiryBoard.userId}");
      var qnaSeq = "${qnaSeq}";
      //alert("================== " + "${qnaSeq}");
       //alert("===========" + "${inquiryBoard.qnaTitle}");
       var beforeQnaTitle = "${inquiryBoard.qnaTitle}";   
         //alert("================== " + beforeQnaTitle);
       var orderGubun = "${orderGubun}";
       
   $("#btnList").on("click", function() {
       document.bbsForm.action = "/inquiry/inquiryList";
       document.bbsForm.submit();
   });
   
   $("#btnReply").on("click", function() {
       document.bbsForm.action = "/inquiry/inquiryReplyForm";
       document.bbsForm.userId.value = userId;
       document.bbsForm.qnaSeq.value = qnaSeq;
       document.bbsForm.beforeQnaTitle.value = beforeQnaTitle;
       document.bbsForm.submit();   
   });
   

   $("#btnUpdate").on("click", function() {
       document.bbsForm.action = "/inquiry/inquiryUpdateForm";
       document.bbsForm.userId.value = userId;
       document.bbsForm.qnaSeq.value = qnaSeq;
         document.bbsForm.submit();
  
   });
   
   $("#btnDelete").on("click", function() 
   {   
      if(confirm("문의글을 삭제하시겠습니까") == true)      //브라우저상 yes눌렀을 시 true!      
      {
        $.ajax({
           type:"POST",
           url:"/inquiry/inquiryDelete",
           data:{
              qnaSeq:<c:out value="${qnaSeq}" />,
              orderGubun: orderGubun,
               userId: userId
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
                 alert("문의글이 삭제되었습니다.");
                 location.href = "/inquiry/inquiryList";
              }
              else if(response.code == 400)
              {
                 alert("입력 값이 올바르지 않습니다.");
              }
              else if(response.code == 403)
              {
                 alert("본인 글이 아니므로 삭제할 수 없습니다.");
              }
              else if(response.code == 404)
              {
                 alert("해당 문의글을 찾을 수 없습니다.");
                 location.href = "/inquiry/inquiryList";
              }
              else if(response.code == -999)
              {
                 alert("답변 문의글이 존재하여 삭제할 수 없습니다.");
              }
              else
              {
                 alert("문의글 삭제시 오류가 발생하였습니다.");
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
   <h1>문의사항</h1>
     <div class="row" style="margin-right:0; margin-left:0;">
      <table class="table">
        <thead>
            <tr class="table-active">
              <th scope="col" style="width:60%;">
            <c:set var="gubun" value="${fn:substring(inquiryBoard.orderedSeq, 0, 1)}"/>
            <c:set var="gubun2" value="${fn:substring(inquiryBoard.qnaTitle, 0, 5)}"/>
            <div>
             <c:choose>
              <c:when test="${gubun eq 'R'}">
                <c:choose>
                 <c:when test="${gubun2 ne '[예약전]'}">
                    <input type="text" name="afterReserv" id="afterReserv" maxlength="20" value="【식당명 : ${inquiryBoard.orderedName} 　　예약번호 : ${inquiryBoard.orderSeq}　　작성일 : ${inquiryBoard.regDate}】" style="ime-mode:active; margin-top: 2px !important; font-weight: bold;" class="form-control mt-4 mb-2" readonly />
                 </c:when>
                 <c:when test="${gubun2 eq '[예약전]'}">
                    <input type="text" name="beforeReserv" id="beforeReserv" maxlength="20" value="【식당명 : ${inquiryBoard.orderedName} 　　식당번호 : ${inquiryBoard.orderedSeq}　　작성일 : ${inquiryBoard.regDate}】" style="ime-mode:active; margin-top: 2px !important; font-weight: bold;" class="form-control mt-4 mb-2" readonly />
                 </c:when>
                </c:choose>
               </c:when>
              <c:when test="${gubun eq 'P'}">
                <c:choose>
                 <c:when test="${gubun2 ne '[구매전]'}">
                    <input type="text" name="afterBuy" id="afterBuy" maxlength="20" value="【상품명: ${inquiryBoard.orderedName} 　　주문번호: ${inquiryBoard.orderSeq}　　작성일 : ${inquiryBoard.regDate}】" style="ime-mode:active; margin-top: 2px !important; font-weight: bold;" class="form-control mt-4 mb-2" readonly />
                 </c:when>
                 <c:when test="${gubun2 eq '[구매전]'}">
                   <input type="text" name="beforeBuy" id="beforeBuy" maxlength="20" value="【상품명: ${inquiryBoard.orderedName} 　　상품번호: ${inquiryBoard.orderedSeq}　　작성일 : ${inquiryBoard.regDate}】" style="ime-mode:active; margin-top: 2px !important; font-weight: bold;" class="form-control mt-4 mb-2" readonly />
                 </c:when>
                </c:choose>
              </c:when>
             </c:choose>
            </div>       
           
           <div id="Writer" style="margin-top:-15px !important;">
               <c:if test="${inquiryBoard.qnaIndent % 2 eq 0}" >      
                   <input type="text" name="userName" id="userName" maxlength="20" value="작성자 : ${inquiryBoard.userName}" style="ime-mode:active;  font-weight: bold;" class="form-control mt-4 mb-2" placeholder="이름을 입력해주세요." readonly />
              </c:if>
              <c:if test="${inquiryBoard.qnaIndent % 2 eq 1}" >
                <c:choose>
                <c:when test="${gubun eq 'R'}">
                      <input type="text" name="RestoName" id="RestoName" maxlength="20" value="작성자: ${inquiryBoard.orderedName}" style="ime-mode:active;  font-weight: bold;" class="form-control mt-4 mb-2" placeholder="이름을 입력해주세요." readonly />
               </c:when>
               <c:when test="${gubun eq 'P'}">
                     <input type="text" name="ProductName" id="ProductName" maxlength="20" value="작성자: ${inquiryBoard.orderedName} 판매자" style="ime-mode:active;  font-weight: bold;" class="form-control mt-4 mb-2" placeholder="이름을 입력해주세요." readonly />
               </c:when> 
               </c:choose>
             </c:if>
            </div>
          
              <input type="text" name="qnaTitle" id="qnaTitle" maxlength="100" value="${inquiryBoard.qnaTitle}" style="ime-mode:active; font-weight: bold;" class="form-control mb-2"  readonly />
     
            <div class="form-group">
                 <textarea class="form-control" rows="10" name="qnaContent" id="qnaContent" style="ime-mode:active;" readonly>${inquiryBoard.qnaContent}</textarea>
            </div>
            
            <c:if test="${!empty inquiryBoard.inquiryBoardFile}">
             <div class="form-group">
                  <!--다중파일 등록시 아래처럼 foreach문을 통해 파일을 보여줘야함 -->
              <c:forEach items="${inquiryBoard.inquiryBoardFile}" var="file">
                   <img src="/resources/upload/${file.fileName}" alt="" style="width: 300px; height: 300px;">
                </c:forEach>
             </div>           
            </c:if>        
            </th>
          </tr>
         </thead>
         
         <tfoot>
         <tr>
               <td colspan="2"></td>
          </tr>
         </tfoot>
      </table>
    </div>
   
      <c:set var="cookieUserId1" value="<%=cookieIdd%>" />
     <c:set var="cookieSellerId1" value="<%=cookieSellerIdd%>" />
     <c:if test="${cookieUserId1 != null and cookieUserId1 != '' }" >
       <c:choose>
       <c:when test="${cookieUserId1 eq 'adm'}">
         <button type="button" id="btnList" class="btn btn-secondary">목록</button>
         <button type="button" id="btnDelete" class="btn btn-secondary">삭제</button> 
       </c:when>
       <c:when test="${(cookieUserId1 eq inquiryBoard.userId) and (inquiryBoard.qnaIndent eq 0)}">
            <button type="button" id="btnList" class="btn btn-secondary">목록</button>
          <button type="button" id="btnDelete" class="btn btn-secondary">삭제</button> 
          <button type="button" id="btnUpdate" class="btn btn-secondary">수정</button>
       </c:when>
       <c:when test="${(cookieUserId1 eq inquiryBoard.userId) and (inquiryBoard.qnaIndent eq 1)}">
          <button type="button" id="btnList" class="btn btn-secondary">목록</button>
          <!-- 문의사항은 1개 문의 와 1개의 답변      <button type="button" id="btnReply" class="btn btn-secondary">답변</button>  -->
          </c:when>
       </c:choose>
      </c:if>  
    
     <c:if test="${cookieSellerId1 != null and cookieSellerId1 != '' }" >
       <c:choose>
         <c:when test="${(cookieSellerId1 eq inquiryBoard.sellerId) and (inquiryBoard.qnaIndent eq 0) and (inquiryBoard.replyStatus eq 'N')}">
               <button type="button" id="btnList" class="btn btn-secondary">목록</button>
               <button type="button" id="btnReply" class="btn btn-secondary">답변</button>
         </c:when>
         <c:when test="${(cookieSellerId1 eq inquiryBoard.sellerId) and (inquiryBoard.qnaIndent eq 0) and (inquiryBoard.replyStatus eq 'Y')}">
               <button type="button" id="btnList" class="btn btn-secondary">목록</button>
         </c:when>
         <c:when test="${(cookieSellerId1 eq inquiryBoard.sellerId) and (inquiryBoard.qnaIndent eq 1)}">
             <button type="button" id="btnList" class="btn btn-secondary">목록</button>
             <button type="button" id="btnDelete" class="btn btn-secondary">삭제</button> 
             <button type="button" id="btnUpdate" class="btn btn-secondary">수정</button>
            </c:when>
        </c:choose>
      </c:if>    
   <br/>
   <br/>
</div>

   <input type="hidden" name="cookieSellerIdd" id="cookieSellerIdd" value="<%=cookieSellerIdd%>" />
   <input type="hidden" name="cookieIdd" id="cookieIdd" value="<%=cookieIdd%>" />
<form name="bbsForm" id="bbsForm" method="post">
   <input type="hidden" name="qnaSeq" value="" />
   <input type="hidden" name="userId" value="" />
   <input type="hidden" name="beforeQnaTitle" value="" />
   <input type="hidden" name="orderGubun" value="${orderGubun}" />
   <input type="hidden" name="searchType" value="${searchType}" />
   <input type="hidden" name="searchValue" value="${searchValue}" />
   <input type="hidden" name="searchCategory" value="${searchCategory}" />
   <input type="hidden" name="curPage" value="${curPage}" />
   
</form>

<footer style="background-color: black; color: lightgray; text-align: center; margin-top:60px; padding: 30px;">
 <a style="font-size:20px; letter-spacing:5px;">《 Dayiary 》 </a> <br>
    &copy; Copyright Dayiary Corp. All Rights Reserved. <br>
    Always with you 🎉 여러분의 일상을 함께합니다.
</footer> 
</body>
</html>