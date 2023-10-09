<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/views/include/head.jsp" %>
   
    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
    <script>
       var index;
        var getMail = new RegExp(/^[A-Za-z0-9_\.\-]+@[A-Za-z0-9\-]+\.[A-Za-z0-9\-]+/); // 이메일 정규표현식
        var getCheck = new RegExp(/^[a-zA-Z0-9]{4,20}$/); // 아이디, 비밀번호 정규표현식
        var getName = new RegExp(/^[가-힣]{2,4}$/); // 이름 정규 표현식
        var getNickName = new RegExp(/^[a-zA-Z0-9가-힣]{2,12}$/); // 닉네임 정규 표현식 
        var getBid = new RegExp(/([0-9]{3})-?([0-9]{2})-?([0-9]{5})/);
        var getPh = new RegExp(/^01([0|1|6|7|8|9])([0-9]{3,4})([0-9]{4})$/);
        var msgArr = 
        [
            "아이디는 4 ~ 20자 영어 대소문자, 숫자만 입력할 수 있습니다", 
            "비밀번호는 4 ~ 20자 영어 대소문자, 숫자만 입력할 수 있습니다",
            "비밀번호가 일치합니다",
            "비밀번호가 일치하지 않습니다",
            "이메일은 형식에 맞게 입력해 주세요",
            "이름은 한글만 입력 가능합니다",
            "생년월일은 숫자만 입력가능합니다",
            "전화번호 양식에 맞게 입력해주세요"
        ];

        $(function() 
        {     
            $("#userId").focus();
            
            $("#userId").on("input", function() 
            {
                var inputText = $(this).val();
                var messageElement = $("#userIdMsg");
                if(inputText != null && inputText != "")
                {
                   messageElement.css("color", "white");
                }
                if (!getCheck.test(inputText)) 
                {   
                   messageElement.css("color", "white");
                    messageElement.text(msgArr[0]);
                    var sanitizedText = inputText.replace(/[^a-zA-Z0-9]/g, "");
                    $(this).val(sanitizedText);
                } 
                else
                {
                    messageElement.html("&nbsp;");
                }
            });
            
            $("#userId").keyup(function(event)
              {   
                if(event.keyCode === 13)
                {
                   $("#userPwd1").focus();
                }
            });
                    
            $("#userId").on("blur", function()
            {
                var inputText = $(this).val();
                if($(this).val() != $("#hiddenId").val())
                {
                   if((inputText != null && inputText != "") && getCheck.test(inputText))
                   {
                       $.ajax
                       ({
                           type:"POST",
                           url:"/seller/sellerIdCheckAjax",
                           data:
                           {
                               userId:inputText
                           },
                           dataType:"JSON",
                           success: function(response)
                           {
                              if(response.code == 0)
                             { // 사용가능 아이디
                                 $("#userIdMsg").text("사용가능한 아이디입니다.");
                                   $("#userIdMsg").css("color", "blue");
                                     $("#hiddenId").val(String($("#userId").val())); 
                             }
                             else if(response.code == 100)
                             { // 중복 아이디
                                   $("#userIdMsg").text("사용할 수 없는 아이디입니다.");
                                   $("#userIdMsg").css("color", "red");
                             }
                             else
                             { // 파라미터 오류

                                   $("#userIdMsg").text("입력 값이 잘못되었습니다.");
                                   $("#userIdMsg").css("color", "red");
                             }
                           },
                           error: function(xhr, status, error) 
                           {
                               console.log("error : " + error);
                           }
                       });
                   }
                }
            });

            $("#userPwd1").on("input", function() 
            {
                var inputText = $(this).val();
                var messageElement = $("#userPwd1Msg");
                if (!getCheck.test(inputText)) 
                {
                    messageElement.text(msgArr[1]);
                    messageElement.css("color", "#ffffff");
                    var sanitizedText = inputText.replace(/[^a-zA-Z0-9]/g, "");
                    $(this).val(sanitizedText);
                } 
                else
                {
                    messageElement.html("&nbsp;");
                }
            });
            
            $("#userPwd1").keyup(function(event)
           {   
               if(event.keyCode === 13)
               {
                  $("#userPwd2").focus();
               }
           });

            $("#userPwd2").on("input", function() 
            {
                var inputText = $(this).val();
                var messageElement = $("#userPwd2Msg");
                if($("#userPwd1").val() === inputText)
                {
                    messageElement.text(msgArr[2]);
                    messageElement.css("color", "blue");
                    $("#hiddenPwd").val($("#userPwd1").val());
                }
                else
                {
                   messageElement.css("color", "#ffffff");
                    messageElement.text(msgArr[3]);
                }
            });
            
            $("#userPwd2").keyup(function(event)
              {   
                if(event.keyCode === 13)
                {
                   $("#userEmail").focus();
                }
            });

            $("#userEmail").on("input", function() 
            {
                var inputText = $(this).val();
                var messageElement = $("#userEmailMsg");
                if (!getMail.test(inputText)) 
                {
                    messageElement.text(msgArr[4]);
                } 
                else
                {
                    messageElement.text("이메일 인증을 해주세요.");
                }
            }); // 이메일 ajax시켜야함 아직 안했음
            
            $("#userEmail").keyup(function(event)
              {   
                if(event.keyCode === 13)
                {
                   $("#userName").focus();
                }
            });

            $("#sendMail").on("click", function() {
                var sendMailButton = $(this);

                var userEmail = $("#userEmail").val();
                var messageElement = $("#userEmailMsg");
                messageElement.html("&nbsp;");
                messageElement.css("color", "#ffffff");

                sendMailButton.prop("disabled", true);
                if (userEmail != null && userEmail != "" && getMail.test(userEmail)) {
                    alert("인증메일이 발송중입니다.");

                    $.ajax({
                        type: "POST",
                        url: "/mail/userEmailCheck",
                        data: {
                            userEmail: userEmail
                        },
                        success: function(response) 
                        {
                            if (response.code == 0) 
                            {
                                alert("인증메일이 발송되었습니다.");
                                messageElement.text("인증 이메일이 발송 되었습니다, 5분 이내에 인증 버튼을 눌러주세요.");
                                messageElement.css("color", "blue");
                                $("#hiddenEmail").val(userEmail);
                                sendMailButton.prop("disabled", true);
                            } 
                            else if (response.code == 100) 
                            {
                                messageElement.text("이미 사용중인 이메일입니다.");
                                messageElement.css("color", "red");
                                $("#hiddenEmail").val("");
                                sendMailButton.prop("disabled", false);
                            } 
                            else if (response.code == 400 || response.code == 500) 
                            {
                                messageElement.text("오류가 발생하였습니다, 다시 인증하세요.");
                                messageElement.css("color", "red");
                                $("#hiddenEmail").val("");
                                sendMailButton.prop("disabled", false);
                            } 
                            else 
                            {
                                messageElement.text("오류가 발생하였습니다, 다시 인증하세요.");
                                messageElement.css("color", "red");
                                $("#hiddenEmail").val("");
                                sendMailButton.prop("disabled", false);
                            }
                        },
                        error: function(xhr, status, error) 
                        {
                            console.log("error : " + error);
                            sendMailButton.prop("disabled", false);
                        }
                    });
                } 
                else 
                {
                    messageElement.text("이메일 형식을 확인하세요.");
                    $("#sendMail").prop("disabled", false);
                    return;
                }
            });
            
            // 사업자 번호
      $("#userBid").on("input", function() 
         {
             var inputText = $(this).val();
             var messageElement = $("#userBidMsg");
             var sanitizedText = inputText.replace(/-/g, "");
         
             if (!getBid.test(sanitizedText)) 
             {
                 messageElement.text("사업자 번호 10자리 중에 숫자만 입력해주세요");
                 sanitizedText = sanitizedText.replace(/[^0-9-]/g, "");
             }
             else 
             {
                 messageElement.html("&nbsp;");
                 
             }
         
             if (sanitizedText.length >= 3) 
             {
                 sanitizedText = sanitizedText.slice(0, 3) + "-" + sanitizedText.slice(3);
             }
             if (sanitizedText.length >= 6) 
             {
                 sanitizedText = sanitizedText.slice(0, 6) + "-" + sanitizedText.slice(6);
             }
         
             if (sanitizedText.length > 12) 
             {
                 sanitizedText = sanitizedText.slice(0, 12);
             }
         
             $(this).val(sanitizedText);
         });

           
           
            $("#userBid").keyup(function(event)
              {   
                if(event.keyCode === 13)
                {
                   $("#detailAddress").focus();
                }
            });
            
            // 사업자 코드 ajax 
              $("#userBid").on("blur", function()
            {
                var inputText = $(this).val();
 
                if($(this).val() != $("#hiddenBid").val())
                {
                   if((inputText  != null && inputText  != "") && getBid.test(inputText))
                   {
                       $.ajax
                       ({
                           type:"POST",
                           url:"/seller/sellerBusinnesIdAjax",
                           data:
                           {
                              userBid:inputText 
                           },
                           dataType:"JSON",
                           success: function(response)
                           {
                              if(response.code == 0)
                             { // 사용가능 아이디
                                 $("#userBidMsg").text("사용가능 사업자번호입니다.");
                                   $("#userBidMsg").css("color", "blue");
                                     $("#hiddenBid").val($("#userBid").val()); 
                             }
                             else if(response.code == 100)
                             { // 중복 아이디
                                   $("#userBidMsg").text("사용할 수 없는 사업자번호입니다.");
                                   $("#userBidMsg").css("color", "#ffffff");
                             }
                             else
                             { // 파라미터 오류

                                   $("#userBidMsg").text("입력 값이 잘못되었습니다.");
                                   $("#userBidMsg").css("color", "#ffffff");
                             }
                           },
                           error: function(xhr, status, error) 
                           {
                               console.log("error : " + error);
                           }
                       });
                   }
                }
            });     
            
            
            $("#userShopName").on("input", function() 
            {
               $("#userShopNameMsg").html("&nbsp;");
               $("#hiddenShopName").val($("#userShopName").val());    
            });
            
            $("#detailAddress").on("input", function() 
            {
               $("#userAddMsg").html("&nbsp;");
               $("#hiddenAdd").val($("#roadAddress").val() + " " + $("#detailAddress").val());    
            });
            
            
            $("#userPh").on("input", function() 
            {
                var inputText = $(this).val();
                var messageElement = $("#userPhMsg");
                if (!getPh.test(inputText)) 
                {
                    messageElement.text(msgArr[7]);
                    var sanitizedText = inputText.replace(/[^0-9]/g, "");
                    $(this).val(sanitizedText);
                } 
                else
                {
                    messageElement.html("&nbsp;");
                    $("#hiddenPhNum").val($("#userPh").val());
                }
            });

            $("#userPh").keyup(function(event)
              {   
                if(event.keyCode === 13)
                {
                   $("#chMSG").focus();
                }
            });
            
            var timer = null;
            var checkRanNum = false; // 인증번호 확인 했는지 체크용 (확인됬다면 1, 안됬으면 0)

            $("#sendMsg").on("click", function() // 인증번호 발송 버튼을 눌렀을 때
            {  
               var sendMailButton = $(this);
               sendMailButton.prop("disabled", true);
                if(getPh.test($("#userPh").val())) // 전화번호 정규표현식
                { // 정규 표현식 성공 했을 떄 
                    var display = $("#chMsgMsg"); // 타이머 표시하기 위해 p태그 지정
                    var leftSec = 180; // 타이머 시간 설정
                    var checkRanNum = false;
                    $("#hiddenChPh").val("0");
                    $.ajax
                    ({
                        type:"POST",
                        url:"/seller/sellerPhCheck",
                        dataType:"JSON",
                        data:
                        {
                           userPh:$('#userPh').val()
                        },
                        success: function(response)
                        {
                           if(response.code == 0)
                          { 
                                startTimer(leftSec, display, response.data);
                          }
                          else
                          { 
                                $("#chMsgMsg").text("오류가 발생하였습니다");
                                $("#chMsgMsg").css("color", "red");
                                sendMailButton.attr("disabled", false);
                          }
                       },
                       error: function(xhr, status, error) 
                       {
                           console.log("error : " + error);
                            sendMailButton.attr("disabled", false);
                       }
                  });   
                }
                else
                { // 정규표현식 실패 시
                    $("#sendMsg").attr("disabled", false);
                    $("#Msg").val("");
                    $("#userPhMsg").text("전화번호를 입력해주세요"); 
                    $("#userPh").focus(); // 전화번호 입력 포커스
                }
            });

            function startTimer(count, display, ranNum) // 타이머시간, 남은시간 표시해줄 태그, 인증번호(자바에서 넘길 예정)
            {  
                var minutes, seconds;
                display.css("color", "red");
                $("#Msg").val("");
                $("#userPhMsg").text("인증번호가 발송되었습니다.");
                $("#userPhMsg").css("color", "#ffffff");
                timer = setInterval(
                   function () // 타이머 실행
                    {
                        minutes = parseInt(count / 60, 10);
                        seconds = parseInt(count % 60, 10);
                        minutes = minutes < 10 ? "0" + minutes : minutes;
                        seconds = seconds < 10 ? "0" + seconds : seconds;

                        display.text(minutes + ":" + seconds);
                        // 타이머 끝
                        if (--count < 0) // 타이머가 종료되면
                        {
                            clearInterval(timer);
                            ranNum = null;
                            display.text("시간이 만료되었습니다. 다시 인증번호를 받아주세요.");           
                            checkRanNum = false;
                            $("#sendMsg").attr("disabled", false);
                            $("#hiddenChPh").val("0");
                            $("#userPhMsg").html("&nbsp;");
                        }
                        else
                        {
                            $("#chMsg").on("click",function() // 인증번호 확인 버튼 눌렀을 때
                            {
                                if($("#Msg").val() === String(ranNum))
                                {
                                    checkRanNum = true;
                                    $("#hiddenChPh").val("1");
                                    clearInterval(timer); 
                                    $("#sendMsg").attr("disabled", true);
                                    display.text("인증완료 되었습니다.");
                                    display.css("color", "blue");           
                                    $("#userPhMsg").html("&nbsp;");
                                }
                                else
                                {
                                    checkRanNum = false;
                                    ranNum = null;
                                    $("#hiddenChPh").val("0");
                                    clearInterval(timer);
                                    display.text("인증번호가 틀렸습니다. 인증번호를 다시 요청하세요");
                                    $("#sendMsg").attr("disabled", false);
                                    $("#Msg").focus();
                                    $("#userPhMsg").html("&nbsp;");
                                }
                            });
                        }
                    }, 1000
                );
            }
         
         $("#btnSubmit").keyup(function(event)
              {   
                  if(event.keyCode === 13)
                {
                    event.preventDefault();
                }
            });
         
         $("#btnSubmit").on("click", function()
         {   
            if($("#hiddenId").val() == null || $("#hiddenId").val() == "")
            {
               $("#userIdMsg").text("아이디를 입력하세요");
               $("#userId").focus();
               return;
            }
            
            if($("#hiddenPwd").val() == null || $("#hiddenPwd").val() == "")
            {
               $("#userPwd1Msg").text("비밀번호를 입력하세요");
               $("#userPwd1").focus();
               return;
            }
            
            if($("#hiddenEmail").val() == null || $("#hiddenEmail").val() == "")
            {
               $("#userEmailMsg").text("이메일을 입력하세요");
               $("#userEmail").focus();
               return;
            }
            
            var hiddenBidValue = $("#hiddenBid").val();
            
            
            if($("#hiddenBid").val() == null || $("#hiddenBid").val() == "")
            {
               
               
               $("#userBidMsg").text("사업자번호를 입력하세요");
               $("#userBid").focus();
               return;
            }
            
            if($("#hiddenShopName").val() == null || $("#hiddenShopName").val() == "")
            {
               $("#userShopNameMsg").text("상호명을 입력하세요");
               $("#userShopName").focus();
               return;
            }
            
            if($("#hiddenAdd").val() == null || $("#hiddenAdd").val() == "" || $("#roadAddress").val() == null || $("#roadAddress").val() == "")
            {
               $("#userAddMsg").text("우번편호 찾기 버튼을 통해 주소를 입력해주세요.");
               $("#detailAddress").focus();
               return;
            }
            
            if($("#hiddenPhNum").val() == null || $("#hiddenPhNum").val() == "")
            {
               $("#userPhMsg").text("전화번호를 입력하세요");
               $("#userPh").focus();
               return;
            }
            
            if($("#hiddenChPh").val() == null || $("#hiddenChPh").val() == "" || $("#hiddenChPh").val() == "0")
            {
               $("#chMsgMsg").text("인증을 해주세요");
               $("#userPh").focus();
               return;
            }
            
            $.ajax
                ({ // 이메일 인증 체크부터 함
                    type:"POST",
                    url:"/mail/selectStatus",
                    data:
                    {
                     userEmail:$("#hiddenEmail").val()
                    },
                    dataType:"JSON",
                    success: function(response)
                    {
                       if(response.code == 0)
                      { // 이메일 인증 성공 다시 ajax
                          $("#userEmailMsg").text("이메일 인증이 완료된 아이디 입니다.");
                            $("#userEmailMsg").css("color", "#ffffff");
                            fn_userProc();
                      }
                      else if(response.code == 100)
                      { // 이메일 인증 버튼을 아직 안눌렀을 때
                            $("#userEmailMsg").text("이메일 인증을 다시해주세요.");
                            $("#userEmailMsg").css("color", "#ffffff");
                       $("#userEmail").focus();

                            $("#sendMail").attr("disabled", false);
                       return;
                      }
                      else if(response.code == 400)
                      { // 인증 테이블 컬럼 없음

                            $("#userEmailMsg").text("이메일 인증을 다시해주세요.");
                            $("#userEmailMsg").css("color", "#ffffff");
                       $("#userEmail").focus();
                            $("#sendMail").attr("disabled", false);
                       return;
                      }
                      else if(response.code == 500)
                      { // 파라미터 오류
                            $("#userEmailMsg").text("입력 값이 잘못되었습니다.");
                            $("#userEmailMsg").css("color", "#ffffff");
                       $("#userEmail").focus();
                            $("#sendMail").attr("disabled", false);
                       return;
                      }
                      else
                      { // 알 수 없는 오류
                            $("#userEmailMsg").text("알 수 없는 오류가 발생하였습니다.");
                            $("#userEmailMsg").css("color", "#ffffff");
                       $("#userEmail").focus();
                            $("#sendMail").attr("disabled", false);
                       return;
                      }
                    },
                    error: function(xhr, status, error) 
                    {
                        console.log("[Mail](selectStatus)error : " + error);
                    }
                });
         });
        });
        
        
        function fn_userProc()// 회원가입 ajax
        {
           $.ajax
            ({
               type:"POST",
                url:"/seller/sellerProc",
                data:
                { 
                   userId:$("#hiddenId").val(),
                   userBid:$("#hiddenBid").val(),
                   userEmail:$("#hiddenEmail").val(),
                   userPwd:$("#hiddenPwd").val(),
                   userShopName:$("#hiddenShopName").val(),
                   userPh:$("#hiddenPhNum").val(),
                   userChPh:$("#hiddenChPh").val(),
                   userAdd:$("#hiddenAdd").val()
                   
                },
                dataType:"JSON",
                success: function(response)
                {
                   if(response.code == 0)
                   { // insert 성공
                     alert("회원가입에 성공하셨습니다.");
                      location.href = "/";
                   }
                   else if(response.code == 400)
                   { // 파라미터 오류
                  
                     alert("회원가입에 실패하셨습니다.");
                      location.href = "/";   
                   }
                   else if(response.code == 100)
                   { // 회원이 이미 존재함

                     alert("회원가입에 실패하셨습니다.");
                      location.href = "/";   
                   }
                   else if(response.code == 500)
                   { // 서버 에러
                     alert("회원가입에 실패하셨습니다.");
                      location.href = "/";   
                   }
                   else
                   { // 알 수 없는 오류
                     alert("회원가입에 실패하셨습니다.");
                      location.href = "/";   
                   }
                }, 
                error: function(xhr, status, error) 
                {
                    console.log("[user](userProc)error : " + error);
                }
            });
           
        }
        
        // 도로명 주소 표기 방식에 대한 법령에 따라, 내려오는 데이터를 조합하여 올바른 주소를 구성하는 방법을 설명합니다.
        function getDaumPostcode() 
        {
             $("#userAddMsg").html("&nbsp;");
           new daum.Postcode
           ({
               oncomplete: function(data) 
                {
                     // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                     // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                     // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                   var addr = ''; // 주소 변수s
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
    <style>
        /* Google web font CDN*/
        @import url('https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100;300;400;500;700&display=swap');

        *{
            box-sizing: border-box; /*전체에 박스사이징*/
            outline: none; /*focus 했을때 테두리 나오게 */
        }
        
         @font-face {
          font-family: 'SUIT-Regular'; /* 고딕 */
          src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_suit@1.0/SUIT-Regular.woff2') format('woff2');
          font-weight: 100;
          font-style: normal;
} 


body {
    font-family: 'SUIT-Regular', sans-serif;
    font-size: 16px;
    line-height: 1.5em;
    color: #222;
    margin: 0;
    display: flex;
    justify-content: center;
    align-items: center;
    min-height: 100vh; /* 최소 뷰포트 높이 설정 */
    background-image: url('/resources/images/wine.jpg');
    background-size: cover;
    position: relative;
}
      
      b
      {
         color: #FFFFFF;
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

        /*member sign in*/
        .member{
            width: 400px;
            /* border: 1px solid #000; */
            margin: auto; /*중앙 정렬*/
            padding: 0 20px;
            margin-bottom: 20px;
        }

        .member .logo{
            /*로고는 이미지라 인라인 블록이니까 마진 오토 안됨 블록요소만 됨 */
            /* display: block; */
            margin : 20px auto;
            width: 130px;
            height: 100px;
        }

        .member .field{
            margin : 5px 0; /*상하로 좀 띄워주기*/
        }

        .member b{
            /* border: 1px solid #000; */
            display: block; /*수직 정렬하기 */
            margin-bottom: 5px;
        }

        /*input 중 radio 는 width 가 100%면 안되니까 */
        .member input:not(input[type=radio]), 
        .member select, 
        .gender input[type="radio"] + span 
        {
            padding: 15px;
            width: 100%;
            display: flex;
        }

        .gender input[type="radio"] {
            display: none;
        }

        .gender input[type="radio"] + span {
            display: inline-block;
            border: 1px solid #dfdfdf;
            background-color: #ffffff;
            text-align: center;
            cursor: pointer;
        }

        .gender input[type="radio"]:checked + span 
        {
            background-color: #9dafeb;
            color: #ffffff;
        }

        .member input[type=button],
        .member input[type=submit]
        {
            background-color: #9dafeb;
            text-align: center;
            display: flex;
            align-items: center;
            justify-content: center;
            color:#fff
        }

        .member input:focus, .member select:focus
        {
            border: 1px solid #9dafeb;
        }

        .field.tel-number div 
        {
            display: flex;
        }

        .field.tel-number div input:nth-child(2)
        {
            flex:2;
        }

        .field.tel-number div input:nth-child(2)
        {
            flex:1;
        }

        .field.gender div label 
        {
            flex-basis: 50%;
        }
        
        .field.gender div input[type="radio"]
        {
            flex-basis: 50%;
        }

        .field.gender div
        {
            border: 1px solid #dadada;
            padding-left : 5px;
            padding-right : 5px; 
            padding-top: 5px;     
            width: 100%;
            height: 100%;
            background-color: #fff;
            display: flex;
            flex-direction: row;
        }

        @media (max-width:768px) 
        {
            .member{
                width: 100%;
            }
        }
        
        #reg {
}
   .container {
      
           background-color: rgba(255, 255, 255, 0.5) !important;   /* 게시판 테두리 투명도 */
           border-radius: 10px;                            /* 게시판 테두리 라운드 */
           padding-top: 10px;                               /* 게시판 내부내용 상단에서 띄우기 */
           padding-bottom: 20px;
           max-width: 600px !important;
      }


    </style>
</head>



<body>

<%@ include file="/WEB-INF/views/include/navigation.jsp" %>
<div class="container" style="margin-top:10px">
    <form id="reg" name="reg" action="/seller/sellerProc" method="post" style="margin-top: 120px">
        <div class="member">
            <div class="field">
            <div style="text-align: center;">
            <span style="font-size: 36px; color: #000000;"> 판매자 회원 가입 </span></div><br><br>
                <b style="color: #000000;">아이디</b>
                <span class="placehold-text">
                    <input type="text" placeholder="아이디를 입력하세요" name="userId" id="userId">
                </span>
                <p id="userIdMsg">
                    &nbsp;
                </p>
            </div>
            <div class="field">
                <b style="color: #000000;">비밀번호</b>
                <input class="userpw" type="password" placeholder="비밀번호를 입력하세요" name="userPwd1" id="userPwd1">
                <p id="userPwd1Msg">
                    &nbsp;
                </p>
            </div>
            <div class="field">
                <b style="color: #000000;">비밀번호 재확인</b>
                <input class="userpw-confirm" type="password" placeholder="비밀번호 확인을 입력하세요" name="userPwd2" id="userPwd2">
                <p id="userPwd2Msg">
                    &nbsp;
                </p>
            </div>
            <div class="field tel-number">
                <b style="color: #000000;">이메일</b>
                <div>
                     <input class="userpw-confirm" type="email" placeholder="이메일을 입력하세요" name="userEmail" id="userEmail">
                     <input type="button" value="인증메일 받기" id="sendMail"  style="background-color: #000000">
                    
                </div>
                <div>
                    <p id="userEmailMsg" style="color: red;">
                        &nbsp;
                    </p>
                </div>
               
            </div>
          
            <div class="field">
                <b style="color: #000000;">사업자번호</b>
                <input type="text" placeholder="사업자번호 10자리" name="userBid" id="userBid">
                <p id="userBidMsg">
                    &nbsp;
                </p>
            </div>
            
            <div class="field">
                <b style="color: #000000;">상호명</b>
                <input type="text" placeholder="상호명을 입력하세요" name="userShopName" id="userShopName">
                <p id="userShopNameMsg">
                    &nbsp;
                </p>
            </div>
            
            <div class="field">
            <input type="button" onclick="getDaumPostcode()" value="우편번호 찾기"  style="background-color: #000000">
            </div>
         <div class="field">
             <div style="display: flex;">
                 <input type="text" name="postcode" id="postcode" style="flex: 1.5; margin-right: 5px; background-color: #FFF;" placeholder="우편번호" disabled >
                 <input type="text" name="roadAddress" id="roadAddress" style="flex: 5; background-color: #FFF;" placeholder="도로명주소" disabled>
             </div>
         </div>
            <div>
            <input type="text" name="detailAddress" id="detailAddress" placeholder="상세주소">
            </div>
            <p id="userAddMsg">
               &nbsp;
            </p>
            
            <div class="field tel-number">
                <b style="color: #000000;">휴대전화</b>
                <div>
                    <input type="tel" placeholder="전화번호 입력" name="userPh" id="userPh">
                    <input type="button" value="인증번호 받기" id="sendMsg"  style="background-color: #000000">
                    
                </div>
                <div>
                    <p id="userPhMsg">
                        &nbsp;
                    </p>
                </div>
                <div>
                    <input type="text" placeholder="인증번호를 입력하세요" name="Msg" id="Msg">
                    <input type="button" value="인증번호 확인" id="chMsg"  style="background-color: #000000">
                </div>
                <div>
                    <p id="chMsgMsg">
                        &nbsp;
                    </p>
                </div>
        <input type="button" value="가입하기" id="btnSubmit"  style="background-color: #000000"/>
        </div>
            </div>
        <input type="hidden" name="hiddenId" id="hiddenId">
        <input type="hidden" name="hiddenBid" id="hiddenBid">
        <input type="hidden" name="hiddenEmail" id="hiddenEmail">
        <input type="hidden" name="hiddenPwd" id="hiddenPwd">
        <input type="hidden" name="hiddenShopName" id="hiddenShopName">
        <input type="hidden" name="hiddenAdd" id="hiddenAdd">
        <input type="hidden" name="hiddenPhNum" id="hiddenPhNum">
        <input type="hidden" name="hiddenChPh" id="hiddenChPh">
    </form>
</div>    
</body>
</html>