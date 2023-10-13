<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<html>
<head>
<%@ include file="/WEB-INF/views/include/head.jsp"%>
<meta name="viewport"
	content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/normalize/5.0.0/normalize.min.css">

<script
	src='https://cdnjs.cloudflare.com/ajax/libs/smooth-scrollbar/8.3.1/smooth-scrollbar.js'></script>
<script
	src='https://cdnjs.cloudflare.com/ajax/libs/smooth-scrollbar/8.3.1/plugins/overscroll.js'></script>
<link rel="stylesheet" href="/resources/css/myPagestyle.css">
<link rel="stylesheet" href="/resources/css/cardstyle.css">



<style>
html, body {
   overflow: hidden; /* 스크롤 비활성화 */
   height: 100%; /* 화면 전체 높이로 설정 */
   background-color: #565656;
}

.listContainer {
   width: 100%;
   height: 100%;
   margin-top: 100px;
   margin-left: auto;
   margin-right: auto;
   border: none;
   display: none;
}

.giftlistContainer {
   width: 100%;
   height: 100%;
   margin-top: 100px;
   margin-left: auto;
   margin-right: auto;
   border: none;
   display: none;
}

.listType input[type="radio"]+span {
   border: 1px solid #dadada;
   padding: 15px;
   width: 100%;
   display: flex;
   border-radius: 10px; /* .itemBox의 모서리를 둥글게 설정 */
   font-size: 18px;
}

.listType input[type="radio"] {
   display: none;
   border-radius: 10px; /* .itemBox의 모서리를 둥글게 설정 */
}

.listType input[type="radio"]+span {
   display: inline-block;
   border: 1px solid #dfdfdf;
   background-color: #ffffff;
   text-align: center;
   cursor: pointer;
   border-radius: 10px; /* .itemBox의 모서리를 둥글게 설정 */
}

.listType input[type="radio"]:checked+span {
   background-color: #9dafeb;
   color: #ffffff;
   border-radius: 10px; /* .itemBox의 모서리를 둥글게 설정 */
}

.field.listType div label {
   flex-basis: 50%;
   border-radius: 10px; /* .itemBox의 모서리를 둥글게 설정 */
}

.field.listType div input[type="radio"] {
   flex-basis: 50%;
   border-radius: 10px; /* .itemBox의 모서리를 둥글게 설정 */
}

.field.listType div {
   border: 1px solid #dadada;
   padding-left: 5px;
   padding-right: 5px;
   padding-top: 8px;
   width: 95%;
   height: auto;
   margin: auto;
   background-color: #fff;
   display: flex;
   flex-direction: row;
   border-radius: 10px; /* .itemBox의 모서리를 둥글게 설정 */
}

.itemContainer {
   padding: 10px;
   width: 100%;
   height: 805px;
}

.listItems {
   padding: 10px;
   width: 100%;
   height: 100%;
   overflow: auto;
}

::-webkit-scrollbar {
   width: 10px; /* 스크롤바의 너비를 조정하세요. */
}

/* 스크롤바의 슬라이더(Thumb) 디자인 */
::-webkit-scrollbar-thumb {
   background-color: #333; /* 스크롤바의 배경색을 지정하세요. */
   border-radius: 5px; /* 스크롤바의 모서리를 둥글게 만듭니다. */
}

.listItem {
   border-radius: 10px; /* 박스 모서리 둥글게 만들기 */
   border: 1px solid;
   padding: 10px;
   width: 100%;
   height: 280px;
   display: flex; /* Flexbox 레이아웃을 사용하여 아이템 정렬 */
   margin-bottom: 10px;
   background-color: #fff;
}

.listItem2 {
   border-radius: 10px; /* 박스 모서리 둥글게 만들기 */
   border: 1px solid;
   padding: 10px;
   width: 100%;
   height: 250px;
   display: flex; /* Flexbox 레이아웃을 사용하여 아이템 정렬 */
   margin-bottom: 10px;
   background-color: #fff;
}
.itemBox {
   height: 100%;
   width: 228.67px;
   border-radius: 10px; /* .itemBox의 모서리를 둥글게 설정 */
   overflow: hidden; /* 내용이 모서리를 넘어가지 않도록 함 */
}

.itemImg {
   display: block;
   width: 100%;
   height: 100%;
   object-fit: cover;
}

.itemText {
   width: 100%;
   padding: 15px;
}

.texts {
   margin: 0; /* 마진을 제거 */
   padding: 0; /* 패딩을 제거 */
   font-family: "원하는 폰트", sans-serif; /* 원하는 폰트 이름으로 변경 */
}

.atext {
   color: #65FF5E;
}

.impact {
   font-size: 18px;
   font-weight: bold;
}

.itemBtn {
   width: 40%;
   height: 40px;
   border-radius: 10px; /* .itemBox의 모서리를 둥글게 설정 */
   border: none;
   background-color: #000000;
   font-size: 20px;
   color: #ffffff;
   float: right;
}

.textBox .btnBox {
   width: 100%;
   display: flex;
   flex-wrap: nowrap; /* 이 부분을 추가하여 줄 바꿈을 막습니다. */
   overflow: hidden; /* 필요한 경우 텍스트가 넘칠 때 가릴 수 있도록 오버플로우를 숨깁니다. */
   white-space: nowrap; /* 텍스트가 줄 바꿈 되지 않도록 합니다. */
}

.searchBox {
   width: 100%;
   display: flex;
}

.selectBox {
   padding: 10px;
   width: 100%;
   height: 76px;
   display: flex;
}

#_searchType {
   width: auto; /* 필요한 만큼의 너비를 가집니다. */
   height: 100%;
   border-radius: 10px; /* 테두리를 둥글게 만듭니다. */
   margin-right: 10px; /* 선택 상자 사이의 간격을 조정합니다. */
}

