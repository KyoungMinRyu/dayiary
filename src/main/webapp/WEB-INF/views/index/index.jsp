<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<title>Dayiary</title>
<link rel="shortcut icon" href="/resources/images/logo.png" type="image/x-icon">
<link rel='stylesheet'
   href='https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.1/css/all.min.css'>

  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<style>
@font-face {
  font-family: 'dayiary'; /* 야채장수 */
  src: url('../resources/css/dayiary.ttf') format('truetype'); /* 폰트 파일의 경로 및 형식 */
}
@font-face {
  font-family: 'dayiary2'; /* 와일드 */
  src: url('../resources/css/dayiary2.ttf') format('truetype'); /* 폰트 파일의 경로 및 형식 */
 }
 
@font-face {
    font-family: 'SUIT-Regular'; /* 고딕 */
    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_suit@1.0/SUIT-Regular.woff2') format('woff2');
    font-weight: 100;
    font-style: normal;
} 

@font-face {
    font-family: 'HakgyoansimWoojuR';
    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2307-2@1.0/HakgyoansimWoojuR.woff2') format('woff2');
    font-weight: normal;
    font-style: normal;
}

@font-face {
    font-family: 'IBMPlexSansKR-Regular';
    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_20-07@1.0/IBMPlexSansKR-Regular.woff') format('woff');
    font-weight: normal;
    font-style: normal;
}

@font-face {
    font-family: 'LeferiPoint-WhiteObliqueA';
    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2201-2@1.0/LeferiPoint-WhiteObliqueA.woff') format('woff');
    font-weight: normal;
    font-style: normal;
}


:root { 
   --card-width: 200px;
     --card-height: 300px;
     --card-transition-duration: 800ms;
     --card-transition-easing: ease;
}

* {
  box-sizing: border-box;
  margin: 0;
  padding: 0;
}

body {
  width: 100%;
  height: 100vh;
  display: flex;
  justify-content: center;
  align-items: center;
  background: rgba(0, 0, 0, 0.787);
  overflow: hidden;
  background-size: cover; /* 이미지를 화면 전체에 맞게 조절 */
  background-repeat: no-repeat; /* 이미지 반복 방지 */
  background-attachment: fixed; /* 스크롤 시 배경 이미지 고정 */
}

button {
  border: none;
  background: none;
  cursor: pointer;
}
button:focus {
  outline: none;
  border: none;
}
.app {
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
  height: 100vh;
  background: rgba(0, 0, 0, 0.787);
  overflow: hidden;
}

.app__bg {
  position: absolute;
  width: 100%;
  height: 100%;
  z-index: -5;
  filter: blur(8px);
  pointer-events: none;
  user-select: none;
  overflow: hidden;
}
.app__bg::before {
  content: "";
  position: absolute;
  left: 0;
  top: 0;
  width: 100%;
  height: 80%;
  background: #000;
  z-index: 1;
  opacity: 0;
}
.app__bg__image {
  position: absolute;
  left: 50%;
  top: 50%;
  transform: translate(-50%, -50%) translateX(var(--image-translate-offset, 0));
  width: 180%;
  height: 180%;
  transition: transform 1000ms ease, opacity 1000ms ease;
  overflow: hidden;
}
.app__bg__image img {
  width: 100%;
  height: 100%;
  object-fit: cover;
}
.app__bg__image.current--image {
  opacity: 1;
  --image-translate-offset: 0;
}
.app__bg__image.previous--image, .app__bg__image.next--image {
  opacity: 0;
}
.app__bg__image.previous--image {
  --image-translate-offset: -25%;
}
.app__bg__image.next--image {
  --image-translate-offset: 25%;
}

.cardList {
  position: absolute;
  width: calc(3 * var(--card-width));
  height: auto;
}
.cardList__btn {
  --btn-size: 35px;
  width: var(--btn-size);
  height: var(--btn-size);
  position: absolute;
  top: 50%;
  transform: translateY(-50%);
  z-index: 100;
}
.cardList__btn.btn--left {
  left: -5%;
}
.cardList__btn.btn--right {
  right: -5%;
}
.cardList__btn .icon {
  width: 100%;
  height: 100%;
}
.cardList__btn .icon svg {
  width: 100%;
  height: 100%;
}
.cardList .cards__wrapper {
  position: relative;
  width: 100%;
  height: 100%;
  perspective: 1000px;
}

