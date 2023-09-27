<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/views/include/head.jsp" %>
<style>
@font-face {
    font-family: 'SUIT-Regular'; /* 고딕 */
    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_suit@1.0/SUIT-Regular.woff2') format('woff2');
    font-weight: 100;
    font-style: normal;
} 
html, body{
  color:  #525252;
  font-family: 'SUIT-Regular', sans-serif;
  font-size:18px;
}
table{
  width:100%;
  border: 1px solid #c4c2c2;
}
table th, td{
  border-right: 1px solid #c4c2c2;
  border-bottom: 1px solid #c4c2c2;
  height: 4rem;
  padding-left: .5rem;
  padding-right: 1rem;
}
table th{
  background-color: #e0e4fe;
}
input[type=text], input[type=password]{
  height:2rem;
  width: 100%;
  border-radius: .2rem;
  border: .2px solid rgb(204,204,204);
  background-color: rgb(246,246,246);
}
button{
  width: 5rem;
  margin-top: 1rem;
  border: .1rem solid rgb(204,204,204);
  border-radius: .2rem;
  box-shadow: 1px 1px #666;
}
button:active {
  background-color: rgb(186,186,186);
  box-shadow: 0 0 1px 1px #666;
  transform: translateY(1px);
}
</style>
<script type="text/javascript" src="/resources/js/colorBox.js"></script>
<script type="text/javascript">
$(document).ready(function() 
{
   $("#schName").focus();
   
   var contactElements = document.querySelectorAll('.contact-element');
   contactElements.forEach(function(element) {
       var contact = element.textContent.replace(/-/g, ''); // 기존 하이픈 제거
       if(contact.length === 11) { // 11자리 연락처인 경우
           var formattedContact = contact.replace(/(\d{3})(\d{4})(\d{4})/, '$1-$2-$3');
           element.textContent = formattedContact;
       }
   });
});

function fn_sellerUpdate()
{ 
   if(confirm("판매자정보를 수정하시겠습니까?"))   
   {   
         if(icia.common.isEmpty($("#sellerShopName").val()))
         {
            alert("상호명을 입력하세요.")
            $("#sellerShopName").val("");
            $("#sellerShopName").focus();
            return;
         }
         
         fn_sellerUpdateSuccess();
   }   
}
function fn_sellerUpdateSuccess()
 { 
   
   var formData = {
         sellerId:$("#sellerId").val(),
         sellerBusinessId:$("#sellerBusinessId").val(),
         sellerEmail:$("#sellerEmail").val(),
         sellerPwd:$("#sellerPwd").val(),
         sellerShopName:$("#sellerShopName").val(),
         sellerPh:$("#sellerPh").val(),
         sellerAddress:$("#sellerAddress").val(),
         status:$("#status").val(),               
         regDate:$("#regDate").val()
   };
   
   
   icia.ajax.post({
      url:"/admin/adminManageSellerUpdateProc",
      data:formData,
      success:function(res)
      {
         if(res.code == 0)
         {
            alert("판매자정보가 수정 되었습니다.");
            fn_colorbox_close(parent.fn_pageInit);      
         }                                 
         else if(res.code == -1)
         {
            alert("판매자정보 수정 중 오류가 발생하였습니다.");
         }
         else if(res.code == 400)
         {
            alert("입력 값이 잘못 되었습니다.");
         }
         else if(res.code == 404)
         {
            alert("판매자정보가 존재하지 않습니다.");
            fn_colorbox_close();
         }
      },
      complete:function(data)
      {
         icia.common.log(data);
      },
      error:function(xhr, status, error)
      {
         icia.common.error(error);
      }
   });
   
 }




</script>
</head>
<body>
<div class="layerpopup" style="width:1123px; margin:auto; margin-top:-2%;">
   <h1 style="font-size: 1.6rem; margin-top: 3rem; margin-bottom: 1.6rem; padding: .5rem 0 .5rem 1rem; background-color: #e0e4fe;">판매자정보 수정</h1>
   <div class="layer-cont">
      <form name="regForm" id="regForm" method="post">
         <table>
            <tbody>
               <tr>
                  <th scope="row">아이디</th>
                  <td>
                     ${seller.sellerId}
                     <input type="hidden" id="sellerId" name="sellerId" value=" ${seller.sellerId}" />
                  </td>
                  <th scope="row">비밀번호</th>
                  <td>
                      ${seller.sellerPwd}   
                     <input type="hidden" id="sellerPwd" name="sellerPwd" value="${seller.sellerPwd}" />
                  </td>
               </tr>
               <tr>
                  <th scope="row" >전화번호</th>
                  <td>
                     <a class="contact-element">${seller.sellerPh}</a>
                     <input type="hidden" id="sellerPh" name="sellerPh" value="${seller.sellerPh}" />
                  </td>
                  <th scope="row">주소</th>
                  <td>
                     ${seller.sellerAddress}
                      <input type="hidden" id="sellerAddress" name="sellerAddress" value="${seller.sellerAddress}" />
                  </td>
               </tr>
               <tr>
                  <th scope="row">상호명</th>
                  <td>
                     <input type="text" id="sellerShopName" name="sellerShopName" value="${seller.sellerShopName}" style="font-size:1rem;;" maxlength="50" placeholder="상호명" />
                  </td>
                  <th scope="row">사업자번호</th>
                  <td>
                  ${seller.sellerBusinessId}
                     <input type="hidden" id="sellerBusinessId" name="sellerBusinessId" value="${seller.sellerBusinessId}" />
                  </td>
               </tr>
               <tr>
                    <th scope="row">판매자 이메일</th>
                  <td>
                  ${seller.sellerEmail}
                     <input type="hidden" id="sellerEmail" name="sellerEmail" value="${seller.sellerEmail}" />
                  </td>
                  <th scope="row">상태</th>
                  <td>
                     <select id="status" name="status" style="font-size: 1rem; width: 7rem; height: 2rem;">
                        <option value="Y" <c:if test="${seller.status == 'Y'}">selected</c:if>>정상</option>   
                        <option value="N" <c:if test="${seller.status == 'N'}">selected</c:if>>정지</option>
                     </select>
                  </td>
               </tr>
               <tr>
                    <th scope="row">가입일</th>
                  <td>
                  ${seller.regDate}
                  <input type="hidden" id="regDate" name="regDate" value="${seller.regDate}" />
                  </td>
               </tr>

            </tbody>
         </table>
      </form>
      <div class="pop-btn-area" style="float: right;">
         <button onclick="fn_sellerUpdate()" class="btn-type01"><span>수정</span></button>
         <button onclick="fn_colorbox_close()" id="colorboxClose" class="btn-type01" style="margin-left: 1rem;"><span>닫기</span></button>
      </div>
   </div>
</div>
</body>
</html>