<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<%
   // 개행문자 값을 저장한다.
   pageContext.setAttribute("newLine", "\n");
%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" type="text/css" href="/resources/css/diaryList.css">
<%@ include file="/WEB-INF/views/include/head.jsp" %>
<style>
  .btn-container {
    display: flex;
    justify-content: space-between;
    align-items: center;
    flex-direction: column-reverse;
    align-items: stretch;
  }

.left-btns button {
  margin-right: 5px; /* 여기서 10px은 원하는 간격으로 조절 가능합니다. */
}

  .left-btns {
    display: flex;
    align-items: center;
  }

  .center-btn {
    display: flex;   
    flex-direction: column;
    align-items: center;
  }

  .center-btn img {
    width: 30px;
    height: 30px;
    margin-top: 5px;
  }
</style>

<script type="text/javascript">
$(document).ready(function() {

   
   $("#btnList").on("click", function() {
      document.bbsForm.action = "/board/diaryList";
      document.bbsForm.submit();
   });

   $("#btnUpdate").on("click", function() {
      document.bbsForm.action = "/board/diaryUpdateForm";
      document.bbsForm.submit();
   });
   
   $("#btnDelete").on("click", function(){
      if(confirm("게시물을 삭제하시겠습니까?") == true)
      {
         $.ajax({
           type:"POST",
           url:"/board/diaryDelete",
           data:
           {
              boardSeq:<c:out value="${boardSeq}" />
           },
           dataType:"JSON",
           beforeSend:function(xhr)
           {
              xhr.setRequestHeader("AJAX", "true");
           },
           success:function(response)
           {
              if(response.code == 0)
              {
                 alert("게시물이 삭제 되었습니다.");
                 location.href = "/board/diaryList";
              }
              else if(response.code == 400)
              {
                 alert("파라미터 값이 올바르지 않습니다.");
              }
              else if(response.code == 403)
              {
                 alert("본인의 게시물만 삭제할 수 있습니다.");
              }
              else if(response.code == 404)
              {
                 alert("해당 게시물을 찾을 수 없습니다.");
                 location.herf = "/board/diaryList";
              }
              else if(response.code == -999)
              {
                 alert("답글이 있는 게시물은 삭제할 수 없습니다.");
              }
              else
              {
                 alert("게시물 삭제 중 오류가 발생하였습니다.");
              }
           },
           error:function(xhr, status, error)
           {
              icia.common.error(error);
           }
           
         });
      }
   });
   
    //댓글 작성 버튼 클릭시
     $("#btnComment").on("click", function() 
              {
                 if($("#commentContent").val().trim().length <= 0)
                 {
                    alert("댓글 내용을 입력하세요.");
                    $("#commentContent").val("");
                    $("#commentContent").focus();
                    return;
                 }
                  
                 var form = $("#commentForm")[0];
                 var formData = new FormData(form);
                 formData.append("boardSeq", "${boardSeq}"); //게시물번호도 같이 보냄
                 $.ajax
                 ({
                    type:"POST",
                    url:"/board/commentWriteProc",
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
                          alert("댓글이 등록되었습니다.");
                          $("#commentContent").val("");
                          location.reload();
                          /*
                          location.href = "/board/diaryList" 또는
                          document.bbsForm.action = "/board/list";
                          document.bbsForm.submit();   
                          */
                       }
                       else if(response.code == 400)
                       {
                          alert("입력 값이 올바르지 않습니다");
                             $("#commentContent").focus();
                          return;
                       }
                       else
                       {
                          alert("알 수 없는 오류가 발생하였습니다.");
                          $("#commentContent").focus();
                          return;
                       }
                    },
                    error:function(error)
                    {
                       icia.common.error(error);
                       alert("댓글 등록 중 오류가 발생하였습니다.");
                    }
                });        
              });
    
});

