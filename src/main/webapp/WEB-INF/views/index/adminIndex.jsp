<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
<head>
<%@ include file="/WEB-INF/views/include/head.jsp" %>

<link rel='stylesheet' href='https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/css/bootstrap.min.css'>
<link rel='stylesheet' href='https://cdnjs.cloudflare.com/ajax/libs/morris.js/0.5.1/morris.css'>
<script src='https://cdnjs.cloudflare.com/ajax/libs/raphael/2.2.7/raphael.min.js'></script>
<script src='https://cdnjs.cloudflare.com/ajax/libs/morris.js/0.5.1/morris.min.js'></script>
<style>
@media (min-width: 768px) {
    #wrapper.tt-toggled #side-menu li {
        position: relative;
    }
    #wrapper.tt-toggled #side-menu > li ul {
        position: absolute;
        left: 100%;
        top: 0;
        min-width: 200px;
        display: none;
    }
    #wrapper.tt-toggled #side-menu li:hover > ul,
    #wrapper.tt-toggled #side-menu li:hover > ul.collapse {
        display: block !important;
        height: auto !important;
        z-index: 1000;
        background-color: #f8f8f8;
        visibility: visible;
    }
}

body {
  background-color: #fffbf4; 
}

#wrapper {
  width: 100%;
  margin-top: 70px;
}

#page-wrapper {
  padding: 0 15px;
  min-height: 568px;
}

@media (min-width: 768px) {
  #page-wrapper {
    position: inherit;
    padding: 0 30px;
    border-left: 1px solid #e7e7e7;
  }
}

.huge {
  font-size: 20px;
}
.panel-green {
  border-color: #5cb85c;
}
.panel-green > .panel-heading {
  border-color: #5cb85c;
  color: white;
  background-color: #5cb85c;
}
.panel-green > a {
  color: #5cb85c;
}
.panel-green > a:hover {
  color: #3d8b3d;
}
.panel-red {
  border-color: #d9534f;
}
.panel-red > .panel-heading {
  border-color: #d9534f;
  color: white;
  background-color: #d9534f;
}
.panel-red > a {
  color: #d9534f;
}
.panel-red > a:hover {
  color: #b52b27;
}
.panel-yellow {
  border-color: #f0ad4e;
}
.panel-yellow > .panel-heading {
  border-color: #f0ad4e;
  color: white;
  background-color: #f0ad4e;
}
.panel-yellow > a {
  color: #f0ad4e;
}
.panel-yellow > a:hover {
  color: #df8a13;
}

footer {
    position: fixed;
    bottom: 0;
    width: 100%;
}

</style>
<script>
$(document).ready(function() 
{	
	Morris.Donut
	({
		element: 'newlyUserDonutChart',
	  	data: 
	  		[{
			    label: "신규 가입자",
			    value: Number(${userMonthlyTotalCount})
	  		},
	  		{
			    label: "신규 판매자",
			    value: Number(${sellerMonthlyTotalCount})
	  		}],
	  	resize: true
	});
	
	Morris.Donut
	({
		element: 'userDonutChart',
	  	data: 
	  		[{
			    label: "가입자",
			    value:  Number(${userTotalCount})
	  		},
	  		{
			    label: "판매자",
			    value:  Number(${sellerTotalCount})
	  		}],
	  	resize: true
	});
});
</script>	

