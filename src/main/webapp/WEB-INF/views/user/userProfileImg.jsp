<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/head.jsp" %>
<!DOCTYPE html>
<html>
<head>

<script>
document.addEventListener('DOMContentLoaded', function() {
    // 프로필 사진을 클릭하면 숨겨진 파일 업로드를 클릭하는 것처럼 처리
    document.querySelector('.profile-image').addEventListener('click', function() {
        document.getElementById('profileImageInput').click();
    });

    // 파일을 선택하면 선택된 이미지를 프로필 사진으로 변경
    document.getElementById('profileImageInput').addEventListener('change', function(event) {
        const file = event.target.files[0];
        if (file) {
            const reader = new FileReader();
            reader.onload = function(e) {
                document.querySelector('.profile-image').src = e.target.result;
            }
            reader.readAsDataURL(file);
        }
    });
});
$(document).ready(function() {
$("#btnUpdateProfileImg").on("click", function(e) 
{
    e.preventDefault(); // 기본 submit 이벤트를 막습니다.


    var form = $("#uploadprofile")[0];
    var formData = new FormData(form);
    

    
    $.ajax({
        type: "POST",

      enctype:"multipart/form-data",
        url: "/user/uploadProfileImage",
        data: formData,
        processData: false,
        contentType: false,
        cache: false,
        timeout: 600000,
        beforeSend: function(xhr) {
            xhr.setRequestHeader("AJAX", "true");
        },
        success: function(response) {
            if (response.code == 0) {
                alert("이미지가 성공적으로 업로드되었습니다.");
                window.close();
                window.opener.location.reload();  // 부모 페이지를 새로고침

                
                
                
            } else {
                alert("이미지 업로드 중 오류 발생");
            }
        },
        error: function(error) {
            alert("이미지 업로드 중 오류가 발생하였습니다.");
        }
    });
});
});

function setThumbnail(event) {
    var file = event.target.files[0];
    if (file) {
        var reader = new FileReader();
        reader.onload = function(e) {
            document.querySelector('.profile-image').src = e.target.result;
        }
        reader.readAsDataURL(file);
    }
}

</script>

<style>
    @import url('https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100;300;400;500;700&display=swap');

    *{
        box-sizing: border-box;
        outline: none;
    }

   .profile-image {
    width: 300px;  /* Adjust width as required */
    height: 300px; /* Adjust height as required */
    display: block;
    margin: 0 auto;  /* Center the image horizontally */
    border-radius: 50%;  /* Make the image circular */
    object-fit: cover;
}
   
    body{
        font-family: 'Noto Sans KR', sans-serif;
        font-size:16px;
        background-color : white !important; 
        line-height: 1.5em;
        color : #222;
        margin: 0;
    }
    
    b {
        color: black;
    }

    a{
        text-decoration: none;
        color: #222;
    }

    p{
        margin: 1px;
        color: red;
        font-size: 12px;
    }
    h2 
   {
      color: black;
   }

    .member {
        width: 400px;
        margin: auto;
        padding: 0 20px;
        margin-bottom: 20px;
    }

    .member .logo {
        margin : 20px auto;
        width: 130px;
        height: 100px;
    }

    .member .field {
        margin : 5px 0;
    }

    .member b {
        display: block;
        margin-bottom: 5px;
    }

    .member input:not(input[type=radio]), 
    .member select {
        border: 1px solid #dadada;
        padding: 15px;
        width: 100%;
    }

    .member input[type=button], .member input[type=submit] {
        background-color: #9dafeb;
        text-align: center;
        display: flex;
        align-items: center;
        justify-content: center;
        color:#fff;
    }

    .member input:focus, .member select:focus {
        border: 1px solid #9dafeb;
    }

    @media (max-width:768px) {
        .member {
            width: 100%;
        }
          .member .logo {
        width: 130px;
        height: 100px;
    }
        
    }
</style>

</head>
   <body>
   <form id="uploadprofile" name="uploadprofile"  method="post" enctype="multipart/form-data">
       <div class="member">
           <a href="/user/login"><img style="width: 250px; height: 100px;" class="logo" src="../resources/images/logo.gif"></a>
           <h2>프로필 이미지 변경</h2>
           <div class="profile-section1">
    
               <img src="${url}" alt="Profile Image" class="profile-image">
               <!-- display:none; 로 숨기기 -->
               <input id="profileImageInput" name="profileImage" type="file" style="display:none;" accept="image/*" onchange="setThumbnail(event);" required>
               <h3 class="profile-name"></h3>
           </div>
           <!-- 프로필사진 변경적용 버튼 -->
           <input type="button" value="프로필사진 변경적용" id="btnUpdateProfileImg" name="btnUpdateProfileImg" style="background-color: #e165f9" />
          <input type="hidden" name="userId"  value="${user.userId}">
       </div>
   </form>
   </body>
</html>