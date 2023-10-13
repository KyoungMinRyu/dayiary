<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/views/include/head.jsp" %>
<style>

/* 폰트 모아두기 */
@font-face {
    font-family: 'SUIT-Regular'; /* 고딕 */
    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_suit@1.0/SUIT-Regular.woff2') format('woff2');
    font-weight: 100;
    font-style: normal;
} 

@font-face {
    font-family: 'Hahmlet-Regular';
    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2110@1.0/Hahmlet-Regular.woff2') format('woff2');
    font-weight: normal;
    font-style: normal;
}

@font-face {
    font-family: 'Arita-buri-SemiBold';
    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_one@1.0/Arita-buri-SemiBold.woff') format('woff');
    font-weight: normal;
    font-style: normal;
}

@font-face {
    font-family: 'NanumSquareNeo-Variable';
    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_11-01@1.0/NanumSquareNeo-Variable.woff2') format('woff2');
    font-weight: normal;
    font-style: normal;
}

/* 폰트 모아두기 */

body {
   
     background-color: #fffbf4 !important;
}

   *{
      box-sizing: border-box;
      margin: 0;
          padding: 0;
          font-family: 'SUIT-Regular', sans-serif;
   }

   .header{
      height: 530px;
      background-image: url('/resources/images/resto.jpg');
      background-repeat: no-repeat;
      background-size: cover;
      background-position: center center;
      margin-top:75px;
   }

   h3{
      font-family: 'Hahmlet-Regular', sans-serif;
      font-size: 40px;
      color: #545454;
      margin-top: 60px;
      margin-bottom: 60px;
      text-align: center;
      word-spacing: 5px;
      letter-spacing:7px;
      text-shadow: 1px 1px 1px rgba(1, 1, 2, 0.4);
   }   
   
   .main-container {
      display: flex;
      max-width: 1500px;
      margin: 0 auto;
     position: relative;
     flex-direction: column;
   }
   
   
   
/* 레스토랑 리스트 섹션 코드 */
   .products {
       display: flex;
       flex-wrap: wrap;
       justify-content: space-between;
       width: 1300px;
       margin: 0 auto;
       flex: 2;
   }
   
   .product {
       width: 49.5%;
       margin-bottom: 15px;
       margin-top: 5px;
       display: flex !important;
       border: 2px solid #8d8d8d;
       box-sizing: border-box;
       padding:10px;
       padding-bottom:0px;
       flex-direction: column;
       align-items: center;
   }
   
   .product-image img {
       width: 600px;
       height: 350px;
       object-fit: cover;
       margin-bottom:30px;
   }
   
   .product-description {
       flex: 2;
       padding: 10px;
       box-sizing: border-box;
       display: flex;
       flex-direction: column;
       letter-spacing:2px;
       width:100%;
   }
   
   .product-description h2 {
      font-family: 'NanumSquareNeo-Variable', sans-serif;
       margin: 0;
       font-size:35px;
       letter-spacing:5px;
       text-shadow: 1px 1px 1px rgba(1, 1, 2, 0.4);
       text-align: center;
   }
   
   .product-description p {
       font-size: 20px;
       margin-left:20px;
   }
   
   .product-description #restoContent
   {
      height: 90px;
       display: flex;
       align-items: center;
       font-size:20px;
       color: slategrey;
       margin-bottom:30px;
   }
   
   .product-address {
       font-size: 20px;
       color: #e74c3c;
       margin-bottom:20px;
       margin-left:20px;
   }
   
   #click img{
      width: 150px; 
      height: 35px; 
      justify-self: end; 
      margin-right:40px; 
   }
   
   /*자세히보기버튼 오른쪽 정렬용 컨테이너*/
   div#bb { 
    width: 100%;
    margin-bottom:30px;
}

.productNo{
    width: 100%;
    height:500px;
    margin-bottom: 15px;
    margin-top: 5px;
    display: flex !important;
    border: 2px solid #8d8d8d;
    box-sizing: border-box;
    padding: 10px;
    padding-bottom: 0px;
    flex-direction: row;
    align-items: center;
    text-align:center;
    font-size:25px;
    
}

/* 레스토랑 리스트 섹션 코드 끝 */      
      
   
   

