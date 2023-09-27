<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
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

*
{
   font-family: 'SUIT-Regular', sans-serif;
}

footer {
   position:fixed;
    bottom: 0;
    width: 100%;
}

body {
     background-color: #fffbf4;
}
.container {

     background-color: rgba(255, 255, 255, 0.7) !important;   /* 게시판 테두리 투명도 */
     border-radius: 10px;                            /* 게시판 테두리 라운드 */
     padding-top: 30px;                               /* 게시판 내부내용 상단에서 띄우기 */
     font-size: 18px;
     max-width: 1300px !important;
     margin-bottom:100px;
}
</style>
<script type="text/javascript">
$(document).ready(function() {

   $("#bbsTitle").focus();
   
   $("#btnUpdate").on("click", function() {
      
      $("#btnUpdate").prop("disabled", true);      
      

      if($("#_fixed").val() === "") 
      {
         alert("상단 고정 여부를 선택해주세요.");
         $("#btnUpdate").prop("disabled", false);
         return;
      }
      
      if($.trim($("#bbsTitle").val()).length <= 0)
      {
         alert("공지글 제목을 입력하세요.");
         $("#bbsTitle").val("");
         $("#bbsTitle").focus();
         $("#btnUpdate").prop("disabled", false);
         return;
      }
      
      if($.trim($("#bbsContent").val()).length <= 0)
      {
         alert("공지글 내용을 입력하세요.");
         $("#bbsContent").val("");
         $("#bbsContent").focus();
         $("#btnUpdate").prop("disabled", false);
         return;
      }
   
      var form = $("#noticeUpdateForm")[0];
      var formData = new FormData(form);   
                                     
      $.ajax({                           
        type:"POST",
        enctype:"multipart/form-data",
        url:"/notice/noticeUpdateProc",
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
               alert("공지글이 수정 되었습니다.");
               location.href = "/notice/adminNotice";
           }
           else if(response.code == 400)
           {
              alert("입력 값이 올바르지 않습니다.");
              $("#btnUpdate").prop("disabled", false);      
           }
           else if(response.code == 403)
           {
              alert("본인 공지글이 아닙니다.");
              $("#btnUpdate").prop("disabled", false);      
           }    
           else if(response.code == 404)
           {
              alert("공지글을 찾을 수 없습니다.");
              location.href = "/notice/adminNotice";
           }     
           else
           {
                 alert("공지글 수정 중 오류가 발생하였습니다.");
                 $("#btnUpdate").prop("disabled", false);   
           }
        },
        error:function(error)
        {
           icia.common.error(error);
           alert("게시물 수정 중 오류가 발생하였습니다.");
           $("#btnUpdate").prop("disabled", false);       
        }
      });
   });
   
   $("#btnList").on("click", function() {
      document.bbsForm.action = "/notice/adminNotice";
      document.bbsForm.submit();
   });
});
</script>
</head>
<body>

<%@ include file="/WEB-INF/views/include/adminNavi.jsp" %>
<div>
<div class="container" style="margin-top:150px">
   <h1>공지사항 수정</h1>
   
   <form name="noticeUpdateForm" id="noticeUpdateForm" method="post" enctype="multipart/form-data">
      <div style="text-align: left; align-items: left;">
              <select name="searchSort" id="_fixed" class="custom-select" style="width:auto;">
                   <option value="">상단고정</option>
                   <option value="1" >고정</option>
                   <option value="2" >비고정</option>
               </select>
      <input type="text" name="userName" id="userName" maxlength="20" value="${user.userName}" style="ime-mode:active;" class="form-control mt-4 mb-2" placeholder="이름을 입력해주세요." readonly />
      <input type="text" name="bbsTitle" id="bbsTitle" maxlength="100" style="ime-mode:active;" value="${adminNotice.bbsTitle}" class="form-control mb-2" placeholder="제목을 입력해주세요." required />
      <div class="form-group">
         <textarea class="form-control" rows="10" name="bbsContent" id="bbsContent" style="ime-mode:active;" placeholder="내용을 입력해주세요" required>${adminNotice.bbsContent}</textarea>
      </div>

      <input type="hidden" name="bbsSeq" value="${adminNotice.bbsSeq}" />
      <input type="hidden" name="searchType" value="${searchType}" />
      <input type="hidden" name="searchValue" value="${searchValue}" />
      <input type="hidden" name="curPage" value="${curPage}" />
      
       <input type="hidden" name="fixed" id="fixed" value="N" />
   </form>
   
   <div class="form-group row">
      <div class="col-sm-12" style="margin-bottom:30px">
         <button type="button" id="btnUpdate" class="btn btn-primary" title="수정">수정</button>
         <button type="button" id="btnList" class="btn btn-secondary" title="목록">목록</button>
      </div>
   </div>
</div>
<form name="bbsForm" id="bbsForm" method="post">
   <input type="hidden" name="bbsSeq" value="${adminNotice.bbsSeq}" />
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