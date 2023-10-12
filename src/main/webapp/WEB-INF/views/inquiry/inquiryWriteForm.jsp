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
<!DOCTYPE html>
<html>
<head>
<style>

body {
   
     background-color: #fffbf4 !important;
}


.bold {
    font-weight: bold;
}

footer {
   position:fixed;
   bottom: 0;
   width: 100%;
}
.container {

     background-color: rgba(255, 255, 255, 0.7) !important;   /* 게시판 테두리 투명도 */
     border-radius: 10px;                            /* 게시판 테두리 라운드 */
     padding-top: 30px;                               /* 게시판 내부내용 상단에서 띄우기 */
     padding-bottom: 10px;
     max-width: 1300px !important;
    font-size: 18px;
    margin-bottom:85px;
}

div #selectBoxShape {
    display: flex;
    justify-content: flex-start;
    gap:2px;
}

*
{
   font-family: 'SUIT-Regular', sans-serif;
}

</style>
<%@ include file="/WEB-INF/views/include/head.jsp" %>
<script type="text/javascript">
var chkGubun = "";
$(document).ready(function() {
   
   let afterSelected = "${afterSelected}";
      
   if(afterSelected != "" && afterSelected != null)
   {
      SelQnaType(afterSelected);
   }
   
   $("#qnaTitle").focus();
   
   $("#btnWrite").on("click", function() {
     
     $("#btnWrite").prop("disabled", true);
     
     if($("#select1").val() === "") 
     {
          alert("문의종류를 선택해주세요.");
          
         $("#btnWrite").prop("disabled", false);   
         
         return;
     }
   
     if($.trim($("#qnaTitle").val()).length <= 0)
     {
         alert("문의글 제목을 입력하세요.");
         $("#qnaTitle").val("");
         $("#qnaTitle").focus();
         
         $("#btnWrite").prop("disabled", false);   
         
         
         return;
     }
     
     if($.trim($("#qnaContent").val()).length <= 0)
     {
           alert("문의글 내용을 입력하세요.");
           $("#qnaContent").val("");
           $("#qnaContent").focus();
           
           $("#btnWrite").prop("disabled", false);    
           
           return;
     }
     
     
     var qnaTitle = $("#qnaTitle").val();
     var select1Value = $("#select1").val();
     var selectedValue = $('#cateQnaType0').val();
     var selectedValue2 = $('#cateQnaType2').val();

     if (select1Value === '0' && selectedValue.charAt(0) === 'R' && !qnaTitle.startsWith("[예약전]")) 
     {
         // qnaTitle의 값이 "[예약전]"으로 시작하지 않으면 "[예약전] "를 추가하여 저장
         $("#qnaTitle").val("[예약전] " + qnaTitle);
     } else if (select1Value === '2' && selectedValue2.charAt(0) === 'P' && !qnaTitle.startsWith("[구매전]")) 
     {
         // qnaTitle의 값이 "[구매전]"으로 시작하지 않으면 "[구매전] "를 추가하여 저장
         $("#qnaTitle").val("[구매전] " + qnaTitle);
     }

        
     var form = $("#inquiryWriteForm")[0];   
     var formData = new FormData(form);      
                       
     $.ajax({
        type:"POST",
        enctype:"multipart/form-data",
        url:"/inquiry/inquiryWriteProc",
        data:formData,         
        processData:false,      
        contentType:false,       
        cache:false,
        timeout:600000,         
        beforeSend:function(xhr)
        {
           xhr.setRequestHeader("AJAX", "true");
        },
        success:function(response)
        {
           if(response.code == 0)
           {
              alert("문의글이 등록되었습니다.");
              location.href = "/inquiry/inquiryList";
              document.bbsForm.searchCategory.value = $("#_searchCategory").val();
              
           }
           else if(response.code == 400)
           {
              alert("입력 값이 올바르지 않습니다.");
              $("#qnaTitle").focus();
              $("#btnWrite").prop("disabled", false);   
           }
           else
           {
              alert("문의글 등록 중 오류 발생");
              $("#qnaTitle").focus();
              $("#btnWrite").prop("disabled", false);   
           }
        },
        error:function(error)
        {
            icia.common.error(error);
            alert("문의글 등록 중 오류가 발생하였습니다.");
            $("#btnWrite").prop("disabled", false);      
        }
     });
   });
   
   $("#btnList").on("click", function() {
      document.bbsForm.action = "/inquiry/inquiryList";
      document.bbsForm.submit();
   });
});


