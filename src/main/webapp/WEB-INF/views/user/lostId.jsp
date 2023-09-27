<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<meta charset="UTF-8">
<title>Insert title here</title>

<style>
    @import url('https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100;300;400;500;700&display=swap');

    *{
        box-sizing: border-box;
        outline: none;

    }

    body{
        font-family: 'Noto Sans KR', sans-serif;
        font-size:16px;
        background-color: white;
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
        background-color: #59689b;
        text-align: center;
        display: flex;
        align-items: center;
        justify-content: center;
        color:#fff;
    }

    .member input:focus, .member select:focus {
        border: 1px solid #59689b;
    }

    @media (max-width:768px) {
        .member {
            width: 100%;
        }
    }
</style>
<script>

var getMail = new RegExp(/^[A-Za-z0-9_\.\-]+@[A-Za-z0-9\-]+\.[A-Za-z0-9\-]+/); // 이메일 정규표현식
var getName = new RegExp(/^[가-힣]{2,4}$/); // 이름 정규 표현식
var msgArr = [
    "이메일을 형식에 맞게 입력해 주세요",
    "이름은 한글만 입력 가능합니다",
];

$(function() 
{  
   
   $("#btnFindId").on("click", function()
          {
              if ($("#hiddenName").val() == null || $("#hiddenName").val() == "")
              {
                  $("#userNameMsg").text("이름을 입력하세요");
                  $("#userName").focus();
                  return;
              }
              
              if ($("#hiddenEmail").val() == null || $("#hiddenEmail").val() == "")
              {
                  $("#userEmailMsg").text("이메일을 입력하세요");
                  $("#userEmail").focus();
                  return;
              }
              
              fn_lostIdProc();
            
          });
   
    $("#userName").on("input", function() {
        var inputText = $(this).val();
        var messageElement = $("#userNameMsg");
        if (!getName.test(inputText)) {
            messageElement.text(msgArr[1]);
            var sanitizedText = inputText.replace(/[^ㄱ-ㅎㅏ-ㅣ가-힣]+/g, "");
            $(this).val(sanitizedText);
        } else {
            messageElement.html("&nbsp;");
            $("#hiddenName").val($("#userName").val());
        }
    });

    $("#userEmail").on("input", function() {
        var inputText = $(this).val();
        var messageElement = $("#userEmailMsg");
        if (!getMail.test(inputText) && inputText !== "") {
            messageElement.text(msgArr[0]);
        } else {
            messageElement.html("&nbsp;");
            $("#hiddenEmail").val($("#userEmail").val());
        }
    });
});

function fn_lostIdProc() 
{
   $.ajax({
       type: "POST",
       url: "/user/lostIdProc",
       data: {
           userName: $("#hiddenName").val(),
           userEmail: $("#hiddenEmail").val(),
       },
       dataType: "JSON",
       success: function(response) {
           if (response.code == 0) 
           {
              
                   location.href = "/user/findId?userId=" + response.data.userId;
              
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
    <form id="findId" name="findId" action="/user/findIdProc" method="post">
        <div class="member">
        <div style="display:flex; justify-content:space-around;"><img style="width: 250px; height: 100px;" class="logo" src="../resources/images/logo.gif"></div>
            <h2>아이디 찾기</h2>
            <!-- 이름 입력 필드 -->
            <div class="field">
                <b>이름</b>
                <span class="placehold-text">
                    <input type="text" placeholder="이름을 입력하세요" name="userName" id="userName">
                </span>
                <div>   
                <p id="userNameMsg" style="color: red;">
                    &nbsp;
                </p>
                </div>
            </div>
            
            <!-- 이메일 또는 휴대전화 입력 필드 -->
            <div class="field">
                <b>이메일</b>
                <input type="email" placeholder="이메일을 입력하세요" name="userEmail" id="userEmail">
                 <div>
                    <p id="userEmailMsg" style="color: red;">
                        &nbsp;
                    </p>
                </div>
            </div>
            
          

            <!-- 아이디 찾기 버튼 -->
            <input type="button" value="아이디 찾기" id="btnFindId" style="background-color: #59689b"/>
        </div>
        
        <input type="hidden" name="hiddenName" id="hiddenName">
        <input type="hidden" name="hiddenEmail" id="hiddenEmail">
        
    </form>
</body>
</html>