#_searchType1 {
   width: auto; /* 필요한 만큼의 너비를 가집니다. */
   height: 100%;
   border-radius: 10px; /* 테두리를 둥글게 만듭니다. */
   margin-right: 10px; /* 선택 상자 사이의 간격을 조정합니다. */
}
/* 검색 입력란(input) 스타일 수정 */
#_searchValue {
   width: auto; /* 고정된 너비를 가집니다. */
   height: 100%;
   border-radius: 10px; /* 테두리를 둥글게 만듭니다. */
   margin-right: 10px; /* 입력란과 검색 버튼 사이의 간격을 조정합니다. */
}

#_searchValue1 {
   width: auto; /* 고정된 너비를 가집니다. */
   height: 100%;
   border-radius: 10px; /* 테두리를 둥글게 만듭니다. */
   margin-right: 10px; /* 입력란과 검색 버튼 사이의 간격을 조정합니다. */
}

h2 {
   font-family: 'SUIT-Regular', sans-serif;
}

p {
   font-family: 'SUIT-Regular', sans-serif;
}

.item span {
   font-size: 15px;
}

.task-box-profile {
   position: relative;
   border-radius: 12px;
   width: 50%;
   margin: 20px 0;
   padding: 16px;
   cursor: pointer;
   box-shadow: 2px 2px 4px 0px #ebebeb;
}

h2 {
   font-family: 'SUIT-Regular', sans-serif;
}

p {
   font-family: 'SUIT-Regular', sans-serif
}

.item span {
   font-size: 15px;
}

.task-box-profile {
   position: relative;
   border-radius: 12px;
   width: 50%;
   margin: 20px 0;
   padding: 16px;
   cursor: pointer;
   box-shadow: 2px 2px 4px 0px #ebebeb;
}

.contain {
   display: flex;
   width: 100%;
   height: 700px;
}

.card-myId {
   margin: auto;
   overflow-y: auto;
   position: relative;
   background-color: white;
   transition: 0.3s;
   flex-direction: column;
   border-radius: 10px;
   box-shadow: 0 0 0 8px rgba(255, 255, 255, 0.2);
   height: 700px;
   margin-top: 20px;
   width: 100%;
   height: 100%;
}

.card-header {
   background-image: url('/resources/images/revenue.png');
   object-fit: cover;
   width: 100%;
   height: 380px;
   background-repeat: no-repeat;
}

.left-content {
   padding: 40px;
   margin-top: 0px;
   width: 250px; /* 넓이를 조절할 값 */
   height: 100%;
   display: flex;
   flex-direction: column;
}

<!-- 판매자 메인페이지 나란히 -->
.seller-main-page {
    display: flex;
    align-items: center; /* 수직 정렬 */
}

.seller-main-page h6 {
    margin-right: 10px; /* 텍스트와 버튼 사이의 간격을 조절합니다. */
}

/***** CSS Magic to Highlight Stars on Hover *****/
.container {
   display: flex;
   align-items: center;
}

.container h3 {
   margin-right: 10px;
}

select {
   width: 150px;
   margin-right: 10px;
}

input[type="text"] {
   width: 200px;
}

.rating>input:checked ~ label, /* show gold star when clicked */ .rating:not(:checked)>label:hover,
   /* hover current star */ .rating:not(:checked)>label:hover ~ label {
   color: #FFD700;
} /* hover previous stars in list */
.rating>input:checked+label:hover,
   /* hover current star when changing rating */ .rating>input:checked ~
   label:hover, .rating>label:hover ~ input:checked ~ label,
   /* lighten current selection */ .rating>input:checked ~ label:hover ~
   label {
   color: #FFED85;
}

#buttonContainer {
   display: flex;
   margin-top: 10px;
}

#submitButton, #cancelButton {
   height: 50px;
   border: none;
   border-radius: 25px;
   padding: 10px 20px;
   cursor: pointer;
   box-shadow: 0px 4px 6px rgba(0, 0, 0, 0.1);
   font-weight: bold;
   font-size: 16px;
   flex: 1; /* 이 부분이 중요합니다. */
}

#submitButton {
   background-color: #3498db; /* 파란색 */
   color: white;
   margin-right: 5px; /* 오른쪽 마진 추가 */
}

#cancelButton {
   background-color: #e74c3c; /* 빨간색 */
   color: white;
}

</style>

<script
	src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript">

let searchType = "";
let searchValue = "";
let listType = "";
let totalCount = 0;
let startRow = 1;
let endRow = 10;
let deliveryCompany = "";
let orderNum="";
let orderSeq = "";
let selectedValue = "";

