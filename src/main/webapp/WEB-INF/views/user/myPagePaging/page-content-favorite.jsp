<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<html>
<head>

 <link rel="stylesheet" href="/resources/css/myPagestyle.css">
<style type="text/css">
.favoriteMainContainer
{
   width: 100%;
   height: 820px;
   padding: 10px;
}

.favoriteItemsContainer
{
   width: 100%;
   height: 100%;
   padding: 10px;
   overflow: scroll;
}

.favoriteItemontainer
{
   width: 100%;
   height: 400px;
   padding: 10px;
   
   display: flex; /* Flexbox 레이아웃을 사용하여 아이템 정렬 */   
   border-radius: 10px; /* 박스 모서리 둥글게 만들기 */
   border: 1px solid;
   margin-bottom: 10px;
   justify-content: space-between;
}

.favoriteItemImgBox
{
   width: 380px;
   height: 380px;
}

.favoriteItemImg
{
   
    width: 100%;
   height: 100%;
    border-radius: 10px; /* .itemBox의 모서리를 둥글게 설정 */
    overflow: hidden; /* 내용이 모서리를 넘어가지 않도록 함 */
}

.favoriteItemText
{
   width: 580px;
   padding: 30px;
   
}

.texts 
{
    margin: 0; /* 마진을 제거 */
    padding: 0; /* 패딩을 제거 */
}

.impact
{
   font-size: 18px;
    font-weight: bold;
}

.listType input[type="radio"] + span 
{
    border: 1px solid #dadada;
    padding: 15px;
    width: 100%;
    display: flex;
    border-radius: 10px; /* .itemBox의 모서리를 둥글게 설정 */
}

.listType input[type="radio"] {
    display: none;
    border-radius: 10px; /* .itemBox의 모서리를 둥글게 설정 */
}

.listType input[type="radio"] + span {
    display: inline-block;
    border: 1px solid #dfdfdf;
    background-color: #ffffff;
    text-align: center;
    cursor: pointer;
    border-radius: 10px; /* .itemBox의 모서리를 둥글게 설정 */
}

.listType input[type="radio"]:checked + span 
{
    background-color: #9dafeb;
    color: #ffffff;
    border-radius: 10px; /* .itemBox의 모서리를 둥글게 설정 */
}

.field.listType div label 
{
    flex-basis: 50%;
    border-radius: 10px; /* .itemBox의 모서리를 둥글게 설정 */
}

.field.listType div input[type="radio"]
{
    flex-basis: 50%;
    border-radius: 10px; /* .itemBox의 모서리를 둥글게 설정 */
}

.field.listType div
{
    border: 1px solid #dadada;
    padding-left : 5px;
    padding-right : 5px; 
    padding-top: 8px;     
    width: 95%;
    height: auto;
    margin: auto;
    background-color: #fff;
    display: flex;
    flex-direction: row;
    border-radius: 10px; /* .itemBox의 모서리를 둥글게 설정 */
}

.item span {
   font-size: 15px;
}

.left-content {
    width: 229px;

}

.right-bar {
  width: 320px;
  border-left: 1px solid #e3e7f7;
  display: flex;
  flex-direction: column;
}
.page-content {
  width : 987px;
  display: flex;
  flex-direction: column;
  flex: 1;
  padding: 40px 20px 0 20px;
}

</style>
<script type="text/javascript">
function fn_movePage(Seq, type)
{
   if(type == 0)
   {
      window.location.href = "/resto/restoView?rSeq=" + Seq;
   }
   else if(type == 1)
   {
      window.location.href = "/gift/giftView?productSeq=" + Seq;
   }
   else
   {
      return;   
   }
}

function fn_checkFavoriteList(type)
{
   if(type == 0)
   {
      fn_getFavoriteList("/resto/restoFavoriteList", type);
   }
   else if(type == 1)
   {
      fn_getFavoriteList("/gift/giftFavoriteList", type);   
   }
   else
   {
      return;   
   }
}