function fn_commentDelete(commentSeq) //댓글 삭제 버튼 클릭시
{

       if(confirm("댓글을 삭제하시겠습니까?") == true)
       {
          $.ajax({
            type:"POST",
            url:"/board/diaryCommentDelete",
            data:
            {
              boardSeq: <c:out value="${boardSeq}" />,
                 commentSeq: commentSeq // 삭제버튼 누른 해당 댓글의 commentSeq 값을 전송
            },
            dataType:"JSON",
            beforeSend:function(xhr)
            {
               xhr.setRequestHeader("AJAX", "true");
            },
            success:function(response)
            {
               if(response.code == 0)
               {
                  alert("댓글이 삭제 되었습니다.");
                  location.reload();
               }
               else if(response.code == 400)
               {
                  alert("파라미터 값이 올바르지 않습니다.");
               }
               else if(response.code == 403)
               {
                  alert("본인의 댓글만 삭제할 수 있습니다.");
               }
               else if(response.code == 404)
               {
                  alert("해당 댓글을 찾을 수 없습니다.");
                  location.reload();
               }
               else if(response.code == 1)
               {
                  alert("- 댓글이 삭제 되었습니다.");
                  
                  location.reload();

                  var deletedCommentSeq = commentSeq;

                  // 답글 버튼 숨김 처리
                  var replyButton = document.getElementById("btnCommentReply_" + deletedCommentSeq);
                  if (replyButton) {
                    replyButton.style.display = "none";
                  }

                  // 수정 버튼 숨김 처리
                  var updateButton = document.getElementById("btnCommentUpdate_" + deletedCommentSeq);
                  if (updateButton) {
                    updateButton.style.display = "none";
                  }

                  // 삭제 버튼 숨김 처리
                  var deleteButton = document.getElementById("btnCommentDelete_" + deletedCommentSeq);
                  if (deleteButton) {
                    deleteButton.style.display = "none";
                  }
               }
               else
               {
                  alert("댓글 삭제 중 오류가 발생하였습니다.");
               }
            },
            error:function(xhr, status, error)
            {
               icia.common.error(error);
            }
            
          });
       }
}

function fn_commentUpdate(commentSeq) //댓글 수정 버튼 클릭시
{
    var commentContentElement = document.getElementById("commentContent_" + commentSeq);
    var commentContent = commentContentElement.getAttribute("value");
       
       
       //원래 댓글창을 textarea수정창으로 변경 - id: updateContent_commentSeq
       $("#commentContent_" + commentSeq).replaceWith("<textarea class='form-control' id='updateContent_" + commentSeq + "' style='width:1000px;' rows='3'>" 
             + commentContent + "</textarea>");
       
       var completeButton = $("<button>", {
           type: "button",
           class: "btnUpdateComplete",
           text: "수정 완료",
           click: function() {
               var updateCommentContent = $("#updateContent_" + commentSeq).val();
               fn_updateComplete(commentSeq, updateCommentContent); //댓글시퀀스랑 수정창내용 같이 fn_updateComplete로 보냄
           }
       });
       
       $("#btnCommentUpdate_" + commentSeq).replaceWith(completeButton);

}

function fn_updateComplete(commentSeq, updateCommentContent) //수정 완료 버튼 클릭시
{

          $.ajax({
            type:"POST",
            url:"/board/diaryCommentUpdate",
            data:
            {
              boardSeq: <c:out value="${boardSeq}" />,
                 commentSeq: commentSeq, // 수정버튼 누른 해당 댓글의 commentSeq 값을 전송
                 updateCommentContent: updateCommentContent //수정한 댓글 내용 전송
            },
            dataType:"JSON",
            beforeSend:function(xhr)
            {
               xhr.setRequestHeader("AJAX", "true");
            },
            success:function(response)
            {
               if(response.code == 0)
               {
                  alert("댓글이 수정 되었습니다.");
                  location.reload();
               }
               else if(response.code == 400)
               {
                  alert("파라미터 값이 올바르지 않습니다.");
               }
               else if(response.code == 403)
               {
                  alert("본인의 댓글만 수정할 수 있습니다.");
               }
               else if(response.code == 404)
               {
                  alert("해당 댓글을 찾을 수 없습니다.");
                  location.reload();
               }
               else
               {
                  alert("댓글 수정 중 오류가 발생하였습니다.");
               }
            },
            error:function(xhr, status, error)
            {
               icia.common.error(error);
            }
            
          });
}

