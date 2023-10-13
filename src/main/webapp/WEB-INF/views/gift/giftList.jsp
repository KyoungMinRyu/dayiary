<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%> 
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
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
      background-image: url('/resources/images/gift.png');
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
   
   
   
/* 선물 리스트 섹션 코드 */
   .products {
       display: flex;
       flex-wrap: wrap;
       justify-content: space-between;
       width: 1300px;
       margin: 0 auto;
       flex: 2;
   }
   
 
   .card-container {
     display: flex;
     flex-wrap: wrap;
     justify-content: flex-start;
     gap: 4px; /* 카드 사이의 간격 조정 */
   }
   
   .product-card {
     flex: 0 1 calc(20.9% - 10px); /* 카드가 가로 25% 차지하도록 설정하고 간격을 뺍니다. */
     background-color: #fff;
     border: 1px solid #ddd;
     padding: 10px;
     box-shadow: 0 0 5px rgba(0, 0, 0, 0.1);
     width:322px;
     height:550px;
   }

   .product-image img {
       width: 300px;
       height: 300px;
       object-fit: cover;
       margin-bottom:10px;
   }
   
   .product-description {
       flex: 2;
       padding: 10px;
       box-sizing: border-box;
       display: flex;
       flex-direction: column;
       letter-spacing:2px;
       width:100%;
       align-items: flex-start;
   }
   
   .product-description h1 {
      font-family: 'NanumSquareNeo-Variable', sans-serif;
       margin: 0;
       font-size:35px;
       letter-spacing:5px;
       text-shadow: 1px 1px 1px rgba(1, 1, 2, 0.4);
       text-align: left;
       align-items: center;
       height: 55px;
         display: flex;
   }
   
   .product-description p {
       font-size: 20px;
       margin-bottom:10px;
   }
   
   .product-description #giftContent
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

 #pPrice {
            font-weight: bold;
        }

/* 레스토랑 리스트 섹션 코드 끝 */      
      
   
   

/* 검색조건 코드 */   
   /* low price */
   .lowPriceAsc
   {
      color:black;
      cursor:pointer;
   }
   
   .lowPriceAsc.active
   {
      color:red;
   }


    .search-container {
        display: flex;
       justify-content: space-between;
          align-items: baseline;
        margin-top: 20px;
        padding: 10px;
        padding-bottom : 0px;
        background-color: #f0f0f0;
        width:100%;
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

    .giftButtons button {
        padding: 5px 10px;
        border: none;
        border-radius: 3px;
        background-color:none;
        color: black;
        cursor: pointer;
      font-weight: normal; /* 초기 상태는 보통 폰트 무게로 설정 */
      font-size: 23px;
   }



.active 
{
   color: red; /* 활성화된 버튼은 볼드 폰트로 설정 */
}
 
    
    label, #dateInput
    {
       margin-bottom: 0 !important;
       margin-top: 0 !important;
    }
    
  
/* 검색조건 */

    .giftCateGory {
        margin-bottom: 20px; /* 원하는 간격을 픽셀 단위로 설정하세요. */
    }

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
      
#box
{
    display: flex;
    align-items: center;
}

.product-card:hover {
    background-color: lightgoldenrodyellow;
}

   div#cbb { 
    width: 100%;
    margin-bottom:30px;
}

</style>

 
<script type="text/javascript">


$(document).ready(function() 
{
   

     //조회 버튼 눌렀을때 .. 낮높가격,최신순은 별개로 들어감.
   $("#btnSearch").on("click", function() { 
       document.bbsForm.productSeq.value = "";
       document.bbsForm.searchType.value=$("#_searchType").val();
       document.bbsForm.searchValue.value=$("#_searchValue").val();
       document.bbsForm.curPage.value = "1";
       document.bbsForm.action = "/gift/giftList";
       document.bbsForm.submit();
       
   });
   

   //초기화 버튼 눌렀을시 검색조건 없애고 리로드
   $("#btnRefresh").on("click", function() {  
       document.bbsForm.productSeq.value = "";
       document.bbsForm.searchType.value = "";
       document.bbsForm.searchValue.value = "";
       document.bbsForm.curPage.value = "1";
       document.bbsForm.action = "/gift/giftList";
       document.bbsForm.submit();
   });
   

   
});

