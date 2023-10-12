<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<title>Dayiary</title>
<link rel="shortcut icon" href="/resources/images/logo.png" type="image/x-icon">
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<script type="text/javascript" src="/resources/js/jquery-3.5.1.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/meyer-reset/2.0/reset.min.css">
<link rel='stylesheet' href='https://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css'>
<script src="https://cdnjs.cloudflare.com/ajax/libs/prefixfree/1.0.7/prefixfree.min.js"></script>
<script src='https://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js'></script>
<style>
.glyphicon { margin-right:5px; }
.thumbnail
{
    margin-bottom: 20px;
    padding: 0px;
    -webkit-border-radius: 0px;
    -moz-border-radius: 0px;
    border-radius: 0px;
}

.item.list-group-item
{
    float: none;
    width: 100%;
    background-color: #fff;
    margin-bottom: 10px;
}
.item.list-group-item:nth-of-type(odd):hover,.item.list-group-item:hover
{
    background: #428bca;
}

.item.list-group-item .list-group-image
{
    margin-right: 10px;
}
.item.list-group-item .thumbnail
{
    margin-bottom: 0px;
}
.item.list-group-item .caption
{
    padding: 9px 9px 0px 9px;
}
.item.list-group-item:nth-of-type(odd)
{
    background: #eeeeee;
}	

.item.list-group-item:before, .item.list-group-item:after
{
    display: table;
    content: " ";
}

.item.list-group-item img
{
    float: left;
}
.item.list-group-item:after
{
    clear: both;
}

.bottomFixed
{
	position: fixed;
	bottom: 0;
    width: 100%;
}

.list-group-item-text
{
	font-size: 18px; 	
}
</style>

