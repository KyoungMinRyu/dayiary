<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<meta charset="UTF-8">

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
    }
</style>
<script>

var getMail = new RegExp(/^[A-Za-z0-9_\.\-]+@[A-Za-z0-9\-]+\.[A-Za-z0-9\-]+/); // 이메일 정규표현식
var getBid = new RegExp(/([0-9]{3})-?([0-9]{2})-?([0-9]{5})/);
var msgArr = [
    "이메일을 형식에 맞게 입력해 주세요",
    "사업자번호 양식에 맞게 입력해 주세요.",
];

$(function() 
{  
   
   $("#btnFindId").on("click", function()
          {
              if ($("#hiddensellerBusinessId").val() == null || $("#hiddensellerBusinessId").val() == "")
              {
                  $("#sellerBusinessIdMsg").text("사업자번호를 입력하세요");
                  $("#sellerBusinessId").focus();
                  return;
              }
              
              if ($("#hiddensellerEmail").val() == null || $("#hiddensellerEmail").val() == "")
              {
                  $("#sellerEmailMsg").text("이메일을 입력하세요");
                  $("#sellerEmail").focus();
                  return;
              }
              
              fn_lostIdProc();
          });
   
   $("#sellerBusinessId").on("input", function() {
       var inputText = $(this).val();
       var messageElement = $("#sellerBusinessIdMsg");
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
       $("#hiddensellerBusinessId").val(sanitizedText);  // 히든 값 업데이트
   });



    $("#sellerEmail").on("input", function() {
        var inputText = $(this).val();
        var messageElement = $("#sellerEmailMsg");
        if (!getMail.test(inputText) && inputText !== "") {
            messageElement.text(msgArr[0]);
        } else {
            messageElement.html("&nbsp;");
            $("#hiddensellerEmail").val($("#sellerEmail").val());
        }
    });
    
    
    
    
    
    
    
});

function fn_lostIdProc() 
{
    $.ajax({
        type: "POST",
        url: "/seller/lostIdProc",
        data: {
            sellerBusinessId: $("#hiddensellerBusinessId").val(),
            sellerEmail: $("#hiddensellerEmail").val(),
        },
        dataType: "JSON",
        success: function(response) {
            
            if (response && response.code == 0) {
                location.href = "/seller/findId?sellerId=" + response.data.sellerId; // userId를 sellerId로 변경
            } else if (response && response.message) {
                alert(response.message);
            } else {
                alert("알 수 없는 오류가 발생했습니다.");
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
            <h2>아이디 찾기</h2>
            <!-- 이름 입력 필드 -->
            <div class="field">
                <b>사업자번호</b>
                <span class="placehold-text">
                    <input type="text" placeholder="사업자번호를 입력하세요" name="sellerBusinessId" id="sellerBusinessId">
                </span>
                <div>   
                <p id="sellerBusinessIdMsg" style="color: red;">
                    &nbsp;
                </p>
                </div>
            </div>
            
            <!-- 이메일 또는 휴대전화 입력 필드 -->
            <div class="field">
                <b>이메일</b>
                <input type="email" placeholder="이메일을 입력하세요" name="sellerEmail" id="sellerEmail">
                 <div>
                    <p id="sellerEmailMsg" style="color: red;">
                        &nbsp;
                    </p>
                </div>
            </div>
            
          

            <!-- 아이디 찾기 버튼 -->
            <input type="button" value="아이디 찾기" id="btnFindId" style="background-color: #59689b"/>
        </div>
        
        <input type="hidden" name="hiddensellerBusinessId" id="hiddensellerBusinessId">
        <input type="hidden" name="hiddensellerEmail" id="hiddensellerEmail">
        
    </form>
</body>
</html>