//댓글의 답글 버튼 눌렀을때
function fn_commentReply(commentSeq) {
    var replyFormId = "replyForm_" + commentSeq; //답글폼
    var replyButtonId = "btnCommentReply_" + commentSeq; //답글버튼
    

    // 이미 답글 작성 폼이 열려있는지 확인
    if ($("#" + replyFormId).length === 0) {
       
       // 이제 답글 입력할거니까 답글버튼은 잠시 숨김처리
        $("#" + replyButtonId).hide();
       
        // 답글 작성 폼 생성 및 추가
        var replyForm = $("<form>", {
            id: replyFormId,
            method: "post",
            style: "margin-top: 10px;"
        });
        
         //답글 내용을 입력할 textarea
        var replyTextarea = $("<textarea>", {
            class: "form-control",
            name: "replyContent",
            id: "replyContent_" + commentSeq, 
            width: "1000px",
            rows: "3",
            placeholder: "답글을 입력해주세요."
        });
      
         //답글 완료 버튼
        var replyButton = $("<button>", {
            type: "button",
            class: "btn btn-primary",
            text: "답글 확인",
            click: function() {
               var replyCommentContent = $("#replyContent_" + commentSeq).val();
               fn_commentReplyComplete(commentSeq, replyCommentContent); 
           }
        });
        
         //입력취소 시
        var cancelButton = $("<button>", {
            type: "button",
            class: "btn btn-secondary ml-2",
            text: "취소",
            click: function () {
                // 답글입력폼 닫음
                $("#" + replyFormId).remove();
                //답글버튼 다시 나타나게
                $("#" + replyButtonId).show(); 
            }
        });

        replyForm.append(replyTextarea);
        replyForm.append(replyButton);
        replyForm.append(cancelButton);

        // 댓글 밑에 답글 작성 폼 추가. 답글폼을 실제 여는부분
        $("#commentContent_" + commentSeq).after(replyForm);
        
    }
}

//답글 작성 완료 버튼 눌렀을시
function fn_commentReplyComplete(commentSeq, replyCommentContent)
{
   
   if (replyCommentContent === null || replyCommentContent === "") 
   {
      alert("답글 내용을 입력하세요.");
        return;
    }

      $.ajax
       ({
          type:"POST",
          url:"/board/diaryReplyComment",
          data:
          {
             boardSeq: <c:out value="${boardSeq}" />,
              commentSeq: commentSeq,
              replyCommentContent: replyCommentContent
          },
        dataType:"JSON",
        beforeSend:function(xhr)
        {
           xhr.setRequestHeader("AJAX", "true");
        },
        success:function(response)
          {
             if(response.code == 0)
             {
                alert("답글이 작성 되었습니다.");
                location.reload();
                /*
                document.bbsForm.action = "/board/list";
                document.bbsForm.submit();   
                */
             }
             else if(response.code == 400)
             {
                alert("파라미터 값이 올바르지 않습니다");
                $("#replyContent_" + commentSeq).focus();
                return;
             }
             else if(response.code == 403)
             {
                alert("본인 댓글이 아닙니다.");
                $("#replyContent_" + commentSeq).val();
             }
             else if(response.code == 404)
             {
                alert("게시물을 찾을 수 없습니다.");
                location.href = "/board/diaryList";
             }
             else
             {
                alert("알 수 없는 오류가 발생하였습니다.");
                $("#replyContent_" + commentSeq).focus();
                return;
             }
          },
          error:function(error)
          {
             icia.common.error(error);
             alert("답글 입력 중 오류가 발생하였습니다.");
          }
          
       });
   
}

