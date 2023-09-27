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
var getBid = new RegExp(/([0-9]{3})-?([0-9]{2})-?([0-9]{5})/);
var getCheck = new RegExp(/^[a-zA-Z0-9]{4,20}$/);
var msgArr =
[
    "이메일을 형식에 맞게 입력해 주세요",
    "사업자번호 양식에 맞게 입력해 주세요.",
    "아이디는 4 ~ 20자 영어 대소문자, 숫자만 입력할 수 있습니다"  
];

$(function() 
{  
   
   $("#btnFindPw").on("click", function()
   {
            if($("#hiddensellerIdForPw").val() == null || $("#hiddensellerIdForPw").val() == "")
            {
               $("#sellerIdForPwMsg").text("아이디를 입력하세요");
               $("#sellerIdForPw").focus();
               return;
            }
               
      
            if ($("#hiddensellerBusinessIdForPw").val() == null || $("#hiddensellerBusinessIdForPw").val() == "")
            {
                     $("#sellerBusinessIdForPwMsg").text("사업자번호를 입력하세요");
                     $("#sellerBusinessIdForPw").focus();
                     return;
             }
              
              if ($("#hiddensellerEmailForPw").val() == null || $("#hiddensellerEmailForPw").val() == "")
              {
                  $("#sellerEmailForPwMsg").text("이메일을 입력하세요");
                  $("#sellerEmailForPw").focus();
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
   
   
   $("#sellerBusinessIdForPw").on("input", function() {
       var inputText = $(this).val();
       var messageElement = $("#sellerBusinessIdForPwMsg");
       var sanitizedText = inputText.replace(/-/g, "");
       
       // 사업자 번호 형식 체크
       if (!getBid.test(sanitizedText)) {
           messageElement.text("사업자 번호 12자리 중에 숫자만 입력해주세요");
           sanitizedText = sanitizedText.replace(/[^0-9-]/g, "");
       } else {
           messageElement.html("&nbsp;");
       }
       
       // 사업자 번호 형식으로 변환
       if (sanitizedText.length >= 3) {
           sanitizedText = sanitizedText.slice(0, 3) + "-" + sanitizedText.slice(3);
       }
       if (sanitizedText.length >= 6) {
           sanitizedText = sanitizedText.slice(0, 6) + "-" + sanitizedText.slice(6);
       }
       
       if (sanitizedText.length > 12) {
           sanitizedText = sanitizedText.slice(0, 12);
       }
       
       $(this).val(sanitizedText);
       $("#hiddensellerBusinessIdForPw").val(sanitizedText);  // 히든 값 업데이트
   });
   
   

    $("#sellerEmailForPw").on("input", function()
    {
        var inputText = $(this).val();
        var messageElement = $("#sellerEmailForPwMsg");
        if (!getMail.test(inputText) && inputText !== "") {
            messageElement.text(msgArr[0]);
        } else {
            messageElement.html("&nbsp;");
            $("#hiddensellerEmailForPw").val($("#sellerEmailForPw").val());
        }
    });
    
    $("#sellerIdForPw").on("input", function() 
           {
               var inputText = $(this).val();
               var messageElement = $("#sellerIdForPwMsg");

               if($("#hiddensellerIdForPw").length === 0) {
                   console.error("#hiddensellerIdForPw element does not exist in the DOM.");
                   return;
               }

               if(inputText == null || inputText == "") {
                   messageElement.text("아이디를 입력하세요");
                   messageElement.css("color", "red");
               }
               else if (!getCheck.test(inputText)) {
                   messageElement.css("color", "red");
                   messageElement.text(msgArr[2]);
                   var sanitizedText = inputText.replace(/[^a-zA-Z0-9]/g, "");
                   $(this).val(sanitizedText);
               } 
               else {
                   messageElement.html("&nbsp;");
                   $("#hiddensellerIdForPw").val($("#sellerIdForPw").val());
               }
           });
});


function fn_lostPwdProc() 
{
   $.ajax({
       type: "POST",
       url: "/seller/sellerlostPwdProc",
       data: {
          sellerBusinessId: $("#hiddensellerBusinessIdForPw").val(),
          sellerEmail: $("#hiddensellerEmailForPw").val(),
          sellerId: $("#hiddensellerIdForPw").val()
       },
       dataType: "JSON",
       success: function(response) {
           if (response.code == 0) 
           {
               // 성공시
                $.ajax({
                   type: "POST",
                   url: "/mail/sellerpasswordRecovery",
                   data: {
                       sellerEmail: $("#hiddensellerEmailForPw").val()
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
   <form id="findId" name="findId" action="/seller/findIdProc" method="post">
    <div class="member">
        <div style="display:flex; justify-content:space-around;"><img style="width: 250px; height: 100px;" class="logo" src="../resources/images/logo.gif"></div>
        <h2>판매자 비밀번호 찾기</h2>
        <div class="field">
            <b>아이디</b>
            <span class="placehold-text">
                <input type="text" placeholder="아이디를 입력하세요" name="sellerIdForPw" id="sellerIdForPw">
            </span>
            <p id="sellerIdForPwMsg">&nbsp;</p>
        </div>
        <div class="field">
            <b>사업자번호</b>
            <input type="text" placeholder="사업자번호를 입력하세요" name="sellerBusinessIdForPw" id="sellerBusinessIdForPw">
            <p id="sellerBusinessIdForPwMsg">&nbsp;</p>
        </div>
        <div class="field">
            <b>이메일</b>
            <input type="email" placeholder="이메일을 입력하세요" name="sellerEmailForPw" id="sellerEmailForPw">
            <p id="sellerEmailForPwMsg">&nbsp;</p>
        </div>
        <input type="button" value="비밀번호 찾기" id="btnFindPw" />
    </div>
     <input type="hidden" name="hiddensellerBusinessIdForPw" id="hiddensellerBusinessIdForPw">
     <input type="hidden" name="hiddensellerEmailForPw" id="hiddensellerEmailForPw">
     <input type="hidden" name="hiddensellerIdForPw" id="hiddensellerIdForPw">
    
    </form>
</body>
</html>