$(document).ready(function() 
{
    
   
	//운송장번호 입력 취소 
    $("#cancelButton").click(function() {
        $("#deliveryContainer").fadeOut();
        // deliveryNumber 초기화
        $("#deliveryNumber").val("");
        
        // 선택된 옵션 초기화 (0번째 옵션을 선택하도록 설정)
        $(".delivery select").val("0");
    
        // 나머지 변수 초기화 (필요에 따라서 초기화)
        orderNum = "";
        orderSeq = "";
    
    
    });

   //운송장번호 입력 시 ..
      $("#submitButton").click(function() 
      {
         if(orderSeq != "" && orderSeq != null)
         {
            selectedValue = document.querySelector('.delivery select').value;   
            let formData = 
                {
                  orderSeq: orderSeq,
                  deliverCompany: selectedValue,
                  orderNum: $("#deliveryNumber").val()
                };
            fn_deliveryNumProc(formData);
         }
         else
         {
            return;
         }
       });
      
   	$("#searchMyThings").click(function() 
	{
   		let startDate = $("#startDate").val();
   		let endDate = $("#endDate").val();
   		let listType = $("input[type=radio][name=listType]:checked").val();
   		let searchType = $("#_searchType").val();
   		if(listType == null || listType == "" || listType == "undefined")
   		{
   			alert("조회 할 항목을 선택해주세요.");
			return;
   		}
   		
   		if(startDate != null && startDate != "")
   		{
   			if(endDate == null || endDate == "")
   	   		{
   	   			alert("조회 끝 날짜를 선택해주세요.");
   	   			return;		
   	   		}
   		}
   		else if(endDate != null && endDate != "")
   		{
   			if(startDate == null || startDate == "")
   	   		{
   	   			alert("조회 시작 날짜를 선택해주세요.");
   	   			return;		
   	   		}
   		}
   		
   		let formData = 
   	    {
   			startDate: startDate.replaceAll("-", ""),
   			endDate: endDate.replaceAll("-", ""),
   			listType: listType,
   			searchType: searchType
	    };
   		
   		$.ajax
   	    ({
   	        type: "POST",
   	        url: "/seller/getPeriodRevenue",
   	        data: formData,
   	        success: function(response)
   	        {
   	        	if(response.code == 0)
   	        	{
   	        		let temp = "";
   	        		let makeTag = "";
   	        		let show = "";
   	        		let revenueContainer = $("#revenueContainer");
   	        		revenueContainer.html("");
   	        		let json = response.data;
   	        		let data = "";
   	        		let flag = 0;
   	        		let totalCount = 0;
   	        		let totalPrice = 0;
   	        		let orderTotalCount = 0;
   	        		console.log(json);
   	        		if(listType == 0)
   	        		{
   	        			for(let i = 0; i < json.length; i++)
   	   	        		{
   	   	        			data = json[i];	
   	   	        			if(flag == 1)
   	   	        			{
	   	   	        			if(temp === data.rSeq)
	   	   	        			{
	   	   	        				makeTag += "<h4>" + data.regDate.slice(0,4) + "년 " + data.regDate.slice(4) + "월" + " " + data.orderTotalCnt.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',') + "건 " + data.reservPerson.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',') + "명 " + data.totalPrice.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',') + "원</h4>";
		   	   	        			totalCount += data.reservPerson;
	   	        					totalPrice += data.totalPrice;
	   	        					orderTotalCount += Number(data.orderTotalCnt);
	   	   	        			}
	   	   	        			else
	   	   	        			{
	   	   	        				makeTag += "<h4>총매출액 : " + orderTotalCount.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',') + "건 " + totalCount.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',') + "명 " +  totalPrice.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',') + "원</h4>";
	   	   	        				makeTag += "</div></div>";
	   	   	        				show += makeTag;
	   	   	        				makeTag = "";
		   	   	        			totalCount = 0;
		   	   	        			totalPrice = 0;
		   	   	        			orderTotalCount = 0;
	   	   	        				flag = 0;
	   	   	        			}	
   	   	        			}
   	   	        			if(flag == 0)
							{
	   	   	        			makeTag = 
		   	        					"<div style='width:100%; height: auto; border: 1px solid black; border-radius: 10px; padding: 10px; margin-bottom: 20px;'><h3>" +
		   	        					 data.restoName + "</h3><div style='justify-content: center; text-align: center;'><h4>" +
		   	        					 data.regDate.slice(0,4) + "년 " + data.regDate.slice(4) + "월" + " " + data.orderTotalCnt.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',') + "건 " + data.reservPerson.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',') + "명 " + data.totalPrice.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',') + "원</h4>";	   	           			

			   	        		orderTotalCount += Number(data.orderTotalCnt);
   	        					totalCount += data.reservPerson;
   	        					totalPrice += data.totalPrice;
		   	        			flag = 1;
							}
   	   	        			temp = data.rSeq;   	   	        			
   	   	           		}
   	        			makeTag += "<h4>총매출액 : " + orderTotalCount.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',') + "건 " + totalCount.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',') + "명 " + totalPrice.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',') + "원</h4>";
  	        			makeTag += "</div></div>";
   	        			show += makeTag;
   	        			revenueContainer.html(show);
   	        		}
   	        		else if(listType == 1)
   	        		{
   	        			for(let i = 0; i < json.length; i++)
   	   	        		{
   	   	        			data = json[i];	
   	   	        			if(flag == 1)
   	   	        			{
	   	   	        			if(temp === data.productSeq)
	   	   	        			{
	   	   	        				makeTag += "<h4>" + data.regDate.slice(0,4) + "년 " + data.regDate.slice(4) + "월" + " " + data.orderTotalCnt.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',') + "건 " + data.totalCnt.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',') + "개 " + data.totalPrice.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',') + "원</h4>";
		   	   	        			totalCount += data.totalCnt;
	   	        					totalPrice += data.totalPrice;
				   	        		orderTotalCount += Number(data.orderTotalCnt);
	   	   	        			}
	   	   	        			else
	   	   	        			{
	   	   	        				makeTag += "<h4>총매출액 : " + orderTotalCount.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',') + "건 " + totalCount.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',') + "개 " + totalPrice.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',') + "원</h4>";
   	   	        					makeTag += "</div></div>";
	   	   	        				show += makeTag;
	   	   	        				makeTag = "";
		   	   	        			totalCount = 0;
		   	   	        			totalPrice = 0;
		   	   	        			orderTotalCount = 0;
	   	   	        				flag = 0;
	   	   	        			}	
   	   	        			}
   	   	        			if(flag == 0)
							{
	   	   	        			makeTag = 
		   	        					"<div style='width:100%; height: auto; border: 1px solid black; border-radius: 10px; padding: 10px; margin-bottom: 20px;'><h3>" +
		   	        					 data.pName + "</h3><div style='justify-content: center; text-align: center;'><h4>" +
		   	        					 data.regDate.slice(0,4) + "년 " + data.regDate.slice(4) + "월" + " " + data.orderTotalCnt.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',') + "건 " + data.totalCnt.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',') + "개 " + data.totalPrice.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',') + "원</h4>";	   	           			

   	        					totalCount += data.totalCnt;
   	        					totalPrice += data.totalPrice;
			   	        		orderTotalCount += Number(data.orderTotalCnt);
  	        					flag = 1;
							}
   	   	        			temp = data.productSeq;   	   	        			
   	   	           		}
   	        			makeTag += "<h4>총매출액 : " + orderTotalCount.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',') + "건 " + totalCount.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',') + "개 " + totalPrice.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',') + "원</h4>";
  	        			makeTag += "</div></div>";
   	        			show += makeTag;
   	        			revenueContainer.html(show);
   	        		}
   	        		else
   	        		{
   	        			return;
   	        		}
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
	});
});

