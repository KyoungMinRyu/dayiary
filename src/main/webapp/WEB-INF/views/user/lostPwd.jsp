<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <%@ include file="/WEB-INF/views/include/head.jsp" %>
    <link href='https://fonts.googleapis.com/css?family=Open+Sans' rel='stylesheet' type='text/css'>
    <style>
    @import url('https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100;300;400;500;700&display=swap');

    *{
        box-sizing: border-box;
        outline: none;
    }

   h2 
   {
      color: black;
   }
    body{
        font-family: 'Noto Sans KR', sans-serif;
        font-size:16px;
        background-color: #white;
        line-height: 1.5em;
        color : #222;
    }
    
    b {
        color: #black;
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

    .member {
        width: 400px;
        margin: auto;
        padding: 0 20px;
        margin-bottom: 20px;
    }

    .member .logo {
        width: 120px;
        height: 100px;
    }

    .member .field {
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
        background-color: #59689b;
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
    }
</style>


<script type="text/javascript">
var getMail = new RegExp(/^[A-Za-z0-9_\.\-]+@[A-Za-z0-9\-]+\.[A-Za-z0-9\-]+/); // 이메일 정규표현식
var getName = new RegExp(/^[가-힣]{2,4}$/); // 이름 정규 표현식
var getCheck = new RegExp(/^[a-zA-Z0-9]{4,20}$/);

var msgArr = [
    "이메일을 형식에 맞게 입력해 주세요",
    "이름은 한글만 입력 가능합니다",
    "아이디는 4 ~ 20자 영어 대소문자, 숫자만 입력할 수 있습니다"  
];

$(function() 
{  
   
   $("#btnFindPw").on("click", function()
   {
            if($("#hiddenuserIdForPw").val() == null || $("#hiddenuserIdForPw").val() == "")
            {
               $("#userIdForPwMsg").text("아이디를 입력하세요");
               $("#userIdForPw").focus();
               return;
            }
               
      
              if ($("#hiddenuserNameForPw").val() == null || $("#hiddenuserNameForPw").val() == "")
              {
                  $("#userNameForPwMsg").text("이름을 입력하세요");
                  $("#userNameForPw").focus();
                  return;
              }
              
              if ($("#hiddenuserEmailForPw").val() == null || $("#hiddenuserEmailForPw").val() == "")
              {
                  $("#userEmailForPwMsg").text("이메일을 입력하세요");
                  $("#userEmailForPw").focus();
                  return;
              }
              
              var confirmSend = confirm("임시비밀번호를 받으시겠습니까?");
              if (confirmSend)
              {
                 fn_lostPwdProc();
                 
              } 
              else   //아니요 누르면
              {
                   window.close()   
              }
   });
   
    $("#userNameForPw").on("input", function() 
    {
        var inputText = $(this).val();
        var messageElement = $("#userNameForPwMsg");
        if (!getName.test(inputText))
        {
            messageElement.text(msgArr[1]);
            var sanitizedText = inputText.replace(/[^ㄱ-ㅎㅏ-ㅣ가-힣]+/g, "");
            $(this).val(sanitizedText);
        } 
        else 
        {
            messageElement.html("&nbsp;");
            $("#hiddenuserNameForPw").val($("#userNameForPw").val());
        }
    });

    $("#userEmailForPw").on("input", function()
    {
        var inputText = $(this).val();
        var messageElement = $("#userEmailForPwMsg");
        if (!getMail.test(inputText) && inputText !== "")
        {
            messageElement.text(msgArr[0]);
        }
        else 
        {
            messageElement.html("&nbsp;");
            $("#hiddenuserEmailForPw").val($("#userEmailForPw").val());
        }
    });
    
    $("#userIdForPw").on("input", function() 
           {
               var inputText = $(this).val();
               var messageElement = $("#userIdForPwMsg");

               if($("#hiddenuserIdForPw").length === 0) 
               {
                   console.error("#hiddenuserIdForPw element does not exist in the DOM.");
                   return;
               }

               if(inputText == null || inputText == "")
               {
                   messageElement.text("아이디를 입력하세요");
                   messageElement.css("color", "red");
               }
               else if (!getCheck.test(inputText))
               {
                   messageElement.css("color", "red");
                   messageElement.text(msgArr[2]);
                   var sanitizedText = inputText.replace(/[^a-zA-Z0-9]/g, "");
                   $(this).val(sanitizedText);
               } 
               else
               {
                   messageElement.html("&nbsp;");
                   $("#hiddenuserIdForPw").val($("#userIdForPw").val());
               }
           });
});


function fn_lostPwdProc() 
{
   $.ajax({
       type: "POST",
       url: "/user/lostPwdProc",
       data: {
           userName: $("#hiddenuserNameForPw").val(),
           userEmail: $("#hiddenuserEmailForPw").val(),
           userId: $("#hiddenuserIdForPw").val()
       },
       dataType: "JSON",
       success: function(response) {
           if (response.code == 0) 
           {
               // 성고시
               $.ajax({
                   type: "POST",
                   url: "/mail/passwordRecovery",
                   data: {
                       userEmail: $("#hiddenuserEmailForPw").val()
                   },
                   dataType: "JSON",
                   success: function(response)
                   {
                       if (response.code == 0)
                       {
                           alert("임시 비밀번호가 이메일로 발송되었습니다.");
                           window.close();
                       } 
                       else 
                       {
                           alert(response.message);
                       }
                   },
                   error: function(jqXHR, textStatus, errorThrown) 
                   {
                       alert("An error occurred: " + textStatus);
                   }
               });
           }
           else {
               alert(response.message);
           }
       },
       error: function(jqXHR, textStatus, errorThrown) {
           alert("An error occurred: " + textStatus);
       }
   });
}






</script>
</head>
<body>
   <form id="findPwd" name="findPwd" action="/user/lostPwdProc" method="post">
    <div class="member">
        <a href="/user/login"></a>
        <div style="display:flex; justify-content:space-around;"><img style="width: 250px; height: 100px;" class="logo" src="../resources/images/logo.gif"></div>
        <h2>비밀번호 찾기</h2>
        <div class="field">
            <b>아이디</b>
            <span class="placehold-text">
                <input type="text" placeholder="아이디를 입력하세요" name="userIdForPw" id="userIdForPw">
            </span>
            <p id="userIdForPwMsg">&nbsp;</p>
        </div>
        <div class="field">
            <b>이름</b>
            <input type="text" placeholder="이름을 입력하세요" name="userNameForPw" id="userNameForPw">
            <p id="userNameForPwMsg">&nbsp;</p>
        </div>
        <div class="field">
            <b>이메일</b>
            <input type="email" placeholder="이메일을 입력하세요" name="userEmailForPw" id="userEmailForPw">
            <p id="userEmailForPwMsg">&nbsp;</p>
        </div>
        <input type="button" value="비밀번호 찾기" id="btnFindPw"/>
        <b>가입 시 등록하신 이메일 주소로 임시 비밀번호를 보내 드립니다.</b>
    </div>
        <input type="hidden" name="hiddenuserIdForPw" id="hiddenuserIdForPw">
        <input type="hidden" name="hiddenuserEmailForPw" id="hiddenuserEmailForPw">
        <input type="hidden" name="hiddenuserNameForPw" id="hiddenuserNameForPw">
    </form>
</body>
</html>