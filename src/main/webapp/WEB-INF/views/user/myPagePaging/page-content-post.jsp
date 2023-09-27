<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/views/include/head.jsp" %>


<style>

body {
  margin: 0;
  justify-content: center;
  flex-direction: column;
  overflow: hidden;
  width: 100%;
  height: 100%;
  padding: 12px;
  font-family: "DM Sans", sans-serif;
  font-size: 12px;
  background-image: linear-gradient(21deg, rgba(64, 83, 206, 0.3697003235) 68%, rgba(255, 206, 196, 0.5) 163%), linear-gradient(163deg, rgba(49, 146, 170, 0.0794448997) 86%, rgba(239, 112, 138, 0.5) 40%), linear-gradient(30deg, rgba(76, 79, 173, 0.6173675717) 22%, rgba(237, 106, 134, 0.5) 169%), linear-gradient(48deg, rgba(31, 85, 147, 0.7323890642) 64%, rgba(247, 126, 132, 0.5) 43%);
  background-blend-mode: overlay, multiply, color, normal;

}

.task-manager {
   display: flex;
  justify-content: space-between;
  width: 100%;
  max-width: 1200px;
  height: 90vh;
  background: #fff;
  border-radius: 4px;
  box-shadow: 0 0.3px 2.2px rgba(0, 0, 0, 0.011), 0 0.7px 5.3px rgba(0, 0, 0, 0.016), 0 1.3px 10px rgba(0, 0, 0, 0.02), 0 2.2px 17.9px rgba(0, 0, 0, 0.024), 0 4.2px 33.4px rgba(0, 0, 0, 0.029), 0 10px 80px rgba(0, 0, 0, 0.04);
  overflow: hidden;
   max-width: 1600px;
	margin-top: 78  px;
}
.navbar {
  display: flex;
  justify-content: center;
  align-items: center;
  height: 80px; 
  background-color:black;
  text-decoration: none;
  position: fixed; 
  top: 0; 
  left: 0; 
  width: 100%; 
  z-index:99;
}

.pricing-table {
  box-shadow: 0px 10px 13px -6px rgba(0, 0, 0, 0.08), 0px 20px 31px 3px rgba(0, 0, 0, 0.09), 0px 8px 20px 7px rgba(0, 0, 0, 0.02);
  display: flex;
  flex-direction: column;
}

@media (min-width: 900px) {
  .pricing-table {
    flex-direction: row;
  }
}

.pricing-table * {
  text-align: center;
}

.pricing-plan {
  border-bottom: 1px solid #e1f1ff;
  padding: 25px;
  display: flex;
  flex-direction: column;
  align-items: center;
}

.pricing-plan:last-child {
  border-bottom: none;
}

@media (min-width: 900px) {
  .pricing-plan {
    border-bottom: none;
    border-right: 1px solid #e1f1ff;
    flex-basis: 100%;
    padding: 25px 50px;
  }

  .pricing-plan:last-child {
    border-right: none;
  }
}
</style>

<script>