//aboutMe 메서드 실행
function aboutMe() {
    $.ajax({
        type: "POST",
        url: "/seller/getSellerProfile",
        success: function (response) {
            if (response.code == 0) {
                $(".page-content").html("");
                let json = response.data;
                let makeTag =
                    "<div class='sellerinfocontainer' style='padding: 50px;'>" +
                    "<h2>판매자 정보 수정</h2>" +
                    "<div>" +
                    "<div style='margin-top: 20px;'>" +
                    "<label for='sellerid' style='font-size: 20px'>아이디 : &nbsp;</label>" +
                    "<span style='font-size: 20px;'>" + json.sellerId + "</span>" +
                    "</div>" +
                    "<div>" +
                    "<label for='sellerid' style='font-size: 20px'>가입일 : &nbsp;</label>" +
                    "<span style='font-size: 20px;'>" + json.regDate + "</span>" +
                    "</div>" +
                    "<div>" +
                    "<label for 'sellerid' style='font-size: 20px'>이메일 : &nbsp;</label>" +
                    "<span style='font-size: 20px;'>" + json.sellerEmail + "</span>" +
                    "</div>" +
                    "<div>" +
                    "<label for 'sellerid' style='font-size: 20px'>사업자번호 : &nbsp;</label>" +
                    "<span style='font-size: 20px;'>" + json.sellerBusinessId + "</span>" +
                    "</div>" +
                    "<div>" +
                    "<label for 'sellerid' style='font-size: 20px'>전화번호 : &nbsp;</label>" +
                    "<span style='font-size: 20px;'> " + json.sellerPh + "</span>" +
                    "</div>" +
                    "<form>" +
                    "<div style='margin-top: 20px; display: flex; justify-content: flex-start;'>" +
                    "<label for='sellerpwd' style='font-size: 20px;'>비밀번호 : &nbsp;</label>" +
                    "<input style='width: 77.5%;' type='password' class='form-control' id='sellerPwd1' name='sellerPwd1' value=" + json.sellerPwd + " placeholder='비밀번호' />" +
                    "</div>" +
                    "<div style='margin-top: 20px; display: flex; justify-content: flex-start;'>" +
                    "<label for 'sellerpwd' style='font-size: 20px'>비밀번호 확인 : &nbsp;</label>" +
                    "<input style='width: 74.3%;' type='password' class='form-control' id='sellerPwd2' name='sellerPwd2' value='" + json.sellerPwd + "' placeholder='비밀번호 확인' />" +
                    "</div>" +
                    "<div style='margin-top: 20px; display: flex; justify-content: flex-start;'>" +
                    "<label for 'shopname' style='font-size: 20px'>판매자 상호명 : &nbsp;</label>" +
                    "<input style='width: 74.3%;' type='text' class='form-control' id='shopName' name='shopName' value='" + json.sellerShopName + "' placeholder='상호명' />" +
                    "</div>" +
                    "<div style='margin-top: 20px;'>" +
                    "<br>" +
                    "<label for 'selleradd' style='font-size: 25px'>판매자 주소</label>" +
                    "<div class='field'>" +
                    "<input type='button' onclick='getDaumPostcode()' value='우편번호 찾기' style='height: 38px; background-color: #000; color: white; font-size: 15px;' />" +
                    "</div>" +
                    "<div style='display: flex; justify-content: flex-start; margin-top: 15px;'>" +
                    "<input type='text' name='postcode' id='postcode' style='width: 20%; height: 38px; margin-right: 10px; background-color: #FFF;' placeholder='우편번호' disabled> " +
                    "<input type='text' name='roadAddress' id='roadAddress' style='width: 64%; height: 38px; background-color: #FFF;' value='" + json.sellerAddress + "' placeholder='도로명주소' disabled>" +
                    "</div>" +
                    "<div>" +
                    "<input type='text' name='detailAddress' id='detailAddress' style='width: 84.8%; height: 38px; margin-top: 15px;' placeholder='상세주소'>" +
                    "</div>" +
                    "</div>" +
                    "<button style='font-size: 20px; width: 20%; margin-top: 15px;' type='button' id='btnUpdate' class='btn btn-primary'>수정</button>" +
                    "<input type='hidden' name='hiddenAdd' id='hiddenAdd' value=''>" +
                    "</form>" +
                    "</div>" +
                    "</div>";

                $(".page-content").html(makeTag);

                // 회원정보수정 완료 버튼 누를 시 ..
                $("#btnUpdate").on("click", function () {
                    // 모든 공백 체크 정규식
                    var emptCheck = /\s/g;
                    // 영문 대소문자, 숫자로만 이루어진 4~12자리 정규식
                    var pwCheck = /^[a-zA-Z0-9]{4,12}$/;

                    if ($.trim($("#sellerPwd1").val()).length <= 0) {
                        alert("비밀번호를 입력하세요.");
                        $("#sellerPwd1").val("");
                        $("#sellerPwd1").focus();
                        return;
                    }

                    if (emptCheck.test($("#sellerPwd1").val())) {
                        alert("비밀번호는 공백을 포함할 수 없습니다.");
                        $("#sellerPwd1").focus();
                        return;
                    }

                    if (!pwCheck.test($("#sellerPwd1").val())) {
                        alert("비밀번호는 영문 대소문자와 숫자로 4~12자리 입니다.");
                        $("#sellerPwd1").focus();
                        return;
                    }

                    if ($("#sellerPwd1").val() != $("#sellerPwd2").val()) {
                        alert("비밀번호가 일치하지 않습니다.");
                        $("#sellerPwd2").focus();
                        return;
                    }

                    // 이 부분은 주소를 업데이트하게끔 수정됨
                    var newAddress = $("#roadAddress").val() + " " + $("#detailAddress").val();
                    $("#hiddenAdd").val(newAddress);

                    $.ajax({
                        type: "POST",
                        url: "/seller/updateProc",
                        data: {
                            sellerPwd: $("#sellerPwd1").val(),
                            sellerShopName: $("#shopName").val(),
                            sellerAddress: $("#hiddenAdd").val()
                        },
                        datatype: "JSON",
                        success: function (response) {
                            if (response.code == 0) {
                                alert("판매자 정보가 수정되었습니다.");
                                location.reload();
                            } else if (response.code == 400) {
                                alert("파라미터 값이 올바르지 않습니다.");
                                $("#sellerPwd1").focus();
                            } else if (response.code == 404) {
                                alert("판매자 정보가 존재하지 않습니다.");
                                location.href = "/seller/logout";
                            } else if (response.code == 500) {
                                alert("판매자 정보 수정 중 오류가 발생하였습니다.");
                                $("#sellerPwd1").focus();
                            } else {
                                alert("판매자 수정 중 오류 발생");
                            }
                        },
                        error: function (xhr, status, error) {
                            icia.common.error(error);
                        }
                    });
                });
            } else {
                location.href = "/seller/logout";
            }
        },
        error: function (xhr, status, error) {
            console.log(error);
        }
    });
}