function searchGubun(gubunVal)
{
   var gubun = "";
   
   if(gubunVal == 'all')
   {
      gubun = "all";
   }
   else if(gubunVal == 'beauty')
   {
      gubun = '뷰티';
   }
   else if(gubunVal == 'health')
   {
      gubun = '식품';
   }
   else if(gubunVal == 'acc')
   {
      gubun = '악세서리';
   }
   else if(gubunVal == 'fashion')
   {
      gubun = '패션';
   }
   else if(gubunVal == 'eletronics')
   {
      gubun = '가전';
   }
   else if(gubunVal == 'flower')
   {
      gubun = '꽃';
   }
   
   
   document.bbsForm.productType.value = gubun;
   document.bbsForm.productSeq.value = "";
   document.bbsForm.searchType.value=$("#_searchType").val();
   document.bbsForm.searchValue.value=$("#_searchValue").val();
   document.bbsForm.curPage.value = "1";
   document.bbsForm.action = "/gift/giftList";

   document.bbsForm.submit();
}

function searchOrderBy(orderGubun)
{
   document.bbsForm.orderBy.value = orderGubun;
   document.bbsForm.productSeq.value = "";
    document.bbsForm.searchType.value=$("#_searchType").val();
    document.bbsForm.searchValue.value=$("#_searchValue").val();
    document.bbsForm.curPage.value = "1";
    document.bbsForm.action = "/gift/giftList";

   document.bbsForm.submit();
      
}

function fn_view(productSeq)
{
   document.bbsForm.productSeq.value = productSeq;
   document.bbsForm.action = "/gift/giftView";
   document.bbsForm.submit();
}

function fn_list(curPage) {
    // 페이지 버튼을 클릭한 경우, 새로운 페이지로 업데이트하고 서버에 요청을 보냅니다.
 document.bbsForm.productSeq.value = "";
   document.bbsForm.curPage.value = curPage;
   document.bbsForm.action = "/gift/giftList";
   document.bbsForm.submit();

}


</script>


  </head>
<body>
<%@ include file="/WEB-INF/views/include/navigation.jsp" %>

   <div class="header"></div>

    <h3> Gift ― FOR ANNIVERSARY </h3>




 <main class="main-container">
 
     <!-- 선물 리스트 -->
   <section class="products">
        
        
   <!-- 검색 조건 -->
    <div class="search-container">
   <div class="giftButtons">
  <div class="giftCateGory">
    <a id="giftCateGory" style="font-weight:bold; font-size:23px;">[카테고리] </a>
    <button id="all" onClick="searchGubun('all')" type="button"  class="button1" <c:if test="${productType eq 'all'}">style='color: #ffa300;'</c:if>>전체</button>
    <button id="beauty" onClick="searchGubun('beauty')" type="button" class="button1" <c:if test="${productType eq '뷰티'}">style='color: #ffa300;'</c:if>>뷰티</button>
    <button id="acc" onClick="searchGubun('acc')" type="button" class="button1" <c:if test="${productType eq '악세서리'}">style='color: #ffa300;'</c:if>>악세서리</button>
    <button id="fashion" onClick="searchGubun('fashion')" type="button" class="button1" <c:if test="${productType eq '패션'}">style='color: #ffa300;'</c:if>>패션</button>
    <button id="eletronics" onClick="searchGubun('eletronics')" type="button" class="button1" <c:if test="${productType eq '가전'}">style='color: #ffa300;'</c:if>>가전</button>
    <button id="health" onClick="searchGubun('health')" type="button" class="button1" <c:if test="${productType eq '식품'}">style='color: #ffa300;'</c:if>>식품</button>
    <button id="flower" onClick="searchGubun('flower')" type="button" class="button1" <c:if test="${productType eq '꽃'}">style='color: #ffa300;'</c:if>>꽃</button>
  </div>
  <div class="giftOrDer">
    <a id="giftOrder" style="font-weight:bold; font-size:23px;">[정 　렬] </a>
    <button id="giftRecent" onClick="searchOrderBy('regDesc')" type="button" class="button1" <c:if test="${orderBy eq 'regDesc'}">style='color: #ffa300;'</c:if>>최신순</button>
    <button id="giftAsc" onClick="searchOrderBy('regAsc')" class="button1" <c:if test="${orderBy eq 'regAsc'}">style='color: #ffa300;'</c:if>>등록순</button>
    <button id="highPriceDesc" onClick="searchOrderBy('priceDesc')" type="button" class="button1" <c:if test="${orderBy eq 'priceDesc'}">style='color: #ffa300;'</c:if>>높은가격순</button>
    <button id="lowPriceAsc" onClick="searchOrderBy('priceAsc')" type="button" class="button1" <c:if test="${orderBy eq 'priceAsc'}">style='color: #ffa300;'</c:if>>낮은가격순</button>
  </div>