.card {
  --card-translateY-offset: 100vh;
  position: absolute;
  left: 50%;
  top: 50%;
  transform: translate(-50%, -50%) translateX(var(--card-translateX-offset)) translateY(var(--card-translateY-offset)) rotateY(var(--card-rotation-offset)) scale(var(--card-scale-offset));
  display: inline-block;
  width: var(--card-width);
  height: var(--card-height);
  transition: transform var(--card-transition-duration) var(--card-transition-easing);
  user-select: none;
}
.card::before {
  content: "";
  position: absolute;
  left: 0;
  top: 0;
  width: 100%;
  height: 100%;
  background: #000;
  z-index: 1;
  transition: opacity var(--card-transition-duration) var(--card-transition-easing);
  opacity: calc(1 - var(--opacity));
}
.card__image {
  position: relative;
  width: 100%;
  height: 100%;
}
.card__image img {
  position: absolute;
  left: 0;
  top: 0;
  width: 100%;
  height: 100%;
  object-fit: cover;
}
.card.current--card {
  --current-card-rotation-offset: 0;
  --card-translateX-offset: 0;
  --card-rotation-offset: var(--current-card-rotation-offset);
  --card-scale-offset: 1.2;
  --opacity: 0.8;
}
.card.previous--card {
  --card-translateX-offset: calc(-1 * var(--card-width) * 1.1);
  --card-rotation-offset: 25deg;
}
.card.next--card {
  --card-translateX-offset: calc(var(--card-width) * 1.1);
  --card-rotation-offset: -25deg;
}
.card.previous--card, .card.next--card {
  --card-scale-offset: 0.9;
  --opacity: 0.4;
}


.infoList {
  position: absolute;
  width: calc(3 * var(--card-width));
  height: var(--card-height);
  pointer-events: none;
}
.infoList .info__wrapper {
  position: relative;
  width: 100%;
  height: 100%;
  display: flex;
  justify-content: flex-start;
  align-items: flex-end;
  perspective: 1000px;
  transform-style: preserve-3d;
}

.info {
  margin-bottom: calc(var(--card-height) / 8);
  margin-left: calc(var(--card-width) / 1.5);
  transform: translateZ(2rem);
  transition: transform var(--card-transition-duration) var(--card-transition-easing);
}
.info .text {
  position: relative;
  font-family: 'LeferiPoint-WhiteObliqueA', sans-serif;
  font-size: calc(var(--card-width) * var(--text-size-offset, 0.2));
  white-space: nowrap;
  color: #fff;
  width: fit-content;
}

.text.name {
letter-spacing: 10px;
}

.info .location {
  font-weight: 800;
}
.info .location {
  --mg-left: 40px;
  --text-size-offset: 0.12;
  font-weight: 600;
  margin-left: var(--mg-left);
  margin-bottom: calc(var(--mg-left) / 2);
  padding-bottom: 0.8rem;
}
.info .location::before, .info .location::after {
  content: "";
  position: absolute;
  background: #fff;
  left: 0%;
  transform: translate(calc(-1 * var(--mg-left)), -50%);
}
.info .location::before {
  top: 50%;
  width: 20px;
  height: 5px;
}
.info .location::after {
  bottom: 0;
  width: 60px;
  height: 2px;
}
.info .description {
  --text-size-offset: 0.065;
  font-weight: 500;
}
.info.current--info {
  opacity: 1;
  display: block;
}
.info.previous--info, .info.next--info {
  opacity: 0;
  display: none;
}
.loading__wrapper {
  position: fixed;
  left: 0;
  top: 0;
  width: 100%;
  height: 100%;
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
  background: #000;
  z-index: 200;
}

.loading__wrapper .loader--text {
  color: #fff;
  font-family: 'dayiary', sans-serif; 
  font-weight: 500;
  margin-bottom: 1.4rem;
}
.loading__wrapper .loader {
  position: relative;
  width: 200px;
  height: 2px;
  background: rgba(255, 255, 255, 0.25);
}
.loading__wrapper .loader span {
  position: absolute;
  left: 0;
  top: 0;
  width: 100%;
  height: 100%;
  background: red;
  transform: scaleX(0);
  transform-origin: left;
}

@media only screen and (min-width: 800px) {
  :root {
    --card-width: 350px;
    --card-height: 500px;
  }
}
.support {
  position: absolute;
  right: 10px;
  bottom: 10px;
  padding: 10px;
  display: flex;
}
.support a {
  margin: 0 10px;
  color: #fff;
  font-size: 1.8rem;
  backface-visibility: hidden;
  transition: all 150ms ease;
}
.support a:hover {
  transform: scale(1.1);
}


