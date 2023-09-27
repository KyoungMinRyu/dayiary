<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" type="text/css" href="/resources/css/diaryList.css">
<%@ include file="/WEB-INF/views/include/head.jsp" %>
<script type="text/javascript" src="//code.jquery.com/jquery-1.11.0.min.js"></script>
<script type="text/javascript" src="/resources/smarteditor2/js/HuskyEZCreator.js" charset="utf-8"></script>
<script type="text/javascript">
$(document).ready(function() {

    //전역변수
    var oEditors = [];
    //스마트에디터 프레임생성
    nhn.husky.EZCreator.createInIFrame({
        oAppRef: oEditors,
        elPlaceHolder: "editor",
        sSkinURI: "/resources/smarteditor2/SmartEditor2Skin.html", 
        htParams : {
            // 툴바 사용 여부 (true:사용/ false:사용하지 않음)
            bUseToolbar : true,             
            // 입력창 크기 조절바 사용 여부 (true:사용/ false:사용하지 않음)
            bUseVerticalResizer : true,     
            // 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음)
            bUseModeChanger : true, 
        }
    });
   
    
   $("#boardTitle").focus();
   
   $("#btnUpdate").on("click", function() {
      $("#btnUpdate").prop("disabled", true); //버튼 비활성화
      
      oEditors.getById["editor"].exec("UPDATE_CONTENTS_FIELD", []);
      
      if($.trim($("#boardTitle").val()).length <= 0)
      {
         alert("제목을 입력하세요.");
         $("#boardTitle").val("");
         $("#boardTitle").focus();
         $("#btnUpdate").prop("disabled", false);
         return;
      }
      
      if($.trim($("#editor").val()).length <= 0)
      {
         alert("내용을 입력하세요.");
         $("#editor").val("");
         $("#editor").focus();
         $("#btnUpdate").prop("disabled", false);
         return;
      }
      
      var form = $("#updateForm")[0];
      var formData = new FormData(form);
      
      $.ajax
       ({
          type:"POST",
          enctype:"multipart/form-data",
          url:"/board/diaryUpdateProc",
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
                alert("게시물이 수정되었습니다.");
                location.href = "/board/diaryList"
                /*
                document.bbsForm.action = "/board/list";
                document.bbsForm.submit();   
                */
             }
             else if(response.code == 400)
             {
                alert("파라미터 값이 올바르지 않습니다");
                   $("#boardTitle").focus();
                   $("#btnUpdate").prop("disabled", false);
                return;
             }
             else if(response.code == 403)
             {
                alert("본인 게시물이 아닙니다.");
                $("#btnUpdate").prop("disabled", false);
             }
             else if(response.code == 404)
             {
                alert("게시물을 찾을 수 없습니다.");
                location.href = "/board/diaryList";
             }
             else
             {
                alert("알 수 없는 오류가 발생하였습니다.");
                $("#boardTitle").focus();
                   $("#btnUpdate").prop("disabled", false);
                return;
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
      document.bbsForm.action = "/board/diaryList";
      document.bbsForm.submit();
   });


});
</script>
<style>
.container
{
   max-width: 1500px !important;
   width:1500px !important;
    margin: 0 auto;
    margin-top:160px;
    padding: 35px; /* 전체 카드 컨테이너의 패딩 */
    /*background-color: #f5f5f5;*/
    background-color: rgba(255, 255, 255, 0.8);
    display: flex;
    justify-content: center;
    flex-direction: column;
}
}

#updateForm
{
   width:1300px;
}

</style>
</head>
<body>

<%@ include file="/WEB-INF/views/include/navigation.jsp" %>
<div class="container">
   <h1>다이어리 수정</h1>
   <form name="updateForm" id="updateForm" method="post" enctype="multipart/form-data">
      <input type="text" name="userName" id="userName" maxlength="20" value="${user.userName}" style="ime-mode:active;" class="form-control mt-4 mb-2" placeholder="이름을 입력해주세요." readonly />
      <input type="text" name="userEmail" id="userEmail" maxlength="30" value="${user.userEmail}"  style="ime-mode:inactive;" class="form-control mb-2" placeholder="이메일을 입력해주세요." readonly />
      <input type="text" name="boardTitle" id="boardTitle" maxlength="100" style="ime-mode:active;" value="${mainBoard.boardTitle}" class="form-control mb-2" placeholder="제목을 입력해주세요." required />
      <div class="form-group">
          <textarea name="editor" id="editor" rows="10" cols="100" style="width:100%; height:412px; min-width:610px;">${mainBoard.boardContent}</textarea>
      </div>
      <input type="file" id="mainBoardFile" name="mainBoardFile" class="form-control mb-2" placeholder="파일을 선택하세요." multiple="multiple" required />
<c:if test="${!empty mainBoard.mainBoardFile}">
      <div style="margin-bottom:0.3em;">[첨부파일 : ${mainBoard.mainBoardFile.fileOrgName}]</div>
</c:if>
      <input type="hidden" name="boardSeq" value="${mainBoard.boardSeq}" />
      <input type="hidden" name="searchType" value="${searchType}" />
      <input type="hidden" name="searchValue" value="${searchValue}" />
      <input type="hidden" name="curPage" value="${curPage}" />
   </form>
   
   <div class="form-group row">
      <div class="col-sm-12">
         <button type="button" id="btnUpdate" class="btn btn-primary" style="background-color:black; color:white; border:none;" title="수정">수정</button>
         <button type="button" id="btnList" class="btn btn-secondary" title="리스트">목록</button>
      </div>
   </div>
</div>
<form name="bbsForm" id="bbsForm" method="post">
   <input type="hidden" name="boardSeq" value="${mainBoard.boardSeq}" />
   <input type="hidden" name="searchType" value="${searchType}" />
   <input type="hidden" name="searchValue" value="${searchValue}" />
   <input type="hidden" name="curPage" value="${curPage}" />
</form>
<footer style="background-color: black; color: lightgray; text-align: center; margin-top:80px; padding: 40px;">
 <a style="font-size:20px; letter-spacing:5px;">《 Dayiary 》 </a> <br>
    &copy; Copyright Dayiary Corp. All Rights Reserved. <br>
    Always with you 🎉 여러분의 일상을 함께합니다.
</footer> 
</body>
</html>