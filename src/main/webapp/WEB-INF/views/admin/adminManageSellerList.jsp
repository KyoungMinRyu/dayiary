<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<%
   // GNB 번호 (사용자관리)
   request.setAttribute("_gnbNo", 1);
%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/views/include/head.jsp" %>
<link type="text/css" href="/resources/css/jquery.colorbox.css" rel="stylesheet" />

<style>
@font-face {
    font-family: 'SUIT-Regular'; /* 고딕 */
    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_suit@1.0/SUIT-Regular.woff2') format('woff2');
    font-weight: 100;
    font-style: normal;
} 

body {
   
     background-color: #fffbf4 !important;
      flex-direction: column;
}
*, ::after, ::before {
   font-family: 'SUIT-Regular', sans-serif;
   box-sizing: unset;
}
 .table-hover th, td {
   border: 2px solid #c4c2c2;
   text-align: center;
}

.table td, .table th {
    padding: 0.75rem;
    vertical-align: top;
    border-top: 2px solid #c4c2c2 !IMPORTANT;
    border-bottom: 2px solid #c4c2c2 !IMPORTANT;
}

 #school_list {
 
     background-color: rgba(255, 255, 255, 0.7) !important;   /* 게시판 테두리 투명도 */
     border-radius: 10px;                            /* 게시판 테두리 라운드 */
     padding-top: 20px;                               /* 게시판 내부내용 상단에서 띄우기 */
     padding-bottom: 30px;
     padding-right: 20px;
     padding-left: 20px;
 
}


.GoUserList {
  border-radius: 10px;
  background-color: rgb(255, 255, 255, 1);
  color: #525252;
  font-weight: bold;
  font-size: 24px;
  cursor: pointer;
  transition: background-color 0.3s, color 0.3s;
}

.GoUserList:hover {   
  background-color: #c4c2c2;
  color: #fff;
}


</style>
<script type="text/javascript" src="/resources/js/jquery.colorbox.js"></script>
<script type="text/javascript">

$("document").ready(function(){
      
      $("a[name='adminManageSellerUpdate']").colorbox({
         iframe:true, 
         innerWidth:1235,
         innerHeight:550,
         scrolling:false,
         onComplete:function()
         {
            $("#colorbox").css("width", "1235px");
            $("#colorbox").css("height", "550");
            $("#colorbox").css("border-radius", "10px");
         }
      });
      
      $("#GoUserList").on("click", function() {
         location.href="/admin/adminManageUserList";          
      });
});

      
function fn_search()
{
   document.searchForm.curPage.value = "1";
   document.searchForm.action = "/admin/adminManageSellerList";
   document.searchForm.submit();
}

function fn_paging(curPage)
{
   document.searchForm.curPage.value = curPage;
   document.searchForm.action = "/admin/adminManageSellerList";
   document.searchForm.submit();
}

function fn_pageInit()      //검색타입, 검색값 초기화 함수
{
   $("#searchType option:eq(0)").prop("selected", true);
   $("#searchValue").val("");
   
   fn_search();      
}



