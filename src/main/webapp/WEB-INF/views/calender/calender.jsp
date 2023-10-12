<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/views/include/head.jsp"%>
<style>
@font-face {
    font-family: 'KBO-Dia-Gothic_bold';
    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2304-2@1.0/KBO-Dia-Gothic_bold.woff') format('woff');
    font-weight: 700;
    font-style: normal;
}

*{
   box-sizing: border-box;
   margin: 0;
   padding: 0;
}

body {
  font-family: 'SUIT-Regular', sans-serif;
  background-color: #fffbf4 !important;
}

ul{
   list-style-type: none;
   text-align: center;
   font-family: Verdana, sans-serif;
   margin: 0px;
}

p{
   margin: 0px;
   font-size: 15px;
   overflow: hidden; /* 넘어가는 내용을 숨김 */
}

li:not(:first-child){
   cursor: pointer;
}

.calender{
   width: 60%;
   margin: auto;
   border-radius: 8px;
   box-shadow: 2px 2px 28px rgba(0,0,0,.5);
}

.calender .month{
   padding: 40px;
   color: black;
   width: 100%;
   position: relative;
   letter-spacing: 4px;
}

.calender .month .next,.calender .month .prev{
   position: absolute;
   top: calc(50% - 15px);
   cursor: pointer;
   padding: 5px;
   display: block;
}

.calender .month .prev{
   left: 10px;
}

.calender .month .next{
   right: 10px;
}

.calender .month .next:hover,.calender .month .prev:hover{
   background-color: rgba(0,0,0,.2);
}

.calender .weeks{
   display: flex;
}

.calender .weeks li{
   background-color: #bdc3c7;
   flex: 1;
   opacity: .5;
   position: relative;
   animation: motion 2s;
   padding: 10px; 
}

.calender .weeks li:hover{
   background-color: rgba(0,0,0,.2);
}

.calender .days {
   display: flex;
   flex-wrap: wrap;
}

.calender .days li{
   flex-basis: calc(100% / 7);
   padding: 10px 0;
   background-color: white;
}

.calender .days li:hover{
   background-color: rgba(0,0,0,.3);
}        


<c:choose>
   <c:when test="${!empty userId}">
      input[type=button] { 
         border: none;
         border-radius: 10px;
      }   
   </c:when>
   <c:otherwise>
      input[type=button] { 
         border: none;
         display : none;
         border-radius: 10px;
      }   
   </c:otherwise>
</c:choose>
   


.scheduler {
        background-color: #fff;
        border-radius: 8px;
        padding: 20px;
        box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        width: 300px;
        display: none;
        position: absolute;
        top: -10%;
        right: 0%;
        transform: translate(-50%, 50%);
    }

    .scheduler input[type="text"],
    .scheduler textarea,
    .scheduler input[type="date"],
    .scheduler input[type="time"] {
        width: 100%;
        padding: 10px;
        border: 1px solid #ccc;
        border-radius: 4px;
        margin-bottom: 10px;
    }

   .btnClass
   {
      width: 100%;
   }   
    .scheduler input[type="button"] {
        background-color: #007bff;
        color: #fff;
        border: none;
        border-radius: 4px;
        padding: 10px 20px;
        cursor: pointer;
        width: 47%;
    }

    .scheduler input[type="button"]:hover {
        background-color: #0056b3;
    }

    .scheduler input[type="button"][value="취소"] {
        background-color: #ccc;
        margin-left: 10px;
    }

    .scheduler input[type="button"][value="취소"]:hover {
        background-color: #999;
    }
    
.detailContainer {
    margin-top: 30px;
    display: flex;
    flex-direction: column;
    align-items: stretch;
    border: 1px solid #ccc;
    padding: 10px;
    width: 100%;
}

.header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 20px;
}

.title {
    display: inline-block;
    white-space: nowrap;
    margin-right: 20px;
}

.buttons {
    display: flex;
    justify-content: flex-end;
    align-items: center;
}

.buttons input {
    white-space: nowrap;
    margin-left: 10px;
}

.content {
    width: 100%;
    white-space: normal;
    word-wrap: break-word;
    border: 1px solid #ccc;
    padding: 10px;
}


