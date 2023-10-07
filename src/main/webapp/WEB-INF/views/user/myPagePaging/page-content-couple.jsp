<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<!DOCTYPE html>
<html>
<head>
 <link rel="stylesheet" href="/resources/css/myPagestyle.css">
 <link rel="stylesheet" href="/resources/css/cardstyle.css">
 
 
<!-- jQuery 라이브러리 로드 -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js">
/* a Pen by Diaco m.lotfollahi  : https://diacodesign.com */

var container = document.getElementById('hearContainer') , 
    bigHeart = document.getElementById('bigHeart') ,
    shadow = document.getElementById('shadow') ,
    heartSrc = bigHeart.getAttribute('src') ,
    A = document.createElement('audio');
A.src = 'http://www.freesound.org/data/previews/265/265296_5003039-lq.mp3';  A.volume=0.7;
container.addEventListener('click',generateHeart);
function generateHeart(){
  A.currentTime=0.09; A.play();
  TweenMax.fromTo([bigHeart,shadow],.15,{scale:1},{scale:.88,repeat:1,yoyo:true,ease:Back.easeIn.config(7)})
  var 
  newH = document.createElement('img') ,
  newC = document.createElement('div') ,
  WH = R(80,15) , newDs = [] ;
  for(var nd,i=2; i--;){ 
    nd = document.createElement('div'); nd.className='dots'; 
    newDs.push(nd); container.insertBefore(nd,bigHeart);
  };
  newH.src = heartSrc; newH.className='hearts'; newC.className='circ';
  TweenLite.set(newH,{width:WH,height:WH})
  container.insertBefore(newH,bigHeart); container.appendChild(newC);
  heartAnim(newH,newC,newDs);
};
function heartAnim(e1,e2,e34){
  var dur = R(3.5,1.5) , Path = [] , Y = R(-250,-380) , xStep = ~~R(6,3) ;
  for(var i=1; i<xStep; i++){ Path.push({x:R(32,-96) , y:i*(Y/xStep)}) };
  TweenLite.to(e1,dur,{scale:.3,
    bezier:{ curviness:1.5,values:Path,autoRotate:90 },
    onComplete:function(){ container.removeChild(e1); container.removeChild(e2); }
  });
  TweenLite.to(e1,dur-0.2,{force3D:true,opacity:1,ease:SlowMo.ease.config(0.1,0.8,true)});
  TweenLite.fromTo(e2,.6,{force3D:true,scale:.3},{scale:1,opacity:0});
  TweenMax.staggerTo(e34,R(3.5,1.5),{force3D:true,opacity:0,scale:0,
    cycle:{
      bezier:function(){
        var nPath = [];
        for(var i=1; i<xStep; i++){ nPath.push({x:R(32,-96) , y:i*(Y/xStep)}) };
        return {curviness:1.5,values:nPath}
      }
    }
  },R(0.5,0),function(){for(var i=2;i--;){container.removeChild(e34[i]);}});  
};
function R(M,m) { return m+(M-m)*Math.random(); };


</script>

<!-- combined_script.js 로드 제외 -->




<style>

h2
{
   font-family : 'SUIT-Regular', sans-serif;
}
p
{
   font-family : 'SUIT-Regular', sans-serif
}

.item span {
   font-size: 15px;
}
.task-box-profile{
   position: relative;
  border-radius: 12px;
  width: 50%;
  margin: 20px 0;
  padding: 16px;
  cursor: pointer;
  box-shadow: 2px 2px 4px 0px #ebebeb;
}


h2
{
   font-family : 'SUIT-Regular', sans-serif;
}
p
{
   font-family : 'SUIT-Regular', sans-serif
}
.item span {
   font-size: 15px;
}

.task-box-profile{
   position: relative;
  border-radius: 12px;
  width: 50%;
  margin: 20px 0;
  padding: 16px;
  cursor: pointer;
  box-shadow: 2px 2px 4px 0px #ebebeb;
}

.contain
{
display: flex;
  width: 100%;
  height: 20%;
}