$(document).ready(function() {
   
   
    //작성하기버튼(pricing-button)을 눌렀을때
    $("#btnWrite").on("click", function () {
       
       if($.trim($("#searchResult").text()).length <= 0) //받는사람 입력 안했으면 돌려보냄
       {
          alert("받는 사람을 먼저 선택하세요.");
          return;
       }
       else   //입력했으면 메세지창 띄워줌
       {
         let card = $(".card");
         card.css("display", "flex");
       }
    });
    
    
    // 캔슬버튼을 눌렀을때
    $("#cancel").on("click", function () {
       
         let card = $(".card");
         card.css("display", "none");
    });
    
    
    //전송 버튼 눌렀을때
    $("#send").on("click", function() {
      
        //보낼 메세지에 아무것도 적지 않았을때
      if($.trim($("#textarea").val()).length <= 0) 
      {
          $(".card").css("display", "flex");
         alert("내용을 입력하세요.");
         return;
      }
      else //적었으면 쪽지 DB에 인서트하고 편지보내는 효과 실행
      {
         
         $.ajax({
             type: "POST",  
             url: "/post/sendPost", 
             data: 
             {
                  yourId : $("#yourId").val(),
                  msgContent : $("#textarea").val()
             }, 
             beforeSend:function(xhr)
              {
                 xhr.setRequestHeader("AJAX", "true");
              },
             success: function(response)
             {
                if(response.code == 0)
                {
                    $(".card").addClass("sent"); //쪽지보내는 효과 실행
                     setTimeout(function() 
                     {
                      $(".card").removeClass("sent"),
                     $(".card").css("display", "none"); //1.5초 뒤 창 닫음
                    } , 2000);
                }
                else if(response.code == 500)
                {
                   alert(response.data);
                }
                else if(response.code == 400)
                {
                   alert(response.data);
                }
                else if(response.code == 404)
                {
                   alert(response.data);
                }
                else if(response.code == 100)
                {
                   alert(response.data);
                }
                else   
                {
                   alert("알 수 없는 오류가 발생하였습니다.");
                }
                
             },
             error: function(xhr, status, error) 
             {
                 console.log(error);
             }
             
         });
         
      }
      
    });
      
     

    
    
    
    
    
    
    
    
   

   
   //유저 찾기 버튼 눌렀을때
  $("#btnSearch").on("click", function() {

       $.ajax({
           type: "POST",  
           url: "/post/searchUser", 
           data: 
           {
                searchInput : $("#searchInput").val()
           }, 
           beforeSend:function(xhr)
            {
               xhr.setRequestHeader("AJAX", "true");
            },
           success: function(response) 
           {
              if(response.code == 0)
            {
                 document.getElementById("userImage").src = response.data.fileName;
                 document.getElementById('userImage').style.display = 'inline';
                   document.getElementById('searchResult').innerText = response.data.userNickName;
                   document.getElementById('fromUser').innerText = "< " + response.data.userNickName + " > 님에게";
                   document.getElementById('yourId').value = response.data.userId; //유저아이디값 기억했다가 서버에 보내려고 히든타입에 담아둔거
            }
            else if(response.code == 400)
            {
               console.log("ajax 오류 400");
               alert("찾으려는 아이디를 입력해주세요.");
            }
            else if(response.code == 500)
            {
               alert("일치하는 사용자가 없습니다. 정확한 아이디를 입력해 주세요.");
            }

           },
           error: function(error) 
           {
              icia.common.error(error);
              console.log("ajax 에러");
           }
       }); 
       
     });
   
   
  
}); 






</script>

</head>
<body>



  <div class="panel pricing-table">

    <div class="pricing-plan">
    <div id="imgContainer">
      <img src="/resources/images/post.png" alt="" class="pricing-img">
    </div>
      <h2 class="pricing-header">내 쪽지함</h2>
      <ul class="pricing-features">
        <li class="pricing-features-item">받은 쪽지 ${fromCount}개</li>
        <li class="pricing-features-item">보낸 쪽지 ${toCount}개</li>
      </ul>
      <a href="/post/postBox" class="pricing-button is-featured" id="btnMove">이동</a>
    </div>

    <div class="pricing-plan">
    <div id="imgContainer">
      <img src="/resources/images/send2.png" alt="" class="pricing-img">
    </div>
      <h2 class="pricing-header">쪽지 보내기</h2>
      <ul class="pricing-features" id="right">
        <li class="pricing-features-item">
         <div id="user">
         <div>받는 사람:</div>
            <div>
            <img id="userImage" src="" alt="noImage" style="width:35px; height:35px; display: none;">
            <span id="searchResult" style="border:none;"></span>
            <input type="hidden" id="yourId">
            </div>
         </div>
      </li>
        <li class="pricing-features-item"><input type="text" id="searchInput" placeholder="유저 아이디를 입력하세요"><button id="btnSearch">검색</button></li>
      </ul>
      <div>
   </div>
      <a href="#/" class="pricing-button" id="btnWrite">작성하기</a>
    </div>

  </div>




<form class="card" action="javascript:void(0);"  style="display: none;">
  <div class="hint">
    <h2>쪽지를 보냈어요!</h2>
  </div>
  <span id="fromUser" style="font-size: 25px; margin-bottom: 20px;"></span>
  <textarea class="textarea" id="textarea" placeholder="보내고 싶은 메시지를 작성해 보세요!"></textarea>
  <div class="multi-button">
    <button class="btn btn-danger btn-shock" id="cancel">취소</button>
    <button class="btn btn-info btn-shock" type="reset" id="reset">내용 지우기</button>
    <button class="btn btn-success btn-shock" type="button" id="send">전송</button>
  </div>
</form>  









</body>
</html>