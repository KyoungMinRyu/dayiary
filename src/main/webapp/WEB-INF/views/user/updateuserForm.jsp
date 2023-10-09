<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en" >
<head>
  <meta charset="UTF-8">
  
  
  
  <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<style>
h1{
 height:100px;
 position: relative;
 margin-bottom : -15px;
 margin-top: 0px;
 

}
body
{

 padding-bottom: 0px;

}

b{

margin-bottom : 0px;

}

form {

  display: grid;
  grid-gap: 2rem;
}
input {
  background: white;
  color: rgb(7 2 18);
  transition: all 200ms ease;
  border-left: 0 solid transparent;
  border: 0;
  height: 2.5rem;
  padding: 0 calc(5.8rem * 0.5);
  border-radius: calc(5.8rem * 0.3);
  box-shadow: 0 0 2rem rgb(0, 0, 0, 20%);
}

.header {
  padding-top: -20px;
}
.page-contentmain{
  overflow : hidden;

}
.page-content{
     padding-top : 0px;
     
}

</style>
<script>

var index;
var getCheck = new RegExp(/^[a-zA-Z0-9]{4,20}$/); // 아이디, 비밀번호 정규표현식
var getNickName = new RegExp(/^[a-zA-Z0-9가-힣]{2,12}$/); // 닉네임 정규 표현식 
var msgArr = 
[ 
    "비밀번호는 4 ~ 20자 영어 대소문자, 숫자만 입력할 수 있습니다",
    "비밀번호가 일치합니다",
    "비밀번호가 일치하지 않습니다",
];

$(function() {
    // 2. AJAX related functions
    function sendUserNickNameAjax(inputText) {
        $.ajax
        ({
            type: "POST",
            url: "/user/userNickNameAjax",
            data: { userNickName: inputText },
            dataType: "JSON",
            success: function(response) {
               if(response.code == 0)
          { // 사용가능 아이디
                                 $("#userNickNameMsg").text("사용가능한 닉네임입니다.");
                                   $("#userNickNameMsg").css("color", "blue");
                                     $("#hiddenNickName").val(String($("#userNickName").val())); 
                             }
                             else if(response.code == 100)
                                 { // 중복 아이디
                                   $("#userNickNameMsg").text("사용할 수 없는 닉네임입니다.");
                                   $("#userNickNameMsg").css("color", "red");
                                   $("#hiddenNickName").val("");
                             }
                             else
                             { // 파라미터 오류
                                   $("#userNickNameMsg").text("입력 값이 잘못되었습니다.");
                                   $("#userNickNameMsg").css("color", "red");
                                   $("#hiddenNickName").val("");
                             }
            },
            error: function(xhr, status, error) {
                console.log("error : " + error);
            }
        });
    }
    
    // 3. Event handlers
    $("#userNickName").on("input", function() {
         var inputText = $(this).val();
            var messageElement = $("#userNickNameMsg");
            if (!getNickName.test(inputText)) 
            {
                messageElement.text("닉네임은 영어 대소문자, 숫자, 한글만 2~12자만 입력 가능합니다.");
                var sanitizedText = inputText.replace(/[^a-zA-Z0-9ㄱ-ㅎㅏ-ㅣ가-힣]+/g, "");
                $(this).val(sanitizedText);
            } 
            else
            {
                messageElement.html("&nbsp;");
            }
    });
    
    $("#userPwd1").on("input", function() {
      var inputText = $(this).val();
            var messageElement = $("#userPwd1Msg");
            if (!getCheck.test(inputText)) 
            {
                messageElement.text(msgArr[0]);
                var sanitizedText = inputText.replace(/[^a-zA-Z0-9]/g, "");
                $(this).val(sanitizedText);
            } 
            else
            {
                messageElement.html("&nbsp;");
            }
    });
    
    $("#userPwd2").on("input", function() {
        var inputText = $(this).val();
        var messageElement = $("#userPwd2Msg");
        if ($("#userPwd1").val() === inputText) {
            messageElement.text(msgArr[1]);
            messageElement.css("color", "blue");
            $("#hiddenPwd").val($("#userPwd1").val());
        } else {
            messageElement.css("color", "red");
            messageElement.text(msgArr[2]);
            $("#hiddenPwd").val(null);  // 비밀번호가 일치하지 않으면 hiddenPwd를 null로 설정합니다.
        }
    });


    
    $("#userNickName").on("blur", function() {
        var inputText = $(this).val();
        if (inputText && inputText !== $("#hiddenNickName").val() && getNickName.test(inputText)) {
            sendUserNickNameAjax(inputText);
        } 
        else if (inputText === $("#hiddenNickName").val()) {
            $("#userNickNameMsg").html("&nbsp;");  // 닉네임이 변경되지 않았으면 메시지를 지웁니다.
        }
    });

    
    $("#btnUpdate").on("click", function()
         {         
        if($("#hiddenPwd").val() == null || $("#hiddenPwd").val() == "")
           {
               $("#userPwd1Msg").text("비밀번호를 입력하세요");
               $("#userPwd1").focus();
               return;
           }
           
           if($("#hiddenNickName").val() == null || $("#hiddenNickName").val() == "")
           {
               $("#userNickNameMsg").text("닉네임을 입력하세요");
               $("#userNickName").focus();
               return;
           }
           
           if($("#detailAddress").val() == null || $("#detailAddress").val().trim() == "")
           {
               $("#userAddMsg").text("상세 주소를 입력하세요.");
               $("#detailAddress").focus();
               return;
           }
           else
           {
               $("#hiddenAdd").val($("#roadAddress").val() + " " + $("#detailAddress").val());    
           }
                

            $.ajax
               ({
                  type:"POST",
                   url:"/user/updateuserInfo",
                   data:
                   { 
                    userPwd:$("#hiddenPwd").val(),
                    userNickName:$("#hiddenNickName").val(),
                    userAddress:$("#hiddenAdd").val(),
                   },
                   dataType:"JSON",
                   success: function(response)
                   {
                      if(response.code == 0)
                      { // insert 성공
                        alert("회원정보수정에 성공하셨습니다.");
                         location.href = "/user/userMyPage";
                      }
                      else if(response.code == 400)
                      { // 파라미터 오류

                        alert("회원정보수정에 실패하셨습니다.");
                         location.href = "/user/userMyPage";   
                      }
                      else if(response.code == 100)
                      { // 회원이 이미 존재함

                        alert("회원수정에 실패하셨습니다.");
                         location.href = "/user/userMyPage";   
                      }
                      else if(response.code == 500)
                      { // 서버 에러
                        alert("회원수정에 실패하셨습니다.");
                         location.href = "/user/userMyPage";   
                      }
                      else
                      { // 알 수 없는 오류
                        alert("회원수정에 실패하셨습니다.");
                         location.href = "/user/userMyPage";   
                      }
                   }, 
                   error: function(xhr, status, error) 
                   {
                       console.log("[user](userProc)error : " + error);
                   }
               });
         });
    
    $("#detailAddress").on("input", function() 
            {
               $("#userAddMsg").html("&nbsp;");
               $("#hiddenAdd").val($("#roadAddress").val() + " " + $("#detailAddress").val());    
            });
    
    
    
});