/* 검색조건 코드 */   
    .search-container {
        display: flex;
        justify-content: center;
          align-items: baseline;
        margin-top: 20px;
        padding: 10px;
        padding-bottom : 0px;
        background-color: #f0f0f0;
        width:100%;
        font-size:18px;
        font-weight:bold;
        font-family: 'SUIT-Regular', sans-serif;
        
    }

    .search-container label {
        margin-right: 10px;
        
    }

    .search-container select {
        padding: 5px;
        border: 1px solid #ccc;
        border-radius: 3px;
        margin-right: 30px;
    }

    .search-container button {
        padding: 5px 10px;
        border: none;
        border-radius: 3px;
        background-color: #007bff;
        color: white;
        cursor: pointer;
    }
    
    label, #dateInput
    {
       margin-bottom: 0 !important;
       margin-top: 0 !important;
    }
/* 검색조건 */



/*페이지 버튼*/

.page-item.active .page-link {
    z-index: 1;
    color: #fff;
    background-color: #000000;
    border-color: #000000;
}

.page-item .page-link {
    color: black;
    background-color: white;
}

</style>






<script type="text/javascript">

$(document).ready(function() {
   
   //조회 버튼 눌렀을때
   $("#btnSearch").on("click", function() { 
       document.bbsForm.rSeq.value = "";
       document.bbsForm.searchTypeLocation.value = $("select[name=location]").val();
       document.bbsForm.searchTypeShop.value = $("select[name=shop]").val();
       document.bbsForm.searchTypeFood.value = $("select[name=food]").val();

       //2023-08-30 형식의 날짜에서 요일만 받아서 서버로 보냄
       const selectedDate = new Date(dateInput.value);
       const daysOfWeek = ['일', '월', '화', '수', '목', '금', '토'];
       const searchTypeDate = daysOfWeek[selectedDate.getDay()];
       
       if(searchTypeDate !== undefined) //사용자가 날짜 입력 안했으면 undefined 값이 나오는데, undefined면 서버로 보내지 않기 위함
       {
             document.bbsForm.searchTypeDate.value = searchTypeDate;
       }
       
       document.bbsForm.curPage.value = "1";
       document.bbsForm.action = "/resto/restoList";
       document.bbsForm.submit();
   });
   

   //초기화 버튼 눌렀을시 검색조건 없애고 리로드
   $("#btnRefresh").on("click", function() {  
      document.bbsForm.rSeq.value = "";
       document.bbsForm.searchTypeLocation.value = "";
       document.bbsForm.searchTypeShop.value = "";
       document.bbsForm.searchTypeFood.value = "";
       document.bbsForm.searchTypeDate.value = "";
       document.bbsForm.curPage.value = "1";
       document.bbsForm.action = "/resto/restoList";
       document.bbsForm.submit();
   });
   

});



function fn_view(rSeq)
{
   document.bbsForm.rSeq.value = rSeq;
   document.bbsForm.action = "/resto/restoView";
   document.bbsForm.submit();
}

function fn_list(curPage)
{
   document.bbsForm.rSeq.value = "";
   document.bbsForm.curPage.value = curPage;
   document.bbsForm.action = "/resto/restoList";
   document.bbsForm.submit();
}


</script>













  </head>
<body>
<%@ include file="/WEB-INF/views/include/navigation.jsp" %>

   <div class="header"></div>

    <h3> Restaurant ― RESERVATION </h3>




 <main class="main-container">
 


    
     <!-- 레스토랑 리스트 -->
   <section class="products">
        
        
   <!-- 검색 조건 -->
    <div class="search-container">
        <label for="location">위치:</label>
        <select id="location" name="location">
           <option value="" disabled selected>선택하세요</option>
            <option value="서울" <c:if test='${searchTypeLocation eq "서울"}'>selected</c:if>>서울</option>
            <option value="경기" <c:if test='${searchTypeLocation eq "경기"}'>selected</c:if>>경기</option>
            <option value="부산" <c:if test='${searchTypeLocation eq "부산"}'>selected</c:if>>부산</option>
            <option value="인천" <c:if test='${searchTypeLocation eq "인천"}'>selected</c:if>>인천</option>
            <option value="제주" <c:if test='${searchTypeLocation eq "제주"}'>selected</c:if>>제주</option>
        </select>

        <label for="shop">식당 종류:</label>
        <select id="shop" name="shop">
           <option value="" disabled selected>선택하세요</option>
            <option value="레스토랑" <c:if test='${searchTypeShop eq "레스토랑"}'>selected</c:if>>레스토랑</option>
            <option value="오마카세" <c:if test='${searchTypeShop eq "오마카세"}'>selected</c:if>>오마카세</option>
            <option value="뷔페" <c:if test='${searchTypeShop eq "뷔페"}'>selected</c:if>>뷔페</option>
            <option value="파인다이닝" <c:if test='${searchTypeShop eq "파인다이닝"}'>selected</c:if>>파인다이닝</option>
            <option value="일반식당" <c:if test='${searchTypeShop eq "일반식당"}'>selected</c:if>>일반식당</option>
        </select>
        
        <label for="food">음식 종류:</label>
        <select id="food" name="food">
           <option value="" disabled selected>선택하세요</option>
            <option value="한식" <c:if test='${searchTypeFood eq "한식"}'>selected</c:if>>한식</option>
            <option value="중식" <c:if test='${searchTypeFood eq "중식"}'>selected</c:if>>중식</option>
            <option value="일식" <c:if test='${searchTypeFood eq "일식"}'>selected</c:if>>일식</option>
            <option value="양식" <c:if test='${searchTypeFood eq "일식"}'>selected</c:if>>양식</option>
            <option value="기타" <c:if test='${searchTypeFood eq "기타"}'>selected</c:if>>기타</option>
        </select>

        <label for="date">예약 날짜:</label>
        <p><input type="date" id="dateInput"></p>

        <button id="btnSearch" style="background-color:black; margin-right:-8px; margin-left:10px;">조회</button>
        <button id="btnRefresh" style="background-color:gray; margin-left:10px;">초기화</button>
    </div>
    <!-- 검색 조건 끝 -->