function fn_writeDeliveryNum(seq) 
{
   deliveryContainer.style.display = "flex";
   orderSeq = seq;
   $("#deliveryContainer").fadeIn();
}

      
   

//왼쪽 메뉴 레스토랑, 선물 리스트 버튼 클릭시
function restoGiftList(type)
{
   $(".page-content").html("");
   
   if(type == 1)
   {
      fn_restoList("/seller/getMyRestoList");
   }
   else if(type == 2)
   {
      fn_giftList("/seller/getMyGiftList");
   }
   else
   {
      return;
   }
}

//내가 등록한 레스토랑 리스트 뜨기
function fn_restoList(url)
{
   $.ajax
    ({
        type: "POST",
        url: url,
        success: function(response)
        {
           let json = response.data;
           let makeTag = "";
           let show = "";
           
           for(let i = 0; i < json.length; i++)
           {
              makeTag = 
                    "<div class='listItem'><a href='/resto/restoView?rSeq=" + json[i].rSeq + "'>" +
                    "<div class='itemBox'><img class='itemImg' src='/resources/upload/" + json[i].fileName + "'>" +
                    "</div></a><div class='itemText' style='font-size: 18px;'>등록일 : " + json[i].regDate;
               makeTag +=      
                    "<p class='texts impact' style='margin-top: 5px; font-size:20px;'><b>" + json[i].restoName + "</b></p><br>" +
                    "<p class='texts impact' style='font-size:20px;  font-weight: 310;' ><b> 레스토랑  주소 : "  + json[i].restoAddress + "</b></p>" ;
                  
               makeTag += "<p class='texts impact' style='font-size:20px; font-weight: 310;'><b>레스토랑 휴무일: ";

               if (json[i].restoOff !== null && json[i].restoOff !== "") {
                  makeTag += json[i].restoOff;
               } else {
                  makeTag += "연중무휴";
               }
               makeTag += "</b></p><br>";
               
               if (json[i].status === 'T') {
                  makeTag += "<span style='font-size: 18px; color: red;'> 매장 상태 정지입니다. 관리자에게 문의하세요. ( mail:dbrudals85@gmail.com / phone:010-9604-7420 )</span>";
               }
               if (json[i].status !== 'T') {
                  makeTag += "<a href='/seller/restoBring?rSeq=" + json[i].rSeq +"' style='font-size: 18px; color: blue;'>수정하기</a>";
               }

            	makeTag += "</div></div>";
              show += makeTag;

              makeTag = "";
           }
           $(".page-content").css("overflow", "scroll");
           $(".page-content").html(show);
        },
        error: function(xhr, status, error) 
        {
            console.log(error);
        }
    });  
}
//내가 등록한 선물 리스트 뜨기
function fn_giftList(url)
{
   $.ajax
    ({

        type: "POST",
        url: url,
        success: function(response)
        {
           let json = response.data;
           let makeTag = "";
           let show = "";
           for(let i = 0; i < json.length; i++)
           {
              makeTag = 
                    "<div class='listItem'><a href='/gift/giftview?productSeq=" + json[i].productSeq + "'>" +
                    "<div class='itemBox'><img class='itemImg' src='/resources/upload/" + json[i].fileName + "'>" +
                    "</div></a><div class='itemText' style='font-size: 18px;'>등록일 : " + json[i].regDate;
              makeTag +=      
                    "<p class='texts impact' style='margin-top: 5px; font-size:20px;'><b>" + json[i].pName + "</b></p><br>" +
                    "<p class='texts impact' style='font-size:20px;'><b>선물 가격: " + json[i].pPrice.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',')  + "원</b></p>" +
                    "<p class='texts impact' style='font-size:20px;'><b>선물 공개여부: " + json[i].status + "</b></p><br>" ;
                    
                    
                    if (json[i].status === 'T') {
                       makeTag += "<span style='font-size: 18px; color: red;'>선물 상태 정지입니다. 관리자에게 문의하세요. ( mail:dbrudals85@gmail.com / phone:010-9604-7420 )</span>";
                    }
                    if (json[i].status !== 'T') {
                       makeTag += "<a href='/seller/giftBring?productSeq=" +  json[i].productSeq +"' style='font-size: 18px; color: blue;'>수정하기</a>";
                    }      
         
            
              makeTag += "</div></div>";
              show += makeTag;

              makeTag = "";
           }
           $(".page-content").css("overflow", "scroll");
           $(".page-content").html(show);
        },
        error: function(xhr, status, error) 
        {
            console.log(error);
        }
    });  
}


