<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en" >
<head>
 <%@ include file="/WEB-INF/views/include/head.jsp" %>
 
<link href='https://fonts.googleapis.com/css?family=Open+Sans' rel='stylesheet' type='text/css'>
<style>

@font-face {
    font-family: 'SUIT-Regular'; /* 고딕 */
    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_suit@1.0/SUIT-Regular.woff2') format('woff2');
    font-weight: 100;
    font-style: normal;
} 


* {
  margin: 0;
  padding: 0;
  box-sizing: border-box;
  font-family: 'SUIT-Regular', sans-serif;
}

body
{
  background-image: url('/resources/images/loginBg.png');
  background-size: cover;
  background-position: center;
}

section {
  position: relative;
  min-height: 100vh;
  display: flex;
  justify-content: center;
  align-items: center;
}
.container {
  position: relative;
  width: 1100px;
  height: 600px;
  box-shadow: 10px 15px 50px rgba(0, 0, 0, 0.4);
  overflow: hidden;
  border-radius:35px;
}
.container .user {
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  display: flex;
}
.container .user .imgBx {
  position: relative;
  width: 50%;
  height: 100%;
  background: #ff0;
  transition: 0.5s;
}
.container .user .imgBx img {
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  object-fit: cover;
}
.container .user .formBx {
  position: relative;
  width: 50%;
  height: 100%;
  background: #fff;
  display: flex;
  justify-content: center;
  align-items: center;
  padding: 40px;
  transition: 0.5s;
}
.container .user .formBx form h2 {
  font-size: 20px;
  font-weight: 600;
  text-transform: uppercase;
  letter-spacing: 2px;
  text-align: center;
  width: 100%;
  margin-bottom: 10px;
  color: #555;
}
.container .user .formBx form input {
  position: relative;
  width: 100%;
  padding: 10px;
  background: #f5f5f5;
  color: #333;
  border: none;
  outline: none;
  box-shadow: none;
  margin: 8px 0;
  font-size: 18px;
  letter-spacing: 1px;
  font-weight: 300;
}
.container .user .formBx form input[type="button"] {
  max-width: 470px;
  background: black;
  color: #fff;
  cursor: pointer;
  font-size: 20px;
  font-weight: 500;
  letter-spacing: 1px;
  transition: 0.5s;
  margin-top:25px;
}
.container .user .formBx form .signup {
  position: relative;
  margin-top: 20px;
  font-size: 15px;
  letter-spacing: 2px;
  color: #00000;
  text-transform: uppercase;
}
.container .user .formBx form .signup a {
  font-weight: 600;
  text-decoration: none;
  color: #00000;
}

p.signup
{
   display: flex;
    justify-content: center;
}

p.signup a:hover {
  color: #bbbbbb;
}

p.signup a
{
   color:black;
}


.button__login-type {
  background-color:white;
  color: black; 
  border: none;
  padding: 10px 20px; 
  cursor: pointer;
  transition: background-color 0.3s; 
  font-weight: bold;
  width: 222px; 
  margin-bottom:10px;
  border:outset;
}

.button__login-type:hover {
   background-color:#bbbbbb;
}

.button__login-type.selected {
  background-color: black;
  color:white;
}

a:not(:last-child)::after {
  content: " | "; /* 작대기 문자 또는 다른 구분자를 여기에 입력하세요 */
  margin: 0 5px; /* 작대기 주변 여백 조절 */
}

button
{
   font-size: 18px;
}

  </style>
  
  <script type="text/javascript">
  <%
  String msg = com.icia.web.util.CookieUtil.getValue(request, "msg");

  if (msg != null && !msg.isEmpty()) 
  {
  %>
       alert("<%= msg %>");
  <%   
        com.icia.web.util.CookieUtil.deleteCookie(request, response, "/", "msg");
  }
  %>
  
  $(document).ready(function() {
      
      $("#userId").focus();
      
      //로그인 버튼 선택시
      $("#btnLogin").on("click", function() {
         if ($("#tabseller").hasClass("selected"))
          {
              // 판매자 버튼이 선택된 경우
            fn_sellerloginCheck();
          }
          else 
          {
              // 판매자 버튼이 선택되지 않은 경우 (일반 회원의 경우)
             fn_loginCheck();  
          }
         
      });
      
     
      
      // 회원가입 버튼 선택시
      $("#btnReg").on("click", function() {
          if ($("#tabseller").hasClass("selected"))
          {
              // 판매자 버튼이 선택된 경우
              location.href = "/seller/signUp";
          }
          else 
          {
              // 판매자 버튼이 선택되지 않은 경우 (일반 회원의 경우)
              location.href = "/user/signUp";   
          }
      });
   });


//일반회원 로그인 
function fn_loginCheck()
{
   if($.trim($("#userId").val()).length <= 0)
   {
      alert("아이디를 입력하세요.");
      $("#userId").focus();
      return;
   }
   
   if($.trim($("#userPwd").val()).length <= 0)
   {
      alert("비밀번호를 입력하세요.");
      $("#userPwd").focus();
      return;

   }
   
      $.ajax({ //spring 에선 아이디 비밀번호를 ajax 통신으로 넘김 ! ! 
            type:"POST",
            url:"/user/loginProc", //distpatcher servlet이 받아서 user controllor로 감 
            data:{
               userId:$("#userId").val(),
               userPwd:$("#userPwd").val()
            },
            datatype:"JSON",
            beforeSend:function(xhr){
               xhr.setRequestHeader("AJAX", "true");
            },
            success:function(response){
               if(!icia.common.isEmpty(response))
               {
                  var code = icia.common.objectValue(response, "code", -500);
                  
                  if(code == 0)
                  {
                    location.href = "/index";
                  }
                  else if(code == 1)
                  {
                     location.href = "/index/adminIndex";
                  }
                  else
                  {
                     if(code == -1)
                     {
                        alert("일치하는 정보가 없습니다.");
                        $("#userPwd").focus();
                     }
                     else if(code == 404)
                     {
                        alert("일치하는 정보가 없습니다.");
                        $("#userId").focus();
                     }
                     else if(code == 400)
                     {
                        alert("입력 값이 올바르지 않습니다.");
                        $("#userId").focus();
                     }
                     else
                     {
                        alert("오류가 발생하였습니다.");
                        $("#userId").focus();
                     }
                  }
               }
               else
               {
                  alert("오류가 발생하였습니다.");
                  $("#userId").focus();
               }
            },
            error:function(xhr, status, error)
            {
               icia.common.error(error);
            }

   });
}