.shareAnniversary { 
   background-color: #ffffff; 
   padding: 20px; 
   border-radius: 8px; 
   box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1); 
   width: 350px; 
   max-height: 550px; 
   overflow-y: auto; 
   display: none;
   position: absolute; /* 위치를 absolute로 설정 */
   top: 0; /* 상단에 위치 */
   right: 200%; /* 오른쪽 끝에 붙이기 */
   margin-top: -10px; /* 상단으로 약간 위로 조정 */
}
    .shareAnniversary h3 {
        font-size: 18px;
        margin-bottom: 20px;
        position: sticky;
        top: 0;
        background-color: #ffffff;
        padding: 10px 0;
    }

    .shareScroll {
        max-height: 350px;
        overflow-y: auto;
        animation: bounce-reverse 0.5s ease-in-out infinite;
      animation-play-state: paused;
    }

    .shareFriend {
        display: flex;
        align-items: center;
        margin-bottom: 10px;
        padding: 10px;
    }

    .shareFriend:hover {
        background-color: #f4f4f4;
    }

    .shareFriend img {
        width: 40px;
        height: 40px;
        border-radius: 50%;
        margin-right: 10px;
        object-fit: cover;
    }

    .shareFriendName {
        font-size: 16px;
    }

    .shareAnniversary input[type="button"] {
        background-color: #007bff;
        color: #fff;
        border: none;
        border-radius: 4px;
        padding: 10px 20px;
        cursor: pointer;
        width: 100%;
        margin-top: 20px;
    }

    .shareAnniversary input[type="button"]:hover {
        background-color: #0056b3;
    }

    /* 스크롤바 디자인 */
    .shareScroll::-webkit-scrollbar {
        width: 10px;
    }

    .shareScroll::-webkit-scrollbar-track {
        background: #f1f1f1;
    }

    .shareScroll::-webkit-scrollbar-thumb {
        background: #888;
        border-radius: 5px;
    }

    .shareScroll::-webkit-scrollbar-thumb:hover {
        background: #555;
    }
.icon {
    transition: transform 0.3s ease; /* 회전 애니메이션 속성 설정 */
}
    
</style>
<script>
$(document).ready(function() 
{   
      let day = ${day};

    let content = [<c:forEach var="i" items="${content}" varStatus="status">'${i}',</c:forEach>];

   let contentToTag = "";
      
   let date = new Date("${year}-${month}"); 
   
    var calender = document.querySelector(".calender"),//container of calender
        topDiv = document.querySelector('.month'),
        monthDiv = calender.querySelector("h1"),//h1 of monthes
        yearDiv = calender.querySelector('h2'),//h2 for years
        weekDiv = calender.querySelector(".weeks"),//week container
        dayNames = weekDiv.querySelectorAll("li"),//dayes name
        dayItems = calender.querySelector(".days"),//date of day container
        prev = calender.querySelector(".prev"),
        next = calender.querySelector(".next"),
        calAddBtn = calender.querySelector(".calAddBtn"),
        years = date.getFullYear(),
        monthes = date.getMonth(),
        lastDayOfMonth = new Date(${year}, ${month}, 0).getDate(),
        dayOfFirstDateOfMonth = date.getDay(),
        //colors = ['#FFA549', '#ABABAB', '#1DABB8', '#953163', '#E7DF86', '#E01931', '#92F22A', '#FEC606', '#563D28', '#9E58DC', '#48AD01', '#0EBB9F'],
        colors = ['/resources/images/spring.png', '/resources/images/summer.png', '/resources/images/autumn.png', '/resources/images/winter.png'],
        i,//counter for day before month first day in week
        counter;//counter for day of month  days;
        monthDiv.style.fontFamily = 'KBO-Dia-Gothic_bold';
        monthDiv.style.fontSize = '45px';

    function days()   
    {
       yearDiv.innerHTML = years;
        monthDiv.innerHTML = (monthes + 1) + "월";
        monthDiv.style.fontFamily = 'KBO-Dia-Gothic_bold';
        monthDiv.style.fontSize = '45px';
       
        for (i = 0; i < dayOfFirstDateOfMonth; i++) 
        {
            dayItems.innerHTML += "<li style='height: 160px;'> - </li>";
        }
        
        for (counter = 1; counter <= lastDayOfMonth; counter++) 
        {
            for(i = 0; i < day.length; i++)
            {
               if(day[i] == counter)
               {
                  contentToTag = contentToTag + "<p>" + content[i] + "</p>";
               }
            }

            <c:choose>
               <c:when test="${!empty userId}">
                  dayItems.innerHTML += "<li style='height: 160px; overflow: hidden;' onclick='fn_detailView(" + counter + ")'>" + (counter) + contentToTag + "</li>";  
               </c:when>
               <c:otherwise>
                  dayItems.innerHTML += "<li style='height: 160px; overflow: hidden;'>" + (counter) + contentToTag + "</li>";
               </c:otherwise>
            </c:choose>
            
            contentToTag = "";

        }
        
        //topDiv.style.background = colors[monthes];
        topDiv.style.backgroundImage = 'url("/resources/images/spring.png")';
        dayItems.style.background = 'lightgray';
        calAddBtn.style.color = colors[monthes];
        if (monthes === new Date().getMonth() && years === new Date().getFullYear()) 
        {
            dayItems.children[new Date().getDate() + dayOfFirstDateOfMonth - 1].style.background = "#e7f2ff";
        }
    }
    
    prev.onclick = function () 
    {
        'use strict';
        moveDate(-1);//decrement monthes
    };
    next.onclick = function () 
    {
        'use strict';
        moveDate(1);//increment monthes
    };
    
    if($("#weatherImg").attr("src") === "") 
    {
       $("#weatherImg").hide();
    }
    
    days();
    
    fn_getWeather();
    
    fn_getMoon(years);
    
    $("#dateEvent").on('change', function() 
    {
       const inputYear = $('input[name="year"]');
       const inputMonth = $('input[name="month"]');
       let moveDate = new Date($(this).val());
       inputYear.val(moveDate.getFullYear());
       inputMonth.val((moveDate.getMonth() + 1) < 10 ? "0" + (moveDate.getMonth() + 1) : moveDate.getMonth() + 1);
      document.calenderForm.action = "/calender/calender";
         document.calenderForm.submit();   
    });
    
    $("#addCal").on("click", function() 
    {
        $(".scheduler").fadeToggle(); // 요소를 나타나게 함
    });

    $("#cancleAdd").on("click", function() 
    {
        $(".scheduler").fadeOut(); // 요소를 사라지게 함
    });
    
    $("#closeList").on("click", function()
    {   
       $(".shareAnniversary").fadeOut();
    });
  
    $("#requestAdd").on("click", function() 
    {
      $(this).prop("disabled", true);
       let calTitle = $("#calTitle");
       let calContent = $("#calContent");
       let calDate = $("#calDate");
       let calTime = $("#calTime");
       
       if(calTitle.val().trim().length <= 0)
       {
          alert("일정 제목을 입력하세요.");
          calTitle.focus();
          $(this).prop("disabled", false);
          return;
       }
       
       if(calContent.val().trim().length <= 0)
       {
          alert("일정 내용을 입력하세요.");
          calContent.focus();
          $(this).prop("disabled", false);
          return;
       }
       
       if(calDate.val() == null || calDate.val() == "")
       {
          alert("날짜를 선택하세요.");
          calDate.focus();
          $(this).prop("disabled", false);
          return;
       }
       
       if(calTime.val() == null || calTime.val() == "")
       {
          if(!confirm("시간을 지정하지 않고 일정을 등록하시겠습니까?"))
          {
             alert("시간을 선택해주세요.");   
              calTime.focus();
              $(this).prop("disabled", false);
              return;
          }
       }
       
      let addDate = new Date(calDate.val());
              
       let formData = 
        {
          calTitle: calTitle.val(),
          calContent: calContent.val(),
            year: addDate.getFullYear(),
            month: (addDate.getMonth() + 1) < 10 ? "0" + (addDate.getMonth() + 1) : addDate.getMonth() + 1,
            day: (addDate.getDate()) < 10 ? "0" + (addDate.getDate()) : addDate.getDate(),
            calTime: calTime.val().replace(":", "")
        };
       
       fn_ajax("/anniversary/addAnniversary", formData);
       
    });
       
  
});