</div>
<div id="box">
<div class="row">
  <div class="col-md-4" style="padding-right:0px !important;">
    <select name="_searchType" id="_searchType" class="custom-select">
      <option value="">조회 항목</option>
      <option value="1" <c:if test='${searchType eq "1"}'>selected</c:if>>제목</option>
      <option value="2" <c:if test='${searchType eq "2"}'>selected</c:if>>내용</option>
    </select>
  </div>
  <div class="col-md-8" style="padding-left:0px !important;">
    <input type="text" name="_searchValue" id="_searchValue" value="${searchValue}" class="form-control" maxlength="20" placeholder="조회값을 입력하세요." />
  </div>
</div>
   
   <div class="btnSearchRefresh">
        <button id="btnSearch" style="background-color:black; color:white; margin-left:5px; margin-right:-12px; width:50px; height:35px; border-radius:5px;" >조회</button>
        <button id="btnRefresh" style="background-color:gray; color:white; margin-left:10px; width:50px; height:35px; border-radius:5px;">초기화</button>
   </div>
</div>
   </div> 
    <!-- 검색 조건 끝 -->
<div class="card-container">
  <c:if test="${!empty list}">
    <c:forEach var="giftAdd" items="${list}" varStatus="status">
      <a href="javascript:void(0)" style="text-decoration:none;" onclick="fn_view('${giftAdd.productSeq}')">
      <div class="product-card">
        <!-- 카드 내용을 여기에 넣으세요 -->
        <div class="product-image">
          <img src="/resources/upload/${giftAdd.fileName}" alt="NO IMAGE" />
        </div>
        
        
<%
  // 현재 날짜를 얻습니다.
  Date currentDate = new Date();
  SimpleDateFormat sdf = new SimpleDateFormat("yyyy.MM.dd HH:mm:ss");
  String currentDateString = sdf.format(currentDate);
%>

<c:set var="currentDate" value="<%= currentDateString %>" />
<c:set var="registrationDateString" value="${giftAdd.regDate}" />

<c:set var="datePattern" value="yyyy.MM.dd HH:mm:ss" />

<%
  try {
    Date parsedCurrentDate = sdf.parse((String)pageContext.getAttribute("currentDate"));
    Date parsedRegistrationDate = sdf.parse((String)pageContext.getAttribute("registrationDateString"));
    long twoDaysAgo = parsedCurrentDate.getTime() - (2 * 24 * 60 * 60 * 1000);

    pageContext.setAttribute("parsedCurrentDate", parsedCurrentDate);
    pageContext.setAttribute("parsedRegistrationDate", parsedRegistrationDate);
    pageContext.setAttribute("twoDaysAgo", twoDaysAgo);
  } catch (Exception e) {
    e.printStackTrace();
  }