function SelQnaType(type, select) {
   
   chkGubun = type;
   
    $('#cateQnaType').empty();
    
   if(type == "")
   {
      $('#cateQnaType').append("<option value='11'></option>");
      $("#cateQnaType0").css("display", 'none');
        $("#cateQnaType1").css("display", 'none');
        $("#cateQnaType2").css("display", 'none');
        $("#cateQnaType3").css("display", 'none');
        document.inquiryWriteForm.cateQnaType.value = "";   // 다른 셀렉트 선택후 일반문의 선택시 기존값 초기화
        document.inquiryWriteForm.sellerId.value = "";       // 다른 셀렉트 선택후 일반문의 선택시 기존값 초기화화
   }   
    else if (type == '0') 
    {   
       $("#cateQnaType0").css("display", 'block');
        $("#cateQnaType1").css("display", 'none');
        $("#cateQnaType2").css("display", 'none');
        $("#cateQnaType3").css("display", 'none');
        //document.inquiryWriteForm.cateQnaType.value = "";   // 다른 셀렉트 선택후 일반문의 선택시 기존값 초기화
        //document.inquiryWriteForm.sellerId.value = "";       // 다른 셀렉트 선택후 일반문의 선택시 기존값 초기화화
    } 
    else if (type == '1') 
    {   
       $("#cateQnaType0").css("display", 'none');
        $("#cateQnaType1").css("display", 'block');
        $("#cateQnaType2").css("display", 'none');
        $("#cateQnaType3").css("display", 'none');
    } 
    else if (type == '2') 
    {   
       $("#cateQnaType0").css("display", 'none');
       $("#cateQnaType1").css("display", 'none');
       $("#cateQnaType2").css("display", 'block');
       $("#cateQnaType3").css("display", 'none');

       // $('#cateQnaType').append("<option value='22'>TV</option>");
    } 
    else if (type == '3') 
    {
       $("#cateQnaType0").css("display", 'none');
       $("#cateQnaType1").css("display", 'none');
       $("#cateQnaType2").css("display", 'none');
       $("#cateQnaType3").css("display", 'block');
        // $('#cateQnaType').append("<option value='33'>TV</option>");
    }
   
    
    //document.getElementById("cateQnaType").style.display = "";

    if ($.trim(type) != "") {
        $('#select1').val(type);
        
        document.inquiryWriteForm.questType.value = type;
        
        if (type == '0')
        {
           document.inquiryWriteForm.cateQnaType.value = $('#cateQnaType0').val();
           document.inquiryWriteForm.sellerId.value = $('#cateQnaType0 option:selected').data('seller-id');
        }
        else if (type == '1')
        {
           document.inquiryWriteForm.cateQnaType.value = $('#cateQnaType1').val();
           document.inquiryWriteForm.sellerId.value = $('#cateQnaType1 option:selected').data('seller-id');
           document.inquiryWriteForm.afterSelected.value = $('#select1').val();
        }
        else if (type == '2')
        {
           document.inquiryWriteForm.cateQnaType.value = $('#cateQnaType2').val();
           document.inquiryWriteForm.sellerId.value = $('#cateQnaType2 option:selected').data('seller-id');
        }
        else if (type == '3')
        {
           document.inquiryWriteForm.cateQnaType.value = $('#cateQnaType3').val();
           document.inquiryWriteForm.sellerId.value = $('#cateQnaType3 option:selected').data('seller-id');
           document.inquiryWriteForm.afterSelected.value = $('#select1').val();
        }
    }
}