<c:if test="${!empty list}">      <!--list 객체가 비어있지 않을때 실행-->
   <c:forEach var="restoInfo" items="${list}" varStatus="status">            
   <div class="product">
      <div class="product-image">
         <img src="/resources/upload/${restoInfo.fileName}" alt="Product 1">
      </div>
           <div class="product-description">
              <h2 style="margin-bottom:10px !important;">《 ${restoInfo.restoName} 》</h2>
              
              
          <div id="star" style="display: flex; justify-content: center; margin-bottom:10px;">
          
          <c:set var="starCount" value="${restoInfo.reviewScore}" />
   
           <c:choose>
              <c:when test="${starCount eq 0}"> <!-- 별점이 0일 경우 (아직 리뷰가 없을때) -->
                   <img src="/resources/images/emptyStar.png" style="width:30px; height:30px; border:none !important;" alt="Empty Star">
                   <img src="/resources/images/emptyStar.png" style="width:30px; height:30px; border:none !important;" alt="Empty Star">
                   <img src="/resources/images/emptyStar.png" style="width:30px; height:30px; border:none !important;" alt="Empty Star">
                   <img src="/resources/images/emptyStar.png" style="width:30px; height:30px; border:none !important;" alt="Empty Star">
                   <img src="/resources/images/emptyStar.png" style="width:30px; height:30px; border:none !important;" alt="Empty Star">
                   (${restoInfo.reviewCount}건)
               </c:when>
           
               <c:when test="${(starCount % 2) eq 0}"> <!-- 별점이 짝수일 경우 (꽉찬별만 있을때) -->
                  <c:forEach var="i" begin="1" end="${starCount / 2}">
                   <img src="/resources/images/fullStar.png" style="width:30px; height:30px; border:none !important;" alt="Full Star">
                   </c:forEach>
                   <c:forEach var="i" begin="1" end="${5 - (starCount / 2)}">
                   <img src="/resources/images/emptyStar.png" style="width:30px; height:30px; border:none !important;" alt="Empty Star">
                   </c:forEach>
                   (${restoInfo.reviewCount}건)
               </c:when>
                
               <c:when test="${(starCount % 2) eq 1}">
                  <c:forEach var="i" begin="1" end="${starCount / 2}"> <!-- 별점이 홀수일 경우 (반개별 필요) -->
                   <img src="/resources/images/fullStar.png" style="width:30px; height:30px; border:none !important;" alt="Full Star">
                   </c:forEach>
                   <img src="/resources/images/halfStar.png" style="width:30px; height:30px; border:none !important;" alt="Half Star">
                   <c:forEach var="i" begin="1" end="${5 - (starCount / 2)}">
                   <img src="/resources/images/emptyStar.png" style="width:30px; height:30px; border:none !important;" alt="Empty Star">
                   </c:forEach>
                   (${restoInfo.reviewCount}건)
               </c:when>
           </c:choose>
            
            
          </div>
              
              
              
              
              
              <p id="restoContent">${restoInfo.restoContent}</p>
               <span class="product-address"><img src="/resources/images/address.png" style="width:20px;height:20px; margin-right:10px;">${restoInfo.restoAddress}</span>
           
            <!--  레스토랑 영업시간 -->
            <c:if test="${restoInfo.restoOpen ne ''}">    
                <p><img src="/resources/images/openClose.png" style="width:20px;height:20px; margin-right:10px;">
                ${(restoInfo.restoOpen).substring(0,2)}${(restoInfo.restoOpen).substring(2)} ~ <!-- 오픈시간 12:00 형식으로 표시 -->
                ${(restoInfo.restoClose).substring(0,2)}${(restoInfo.restoOpen).substring(2)}</p> <!-- 마감시간 12:00 형식으로 표시 -->
            </c:if>
            
            <!-- 레스토랑 휴무요일 -->
            <c:if test="${restoInfo.restoOff eq ''}">
                <p><img src="/resources/images/off.png" style="width:20px;height:20px; margin-right:10px;">연중무휴</p>
            </c:if>
            <c:if test="${restoInfo.restoOff.length() eq 1}"> <!-- 휴무일이 하루라면 -->
                <p><img src="/resources/images/off.png" style="width:20px;height:20px; margin-right:10px;">${restoInfo.restoOff}요일 휴무</p>
            </c:if>
            <c:if test="${restoInfo.restoOff.length() ge 2 }"> <!-- 휴무가 이틀 이상이라면 O요일, O요일로 나눠서 표시 -->
                <p><img src="/resources/images/off.png" style="width:20px;height:20px; margin-right:10px;">${restoInfo.restoOff.charAt(0)}요일, ${restoInfo.restoOff.charAt(1)}요일 휴무</p>
            </c:if>
                
                
                
                <p><img src="/resources/images/call.png" style="width:20px;height:20px; margin-right:10px;">${restoInfo.restoPh}</p>
         </div>
         
         <div id="bb">
                <a href="javascript:void(0)" onclick="fn_view('${restoInfo.rSeq}')">
             <span id="click" style="display:grid;"><img src="/resources/images/자세히보기.png"  alt="자세히 보기"></span>
             </a>
          </div>
   </div>
   </c:forEach>