<script>
$(document).ready(function() 
{
	let totalCount = ${totalCount};
	let startRow = ${hashMap.startRow};
	let endRow = ${hashMap.endRow};
	
	let listType = 0;

	let products = $("#products");
	
    $('#list').click(function(event)
    {
    	listType = 1;
        event.preventDefault();
        $('#products .item').addClass('list-group-item');
    });
    
    $('#grid').click(function(event)
    {
    	listType = 0;
        event.preventDefault();
        $('#products .item').removeClass('list-group-item');
        $('#products .item').addClass('grid-group-item');
    });
    
	let isScrolling = false;
	
    $(window).scroll(function() 
    {
    	if(isScrolling)
    	{
    		return;
    	}
    	
    	if ($(window).scrollTop() + $(window).height() >= $(document).height()) 
        {
        	if(totalCount > endRow)
			{
		        startRow += 6;
		        endRow += 6;
		        let formData = 
		        {
		            startRow: startRow,
		            endRow: endRow,
		            searchValue: $("#searchValue").val()
		        };
		        
		        getRestoTotalRevenueList(formData, listType);
		        
		        isScrolling = true;
		        setTimeout(function() 
		        {
		            isScrolling = false;
		        }, 100);
			}
        }
    });
    
    $("#btnSearch").on("click", function()
    {
    	let formData = 
        {
            searchValue: $("#searchValue").val()
        };
    	
    	$.ajax
	    ({
	        type: "POST",
	        url: "/admin/getRestoTotalCount",
	        data: formData,
	        success: function(response)
	        {
	        	if(response.code == 0)
	        	{
	        		totalCount = response.data;
	        		startRow = 1;
	        		endRow = 6;
	        		formData = 
			        {
			            startRow: startRow,
			            endRow: endRow,
			            searchValue: $("#searchValue").val()
			        };
	        		
	        		if(totalCount > 0)
	        		{
	        			products.html("");
						
	        			if(totalCount > 3)
						{
		       		        $('#bottomFixed').removeClass('bottomFixed');
						}
						else
						{
							$('#bottomFixed').addClass('bottomFixed');
		       		    }
						
	        			getRestoTotalRevenueList(formData, listType);
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

function getRestoTotalRevenueList(formData, listType)
{
	let products = $("#products");
	
	$.ajax
    ({
        type: "POST",
        url: "/admin/getRestoTotalRevenueList",
        data: formData,
        success: function(response)
        {
        	if(response.code == 0)
        	{
        		let json = response.data;
        		let makeTag = "";
        		let show = "";
        		let data = "";
        		if(json.length > 0)
        		{
        			for(let i = 0; i < json.length; i++)
        			{
        				data = json[i];
        			
        				makeTag = 
        				    "<div class='item col-xs-4 col-lg-4' onclick=\"fn_restoRevenueDetailView('" + data.rSeq + "')\">" +
        				    "<div class='thumbnail'><img class='group list-group-image' src='/resources/upload/" + data.fileName + "' alt='' style='width: 500px; height: 350px;'/>" +
        				    "<div class='caption'><h4 class='group inner list-group-item-heading' style='font-size: 20px; font-weight: bold;  overflow: hidden; white-space: nowrap; overflow: hidden; text-overflow: ellipsis;'>" + data.restoName + "</h4><p class='group inner list-group-item-text'>" +
        				    "총 예약건수 : " + data.restoTotalCount.replace(/\B(?=(\d{3})+(?!\d))/g, ',') + "건<br>총 예약인원 : " + data.reservPerson.replace(/\B(?=(\d{3})+(?!\d))/g, ',') + "명<br>" +
        				    "총 매출액 : " + data.restoTotalPrice.replace(/\B(?=(\d{3})+(?!\d))/g, ',') + "원<br>예약금 : " + data.restoDeposit.replace(/\B(?=(\d{3})+(?!\d))/g, ',') + "원</p></div></div></div>";

        				show += makeTag;
        				makeTag = "";
        			}
        			
        			products.append(show);
        			
        			if(listType == 0)
        			{
        		        event.preventDefault();
        		        $('#products .item').removeClass('list-group-item');
        		        $('#products .item').addClass('grid-group-item');
        			}
        			else if(listType == 1)
        			{
        		        event.preventDefault();
        		        $('#products .item').addClass('list-group-item');
        			}
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
}

function fn_restoRevenueDetailView(rSeq)
{
	window.location.href = "/admin/adminRestoView?rSeq=" + rSeq;
}
</script>
</head>
<body style="height: 100%; background-color: #fffbf4; margin-bottom: auto">
<%@ include file="/WEB-INF/views/include/adminNavi.jsp" %>
<div class="container" style="margin-top: 100px; width: 1600px;">
    <div class="well well-sm">
		<div class="btn-group" style="display: flex; justify-content: space-between; align-items: center;">
            <span>
            	<strong>Display</strong>
	            <a href="#" id="list" class="btn btn-default btn-sm">
	            	<span class="glyphicon glyphicon-th-list">
	            	</span>List
	            </a> 
	            <a href="#" id="grid" class="btn btn-default btn-sm">
	            	<span class="glyphicon glyphicon-th">
	            	</span>Grid
	            </a>
            </span>
            <span>
            	<input type="text" id="searchValue" style="width: 250px; height: 29px;" placeholder="레스토랑명을 입력해주세요.">
        		<img id="btnSearch" src="/resources/images/search.png" style="width: 25px; height: 25px;">
            </span>
	        
        </div>
    </div>
    <div id="products" class="row list-group">
    	<c:if test="${!empty list}">
          	<c:forEach var="admin" items="${list}" varStatus="status">        
        		<div class="item  col-xs-4 col-lg-4" onclick="fn_restoRevenueDetailView('${admin.rSeq}')">
		            <div class="thumbnail">
		                <img class="group list-group-image" src="/resources/upload/${admin.fileName}" alt="" style="width: 500px; height: 350px;"/>
		                <div class="caption">
		                    <h4 class="group inner list-group-item-heading" style="font-size: 20px; font-weight: bold; overflow: hidden; white-space: nowrap; overflow: hidden; text-overflow: ellipsis;">${admin.restoName}</h4>
		                    <p class="group inner list-group-item-text">
		                        총 예약건수 : <fmt:formatNumber value="${admin.restoTotalCount}" pattern="#,###"/>건<br>
		                        총 예약인원 : <fmt:formatNumber value="${admin.reservPerson}" pattern="#,###"/>명<br>
		                        총 매출액 : <fmt:formatNumber value="${admin.restoTotalPrice}" pattern="#,###"/>원<br>
		                        예약금 : <fmt:formatNumber value="${admin.restoDeposit}" pattern="#,###"/>원
		                    </p>
		                </div>
		            </div>
		        </div>
           	</c:forEach>
        </c:if> 
    </div>
</div>
<footer id="bottomFixed" style="background-color: black; color: lightgray; text-align: center; margin-top: auto; padding: 30px;"> 
 <p style="font-size:20px; letter-spacing:5px;">《 Dayiary 》 </p>
    &copy; Copyright Dayiary Corp. All Rights Reserved. <br>
    Always with you 🎉 여러분의 일상을 함께합니다.
</footer>
</body>
</html>