//왼쪽 메뉴 레스토랑 예약, 선물 배송 리스트 버튼 클릭시
function orderRestoGiftList(type)
{
   $(".page-content").html("");
   
   if(type == 1)
   {
      fn_restoList2("/seller/getRestoOrderList");
   }
   else if(type == 2)
   {
      fn_giftList2("/seller/getGiftOrderList");
   }
   else
   {
      return;
   }
}

//식당 예약 리스트 클릭 시.
function fn_restoList2(url, formData) {
    $.ajax({
        type: "POST",
        url: url,
        data: formData,
        success: function(response) {
            searchType = response.data.searchType;
            searchValue = response.data.searchValue;
            let json = response.data.list; // AJAX 응답 데이터를 json 변수에 할당
            let makeTag = "";
            let show = "";
			console.log(response.data);
            for (let i = 0; i < json.length; i++) 
            {            	
            	makeTag = 
                    "<div class='listItem'><div class='itemText' style='font-size: 18px;'>주문번호 : " + json[i].orderSeq + "<br>결제일 : " + json[i].regDate + " 결제완료" +   
                    "<p class='texts impact' style='margin-top: 5px;'>" + json[i].restoName + "</p>" +
                    "<p class='texts impact'>결제액 : " + json[i].totalPrice.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',')  + "원</p>" +
                    "<p class='texts impact'>예약자 : " + json[i].userName + "</p>" +
                    "<p class='texts impact'>예약자연락처 : " + json[i].userPh + "</p>" +
                    "<p class='texts impact'>예약인원 : " + json[i].reservPerson.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',')  + "명</p>" + 
                    "<p class='texts impact'>예약일 : " + json[i].reservDate.substr(0, 10) + " " + json[i].reservTime + "</p><br></div></div>";
                    
             	 show += makeTag;

	             makeTag = "";
            }
            $(".page-content").css("overflow", "scroll");
            $(".page-content").html(show);

        },
        error: function(xhr, status, error) {
            console.log(error);
        }
    });
}

//선물배송리스트 클릭 시 
function fn_giftList2(url, formData) {
    $.ajax({
        type: "POST",
        url: url,
        data: formData,
        success: function(response) {
            searchType = response.data.searchType;
            searchValue = response.data.searchValue;
            let json = response.data.list; // AJAX 응답 데이터를 json 변수에 할당
            let makeTag = "";
            let show = "";

            $(".page-content").html("<p>총 " + json.length + "건</p>");
            for (let i = 0; i < json.length; i++) 
            {
            	
            	makeTag = 
                    "<div class='listItem'><div class='itemText' style='font-size: 18px;'>주문번호 : " + json[i].orderSeq + "<br>결제일 : " + json[i].regDate + " ";
                
                if (json[i].deliveryStatus == "0") 
                {
                    makeTag += "&nbsp;결제완료</p>";
                }
                else if (json[i].deliveryStatus == "1") 
                {
                    makeTag += "&nbsp;배송준비중</p>";
                } 
                else if (json[i].deliveryStatus == "2") 
                {
                    makeTag += "&nbsp;배송중</p>";
                } 
                else if (json[i].deliveryStatus == "3") 
                {
                    makeTag += "&nbsp;배송완료</p>";
                }   
                
                makeTag +=
                    "<p class='texts impact' style='margin-top: 5px;'>" + json[i].pName + "</p>" +
                    "<p class='texts impact'>결제액 : " + json[i].totalPrice.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',')  + "원</p>" +
                    "<p class='texts impact'>주문자 : " + json[i].userName + "</p>" +
                    "<p class='texts impact'>배송지 : " + json[i].orderAddress + "</p>" +
                    "<p class='texts impact'>요청사항 : " + json[i].orderMsg + "</p>"; 
                    
                if (json[i].deliveryStatus == "0") {
                    makeTag += "<div class='orderbutton'><input type='button' value='주문확인' class='itemBtn' onclick='confirmGiftOrder(" + json[i].orderSeq + ")'></div>";
                } 
                else if(json[i].deliveryStatus == "1"){
                    makeTag += "<div class='orderbutton'><input type='button' value='운송장입력' class='itemBtn' onclick='fn_writeDeliveryNum(" + json[i].orderSeq + ")'></div>";
                }
                makeTag += "</div></div>";
                    
                show += makeTag;

	            makeTag = "";
            }
            $(".page-content").css("overflow", "scroll");
            $(".page-content").html(show);
            

        },
        error: function(xhr, status, error) {
            console.log(error);
        }
    });
}