</c:if>

<c:if test="${empty list}">   
<div class="productNo">
           <div class="product-description">
         </div>
         <div id="bb">
             <span id="click" style="display:grid;">찾으시는 레스토랑이 없습니다. <br> 조건을 변경하여 다시 검색해 주세요.</span>
          </div>
   </div>
</c:if>      
 
   </section>
      <!-- 레스토랑 리스트 끝-->  
      
      
      
<nav>
      <ul class="pagination justify-content-center">
<c:if test="${!empty paging}">      
   <c:if test="${paging.prevBlockPage gt 0}">
         <li class="page-item"><a class="page-link" href="javascript:void(0)" onclick="fn_list(${paging.prevBlockPage})">이전블럭</a></li>
   </c:if>
   
   <c:forEach var="i" begin="${paging.startPage}" end="${paging.endPage}">
      <c:choose>
         <c:when test="${i ne curPage}">
         <li class="page-item"><a class="page-link" href="javascript:void(0)" onclick="fn_list(${i})">${i}</a></li>
            </c:when>
            <c:otherwise> <!-- otherwise:디폴트.모든조건이 거짓일 경우 실행 -->
         <li class="page-item active"><a class="page-link" href="javascript:void(0)" style="cursor:default;">${i}</a></li>
            </c:otherwise>
         </c:choose>
      </c:forEach>
      
      <c:if test="${paging.nextBlockPage gt 0}">
         <li class="page-item"><a class="page-link" href="javascript:void(0)" onclick="fn_list(${paging.nextBlockPage})">다음블럭</a></li>
   </c:if>
</c:if>
      </ul>
</nav>
      
      
      
      
      
        
      <form name="bbsForm" id="bbsForm" method="post">
      <input type="hidden" name="rSeq" value="" />
      <input type="hidden" name="searchTypeLocation" value="${searchTypeLocation}" />
      <input type="hidden" name="searchTypeShop" value="${searchTypeShop}" />
      <input type="hidden" name="searchTypeFood" value="${searchTypeFood}" />
      <input type="hidden" name="searchTypeDate" value="${searchTypeDate}" />
      <!--input type="hidden" name="searchTypePrice" value="${searchPrice}" / -->
      <input type="hidden" name="curPage" value="${curPage}" />
      </form>
        
</main>

   
</body>
<script>
    //날짜 선택시 내일날짜부터 선택할 수 있게 하는 함수
    const dateInput = document.getElementById('dateInput');
   const today = new Date();
   today.setDate(today.getDate() + 1); // 오늘 날짜에서 1일 추가하여 내일로 설정
   const minDate = today.toISOString().split('T')[0];
   dateInput.min = minDate;

    
</script>
</html>