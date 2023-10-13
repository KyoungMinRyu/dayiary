   <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <%@ include file="/WEB-INF/views/include/head.jsp" %>
    <title>선물 등록 폼</title>
    
    <script>

 $(document).ready(function()
    {
      //메인 사진 썸네일 등록
       $("#giftThum").on("change", function(event) {
   
             var reader = new FileReader();
   
             reader.onload = function(event) {
   
                var img = document.createElement("img");
               img.setAttribute("src", event.target.result);
               img.setAttribute("class", "col-lg-6");
               img.style.maxWidth = "20%";
               img.style.maxHeight = "20%";
               document.querySelector("div#image_container").innerHTML = '';
               document.querySelector("div#image_container").appendChild(img);
            };
            
            reader.readAsDataURL(event.target.files[0]);
         });

      //사진 등록
       $("#product_detail_image").on("change", function(event) {
            $("div#images_container").empty();
          
            for(var image of event.target.files){
               var reader = new FileReader();
               
               reader.onload = function(event){
                  var img = document.createElement("img");
                  img.setAttribute("src", event.target.result);
                  img.setAttribute("class", "col-lg-6");
                  img.style.maxWidth = "20%";
                  img.style.maxHeight = "20%";
                  document.querySelector("div#images_container").appendChild(img);
               };
               
               reader.readAsDataURL(image);
            }
          
       });
       
       
       
       
  //등록하기 버튼을 눌렀을 때
   $("#btnSubmit").on("click", function()
   {     var fileInput = document.getElementById("giftThum");

         // 파일이 선택되었는지 확인
         if (fileInput.files.length === 0) {
             alert("메인사진 파일을 선택하세요.");
             return;
         }
       
        if($("#giftName").val() == null || $("#giftName").val() == "")
        {
           alert("선물 이름를 입력하세요.");
           $("#giftName").focus();
           return;
        }
        
        if($("#giftContent").val() == null || $("#giftContent").val() == "")
        {
           alert("선물 소개를 입력하세요.");
           $("#giftContent").focus();
           return;
        }
        
        if($("#giftPrice").val() == null || $("#giftPrice").val() == "")
        {
           alert("선물 가격을 입력하세요.");
           $("#giftPrice").focus();
           return;
        }
        
        if (!$("input[name='giftCategory']:checked").length) 
          {
             alert("선물 카테고리를 체크하세요.");
             return;
          }
        
         var detailFileInput = document.getElementById("product_detail_image");
      
         // 파일이 선택되었는지 확인
         if (detailFileInput.files.length === 0) {
             alert("상세사진 파일을 선택하세요.");
             return;
         }
        
        
       //최종 선물등록 시작=============================================ㄴ
       var form = $("#giftForm")[0]; 
       //<form name="writeForm" id="writeForm" method="post" enctype="multipart/form-data">
       var formData = new FormData(form); 

   $.ajax({
      type:"POST",
      enctype:"multipart/form-data",
      url:"/gift/giftProc",
      data:formData,
      processData:false,      //formData를 string으로 변환하지 않음
      contentType:false,      //content-type헤더가 multipart/form-data로 전송
      cache:false,
      timeout:600000,
      beforeSend:function(xhr)
      {
         xhr.setRequestHeader("AJAX", "true");
         
      },
      success:function(response)
      {
         if(response.code == 0)
          { // insert 성공
               alert("선물 등록에 성공하셨습니다.");
               location.href = "/gift/giftView?productSeq=" + response.data;
          }
          else if(response.code == 400)
          { // 파라미터 오류
           
            alert("입력값이 잘못 되었습니다.");
          }
          else if(response.code == 500)
          { // 서버 에러
               alert("서버에 에러가 발생하였습니다.");
          }
          else
          { // 알 수 없는 오류
               alert("알 수 없는 오류가 발생하였습니다.");
          }
      },
      error:function(error)
      {
         icia.common.error(error);
         alert("선물 등록 중 오류가 발생하였습니다.");
         $("#btnSubmit").prop("disabled", false);    //글쓰기 버튼 활성화
      }
   });
   });
      
});       


    </script>
