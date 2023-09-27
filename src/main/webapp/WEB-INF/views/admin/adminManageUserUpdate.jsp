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
html, body{
  color:  #525252;
  font-family: 'SUIT-Regular', sans-serif;
  font-size:18px;
}
table{
  width:100%;
  border: 1px solid #c4c2c2;
}
table th, td{
  border-right: 1px solid #c4c2c2;
  border-bottom: 1px solid #c4c2c2;
  height: 4rem;
  padding-left: .5rem;
  padding-right: 1rem;
}
table th{
  background-color: #e0e4fe;
}
input[type=text], input[type=password]{
  height:2rem;
  width: 100%;
  border-radius: .2rem;
  border: .2px solid rgb(204,204,204);
  background-color: rgb(246,246,246);
}
button{
  width: 5rem;
  margin-top: 1rem;
  border: .1rem solid rgb(204,204,204);
  border-radius: .2rem;
  box-shadow: 1px 1px #666;
}
button:active {
  background-color: rgb(186,186,186);
  box-shadow: 0 0 1px 1px #666;
  transform: translateY(1px);
}
</style>
<script type="text/javascript" src="/resources/js/colorBox.js"></script>
<script type="text/javascript">
$(document).ready(function() 
{
   $("#schName").focus();
   
   var contactElements = document.querySelectorAll('.contact-element');
   contactElements.forEach(function(element) {
       var contact = element.textContent.replace(/-/g, ''); // 기존 하이픈 제거
       if(contact.length === 11) { // 11자리 연락처인 경우
           var formattedContact = contact.replace(/(\d{3})(\d{4})(\d{4})/, '$1-$2-$3');
           element.textContent = formattedContact;
       }
   });
   
   var birthdayElements = document.querySelectorAll('.birthday-element');
   birthdayElements.forEach(function(element) {
      var birthday = element.textContent.replace(/\./g, ''); // 기존 점(.) 제거
      if(birthday.length === 8) { // 8자리 생년월일인 경우
          var formattedBirthday = birthday.replace(/(\d{4})(\d{2})(\d{2})/, '$1.$2.$3');
          element.textContent = formattedBirthday;
      }
   });

});

function fn_userUpdate()
{ 
   if(confirm("회원정보를 수정하시겠습니까?"))   
   {   
         if(icia.common.isEmpty($("#userNickName").val()))
         {
            alert("회원 닉네임을 입력하세요.")
            $("#userNickName").val("");
            $("#userNickName").focus();
            return;
         }
         
         if($("#userNickName").val() !== $("#userNickNameCHK").val())
         {
         icia.ajax.post({
            url:"/user/userNickNameAjax",   
            data:{
               userNickName:$("#userNickName").val()      
            },
            datatype:"JSON",
            success:function(response)
            {
               if(response.code == 0)
               {
                  alert("사용 가능한 닉네임입니다.");
                  fn_userUpdateSuccess();
               }
               else if(response.code == 100)
               {
                  alert("중복된 닉네임입니다.");
                  $("#userNickName").focus();
               }
               else if(response.code == 400)
               {
                  alert("입력 값이 올바르지 않습니다.");
                  $("#userNickName").focus();
               }
               else
               {
                  alert("오류가 발생하였습니다.");
                  $("#userNickName").focus();
               }   
            },
            error:function(xhr, status, error)
            {
               icia.common.error(error);   
            }
           });
         }
         else
         {
            fn_userUpdateSuccess();
         }
   }   
}
function fn_userUpdateSuccess()
 { 
   
   var formData = {
         userId:$("#userId").val(),
         userPwd:$("#userPwd").val(),
         userEmail:$("#userEmail").val(),
         userName:$("#userName").val(),
         userNickName:$("#userNickName").val(),
         userPh:$("#userPh").val(),
         userGen:$("#userGen").val(),
         userBir:$("#userBir").val(),               
         status:$("#status").val(),   
         regDate:$("#regDate").val(),
         updateDate:$("#updateDate").val(),
         userAddress:$("#userAddress").val()
   };
   
   
   icia.ajax.post({
      url:"/admin/adminManageUserUpdateProc",
      data:formData,
      success:function(res)
      {
         if(res.code == 0)
         {
            alert("회원정보가 수정 되었습니다.");
            fn_colorbox_close(parent.fn_pageInit);      
         }                                 
         else if(res.code == -1)
         {
            alert("회원정보 수정 중 오류가 발생하였습니다.");
         }
         else if(res.code == 400)
         {
            alert("입력 값이 잘못 되었습니다.");
         }
         else if(res.code == 404)
         {
            alert("회원정보가 존재하지 않습니다.");
            fn_colorbox_close();
         }
      },
      complete:function(data)
      {
         icia.common.log(data);
      },
      error:function(xhr, status, error)
      {
         icia.common.error(error);
      }
   });
   
 }