/*body {
  background-color: lightgray;
  display: flex;
  justify-content: center;
  align-items: center;
  min-height: 100vh;
} */

</style>
<script type="text/javascript">
<%
if(com.icia.web.util.CookieUtil.getHexValue(request, "SELLER_ID") != null && com.icia.web.util.CookieUtil.getHexValue(request, "SELLER_ID") != "")
{
%>
	location.href = "/index/sellerIndex";
<%
}
else if(com.icia.web.util.CookieUtil.getHexValue(request, "USER_ID") != null && com.icia.web.util.CookieUtil.getHexValue(request, "USER_ID") != "")
{
	if(com.icia.common.util.StringUtil.equals(com.icia.web.util.CookieUtil.getHexValue(request, "USER_ID"), "adm"))
	{
	%>
		location.href = "/index/adminIndex";		
	<%
	}
}
%>
</script>
</head>
<body>
<%@ include file="/WEB-INF/views/include/navigation.jsp" %>
   <div class="app">

      <div class="cardList">
         <button class="cardList__btn btn btn--left">
            <div class="icon">
               <svg>
               <use xlink:href="#arrow-left"></use>
            </svg>
            </div>
         </button>

         <div class="cards__wrapper">
            <div class="card current--card" data-url="/calender/calender">
               <div class="card__image">
                  <img src="/resources/images/diary.jpg" alt=""/>
               </div>
            </div>

            <div class="card next--card" data-url="/board/diaryList">
               <div class="card__image">
                  <img src="/resources/images/cal.jpg" alt="" />
               </div>
            </div>

            <div class="card previous--card" data-url="/index/event">
               <div class="card__image">
                  <img src="/resources/images/wine.jpg" alt="" />
               </div>
            </div>
         </div>

         <button class="cardList__btn btn btn--right">
            <div class="icon">
               <svg>
               <use xlink:href="#arrow-right"></use>
            </svg>
            </div>
         </button>
      </div>
      
      <div class="infoList">
         <div class="info__wrapper">
         
            <div class="info current--info">
               <h1 class="text name" style="text-shadow: 5px 2px 5px rgba(0, 0, 0, 0.3);">Calendar</h1>
               <h4 class="text location" style="letter-spacing: -3px; font-size:35px;">일정 관리하기</h4>
               <p class="text description">어떤 날을 기념하고 싶나요? 나만의 달력에 일정을 저장하세요!</p>
            </div>
            
            <div class="info next--info">
               <h1 class="text name" style="text-shadow: 5px 2px 5px rgba(0, 0, 0, 0.3);">Diary</h1>
               <h4 class="text location" style="letter-spacing: -3px; font-size:35px;">다이어리 작성하기</h4>
               <p class="text description">행복한 하루 보내셨나요? 다이어리에 글을 남겨보세요!</p>
            </div>

            <div class="info previous--info">
               <h1 class="text name" style="text-shadow: 5px 2px 5px rgba(0, 0, 0, 0.3);">For you</h1>
               <h4 class="text location" style="letter-spacing: -3px; font-size:35px;">기념일 준비하기</h4>
               <p class="text description">소중한 이를 위해 선물을 구입하고, 레스토랑을 예약하실 수 있습니다.</p>
            </div>
            
         </div>
      </div>


      <div class="app__bg">
         <div class="app__bg__image current--image">
            <img src="/resources/images/diary.jpg" alt="" />
         </div>
         <div class="app__bg__image next--image">
            <img src="/resources/images/cal.jpg" alt="" />
         </div>
         <div class="app__bg__image previous--image">
            <img src="/resources/images/wine.jpg" alt="" />
         </div>
      </div>
   </div>

   <div class="loading__wrapper">
      <div class="loader--text">Loading...</div>
      <div class="loader">
         <span></span>
      </div>
   </div>

   <svg class="icons" style="display: none;">
   <symbol id="arrow-left" xmlns='http://www.w3.org/2000/svg'
         viewBox='0 0 512 512'>
      <polyline points='328 112 184 256 328 400'
         style='fill:none;stroke:#fff;stroke-linecap:round;stroke-linejoin:round;stroke-width:48px' />
   </symbol>
   <symbol id="arrow-right" xmlns='http://www.w3.org/2000/svg'
         viewBox='0 0 512 512'>
      <polyline points='184 112 328 256 184 400'
         style='fill:none;stroke:#fff;stroke-linecap:round;stroke-linejoin:round;stroke-width:48px' />
   </symbol>