// 4. Daum Postcode service related function
function getDaumPostcode() {
   $("#userAddMsg").html("&nbsp;");
   new daum.Postcode
   ({
       oncomplete: function(data) 
        {
             // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

             // 각 주소의 노출 규칙에 따라 주소를 조합한다.
             // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
           var addr = ''; // 주소 변수
            var extraAddr = ''; // 참고항목 변수

             //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
            if (data.userSelectedType === 'R') 
            { // 사용자가 도로명 주소를 선택했을 경우
                addr = data.roadAddress;
            }
            else 
            { // 사용자가 지번 주소를 선택했을 경우(J)
               addr = data.jibunAddress;
            }

             // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
            if(data.userSelectedType === 'R')
            {
                 // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                 // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname))
                {
                    extraAddr += data.bname;
                }
                // 건물명이 있고, 공동주택일 경우 추가한다.
                if(data.buildingName !== '' && data.apartment === 'Y')
                {
                    extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
            } 

             // 우편번호와 주소 정보를 해당 필드에 넣는다.
            document.getElementById('postcode').value = data.zonecode;
            document.getElementById("roadAddress").value = addr;
             // 커서를 상세주소 필드로 이동한다.
            $("#detailAddress").focus();
          }
      }).open();
}

</script>
</head>
<body>
<link href="https://fonts.googleapis.com/css?family=DM+Sans:400,500,700&display=swap" rel="stylesheet">



 
  <div class="header">
  <h1>회원정보수정</h1>
  </div>
   <form method="POST" enctype="application/x-www-form-urlencoded" target="_blank">
 
  <b>닉네임 :
  <a id="userNickNameMsg">              
  </a> 
  </b> <input type="text"  value="${user.userNickName}" name="userNickName" id="userNickName">
  
  <b>비밀번호 :
  <a id="userPwd1Msg">
  </a>
  </b> <input type="password" placeholder="비밀번호를 입력하세요" name="userPwd1" id="userPwd1">
  <b>비밀번호 확인 :
  <a id="userPwd2Msg">
  </a>
  </b> 
  <input type="password" placeholder="비밀번호를 입력하세요" name="userPwd2" id="userPwd2">
  <b>주소 :</b>
    <div class="field">
            <input type="button" onclick="getDaumPostcode()" value="우편번호 찾기">
    </div>
    <div class="field">
             <div style="display: flex;">
                 <input type="text" name="postcode" id="postcode" style="flex: 1.5; margin-right: 5px; background-color: #FFF;" placeholder="우편번호" disabled >
                 <input type="text" name="roadAddress" id="roadAddress" style="flex: 5; background-color: #FFF;" placeholder="도로명주소" disabled>
            </div>
   </div>
   <div>
            <input type="text" name="detailAddress" id="detailAddress" placeholder="상세주소" value="${user.userAddress}">
   
   </div>
  <input type="button" value="수정하기" id="btnUpdate" style="background-color: #e165f9"/>
  <input type="hidden" name="hiddenNickName" id="hiddenNickName">
  <input type="hidden" name="hiddenPwd" id="hiddenPwd">
  <input type="hidden" name="hiddenAdd" id="hiddenAdd">
</form>
  

<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Rubik:400,700">
<!-- partial -->

</body>
</html>