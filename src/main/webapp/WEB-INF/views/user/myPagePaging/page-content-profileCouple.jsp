<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>


 <link rel="stylesheet" href="/resources/css/myPagestyle.css">
<!-- jQuery 라이브러리 로드 -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>


</script>
<style>


</style>
</head>
<body>
    <div class="page-contentmain">
    	<div class="task-box blue" id="profileCard">
        <div class="description-task-img">
          <img src="${url}" alt="Profile Image" class="profile-image" style="border-radius: 50%; width: 100px; height: 100px;">
        </div>
        <div class="description-task-nickname">
         ${user.userNickName}
        </div>
        <div class="more-button"></div>
      </div>
      <div class="task-box blue" id="profileCard">
        <div class="description-task-img">
          <img src="${url}" alt="Profile Image" class="profile-image" style="border-radius: 50%; width: 100px; height: 100px;">
        </div>
        <div class="description-task-nickname">
         ${friend.yourId}
        </div>
        <div class="more-button"></div>
      </div>
    </div>
</body>
</html>