</svg>

   <script src='https://unpkg.com/imagesloaded@4.1.4/imagesloaded.pkgd.min.js'></script>
   <script
      src='https://cdnjs.cloudflare.com/ajax/libs/gsap/3.3.3/gsap.min.js'></script>
   <script>
//console.clear();

const { gsap, imagesLoaded } = window;

const buttons = {
   prev: document.querySelector(".btn--left"),
   next: document.querySelector(".btn--right"),
};
const cardsContainerEl = document.querySelector(".cards__wrapper");
const appBgContainerEl = document.querySelector(".app__bg");

const cardInfosContainerEl = document.querySelector(".info__wrapper");

buttons.next.addEventListener("click", () => swapCards("right"));

buttons.prev.addEventListener("click", () => swapCards("left"));

function swapCards(direction) {
   const currentCardEl = cardsContainerEl.querySelector(".current--card");
   const previousCardEl = cardsContainerEl.querySelector(".previous--card");
   const nextCardEl = cardsContainerEl.querySelector(".next--card");

   const currentBgImageEl = appBgContainerEl.querySelector(".current--image");
   const previousBgImageEl = appBgContainerEl.querySelector(".previous--image");
   const nextBgImageEl = appBgContainerEl.querySelector(".next--image");

   changeInfo(direction);
   swapCardsClass();

   removeCardEvents(currentCardEl);

   function swapCardsClass() {
      currentCardEl.classList.remove("current--card");
      previousCardEl.classList.remove("previous--card");
      nextCardEl.classList.remove("next--card");

      currentBgImageEl.classList.remove("current--image");
      previousBgImageEl.classList.remove("previous--image");
      nextBgImageEl.classList.remove("next--image");

      currentCardEl.style.zIndex = "50";
      currentBgImageEl.style.zIndex = "-2";

      if (direction === "right") {
         previousCardEl.style.zIndex = "20";
         nextCardEl.style.zIndex = "30";

         nextBgImageEl.style.zIndex = "-1";

         currentCardEl.classList.add("previous--card");
         previousCardEl.classList.add("next--card");
         nextCardEl.classList.add("current--card");

         currentBgImageEl.classList.add("previous--image");
         previousBgImageEl.classList.add("next--image");
         nextBgImageEl.classList.add("current--image");
      } else if (direction === "left") {
         previousCardEl.style.zIndex = "30";
         nextCardEl.style.zIndex = "20";

         previousBgImageEl.style.zIndex = "-1";

         currentCardEl.classList.add("next--card");
         previousCardEl.classList.add("current--card");
         nextCardEl.classList.add("previous--card");

         currentBgImageEl.classList.add("next--image");
         previousBgImageEl.classList.add("current--image");
         nextBgImageEl.classList.add("previous--image");
      }
   }
}

function changeInfo(direction) {
   let currentInfoEl = cardInfosContainerEl.querySelector(".current--info");
   let previousInfoEl = cardInfosContainerEl.querySelector(".previous--info");
   let nextInfoEl = cardInfosContainerEl.querySelector(".next--info");

   gsap.timeline()
      .to([buttons.prev, buttons.next], {
      duration: 0.2,
      opacity: 0.5,
      pointerEvents: "none",
   })
      .to(
      currentInfoEl.querySelectorAll(".text"),
      {
         duration: 0.4,
         stagger: 0.1,
         translateY: "-120px",
         opacity: 0,
      },
      "-="
   )
      .call(() => {
      swapInfosClass(direction);
   })
      .call(() => initCardEvents())
      .fromTo(
      direction === "right"
      ? nextInfoEl.querySelectorAll(".text")
      : previousInfoEl.querySelectorAll(".text"),
      {
         opacity: 0,
         translateY: "40px",
      },
      {
         duration: 0.4,
         stagger: 0.1,
         translateY: "0px",
         opacity: 1,
      }
   )
      .to([buttons.prev, buttons.next], {
      duration: 0.2,
      opacity: 1,
      pointerEvents: "all",
   });

   function swapInfosClass() {
      currentInfoEl.classList.remove("current--info");
      previousInfoEl.classList.remove("previous--info");
      nextInfoEl.classList.remove("next--info");

      if (direction === "right") {
         currentInfoEl.classList.add("previous--info");
         nextInfoEl.classList.add("current--info");
         previousInfoEl.classList.add("next--info");
      } else if (direction === "left") {
         currentInfoEl.classList.add("next--info");
         nextInfoEl.classList.add("previous--info");
         previousInfoEl.classList.add("current--info");
      }
   }
}