function cateSelectType(type)
{
    if ($.trim(type) != "") 
    {
       if(chkGubun == '0')
       {
          document.inquiryWriteForm.cateQnaType.value = $('#cateQnaType0').val();
           document.inquiryWriteForm.sellerId.value = $('#cateQnaType0 option:selected').data('seller-id');
       }
       else if(chkGubun == '1')
       {
          document.inquiryWriteForm.cateQnaType.value = $('#cateQnaType1').val();
           document.inquiryWriteForm.sellerId.value = $('#cateQnaType1 option:selected').data('seller-id');
           document.inquiryWriteForm.afterSelected.value = $('#select1').val();
       }
       else if(chkGubun == '2')
        {
           document.inquiryWriteForm.cateQnaType.value = $('#cateQnaType2').val();
           document.inquiryWriteForm.sellerId.value = $('#cateQnaType2 option:selected').data('seller-id');
        }
        else if(chkGubun == '3')
        {
           document.inquiryWriteForm.cateQnaType.value = $('#cateQnaType3').val();
           document.inquiryWriteForm.sellerId.value = $('#cateQnaType3 option:selected').data('seller-id');
           document.inquiryWriteForm.afterSelected.value = $('#select1').val();
        }
    }   
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
    
<div class="container" style="margin-top:150px; height: auto;">
   <h1>문의사항 작성</h1>
   <form name="inquiryWriteForm" id="inquiryWriteForm" method="post" enctype="multipart/form-data">
   <div id="selectBoxShape" style="margin-bottom:-15px;">
    <tr>
       <th>문의유형:</th>
          <td width="600px">
             <select name="questType" id="select1" onChange="SelQnaType(this.value)" >
                <option value="">문의종류</option>
                <option value="0" <c:if test="${afterSelected == '0'}">selected</c:if>>레스토랑문의(예약전)</option>
                <option value="1" <c:if test="${afterSelected == '1'}">selected</c:if>>레스토랑문의(예약후)</option>
                <option value="2" <c:if test="${afterSelected == '2'}">selected</c:if>>선물문의(구매전)</option>
                <option value="3" <c:if test="${afterSelected == '3'}">selected</c:if>>선물문의(구매후)</option>
             </select>
             
             <select id="cateQnaType0" name="cateQnaType0" style="width:auto; display:none;"  onChange="cateSelectType(this.value)"> 
                  <c:if test="${!empty list2}">   
                     <c:forEach var="inquiry" items="${list2}" varStatus="status"> 
                        <c:set var="gubun" value="${fn:substring(inquiry.rSeq, 0, 1)}"/>
                         <c:choose>
                                <c:when test="${gubun eq 'R'}">    
                                   <option value='${inquiry.rSeq}' data-seller-id='${inquiry.rSellerId}'>식당명: ${inquiry.restoName}　/　식당번호: ${inquiry.rSeq} </option>
                                </c:when>
                        </c:choose>                        
                     </c:forEach>
                  </c:if> 
              </select>
             <select id="cateQnaType1" name="cateQnaType1" style="width:auto; display:none;"  onChange="cateSelectType(this.value)"> <!-- block -->
                  <c:if test="${!empty list}">   
                     <c:forEach var="inquiry" items="${list}" varStatus="status">  
                        <c:set var="gubun" value="${fn:substring(inquiry.orderedSeq, 0, 1)}"/>  
                        <c:choose>
                                <c:when test="${gubun eq 'R'}">    
                                   <option <c:if test='${orderSeq eq inquiry.orderSeq}'>selected</c:if> value='${inquiry.orderedSeq}' data-seller-id='${inquiry.sellerId}'>식당명: ${inquiry.orderedName}　/　예약번호: ${inquiry.orderSeq}</option>
                               </c:when>
                        </c:choose>  
                     </c:forEach>
                  </c:if> 
              </select>
             
             
             <select id="cateQnaType2" name="cateQnaType2" style="width:auto; display:none;"  onChange="cateSelectType(this.value)"> 
                  <c:if test="${!empty list1}">   
                     <c:forEach var="inquiry" items="${list1}" varStatus="status"> 
                        <c:set var="gubun" value="${fn:substring(inquiry.productSeq, 0, 1)}"/>
                         <c:choose>
                                <c:when test="${gubun eq 'P'}">    
                                   <option <c:if test='${productSeq eq inquiry.productSeq}'>selected</c:if> value='${inquiry.productSeq}' data-seller-id='${inquiry.pSellerId}'>상품명: ${inquiry.pName}　/　상품번호: ${inquiry.productSeq} </option>
                                </c:when>
                        </c:choose>                        
                     </c:forEach>
                  </c:if> 
              </select>
              
               <select id="cateQnaType3" name="cateQnaType3" style="width:auto; display:none;" onChange="cateSelectType(this.value)">
                  <c:if test="${!empty list}">   
                     <c:forEach var="inquiry" items="${list}" varStatus="status">  
                        <c:set var="gubun" value="${fn:substring(inquiry.orderedSeq, 0, 1)}"/>  
                        <c:choose>
                                <c:when test="${gubun eq 'P'}">
                                   <option  <c:if test='${orderSeq eq inquiry.orderSeq}'>selected</c:if>  value='${inquiry.orderedSeq}' data-seller-id='${inquiry.sellerId}'>상품명: ${inquiry.orderedName}　/　주문번호: ${inquiry.orderSeq}</option>
                                </c:when>
                        </c:choose>
                     </c:forEach>
                  </c:if>
              </select>
             
          </td>   
     </tr>
    </div>         
   
      <input type="text" name="userName" id="userName" maxlength="20" value="작성자 : ${user.userName}" style="ime-mode:active;" class="form-control mt-4 mb-2" placeholder="이름을 입력해주세요." readonly />
      
      <input type="text" name="qnaTitle" id="qnaTitle" maxlength="100" style="ime-mode:active; font-weight: bold;" class="form-control mb-2" placeholder="문의글 제목을 입력해주세요." required />
      
      <div class="form-group">
         <textarea class="form-control" rows="10" name="qnaContent" id="qnaContent" style="ime-mode:active;" placeholder="문의글 내용을 입력해주세요" required></textarea>
      </div>
      
      <!-- 이미지 미리보기시 div image_container처럼 사진을 보여줄 구간 생성필요! 또한 여러사진등록시 multiple 기입, setThumbnail함수 설정 및 스크립트 단에서 내용기입 -->
     <input type="file" id="inquiryFile" name="inquiryFile" class="form-control mb-2" onchange="setThumbnail(event);" placeholder="이미지를 선택하세요." multiple="multiple" required/>
     <div id="image_container" style="margin-bottom:5px;"></div>                                                        
     
      <div class="form-group row">
         <div class="col-sm-12">
            <button type="button" id="btnWrite" class="btn btn-primary" title="저장">저장</button>
            <button type="button" id="btnList" class="btn btn-secondary" title="목록">목록</button>
         </div>
      </div>
      <input type="hidden" name="cateQnaType" value="" />
      <input type="hidden" name="sellerId" value="" />
      <input type="hidden" name="afterSelected" value="" />
   </form> 
  
   <form name="bbsForm" id="bbsForm" method="post">            
      <input type="hidden" name="searchType" value="${searchType}" />
      <input type="hidden" name="searchValue" value="${searchValue}" />
      <input type="hidden" name="searchCategory" value="${searchCategory}" />
      <input type="hidden" name="curPage" value="${curPage}" />
   </form>
</div>
<footer style="background-color: black; color: lightgray; text-align: center; margin-top:auto; padding: 30px;">
 <a style="font-size:20px; letter-spacing:5px;">《 Dayiary 》 </a> <br>
    &copy; Copyright Dayiary Corp. All Rights Reserved. <br>
    Always with you 🎉 여러분의 일상을 함께합니다.
</footer> 
</body>
</html>