//판매자로그인
function fn_sellerloginCheck()
{
   if($.trim($("#userId").val()).length <= 0)
   {
      alert("아이디를 입력하세요.");
      $("#userId").focus();
      return;
   }
   
   if($.trim($("#userPwd").val()).length <= 0)
   {
      alert("비밀번호를 입력하세요.");
      $("#userPwd").focus();
      return;

   }
   
      $.ajax({ //spring 에선 아이디 비밀번호를 ajax 통신으로 넘김 ! ! 
            type:"POST",
            url:"/seller/loginProc", //distpatcher servlet이 받아서 user controllor로 감 
            data:{
               userId:$("#userId").val(),
               userPwd:$("#userPwd").val()
            },
            datatype:"JSON",
            beforeSend:function(xhr){
               xhr.setRequestHeader("AJAX", "true");
            },
            success:function(response){
               if(!icia.common.isEmpty(response))
               {
                  var code = icia.common.objectValue(response, "code", -500);
                  
                  if(code == 0)
                  {
                     location.href = "/index/sellerIndex"; 
                  }
                  else
                  {
                     if(code == -1)
                     {
                        alert("일치하는 정보가 없습니다.");
                        $("#userPwd").focus();
                     }
                     else if(code == 404)
                     {
                        alert("일치하는 정보가 없습니다.");
                        $("#userId").focus();
                     }
                     else if(code == 400)
                     {
                        alert("입력 값이 올바르지 않습니다.");
                        $("#userId").focus();
                     }
                     else
                     {
                        alert("오류가 발생하였습니다.");
                        $("#userId").focus();
                     }
                  }
               }
               else
               {
                  alert("오류가 발생하였습니다.");
                  $("#userId").focus();
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


document.addEventListener('DOMContentLoaded', function() {
    document.querySelectorAll('.button__login-type').forEach(button => {
        button.addEventListener('click', function() {
            document.querySelector('.button__login-type.selected')?.classList.remove('selected');
            this.classList.add('selected');
        });
    });

    // 이 부분을 바깥으로 빼서 한 번만 실행되게 함

});


function showPopup(type) {
    var isUserSelected = document.getElementById('tabUser').classList.contains('selected');
    var isSellerSelected = document.getElementById('tabseller').classList.contains('selected');
   
    if (type === 'lostId' && isUserSelected) 
    {
        window.open("/user/lostId", "아이디찾기", "width=600, height=490, left=650, top=150"); 
    } 
    else if (type === 'lostPwd' && isUserSelected)
    {
        window.open("/user/lostPwd", "비밀번호찾기", "width=600, height=580, left=650, top=150"); 
    }
    else if (type === 'lostId' && isSellerSelected) 
    {
        window.open("/seller/sellerlostId", "아이디찾기", "width=600, height=490, left=650, top=150"); 
    }
    else if (type === 'lostPwd' && isSellerSelected)
    {
        window.open("/seller/sellerlostPwd", "비밀번호찾기", "width=600, height=580, left=650, top=150"); 
    }
    else
    {
       alert("회원, 판매자를 선택하십시요.");
    }   
}





</script>
</head>
<body>

<%@ include file="/WEB-INF/views/include/navigation.jsp" %>
<!-- partial:index.partial.html -->
<input type="radio" checked id="toggle--login" name="toggle" class="ghost" />
  <input type="radio" id="toggle--signup" name="toggle" class="ghost" />

    <section>
      <div class="container">
      
        <div class="user signinBx">
          <div class="imgBx"><img src="/resources/images/diary.jpg" /></div>
          <div class="formBx">
            <form>
            
                
    <div class="box__member-type">
    <div class="box__login-type" role="tablist" aria-label="회원/판매자 로그인">
    
    <button type="button" class="button__login-type selected" data-montelena-acode="200008560" 
    role="tab" aria-selected="true" aria-controls="memberTypeUser" id="tabUser">일반회원</button>
    <button type="button" class="button__login-type" data-montelena-acode="200008561" 
    role="tab" aria-selected="false" aria-controls="memberTypeGuest" id="tabseller" >판매자</button>
    </div>
   </div>
 
              <input type="text" name="userId" id="userId" placeholder="ID" />
              <input type="password" name="userPwd" id="userPwd" placeholder="Password" />
              <input type="button" name="btnLogin" id="btnLogin" value="Login" />
              <p class="signup">
                <a class="text text--small text--border-right" href="javascript:;" id="btnReg">회원가입</a>
                <a class="text text--small text--border-right" href="javascript:;" id="lostId"  onclick="showPopup('lostId')">아이디찾기</a>
                <a class="text text--small" href="javascript:;" id="lostPwd" onclick="showPopup('lostPwd')" >비밀번호찾기</a>
              </p>
            </form>
          </div>
        </div>
      </div>
    </section>
 

  
</body>
</html>