function moveDate(num)
{
   const inputYear = $('input[name="year"]');
   
   const inputMonth = $('input[name="month"]');
   
   inputMonth.val(Number(inputMonth.val()) + num);
   
   if(inputMonth.val() > 12)
   {
      inputYear.val(Number(inputYear.val()) + 1);
      inputMonth.val("01");
   }
   
   if(inputMonth.val() < 1)
   {
      inputYear.val(Number(inputYear.val()) - 1);
      inputMonth.val("12");
   }
   
   if(inputMonth.val().length == 1)
   {
      inputMonth.val("0" + inputMonth.val());
   }
   document.calenderForm.action = "/calender/calender";
      document.calenderForm.submit();   
}

function fn_getWeather()
{
   $.ajax
       ({
           type:"POST",
           url:"/calender/weather",
           success: function(response)
           {
              if(response.code == 0)
              {
                 let weather = response.data;
                 if(weather != null)
                 {
                  $("#weatherDetail").text(weather.geoLocation.gu + " " + weather.temperature +"℃"); // api 때문에 주석 나중에 풀어야함 
                  //$("#weatherDetail").text(weather.temperature +"℃");
                  
                  let hour = new Date().getHours();
                  if(hour < 5 || hour > 18)
                  {
                     if(weather.precipitationType == 1)
                     {
                            $("#weatherImg").attr("src", "/resources/images/rain.png");
                     }
                     else if(weather.precipitationType == 2)
                     {
                            $("#weatherImg").attr("src", "/resources/images/snowrain.png");
                     }
                     else if(weather.precipitationType == 3)
                     {
                            $("#weatherImg").attr("src", "/resources/images/snow.png");
                     }
                     else if(weather.precipitationType == 5)
                     {
                            $("#weatherImg").attr("src", "/resources/images/rain.png");
                     }
                     else if(weather.precipitationType == 6)
                     {
                            $("#weatherImg").attr("src", "/resources/images/rain.png");
                     }
                     else if(weather.precipitationType == 7)
                     {
                            $("#weatherImg").attr("src", "/resources/images/snowrain.png");
                     }
                     else
                     {
                            $("#weatherImg").attr("src", "/resources/images/moon.png");
                     }
                  }
                  else
                  {
                     if(weather.precipitationType == 1)
                     {
                            $("#weatherImg").attr("src", "/resources/images/rain.png");
                     }
                     else if(weather.precipitationType == 2)
                     {
                            $("#weatherImg").attr("src", "/resources/images/snowrain.png");
                     }
                     else if(weather.precipitationType == 3)
                     {
                            $("#weatherImg").attr("src", "/resources/images/snow.png");
                     }
                     else if(weather.precipitationType == 5)
                     {
                            $("#weatherImg").attr("src", "/resources/images/rain.png");
                     }
                     else if(weather.precipitationType == 6)
                     {
                            $("#weatherImg").attr("src", "/resources/images/rain.png");
                     }
                     else if(weather.precipitationType == 7)
                     {
                            $("#weatherImg").attr("src", "/resources/images/snowrain.png");
                     }
                     else
                     {
                            $("#weatherImg").attr("src", "/resources/images/sun.png");
                     }
                  }
                  $("#weatherImg").show();
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

function fn_getMoon(year)
{
   let formData = 
    {
         year: year
    };
   
   $.ajax
       ({
           type:"POST",
           url:"/calender/moon",
           data:formData,
           success: function(response)
           {
              
           },
           error: function(xhr, status, error) 
           {
               console.log(error);
           }
       });  
}

<c:if test="${!empty userId}">
   function fn_deleteAnniversary(anniversarySeq)
   {
      if (anniversarySeq > 0) 
       {
           let formData = 
           {
              anniversarySeq: anniversarySeq
           };
           if(confirm("해당 일정을 삭제하시겠습니까?"))
           {
               $.ajax
              ({
                  type:"POST",
                  url:"/anniversary/deleteAnniversary",
                  data:formData,
                  success: function(response)
                  {
                     if(response.code == 0)
                     {
                        alert(response.data);
                        document.calenderForm.action = "/calender/calender";
                           document.calenderForm.submit();
                     }
                     else if(response.code == 500)
                     {
                        alert(response.data);
                     }
                     else if(response.code == 400)
                     {
                        alert(response.data);
                        document.calenderForm.action = "/calender/calender";
                           document.calenderForm.submit();
                     }
                     else if(response.code == 404)
                     {
                        alert(response.data);
                        document.calenderForm.action = "/calender/calender";
                           document.calenderForm.submit();
                     }
                     else if(response.code == 100)
                     {
                        alert(response.data);
                        document.calenderForm.action = "/calender/calender";
                           document.calenderForm.submit();
                     }
                     else   
                     {
                        alert("알 수 없는 오류가 발생하였습니다.");
                        document.calenderForm.action = "/calender/calender";
                           document.calenderForm.submit();
                     }
                  },
                  error: function(xhr, status, error) 
                  {
                      console.log(error);
                  }
              });  
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
   
   function fn_refuseShared(anniversarySeq, nickName, yourId)
   {
      if (anniversarySeq > 0) 
       {
           let formData = 
           {
              anniversarySeq: anniversarySeq,
              yourId: yourId
           };
           if(confirm(nickName + "님이 공유한 일정을 삭제하시겠습니까?"))
           {
               $.ajax
              ({
                  type:"POST",
                  url:"/anniversary/refuseShared",
                  data:formData,
                  success: function(response)
                  {
                     if(response.code == 0)
                     {
                        alert(response.data);
                        document.calenderForm.action = "/calender/calender";
                           document.calenderForm.submit();
                     }
                     else if(response.code == 500)
                     {
                        alert(response.data);
                     }
                     else if(response.code == 400)
                     {
                        alert(response.data);
                        document.calenderForm.action = "/calender/calender";
                           document.calenderForm.submit();
                     }
                     else if(response.code == 404)
                     {
                        alert(response.data);
                        document.calenderForm.action = "/calender/calender";
                           document.calenderForm.submit();
                     }
                     else if(response.code == 100)
                     {
                        alert(response.data);
                        document.calenderForm.action = "/calender/calender";
                           document.calenderForm.submit();
                     }
                     else   
                     {
                        alert("알 수 없는 오류가 발생하였습니다.");
                        document.calenderForm.action = "/calender/calender";
                           document.calenderForm.submit();
                     }
                  },
                  error: function(xhr, status, error) 
                  {
                      console.log(error);
                  }
              });  
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
   
   function fn_ajax(url, data)
   {
      const inputYear = $('input[name="year"]');
      
      const inputMonth = $('input[name="month"]');
      
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
                   $(".scheduler").fadeOut(); // 요소를 사라지게 함
                 if(confirm("일정 등록하신 날짜로 이동하시겠습니까?"))
                 {
                    inputYear.val(data.year);
                    inputMonth.val(data.month);
                 }
                 document.calenderForm.action = "/calender/calender";
                    document.calenderForm.submit();
              }
              else if(response.code == 500)
              {
                 alert(response.data);
                 $(this).prop("disabled", false);
              }
              else if(response.code == 400)
              {
                 alert(response.data);
                 document.calenderForm.action = "/calender/calender";
                    document.calenderForm.submit();
              }
              else if(response.code == 404)
              {
                 alert(response.data);
                 document.calenderForm.action = "/calender/calender";
                    document.calenderForm.submit();
              }
              else if(response.code == 100)
              {
                 alert(response.data);
                 document.calenderForm.action = "/calender/calender";
                    document.calenderForm.submit();
              }
              else   
              {
                 alert("알 수 없는 오류가 발생하였습니다.");
                 document.calenderForm.action = "/calender/calender";
                    document.calenderForm.submit();
              }
           },
           error: function(xhr, status, error) 
           {
               console.log(error);
           }
       });      
   }

   function fn_detailView(day)
   {
      const inputYear = $('input[name="year"]');
      
      const inputMonth = $('input[name="month"]');

      $(".shareAnniversary").fadeOut();
      
      let checkDate = new Date(inputYear.val() + "-" + inputMonth.val());
      let lastDay = new Date(new Date(inputYear.val(), inputMonth.val(), 0)).getDate();
      let checkDay = Number(day);
      if(checkDay >= 1 && checkDay <= lastDay)
      {
         let formData = 
           {
               year: inputYear.val(),
               month: inputMonth.val(),
               day: day < 10 ? "0" + day : day
           }
         fn_detailViewAjax("/anniversary/detailAnniversary", formData);
      }   
      else
      {
         alert("입력 값이 잘못되었습니다.");
         return;   
      }
   }
   
   function fn_detailViewAjax(url, data)
   {   
      $.ajax
       ({
           type:"POST",
           url:url,
           data:data,
           success: function(response)
           {
              let json = response.data;
             let show = "";
             let makeTag = "";
             let inputTag = $("#detailItems");
             
              if(response.code == 0)
              {
                 if(json.length > 0)
                 {
                    for(let i = 0; i < json.length; i++)
                    {
                       if(json[i].anniversarySeq != 0)
                       {
                          if(json[i].userId != "")
                          {
                             makeTag = 
                                  "<div class='detailContainer'><div class='header'><div class='title'><p>" + json[i].userNickname + "님이 공유한 일정 : " +
                                  json[i].anniversaryTitle + "</p></div><div class='buttons'><p>" + json[i].anniversaryDate + " " + json[i].anniversaryTime + 
                                  "</p><img onclick=\"fn_refuseShared(" + json[i].anniversarySeq + ", '" + json[i].userNickname + "', '" + json[i].userId + "')\"" +
                                    " src='/resources/images/X_icon.png' style='width: 24px; height: 24px; margin-left: 10px;'></div></div><div class='content'>" + 
                                  json[i].anniversaryContent + "</div></div>";   
                          }
                          else
                          {
                             makeTag = 
                                  "<div class='detailContainer'><div class='header'><div class='title'><p>" + json[i].anniversaryTitle + 
                                  "</p></div><div class='buttons'><p>" + json[i].anniversaryDate + " " + json[i].anniversaryTime + 
                                  "</p><input type='button' value='일정 공유 내역' onclick='fn_shareList(" + json[i].anniversarySeq + ", event)'>" + 
                                  "<input type='button' value='일정 공유' onclick='fn_share(" + json[i].anniversarySeq + ", event)'>" +
                                  "<img onclick='fn_deleteAnniversary(" + json[i].anniversarySeq + ")' src='/resources/images/X_icon.png'" + 
                                  "style='width: 24px; height: 24px; margin-left: 10px;'></div></div>" +
                                  "<div class='content'>" + json[i].anniversaryContent + "</div></div>";   
                          }   
                       }
                       else
                       {
                          makeTag = 
                              "<div class='detailContainer'><div class='header'><div class='title'><p>" + json[i].anniversaryTitle + 
                              "</p></div><div class='buttons'><p>" + json[i].anniversaryDate + " " + json[i].anniversaryTime + 
                              "</p></div></div>" + "<div class='content'>" + json[i].anniversaryContent + "</div></div>";   
                       }
                       show = show + makeTag;
                       makeTag = "";
                    }
                 }
                 show = show + "<br>"
                 inputTag.html(show);
              }
              else if(response.code == 1)
              {
                 if(json.length > 0)
                 {
                    for(let i = 0; i < json.length; i++)
                    {
                       makeTag = 
                             "<div class='detailContainer'><div class='header'><div class='title'><p>" + json[i].anniversaryTitle + "</p></div>" +
                             "</div><div class='content'>해당 날짜에 추가한 일정이 없습니다. 일정을 추가해 보세요.</div></div>";   
                       show = show + makeTag;
                       makeTag = "";
                    }
                 }
                 show = show + "<br>"
                 inputTag.html(show);
              }
              else if(response.code == 500)
              {
                 alert(response.data);
              }
              else if(response.code == 400)
              {
                 alert(response.data);
                 document.calenderForm.action = "/calender/calender";
                    document.calenderForm.submit();
              }
              else if(response.code == 404)
              {
                 alert(response.data);
                 document.calenderForm.action = "/calender/calender";
                    document.calenderForm.submit();
              }
              else if(response.code == 100)
              {
                 alert(response.data);
                 document.calenderForm.action = "/calender/calender";
                    document.calenderForm.submit();
              }
              else   
              {
                 alert("알 수 없는 오류가 발생하였습니다.");
                 document.calenderForm.action = "/calender/calender";
                    document.calenderForm.submit();
              }
           },
           error: function(xhr, status, error) 
           {
               console.log(error);
           }
       });      
   }
   

   function fn_shareList(a_Seq, event) 
   {
      $(".shareAnniversary").fadeOut();
       if (a_Seq > 0) 
       {
           let formData = 
           {
              anniversarySeq: a_Seq
           };
           let y = event.clientY;
           let screenHeight = window.innerHeight; 
           let yPercentage = (y / screenHeight) * 100;
           fn_checkMyAnniversary("/anniversary/checkMyAnniversary", formData, 72, yPercentage, 1);
       } 
       else 
       {
           return;
       }
   }
   
   function fn_getSharedList(url, data, x, y) 
   {
       $.ajax
       ({
           type: "POST",
           url: url,
           data: data,
           success: function(response) 
           {
               if(response.code == 0) 
               { 
                let inputTag = $("#shareScroll");
                   var buttonPosition = $('.buttons').offset();
                   var buttonWidth = $('.buttons').outerWidth();
                   var buttonHeight = $('.buttons').outerHeight();
                   var shareAnniversary = $('.shareAnniversary');

                   var topPosition = y + 40 + '%'; // 화면 높이에 대한 백분율
                   var leftPosition = x + 4 + '%'; // 화면 너비에 대한 백분율

                   shareAnniversary.css
                   ({
                       'top': topPosition,
                       'left': leftPosition,
                       'display': 'block'
                   });

                   $('.shareAnniversary').on('click', function(event) 
                   {
                       event.stopPropagation();
                   });
               
                   let json = response.data;

                   let makeTag = ""; 
                   let show = "";
                   if(json.length > 0)
                   {
                      $("#shareText").html("일정을 공유 중인 친구입니다.<br>공유를 취소할 친구를 선택하세요.");
                      for(let i = 0; i < json.length; i++)
                      {
                         if(json[i].relationalSeq > 0)
                         {
                            makeTag  = 
                            "<div class='shareFriend' onclick='fn_cancleShared(" + json[i].relationalSeq + ", " + data.anniversarySeq + ", event, " + i + ")'><div><img src='" 
                            + json[i].fileName + "' alt='프로필 이미지'></div><div class='shareFriendName'>" + json[i].userNickname + "</div></div>";
                         }
                         show = show + makeTag;
                         makeTag = "";
                      }
                   }
                   else
                  {
                      $("#shareText").text("일정을 공유하고 있는 친구가 없습니다.");
                      show = "<div class='shareFriend'><div></div><div class='shareFriendName' onclick='fn_share(" + data.anniversarySeq + ", event)'>일정 공유하기</div></div>";
                  }
                 inputTag.html(show);
                   
                   $(".shareAnniversary").fadeIn();
               }
              else if(response.code == 500)
              {
                 alert(response.data);
              }
              else if(response.code == 400)
              {
                 alert(response.data);
                 document.calenderForm.action = "/calender/calender";
                    document.calenderForm.submit();
              }
              else if(response.code == 404)
              {
                 alert(response.data);
                 document.calenderForm.action = "/calender/calender";
                    document.calenderForm.submit();
              }
              else if(response.code == 100)
              {
                 alert(response.data);
                 document.calenderForm.action = "/calender/calender";
                    document.calenderForm.submit();
              }
              else   
              {
                 alert("알 수 없는 오류가 발생하였습니다.");
                 document.calenderForm.action = "/calender/calender";
                    document.calenderForm.submit();
              }
           },
           error: function(xhr, status, error) 
           {
               console.log(error);
           }
       }); 
   }

   function fn_share(a_Seq, event) 
   {
       $(".shareAnniversary").fadeOut();
       if (a_Seq > 0) 
       {
           let formData = 
           {
              anniversarySeq: a_Seq
           };
           
           let y = event.clientY;
           let screenHeight = window.innerHeight; 
           let yPercentage = (y / screenHeight) * 100;
           fn_checkMyAnniversary("/anniversary/checkMyAnniversary", formData, 72, yPercentage, 0);
       } 
       else 
       {
           return;
       }
   }

   function fn_checkMyAnniversary(url, data, x, y, type) 
   {
       $.ajax
       ({
           type: "POST",
           url: url,
           data: data,
           success: function (response) 
           {
               if(response.code == 0) 
               {
                  if(type == 0)
                  {
                     fn_getShareableList("/anniversary/getShareableList", data, x, y);
                  }
                  else if(type == 1)
                  {
                     fn_getSharedList("/anniversary/getSharedList", data, x, y);
                  }
                  else
                  {
                      return;
                  }
               }
              else if(response.code == 500)
              {
                 alert(response.data);
              }
              else if(response.code == 400)
              {
                 alert(response.data);
                 document.calenderForm.action = "/calender/calender";
                    document.calenderForm.submit();
              }
              else if(response.code == 404)
              {
                 alert(response.data);
                 document.calenderForm.action = "/calender/calender";
                    document.calenderForm.submit();
              }
              else if(response.code == 100)
              {
                 alert(response.data);
                 document.calenderForm.action = "/calender/calender";
                    document.calenderForm.submit();
              }
              else   
              {
                 alert("알 수 없는 오류가 발생하였습니다.");
                 document.calenderForm.action = "/calender/calender";
                    document.calenderForm.submit();
              }
           },
           error: function(xhr, status, error) 
           {
               console.log(error);
           }
       }); 
   }
   
   function fn_getShareableList(url, data, x, y) 
   {
       $.ajax
       ({
           type: "POST",
           url: url,
           data: data,
           success: function(response) 
           {
               if(response.code == 0) 
               { 
                let inputTag = $("#shareScroll");
                   var buttonPosition = $('.buttons').offset();
                   var buttonWidth = $('.buttons').outerWidth();
                   var buttonHeight = $('.buttons').outerHeight();
                   var shareAnniversary = $('.shareAnniversary');

                   var topPosition = y + 40 + '%'; // 화면 높이에 대한 백분율
                   var leftPosition = x + 4 + '%'; // 화면 너비에 대한 백분율

                   shareAnniversary.css
                   ({
                       'top': topPosition,
                       'left': leftPosition,
                       'display': 'block'
                   });

                   $('.shareAnniversary').on('click', function(event) 
                   {
                       event.stopPropagation();
                   });
               
                   let json = response.data;

                   let makeTag = ""; 
                   let show = "";
                   if(json.length > 0)
                   {
                      $("#shareText").text("일정을 공유할 친구를 선택하세요.");
                      for(let i = 0; i < json.length; i++)
                      {
                         if(json[i].relationalSeq > 0)
                         {
                            makeTag  = 
                            "<div class='shareFriend' onclick='fn_shareForYou(" + json[i].relationalSeq + ", " + data.anniversarySeq + ", event, " + i + ")'><div><img src='" 
                            + json[i].fileName + "' alt='프로필 이미지'></div><div class='shareFriendName'>" + json[i].userNickname + "</div></div>";
                         }
                         show = show + makeTag;
                         makeTag = "";
                      }
                   }
                   else
                  {
                      $("#shareText").text("공유 할 수 있는 친구가 없습니다.");
                      show = "<div class='shareFriend'><div></div><div class='shareFriendName'><a href='/friend/friendList'>친구추가하러가기</a></div></div>";
                  }
                 inputTag.html(show);
                   
                   $(".shareAnniversary").fadeIn();
               }
              else if(response.code == 500)
              {
                 alert(response.data);
              }
              else if(response.code == 400)
              {
                 alert(response.data);
                 document.calenderForm.action = "/calender/calender";
                    document.calenderForm.submit();
              }
              else if(response.code == 404)
              {
                 alert(response.data);
                 document.calenderForm.action = "/calender/calender";
                    document.calenderForm.submit();
              }
              else if(response.code == 100)
              {
                 alert(response.data);
                 document.calenderForm.action = "/calender/calender";
                    document.calenderForm.submit();
              }
              else   
              {
                 alert("알 수 없는 오류가 발생하였습니다.");
                 document.calenderForm.action = "/calender/calender";
                    document.calenderForm.submit();
              }
           },
           error: function(xhr, status, error) 
           {
               console.log(error);
           }
       }); 
   }
   
   function fn_shareForYou(relationalSeq, anniversarySeq, event, i)
   {
      let tag = event.target;
      let $shareFriendNames = $('.shareFriendName', tag.parentElement);
      let nickName = "";
      if (i < $shareFriendNames.length) 
      {
           nickName = $($shareFriendNames[i]).text();
       }
      else 
       {
         return;
       }
      if(relationalSeq > 0 && anniversarySeq > 0)
      {
         if(confirm(nickName + "님에게 일정을 공유하시겠습니까?"))
         {
            let formData = 
              {
               relationalSeq: relationalSeq,
                 anniversarySeq: anniversarySeq
              };
            
              let y = event.clientY;
              let screenHeight = window.innerHeight;
              let yPercentage = (y / screenHeight) * 100;
            fn_shareAjax("/anniversary/shareForYou", formData, yPercentage, 0);
         }
      }
   }
   
   function fn_cancleShared(relationalSeq, anniversarySeq, event, i)
   {
      let tag = event.target;
      let $shareFriendNames = $('.shareFriendName', tag.parentElement);
      let nickName = "";
      if (i < $shareFriendNames.length) 
      {
           nickName = $($shareFriendNames[i]).text();
       }
      else 
       {
         return;
       }
      if(relationalSeq > 0 && anniversarySeq > 0)
      {
         if(confirm(nickName + "님에게 일정 공유를 취소 하시겠습니까?"))
         {
            let formData = 
              {
               relationalSeq: relationalSeq,
                 anniversarySeq: anniversarySeq
              };
            
              let y = event.clientY;
              let screenHeight = window.innerHeight;
              let yPercentage = (y / screenHeight) * 100;
              
            fn_shareAjax("/anniversary/cancleShared", formData, yPercentage, 1);
         }
      }
   }
   
   
   function fn_shareAjax(url, data, y, type)
   {
      $.ajax
       ({
           type: "POST",
           url: url,
           data: data,
           success: function(response) 
           {
               if(response.code == 0) 
               {
                  alert(response.data);
                   $(".shareAnniversary").fadeOut();
                   if(type == 0)
                  {
                     fn_getShareableList("/anniversary/getShareableList", data, 72, y);
                  }
                  else if(type == 1)
                  {
                     fn_getSharedList("/anniversary/getSharedList", data, 72, y);
                  }
                  else
                  {
                      return;
                  }
               }
              else if(response.code == 500)
              {
                 alert(response.data);
                 document.calenderForm.action = "/calender/calender";
                    document.calenderForm.submit();
              }
              else if(response.code == 400)
              {
                 alert(response.data);
                 document.calenderForm.action = "/calender/calender";
                    document.calenderForm.submit();
              }
              else if(response.code == 404)
              {
                 alert(response.data);
                 document.calenderForm.action = "/calender/calender";
                    document.calenderForm.submit();
              }
              else if(response.code == 100)
              {
                 alert(response.data);
                 document.calenderForm.action = "/calender/calender";
                    document.calenderForm.submit();
              }
              else   
              {
                 alert("알 수 없는 오류가 발생하였습니다.");
                 document.calenderForm.action = "/calender/calender";
                    document.calenderForm.submit();
              }
           },
           error: function(xhr, status, error) 
           {
               console.log(error);
           }
       }); 
   }
</c:if>

</script>    
</head>
<body>
<%@ include file="/WEB-INF/views/include/navigation.jsp"%>   

<div class="calender" style="margin-top: 150px;">
   <ul class="month" style="border-radius:10px;">
        <li style="display: flex; align-items: flex-end; justify-content: space-between;">
          <span class="weather" style="justify-content: flex-start;">
              <b id="weatherDetail"></b>
              <img id="weatherImg" src="" style="width: 30px; height: 30px">
          </span>
          <div style="margin-bottom:30px;">
          <span>
             <input class="calAddBtn" type="button" value="일정 추가하기" style="width: 150px; height: 40px;" id="addCal">
             <input type="date" id="dateEvent" style="width:auto; height: 40px; margin-left: 5px; border-radius: 10px; border: none; text-align: center;">
            <a href="/calender/calender"><input type="button" value="오늘 날짜 돌아가기" style="width:180px; height: 40px; margin-left: 5px; border-radius: 10px; border: none; text-align: center;"></a>
         </span>
         </div>
      </li>
    <li>
         <h1>January</h1>
         <h2>2023</h2>
    </li>
       <span class="prev">&#10094;</span>
       <span class="next">&#10095;</span>
     </ul>
     <ul class="weeks" style="font-weight:bold; font-size:20px;">
       <li>일</li>
       <li>월</li>
       <li>화</li>
       <li>수</li>
       <li>목</li>
       <li>금</li>
       <li>토</li>
     </ul>
     <ul class="days" style="border-radius:10px;">
     </ul>
</div>

<div style="margin:auto; height: auto; width: 50%;" id="detailItems">
</div>

<div class="scheduler">
   <form action="">
      <div>
         <input type="text" maxlength="30" placeholder="일정 제목을 입력하세요." id="calTitle" name="calTitle">
      </div>
      <div>
         <textarea rows="10" cols="100" maxlength="200" placeholder="일정 내용을 입력하세요." id="calContent" name="calContent"></textarea>
      </div>
      <div>
         <span>
            <input type="date" id="calDate" name="calDate">
         </span>
         <span>
            <input type="time" id="calTime" name="calTime">
         </span>
      </div>
      <div class="btnClass">
         <span>
            <input type="button" value="추가" id="requestAdd">
         </span>
         <span>
            <input type="button" value="취소" id="cancleAdd">
         </span>
      </div>
   </form>
</div>

<div class="shareAnniversary">
   <div>
      <h3 id="shareText"></h3>      
   </div>
   <div class="shareScroll" id="shareScroll">
   </div>
   <div>
      <input type="button" value="닫기" id="closeList">
   </div>
</div>


<form action="" name="calenderForm">
    <input type="hidden" name="year" value="${year}">
    <input type="hidden" name="month" value="${month}">
</form>


<footer style="background-color: black; color: lightgray; text-align: center; margin-top:60px; padding: 40px;">
 <a style="font-size:20px; letter-spacing:5px;">《 Dayiary 》 </a> <br>
    &copy; Copyright Dayiary Corp. All Rights Reserved. <br>
    Always with you 🎉 여러분의 일상을 함께합니다.
</footer> 
</body>
</html>