// 주문 확인 버튼을 눌렀을 때 실행되는 함수를 클로저로 정의
function confirmGiftOrder(orderSeq, deliveryStatus) {

   $(".page-content").html("");
   
   let formData =
      {
         orderSeq : orderSeq,
         deliveryStatus: deliveryStatus
      };
   
   $.ajax
    ({
        type: "POST",
        url: "/seller/confirmGiftOrder",
        data: formData,
        success: function(response)
        {
           if(response.code == 0)
         {
              $("#deliveryContainer").fadeOut();
              orderRestoGiftList("2");
                
           }
           else if(response.code == 500)
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

//운송장 입력 버튼 눌렀을 때 
function fn_writeDelivery(seq) 
{
    reviewContainer.style.display = "flex";
   orderSeq = seq;
   $("#reviewContainer").fadeIn();
}

//운송장입력 "등록" 버튼 누를 때 
function fn_deliveryNumProc(formData)
{
   $.ajax
    ({
        type: "POST",
        url: "/seller/deliveryNumProc",
        data: formData,
        success: function(response)
        {
           if(response.code == 0)
           {
        	  $("#deliveryContainer").fadeOut();
               // deliveryNumber 초기화
              $("#deliveryNumber").val("");
               
               // 선택된 옵션 초기화 (0번째 옵션을 선택하도록 설정)
              
              $(".delivery select").val("0");
           
               // 나머지 변수 초기화 (필요에 따라서 초기화)
              orderNum = "";
              orderSeq = "";
              orderRestoGiftList("2");
           }
           else if(response.code == 500)
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

// 레스토랑 주소 수정 시 필요한 function
function getDaumPostcode() 
{
     
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

function orderRestoList()
{
   location.href = '/seller/sellerRestoCheck';
}

function fn_movePage()
{
   window.location.href = "/seller/sellerMyPage";
}


function fn_getMyThings(type)
{
	let formData = 
    {
		type: type
    };
	
	$.ajax
    ({
        type: "POST",
        url: "/seller/getMyThings",
        data: formData,
        success: function(response)
        {
        	if(response.code == 0)
        	{
        		let json = response.data;
            	if(json.length > 0)
            	{
            		let searchType = $("#_searchType");
                   	searchType.empty();
                   	let option = [{text: "전체", value: 0}];
                   	let data;
                   	if(type == 0)
                   	{
                   		for(let i = 0; i < json.length; i++)
                   		{
                   			option.push({text: json[i].restoName, value: json[i].rSeq});
                   		}
                   	}
                   	else if(type == 1)
               		{
                   		for(let i = 0; i < json.length; i++)
                   		{
                   			option.push({text: json[i].pName, value: json[i].productSeq});
                   		}
               		}
                   	$.each(option, function(index, option) 
               		{
               			searchType.append($('<option>', 
               			{
                               value: option.value,
                               text: option.text
                    	}));
					})
            	}
            	else 
            	{
            		alert("등록된 매장이나 레스토랑이 없습니다.");
            	}	
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


</script>

</head>
<body>
   <link
      href="https://fonts.googleapis.com/css?family=DM+Sans:400,500,700&display=swap"
      rel="stylesheet">
   <%@ include file="/WEB-INF/views/include/navigation.jsp"%>

   <div id="deliveryContainer"
      style="position: fixed; top: 50%; left: 50%; transform: translate(-50%, -50%); height: 600px; width: 40%; display: none; flex-direction: column; align-items: center; justify-content: center; background: white; border-radius: 25px;">

      <h3 style="display: inline-block; margin: 20px 10px 0 0;">운송장 입력</h3>
      <span class="delivery" style="display: inline-block;"> <select>
            <option value="0">DHL</option>
            <option value="1">Sagawa</option>
            <option value="2">Kuroneko Yamato</option>
            <option value="3">Japan Post</option>
            <option value="4">천일택배</option>
            <option value="5">CJ대한통운</option>
            <option value="6">CU 편의점택배</option>
            <option value="7">GS Postbox 택배</option>
            <option value="8">CWAY (Woori Express)</option>
            <option value="9">대신택배</option>
            <option value="10">우체국 택배</option>
            <option value="11">한의사랑택배</option>
            <option value="12">한진택배</option>
            <option value="13">합동택배</option>
            <option value="14">홈픽</option>
            <option value="15">한서호남택배</option>
            <option value="16">일양로지스</option>
            <option value="17">경동택배</option>
            <option value="18">건영택배</option>
            <option value="19">로젠택배</option>
            <option value="20">롯데택배</option>
            <option value="21">SLX</option>
            <option value="22">성원글로벌카고</option>
            <option value="23">TNT</option>
            <option value="24">EMS</option>
            <option value="25">Fedex</option>
            <option value="26">UPS</option>
            <option value="27">USPS</option>
      </select>
      </span>

      <h4 style="margin-bottom: 15px;">송장번호</h4>
      <input type="text" id="deliveryNumber" maxlength="12"
         name="deliveryNumber" placeholder="최대 12자리까지 입력 가능합니다" />

      <div id="buttonContainer">
         <input type="button" value="등록" id="submitButton"> <input
            type="button" value="취소" id="cancelButton"
            style="margin-left: 10px;">
      </div>
   </div>

   <div class="task-manager">
      <div class="left-bar">
         <div class="upper-part">
            <div class="actions">
               <div class="circle"></div>
               <div class="circle-2"></div>
            </div>
         </div>
         <div class="left-content">
            <div class="seller-main-page">
            <div class="seller-main-page">
                <button class="small-button" onclick="location.href='/index/sellerIndex'" style="height: 85px;">
                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="#000000" stroke-width="2" stroke-linecap="butt" stroke-linejoin="bevel">
                        <path d="M20 9v11a2 2 0 0 1-2 2H6a2 2 0 0 1-2-2V9" />
                        <path d="M9 22V12h6v10M2 10.6L12 2l10 8.6" />
                    </svg>
                </button>
                <h6>판매자 메인페이지</h6>
            </div>

         </div>
            <ul class="profile-section">
               <div class="profile-section1"></div>
               <hr class="profile-divider">
               <!-- This is the separating line -->

            </ul>
            <div class="content-item">

               <ul class="action-list">
                  <li class="item" onclick="fn_movePage()"><svg
                        xmlns="http://www.w3.org/2000/svg" width="24" height="24"
                        viewBox="0 0 24 24" fill="none" stroke="#000000"
                        stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                        <path
                           d="M16 4h2a2 2 0 0 1 2 2v14a2 2 0 0 1-2 2H6a2 2 0 0 1-2-2V6a2 2 0 0 1 2-2h2"></path>
                        <rect x="8" y="2" width="8" height="4" rx="1" ry="1"></rect></svg> <span
                     style="font-size: 18px;">내 정보</span></li>
                  <li class="item" onClick="restoGiftList('1')"><svg
                        xmlns="http://www.w3.org/2000/svg" width="24" height="24"
                        viewBox="0 0 24 24" fill="none" stroke="#000000"
                        stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                        <path
                           d="M16 4h2a2 2 0 0 1 2 2v14a2 2 0 0 1-2 2H6a2 2 0 0 1-2-2V6a2 2 0 0 1 2-2h2"></path>
                        <rect x="8" y="2" width="8" height="4" rx="1" ry="1"></rect></svg> <span
                     style="font-size: 18px;">내 레스토랑</span></li>
                  <li class="item" onclick="restoGiftList('2')"><svg
                        xmlns="http://www.w3.org/2000/svg" width="24" height="24"
                        viewBox="0 0 24 24" fill="none" stroke="#000000"
                        stroke-width="2" stroke-linecap="butt" stroke-linejoin="bevel">
                        <rect x="3" y="4" width="18" height="18" rx="2" ry="2"></rect>
                        <line x1="16" y1="2" x2="16" y2="6"></line>
                        <line x1="8" y1="2" x2="8" y2="6"></line>
                        <line x1="3" y1="10" x2="21" y2="10"></line></svg> <span
                     style="font-size: 18px;">내 선물</span></li>
                  <li class="item" onclick="orderRestoGiftList('1')"><svg
                        xmlns="http://www.w3.org/2000/svg" width="24" height="24"
                        viewBox="0 0 24 24" fill="none" stroke="#000000"
                        stroke-width="2" stroke-linecap="butt" stroke-linejoin="bevel">
                        <rect x="2" y="4" width="20" height="16" rx="2" />
                        <path d="M7 15h0M2 9.5h20" /></svg> <span style="font-size: 18px;">식당
                        예약내역</span></li>
                  <li class="item" onclick="orderRestoGiftList('2')"><svg
                        xmlns="http://www.w3.org/2000/svg" width="24" height="24"
                        viewBox="0 0 24 24" fill="none" stroke="#000000"
                        stroke-width="2" stroke-linecap="butt" stroke-linejoin="bevel">
                        <rect x="2" y="4" width="20" height="16" rx="2" />
                        <path d="M7 15h0M2 9.5h20" /></svg> <span style="font-size: 18px;">선물
                        배송내역</span></li>
            <li class="item" onclick="aboutMe()" >
            <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="#000000" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><circle cx="12" cy="12" r="3"></circle><path d="M19.4 15a1.65 1.65 0 0 0 .33 1.82l.06.06a2 2 0 0 1 0 2.83 2 2 0 0 1-2.83 0l-.06-.06a1.65 1.65 0 0 0-1.82-.33 1.65 1.65 0 0 0-1 1.51V21a2 2 0 0 1-2 2 2 2 0 0 1-2-2v-.09A1.65 1.65 0 0 0 9 19.4a1.65 1.65 0 0 0-1.82.33l-.06.06a2 2 0 0 1-2.83 0 2 2 0 0 1 0-2.83l.06-.06a1.65 1.65 0 0 0 .33-1.82 1.65 1.65 0 0 0-1.51-1H3a2 2 0 0 1-2-2 2 2 0 0 1 2-2h.09A1.65 1.65 0 0 0 4.6 9a1.65 1.65 0 0 0-.33-1.82l-.06-.06a2 2 0 0 1 0-2.83 2 2 0 0 1 2.83 0l.06.06a1.65 1.65 0 0 0 1.82.33H9a1.65 1.65 0 0 0 1-1.51V3a2 2 0 0 1 2-2 2 2 0 0 1 2 2v.09a1.65 1.65 0 0 0 1 1.51 1.65 1.65 0 0 0 1.82-.33l.06-.06a2 2 0 0 1 2.83 0 2 2 0 0 1 0 2.83l-.06.06a1.65 1.65 0 0 0-.33 1.82V9a1.65 1.65 0 0 0 1.51 1H21a2 2 0 0 1 2 2 2 2 0 0 1-2 2h-.09a1.65 1.65 0 0 0-1.51 1z"></path>
            </svg>
            <span style="font-size: 18px;">내 정보수정</span>
          </li>
               </ul>

            </div>

         </div>
      </div>
   
      
      <div class="page-content" style="padding: 10px; height: 1180px;">

         

         
    <div class="page-contentmain">
    
    
    
       <div class="contain">
    <div class="card card-myId" data-state="#about"   style="height: 1070px;">
  <div class="card-header">
  
  </div>
  
   <div class="selectBox" style="justify-content: center; align-items: center;">
       <div class="field listType" style="width: 60%;">            
          <div>
             <label class="listType">
                <input type="radio" name="listType" value="0" onclick="fn_getMyThings(0)">
                <span>레스토랑</span>
            </label>
            &nbsp;
            <label class="listType">
                <input type="radio" name="listType" value="1" onclick="fn_getMyThings(1)">
                <span>선물</span>
            </label>
        </div>
       </div> 
       <select name="_searchType" id="_searchType" style="width: 250px; height: 100%; font-size: 20px; overflow: hidden; text-overflow: ellipsis;">
           <option value="" selected>조회 항목 선택</option>
       </select>
       
      <input type="date" id="startDate" name="calDate" style="width: 250px; height: 100%; font-size: 22px;">
      
      <input type="date" id="endDate" name="calDate" style="width: 250px; height: 100%; margin-left: 10px; font-size: 22px;">
      
       <img src="/resources/images/search.png" id="searchMyThings" style="width: auto; height: 100%; margin-left: 10px;">
   </div>     
  
     <div class="card-main" id="revenueContainer" style="overflow: scroll; height: 1000px;">   
      <div style="width:100%; height: auto; border: 1px solid black; border-radius: 10px; padding: 10px; margin-bottom: 20px;">
            <div style="justify-content: center; text-align: center;">
              <h3>검색할 조건을 선택해주세요.</h3>           
            </div>
         </div>
    </div>
</div>

</div> 

    
    
    
    </div>



      </div>




</body>
</html>