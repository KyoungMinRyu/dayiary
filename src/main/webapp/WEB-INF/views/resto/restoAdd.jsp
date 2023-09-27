<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <%@ include file="/WEB-INF/views/include/head.jsp" %>
    <title>레스토랑 등록 폼</title>
    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
    
    <script>

    
    //매장 전화번호(핸드폰,지역번호 모두 받기) 받는 함수        
    function oninputPhone(target) {
        target.value = target.value
            .replace(/[^0-9]/g, '')
            .replace(/(^02.{0}|^01.{1}|[0-9]{3,4})([0-9]{3,4})([0-9]{4})/g, "$1-$2-$3");
    }
   
   
    
 $(document).ready(function() {
   
    var menuCount = 1;
    

    //상세 주소 입력시 도로명주소+상세주소 합쳐지는 거
     $("#detailAddress").on("input", function() 
    {
       $("#restoAddMsg").html("&nbsp;");
       $("#hiddenAdd").val($("#roadAddress").val() + " " + $("#detailAddress").val());    
       //console.log(document.getElementById("roadAddress").value);
    });   
    
   //메뉴 추가하기 펑션
    $("#menuPlus").on("click", function() {
           
        var div = document.createElement('div');
        div.innerHTML = $(".restoMenuAdd").html();
       
        // 각 요소에 고유한 ID,NAME를 추가
        $(div).find(".menuName").attr("id", "menuName" + menuCount);
        $(div).find(".menuPrice").attr("id", "menuPrice" + menuCount);
        $(div).find(".menuDescription").attr("id", "menuDescription" + menuCount);
        $(div).find(".menuFile").attr("id", "menuFile" + menuCount);
 
        $(div).find(".menuName").attr("name", "menuName" + menuCount);
        $(div).find(".menuPrice").attr("name", "menuPrice" + menuCount);
        $(div).find(".menuDescription").attr("name", "menuDescription" + menuCount);
        $(div).find(".menuFile").attr("name", "menuFile" + menuCount);
        
        
        $(".field9").append(div);
  
        menuCount++;
     
        $("#menuCount").val(menuCount);
    });
    
    //메뉴삭제하기 펑션
        $("#menuDelete").on("click", function() {
            if (menuCount > 1) 
            { // 메뉴 아이템이 1개 이상일 때만 삭제
                menuCount--; // 가장 최근 추가된 메뉴 아이템의 ID를 감소

                $("#menuName" + menuCount).remove(); // 해당 ID를 가진 메뉴 아이템없애기
                $("#menuPrice" + menuCount).remove();
                $("#menuDescription" + menuCount).remove();
                $("#menuFile" + menuCount).remove();
                $("#menuCount").val(menuCount);
                
            }             
        });
    

    
    //등록하기 버튼을 눌렀을 때
   $("#btnSubmit").on("click", function()
   {            
      //휴무일 하루, 이틀일 때 처리
      var selectRestoOff = [];
      $(".restoOff input:checked").each(function() {
          selectRestoOff.push($(this).val());
      });
      
      if (selectRestoOff.length === 1) {
          combinedRestoOff = selectRestoOff[0];
      } else {
          var combinedRestoOff = selectRestoOff.join("");
      }

      $("#hiddenRestoOff").val(combinedRestoOff);
        
        
       //최종 회원가입 시작=============================================ㄴ
       var form = $("#hidrestoForm")[0]; 
       //<form name="writeForm" id="writeForm" method="post" enctype="multipart/form-data">
       var formData = new FormData(form); 
       

    
   $.ajax({
      type:"POST",
      enctype:"multipart/form-data",
      url:"/resto/restoProc",
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
             alert("매장 등록에 성공하셨습니다.");
              location.href = "/index/sellerIndex";
           }
           else if(response.code == 400)
           { // 파라미터 오류
            
             alert("매장 등록에 실패하셨습니다.");
              location.href = "/";   
           }
           else if(response.code == 100)
           { // 회원이 이미 존재함

             alert("매장 등록에 실패하셨습니다.1");
              location.href = "/";   
           }
           else if(response.code == 500)
           { // 서버 에러
             alert("매장 등록에 실패하셨습니다.2");
              location.href = "/";   
           }
           else
           { // 알 수 없는 오류
             alert("매장 등록에 실패하셨습니다.3");
              location.href = "/";   
           }
      },
      error:function(error)
      {
         icia.common.error(error);
         alert("게시물 등록 중 오류가 발생하였습니다.");
         $("#btnSubmit").prop("disabled", false);    //글쓰기 버튼 활성화
      }
   });
   
   });   
});       

      //매장 주소 입력
    // 도로명 주소 표기 방식에 대한 법령에 따라, 내려오는 데이터를 조합하여 올바른 주소를 구성하는 방법을 설명합니다.
    function getDaumPostcode2() 
    {
         $("#restoAddMsg").html("&nbsp;");
       new daum.Postcode
       ({
           oncomplete: function(data) 
            {
                 // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                 // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                 // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
               var addr2 = ''; // 주소 변수s
                var extraAddr2 = ''; // 참고항목 변수

                 //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') 
                { // 사용자가 도로명 주소를 선택했을 경우
                    addr2 = data.roadAddress;
                }
                else 
                { // 사용자가 지번 주소를 선택했을 경우(J)
                   addr2 = data.jibunAddress;
                }

                 // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
                if(data.userSelectedType === 'R')
                {
                     // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                     // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname))
                    {
                        extraAddr2 += data.bname;
                    }
                    // 건물명이 있고, 공동주택일 경우 추가한다.
                    if(data.buildingName !== '' && data.apartment === 'Y')
                    {
                        extraAddr2 += (extraAddr2 !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                } 

                 // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('postcode').value = data.zonecode;
                document.getElementById("roadAddress").value = addr2;
                 
                console.log($("#roadAddress").val());
                
                 // 커서를 상세주소 필드로 이동한다.
                $("#detailAddress").focus();
              }
         
       }).open();
       
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
  margin-right:50px;
  border-radius:10px;
}

.flexbox-container > div:first-child {
   margin-right: 20px;
   margin-top:140px;
   margin-left:50px;
   border-radius:10px;
}

</style>
<body>
    <form name="hidrestoForm" id="hidrestoForm" method="post" enctype="multipart/form-data">
    <div class="flexbox-container">

         <div class="field1">
            <div style="text-align: center;">
            <span style="font-size: 36px; color: #000000;"> 판매자 매장 등록 </span>
            </div><br><br>

                
           <b style="color: #000000;">예약리스트:메인사진</b>
           <input type="file" id="restoThum" name="restoThum" class="form-control mb-2" required /><br><br>

           
            <div class="field2">
                <b style="color: #000000;">매장이름 </b>
                <input class="restoName" type="text" placeholder="매장이름을 입력하세요" name="restoName" id="restoName" />
            </div><br><br>
      
           <div class="field">         
           <b style="color: #000000;">매장주소 </b>  
           
            </div>
      
         <div class="field">
          <div style="display: flex;">
              <input type="text" name="postcode" id="postcode" style="flex: 1.5; margin-right: 5px; background-color: #FFF;" placeholder="우편번호" disabled >             
              <input type="text" name="roadAddress" id="roadAddress" style="flex: 5; background-color: #FFF;" placeholder="도로명주소" disabled >
          </div>
         </div>
          <div>
            <input type="text" name="detailAddress" id="detailAddress" style="margin-top:5px;" placeholder="상세주소" >
               <input type="button" onclick="getDaumPostcode2()" value="우편번호 찾기"  style="background-color: #000000;  color: #FFFFFF;" >
              <input type="hidden" id="hiddenAdd" name="hiddenAdd" value="" />
          </div>
      
          <p id="restoAddMsg">
          </p>
      
          <div class="field tel-number">
               <b style="color: #000000;">매장번호</b>
               <input type="text" class="form-control" name="restoPh" id="restoPh" oninput="oninputPhone(this)" maxlength="14">
             </div><br><br>
             
         <div class="field about-resto">
              <b style="color: #000000;">매장 한줄소개</b>
              <textarea  class="form-control" name="restoContent" id="restoContent" style="ime-mode:active;" placeholder="매장소개를 해주세요" ></textarea>
           </div>
      
         <div class="field resto-deposit">
              <b style="color: #000000;">매장 예약금</b>
              <input type="number" class="form-control" name="restoDeposit" id="restoDeposit" placeholder="매장예약금을 입력해주세요" />
           </div>
           
         <div class="field resto-deposit">
              <b style="color: #000000;">매장 수용 인원</b>
              <input type="number" class="form-control" name="restoLimitPpl" id="restoLimitPpl" placeholder="시간당 인원을 입력해주세요" />
           </div>
     
     </div>
               
   <div class="field5">
        <b style="color: #000000;">매장 상세 사진</b>
        <div class="field">
   <input type="file" id="restoFile" name="restoFile" class="form-control mb-2" multiple="multiple" />
        </div>
   <br><br>

   <div class="field6">
           <b style="color: #000000;">매장 타입</b>
           <div class="restoType">
           <label><input type="radio" name="restoType" id="restoType1" value="레스토랑" > 레스토랑</label>
           <label><input type="radio" name="restoType" id="restoType2" value="오마카세"> 오마카세</label>
           <label><input type="radio" name="restoType" id="restoType3" value="뷔페"> 뷔페</label>
           <label><input type="radio" name="restoType" id="restoType4" value="파인다이닝"> 파인다이닝</label>
           <label><input type="radio" name="restoType" id="restoType5" value="일반식당"> 일반식당</label>
           </div>
   </div><br>
   
   <div class="field7">
              <b style="color: #000000;">음식 타입</b>
        <div class="restoMenuType">
           <label><input type="radio" name="restoMenuType" id="restoMenuType1" value="한식"> 한식</label>
           <label><input type="radio" name="restoMenuType" id="restoMenuType2" value="중식"> 중식</label>
           <label><input type="radio" name="restoMenuType" id="restoMenuType3" value="일식"> 일식</label>
           <label><input type="radio" name="restoMenuType" id="restoMenuType4" value="양식"> 양식</label>
           <label><input type="radio" name="restoMenuType" id="restoMenuType5" value="기타"> 기타</label>
       </div>
   </div><br>
   
   <div class="field8">
              <b style="color: #000000;">식당 휴무일</b>
        <div class="restoOff">
              <label><input type="checkbox" name="restoOff" id="restoOff1" value="월"> 월</label>
              <label><input type="checkbox" name="restoOff" id="restoOff2" value="화"> 화</label>
              <label><input type="checkbox" name="restoOff" id="restoOff3" value="수"> 수</label>
              <label><input type="checkbox" name="restoOff" id="restoOff4" value="목"> 목</label>
              <label><input type="checkbox" name="restoOff" id="restoOff5" value="금"> 금</label>
              <label><input type="checkbox" name="restoOff" id="restoOff6" value="토"> 토</label>
              <label><input type="checkbox" name="restoOff" id="restoOff7" value="일"> 일</label>
                <input type="hidden" id="hiddenRestoOff" name="hiddenRestoOff" value="" />
       </div>
   </div><br>
   
   <div class="field9">
   <b style="color: #000000;">식당메뉴(메뉴 하나 당 사진 첨부해주세요)</b><br>
       <div class="restoMenuAdd" id="menuPl">
            <input type="text" class="menuName" id="menuName" name="menuName" placeholder="메뉴명 입력" />
         <input type="text" class="menuPrice" id="menuPrice" name="menuPrice" placeholder="가격 입력" />
             <input type="text" class="menuDescription" id="menuDescription" name="menuDescription" placeholder="메뉴 설명 입력" />    
            <input type="file" class="menuFile" id="menuFile" name="menuFile" class="form-control mb-2" style="margin-top:5px;" />
      </div>
            <input type="button" value="메뉴추가하기" id="menuPlus" name="menuPlus" style="background-color: #000000; margin-top:10px; color: #FFFFFF;" />
            <input type="button" value="메뉴삭제하기" id="menuDelete" name="menuDelete"  style="background-color: #000000; margin-top:10px; color: #FFFFFF;" />

      </div><br><br>
   
   
   <div class ="field10">
   <b style="color: #000000;">매장 오픈 시간</b><br>
     <input type="time" id="restoOpen" name="restoOpen" />
   </div>
   
   <div class = "field11">
   <b style="color: #000000;">매장 마감 시간</b><br>
      <input type="time" id="restoClose" name="restoClose" />
   </div>
   
  <input type="button" value="가입하기" id="btnSubmit"  style="background-color: #000000; margin-top:20px; color: #FFFFFF"/>
   <input type="hidden" id="menuCount" name="menuCount" value="" />
   </div>
  </div>
   </form>

<footer style="background-color: black; color: lightgray; text-align: center; margin-top:80px; padding: 30px;">
 <a style="font-size:20px; letter-spacing:5px;">《 Dayiary 》 </a> <br>
    &copy; Copyright Dayiary Corp. All Rights Reserved. <br>
    Always with you 🎉 여러분의 일상을 함께합니다.
</footer>    
</body>
</html>