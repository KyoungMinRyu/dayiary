<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<style>
   
   .navbar {
     display: flex;
     justify-content: center;
     align-items: center;
     height: 70px; 
     background-color:black;
     text-decoration: none;
     position: fixed; 
     top: 0; 
     left: 0; 
     width: 100%;
     z-index:99;
     padding:0px !important;
   }
   
   .nav-list
   {
     display: flex;
     gap:100px;
     font-family: 'SUIT-Regular', cursive; 
     font-size: 20px;
     text-decoration: none;
     letter-spacing: 2px;
     color: #fff;
     list-style: none;
     margin-bottom:0;
     margin-top:0;
     padding:0;
   }
   
   .nav-list li a {
     color: white; /* 링크 글자 색상을 흰색으로 설정 */
     text-decoration: none; /* 밑줄 제거 */
     margin-bottom:0;
     margin-top:0;
     padding:0;
   }
   
   .nav-list a:hover {
     color: #ffc107; /* 마우스 오버시 색상 변경 */
   }
   
    @font-face {
      font-family: 'SUIT-Regular'; /* 고딕 */
      src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_suit@1.0/SUIT-Regular.woff2') format('woff2');
      font-weight: 100;
        font-style: normal;
    }
   
   .right {
     display: flex;
     position: absolute; 
     top:20px;
     right: 50px;
     list-style: none;
     font-size:20px;
     margin-bottom:0;
     margin-top:0;
     padding:0;
    } 
    
.confetti
{
	color: white; /* 링크 글자 색상을 흰색으로 설정 */
    text-decoration: none; /* 밑줄 제거 */
    margin-bottom:0;
    margin-top:0;
    padding:0;
    font-size: 35px;
}
</style>

<nav class="navbar">
	<div style="display: flex; align-items: center;">
    	<a href="/index/adminIndex">
        	<div style="display: flex; position: absolute; top: 0; left: 0; padding: 10px; margin-left: 5px;"> <!-- .confetti 클래스 추가 -->
            	<span class="confetti">D</span> <!-- .confetti 클래스 추가 -->
              	<span class="confetti">A</span> <!-- .confetti 클래스 추가 -->
	            <span class="confetti">Y</span> <!-- .confetti 클래스 추가 -->
	            <span class="confetti">i</span> <!-- .confetti 클래스 추가 -->
	            <span class="confetti">a</span> <!-- .confetti 클래스 추가 -->
	            <span class="confetti">r</span> <!-- .confetti 클래스 추가 -->
	            <span class="confetti">y</span> <!-- .confetti 클래스 추가 -->
        	</div>
    	</a>
	</div>
          <ul class="nav-list">
            <li><a href="/notice/adminNotice">Notice</a></li>
            <li><a href="/inquiry/inquiryList">QnA</a></li>
            <li><a href="/admin/adminManageUserList">Member Management</a></li>
            <li><a href="/admin/adminRestoList">Resto Management</a></li>
            <li><a href="/admin/adminGiftList">Gift Management</a></li>
            </ul>
         <ul class="right">
         <li><b style="color: #FFF; text-decoration: underline; margin-left: 5px; display: inline-block; vertical-align: middle;">
         <img src="../resources/images/adm.png"  style="width: 25px; height: 30px; margin-right:5px;" >관리자</b></li>
         <li style="margin-left: 20px;"><a href="/user/logout">
            <img alt="" src="/resources/images/logout3.png" style="width: 70px; height: 60px; margin-top:-15px;"></a></li>
          </ul>
</nav>