function fn_getFavoriteList(url, type)
{
   let favoriteItemsContainer = $(".favoriteItemsContainer");
   
   $.ajax
    ({
        type: "POST",
        url: url,
        success: function(response)
        {
           if(response.code == 0)
           {
              favoriteItemsContainer.html("");
              let json = response.data;
              let makeTag = "";
              let show = "";
              if(json.length > 0)
              {
                 if(type == 0)
                 {
                    let data;
                    for(let i = 0; i < json.length; i ++)
                    {
                       data = json[i];
                       makeTag =
                             "<div class='favoriteItemontainer' onclick=\"fn_movePage('" + data.rSeq + "', 0)\"><div class='favoriteItemImgBox'>" +
                             "<img class='favoriteItemImg' src='/resources/upload/" + data.fileName + "'></div><div class='favoriteItemText'>" +
                             "<p class='texts impact' style='margin-top: 55px; margin-bottom: 5px;''>가게명 : " + data.restoName + "</p><p class='texts impact' " +
                             "style='margin-bottom: 5px;'>주소 : " + data.restoAddress + "</p><p class='texts impact' style='margin-bottom: 5px;'>매장 전화번호 : " +
                             data.restoPh + "</p>";
                             
                       if(data.restoOff == "")
                       {
                          makeTag += "<p class='texts impact' style='margin-bottom: 5px;'>휴무일 : 연중무휴</p>";
                       }
                       else
                       {
                          makeTag += "<p class='texts impact' style='margin-bottom: 5px;'>휴무일 : " + data.restoOff + "</p>";
                          
                       }
                       
                       makeTag += 
                             "<p class='texts impact' style='margin-bottom: 5px;''>오픈시간 : " + data.restoOpen + "</p><p class='texts impact' " +
                             "style='margin-bottom: 5px;'>마감시간 : " + data.restoClose + "</p></div></div>";
                             
                       show += makeTag;
                       makeTag = "";
                       
                    }
                    favoriteItemsContainer.html(show);
                 }
                 else if(type == 1)
                 {
                    let data;
                    for(let i = 0; i < json.length; i ++)
                    {
                       data = json[i];
                       
                       makeTag =
                         "<div class='favoriteItemontainer' onclick=\"fn_movePage('" + data.productSeq + "', 1)\"><div class='favoriteItemImgBox'>" +
                         "<img class='favoriteItemImg' src='/resources/upload/" + data.fileName + "'></div><div class='favoriteItemText'>" +
                         "<p class='texts impact' style='margin-top: 85px; margin-bottom: 5px;'>상품명 : " + data.pName + "</p><p class='texts impact' " +
                         "style='margin-bottom: 5px;'>가격 : " + data.pPrice.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',') + "원</p><p class='texts impact' style='margin-bottom: 5px;'>설명 : " + data.pContent + "</p></div></div>";
                       
                       show += makeTag;
                       makeTag = "";
                    }
                    favoriteItemsContainer.html(show);
                 }
                 else
                  {
                     return;
                  }   
              }
              else
              {
                 return;
              }
           }
           else
           {
              return;   
           }
        },
        error: function(xhr, status, error) 
        {
            console.log(error);
        }
    });  
}


</script>
</head>
<body>
<div class="favoriteMainContainer">
   <div class="field listType" style="width: 100%;">            
          <div>
             <label class="listType">
                <input type="radio" name="listType" value="0"  onclick="fn_checkFavoriteList(0)" checked>
                <span><b>레스토랑</b></span>
            </label>
            &nbsp;
            <label class="listType">
                <input type="radio" name="listType" value="1" onclick="fn_checkFavoriteList(1)">
                <span><b>선물</b></span>
            </label>
        </div>
    </div> 
   <div class="favoriteItemsContainer">
      <c:if test="${!empty list}">
         <c:forEach var="resto" items="${list}" varStatus="status">
            <div class="favoriteItemontainer" onclick="fn_movePage('${resto.rSeq}', 0)">
               <div class="favoriteItemImgBox">
                  <img class="favoriteItemImg" src="/resources/upload/${resto.fileName}">
               </div>
               <div class="favoriteItemText">
                  <p class="texts impact" style="margin-top: 55px; margin-bottom: 5px;">가게명 : ${resto.restoName}</p>
                  <p class="texts impact" style="margin-bottom: 5px;">주소 : ${resto.restoAddress}</p>
                  <p class="texts impact" style="margin-bottom: 5px;">매장 전화번호 : ${resto.restoPh}</p>
                  <c:choose>
                     <c:when test="${resto.restoOff eq ''}">
                        <p class="texts impact" style="margin-bottom: 5px;">휴무일 : 연중무휴</p>
                     </c:when>
                     <c:otherwise>
                        <p class="texts impact" style="margin-bottom: 5px;">휴무일 : ${resto.restoOff}</p>
                     </c:otherwise>
                  </c:choose>
                  <p class="texts impact" style="margin-bottom: 5px;">오픈시간 : ${resto.restoOpen}</p>
                  <p class="texts impact" style="margin-bottom: 5px;">마감시간 : ${resto.restoClose}</p>
               </div>
            </div>
         </c:forEach>
      </c:if>
   </div>
</div>
</body>
</html>