</script>
</head>
<body>
<div class="layerpopup" style="width:1123px; margin:auto; margin-top:-2%;">
   <h1 style="font-size: 1.6rem; margin-top: 3rem; margin-bottom: 1.6rem; padding: .5rem 0 .5rem 1rem; background-color: #e0e4fe;">유저정보 수정</h1>
   <div class="layer-cont">
      <form name="regForm" id="regForm" method="post">
         <table>
            <tbody>
               <tr>
                  <th scope="row">아이디</th>
                  <td>
                     ${user.userId}
                     <input type="hidden" id="userId" name="userId" value="${user.userId}" />
                  </td>
                  <th scope="row">비밀번호</th>
                  <td>
                      ${user.userPwd}   
                     <input type="hidden" id="userPwd" name="userPwd" value="${user.userPwd}" />
                  </td>
               </tr>
               <tr>
                  <th scope="row">이름</th>
                  <td>
                     ${user.userName}
                     <input type="hidden" id="userName" name="userName" value="${user.userName}" />
                  </td>
                  <th scope="row">이메일</th>
                  <td>
                     ${user.userEmail}
                      <input type="hidden" id="userEmail" name="userEmail" value="${user.userEmail}" />
                  </td>
               </tr>
               <tr>
                  <th scope="row">닉네임</th>
                  <td>
                     <input type="text" id="userNickName" name="userNickName" value="${user.userNickName}" style="font-size:1rem;;" maxlength="50" placeholder="닉네임" />
                      <input type="hidden" id="userNickNameCHK" name="userNickNameCHK" value="${user.userNickName}" />
                  </td>
                  <th scope="row">전화번호</th>
                  <td>
                  <a class="contact-element">${user.userPh}</a>
                     <input type="hidden" id="userPh" name="userPh" value="${user.userPh}" />
                  </td>
               </tr>
               <tr>
                  <th scope="row">성별</th>
                  <td>
                  ${user.userGen}
                     <input type="hidden" id="userGen" name="userGen" value="${user.userGen}" />
                  </td>
                  <th scope="row">생년월일</th>
                  <td>
                  <a class="birthday-element">${user.userBir}</a>
                     <input type="hidden" id="userBir" name="userBir" value="${user.userBir}" />
                  </td>
               </tr>
               <tr>
                  <th scope="row">상태</th>
                  <td>
                     <select id="status" name="status" style="font-size: 1rem; width: 7rem; height: 2rem;">
                        <option value="Y" <c:if test="${user.status == 'Y'}">selected</c:if>>정상</option>   
                        <option value="N" <c:if test="${user.status == 'N'}">selected</c:if>>정지</option>
                     </select>
                  </td>
                  <th scope="row">가입일</th>
                  <td>
                  ${user.regDate}
                  <input type="hidden" id="regDate" name="regDate" value="${user.regDate}" />
                  </td>
               </tr>
               <tr>
                  <th scope="row">수정일</th>
                  <td>
                  ${user.updateDate}
                     <input type="hidden" id="updateDate" name="updateDate" value="${user.updateDate}" />
                  </td>
                  <th scope="row">주소</th>
                  <td>
                  ${user.userAddress}
                     <input type="hidden" id="userAddress" name="userAddress" value="${user.userAddress}" />
                  </td>
               </tr>
            </tbody>
         </table>
      </form>
      <div class="pop-btn-area" style="float: right; margin-top:-10px;">
         <button onclick="fn_userUpdate()" class="btn-type01"><span>수정</span></button>
         <button onclick="fn_colorbox_close()" id="colorboxClose" class="btn-type01" style="margin-left: 1rem;"><span>닫기</span></button>
      </div>
   </div>
</div>
</body>
</html>