<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/head.jsp"%>
<html lang="ko">
<head>
<meta name="viewport"
	content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/normalize/5.0.0/normalize.min.css">
<style>
@import
	url("https://fonts.googleapis.com/css?family=Quicksand:400,500,700&subset=latin-ext");

html {
	position: relative;
	overflow-x: hidden !important;
}

* {
	box-sizing: border-box;
}

body {
	font-family: "Quicksand", sans-serif;
	color: #324e63;
}

a, a:hover {
	text-decoration: none;
}

.icon {
	display: inline-block;
	width: 1em;
	height: 1em;
	stroke-width: 0;
	stroke: currentColor;
	fill: currentColor;
}

<c:choose>
	<c:when test="${relationalType eq '1'}">
		.wrapper {
			width: 100%;
			width: 100%;
			height: auto;
			min-height: 100vh;
			padding: 50px 20px;
			padding-top: 100px;
			display: flex;
			background-image: linear-gradient(-20deg, #FB929E 0%, #FFDFDF 100%);
			display: flex;
			background-image: linear-gradient(-20deg, #FB929E 0%, #FFDFDF 100%);
		}
	</c:when>
	<c:otherwise>
		.wrapper {
			width: 100%;
			width: 100%;
			height: auto;
			min-height: 100vh;
			padding: 50px 20px;
			padding-top: 100px;
			display: flex;
			background-image: linear-gradient(-20deg, #07689F 0%, #A2D5F2 100%);
			display: flex;
			background-image: linear-gradient(-20deg, #07689F 0%, #A2D5F2 100%);
		}
	</c:otherwise>
</c:choose>

img{
	max-width: 100%;
    height: auto;
}

@media screen and (max-width: 768px) {
	.wrapper {
		height: auto;
		min-height: 100vh;
		padding-top: 100px;
	}
}
	
.profile-card {
	width: 100%;
	min-height: 460px;
	margin: auto;
	box-shadow: 0px 8px 60px -10px rgba(13, 28, 39, 0.6);
	background: #fff;
	border-radius: 12px;
	max-width: 700px;
	position: relative;
}

.profile-card.active .profile-card__cnt {
	filter: blur(6px);
}

.profile-card.active .profile-card-message, .profile-card.active .profile-card__overlay
	{
	opacity: 1;
	pointer-events: auto;
	transition-delay: 0.1s;
}

.profile-card.active .profile-card-form {
	transform: none;
	transition-delay: 0.1s;
}

.profile-card__img {
	width: 150px;
	height: 150px;
	margin-left: auto;
	margin-right: auto;
	transform: translateY(-50%);
	border-radius: 50%;
	overflow: hidden;
	position: relative;
	z-index: 4;
	box-shadow: 0px 5px 50px 0px #6c44fc, 0px 0px 0px 7px
		rgba(107, 74, 255, 0.5);
}

@media screen and (max-width: 576px) {
	.profile-card__img {
		width: 120px;
		height: 120px;
	}
}

.profile-card__img img {
	display: block;
	width: 100%;
	height: 100%;
	object-fit: cover;
	border-radius: 50%;
}

.profile-card__cnt {
	margin-top: -35px;
	text-align: center;
	padding: 0 20px;
	padding-bottom: 40px;
	transition: all 0.3s;
}

.profile-card__name {
	font-weight: 700;
	font-size: 24px;
	color: #6944ff;
	margin-bottom: 15px;
}

.profile-card-loc__icon {
	display: inline-flex;
	font-size: 27px;
	margin-right: 10px;
}

.profile-card-inf {
	display: flex;
	justify-content: center;
	flex-wrap: wrap;
	align-items: flex-start;
	margin-top: 35px;
}

.profile-card-inf__item {
	padding: 10px 35px;
	min-width: 150px;
}

@media screen and (max-width: 768px) {
	.profile-card-inf__item {
		padding: 10px 20px;
		min-width: 120px;
	}
}

.profile-card-inf__title {
	font-weight: 700;
	font-size: 27px;
	color: #324e63;
}

.profile-card-inf__txt {
	font-weight: 500;
	margin-top: 7px;
}

.profile-card-social {
	margin-top: 25px;
	display: flex;
	justify-content: center;
	align-items: center;
	flex-wrap: wrap;
}

.profile-card-social__item {
	position: relative;
	display: inline-block;
	padding: 20px;
	border: 1px solid #ddd;
	background-color: #f9f9f9;
	border-radius: 10px;
	text-align: center;
	cursor: pointer;
}

.profile-card-social__item:hover {
	background-color: #e0e0e0;
}

/* 툴팁 스타일 */
.profile-card-social__item:hover::before {
	content: attr(title);
	position: absolute;
	bottom: 100%;
	left: 50%;
	transform: translateX(-50%);
	padding: 5px;
	background-color: #333;
	color: #fff;
	border-radius: 5px;
	font-size: 12px;
	opacity: 0;
	transition: opacity 0.3s ease;
	white-space: nowrap;
}

.profile-card-social__item:hover::before {
	opacity: 1;
}

@media screen and (max-width: 768px) {
	.profile-card-social__item {
		width: 50px;
		height: 50px;
		margin: 10px;
	}
}

@media screen and (min-width: 768px) {
	.profile-card-social__item:hover {
		transform: scale(1.2);
	}
}

.profile-card-social__item.link {
	background: linear-gradient(45deg, #d5135a, #f05924);
	box-shadow: 0px 4px 30px rgba(223, 45, 70, 0.6);
}

.profile-card-social .icon-font {
	display: inline-flex;
}

.profile-card-ctr {
	display: flex;
	justify-content: center;
	align-items: center;
	margin-top: 40px;
}

@media screen and (max-width: 576px) {
	.profile-card-ctr {
		flex-wrap: wrap;
	}
}

.profile-card__button {
	background: none;
	border: none;
	font-family: "Quicksand", sans-serif;
	font-weight: 700;
	font-size: 19px;
	margin: 15px 35px;
	padding: 15px 40px;
	min-width: 201px;
	border-radius: 50px;
	min-height: 55px;
	color: #fff;
	cursor: pointer;
	backface-visibility: hidden;
	transition: all 0.3s;
}

@media screen and (max-width: 768px) {
	.profile-card__button {
		min-width: 170px;
		margin: 15px 25px;
	}
}

@media screen and (max-width: 576px) {
	.profile-card__button {
		min-width: inherit;
		margin: 0;
		margin-bottom: 16px;
		width: 100%;
		max-width: 300px;
	}
	.profile-card__button:last-child {
		margin-bottom: 0;
	}
}

.profile-card__button:focus {
	outline: none !important;
}

@media screen and (min-width: 768px) {
	.profile-card__button:hover {
		transform: translateY(-5px);
	}
}

.profile-card__button:first-child {
	margin-left: 0;
}

.profile-card__button:last-child {
	margin-right: 0;
}

.profile-card__button.button--blue {
	background: linear-gradient(45deg, #1da1f2, #0e71c8);
	box-shadow: 0px 4px 30px rgba(19, 127, 212, 0.4);
}

.profile-card__button.button--blue:hover {
	box-shadow: 0px 7px 30px rgba(19, 127, 212, 0.75);
}

.profile-card__button.button--orange {
	background: linear-gradient(45deg, #d5135a, #f05924);
	box-shadow: 0px 4px 30px rgba(223, 45, 70, 0.35);
}

.profile-card__button.button--orange:hover {
	box-shadow: 0px 7px 30px rgba(223, 45, 70, 0.75);
}

.profile-card__button.button--gray {
	box-shadow: none;
	background: #dcdcdc;
	color: #142029;
}

.profile-card-message {
	width: 100%;
	height: 100%;
	position: absolute;
	top: 0;
	left: 0;
	padding-top: 130px;
	padding-bottom: 100px;
	opacity: 0;
	pointer-events: none;
	transition: all 0.3s;
}

.profile-card-form {
	box-shadow: 0 4px 30px rgba(15, 22, 56, 0.35);
	max-width: 80%;
	margin-left: auto;
	margin-right: auto;
	height: 100%;
	background: #fff;
	border-radius: 10px;
	padding: 35px;
	transform: scale(0.8);
	position: relative;
	z-index: 3;
	transition: all 0.3s;
}

@media screen and (max-width: 768px) {
	.profile-card-form {
		max-width: 90%;
		height: auto;
	}
}

@media screen and (max-width: 576px) {
	.profile-card-form {
		padding: 20px;
	}
}

.profile-card-form__bottom {
	justify-content: space-between;
	display: flex;
}

@media screen and (max-width: 576px) {
	.profile-card-form__bottom {
		flex-wrap: wrap;
	}
}

.profile-card textarea {
	width: 100%;
	resize: none;
	height: 210px;
	margin-bottom: 20px;
	border: 2px solid #dcdcdc;
	border-radius: 10px;
	padding: 15px 20px;
	color: #324e63;
	font-weight: 500;
	font-family: "Quicksand", sans-serif;
	outline: none;
	transition: all 0.3s;
}

.profile-card textarea:focus {
	outline: none;
	border-color: #8a979e;
}

.profile-card__overlay {
	width: 100%;
	height: 100%;
	position: absolute;
	top: 0;
	left: 0;
	pointer-events: none;
	opacity: 0;
	background: rgba(22, 33, 72, 0.35);
	border-radius: 12px;
	transition: all 0.3s;
}
</style>
</head>
<script type="text/javascript"> 
var status = "${friend.status}";
    
var relationalSeq = "${friend.relationalSeq}";

var relationalType = "${relationalType}"

$(document).ready(function() 
{
	// 리스트 버튼
	$("#friendList").on("click", function() 
	{
		document.friendForm.yourId.value = "";
		document.friendForm.action = "/friend/friendList";
	   	document.friendForm.submit();
   	});
	
	<c:choose> <%-- 왼쪽 버튼 --%>
		<c:when test="${listType eq '1'}"> <%-- 내가 요청 받음 --%>
			<c:choose>
				<c:when test="${friend.status eq 'N'}"> <%-- 아직 수락하지 않았을 떄 --%>
					<c:choose>
						<c:when test="${friend.relationalType eq '1'}"> <%-- 받은 요청이 연인일 경우 --%>
							$("#acceptCouple").on("click", function() 
							{
								confirmAction("${friend.userNickName}님에게 온 연인 신청을 수락하시겠습니까?", "/friend/acceptCouple");
	                        });
						</c:when>
						<c:otherwise> <%-- 받은 요청이 친구일 경우 --%>
							$("#acceptFriend").on("click", function() 
							{
								confirmAction("${friend.userNickName}님에게 온 친구 신청을 수락하시겠습니까?", "/friend/acceptFriend");
	                        });
						</c:otherwise>
					</c:choose>
				</c:when>
				<c:otherwise> <%-- 친구 상태이거나 아직 아무 사이도 아닐 떄 --%>
					var $messageBox = $('.js-message');
					var $btn = $('.js-message-btn');
					var $card = $('.js-profile-card');
					var $closeBtn = $('.js-message-close');
					
					$btn.on('click', function(e)
					{
					    e.preventDefault();
					    $card.addClass('active'); 
					});
			
					$("#sendPost").on("click", function() 
					{
					    if($("#msgContent").val().trim().length <= 0)
					    {
					        alert("보낼 쪽지 내용을 입력해 주세요.");
					        return;
					    }
					    
					    var formData =
					    {
					        yourId:$("input[name='yourId']").val(),
					        msgContent:$("#msgContent").val()
					    };
					    
					    fn_ajax("/msg/sendMsg", formData);
					});
					
					$closeBtn.each(function(index, element)
					{
						var $element = $(element);
					    $element.on('click', function(e) 
					    {
					    	e.preventDefault();
			
					    	$("#canclePost").on("click", function() 
					    	{
					       		$card.removeClass('active'); 
					       	});
					    });
					});	
				</c:otherwise>
			</c:choose>
		</c:when>
		<c:otherwise>  <%-- 받은 요청 왜의 모든 타입 리스트에서 들어올 경우 --%>
			var $messageBox = $('.js-message');
			var $btn = $('.js-message-btn');
			var $card = $('.js-profile-card');
			var $closeBtn = $('.js-message-close');
			
			$btn.on('click', function(e)
			{
			    e.preventDefault();
			    $card.addClass('active'); 
			});
	
			$("#sendPost").on("click", function() 
			{
			    if($("#msgContent").val().trim().length <= 0)
			    {
			        alert("보낼 쪽지 내용을 입력해 주세요.");
			        return;
			    }
			    
			    var formData =
			    {
			        yourId:$("input[name='yourId']").val(),
			        msgContent:$("#msgContent").val()
			    };
			    
			    fn_ajax("/msg/sendMsg", formData);
			});
			
			$closeBtn.each(function(index, element)
			{
				var $element = $(element);
			    $element.on('click', function(e) 
			    {
			    	e.preventDefault();
	
			    	$("#canclePost").on("click", function() 
			    	{
			       		$card.removeClass('active'); 
			       	});
			    });
			});	
		</c:otherwise>
	</c:choose>
	
	<c:choose> <%-- 오른쪽 버튼 --%>
		<c:when test="${friend.relationalType eq '1'}"> <%-- 친구 관계가 연인일 경우 --%>
			<c:choose>
				<c:when test="${listType eq '1'}"> <%-- 내가 요청 받음 --%>
					$("#refuseCouple").on("click", function() 
					{
						confirmAction("${friend.userNickName}님에게 온 연인 신청을 거절하시겠습니까?", "/friend/refuseCouple");
	                });
				</c:when>
				<c:when test="${listType eq '2'}"> <%-- 상대가 요청 보냄 --%>
					$("#cancleCouple").on("click", function() 
					{
	                    confirmAction("${friend.userNickName}님에게 보낸 연인 요청을 취소하시겠습니까?", "/friend/cancleCouple");
	                });
				</c:when>
				<c:otherwise>
					<c:choose>
						<c:when test="${friend.status eq 'Y'}"> <%-- 연인 상태 일 경우 --%>
							$("#deleteCouple").on("click", function() 
							{
			                    confirmAction("연인을 끊으시겠습니까?", "/friend/deleteCouple");
			                });
						</c:when>
						<c:otherwise> <%-- 리스트 타입이 0일 때 들어와서 연인 신청을 하고 난 뒤 --%>
							$("#cancleCouple").on("click", function() 
							{
			                    confirmAction("${friend.userNickName}님에게 보낸 연인 요청을 취소하시겠습니까?", "/friend/cancleCouple");
			                });
						</c:otherwise>
					</c:choose>	
				
				
				</c:otherwise>
			</c:choose>
		</c:when>
		<c:when test="${friend.relationalType eq '0'}"> <%-- 친구 관계가 친구일 경우 --%>
			<c:choose>
				<c:when test="${listType eq '1'}"> <%-- 내가 요청 받음 --%>
					$("#refuseFriend").on("click", function() 
					{
						confirmAction("${friend.userNickName}님에게 온 친구 신청을 거절하시겠습니까?", "/friend/refuseFriend");
	                });
				</c:when>
				<c:when test="${listType eq '2'}"> <%-- 상대가 요청 보냄 --%>
					$("#cancleFriend").on("click", function() 
					{
	                	confirmAction("${friend.userNickName}님에게 보낸 친구 요청을 취소하시겠습니까?", "/friend/cancleFriend");
	                });						
	            </c:when>
	            <c:when test="${listType eq '0'}">
	            	$("#cancleFriend").on("click", function() 
					{
	                	confirmAction("${friend.userNickName}님에게 보낸 친구 요청을 취소하시겠습니까?", "/friend/cancleFriend");
	                });	
	            </c:when>
				<c:otherwise> <%-- 내 친구 목록에서 즉 친구 상태 --%>
					<c:choose>
						<c:when test="${relationalType eq '1'}"> <%-- 내 친구 목록을 연인신청 타입으로 들어왔을 경우 --%>
							$("#requestCouple").on("click", function() 
							{
								requestCoupleAction("${friend.userNickName}님에게 연인 신청하시겠습니까?", "/friend/requestCouple", "1");
	                        });
						</c:when>
						<c:otherwise>
							$("#deleteFriend").on("click", function() 
							{
	                            confirmAction("친구를 끊으시겠습니까?", "/friend/deleteFriend");
	                        });
						</c:otherwise>
					</c:choose>
				</c:otherwise>
			</c:choose>
		</c:when>
		<c:otherwise> <%-- 친구 요청을 아직 안보냈을 경우 --%>
			<c:choose>
				<c:when test="${relationalType eq '1'}"> <%-- 요청 타입이 연인일 경우 --%>
					$("#requestCouple").on("click", function() 
					{
						requestCoupleAction("${friend.userNickName}님에게 연인 신청하시겠습니까?", "/friend/requestCouple", "0");
	                });
				</c:when>
				<c:otherwise>  <%-- 요청 타입이 친구일 경우 --%>
					$("#requestFriend").on("click", function() 
					{
	                    confirmAction("${friend.userNickName}님에게 친구 신청하시겠습니까?", "/friend/requestFriend");
	                });
				</c:otherwise>
			</c:choose>
		</c:otherwise>
	</c:choose>
});

function fn_ajax(url, data)
{
	$.ajax
    ({
        type:"POST",
        url:url,
        data:data,
        success: function(response)
        {
        	if(response.code == 0)
        	{
        		alert(response.data);
        		document.friendForm.action = "/friend/yourPage";
        	   	document.friendForm.submit();
        	}
        	else if(response.code == 500)
        	{
        		alert(response.data);
        	}
        	else if(response.code == 400)
        	{
        		alert(response.data);
        		document.friendForm.action = "/friend/friendList";
        	   	document.friendForm.submit();
        	}
        	else if(response.code == 404)
        	{
        		alert(response.data);
        		document.friendForm.action = "/friend/friendList";
        	   	document.friendForm.submit();
        	}
        	else if(response.code == 100)
        	{
        		alert(response.data);
        		document.friendForm.action = "/friend/friendList";
        	   	document.friendForm.submit();
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

function confirmAction(confirmMsg, actionUrl) 
{
    if(confirm(confirmMsg)) 
    {
        var formData = 
        {
            yourId: $("input[name='yourId']").val(),
            status: status,
            relationalSeq: relationalSeq
        };
        fn_ajax(actionUrl, formData);
    }
    return;
}

<c:if test="${relationalType eq '1'}">
	function requestCoupleAction(confirmMsg, actionUrl, checkFri) 
	{
	    if(confirm(confirmMsg)) 
	    {
	        var userInput = prompt("사귄 날짜를 숫자 8자리로 입력해 주세요.");
	        var numberPattern = /^\d{8}$/;
	
	        if(numberPattern.test(userInput)) 
	        {
	            var dateStr = "";
	            var todayDate = new Date();
	            dateStr = userInput.substr(0, 4);
	            dateStr = dateStr + "-" + userInput.substr(4, 2);
	            dateStr = dateStr + "-" + userInput.substr(6, 2);
	            var inputDate = new Date(dateStr);
	            if (inputDate <= todayDate) 
	            {
	                var after100 = dateToString(new Date(new Date(dateStr).setDate(inputDate.getDate() + 100)));
	                var after200 = dateToString(new Date(new Date(dateStr).setDate(inputDate.getDate() + 200)));
	                var after300 = dateToString(new Date(new Date(dateStr).setDate(inputDate.getDate() + 300)));
	                var formData = 
	                {
	                    yourId: $("input[name='yourId']").val(),
	                    status: status,
	                    relationalSeq: relationalSeq,
	                    relationalType: relationalType,
	                    checkFri: checkFri,
	                    startDate: userInput,
	                    after100: after100,
	                    after200: after200,
	                    after300: after300
	                };
	                fn_ajax(actionUrl, formData);
	            }
	            else 
	            {
	                alert("오늘 이후 날짜는 입력하실 수 없습니다.");
	                return;
	            }
	        }
	        else 
	        {
	            alert("사귄 날짜를 숫자 8자리로 입력해 주세요.");
	            return;
	        }
	    }
	}
	
	function dateToString(dateData)
	{
	    var date = dateData;
	    var year = date.getFullYear();
	    var month = ("0" + (1 + date.getMonth())).slice(-2);
	    var day = ("0" + date.getDate()).slice(-2);

	    return year + month + day;
	}
</c:if>
</script>
<body>
<%@ include file="/WEB-INF/views/include/navigation.jsp"%>
	<div class="wrapper">
		<div class="profile-card js-profile-card">
			<div class="profile-card__img">
				<img src="${friend.fileName}" alt="profile card">
			</div>
			<div class="profile-card__cnt js-profile-cnt">
				<div class="profile-card__name">${friend.userNickName}</div>
			</div>
			<div class="profile-card-inf">
				<div class="profile-card-inf__item">
					<div class="profile-card-inf__title">${friend.friendCnt}</div>
					<div class="profile-card-inf__txt">친구 수</div>
				</div>
				<div class="profile-card-inf__item">
					<div class="profile-card-inf__title">${friend.diaryCnt}</div>
					<div class="profile-card-inf__txt">다이어리 수</div>
				</div>
			</div>
			<div class="profile-card-social" id="friendList">
				<a class="profile-card-social__item link" title="리스트로 이동">
					<span class="icon-font"> 
						<img src="/resources/images/fList.png" style="width: 30px; height: 30px;">
					</span>
				</a>
			</div>
			<div class="profile-card-ctr">
			
				<c:choose><%-- 왼쪽 버튼 --%>
					<c:when test="${listType eq '1'}"> <%-- 내가 요청 받음 --%>
						<c:choose>
							<c:when test="${friend.status eq 'N'}"> <%-- 아직 수락하지 않았을 떄 --%>
								<c:choose>
									<c:when test="${friend.relationalType eq '1'}"> <%-- 받은 요청이 연인일 경우 --%>
										<button class="profile-card__button button--blue" id="acceptCouple">연인 수락</button>
									</c:when>
									<c:otherwise> <%-- 받은 요청이 친구일 경우 --%>
										<button class="profile-card__button button--blue" id="acceptFriend">친구 수락</button>
									</c:otherwise>
								</c:choose>
							</c:when>
							<c:otherwise> <%-- 친구 상태이거나 아직 아무 사이도 아닐 떄 --%>
								<button class="profile-card__button button--blue js-message-btn" >쪽지 보내기</button>
							</c:otherwise>
						</c:choose>
					</c:when>
					<c:otherwise> <%-- 받은 요청 왜의 모든 타입 리스트에서 들어올 경우 --%>
						<button class="profile-card__button button--blue js-message-btn">쪽지 보내기</button>
					</c:otherwise>
				</c:choose>
				
				<c:choose> <%-- 오른쪽 버튼 --%>
					<c:when test="${friend.relationalType eq '1'}"> <%-- 친구 관계가 연인일 경우 --%>
						<c:choose>
							<c:when test="${listType eq '1'}"> <%-- 내가 요청 받음 --%>
								<button class="profile-card__button button--orange" id="refuseCouple">연인 거절</button>
							</c:when>
							<c:when test="${listType eq '2'}"> <%-- 상대가 요청 보냄 --%>
								<button class="profile-card__button button--orange" id="cancleCouple">요청 취소</button>
							</c:when>
							<c:otherwise> 
								<c:choose>
									<c:when test="${friend.status eq 'Y'}"> <%-- 연인 상태 일 경우 --%>
										<button class="profile-card__button button--orange" id="deleteCouple">연인 끊기</button>
									</c:when>
									<c:otherwise> <%-- 리스트 타입이 0일 때 들어와서 연인 신청을 하고 난 뒤 --%>
										<button class="profile-card__button button--orange" id="cancleCouple">요청 취소</button>
									</c:otherwise>
								</c:choose>
							</c:otherwise>
						</c:choose>
					</c:when>
					<c:when test="${friend.relationalType eq '0'}"> <%-- 친구 관계가 친구일 경우 --%>
						<c:choose>
							<c:when test="${listType eq '1'}"> <%-- 내가 요청 받음 --%>
								<button class="profile-card__button button--orange" id="refuseFriend">친구 거절</button>
							</c:when>
							<c:when test="${listType eq '2'}"> <%-- 상대가 요청 보냄 --%>
				                <button class="profile-card__button button--orange" id="cancleFriend">요청 취소</button>							
				            </c:when>
				            <c:when test="${listType eq '0'}">
				                <button class="profile-card__button button--orange" id="cancleFriend">요청 취소</button>	
				            </c:when>
							<c:otherwise> <%-- 내 친구 목록에서 즉 친구 상태 --%>
								<c:choose>
									<c:when test="${relationalType eq '1'}"> <%-- 내 친구 목록을 연인신청 타입으로 들어왔을 경우 --%>
										<button class="profile-card__button button--orange" id="requestCouple">연인 신청</button>
									</c:when>
									<c:otherwise>
										<button class="profile-card__button button--orange" id="deleteFriend">친구 끊기</button>
									</c:otherwise>
								</c:choose>
							</c:otherwise>
						</c:choose>
					</c:when>
					<c:otherwise> <%-- 친구 요청을 아직 안보냈을 경우 --%>
						<c:choose>
							<c:when test="${relationalType eq '1'}"> <%-- 요청 타입이 연인일 경우 --%>
								<button class="profile-card__button button--orange" id="requestCouple">연인 신청</button>
							</c:when>
							<c:otherwise>  <%-- 요청 타입이 친구일 경우 --%>
								<button class="profile-card__button button--orange" id="requestFriend">친구 신청</button>
							</c:otherwise>
						</c:choose>
					</c:otherwise>
				</c:choose>
				
			</div>
			<div class="profile-card-message js-message">
		    	<form class="profile-card-form">
		        	<div class="profile-card-form__container">
		        		<textarea placeholder="메세지를 입력하세요." id="msgContent"></textarea>
		        	</div>	
		        	<div class="profile-card-form__bottom">
		          		<button class="profile-card__button button--blue js-message-close" id="sendPost">
		            		보내기
		          		</button>
			          	<button class="profile-card__button button--gray js-message-close" id="canclePost">
			            	취소
			          	</button>
		        	</div>
		      </form>
		      <div class="profile-card__overlay js-message-close"></div>	
		    </div>
		</div>
	</div>
	<form name="friendForm" id="friendForm" method="post">
   		<input type="hidden" name="listType" value="${listType}" />
	    <input type="hidden" name="relationalType" value="${relationalType}" />
      	<input type="hidden" name="yourId" value="${friend.userId}" />
      	<input type="hidden" name="searchType" value="${searchType}" />
      	<input type="hidden" name="searchValue" value="${searchValue}" />
    	<input type="hidden" name="curPage" value="${curPage}" />
   	</form>
</body>
</html>