%>
        
        <c:choose>
            <c:when test="${parsedRegistrationDate.time <= twoDaysAgo}">
                <div id="new">
                </div>
            </c:when>
            <c:otherwise>
                <div id="new">
                <img src="/resources/images/new2.png"  style="width:45px;">
                </div>
            </c:otherwise>
        </c:choose>
          
        <div class="product-description" style="text-align:center;">
          <p style="color:gray;">[${giftAdd.productSeq}]</p>
          <h1 style="font-size: 20px; color:black; margin-bottom:10px;">${giftAdd.pName}</h1>
          <div style="text-align:center;">
            <span id="pPrice" style="font-size:20px; color:black; "><fmt:formatNumber type="number" maxFractionDigits="3" value="${giftAdd.pPrice}" />원</span>
          </div>
          <div id="star">
          
          <c:set var="starCount" value="${giftAdd.reviewScore}" />
   
           <c:choose>
              <c:when test="${starCount eq 0}"> <!-- 별점이 0일 경우 (아직 리뷰가 없을때) -->
                   <img src="/resources/images/emptyStar.png" style="width:25px; height:25px; border:none !important;" alt="Empty Star">
                   <img src="/resources/images/emptyStar.png" style="width:25px; height:25px; border:none !important;" alt="Empty Star">
                   <img src="/resources/images/emptyStar.png" style="width:25px; height:25px; border:none !important;" alt="Empty Star">
                   <img src="/resources/images/emptyStar.png" style="width:25px; height:25px; border:none !important;" alt="Empty Star">
                   <img src="/resources/images/emptyStar.png" style="width:25px; height:25px; border:none !important;" alt="Empty Star">
                   (${giftAdd.reviewCount}건)
               </c:when>
           
               <c:when test="${(starCount % 2) eq 0}"> <!-- 별점이 짝수일 경우 (꽉찬별만 있을때) -->
                  <c:forEach var="i" begin="1" end="${starCount / 2}">
                   <img src="/resources/images/fullStar.png" style="width:25px; height:25px; border:none !important;" alt="Full Star">
                   </c:forEach>
                   <c:forEach var="i" begin="1" end="${5 - (starCount / 2)}">
                   <img src="/resources/images/emptyStar.png" style="width:25px; height:25px; border:none !important;" alt="Empty Star">
                   </c:forEach>
                   (${giftAdd.reviewCount}건)
               </c:when>
                
               <c:when test="${(starCount % 2) eq 1}">
                  <c:forEach var="i" begin="1" end="${starCount / 2}"> <!-- 별점이 홀수일 경우 (반개별 필요) -->
                   <img src="/resources/images/fullStar.png" style="width:25px; height:25px; border:none !important;" alt="Full Star">
                   </c:forEach>
                   <img src="/resources/images/halfStar.png" style="width:25px; height:25px; border:none !important;" alt="Half Star">
                   <c:forEach var="i" begin="1" end="${5 - (starCount / 2)}">
                   <img src="/resources/images/emptyStar.png" style="width:25px; height:25px; border:none !important;" alt="Empty Star">
                   </c:forEach>
                   (${giftAdd.reviewCount}건)
               </c:when>
           </c:choose>
            
            
          </div>
        </div>
      </div>
      </a>
    </c:forEach>
  </c:if>
</div>


<c:if test="${empty list}">   
<div class="productNo">
           
         <div id="cbb">
             <span id="click" style="display:grid;">찾으시는 제품이 없습니다. <br> 조건을 변경하여 다시 검색해 주세요.</span>
          </div>
   </div>
</c:if>      
 
   </section>
      <!--  선물 리스트 끝-->  
      
      
   <c:if test="${not empty paging}">
    <nav style="margin-top:20px;">
        <ul class="pagination justify-content-center">
            <c:if test="${paging.prevBlockPage gt 0}">
                <li class="page-item"><a class="page-link" href="javascript:void(0)" onclick="fn_list(${paging.prevBlockPage}, 'lowPriceAsc')">이전블럭</a></li>
            </c:if>
            
            <c:forEach var="i" begin="${paging.startPage}" end="${paging.endPage}">
                <c:choose>
                    <c:when test="${i ne curPage}">
                        <li class="page-item"><a class="page-link" href="javascript:void(0)" onclick="fn_list(${i})">${i}</a></li>
                    </c:when>
                    <c:otherwise>
                        <li class="page-item active"><a class="page-link" href="javascript:void(0)" style="cursor:default;">${i}</a></li>
                    </c:otherwise>
                </c:choose>
            </c:forEach>
            
            <c:if test="${paging.nextBlockPage gt 0}">
                <li class="page-item"><a class="page-link" href="javascript:void(0)" onclick="fn_list(${paging.nextBlockPage})">다음블럭</a></li>
            </c:if>
        </ul>
    </nav>
</c:if>

       <form name="bbsForm" id="bbsForm" method="post">
         <input type="hidden" name="productSeq" value="" />
         <input type="hidden" name="searchType" value="${searchType}" />
         <input type="hidden" name="searchValue" value="${searchValue}" />
         <input type="hidden" name="curPage" value="${curPage}" />
         <input type="hidden" name="orderBy" value="${orderBy}" />
         <input type="hidden" name="productType" value="${productType}" />       
        </form>
 
</main>

<footer style="background-color: black; color: lightgray; text-align: center; margin-top:80px; padding: 40px;">
 <a style="font-size:20px; letter-spacing:5px;">《 Dayiary 》 </a> <br>
    &copy; Copyright Dayiary Corp. All Rights Reserved. <br>
    Always with you 🎉 여러분의 일상을 함께합니다.
</footer> 
   
</body>
</html>