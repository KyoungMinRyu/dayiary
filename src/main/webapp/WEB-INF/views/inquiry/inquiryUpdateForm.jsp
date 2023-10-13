<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
     margin-bottom:85px;
}

#inquiryUpdateForm
{
   font-family: 'SUIT-Regular', sans-serif;
}
footer {
   position:fixed;
   bottom: 0;
   width: 100%;
}


</style>
<%@ include file="/WEB-INF/views/include/head.jsp" %>
<script>
$(document).ready(function(){
   
      $("#qnaTitle").focus();   
      
      $("#btnUpdate").on("click",function(){
         
           $("#btnUpdate").prop("disabled", true);   //버튼 비활성화
         
         if($.trim($("#qnaTitle").val()).length <= 0)
         {
           alert("문의글 제목을 입력하세요.");
            $("#qnaTitle").val("");
            $("#qnaTitle").focus();
            return;
         }
         
         if($.trim($("#qnaContent").val()).length <= 0)
         {
           alert("문의글 내용을 입력하세요.");
            $("#qnaContent").val("");
            $("#qnaContent").focus();
            return;
         }
      
       var form = $("#inquiryUpdateForm")[0];
        var formData = new FormData(form);      

        $.ajax({                           
          type:"POST",
          enctype:"multipart/form-data",
          url:"/inquiry/inquiryUpdateProc",
          data:formData,
          processData:false,
          contentType:false,
          cache:false,
          beforeSend:function(xhr)
          {
             xhr.setRequestHeader("AJAX", "true");
          },
          success:function(response)
          {
             if(response.code == 0)
             {
                 alert("문의글이 수정 되었습니다.");
                 location.href = "/inquiry/inquiryList";
             }
             else if(response.code == 400)
             {
                alert("입력 값이 올바르지 않습니다.");
                $("#btnUpdate").prop("disabled", false);      //버튼 활성화  
             }
             else if(response.code == 403)
             {
                alert("본인 문의글이 아닙니다.");
                $("#btnUpdate").prop("disabled", false);      
             }    
             else if(response.code == 404)
             {
                alert("문의글을 찾을 수 없습니다.");
                location.href = "/inquiry/inquiryList";
             }     
             else
             {
                   alert("문의글 수정 중 오류가 발생하였습니다.");
                   $("#btnUpdate").prop("disabled", false);    
             }
          },
          error:function(error)
          {
             icia.common.error(error);
             alert("문의글 수정 중 오류가 발생하였습니다.");
             $("#btnUpdate").prop("disabled", false);      
          }
        });
   });
      
     
         //[예약전], [구매전]으로 시작할 때 해당문구삭제 불가 및 저장시에도 [예약전], [구매전] 문구 붙여서 넘어감
         var originalValue = $("#qnaTitle").val();
      var readonlyPrefixes = ["[예약전]", "[구매전]"];
      var originalPrefix = null;
      
      for (var i = 0; i < readonlyPrefixes.length; i++) 
      {
         if (originalValue.startsWith(readonlyPrefixes[i])) 
         {      
              originalPrefix = readonlyPrefixes[i];
              break;
         }
      }
      
      $("#qnaTitle").on("input", function () 
      {
          var currentValue = $(this).val();   //타이틀 변경시 입력값이 this.val()               
      
          if (originalPrefix) 
          {
              if (!currentValue.startsWith(originalPrefix))    //[예약전], [구매전] 으로 제목이 시작할 시 값을 지우거나 변경하지 못하도록 제한하는 기능
              {
                  // 입력값이 원래 문자열과 다르면 원래 값으로 복원
                  $(this).val(originalValue);
              }
          }
          else 
          {
              // 원래 값이 없는 경우 현재 입력값을 원래 값으로 설정
              originalValue = currentValue;
          }
      });

      
       $("#btnList").on("click", function() {
          
              document.bbsForm.action = "/inquiry/inquiryList";
              document.bbsForm.submit();
       
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

<!-- 이미지 미리보기 -->
<script>

      function setThumbnail(event) 
      {
         var imageContainer = document.querySelector("div#image_container");
           imageContainer.innerHTML = ''; // 기존 이미지 삭제
       
        for (var image of event.target.files) 
        {
           
             var reader = new FileReader();

             reader.onload = function(event) 
             {
               var img = document.createElement("img");
               
               img.setAttribute("src", event.target.result);
               
               img.style.width = "300px"; // 이미지 크기 조절
               img.style.height = "300px"; // 이미지 크기 조절

               document.querySelector("div#image_container").appendChild(img);
            };
          
          reader.readAsDataURL(image);
        }
        $("footer").css("position", "static");
      }
</script>

<div class="container" style="margin-top:150px">
   <h1>문의사항 수정</h1>
   <form name="inquiryUpdateForm" id="inquiryUpdateForm" method="post" enctype="multipart/form-data">
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
           
            <c:set var="cookieUserId1" value="<%=cookieIdd%>" />
             <c:set var="cookieSellerId1" value="<%=cookieSellerIdd%>" />          
     
              <c:if test="${(cookieUserId1 != null) and (cookieUserId1 != '')}">
                 <c:choose>
                <c:when test="${cookieUserId1 ne 'adm'}" >             
                    <input type="text" name="userName" id="userName" maxlength="20" value="작성자 : ${inquiryBoard.userName}" style="ime-mode:active; margin-top: 0.5rem!important; font-weight: bold;" class="form-control mt-4 mb-2" placeholder="이름을 입력해주세요." readonly />
                </c:when>
               </c:choose>
              </c:if> 
     
            <c:if test="${(cookieSellerId1 != null) and (cookieSellerId1 != '')}" >
               <c:choose>
              <c:when test="${gubun eq 'R'}">
                     <input type="text" name="RestoName" id="RestoName" maxlength="20" value="작성자: ${inquiryBoard.orderedName}" style="ime-mode:active;  font-weight: bold;" class="form-control mt-4 mb-2" placeholder="이름을 입력해주세요." readonly />
             </c:when>
             <c:when test="${gubun eq 'P'}">
                    <input type="text" name="ProductName" id="ProductName" maxlength="20" value="작성자: ${inquiryBoard.orderedName} 판매자" style="ime-mode:active;  font-weight: bold;" class="form-control mt-4 mb-2" placeholder="이름을 입력해주세요." readonly />
             </c:when> 
             </c:choose>
            </c:if>        
  
               <input type="text" name="qnaTitle" id="qnaTitle" maxlength="100" style="ime-mode:active; font-weight: bold;" value="${inquiryBoard.qnaTitle}" class="form-control mb-2" placeholder="문의글 제목을 입력해주세요." required />
      
             <div class="form-group">
               <textarea class="form-control" rows="10" name="qnaContent" id="qnaContent" style="ime-mode:active;" placeholder="문의글 내용을 입력해주세요" required>${inquiryBoard.qnaContent}</textarea>
             </div>
            
               <input type="file" id="inquiryFile" name="inquiryFile" class="form-control mb-2" onchange="setThumbnail(event);" placeholder="이미지를 선택하세요." multiple="multiple" required/>
               <div id="image_container" style="margin-bottom:5px;"></div>    
      
         <input type="hidden" name="qnaSeq" value="${inquiryBoard.qnaSeq}" />
         <input type="hidden" name="userId" value="${inquiryBoard.userId}" />
         <input type="hidden" name="orderGubun" value="${orderGubun}" />
         <input type="hidden" name="searchType" value="${searchType}" />
         <input type="hidden" name="searchValue" value="${searchValue}" />
         <input type="hidden" name="searchCategory" value="${searchCategory}" />
         <input type="hidden" name="curPage" value="${curPage}" />
         <input type="hidden" name="sellerId" value="${inquiryBoard.sellerId}" />
   </form>
   
      <div class="form-group row">
       <div class="col-sm-12">
         <button type="button" id="btnUpdate" class="btn btn-primary" title="수정">수정</button>
         <button type="button" id="btnList" class="btn btn-secondary" title="목록">목록</button>
       </div>
    </div>
</div>

<form name="bbsForm" id="bbsForm" method="post">
   <input type="hidden" name="qnaSeq" value="" />
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