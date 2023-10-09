<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/views/include/head.jsp" %>
    
    <script>

$(document).ready(function()
{
	let productSeq = "${giftAdd.productSeq}";

       
  //등록하기 버튼을 눌렀을 때
   $("#btnSubmit").on("click", function()
   {    
      
       //최종 선물등록 시작=============================================ㄴ
       var form = $("#giftUpdateForm")[0]; 
       //<form name="writeForm" id="writeForm" method="post" enctype="multipart/form-data">
       var formData = new FormData(form); 

   $.ajax({
      type:"POST",
      enctype:"multipart/form-data",
      url:"/seller/giftUpdateProc",
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
             	alert("선물 수정에 성공하셨습니다.");
             	location.href = "/gift/giftView?productSeq=" + productSeq;
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
 

 function setThumbnail(event) {
       const input = event.target;
       if (input.files && input.files[0]) {
           const reader = new FileReader();

           reader.onload = function (e) {
               // 미리보기를 위한 이미지 태그 업데이트
               const imageContainer = document.getElementById('image_container');
               const existingImage = document.getElementById('existingImage');

               if (existingImage) {
                   // 기존 이미지가 있다면 업데이트
                   existingImage.src = e.target.result;
               } else {
                   // 기존 이미지가 없다면 새로 추가
                   const newImage = document.createElement('img');
                   newImage.src = e.target.result;
                   newImage.alt = '미리보기 이미지';

                   imageContainer.appendChild(newImage);
               }
           };

           reader.readAsDataURL(input.files[0]);
       }
   }

  


 
  function setDetailImage(event) {
       const input = event.target;
       const imageContainer = document.getElementById('images_container');

       // 기존의 미리보기 이미지 삭제 (기존 이미지가 있다면)
       const existingDetailImage = document.getElementById('existingDetailImage');
       if (existingDetailImage) {
           imageContainer.removeChild(existingDetailImage);
       }

       for (let i = 0; i < input.files.length; i++) {
           const file = input.files[i];
           const reader = new FileReader();

           reader.onload = function (e) {
               // 미리보기를 위한 이미지 태그 생성
               const newImage = document.createElement('img');
               newImage.src = e.target.result;
               newImage.alt = '미리보기 이미지';
               newImage.className = 'imageTag';

               // 이미지를 컨테이너에 추가
               imageContainer.appendChild(newImage);
           };

           reader.readAsDataURL(input.files[i]);
       }
   }

  
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
}

.flexbox-container > div {
   width: 50%;
   padding: 10px;
  background: #fff;
  margin-top:140px;
}

.flexbox-container > div:first-child {
   margin-right: 20px;
   margin-top:140px;
}

.imageTag{
   width: 200px;
   height: 200px;
}

</style>
<body>
  <form name="giftUpdateForm" id="giftUpdateForm" method="post" enctype="multipart/form-data">
    <div class="flexbox-container">

      <div class="field1">
      <div class="field11" style="text-align: center;">
      <span style="font-size: 36px; color: #000000;"> 판매자 선물 수정 </span>
      </div><br><br>

     <div class="field2">        
      <b style="color: #000000;">선물리스트:메인사진</b>
      <input type="file" id="giftThum" name="giftThum" class="form-control mb-2" onchange="setThumbnail(event)" />
      <div id="image_container"> <img src="/resources/upload/${giftFileList.get(0).fileName}" id="existingImage" name="existingImage" alt="기존 이미지" class="imageTag"></div>
   </div><br><br><br><br>
      
       <div class="field3">
      <b style="color: #000000;">선물 이름</b>
      <input type="text" id="giftName" name="giftName"  value="${giftAdd.pName}" class="form-control mb-2" required />
       </div><br><br>

     <div class="1">
    <div class="field about-gift">
        <b style="color: #000000;">선물 한줄소개</b>
        <input type="text" class="form-control" name="giftContent" id="giftContent" value="${giftAdd.pContent}"  style="ime-mode:active;"  placeholder="선물 소개를 수정해주세요" /> 
     </div>
  </div>
 </div>  
  <div class="ohno">
   <div class="field gift-deposit">
        <b style="color: #000000;">선물 가격</b>
        <input type="number" class="form-control" name="giftPrice" id="giftPrice"  value="${giftAdd.pPrice}"  placeholder="선물 가격을 수정해주세요" />
   </div>
     <br>
    <div class="field gift-type">
              <b style="color: #000000;">선물 카테고리(목걸이,시계 등은 악세서리 / 화장품, 향수는 뷰티)</b>
        <div class="giftCategory">
        	<label><input type="radio" name="giftCategory" id="giftCategory1" value="뷰티"  ${giftAdd.productCategory == '뷰티' ? 'checked' : ''}> 뷰티</label>
           	<label><input type="radio" name="giftCategory" id="giftCategory2" value="악세서리"  ${giftAdd.productCategory == '악세서리' ? 'checked' : ''}> 악세서리</label>
           	<label><input type="radio" name="giftCategory" id="giftCategory3" value="패션"  ${giftAdd.productCategory == '패션' ? 'checked' : ''}> 패션</label>
           	<label><input type="radio" name="giftCategory" id="giftCategory4" value="가전"  ${giftAdd.productCategory == '가전' ? 'checked' : ''}> 가전</label>
           	<label><input type="radio" name="giftCategory" id="giftCategory5" value="식품"  ${giftAdd.productCategory == '식품' ? 'checked' : ''}> 식품</label>
           	<label><input type="radio" name="giftCategory" id="giftCategory6" value="꽃"  ${giftAdd.productCategory == ' 꽃' ? 'checked' : ''}> 꽃</label> 
		</div>
   </div><br>
   <div class="field gift-status">
        <b style="color: #000000;">선물 공개 여부</b> 
        <div class="giftStatus">
         <label><input type="radio" name="giftStatus" id="giftStatus1" value="Y" ${giftAdd.status == 'Y' ? 'checked' : ''}> Y</label>
         <label><input type="radio" name="giftStatus" id="giftStatus2" value="N" ${giftAdd.status == 'N' ? 'checked' : ''}> N</label>
         </div>
   </div><br>
   
   <div class="field5">
        <b style="color: #000000;">선물 상세 사진</b>                  
   <div class="form-group">

                <input class="form-control  mb-2" type="file" 
                    name="detailImage" id="detailImage" multiple="multiple" onchange="setDetailImage(event)" />

                <div id="images_container">
                <c:forEach var="giftFileList" items="${giftFileList}" varStatus="status">
                <c:if test="${!status.first}">
                    <img src="/resources/upload/${giftFileList.fileName}" alt="기존 상세 이미지" id="existingDetailImage" name="existingDetailImage" class="imageTag">
                 </c:if>
                 </c:forEach> 
                </div>
         
 </div>
<br>
   <input type="button" value="수정하기" id="btnSubmit"  style="background-color: #000000;  color: #FFFFFF"/>
   <input type="hidden" name="productSeq" value="${giftAdd.productSeq}" />
   <input type="hidden" name="thumSeq" value=" ${giftFileList.get(0).fileSeq}" />
   <input type="hidden" name="detailSeq" value=" ${giftFileList.get(1).fileSeq}" />
  </div>
  </div>
  </div>
 </form>
<footer style="background-color: black; color: lightgray; text-align: center; margin-top:240px; padding: 40px;">
 <a style="font-size:20px; letter-spacing:5px;">《 Dayiary 》 </a> <br>
    &copy; Copyright Dayiary Corp. All Rights Reserved. <br>
    Always with you 🎉 여러분의 일상을 함께합니다.
</footer> 
</body>
</html>