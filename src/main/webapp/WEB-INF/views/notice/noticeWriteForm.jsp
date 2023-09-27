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

body {
     background-color: #fffbf4;
     
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
     font-size: 18px;
     max-width: 1300px !important;
     margin-bottom: 100px;
}


</style>
<script type="text/javascript">
$(document).ready(function() {
   
   if(localStorage.getItem("title") != null || localStorage.getItem("content") != null)
   {
      if(confirm("임시저장한 글을 불러오시겠습니까?"))   
      {
             if(localStorage.getItem("title") != null || localStorage.getItem("title") != undefined || localStorage.getItem("title") != "")
            {
                 $("#bbsTitle").val(localStorage.getItem("title"));
             } 
          
            if(localStorage.getItem("content") != null || localStorage.getItem("content") != undefined || localStorage.getItem("content") != "")
            {
                 $("#bbsContent").val(localStorage.getItem("content"));
            }
      }
      else
      {   
         localStorage.clear();
         $("#bbsTitle").focus();   
      }
   }
   
   $("#btnWrite").on("click", function() {
     
     $("#btnWrite").prop("disabled", true);   

     if($("#_fixed").val() === "") 
     {
          alert("상단 고정 여부를 선택해주세요.");
         $("#btnWrite").prop("disabled", false);   
         
         return;
     }
     
     if($.trim($("#bbsTitle").val()).length <= 0)
     {
         alert("공지글 제목을 입력하세요.");
         $("#bbsTitle").val("");
         $("#bbsTitle").focus();
         
         $("#btnWrite").prop("disabled", false);   
         
         return;
     }
     
     if($.trim($("#bbsContent").val()).length <= 0)
     {
           alert("공지글 내용을 입력하세요.");
           $("#bbsContent").val("");
           $("#bbsContent").focus();
           
           $("#btnWrite").prop("disabled", false);    
        
           return;
     }

     var form = $("#noticeWriteForm")[0];   
     var formData = new FormData(form); 
                                            
     $.ajax({
        type:"POST",
        enctype:"multipart/form-data",   
        url:"/notice/noticeWriteProc",
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
              alert("공지글이 등록되었습니다.");
              location.href = "/notice/adminNotice";
              localStorage.clear();
              
           }
           else if(response.code == 400)
           {
              alert("입력값이 올바르지 않습니다.");
              $("#bbsTitle").focus();
              $("#btnWrite").prop("disabled", false);   
           }
           else
           {
              alert("공지글 등록 중 오류 발생");
              $("#bbsTitle").focus();
              $("#btnWrite").prop("disabled", false);   
           }
        },
        error:function(error)
        {
            icia.common.error(error);
            alert("공지글 등록 중 오류가 발생하였습니다.");
            $("#btnWrite").prop("disabled", false);   
        }
     });
   });
   
   $("#btnTempSave").on("click", function()
   {   
      $("#btnTemSave").prop("disabled", true);   

        if($("#_fixed").val() === "") 
        {
             alert("상단 고정 여부를 선택해주세요.");
            $("#btnWrite").prop("disabled", false);   
            
            return;
        }
        
        if($.trim($("#bbsTitle").val()).length <= 0)
        {
            alert("공지글 제목을 입력하세요.");
            $("#bbsTitle").val("");
            $("#bbsTitle").focus();
            
            $("#btnWrite").prop("disabled", false);   
            
            return;
        }
        
        if($.trim($("#bbsContent").val()).length <= 0)
        {
              alert("공지글 내용을 입력하세요.");
              $("#bbsContent").val("");
              $("#bbsContent").focus();
              
              $("#btnWrite").prop("disabled", false);    
           
              return;
        }

      if(confirm("작성중인 글을 임시저장 하시겠습니까?"))   
      {   
          localStorage.setItem("title", $("#bbsTitle").val().trim());
          localStorage.setItem("content", $("#bbsContent").val().trim());
          document.bbsForm.action = "/notice/adminNotice";
          document.bbsForm.submit();
          alert("임시저장이 완료되었습니다.");
      }
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
<div class="container" style="margin-top:150px">
  <h1>공지사항 작성</h1>
        
   <form name="noticeWriteForm" id="noticeWriteForm" method="post" enctype="multipart/form-data"> 
      <div style="text-align: left; align-items: left;">
              <select name="searchSort" id="_fixed" class="custom-select" style="width:auto;">
                   <option value="">상단고정</option>
                   <option value="1" >고정</option>
                   <option value="2" >비고정</option>
               </select>
      </div>
      <input type="text" name="userName" id="userName" maxlength="20" value="${user.userName}" style="ime-mode:active;" class="form-control mt-4 mb-2" placeholder="이름을 입력해주세요." readonly />
      <input type="text" name="bbsTitle" id="bbsTitle" maxlength="100" style="ime-mode:active;" class="form-control mb-2" placeholder="공지제목을 입력해주세요." required />
      <div class="form-group">
         <textarea class="form-control" rows="10" name="bbsContent" id="bbsContent" style="ime-mode:active;" placeholder="공지내용을 입력해주세요" required></textarea>
      </div>
      <div class="form-group row">
         <div class="col-sm-12" style="margin-bottom:30px">
            <button type="button" id="btnWrite" class="btn btn-primary" title="저장">저장</button>
            <button type="button" id="btnTempSave" class="btn btn-primary" title="임시저장">임시저장</button>
            <button type="button" id="btnList" class="btn btn-secondary" title="목록">목록</button>
         </div>
      </div>
      <input type="hidden" name="fixed" id="fixed" value="N" />
   </form>  
   <form name="bbsForm" id="bbsForm" method="post">            
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