function fn_like(boardSeq) {
    $.ajax({
        type: "POST",
        url: "/board/diaryLike",
        data: {
            boardSeq: boardSeq,
            likeCheck: 1
        },
        success: function(response) {
            if (response.code === 0) {
                $("#btnUnLike").show();
                $("#btnLike").hide();
                $("#btnUnLike span").text(response.data);
            }
        },
        error: function(error) {
            console.error("Error sending like status to server:", error);
        }
    });
}

function fn_unlike(boardSeq) {
    $.ajax({
        type: "POST",
        url: "/board/diaryLike",
        data: {
            boardSeq: boardSeq,
            likeCheck: 0
        },
        success: function(response) {
            if (response.code === 0) {
                $("#btnLike").show();
                $("#btnUnLike").hide();
                $("#btnLike span").text(response.data);
            }
        },
        error: function(error) {
            console.error("Error sending unlike status to server:", error);
        }
    });
}


</script>
</head>
<body>

<%@ include file="/WEB-INF/views/include/navigation.jsp" %>
<div class="container" style="margin-top:140px; padding-top:90px;">
   <div class="container2">
   <h1>다이어리</h1>
   <div class="row" style="margin-right:0; margin-left:0;">
      <table class="table">
         <thead>
            <tr class="table-active">
               <th scope="col" style="width:60%; font-size:20px;" >
                  <c:out value="${mainBoard.boardTitle}" /><br/>
                  <c:out value="${mainBoard.userNickName}(${mainBoard.userName})" />&nbsp;&nbsp;&nbsp;
                  <a href="mailto:${mainBoard.userEmail}" style="color:#828282;">${mainBoard.userEmail}</a>                 
               </th>
               <th scope="col" style="width:40%" class="text-right">
                  조회 : <fmt:formatNumber type="number" maxFractionDigits="3" value="${mainBoard.readCnt}" /><br/>
                  ${mainBoard.regDate}
               </th>
            </tr>
         </thead>
         <tbody>
            <tr>
               <td>${mainBoard.boardContent}
               <!-- <td colspan="2"><pre><c:out value="${mainBoard.boardContent}" /></pre> -->
               <c:forEach items="${mainBoard.mainBoardFile}" var="file">
               <img src="/resources/upload/${file.fileName}" alt="noImage" style="max-width:500px;">
               <br><br />
               </c:forEach>
               </td>
            </tr>
         </tbody>
         <tfoot>
         <tr>
               <td colspan="2"></td>
           </tr>
         </tfoot>
      </table>
   </div>

<div class="btn-container">
  <div class="left-btns">
    <button type="button" id="btnList" class="btn btn-secondary">목록</button>
    <c:if test ="${boardMe eq 'Y'}">
      <button type="button" id="btnUpdate" class="btn btn-secondary">수정</button>
      <button type="button" id="btnDelete" class="btn btn-secondary">삭제</button>
    </c:if>
  </div>
  <div class="center-btn">
  
     <c:if test="${likeCheck eq 0}"> <!-- 내가 좋아요 누르지 않은 글이면 -->
    <button type="button" id="btnLike" class="btnLike" onclick="fn_like(${boardSeq})"> 좋아요 
      <img src="/resources/images/unlike.png" alt="Like" style="margin-bottom:5px;" /> 
      <span>${likeCount}</span>
    </button>
    
    <button type="button" id="btnUnLike" class="btnUnLike" style="display: none;" onclick="fn_unlike(${boardSeq})"> 좋아요 
       <img src="/resources/images/like.png" alt="Like" style="margin-bottom:5px;" />
       <span></span>
    </button>
    </c:if>
    
    <c:if test="${likeCheck eq 1}"> <!-- 내가 좋아요 누른 글이면 -->
    <button type="button" id="btnUnLike" class="btnUnLike" onclick="fn_unlike(${boardSeq})"> 좋아요
       <img src="/resources/images/like.png" alt="Like" style="margin-bottom:5px;" /> 
       <span>${likeCount}</span>
    </button>
    
    <button type="button" id="btnLike" class="btnLike" style="display: none;" onclick="fn_like(${boardSeq})"> 좋아요
       <img src="/resources/images/unlike.png" alt="Like" style="margin-bottom:5px;" /> 
       <span></span>
    </button>
    </c:if>    
    
  </div>