</head>
<body>
<%@ include file="/WEB-INF/views/include/adminNavi.jsp" %>
<div id="wrapper" class="active">
  <div id="page-wrapper">
  
    <div class="row">
      <div class="col-lg-12">
        <h1 class="page-header">관리자 페이지</h1>
      </div>
    </div>
    
    <div class="row">
      <div class="col-lg-3 col-md-6">
        <div class="panel panel-primary">
          <div class="panel-heading">
            <div class="row">
              <div class="col-xs-9 text-left">
                <div>레스토랑 총 예약건수</div>
                	<c:choose>
                		<c:when test="${empty restoMonthlyTotalCount}">
                			0건
                		</c:when>
                		<c:otherwise>
                			<div class="huge"><fmt:formatNumber value="${restoTotalCount}" pattern="#,###"/>건</div>
                		</c:otherwise>
                	</c:choose>
              </div>
            </div>
          </div>
        </div>
      </div>
      <div class="col-lg-3 col-md-6">
        <div class="panel panel-green">
          <div class="panel-heading">
            <div class="row">
              <div class="col-xs-9 text-left">
                <div>이번달 레스토랑 예약건수</div>
                <div class="huge">
                	<c:choose>
                		<c:when test="${empty restoMonthlyTotalCount}">
                			0건
                		</c:when>
                		<c:otherwise>
                			<fmt:formatNumber value="${restoMonthlyTotalCount}" pattern="#,###"/>건
                		</c:otherwise>
                	</c:choose>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
      <div class="col-lg-3 col-md-6">
        <div class="panel panel-yellow">
          <div class="panel-heading">
            <div class="row">
              <div class="col-xs-9 text-left">
                <div>선물 총 구매개수</div>
               		<c:choose>
                		<c:when test="${empty giftTotalCount}">
                			0개
                		</c:when>
                		<c:otherwise>
                			<div class="huge"><fmt:formatNumber value="${giftTotalCount}" pattern="#,###"/>개</div>
                		</c:otherwise>
                	</c:choose>
              </div>
            </div>
          </div>
        </div>
      </div>
      <div class="col-lg-3 col-md-6">
        <div class="panel panel-red">
          <div class="panel-heading">
            <div class="row">
              <div class="col-xs-9 text-left">
                <div>이번달 선물 구매개수</div>
                <div class="huge">
					<c:choose>
                		<c:when test="${empty giftMonthlyTotalCount}">
                			0개
                		</c:when>
                		<c:otherwise>
                			<fmt:formatNumber value="${giftMonthlyTotalCount}" pattern="#,###"/>개
                		</c:otherwise>
                	</c:choose>                
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
    <div class="row">
      <div class="col-lg-3 col-md-6">
        <div class="panel panel-primary">
          <div class="panel-heading">
            <div class="row">
              <div class="col-xs-9 text-left">
                <div>레스토랑 총 매출액</div>
                	<c:choose>
                		<c:when test="${empty restoTotalPrice}">
                			0원
                		</c:when>
                		<c:otherwise>
                			<div class="huge"><fmt:formatNumber value="${restoTotalPrice}" pattern="#,###"/>원</div>
                		</c:otherwise>
                	</c:choose>
              </div>
            </div>
          </div>
        </div>
      </div>
      <div class="col-lg-3 col-md-6">
        <div class="panel panel-green">
          <div class="panel-heading">
            <div class="row">
              <div class="col-xs-9 text-left">
                <div>이번달 레스토랑 매출액</div>
                <div class="huge">
                	<c:choose>
                		<c:when test="${empty restoMonthlyTotalCount}">
                			0원
                		</c:when>
                		<c:otherwise>
                			<fmt:formatNumber value="${restoMonthlyTotalPrice}" pattern="#,###"/>원
                		</c:otherwise>
                	</c:choose>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
      <div class="col-lg-3 col-md-6">
        <div class="panel panel-yellow">
          <div class="panel-heading">
            <div class="row">
              <div class="col-xs-9 text-left">
                <div>선물 총 매출액</div>
                <c:choose>
               		<c:when test="${empty giftTotalPrice}">
               			0원
               		</c:when>
               		<c:otherwise>
               			<div class="huge"><fmt:formatNumber value="${giftTotalPrice}" pattern="#,###"/>원</div>
               		</c:otherwise>
                </c:choose>
              </div>
            </div>
          </div>
        </div>
      </div>
      <div class="col-lg-3 col-md-6">
        <div class="panel panel-red">
          <div class="panel-heading">
            <div class="row">
              <div class="col-xs-9 text-left">
                <div>이번달 선물 매출액</div>
                <div class="huge">
                	<c:choose>
                		<c:when test="${empty giftMonthlyTotalCount}">
                			0원
                		</c:when>
                		<c:otherwise>
                			<fmt:formatNumber value="${giftMonthlyTotalPrice}" pattern="#,###"/>원
                		</c:otherwise>
                	</c:choose>    
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>

<div style="width: 100%; justify-content: space-between; display: flex;">
    <div class="panel panel-default" style="width: 48%; display: inline-block; margin: auto; ">
        <div class="panel-heading">
            가입자 동향
        </div>
        <div class="panel-body">
            <div id="userDonutChart"></div>
        </div>
    </div>     
    
    <div class="panel panel-default" style="width: 48%; display: inline-block; margin: auto;">
        <div class="panel-heading">
            이번달 신규 가입자 동향
        </div>
        <div class="panel-body">
            <div id="newlyUserDonutChart"></div>
        </div>
    </div>     
</div>




</div>

<footer style="background-color: black; color: lightgray; text-align: center; margin-top:80px; padding: 30px;">
 <p style="font-size:20px; letter-spacing:5px;">《 Dayiary 》 </p>
    &copy; Copyright Dayiary Corp. All Rights Reserved. <br>
    Always with you 🎉 여러분의 일상을 함께합니다.
</footer>
</body>
</html>