function updateCard(e) {
   const card = e.currentTarget;
   const box = card.getBoundingClientRect();
   const centerPosition = {
      x: box.left + box.width / 25,
      y: box.top + box.height / 25,
   };
   let angle = Math.atan2(e.pageX - centerPosition.x, 0) * (35 / Math.PI);
   gsap.set(card, {
      "--current-card-rotation-offset": "17.5deg",
         /*`${angle}deg`,*/
   });

   const currentInfoEl = cardInfosContainerEl.querySelector(".current--info");
   gsap.set(currentInfoEl, {
      rotateY: "17.5deg",
         /*`${angle}deg`,*/
   });
}

function resetCardTransforms(e) {
   const card = e.currentTarget;
   const currentInfoEl = cardInfosContainerEl.querySelector(".current--info");
   gsap.set(card, {
      "--current-card-rotation-offset": 0,
   });
   gsap.set(currentInfoEl, {
      rotateY: 0,
   });
}

function handleCardClick(card) { /*각 카드 클릭시 div에 정의된 주소로 이동*/
    let url = card.dataset.url;
    window.location.href = url;
}


function initCardEvents() {
    const currentCardEl = cardsContainerEl.querySelector(".current--card");
    const nextCardEl = cardsContainerEl.querySelector(".next--card");
    const previousCardEl = cardsContainerEl.querySelector(".previous--card");

   currentCardEl.addEventListener("click", () => handleCardClick(currentCardEl)); /*첫번째 카드 클릭시*/
   nextCardEl.addEventListener("click", () => handleCardClick(nextCardEl)); /*두번째 카드 클릭시*/
   previousCardEl.addEventListener("click", () => handleCardClick(previousCardEl)); /*세번째 카드 클릭시*/

    currentCardEl.addEventListener("pointermove", updateCard);
    currentCardEl.addEventListener("pointerout", (e) => {
        resetCardTransforms(e);
    });
}


initCardEvents();

function removeCardEvents(card) {
   card.removeEventListener("pointermove", updateCard);
}

function init() {

   let tl = gsap.timeline();

   tl.to(cardsContainerEl.children, {
      delay: 0.15,
      duration: 0.5,
      stagger: {
         ease: "power4.inOut",
         from: "right",
         amount: 0.1,
      },
      "--card-translateY-offset": "0%",
   })
      .to(cardInfosContainerEl.querySelector(".current--info").querySelectorAll(".text"), {
      delay: 0.5,
      duration: 0.4,
      stagger: 0.1,
      opacity: 1,
      translateY: 0,
   })
      .to(
      [buttons.prev, buttons.next],
      {
         duration: 0.4,
         opacity: 1,
         pointerEvents: "all",
      },
      "-=0.4"
   );
}

const waitForImages = () => {
   const images = [...document.querySelectorAll("img")];
   const totalImages = images.length;
   let loadedImages = 0;
   const loaderEl = document.querySelector(".loader span");

   gsap.set(cardsContainerEl.children, {
      "--card-translateY-offset": "100vh",
   });
   gsap.set(cardInfosContainerEl.querySelector(".current--info").querySelectorAll(".text"), {
      translateY: "40px",
      opacity: 0,
   });
   gsap.set([buttons.prev, buttons.next], {
      pointerEvents: "none",
      opacity: "0",
   });

   images.forEach((image) => {
      imagesLoaded(image, (instance) => {
         if (instance.isComplete) {
            loadedImages++;
            let loadProgress = loadedImages / totalImages;

            gsap.to(loaderEl, {
               duration: 1,
               scaleX: loadProgress,
               backgroundColor: `hsl(${loadProgress * 120}, 100%, 50%`,
            });

            if (totalImages == loadedImages) {
               gsap.timeline()
                  .to(".loading__wrapper", {
                  duration: 0.8,
                  opacity: 0,
                  pointerEvents: "none",
               })
                  .call(() => init());
            }
         }
      });
   });
};

 jQuery.rnd = function(m,n) {
       m = parseInt(m);
       n = parseInt(n);
       return Math.floor( Math.random() * (n - m + 1) ) + m;
 } 

 
waitForImages();

</script>

</body>
</html>