</div>

<br/>
<br/>
   

<div class="comments" id="comments">
  <div class="comments-body" style="background-color:white; padding:50px; padding-top:20px;">
    <!-- 댓글 작성 창 -->
    <a href="#comment"></a>
    <form name="commentForm" id="commentForm" method="post">
      <div class="form-group">
        <label style="font-size:25px;"> C O M M E N T </label>
        <textarea class="form-control" id="commentContent" name="commentContent" rows="3" placeholder="댓글을 입력해주세요."></textarea>
      </div>
      <button type="button" class="btn btn-primary" id="btnComment" style="background-color:black; color:white; border:none;">댓글 작성</button>
    </form>
    <!-- 댓글 목록 출력-->
<c:if test="${!empty commentList}">      <!--list 객체가 비어있지 않을때 실행-->
      <c:forEach var="commentList" items="${commentList}">
<ul class="list-unstyled">
    <li class="media mt-4" style="margin-left:${commentList.commentIndent * 3}em;"><!-- Indent가 0이 아니면(답댓글이라면), Indent만큼 뒷줄로 밀어줌 -->
        <img src="${commentList.fileName}" style="width: 65px; height:65px; object-fit:cover; border-radius:20px;" class="mr-3" alt="avata">
        <div class="media-body" style="display: flex; justify-content: space-between; align-items: center;">
            <div>
                <h5 class="mt-0 mb-1" style="font-weight: bold; display: inline;">${commentList.userNickName}(${commentList.userName})</h5>
                <p style="margin-top: -15px; margin-left:10px; color: lightgray; display: inline;">${commentList.regDate}</p>
            <c:if test="${commentList.status eq 'Y'}">    
                <p id="commentContent_${commentList.commentSeq}" style="font-size: 17px; margin-top: 3px; max-width:1000px; overflow-wrap: break-word;" value="${commentList.commentContent}">${commentList.commentContent}</p>
              </c:if>
              <c:if test="${commentList.status eq 'N'}">
                <p id="commentContent_${commentList.commentSeq}" style="font-size: 17px; margin-top: 3px; max-width:1000px; color:gray;  text-decoration:line-through;" value="${commentList.commentContent}">${commentList.commentContent}</p>
              </c:if>
              <c:if test="${commentList.status eq 'Y'}">
                 <button type="button" class="btnCommentReply" id="btnCommentReply_${commentList.commentSeq}" style="width:60px; height:30px;" onclick="fn_commentReply(${commentList.commentSeq})"> 답글
                 <img src="/resources/images/icon_reply.gif" alt="버튼 이미지" /></button>
              </c:if>
            </div>
            <c:if test="${commentList.userId eq cookieUserId && commentList.status eq 'Y'}">
            <div class="media-body2">
               <button type="button" class="btnCommentUpdate" id="btnCommentUpdate_${commentList.commentSeq}" onclick="fn_commentUpdate(${commentList.commentSeq})">수정</button>
               <button type="button" class="btnCommentDelete" id="btnCommentDelete_${commentList.commentSeq}" onclick="fn_commentDelete(${commentList.commentSeq})">삭제</button>
            </div>
            </c:if>
        </div>
    </li>
</ul>
</c:forEach>
</c:if>
  </div>
</div>
</div>

</div>

<form name="bbsForm" id="bbsForm" method="post">
   <input type="hidden" name="boardSeq" value="${boardSeq}" />
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