</head>
<%@ include file="/WEB-INF/views/include/navigation.jsp" %>
<style>
@font-face {
   font-family: 'SUIT-Regular'; /* 고딕 */
   src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_suit@1.0/SUIT-Regular.woff2') format('woff2');
   font-weight: 100;
   font-style: normal;
} 

body {
  font-family: 'SUIT-Regular', sans-serif;
   background-color: #fffbf4 !important;
   
}

.flexbox-container {
   display: -ms-flex;
   display: -webkit-flex;
   display: flex;
   margin-bottom: 200px;
}

.flexbox-container > div {
   width: 50%;
   padding: 10px;
  background: #fff;
  margin-top:140px;
  margin-right:50px;
  border-radius:10px;
}

.flexbox-container > div:first-child {
   margin-right: 20px;
   margin-top:140px;
   margin-left:50px;
   border-radius:10px;
}

footer {
	position: fixed;
    bottom: 0;
    width: 100%;
    height: auto;
}

</style>
<body>
  <form name="giftForm" id="giftForm" method="post" enctype="multipart/form-data">
    <div class="flexbox-container">

      <div class="field1">
      <div class="field11" style="text-align: center;">
      <span style="font-size: 36px; color: #000000;"> 판매자 선물 등록 </span>
      </div><br><br>

     <div class="field2">        
      <b style="color: #000000;">선물리스트:메인사진</b>
      <input type="file" id="giftThum" name="giftThum" class="form-control mb-2" onchange="setThumbnail(event)" />
      <div id="image_container"></div>
   </div><br><br><br><br>
      
       <div class="field3">
      <b style="color: #000000;">선물 이름</b>
      <input type="text" id="giftName" name="giftName" class="form-control mb-2" required />
       </div><br><br>

     <div class="1">
    <div class="field about-gift">
        <b style="color: #000000;">선물 한줄소개</b>
        <textarea class="form-control" name="giftContent" id="giftContent" style="ime-mode:active; height:160px;" placeholder="선물 소개를 해주세요" ></textarea>
     </div>
  </div>
 </div>  
  <div class="ohno">
   <div class="field gift-deposit">
        <b style="color: #000000;">선물 가격</b>
        <input type="number" class="form-control" name="giftPrice" id="giftPrice" placeholder="선물 가격을 입력해주세요" />
     </div>
     <br>
    <div class="field gift-type">
              <b style="color: #000000;">선물 카테고리</b>
        <div class="giftCategory">
           <label><input type="radio" name="giftCategory" id="giftCategory1" value="뷰티"> 뷰티</label>
           <label><input type="radio" name="giftCategory" id="giftCategory2" value="악세서리"> 악세서리</label>
           <label><input type="radio" name="giftCategory" id="giftCategory3" value="패션"> 패션</label>
           <label><input type="radio" name="giftCategory" id="giftCategory4" value="가전"> 가전</label>
           <label><input type="radio" name="giftCategory" id="giftCategory5" value="식품"> 식품</label>
           <label><input type="radio" name="giftCategory" id="giftCategory6" value="꽃"> 꽃</label> 
       </div>
   </div><br><br>
   
   
   <div class="field5">
        <b style="color: #000000;">선물 상세 사진</b>                  
   <div class="form-group">
      <input class="form-control form-control-user" type="file" multiple="multiple"
      name="product_detail_image" id="product_detail_image" onchange="setDetailImage(event)" />
   </div>
   <div id="images_container"></div>
   <br><br>
 </div>

  <input type="button" value="등록하기" id="btnSubmit"  style="background-color: #000000;  color: #FFFFFF"/>

  </div>
  </div>
 </form>
</body>

<footer style="background-color: black; color: lightgray; text-align: center; margin-top:80px; padding: 30px;">
 <a style="font-size:20px; letter-spacing:5px;">《 Dayiary 》 </a> <br>
    &copy; Copyright Dayiary Corp. All Rights Reserved. <br>
    Always with you 🎉 여러분의 일상을 함께합니다.
</footer> 
</html>