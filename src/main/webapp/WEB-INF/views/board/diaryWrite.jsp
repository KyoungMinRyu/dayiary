<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" type="text/css" href="/resources/css/diaryList.css">
<style>
body {
    margin: 0;
    padding: 0;
}

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
}

#writeForm
{
   width:1300px;
}

</style>

<%@ include file="/WEB-INF/views/include/head.jsp" %>
<script type="text/javascript" src="//code.jquery.com/jquery-1.11.0.min.js"></script>
<script type="text/javascript" src="/resources/smarteditor2/js/HuskyEZCreator.js" charset="utf-8"></script>
<script type="text/javascript">

$(document).ready(function()
{
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
   
      $("#btnWrite").on("click", function() 
      {
          //nhn.husky.EZCreator.editor.getById["editor"].exec("UPDATE_CONTENTS_FIELD", []);
          oEditors.getById["editor"].exec("UPDATE_CONTENTS_FIELD", []);
         
         $("#btnWrite").prop("disabled", true);
         if($("#boardTitle").val().trim().length <= 0)
         {
            alert("제목을 입력하세요.");
            $("#boardTitle").val("");
            $("#boardTitle").focus();
            $("#btnWrite").prop("disabled", false);
            return;
            }
         
         if($("#editor").val().trim().length <= 0)
         {
            alert("내용을 입력하세요.");
            $("#editor").val("");
            $("#editor").focus();
            $("#btnWrite").prop("disabled", false);
            return;
         }
         
          if ($("#mainBoardFile")[0].files.length === 0) {
              alert("다이어리에는 사진이 필요해요!");
            $("#btnWrite").prop("disabled", false);
              return;
          }
          
         var form = $("#writeForm")[0];
         var formData = new FormData(form);
         $.ajax
         ({
            type:"POST",
            enctype:"multipart/form-data",
            url:"/board/diaryWriteProc",
            data:formData,
            processData:false, // 폼데이터를 String타입으로 변환하지 않는다는 것을 정의
            contentType:false, // contentType헤더가 multipart/form-data로 전송
            cache:false, // 캐시 사용 안함
            timeout:600000, // ajax통신 대기 시간
            beforeSend:function(xhr)
            {
               xhr.setRequestHeader("AJAX", "true");
            },
            success:function(response)
            {
               if(response.code == 0)
               {
                  alert("게시물이 등록되었습니다.");
                  location.href = "/board/diaryList"
                  /*
                  document.bbsForm.action = "/board/list";
                  document.bbsForm.submit();   
                  */
               }
               else if(response.code == 400)
               {
                  alert("입력 값이 올바르지 않습니다");
                     $("#boardTitle").focus();
                     $("#btnWrite").prop("disabled", false);
                  return;
               }
               else
               {
                  alert("알 수 없는 오류가 발생하였습니다.");
                  $("#boardTitle").focus();
                     $("#btnWrite").prop("disabled", false);
                  return;
               }
            },
            error:function(error)
            {
               icia.common.error(error);
               alert("게시물 등록 중 오류가 발생하였습니다.");
                  $("#btnWrite").prop("disabled", false);
            }
        });        
      });
   
      $("#btnList").on("click", function() 
      {
      location.href="/board/diaryList";
      });
});

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

            // 이미지 크기 조절
            img.style.maxWidth = "400px"; // 원하는 크기로 변경

            document.querySelector("div#image_container").appendChild(img);
        };
        reader.readAsDataURL(image);
    }
}

</script>
</head>
<body>
<%@ include file="/WEB-INF/views/include/navigation.jsp" %>
<div class="container">
   <form name="writeForm" id="writeForm" method="post" enctype="multipart/form-data">
   <h1>다이어리 작성</h1>
      <input type="text" name="userName" id="userName" maxlength="20" value="${user.userName}" style="ime-mode:active;" class="form-control mt-4 mb-2" placeholder="이름을 입력해주세요." readonly />
      <input type="text" name="userEmail" id="userEmail" maxlength="30" value="${user.userEmail}" style="ime-mode:inactive;" class="form-control mb-2" placeholder="이메일을 입력해주세요." readonly />
      <input type="text" name="boardTitle" id="boardTitle" maxlength="100" style="ime-mode:active;" class="form-control mb-2" placeholder="제목을 입력해주세요." required />
      <div class="form-group">
   <!-- action : 에디터에 입력한 html 코드를 전달받을 Controller페이지 URL -->
    <textarea name="editor" id="editor" rows="10" cols="100" style="width:100%; height:412px; min-width:610px;"></textarea>
      </div>
      <input type="file" id="mainBoardFile" name="mainBoardFile" class="form-control mb-2" placeholder="파일을 선택하세요." multiple="multiple" onchange="setThumbnail(event);" required />
      <div class="form-group row">
         <div class="col-sm-12">
            <button type="button" id="btnWrite" class="btn btn-primary" title="저장" style="border:none;">저장</button>
            <button type="button" id="btnList" class="btn btn-secondary" title="리스트">목록</button>
         </div>
      </div>
   <div id="image_container"></div>
      
   </form>
   
   <form name="bbsForm" id="bbsForm" method="post">
      <input type="hidden" name="searchType" value="" />
      <input type="hidden" name="searchValue" value="" />
      <input type="hidden" name="curPage" value="" />
   </form>
</div>
<footer style="background-color: black; color: lightgray; text-align: center; margin-top:80px; padding: 40px;">
 <a style="font-size:20px; letter-spacing:5px;">《 Dayiary 》 </a> <br>
    &copy; Copyright Dayiary Corp. All Rights Reserved. <br>
    Always with you 🎉 여러분의 일상을 함께합니다.
</footer> 
</body>
</html>