.card-myId {
  max-width: 1000px;
  margin: auto;
  overflow-y: auto;
  position: relative;
  z-index: 1;
  overflow-x: hidden;
  background-color: white;
  display: flex;
  transition: 0.3s;
  flex-direction: column;
  border-radius: 10px;
  box-shadow: 0 0 0 8px rgba(255, 255, 255, 0.2);
  height: 550px;
  margin-top: 20px;
  width:50%;
}
.card-yourId {
  width : 1600px;
  margin: auto;
  overflow-y: auto;
  position: relative;
  z-index: 1;
  overflow-x: hidden;
  background-color: white;
  display: flex;
  transition: 0.3s;
  flex-direction: column;
  border-radius: 10px;
  box-shadow: 0 0 0 8px rgba(255, 255, 255, 0.2);
  height: 100px;
  margin-top: 20px;
    width:50%;
    left: 0%;
  
}

.card[data-state="#about"] {
  height: 200px;
  overflow: hidden;
}

.card-content{
   border: 2px solid pink; /* 테두리 추가 */
    background-color: #f9f9f9; /* 배경색 추가 */
    padding: 0; /* 패딩 추가 */
    margin: 0; /* 마진 제거 */
    border-radius: 15px;
    background-color: #ffc0cb9c;

}

.card-content-2{
   
   font-size : 50px;
}


#hearContainer {
  width: 128px;
  height: 128px;
  transform: translate(-50%, -50%);
  position: absolute;
  left: 47.6%;
  top: 360px;
  overflow: visible;
  z-index : 999;
}

#bigHeart {
  position: absolute;
  left: 50%;
  bottom: 0px;
  transform: translate(-50%, 0%);
  cursor: pointer;
}

#shadow {
  position: absolute;
  width: 70%;
  height: 10px;
  border-radius: 50%;
  background-color: rgba(0, 0, 0, 0.2);
  left: 50%;
  bottom: -2px;
  transform: translate(-50%, 0%);
}

.hearts {
  transform: translate(-50%, -50%);
  position: absolute;
  left: 50%;
  top: 50%;
  opacity: 0;
}

.circ {
  width: 100%;
  height: 100%;
  border-radius: 50%;
  position: absolute;
  transform: translate(-4px, 0px);
  cursor: pointer;
  border: 4px solid rgb(150, 30, 20);
}

.dots {
  width: 7px;
  height: 7px;
  position: absolute;
  left: 50%;
  top: 50%;
  background-color:red;
  border-radius: 50%;
}

#desc {
  white-space: nowrap;
  position: absolute;
  transform: translate(-50%, -50%);
  left: 50%;
  top: 370px;
  text-align: center;
  font-size: 20px;
  font-family: tahoma;
}

#desc span {
  color: red;
}



</style>
</head>
<body>
<div class="page-contentmain">
       <div class="contain">
    <div class="card card-myId" data-state="#about">
  <div class="card-header">
  <c:choose>
     <c:when test="${myGen eq '0'}">
    <div class="card-cover" style="background-color: #4cc0f1d6;"></div>
    </c:when>
    <c:otherwise>
    <div class="card-cover" style="background-color: pink;"></div>
    </c:otherwise>
  </c:choose>
    <img class="card-avatar" src="${myProfileImage}" alt="avatar" />
    <h1 class="card-fullname">${yourFriend.myNickName}</h1>
    <h2 class="card-jobtitle">${myName}</h2>
  </div>
</div>  
 <div class="card card-yourId" data-state="#about">
  <div class="card-header">
  <c:choose>
    <c:when test="${yourGen eq '1'}">
    <div class="card-cover" style="background-color: pink;"></div>
    </c:when>
    <c:otherwise>
    <div class="card-cover" style="background-color: #4cc0f1d6;"></div>
    </c:otherwise>
  </c:choose>  
    <img class="card-avatar" src="${yourProfileImage}" alt="avatar" />
    <h1 class="card-fullname">${yourFriend.yourNickName}</h1>
    <h2 class="card-jobtitle">${yourName}</h2>
  </div>
</div>      
</div>     
    </div>
<div class="card-content">
<p style="text-align: center">
<br />


<div class="card-content-2" style="text-align: center;">

<b style="font-size : 20px;">커플이 된 날 : ${coupleAnniversary.startDate}</b><br />
<b style="font-size : 20px; ">💖 D-100 💖: ${coupleAnniversary.day100}</b><br />
<b style="font-size : 20px; ">💖 D-200 💖: ${coupleAnniversary.day200}</b><br />
<b style="font-size : 20px; ">💖 D-300 💖: ${coupleAnniversary.day300}</b><br />
<br/>

</div>



</div>

</body>

</html>