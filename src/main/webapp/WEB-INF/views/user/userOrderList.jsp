<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/head.jsp"%>
<html>
<head>
<style type="text/css">

@import url(//netdna.bootstrapcdn.com/font-awesome/3.2.1/css/font-awesome.css);

html, body 
{
    overflow: hidden; /* 스크롤 비활성화 */
    height: 100%; /* 화면 전체 높이로 설정 */ 
    background-color: #fffbf4 !important;
    
}

.listContainer
{
	width: 50%;
	height: 100%;
	margin-top: 100px;
	margin-left: auto;
	margin-right: auto;
	border: none;
}

.listType input[type="radio"] + span 
{
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
    padding-bottom: 8px;
    width: 95%;
    height: auto;
    margin: auto;
    background-color: #fff;
    display: flex;
    flex-direction: row;
    border-radius: 10px; /* .itemBox의 모서리를 둥글게 설정 */
}

.itemContainer
{
	padding: 10px;
	width: 100%;
	height: 805px;
}

.listItems
{	
	padding: 10px;
	width: 100%;
	height: 100%;
	overflow: auto;
}

::-webkit-scrollbar 
{
    width: 10px; /* 스크롤바의 너비를 조정하세요. */
}

/* 스크롤바의 슬라이더(Thumb) 디자인 */
::-webkit-scrollbar-thumb 
{
    background-color: #333; /* 스크롤바의 배경색을 지정하세요. */
    border-radius: 5px; /* 스크롤바의 모서리를 둥글게 만듭니다. */
}

.listItem
{
	border-radius: 10px; /* 박스 모서리 둥글게 만들기 */
	border: 1px solid;
	padding: 10px;
	width: 100%;
	height: 250px;
	display: flex; /* Flexbox 레이아웃을 사용하여 아이템 정렬 */	
	margin-bottom: 10px;	
    background-color: #fff;
}

.itemBox 
{
    height: 100%;
    width: 228.67px;
    border-radius: 10px; /* .itemBox의 모서리를 둥글게 설정 */
    overflow: hidden; /* 내용이 모서리를 넘어가지 않도록 함 */
}

.itemImg 
{
    display: block;
    width: 100%;
    height: 100%;
    object-fit: cover;
}

.itemText
{
	width: 100%;
	padding: 15px;
	
}

.texts 
{
    margin: 0; /* 마진을 제거 */
    padding: 0; /* 패딩을 제거 */
    font-family: "원하는 폰트", sans-serif; /* 원하는 폰트 이름으로 변경 */
}

.atext 
{
    color: #000;
}

.impact
{
	font-size: 18px;
    font-weight: bold;
}

.itemBtns
{
	width: 48%;
	height: 40px;
    border-radius: 10px; /* .itemBox의 모서리를 둥글게 설정 */
    border: none;
    background-color: #9dafeb;
}

.itemBtn
{
	width: 98%;
	height: 40px;
    border-radius: 10px; /* .itemBox의 모서리를 둥글게 설정 */
    border: none;
    background-color: #9dafeb;
}

.textBox .btnBox
{
	width: 100%;	
	display: flex; 
	flex-wrap: nowrap; /* 이 부분을 추가하여 줄 바꿈을 막습니다. */
	overflow: hidden; /* 필요한 경우 텍스트가 넘칠 때 가릴 수 있도록 오버플로우를 숨깁니다. */
	white-space: nowrap; /* 텍스트가 줄 바꿈 되지 않도록 합니다. */
}

.searchBox
{
	width: 100%;
	display: flex;
}

.selectBox
{
	padding: 10px;
	width: 30%;
	height: 76px;
	display: flex;
}

#_searchType 
{
    width: auto; /* 필요한 만큼의 너비를 가집니다. */
    height: 100%;
    border-radius: 10px; /* 테두리를 둥글게 만듭니다. */
    margin-right: 10px; /* 선택 상자 사이의 간격을 조정합니다. */
}

/* 검색 입력란(input) 스타일 수정 */
#_searchValue 
{
    width: auto; /* 고정된 너비를 가집니다. */
    height: 100%;
    border-radius: 10px; /* 테두리를 둥글게 만듭니다. */
    margin-right: 10px; /* 입력란과 검색 버튼 사이의 간격을 조정합니다. */
}




/****** Style Star Rating Widget *****/


fieldset, label 
{ 
	margin: 0; padding: 0; 
}

.rating 
{ 
  	border: none;
  	float: left;
}

.rating > input 
{ 
	display: none; 
} 

.rating > label:before {
 
  	margin: 5px;
  	font-size: 5em;
  	font-family: FontAwesome;
  	display: inline-block;
  	content: "\f005";
}

.rating > .half:before 
{ 
  	content: "\f089";
 	position: absolute;
}

.rating > label 
{ 
  	color: #ddd; 
 	float: right; 
}

/***** CSS Magic to Highlight Stars on Hover *****/

.rating > input:checked ~ label, /* show gold star when clicked */
.rating:not(:checked) > label:hover, /* hover current star */
.rating:not(:checked) > label:hover ~ label 
{ 
	color: #FFD700;  
} /* hover previous stars in list */

.rating > input:checked + label:hover, /* hover current star when changing rating */
.rating > input:checked ~ label:hover,
.rating > label:hover ~ input:checked ~ label, /* lighten current selection */
.rating > input:checked ~ label:hover ~ label 
{ 
	color: #FFED85;  
} 

#buttonContainer 
{
    display: flex;
	margin-top: 10px;
}

#submitButton, #cancelButton 
{
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

#submitButton 
{
    background-color: #3498db; /* 파란색 */
    color: white;
    margin-right: 5px; /* 오른쪽 마진 추가 */
}

#cancelButton 
{
    background-color: #e74c3c; /* 빨간색 */
    color: white;
}

#submitButton:hover 
{
    background-color: #2980b9; /* 파란색의 hover 색상 */
}

#cancelButton:hover 
{
    background-color: #c0392b; /* 빨간색의 hover 색상 */
}

</style>
<script type="text/javascript">
let searchType = "";
let searchValue = "";
let listType = ${listType};
let totalCount = ${totalCount};
let startRow = 1;
let endRow = 10;
let reviewNum = 0;
let orderSeq = "";

const productOptions = 
[
    { value: "0", text: "전체" },
    { value: "1", text: "상품명" },
    { value: "2", text: "결제일" }
];

const restoOptions = 
[
    { value: "0", text: "전체" },
    { value: "1", text: "상품명" },
    { value: "2", text: "결제일" },
    { value: "3", text: "예약일" }
];

$(document).ready(function() 
{
	let listItems = $(".listItems");
	
	
	listItems.on('scroll', function() 
    {
        if (listItems.scrollTop() + listItems.innerHeight() >= listItems[0].scrollHeight - 5) 
        {
			if(totalCount > endRow)
			{
				startRow += 10;
				endRow += 10;
				let formData = 
			    {
					startRow: startRow,
					endRow: endRow,
					searchType: searchType,
					searchValue: searchValue
			    };
				
				if(listType == "0")
				{
					fn_getRestoList("/user/getMoreRestoList", formData);
				}
				else if(listType == "1")
				{
        			fn_getProductList("/user/getMoreProductList", formData);
				}
				else
				{
					return;
				}
			}
        }
    });
	
	$("#btnSearch").on("click", function() 
	{
   		searchType = $("#_searchType").val();
   		searchValue = $("#_searchValue").val();
   		
   		let formData = 
   	    {
			searchType: searchType,
			searchValue: searchValue
   	    };

   		$(".listItems").html("");
   		
   		if(listType == 0)
   		{
   	   		fn_getRestoList("/user/getMoreRestoList", formData);
   		}
   		else if(listType == 1)
   		{
			fn_getProductList("/user/getMoreProductList", formData);
   		}
   		else
   		{
   			return;
   		}
   	});	
	
	$("input[type=radio]").on("click", function () 
	{
		reviewNum = parseFloat($(this).val());
    });
	 
	$("#cancelButton").click(function() 
	{
    	$("#reviewContainer").fadeOut();
    	reviewNum = 0;
    	orderSeq = "";
    });
	
	$("#submitButton").click(function() 
	{
		if(orderSeq != "" && orderSeq != null)
		{
			let formData = 
   		    {
   				orderSeq: orderSeq,
   				reviewNum: reviewNum,
   				reviewComment: $("#reviewText").val()
   		    };
			fn_reviewProc(formData);
		}
		else
		{
			return;
		}
    });
	
});

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

function fn_cancleReserv(orderSeq)
{
	if(orderSeq != "")
	{
		let formData = 
	    {
			orderSeq: orderSeq
	    };
		if(confirm("예약을 취소하시겠습니까?"))
		{
			$.ajax
		    ({
		        type: "POST",
		        url: "/user/cancleReserv",
		        data: formData,
		        success: function(response)
		        {
		        	if(response.code == 0)
		        	{
		        		alert(response.data);
		        		location.reload();
		        	}
		        	else if(response.code == 500)
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
	}
	else
	{
		return;
	}
}


function fn_reviewProc(formData)
{
	$.ajax
    ({
        type: "POST",
        url: "/user/writeReview",
        data: formData,
        success: function(response)
        {
        	if(response.code == 0)
        	{
        		alert(response.data);
        		location.reload();
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

function fn_getTotalCount(type)
{
	let formData = 
    {
		type: type
    };
	
	listType = type;
	
	$.ajax
    ({
        type: "POST",
        url: "/user/getTotalCount",
        data: formData,
        success: function(response)
        {
        	totalCount = response.data;
        	startRow = 1;
        	endRow = 10;
        	formData = 
		    {
				startRow: startRow,
				endRow: endRow
		    };
        	
           	$(".listItems").html("");
           	let searchType = $("#_searchType");
           	searchType.empty();
           	if(type == 0)
           	{
           		$.each(restoOptions, function(index, option) 
           		{
           			searchType.append($('<option>', 
           			{
                           value: option.value,
                           text: option.text
                       }));
                   });
       			fn_getRestoList("/user/getMoreRestoList", formData);
       			
           	}
           	else if(type == 1)
           	{
           		$.each(productOptions, function(index, option) 
           		{
           			searchType.append($('<option>', 
           			{
                           value: option.value,
                           text: option.text
                       }));
                   });
       			fn_getProductList("/user/getMoreProductList", formData);
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

function fn_getProductList(url, formData)
{
	$.ajax
    ({
        type: "POST",
        url: url,
        data: formData,
        success: function(response)
        {
        	searchType = response.data.searchType;
        	searchValue = response.data.searchValue;
        	let json = response.data.list;
        	let today = new Date();
        	let regDate = null;
        	let between = 0;
        	let makeTag = "";
        	let show = "";
        	for(let i = 0; i < json.length; i++)
        	{
        		regDate = new Date(json[i].regDate.slice(0, 10));
            	between = (today - regDate)/(1000 * 60 * 60 * 24);
        		makeTag = 
        				"<div class='listItem'><a href='/gift/giftView?productSeq=" + json[i].productSeq + "'>" +
        				"<div class='itemBox'><img class='itemImg' src='/resources/upload/" + json[i].fileName + "'>" +
        				"</div></a><div class='itemText'><p class='texts'>" + json[i].regDate;
        				
        		if(json[i].status == "N")
        		{
        			makeTag += "&nbsp;주문취소</p>";
        		}
        		else if(json[i].status == "Y")
        		{
        			if(json[i].deliveryStatus == "0")
        			{
            			makeTag += "&nbsp;결제완료</p>";
        			}
        			else if(json[i].deliveryStatus == "1")
        			{
        				makeTag += "&nbsp;배송준비중</p>";
        			}
        			else if(json[i].deliveryStatus == "2")
        			{
        				makeTag += "&nbsp;배송중</p>";
        			}
        			else if(json[i].deliveryStatus == "3")
        			{
        				makeTag += "&nbsp;배송완료</p>";
        			}
        		}
        		
        		makeTag += 
        				"<p class='texts impact' style='margin-top: 5px;'>" + json[i].pName + "</p>" +
        				"<p class='texts impact'>개수 : " + json[i].totalCnt.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',') + "개</p>" +
        				"<p class='texts impact' style='margin-bottom: 5px;'>결제액 : " + json[i].totalPrice.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',') + "원</p>" +
        				"<div class='textBox'><a class='texts atext' onclick=\"fn_getGiftOrderDetail('" + json[i].orderSeq + "')\">&nbsp;주문상세</a>" + 
        				"<a class='texts atext' href='/inquiry/inquiryWriteForm?afterSelected=3&orderSeq=" + json[i].orderSeq + "' style='margin-left: 75%;'>문의하기</a></div>";
    			
        		if(json[i].status == "Y")
    	        {
        			if(json[i].deliveryStatus == "0")
        			{
    					makeTag += "<input onclick=\"fn_cancleOrder('" + json[i].orderSeq + "')\" type='button' value='주문취소' class='itemBtn'>";
        			}    	 
        			else if(json[i].deliveryStatus == "2")
        			{
    					makeTag += "<input onclick=\"fn_deliveryTracking('" + json[i].orderSeq + "')\" type='button' value='배송조회' class='itemBtn'>";
        			}
        			else if(json[i].deliveryStatus == "3")
        			{
        				if(json[i].reviewed == "1")
						{
        					if(between > 28)
        					{
            					makeTag +=
    							    "<div class='btnBox'><input onclick=\"fn_movePage('" + json[i].productSeq + "', 1)\" type='button' value='다시구매하기' class='itemBtn' style='margin-left: 10px;'></div>";       						
        					}
        					else
        					{
            					makeTag +=
    							    "<div class='btnBox'><input onclick=\"fn_movePage('" + json[i].productSeq + "', 1)\" type='button' value='다시구매하기' class='itemBtns' style='margin-left: 10px;'>" +
    							    "<input onclick=\"fn_deliveryTracking('" + json[i].orderSeq + "')\" type='button' value='배송조회' class='itemBtns'></div>";
        					}
						}
						else
						{
							if(between > 28)
        					{
								makeTag +=
								    "<div class='btnBox'><input onclick=\"fn_movePage('" + json[i].productSeq + "', 1)\" type='button' value='다시구매하기' class='itemBtns' style='margin-left: 10px;'>" +
								    "<input type='button' value='리뷰쓰기' class='itemBtns' onclick=\"fn_writeReview('" + json[i].orderSeq + "')\"></div>";
        					}
							else
							{
								makeTag +=
								    "<div class='btnBox'><input type='button' value='리뷰쓰기' class='itemBtns' onclick=\"fn_writeReview('" + json[i].orderSeq + 
								    "')\"><input onclick=\"fn_deliveryTracking('" + json[i].orderSeq + "')\" type='button' value='배송조회' class='itemBtns'></div>";
							}
						}
        			}
				}
        		
				makeTag += "</div></div>";
        		show += makeTag;

        		makeTag = "";
        	}
        	$(".listItems").append(show);
        },
        error: function(xhr, status, error) 
        {
            console.log(error);
        }
    });  
}

function fn_deliveryTracking(orderSeq)
{
	if(orderSeq != "")
	{
		let formData = 
	    {
			orderSeq: orderSeq
	    };
		
		$.ajax
	    ({
	        type: "POST",
	        url: "/delivery/deliveryTracker",
	        data: formData,
	        success: function(response)
	        {
	        	if(response.code == 0)
	        	{
					let jsonData = JSON.parse(response.data.detail);
					let deliveryTracking = response.data.deliveryTracking;
					console.log(deliveryTracking);
					let popupWindow = window.open("", fn_getPopUpName(), "width=800,height=700");
	                popupWindow.document.open();
	                popupWindow.document.write("<html><head><title>배송 정보</title>");

	                popupWindow.document.write('<style>');
	                popupWindow.document.write('body { background-color: #fffbf4; }');   
	                popupWindow.document.write('.container { max-width: 800px; margin: 0 auto; padding: 20px; font-family: Arial, sans-serif; }');
	                popupWindow.document.write('.header { font-size: 24px; font-weight: bold; margin-bottom: 20px;  text-align: center;}');
	                popupWindow.document.write('.delivery-info { border: 1px solid #ccc; padding: 20px; margin-bottom: 20px; }');
	                popupWindow.document.write('.info-title { font-weight: bold;}');
	                popupWindow.document.write('.info-data { margin-left: 10%; display: inline-block;  }'); 
	                popupWindow.document.write('.info-none { display: inline-block; width: 150px;}'); 

	                popupWindow.document.write('</style>');

	                popupWindow.document.write('</head><body>');

	                popupWindow.document.write('<div class="container">');
	                popupWindow.document.write('<div class="header ">배 송 조 회</div>');
	                popupWindow.document.write('<img style="width: 100%; height: 120px;" src="/resources/images/deliveryTracker.png">');

	                popupWindow.document.write('<div class="basic-info">');
	                popupWindow.document.write('<div class="info-title" style="text-align: center;">기본정보</div>');
					
	                popupWindow.document.write('<div class="info-data-container">');
	                popupWindow.document.write('<div class="info-none">받 는 사 람</div> <span id="receiver" class="info-data">' + deliveryTracking.userName + '</span>');
	                popupWindow.document.write('</div>');

	                popupWindow.document.write('<div class="info-data-container">');
	                popupWindow.document.write('<div class="info-none">택 배 사</div> <span id="carrier" class="info-data">' + jsonData.carrier.name + ' (' + jsonData.carrier.tel + ')</span>');
	                popupWindow.document.write('</div>');

	                popupWindow.document.write('<div class="info-data-container">');
	                popupWindow.document.write('<div class="info-none">송 장 번 호</div> <span id="tracking-number" class="info-data">' + deliveryTracking.orderNum + '</span>');
	                popupWindow.document.write('</div>');

	                popupWindow.document.write('<div class="info-data-container">');
	                popupWindow.document.write('<div class="info-none">보 낸 사 람</div> <span id="sender" class="info-data">' + deliveryTracking.sellerShopName + '</span>');
	                popupWindow.document.write('</div>');
	                
	                popupWindow.document.write('<div class="info-data-container">');
	                popupWindow.document.write('<div class="info-none">상 품 명</div> <span id="sender" class="info-data">' + deliveryTracking.pName + '</span>');
	                popupWindow.document.write('</div>');
	                
				   	popupWindow.document.write('</div><br>');

	                // 모든 배송 정보 표시
	                jsonData.progresses.sort(function(a, b) 
	                {
	                    return new Date(b.time) - new Date(a.time);
	                });

	                // 모든 배송 정보 표시
	                jsonData.progresses.forEach(function(progress) 
	                {
	                    popupWindow.document.write("<div class='delivery-info'><div class='info-title'>" + progress.location.name + "</div>");

	                    // 시간과 분을 올바르게 표시
	                    let deliveryTime = new Date(progress.time);
	                    let deliveryHour = deliveryTime.getHours();
	                    let deliveryMinute = deliveryTime.getMinutes();

	                    // 문자열 연결 사용
	                    let contentHTML = deliveryHour + "시 " + deliveryMinute + "분<br>" + progress.status.text + "<br>" + progress.description;
	                    popupWindow.document.write("<div>" + contentHTML + "</div></div>");
	                });

	                popupWindow.document.write("</body></html>");
	                popupWindow.document.close();
	                
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
}


function fn_cancleOrder(orderSeq)
{
	if(orderSeq != "")
	{
		let formData = 
	    {
			orderSeq: orderSeq
	    };
		
		if(confirm("주문 취소하시겠습니까?"))
		{
			$.ajax
		    ({
		        type: "POST",
		        url: "/user/cancleOrder",
		        data: formData,
		        success: function(response)
		        {
		        	if(response.code == 0)
		        	{
		        		alert(response.data);
		        		location.reload();
		        	}
		        	else if(response.code == 500)
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
	}
	else
	{
		return;
	}
}

function fn_getRestoList(url, formData)
{
	$.ajax
    ({
        type: "POST",
        url: url,
        data: formData,
        success: function(response)
        {
        	searchType = response.data.searchType;
        	searchValue = response.data.searchValue;
        	let json = response.data.list;
        	let makeTag = "";
        	let show = "";
        	for(let i = 0; i < json.length; i++)
        	{
        		makeTag = 
        				"<div class='listItem'><a href='/resto/restoView?rSeq=" + json[i].rSeq + "'>" +
        				"<div class='itemBox'><img class='itemImg' src='/resources/upload/" + json[i].fileName + "'>" +
        				"</div></a><div class='itemText'><p class='texts'>" + json[i].regDate;
        				
        		if(json[i].status == "N")
        		{
        			makeTag += "&nbsp;예약취소</p>";
        		}
        		else if(json[i].status == "Y")
        		{
        			makeTag += "&nbsp;예약완료</p>";
        		}
        		else if(json[i].status == "W")
        		{
        			makeTag += "&nbsp;결제 대기중</p>";
        		}
        		
        		makeTag += 
        				"<p class='texts impact' style='margin-top: 5px;'>" + json[i].restoName + "</p>" +
        				"<p class='texts impact'>예약인원 : " + json[i].reservPerson.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',') + "명</p>" +
        				"<p class='texts impact'>예약일 : " + json[i].reservDate + " " + json[i].reservTime + "</p>" +
        				"<p class='texts impact' style='margin-bottom: 5px;'>결제액 : " + json[i].totalPrice.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',') + "원</p>" +
        				"<div class='textBox'>";
    			
   				if(json[i].status != "W")
           		{
           			makeTag += "<a class='texts atext' onclick=\"fn_getGiftOrderDetail('" + json[i].orderSeq + "')\">&nbsp;주문상세</a>" + 
           						"<a class='texts atext' href='/inquiry/inquiryWriteForm?afterSelected=3&orderSeq=" + json[i].orderSeq + "' style='margin-left: 75%;'>문의하기</a>";
           		}
       			
           		makeTag += "</div>";
        				
        		if(json[i].status == "W")
    	        {
					makeTag += "<input type='button' value='결제하기' class='itemBtn'>";    	        
				}
        		else if(json[i].status == "N")
       			{
       			}
        		else
        		{
        			if(json[i].changeable == "0")
    				{
						if(json[i].reviewed == "1")
						{
							makeTag += "<input onclick=\"fn_movePage('" + json[i].rSeq + "', 0)\" type='button' value='다시예약하기' class='itemBtn' style='margin-left: 10px;'>";
						}
						else
						{
							makeTag +=
							    "<div class='btnBox'><input type='button' value='리뷰쓰기' class='itemBtns' onclick=\"fn_writeReview('" + json[i].orderSeq + 
							    "')\"><input onclick=\"fn_movePage('" + json[i].rSeq + "', 0)\" type='button' value='다시예약하기' class='itemBtns' style='margin-left: 10px;'></div>";

						}
    				}
    				else if(json[i].changeable == "2")
    				{
    					makeTag += "<input onclick=\"fn_cancleReserv('" + json[i].orderSeq + "')\" type='button' value='예약취소' class='itemBtn'>";
    				}
        		}
				
				
				makeTag += "</div></div>";
        		show += makeTag;

        		makeTag = "";
        	}
        	$(".listItems").append(show);
        },
        error: function(xhr, status, error) 
        {
            console.log(error);
        }
    });  
}

function fn_writeReview(seq) 
{
    reviewContainer.style.display = "flex";
	orderSeq = seq;
	$("#reviewContainer").fadeIn();
}

function fn_getGiftOrderDetail(orderSeq)
{
	if(orderSeq != "")
	{
		let formData = 
	    {
			orderSeq: orderSeq
	    };
		
		$.ajax
	    ({
	        type: "POST",
	        url: "/user/giftOrderDetail",
	        data: formData,
	        success: function(response)
	        {
	        	if(response.code == 0)
	        	{
	        		let jsonData = response.data;	
					let popupWindow = window.open("", fn_getPopUpName(), "width=1000,height=800px;");
	                popupWindow.document.open();
	                popupWindow.document.write("<html><head><title>주문 정보</title>");

	                popupWindow.document.write('<style>');
	                popupWindow.document.write('body { background-color: #fffbf4; }');           
	                popupWindow.document.write('.container { border: 2px solid #000; border-radius: 10px; max-width: 1000px; margin: 0 auto; font-size: 24px; padding: 20px; font-family: Arial, sans-serif; }');
	                popupWindow.document.write('.header { font-size: 24px; font-weight: bold; margin-bottom: 20px;  text-align: center;}');
	                popupWindow.document.write('.delivery-info { border: 1px solid #ccc; padding: 20px; margin-bottom: 20px; }');
	                popupWindow.document.write('.info-title { font-weight: bold;}');
	                popupWindow.document.write('.info-data { margin-left: 3%; display: inline-block;  }'); 
	                popupWindow.document.write('.info-none { display: inline-block;}'); 

	                popupWindow.document.write('</style>');

	                popupWindow.document.write('</head><body>');

	                popupWindow.document.write('<div class="container">');

	                popupWindow.document.write('<div class="basic-info">');

	                popupWindow.document.write('<div class="info-data-container"');
	                if(jsonData.status == "Y")
	                {
		                popupWindow.document.write('<div class="info-none"><h2 style="margin: 0px;">구매 완료</h2></div>');
	                }
	                else
	                {
		                popupWindow.document.write('<div class="info-none"><h2 style="margin: 0px;">구매 취소</h2></div></span>');
	                }
	                
	                popupWindow.document.write('</div>');

	                popupWindow.document.write('<div class="info-data-container">');
	                popupWindow.document.write('<div class="info-none">주문번호 : </div> <span id="receiver" class="info-data">' + jsonData.orderSeq + '</span>');
	                popupWindow.document.write('</div>');

	                popupWindow.document.write('<div class="info-data-container">');
	                popupWindow.document.write('<div class="info-none">결제일 : </div> <span id="carrier" class="info-data">' + jsonData.regDate.slice(0, 10).replaceAll("-", ".") + '</span>');
	                popupWindow.document.write('</div>');

	                popupWindow.document.write('<div class="info-data-container">');
	                popupWindow.document.write('<div class="info-none">상품명 : </div> <span id="tracking-number" class="info-data">' + jsonData.pName + '</span>');
	                popupWindow.document.write('</div>');
	                popupWindow.document.write('<div class="info-data-container">');
	                popupWindow.document.write('<div class="info-none">판매자 번호 : </div> <span id="tracking-number" class="info-data">' + jsonData.sellerPh + '</span>');
	                popupWindow.document.write('</div>');


	                popupWindow.document.write('<div class="info-data-container">');
	                popupWindow.document.write('<div class="info-none">구매 개수 : </div> <span id="sender" class="info-data">' + jsonData.totalCnt.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',') + '개</span>');
	                popupWindow.document.write('</div>');
	                popupWindow.document.write('<div class="info-data-container">');
	                popupWindow.document.write('<div class="info-none">결제액 : </div> <span id="sender" class="info-data">' + jsonData.totalPrice.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',') + '원</span>');
	                popupWindow.document.write('</div>');
	                popupWindow.document.write('<div class="info-data-container">');
	                popupWindow.document.write('<div class="info-none">성명 : </div> <span id="sender" class="info-data">' + jsonData.userName + '</span>');
	                popupWindow.document.write('</div>');
	                popupWindow.document.write('<div class="info-data-container">');
	                popupWindow.document.write('<div class="info-none">배송지 : </div> <span id="sender" class="info-data">' + jsonData.orderAddress + '</span>');
	                popupWindow.document.write('</div>');
	                popupWindow.document.write('<div class="info-data-container">');
	                popupWindow.document.write('<div class="info-none">전화번호 : </div> <span id="sender" class="info-data">' + jsonData.userPh + '</span>');
	                popupWindow.document.write('</div>');
	                
				   	popupWindow.document.write('</div><br>');

	                popupWindow.document.write('<img style="width: 100%; height: 100%; border-radius: 10px; " src="/resources/upload/' + jsonData.fileName + '">');
	                popupWindow.document.write("</body></html>");
	                popupWindow.document.close()
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
}

function fn_getPopUpName()
{
	return "Detail" + Date.now();	
}

function fn_getRestoOrderDetail(orderSeq)
{
	if(orderSeq != "")
	{
		let formData = 
	    {
			orderSeq: orderSeq
	    };
		
		$.ajax
	    ({
	        type: "POST",
	        url: "/user/restoOrderDetail",
	        data: formData,
	        success: function(response)
	        {
	        	if(response.code == 0)
	        	{
					let jsonData = response.data;
					let popupWindow = window.open("", fn_getPopUpName(), "width=1000,height=800");
					
	                popupWindow.document.open();
	                popupWindow.document.write("<html><head><title>주문 정보</title>");

	                popupWindow.document.write('<style>');
	                popupWindow.document.write('body { background-color: #fffbf4; }');
	                popupWindow.document.write('.container { border: 2px solid #000; border-radius: 10px; max-width: 1000px; margin: 0 auto; font-size: 24px; padding: 20px; font-family: Arial, sans-serif; }');
	                popupWindow.document.write('.header { font-size: 24px; font-weight: bold; margin-bottom: 20px;  text-align: center;}');
	                popupWindow.document.write('.delivery-info { border: 1px solid #ccc; padding: 20px; margin-bottom: 20px; }');
	                popupWindow.document.write('.info-title { font-weight: bold;}');
	                popupWindow.document.write('.info-data { margin-left: 3%; display: inline-block;  }'); 
	                popupWindow.document.write('.info-none { display: inline-block;}'); 


	                popupWindow.document.write('</style>');

	                popupWindow.document.write('</head><body>');

	                popupWindow.document.write('<div class="container">');

	                popupWindow.document.write('<div class="basic-info">');

	                popupWindow.document.write('<div class="info-data-container">');
	                if(jsonData.status == "Y")
	                {
		                popupWindow.document.write('<div class="info-none"><h2 style="margin: 0px;">예약중</h2></div>');

	                }
	                else
	                {
		                popupWindow.document.write('<div class="info-none"><h2 style="margin: 0px;">예약취소</h2></div></span>');

	                }
	                
	                popupWindow.document.write('</div>');

	                popupWindow.document.write('<div class="info-data-container">');
	                popupWindow.document.write('<div class="info-none">주문번호 : </div> <span id="receiver" class="info-data">' + jsonData.orderSeq + '</span>');
	                popupWindow.document.write('</div>');

	                popupWindow.document.write('<div class="info-data-container">');
	                popupWindow.document.write('<div class="info-none">결제일 : </div> <span id="carrier" class="info-data">' + jsonData.regDate.slice(0, 10).replaceAll	("-", ".") + '</span>');
	                popupWindow.document.write('</div>');

	                popupWindow.document.write('<div class="info-data-container">');
	                popupWindow.document.write('<div class="info-none">레스토랑명 : </div> <span id="tracking-number" class="info-data">' + jsonData.restoName + '</span>');
	                popupWindow.document.write('</div>');
	                popupWindow.document.write('<div class="info-data-container">');
	                popupWindow.document.write('<div class="info-none">레스토랑주소 : </div> <span id="tracking-number" class="info-data">' + jsonData.restoAddress + '</span>');
	                popupWindow.document.write('</div>');
	                popupWindow.document.write('<div class="info-data-container">');
	                popupWindow.document.write('<div class="info-none">레스토랑번호 : </div> <span id="tracking-number" class="info-data">' + jsonData.restoPh + '</span>');
	                popupWindow.document.write('</div>');


	                popupWindow.document.write('<div class="info-data-container">');
	                popupWindow.document.write('<div class="info-none">예약 인원 : </div> <span id="sender" class="info-data">' + jsonData.totalCnt.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',') + '명</span>');
	                popupWindow.document.write('</div>');
	                popupWindow.document.write('<div class="info-data-container">');
	                popupWindow.document.write('<div class="info-none">예약자 성명 : </div> <span id="sender" class="info-data">' + jsonData.userName + '</span>');
	                popupWindow.document.write('</div>');
	                popupWindow.document.write('<div class="info-data-container">');
	                popupWindow.document.write('<div class="info-none">예약금 : </div> <span id="sender" class="info-data">' + jsonData.totalPrice.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',') + '원</span>');
	                popupWindow.document.write('</div>');
	                popupWindow.document.write('<div class="info-data-container">');
	                popupWindow.document.write('<div class="info-none">예약일 : </div> <span id="sender" class="info-data">' + jsonData.reservDate + " " + jsonData.reservTime + '</span>');
	                popupWindow.document.write('</div>');
	                
				   	popupWindow.document.write('</div></div><br>');

				   	popupWindow.document.write('<img style="width: 100%; height: 100%; border-radius: 10px;" src="/resources/upload/' + jsonData.fileName + '">');
		            popupWindow.document.write("</body></html>");
	                popupWindow.document.close();
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
}

function fn_movePayPage(restoName, orderPerson, totalAmount, orderDate, orderTime, orderSeq) 
{
   
   	var form = document.getElementById("restoPay");
    
	form.querySelector('input[name="restoName"]').value = restoName;
    form.querySelector('input[name="orderPerson"]').value = orderPerson;
    form.querySelector('input[name="totalAmount"]').value = totalAmount;
    form.querySelector('input[name="orderDate"]').value = orderDate;
    form.querySelector('input[name="orderTime"]').value = orderTime;
    form.querySelector('input[name="orderSeq"]').value = orderSeq;
    
   	var win = window.open('', 'pay', 'toolbar=no,location=no,status=no,menubar=no,scrollbars=yes,resizable=no,width=540,height=700,left=650,top=150');
   	document.restoPay.action = '/kakao/pay'; 
   	document.restoPay.target = 'pay';
   	document.restoPay.submit();
   
}

function payComplete(orderSeq) //결제 성공했으니 결제대기중(W)->결제완료(Y) 상태로 업데이트
{
    $.ajax({
        type:"POST",
        url:"/resto/restoReservationUpdate",
        data:
        {
          orderSeq: orderSeq
        },
        success:function(response)
        {
        	if(response.code == 0)
           	{
            	document.restoPay.action = "/resto/restoReserv";
              	document.restoPay.target = "_self";
              	document.restoPay.submit();
          	}
           	else if(response.code == 400)
           	{
              	alert("파라미터 값이 올바르지 않습니다.");
           	}
           	else if(response.code == 404)
           	{
              	alert("주문정보를 찾을 수 없습니다.");
              	location.reload();
           	}
           	else
           	{
              	alert("알 수 없는 오류가 발생하였습니다.");
           	}
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
<%@ include file="/WEB-INF/views/include/navigation.jsp"%>
<div id="reviewContainer" style="position: fixed; top: 50%; left: 50%; transform: translate(-50%, -50%); height:600px; width:40%; display: none; flex-direction: column; align-items: center; justify-content: center; background: white; border-radius: 25px;">
	
	<h3 style="margin-bottom: -5px; margin-top: 20px;">리뷰 쓰기</h3>
	<fieldset class="rating">
		<input type="radio" id="star5" name="rating" value="10" /><label class="full" for="star5"></label>
        <input type="radio" id="star4half" name="rating" value="9" /><label class="half" for="star4half"></label>
        <input type="radio" id="star4" name="rating" value="8" /><label class="full" for="star4"></label>
        <input type="radio" id="star3half" name="rating" value="7" /><label class="half" for="star3half"></label>
        <input type="radio" id="star3" name="rating" value="6" /><label class="full" for="star3"></label>
        <input type="radio" id="star2half" name="rating" value="5" /><label class="half" for="star2half"></label>
        <input type="radio" id="star2" name="rating" value="4" /><label class="full" for="star2"></label>
        <input type="radio" id="star1half" name="rating" value="3" /><label class="half" for="star1half"></label>
        <input type="radio" id="star1" name="rating" value="2" /><label class="full" for="star1"></label>
        <input type="radio" id="starhalf" name="rating" value="1" /><label class="half" for="starhalf"></label>
 
	</fieldset>
	<br>
	<br><br><br>
	<h4 style="margin-bottom: 15px;">어떤 점이 좋았나요?</h4>
    <textarea id="reviewText" maxlength="20" name="reviewText" placeholder="최대 20글자까지 입력 가능합니다" style="width: 50%; height: 300px;"></textarea>

	<div id="buttonContainer">
	    <input type="button" value="등록" id="submitButton">
	    <input type="button" value="취소" id="cancelButton" style="margin-left: 10px;">
	</div>
</div>

<div class="listContainer">
	<div>
		<h2 style="color: black;">&nbsp;&nbsp;&nbsp;주문 내역</h2>
	</div>
	
	<div class="searchBox">
		<div class="field listType" style="width: 60%;">            
	       	<div>
	       		<label class="listType">
	                <input type="radio" name="listType" value="0"  onclick="fn_getTotalCount(0)" <c:if test='${listType eq "0"}'>checked</c:if>>
	                <span>레스토랑</span>
	            </label>
	            &nbsp;
	            <label class="listType">
	                <input type="radio" name="listType" value="1" onclick="fn_getTotalCount(1)">
	                <span>선물</span>
	            </label>
	        </div>
	    </div> 
	     <div class="selectBox">
        	<select name="_searchType" id="_searchType" class="" style="width: auto; height: 100%;">
        		<c:choose>
        			<c:when test="${listType eq '0'}">
			            <option value="0" <c:if test='${searchType eq "0"}'>selected</c:if>>전체</option>
			            <option value="1" <c:if test='${searchType eq "1"}'>selected</c:if>>매장명</option>
			            <option value="2" <c:if test='${searchType eq "2"}'>selected</c:if>>결제일</option>
			            <option value="3" <c:if test='${searchType eq "3"}'>selected</c:if>>예약일</option>
        			</c:when>
        			<c:otherwise>
			            <option value="0" <c:if test='${searchType eq "0"}'>selected</c:if>>전체</option>
			            <option value="1" <c:if test='${searchType eq "1"}'>selected</c:if>>상품명</option>
			            <option value="2" <c:if test='${searchType eq "2"}'>selected</c:if>>결제일</option>
        			</c:otherwise>
        		</c:choose>
	        </select>
	        <input type="text" name="_searchValue" id="_searchValue" value="${searchValue}" class="form-control mx-1" maxlength="20" style="width: auto; height: 100%" placeholder="조회값을 입력하세요." />      
        	<img src="/resources/images/search.png" id="btnSearch" style="width: auto; height: 100%; margin-left: 10px;">
        </div>     
	</div>
	
	<div class="itemContainer">
		<div class="listItems">
			<c:if test="${!empty restoOrderList}">
				<c:forEach var="resto" items="${restoOrderList}" varStatus="status">
					<div class="listItem">
						<a href="/resto/restoView?rSeq=${resto.rSeq}">
							<div class="itemBox">
									<img class="itemImg" src="/resources/upload/${resto.fileName}">
							</div>
						</a>
						<div class="itemText">
							<p class="texts">${resto.regDate}  
								<c:choose>
									<c:when test="${resto.status eq 'N'}">
										예약취소
									</c:when>
									<c:when test="${resto.status eq 'W'}">
										결제 대기중
									</c:when>
									<c:otherwise>
										예약완료
									</c:otherwise>
								</c:choose>
							</p>
							<p class="texts impact" style="margin-top: 5px;">${resto.restoName}</p>
							<p class="texts impact">예약인원 : <fmt:formatNumber value="${resto.reservPerson}" pattern="#,###"/>명</p>
							<p class="texts impact">예약일 : ${resto.reservDate} ${resto.reservTime}</p>
							<p class="texts impact" style="margin-bottom: 5px;">결제액 : <fmt:formatNumber value="${resto.totalPrice}" pattern="#,###"/>원</p>
							<div class="textBox">
								<c:if test="${resto.status ne 'W'}">
									<a class="texts atext" onclick="fn_getRestoOrderDetail('${resto.orderSeq}')">&nbsp;주문상세</a>
									<a class="texts atext" href="/inquiry/inquiryWriteForm?afterSelected=1&orderSeq=${resto.orderSeq}" style="margin-left: 75%;">문의하기</a>
								</c:if>
							</div>
							<c:choose>
								<c:when test="${resto.status eq 'W'}">
									<input type="button" value="결제하기" class="itemBtn" onclick="fn_movePayPage('${resto.restoName}', ' ${resto.reservPerson}', '${resto.totalPrice}', '${resto.reservDate}', '${resto.reservTime}', '${resto.orderSeq}')">								</c:when>
								<c:when test="${resto.status eq 'N'}">								
								</c:when>
								<c:otherwise>
									<c:choose>
										<c:when test="${resto.changeable eq '0'}">
											<c:choose>
												<c:when test="${resto.reviewed eq '1'}">
													<input onclick="fn_movePage('${resto.rSeq}', 0)" type="button" value="다시예약하기" class="itemBtn" style="margin-left: 10px;">
												</c:when>
												<c:otherwise>
													<div class="btnBox">
														<input onclick="fn_writeReview('${resto.orderSeq}')" type="button" value="리뷰쓰기" class="itemBtns">
														<input onclick="fn_movePage('${resto.rSeq}', 0)" type="button" value="다시예약하기" class="itemBtns" style="margin-left: 10px;">
													</div>
												</c:otherwise>
											</c:choose>
										</c:when>
										<c:when test="${resto.changeable eq '2'}">
											<input onclick="fn_cancleReserv('${resto.orderSeq}')" type="button" value="예약취소" class="itemBtn">
										</c:when>
									</c:choose>
								</c:otherwise>
							</c:choose>
						</div>
					</div>
				</c:forEach>
			</c:if>
		</div>
    </div>
</div>
<form id="restoPay" name="restoPay" target="pay">
     <input type="hidden" name="restoName" value="">
     <input type="hidden" name="orderPerson" value="">
     <input type="hidden" name="totalAmount" value="">
     <input type="hidden" name="orderDate" value="">
     <input type="hidden" name="orderTime" value="">
     <input type="hidden" name="orderSeq" value="">
</form>
</body>
</html>