</script>
</head>
<body>
<%@ include file="/WEB-INF/views/include/adminNavi.jsp" %>

       <div id="school_list" style="width:90%; margin:auto; margin-top:150px; border: 1px solid black;">
      <div class="mnb" style="display:flex; margin-bottom:0.8rem;">
    <h1 style="margin-right:auto; color: #525252;">회원관리</h1>  
         
         <form class="d-flex" name="searchForm" id="searchForm" method="post" style="place-content: flex-end; ">
            <select id="status" name="status" style="font-size: 1rem; width: 6rem; height: 40px;">
               <option value="">상태</option>
               <option value="Y" <c:if test="${status == 'Y'}"> selected </c:if>>정상</option>
               <option value="N" <c:if test="${status == 'N'}"> selected </c:if>>정지</option>
            </select>
            <select id="searchType" name="searchType" style="font-size: 1rem; width: 8rem; height: 40px; margin-left:.5rem; ">
               <option value="">검색타입</option>
               <option value="1" <c:if test="${searchType == '1' }"> selected</c:if>>판매자아이디</option>
               <option value="2" <c:if test="${searchType == '2' }"> selected</c:if>>판매자상호명</option>
            </select>
            <input name="searchValue" id="searchValue" class="form-control me-sm-2" style="width:15rem; margin-left:.5rem; height: 28px;" type="text" value="${searchValue}">
            <a class="btn my-2 my-sm-0" href="javascript:void(0)" onclick="fn_search()" style="width:7rem; margin-left:.5rem; height: 28px; background-color: rgb(239, 239, 239); border-color:rgb(118, 118, 118);">조회</a>
            <input type="hidden" name="curPage" value="${curPage}" />
         </form>
      </div>
      <div style="margin-right:auto; color: #525252; font-weight:bold; font-size:25px;">판매자 관리
      <button type="button" id="GoUserList" class="GoUserList" >유저 관리</button></div>
                                                                                
      <div class="school_list_excel">
         <table class="table table-hover" style="border:2px solid #c4c2c2; font-size:18px;">
            <thead style="border-bottom: 1px solid #c4c2c2;">
            <tr class="table-thead-main">
               <th scope="col" style="width:15%;">아이디</th>
               <th scope="col">상호명</th>
               <th scope="col">사업자번호</th>
               <th scope="col">상태</th>
               <th scope="col">가입일</th>
            </tr>
            </thead>
            <tbody>
           
         <c:if test="${!empty list}">
          <c:forEach items="${list}" var="seller" varStatus="status">
            <tr>
                <th scope="row" class="table-thead-sub" style="border: 1px solid #c4c2c2;"><a href="/admin/adminManageSellerUpdate?sellerId=${seller.sellerId}" name="adminManageSellerUpdate">${seller.sellerId}</a></th>             
                <td>${seller.sellerShopName}</td>
                <td>${seller.sellerBusinessId}</td>
                <td><c:if test="${seller.status == 'Y' }">정상</c:if><c:if test="${seller.status == 'N'}">정지</c:if></td>
                <td>${seller.regDate}</td>
            </tr>
            </c:forEach>
         </c:if>
       
         <c:if test="${empty list }">
               <tr>
                   <td colspan="5">등록된 판매자정보가 없습니다.</td>
             </tr>   
         </c:if>
            </tbody>   
         </table>
         <div class="paging-right" style="float:right; ">  
            <c:if test="${!empty paging}">
            <c:if test="${paging.prevBlockPage gt 0}">
                  <a href="javascript:void(0)"  class="btn2 btn-primary" onclick="fn_paging(${paging.prevBlockPage})" style= "font-size:25px; background-color: transparent !important; color:black; font-weight: bold;" title="이전 블럭">&laquo;</a>
                </c:if>                                                                                      <!-- &laquo;는 << 표시 -->
               <span> 
            <c:forEach var="i" begin="${paging.startPage}" end="${paging.endPage}">
               <c:choose>
                  <c:when test="${i ne curPage}">
                        <a href="javascript:void(0)" class="btn2 btn-primary" onclick="fn_paging(${i})" style="font-size:20px; background-color: transparent !important; color:black; font-weight: bold;">${i}</a>
                  </c:when>
                  <c:otherwise>
                        <h class="btn2 btn-primary" style="font-size:20px; background-color: transparent !important; color:black; font-weight: bold;">${i}</h>
                  </c:otherwise>
               </c:choose>
            </c:forEach>
               </span>     
               <c:if test="${paging.nextBlockPage gt 0}">
                  <a href="javascript:void(0)" class="btn2 btn-primary" onclick="fn_paging(${paging.nextBlockPage})" style= "font-size:25px; background-color: transparent !important; color:black; font-weight: bold;" title="다음 블럭">&raquo;</a>
            </c:if>      
         </c:if>
         </div>
      </div>
   </div>
  
</body>
</html>