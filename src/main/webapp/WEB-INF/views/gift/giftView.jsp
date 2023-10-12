<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%> 
<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/views/include/head.jsp" %>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width,initial-scale=1">
    <meta name="description" content="multikart">
    <meta name="keywords" content="multikart">
    <meta name="author" content="multikart">
    <link rel="icon" href="../assets/images/favicon/1.png" type="image/x-icon">
    <link rel="shortcut icon" href="../assets/images/favicon/1.png" type="image/x-icon">
    
        <!--Google font-->
    <link href="https://fonts.googleapis.com/css?family=Lato:300,400,700,900" rel="stylesheet">


<style>
@font-face {
    font-family: 'SUIT-Regular'; /* 고딕 */
    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_suit@1.0/SUIT-Regular.woff2') format('woff2');
    font-weight: 100;
    font-style: normal;
} 

:root {
  --theme-deafult: #ff4c3b; }
  
  
  
.tab-contentnav-material{
       display: flex;
        justify-content: center;
        align-items: center;
        height: 100vh; /* 화면 높이에 맞게 조절할 수 있습니다. */

}

body {
  margin-top: 200px;
  font-family: 'SUIT-Regular', sans-serif;
  position: relative;
  background: #fffbf4 !important;
  font-size: 14px; }
  body.christmas {
    font-family: Philosopher, sans-serif; }
    body.christmas .dark-light {
      display: none; }
    body.christmas section {
      overflow: hidden; }

h1 {
  font-size: 60px;
  color: #222222;
  font-weight: 700;
  text-transform: uppercase; }
  h1 span {
    font-size: 107px;
    font-weight: 700;
    color: var(--theme-deafult); }

h2 {
  font-size: 36px;
  color: #222222;
  text-transform: uppercase;
  font-weight: 700;
  line-height: 1;
  letter-spacing: 0.02em; }

h3 {
  font-size: 24px;
  font-weight: 400;
  color: #777777;
  letter-spacing: 0.03em; }

h4 {
  font-size: 18px;
  text-transform: capitalize;
  font-weight: 400;
  letter-spacing: 0.03em;
  line-height: 1; }

h5 {
  font-size: 16px;
  font-weight: 400;
  color: #222222;
  line-height: 24px;
  letter-spacing: 0.05em; }

h6 {
  font-size: 14px;
  font-weight: 400;
  color: #777777;
  line-height: 24px; }

ul {
  padding-left: 0;
  margin-bottom: 0; }

li {
  display: inline-block; }

p {
  font-size: 14px;
  color: #777777;
  line-height: 1; }

a {
  -webkit-transition: 0.5s ease;
  transition: 0.5s ease; }
  a:hover {
    text-decoration: none;
    -webkit-transition: 0.5s ease;
    transition: 0.5s ease; }
  a:focus {
    outline: none; }

button:focus {
  outline: none; }

section,
.section-t-space {
  padding-top: 70px; }

.section-b-space {
  padding-bottom: 70px; }

.large-section {
  padding-top: 120px;
  padding-bottom: 120px; }

.p-t-0 {
  padding-top: 0; }

hr.style1 {
  width: 75px;
  height: 3px;
  margin-top: 13px;
  background-color: var(--theme-deafult);
  text-align: center; }

.no-arrow .slick-next,
.no-arrow .slick-prev {
  display: none !important; }

.form-control {
  border-radius: 0; }

.small-section {
  padding-top: 35px;
  padding-bottom: 35px; }

.banner-padding {
  padding-top: 30px; }

.border-section {
  border-top: 1px solid #dddddd;
  border-bottom: 1px solid #dddddd; }

.border-b {
  border-bottom: 1px solid #38352f; }

.border-bottom-grey {
  border-bottom: 1px solid #efefef; }

.border-top-grey {
  border-top: 1px solid #efefef; }

.darken-layout {
  background-color: #393230; }

.dark-layout {
  background-color: #2d2a25; }

.light-layout {
  background-color: #f9f9f9; }

.white-layout {
  background-color: #ffffff; }

.bg-light0 {
  background-color: #d0edff; }

.bg-light1 {
  background-color: #f1e7e6; }

.bg-light2 {
  background-color: #bfbfbf; }

.bg-blog {
  background-color: #eeeeee; }

.bg-grey {
  background-color: #f7f7f7; }

.bg_cls {
  background-color: #fafafa; }

del {
  font-size: 14px;
  color: #aaaaaa;
  font-weight: 400; }

[data-notify="progressbar"] {
  margin-bottom: 0;
  position: absolute;
  bottom: 0;
  left: 0;
  width: 100%;
  height: 5px; }

.progress-bar {
  background-color: #19a340; }

.progress-bar-info {
  background-color: #00829a; }

.container-fluid.custom-container {
  padding-left: 90px;
  padding-right: 90px; }

.ratio_40 .bg-size:before {
  padding-top: 40%;
  content: "";
  display: block; }

.ratio_45 .bg-size:before {
  padding-top: 45%;
  content: "";
  display: block; }

.ratio2_1 .bg-size:before {
  padding-top: 50%;
  content: "";
  display: block; }

.ratio2_3 .bg-size:before {
  padding-top: 60%;
  content: "";
  display: block; }

.ratio3_2 .bg-size:before {
  padding-top: 66.66%;
  content: "";
  display: block; }

.ratio_landscape .bg-size:before {
  padding-top: 75%;
  content: "";
  display: block; }

.ratio_square .bg-size:before {
  padding-top: 100%;
  content: "";
  display: block; }

.ratio_asos .bg-size:before {
  padding-top: 127.7777778%;
  content: "";
  display: block; }

.ratio_portrait .bg-size:before {
  padding-top: 150%;
  content: "";
  display: block; }

.ratio1_2 .bg-size:before {
  padding-top: 200%;
  content: "";
  display: block; }

.b-top {
  background-position: top !important; }

.b-bottom {
  background-position: bottom !important; }

.b-center {
  background-position: center !important; }

.b_size_content {
  background-size: contain !important;
  background-repeat: no-repeat; }

/*Lazy load */


/*=====================
    1.1.Button CSS start
==========================*/
button {
  cursor: pointer; }

.btn {
  line-height: 20px;
  text-transform: uppercase;
  font-size: 14px;
  font-weight: 700;
  border-radius: 0;
  -webkit-transition: 0.3s ease-in-out;
  transition: 0.3s ease-in-out; }
  .btn:hover {
    -webkit-transition: 0.3s ease-in-out;
    transition: 0.3s ease-in-out; }
  .btn:focus {
    -webkit-box-shadow: none;
            box-shadow: none; }

.btn-solid {
  padding: 13px 29px;
  color: #ffffff;
  letter-spacing: 0.05em;
  border: 2px solid var(--theme-deafult);
  background-image: linear-gradient(30deg, var(--theme-deafult) 50%, transparent 50%);
  background-size: 850px;
  background-repeat: no-repeat;
  background-position: 0;
  -webkit-transition: background 300ms ease-in-out;
  transition: background 300ms ease-in-out; }
  .btn-solid:hover {
    background-position: 100%;
    color: #000000;
    background-color: #ffffff; }
  .btn-solid.black-btn {
    background-image: linear-gradient(30deg, #222222 50%, transparent 50%);
    border: 2px solid #222222; }
  .btn-solid:focus {
    color: #ffffff; }
  .btn-solid.btn-gradient {
    background: var(--theme-deafult);
    background: -webkit-gradient(linear, left top, left bottom, from(var(--gradient1)), color-stop(99%, var(--gradient2)));
    background: linear-gradient(180deg, var(--gradient1) 0%, var(--gradient2) 99%);
    -webkit-transition: background 300ms ease-in-out;
    transition: background 300ms ease-in-out;
    background-size: 300% 100%;
    border: none; }
    .btn-solid.btn-gradient:hover {
      background: -webkit-gradient(linear, left top, left bottom, from(var(--gradient2)), color-stop(99%, var(--gradient1)));
      background: linear-gradient(-180deg, var(--gradient2) 0%, var(--gradient1) 99%);
      -webkit-transition: background 300ms ease-in-out;
      transition: background 300ms ease-in-out;
      color: white; }
  .btn-solid.btn-green {
    background-image: -webkit-gradient(linear, left top, right top, from(var(--gradient1)), to(var(--gradient2)));
    background-image: linear-gradient(to right, var(--gradient1), var(--gradient2));
    border: none;
    background-color: var(--theme-deafult); }
    .btn-solid.btn-green:hover {
      background-color: var(--theme-deafult);
      background-image: none;
      color: white; }
  .btn-solid.btn-sm {
    padding: 9px 16px; }
  .btn-solid.btn-xs {
  
  
  
  
    padding: 5px 8px;
    text-transform: capitalize; }

.btn-outline {
  display: inline-block;
  padding: 13px 29px;
  letter-spacing: 0.05em;
  border: 2px solid var(--theme-deafult);
  position: relative;
  color: #000000; }
  .btn-outline:before {
    -webkit-transition: 0.5s all ease;
    transition: 0.5s all ease;
    position: absolute;
    top: 0;
    left: 50%;
    right: 50%;
    bottom: 0;
    opacity: 0;
    content: "";
    background-color: var(--theme-deafult);
    z-index: -2; }
  .btn-outline:hover, .btn-outline:focus {
    color: #ffffff !important; }
    .btn-outline:hover i, .btn-outline:focus i {
      color: #ffffff !important; }
    .btn-outline:hover:before, .btn-outline:focus:before {
      -webkit-transition: 0.5s all ease;
      transition: 0.5s all ease;
      left: 0;
      right: 0;
      opacity: 1; }
  .btn-outline.btn-sm {
    padding: 9px 16px;
    font-size: 12px; }

button.btn.btn-solid:active, button.btn.btn-outline:active {
  background-image: linear-gradient(30deg, var(--theme-deafult) 50%, transparent 50%);
  color: #ffffff;
  background: var(--theme-deafult); }

.btn-classic:hover {
  background-color: var(--theme-deafult); }

.btn-theme {
  background-color: var(--theme-deafult);
  color: #ffffff; }

.btn-white {
  background-color: white;
  color: var(--theme-deafult);
  -webkit-transition: all 0.5s ease;
  transition: all 0.5s ease;
  padding: 10px 29px; }
  .btn-white:hover {
    color: #000000;
    -webkit-transition: all 0.5s ease;
    transition: all 0.5s ease; }

.btn-custom {
  padding: 6px 30px !important;
  border: none; }


/*=====================
    7.About CSS start
==========================*/
.about-text p {
  line-height: 28px;
  letter-spacing: 0.06em;
  text-align: center;
  margin-bottom: 50px; }



/*=====================
    10.Product Box CSS start
==========================*/
.absolute-product .theme-tab .tab-title .current a {
  font-weight: 700; }

.absolute-product .product-box {
  width: 100%;
  display: inline-block;
  padding-bottom: 10px;
  -webkit-box-shadow: 0 0 5px 0 rgba(0, 0, 0, 0.1);
          box-shadow: 0 0 5px 0 rgba(0, 0, 0, 0.1);
  border-radius: 5px; }
  .absolute-product .product-box .img-wrapper {
    border-radius: 5px 5px 0 0; }
  .absolute-product .product-box .product-detail {
    text-align: center;
    margin-top: 0;
    padding: 0 15px; }
    .absolute-product .product-box .product-detail .color-variant {
      padding-top: 5px; }
      .absolute-product .product-box .product-detail .color-variant li {
        height: 16px;
        width: 16px; }
    .absolute-product .product-box .product-detail .cart-bottom {
      border-top: 1px solid #ddd;
      padding-top: 10px;
      margin-top: 10px; }
      .absolute-product .product-box .product-detail .cart-bottom button {
        border: none;
        background-color: transparent;
        padding: 0; }
      .absolute-product .product-box .product-detail .cart-bottom i {
        color: #828282;
        font-size: 18px;
        padding-right: 7px;
        padding-left: 7px;
        -webkit-transition: all 0.5s ease;
        transition: all 0.5s ease; }
        .absolute-product .product-box .product-detail .cart-bottom i:hover {
          color: var(--theme-deafult);
          -webkit-transition: all 0.5s ease;
          transition: all 0.5s ease; }
    .absolute-product .product-box .product-detail .rating {
      margin-top: 10px; }

.absolute-product .slick-slider .product-box {
  margin-bottom: 3px; }

.product-m .slick-list {
  margin-left: -15px;
  margin-right: -15px; }

.product-m .slick-slide > div {
  margin: 0 15px; }

.color-variant li {
  display: inline-block;
  height: 20px;
  width: 20px;
  border-radius: 100%;
  margin-right: 5px;
  -webkit-transition: all 0.1s ease;
  transition: all 0.1s ease;
  vertical-align: middle; }

.image-swatch {
  margin-bottom: 10px; }
  .image-swatch li img {
    width: 33px;
    height: 33px;
    padding: 2px;
    border: 1px solid #dddddd;
    margin-right: 5px;
    -webkit-transition: all 0.5s ease;
    transition: all 0.5s ease; }
  .image-swatch li:last-child {
    margin-right: 0; }
  .image-swatch li.active img {
    border: 1px solid var(--theme-deafult); }
  .image-swatch li:hover img {
    border: 1px solid var(--theme-deafult);
    -webkit-transition: all 0.5s ease;
    transition: all 0.5s ease; }

.no-slider .product-box {
  width: 100%;
  -webkit-box-flex: 0;
      -ms-flex: 0 0 25%;
          flex: 0 0 25%;
  max-width: calc(25% - 30px);
  margin: 0 15px 30px; }
  .no-slider .product-box:nth-last-child(-n+4) {
    margin: 0 15px 0; }

.no-slider.five-product .product-box {
  width: 100%;
  -webkit-box-flex: 0;
      -ms-flex: 0 0 20%;
          flex: 0 0 20%;
  max-width: calc(20% - 30px);
  margin: 0 15px 30px; }
  .no-slider.five-product .product-box:nth-last-child(-n+5) {
    margin: 0 15px 0; }

.product-para p {
  margin-bottom: 0;
  padding-bottom: 30px;
  line-height: 24px;
  letter-spacing: 0.05em; }


.addtocart_count {
  position: relative; }
  .addtocart_count .product-box .product-detail {
    text-align: center; }
  .addtocart_count .product-box .cart-info {
    bottom: 40px;
    right: 10px; }
    .addtocart_count .product-box .cart-info a i {
      background-color: #e2e2e2;
      border-radius: 100%;
      margin: 10px 0;
      padding: 8px;
      font-size: 16px;
      color: #313131; }
  .addtocart_count .product-box .add-button {
    background-color: #efefef;
    color: black;
    text-align: center;
    font-size: 18px;
    text-transform: capitalize;
    width: 100%;
    padding: 5px 0;
    -webkit-transition: all 0.5s ease;
    transition: all 0.5s ease;
    border: none;
    cursor: pointer; }
  .addtocart_count .product-box:hover .cart-info a:nth-child(1) i {
    -webkit-animation: fadeInRight 300ms ease-in-out;
            animation: fadeInRight 300ms ease-in-out; }
  .addtocart_count .product-box:hover .add-button {
    bottom: 0;
    -webkit-transition: all 0.5s ease;
    transition: all 0.5s ease; }
  .addtocart_count .addtocart_btn {
    position: relative; }
    .addtocart_count .addtocart_btn .cart_qty {
      width: 100%; }
      .addtocart_count .addtocart_btn .cart_qty.qty-box {
        position: absolute;
        bottom: 0;
        display: none; }
        .addtocart_count .addtocart_btn .cart_qty.qty-box .input-group .form-control {
          width: 100%; }
          .addtocart_count .addtocart_btn .cart_qty.qty-box .input-group .form-control:focus {
            border-color: #efefef;
            -webkit-box-shadow: none;
                    box-shadow: none; }
        .addtocart_count .addtocart_btn .cart_qty.qty-box .input-group button {
          background: #efefef !important;
          position: absolute;
          height: 100%;
          z-index: 9; }
          .addtocart_count .addtocart_btn .cart_qty.qty-box .input-group button.quantity-left-minus {
            left: 0; }
          .addtocart_count .addtocart_btn .cart_qty.qty-box .input-group button.quantity-right-plus {
            right: 0; }
        .addtocart_count .addtocart_btn .cart_qty.qty-box .input-group button i {
          color: #000000; }
      .addtocart_count .addtocart_btn .cart_qty.open {
        display: block; }

.grid-products {
  margin-bottom: -30px; }
  .grid-products .product-box {
    margin-bottom: 30px; }

.bg-title .theme-card h5.title-border {
  padding: 10px;
  color: white;
  background-color: var(--theme-deafult);
  border-radius: 5px; }

.bg-title .theme-card .slick-prev {
  right: 30px; }
  .bg-title .theme-card .slick-prev:before {
    color: white;
    opacity: 1;
    font-size: 25px; }

.bg-title .theme-card .slick-next {
  right: 6px; }
  .bg-title .theme-card .slick-next:before {
    color: white;
    opacity: 1;
    font-size: 25px; }

.bg-title .theme-tab .bg-title-part {
  display: -webkit-box;
  display: -ms-flexbox;
  display: flex;
  -webkit-box-align: center;
      -ms-flex-align: center;
          align-items: center;
  margin-bottom: 30px;
  margin-top: -6px;
  background-color: var(--theme-deafult);
  padding: 10px;
  border-radius: 5px; }
  .bg-title .theme-tab .bg-title-part .title-border {
    margin-bottom: 0;
    color: white;
    text-transform: capitalize; }
  .bg-title .theme-tab .bg-title-part .tab-title {
    margin-bottom: 0;
    margin-top: 0;
    margin-left: auto;
    text-align: right; }
    .bg-title .theme-tab .bg-title-part .tab-title li {
      font-size: 16px;
      padding-right: 0; }
      .bg-title .theme-tab .bg-title-part .tab-title li:first-child {
        padding-left: 0; }
    .bg-title .theme-tab .bg-title-part .tab-title a {
      color: rgba(255, 255, 255, 0.7); }
    .bg-title .theme-tab .bg-title-part .tab-title .current a {
      color: white; }



/*=====================
  22.Inner pages CSS start
==========================*/



.product-wrapper-grid.list-view .product-wrap .product-info {
  text-align: left;
  -ms-flex-item-align: center;
  align-self: center;
  padding-left: 15px;
  display: flex; /* 요소를 가로로 배열하도록 설정 */
  align-items: center; /* 세로 중앙 정렬 */
  justify-content: space-between; /* 요소 사이의 공간을 최대로 확보하여 나란히 정렬 */
   }

.product-wrapper-grid.list-view .product-box {
  display: -webkit-box;
  display: -ms-flexbox;
  display: flex;
  padding-bottom: 0; }
  .product-wrapper-grid.list-view .product-box .img-wrapper,
  .product-wrapper-grid.list-view .product-box .img-block {
    width: 25%; }
  .product-wrapper-grid.list-view .product-box .product-detail {
    padding-left: 15px;
    -ms-flex-item-align: center;
        align-self: center;
    text-align: left !important; }
    .product-wrapper-grid.list-view .product-box .product-detail .rating {
      margin-top: 0; }
    .product-wrapper-grid.list-view .product-box .product-detail p {
      display: block !important;
      margin-bottom: 5px;
      line-height: 18px; }
    .product-wrapper-grid.list-view .product-box .product-detail .color-variant {
      padding-top: 10px; }
    .product-wrapper-grid.list-view .product-box .product-detail h6 {
      font-weight: 700; }






.qty-box .input-group {
  -webkit-box-pack: center;
      -ms-flex-pack: center;
          justify-content: center; }
  .qty-box .input-group span button {
    background: #efefef !important;
    border: 1px solid #ced4da; }
  .qty-box .input-group .form-control {
    text-align: center;
    width: 80px;
    -webkit-box-flex: unset;
        -ms-flex: unset;
            flex: unset; }
  .qty-box .input-group button {
    background-color: transparent;
    border: 0;
    color: #777777;
    cursor: pointer;
    padding-left: 12px;
    font-size: 12px;
    font-weight: 900;
    line-height: 1; }
    .qty-box .input-group button i {
      font-weight: 900;
      color: #222222; }
  .qty-box .input-group .icon {
    padding-right: 0; }


.product-right p {
  margin-bottom: 0;
  line-height: 1.5em; }

.product-right .product-title {
  color: #222222;
  text-transform: capitalize;
  font-weight: 700;
  margin-bottom: 0; }

.product-right .border-product {
  padding-top: 15px;
  padding-bottom: 20px;
  border-top: 1px dashed #dddddd; }

.product-right h2 {
  text-transform: uppercase;
  margin-bottom: 15px;
  font-size: 35px;
  line-height: 1.2em; }

.product-right h3 {
  font-size: 26px;
  color: #222222;
  margin-bottom: 15px; }

.product-right h4 {
  font-size: 16px;
  margin-bottom: 7px; }
  .product-right h4 del {
    color: #777777; }
  .product-right h4 span {
    padding-left: 5px;
    color: var(--theme-deafult); }

.product-right .color-variant {
  margin-bottom: 10px; }
  .product-right .color-variant li {
    height: 30px;
    width: 30px;
    cursor: pointer; }

.product-right .product-buttons {
  margin-bottom: 20px; }
  .product-right .product-buttons .btn-solid,
  .product-right .product-buttons .btn-outline {
    padding: 7px 25px; }
  .product-right .product-buttons a:last-child {
    margin-left: 10px; }

.product-right .product-description h6 span {
  float: right; }

.product-right .product-description .qty-box {
  display: -webkit-box;
  display: -ms-flexbox;
  display: flex;
  -webkit-box-align: center;
      -ms-flex-align: center;
          align-items: center;
  margin-top: 10px; }
  .product-right .product-description .qty-box .input-group {
    -webkit-box-pack: unset;
        -ms-flex-pack: unset;
            justify-content: unset;
    width: unset; }
    .product-right .product-description .qty-box .input-group .form-control {
      border-right: none; }

.product-right .size-box {
  margin-top: 10px;
  margin-bottom: 10px; }
  .product-right .size-box ul li {
    height: 35px;
    width: 35px;
    border-radius: 50%;
    margin-right: 10px;
    cursor: pointer;
    border: 1px solid #f7f7f7;
    text-align: center; }
    .product-right .size-box ul li a {
      color: #222222;
      font-size: 18px;
      display: -webkit-box;
      display: -ms-flexbox;
      display: flex;
      -webkit-box-align: center;
          -ms-flex-align: center;
              align-items: center;
      -webkit-box-pack: center;
          -ms-flex-pack: center;
              justify-content: center;
      height: 100%; }
    .product-right .size-box ul li.active {
      background-color: #f7f7f7; }

.product-right .product-icon {
  display: -webkit-box;
  display: -ms-flexbox;
  display: flex; }
  .product-right .product-icon .product-social {
    margin-top: 5px; }
    .product-right .product-icon .product-social li {
      padding-right: 30px; }
      .product-right .product-icon .product-social li a {
        color: #333333;
        -webkit-transition: all 0.3s ease;
        transition: all 0.3s ease; }
        .product-right .product-icon .product-social li a i {
          font-size: 18px; }
        .product-right .product-icon .product-social li a:hover {
          color: var(--theme-deafult); }
      .product-right .product-icon .product-social li:last-child {
        padding-right: 0; }
  .product-right .product-icon .wishlist-btn {
    background-color: transparent;
    border: none; }
    .product-right .product-icon .wishlist-btn i {
      border-left: 1px solid #dddddd;
      font-size: 18px;
      padding-left: 10px;
      margin-left: 5px;
      -webkit-transition: all 0.5s ease;
      transition: all 0.5s ease; }
    .product-right .product-icon .wishlist-btn span {
      padding-left: 10px;
      font-size: 18px; }
    .product-right .product-icon .wishlist-btn:hover i {
      color: var(--theme-deafult);
      -webkit-transition: all 0.5s ease;
      transition: all 0.5s ease; }

.product-right .payment-card-bottom {
  margin-top: 10px; }
  .product-right .payment-card-bottom ul li {
    padding-right: 10px; }

.product-right .timer {
  margin-top: 10px;
  background-color: #f7f7f7; }
  .product-right .timer p {
    color: #222222; }

.product-right.product-form-box {
  text-align: center;
  border: 1px solid #dddddd;
  padding: 20px; }
  .product-right.product-form-box .product-description .qty-box {
    margin-bottom: 5px; }
    .product-right.product-form-box .product-description .qty-box .input-group {
      -webkit-box-pack: center;
          -ms-flex-pack: center;
              justify-content: center;
      width: 100%; }
  .product-right.product-form-box .product-buttons {
    margin-bottom: 0; }
  .product-right.product-form-box .timer {
    margin-bottom: 10px;
    text-align: left; }

.single-product-tables {
  display: -webkit-box;
  display: -ms-flexbox;
  display: flex;
  margin-top: 20px; }
  .single-product-tables table {
    width: 20%; }
    .single-product-tables table tr {
      height: 35px; }
      .single-product-tables table tr td:first-child {
        font-weight: 600; }
  .single-product-tables.detail-section {
    margin-top: 0; }
    .single-product-tables.detail-section table {
      width: 55%; }



.product-related h2 {
  color: #222222;
  padding-bottom: 20px;
  border-bottom: 1px solid #dddada;
  margin-bottom: 20px; }

.rating {
  margin-top: 0; }
  .rating i {
    padding-right: 5px; }
    .rating i:nth-child(-n+4) {
      color: #ffa200; }
    .rating i:last-child {
      color: #dddddd; }
  .rating .three-star {
    padding-bottom: 5px; }
    .rating .three-star i {
      color: #acacac; }
      .rating .three-star i:nth-child(-n+3) {
        color: #ffd200; }

.tab-product,
.product-full-tab {
  padding-top: 30px; }
  .tab-product .nav-material.nav-tabs,
  .product-full-tab .nav-material.nav-tabs {
    display: -webkit-box;
    display: -ms-flexbox;
    display: flex;
    -webkit-box-align: center;
        -ms-flex-align: center;
            align-items: center;
    -ms-flex-wrap: nowrap;
        flex-wrap: nowrap; }
    .tab-product .nav-material.nav-tabs .nav-item .nav-link,
    .product-full-tab .nav-material.nav-tabs .nav-item .nav-link {
      color: #212121;
      text-align: center;
      padding: 10px 15px 10px 15px;
      text-transform: uppercase;
      border: 0; }
    .tab-product .nav-material.nav-tabs .nav-item .material-border,
    .product-full-tab .nav-material.nav-tabs .nav-item .material-border {
      border-bottom: 2px solid var(--theme-deafult);
      opacity: 0; }
    .tab-product .nav-material.nav-tabs .nav-link.active,
    .product-full-tab .nav-material.nav-tabs .nav-link.active {
      color: var(--theme-deafult); }
      .tab-product .nav-material.nav-tabs .nav-link.active ~ .material-border,
      .product-full-tab .nav-material.nav-tabs .nav-link.active ~ .material-border {
        -webkit-transition: all 0.3s ease;
        transition: all 0.3s ease;
        opacity: 1; }
  .tab-product .theme-form input,
  .product-full-tab .theme-form input {
    border-color: #dddddd;
    font-size: 15px;
    padding: 15px 25px;
    margin-bottom: 15px;
    height: inherit;
    text-align: left; }
  .tab-product .theme-form .btn-solid,
  .tab-product .theme-form .btn-outline,
  .product-full-tab .theme-form .btn-solid,
  .product-full-tab .theme-form .btn-outline {
    margin: 0 auto; }
  .tab-product .theme-form textarea,
  .product-full-tab .theme-form textarea {
    border-color: #dddddd;
    font-size: 15px;
    padding: 17px 25px;
    margin-bottom: 15px;
    height: inherit; }
  .tab-product .tab-content.nav-material p,
  .product-full-tab .tab-content.nav-material p {
    padding: 20px;
    margin-bottom: -8px;
    line-height: 2;
    letter-spacing: 0.05em; }
  .tab-product .tab-content.nav-material .media,
  .product-full-tab .tab-content.nav-material .media {
    margin-top: 20px; }
  .tab-product .title,
  .product-full-tab .title {
    padding-right: 45px;
    color: var(--theme-deafult);
    padding-bottom: 20px; }
  .tab-product .theme-slider .slick-arrow,
  .product-full-tab .theme-slider .slick-arrow {
    top: -45px;
    height: auto; }
    .tab-product .theme-slider .slick-arrow :before,
    .product-full-tab .theme-slider .slick-arrow :before {
      color: #000000;
      font-size: 18px; }
  .tab-product .product-box,
  .product-full-tab .product-box {
    position: relative;
    margin: 5px; }
    .tab-product .product-box:hover,
    .product-full-tab .product-box:hover {
      -webkit-box-shadow: 0 0 12px 0 #dddddd;
              box-shadow: 0 0 12px 0 #dddddd; }
      .tab-product .product-box:hover .lbl-1,
      .product-full-tab .product-box:hover .lbl-1 {
        opacity: 1;
        -webkit-transition: all 0.3s ease;
        transition: all 0.3s ease; }
      .tab-product .product-box:hover .lbl-2,
      .product-full-tab .product-box:hover .lbl-2 {
        opacity: 1;
        -webkit-animation: flipInY 1000ms ease-in-out;
                animation: flipInY 1000ms ease-in-out; }
      .tab-product .product-box:hover .color-variant li,
      .product-full-tab .product-box:hover .color-variant li {
        opacity: 1 !important;
        -webkit-animation: fadeInUp 500ms ease-in-out;
                animation: fadeInUp 500ms ease-in-out; }
    .tab-product .product-box .img-block,
    .product-full-tab .product-box .img-block {
      min-height: unset; }
    .tab-product .product-box .cart-info,
    .product-full-tab .product-box .cart-info {
      position: absolute;
      padding: 10px 0;
      top: 25%;
      right: 15px;
      width: 40px;
      margin-right: 0; }
      .tab-product .product-box .cart-info i,
      .product-full-tab .product-box .cart-info i {
        padding-right: 0; }
      .tab-product .product-box .cart-info a,
      .tab-product .product-box .cart-info button,
      .product-full-tab .product-box .cart-info a,
      .product-full-tab .product-box .cart-info button {
        color: #333333;
        -webkit-transition: all 0.3s ease;
        transition: all 0.3s ease;
        background-color: #ffffff;
        height: 35px;
        width: 35px;
        margin: 7px 0;
        border-radius: 100%;
        display: -webkit-inline-box;
        display: -ms-inline-flexbox;
        display: inline-flex;
        -webkit-box-align: center;
            -ms-flex-align: center;
                align-items: center;
        -webkit-box-pack: center;
            -ms-flex-pack: center;
                justify-content: center;
        border: 0;
        -webkit-box-shadow: 0 0 12px 0 #dddddd;
                box-shadow: 0 0 12px 0 #dddddd; }
        .tab-product .product-box .cart-info a :hover,
        .tab-product .product-box .cart-info button :hover,
        .product-full-tab .product-box .cart-info a :hover,
        .product-full-tab .product-box .cart-info button :hover {
          -webkit-transition: all 0.3s ease;
          transition: all 0.3s ease;
          color: var(--theme-deafult); }
    .tab-product .product-box .lbl-1,
    .product-full-tab .product-box .lbl-1 {
      background-color: var(--theme-deafult);
      padding: 2px 20px 2px 10px;
      display: inline-block;
      text-align: center;
      color: #ffffff;
      position: absolute;
      left: 0;
      top: 15px;
      font-size: 14px;
      line-height: 1.5;
      opacity: 0; }
      .tab-product .product-box .lbl-1:before,
      .product-full-tab .product-box .lbl-1:before {
        content: "";
        position: absolute;
        right: 0;
        top: 0;
        width: 0;
        height: 0;
        border-top: 12px solid var(--theme-deafult);
        border-bottom: 13px solid var(--theme-deafult);
        border-right: 7px solid #ffffff; }
    .tab-product .product-box .lbl-2,
    .product-full-tab .product-box .lbl-2 {
      font-size: 14px;
      top: 15px;
      position: absolute;
      right: 10px;
      color: #333333;
      font-weight: 600;
      text-transform: capitalize;
      opacity: 0; }
    .tab-product .product-box a,
    .product-full-tab .product-box a {
      color: #0072bb;
      font-size: 15px;
      font-weight: 700;
      letter-spacing: 1px; }
    .tab-product .product-box .color-variant,
    .product-full-tab .product-box .color-variant {
      position: absolute;
      top: -35px;
      width: 100%; }
    .tab-product .product-box .slick-slide img,
    .product-full-tab .product-box .slick-slide img {
      display: block; }
    .tab-product .product-box .product-details,
    .product-full-tab .product-box .product-details {
      position: relative; }
      .tab-product .product-box .product-details .color-variant,
      .product-full-tab .product-box .product-details .color-variant {
        position: absolute;
        top: -35px;
        width: 100%; }
        .tab-product .product-box .product-details .color-variant li,
        .product-full-tab .product-box .product-details .color-variant li {
          opacity: 0;
          display: inline-block;
          height: 15px;
          width: 15px;
          border-radius: 100%;
          margin: 0 3px;
          -webkit-transition: all 0.3s ease;
          transition: all 0.3s ease;
          cursor: pointer; }
      .tab-product .product-box .product-details h6,
      .product-full-tab .product-box .product-details h6 {
        color: #333333;
        font-weight: 600;
        letter-spacing: 1px;
        text-transform: capitalize; }
      .tab-product .product-box .product-details .price,
      .product-full-tab .product-box .product-details .price {
        padding-bottom: 10px;
        font-size: 16px;
        color: var(--theme-deafult); }

.product-full-tab {
  padding-top: 70px; }


.product_image_4 > div:nth-last-child(-n+2) {
  margin-top: 25px; }

.quick-view {
  width: 100%;
  max-width: 1080px;
  max-height: 600px;
  position: relative; }

.nav-item-qna .nav-link {
    color: #000; /* 검정색 */
}


.floating-button {
    position: fixed;
    bottom: 20px; 
    right: 25px; 
    width: 50px;
    height: 50px; 
    border-radius: 50%;
    background-color: #ff4c3b; 
    border: 1px solid #ddd;
    text-align: center;
    line-height: 45px;
    cursor: pointer;
    font-size: 20px;
    color: #fff;
}

</style>
<script type="text/javascript">



$(document).ready(function() {
    
       var price = ${giftAdd.pPrice}; 
       var quantityInput = document.getElementById("quantity");
       var quantity = parseInt(quantityInput.value, 10);
       var formattedPrice = numberWithCommas(${giftAdd.pPrice});
   
      
     //가격에 천단위 콤마 찍기
       function numberWithCommas(p) {
           return p.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
           document.getElementById("formattedPrice").innerHTML = formattedPrice + "원";
       }

     //첫번째 가격  
       var formattedPriceElement = document.getElementById("formattedPrice");
       formattedPriceElement.textContent = formattedPrice + "원";


     //수량결정 후 가격
       function updateTotalPrice() {
           var totalPrice = price * quantity;
           var formattedTotalPrice = numberWithCommas(totalPrice);
           document.getElementById("totalprice").innerHTML = formattedTotalPrice + "원";

       }
     
      //수량 플러스 버튼 클릭 시 
       $("#increaseQuantity").on("click", function() {
           quantity++;
           quantityInput.value = quantity; // 수량 값을 업데이트
           updateTotalPrice();
       });
      
       //수량 마이너스 버튼 클릭 시  
       $("#decreaseQuantity").on("click", function() {
           if (quantity > 1) {
               quantity--;
               quantityInput.value = quantity; // 수량 값을 업데이트
               updateTotalPrice();
           }
       });

   
       // 페이지 로드 시 초기 총 가격 설정
       updateTotalPrice();
       
       
      var productSeq = "${productSeq}";
       
      //구매버튼
       function handlePurchaseButtonClick() 
      {

       // document.orderPage를 통해 필요한 속성 값을 변경합니다.
       document.orderPage.price.value = price;
       document.orderPage.quantity.value = quantity;
       document.orderPage.totalPrice.value = price * quantity;
       document.orderPage.giftFileName.value = "${giftAdd.giftFileList.get(0).fileName}";
       document.orderPage.giftpName.value = "${giftAdd.pName}";
       document.orderPage.giftpContent.value = "${giftAdd.pContent}";
       document.orderPage.productSeq.value = productSeq;

      // 폼의 action 속성을 설정하여 어떤 URL로 전송할지 지정합니다.
       document.orderPage.action = "/gift/giftOrder";

       // 폼을 제출합니다.
       document.orderPage.submit();
       
     }
   
     // "구매하기" 버튼을 가져와 클릭 이벤트를 추가합니다.
     const purchaseButton = document.getElementById("purchaseButton");
     purchaseButton.addEventListener("click", handlePurchaseButtonClick);

});


//문의하기 버튼 클릭시 QNA 화면에 상품구매전 (afterSelected) 와 상품번호 (productSeq)를 넘겨서 셀렉트박스 고정시키는 용도 
function fn_movePage(afterSelected, productSeq)
{
   
     window.location.href = "/inquiry/inquiryWriteForm?afterSelected=" + afterSelected + "&productSeq=" + productSeq;
  
}



function fn_reversal(checkFavorite, productSeq)
{
   if(checkFavorite === 0 || checkFavorite === 1)
   {
      let formData = 
       {
         checkFavorite: checkFavorite,
         productSeq: productSeq
       };
      
      $.ajax
       ({
           type: "POST",
           url: "/gift/reversalFavorite",
           data: formData,
           success: function(response)
           {
              if(response.code == 0)
              {
                 let checkFavoriteBox = $("#checkFavoriteBox");
                 checkFavoriteBox.html("");
                 if(checkFavorite == 0) // insert
                 { 
                    checkFavoriteBox.html("<b onclick='fn_reversal(" + Number(response.data.cnt) + ", \"" + productSeq + "\")' style='font-size: 32px; color: red;'>♥</b>");
                 }
                 else if(checkFavorite == 1) // delete
                 {
                    checkFavoriteBox.html("<b onclick='fn_reversal(" + Number(response.data.cnt) + ", \"" + productSeq + "\")' style='font-size: 32px;'>♡</b>");
                 }
                 else
                 {
                    return;
                 }
              }
              else if(response.code == 500)
              {
                 alert("서버에서 오류가 발생하였습니다.");
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
   else
   {
      return;
   }
}


function fn_moveList()
{
    document.bbsForm.action = "/gift/giftList";
    document.bbsForm.submit();
}
</script>
</head>
<body>
<%@ include file="/WEB-INF/views/include/navigation.jsp" %>   
	<div>
    	<div class="collection-wrapper">
        	<div class="container">
            	<div class="row">   
                    <div class="col-lg-5 col-sm-10 col-xs-12">
                    	<div class="product-right-slick">
                            <div>
                            	<img src="/resources/upload/${giftAdd.giftFileList.get(0).fileName}" style="width:480px; height:500px;" alt="NO IMAGE " />
                            </div>
						</div>
                    </div>
                    <div class="col-lg-1 col-sm-2 col-xs-12"></div>
                    <div class="col-lg-6 rtl-text">
                        <div class="product-right">
                        	<h5 style="font-size:18px;">카테고리:${giftAdd.productCategory}</h5>
                            <h2>${giftAdd.pName}</h2>
                          	<p id="formattedPrice" style="font-size: 30px; color: black;"></p>
							<div class="product-description border-product">
							<h5 class="product-title">구매 수량</h5>
                            <div class="qty-box">
                            	<div class="input-group">
                                	<span class="input-group-prepend">
                  						<button type="button" id="decreaseQuantity"  data-type="minus" data-field="">
                      						<i class="ti-angle-left">-</i>
                  						</button>
										<input type="text" id="quantity" name="quantity" class="form-control input-number" value="1">
										<button type="button" id="increaseQuantity" data-type="plus" data-field="">
									    	<i class="ti-angle-right" >+</i>
										</button> 
                     				</span>
   								</div>        
    						</div>
                            <div class="border-product">
                                <h5 class="product-title">상품 소개</h5>
                                <p style="font-size: 20px;">${giftAdd.pContent}</p>
                            </div>
                            <div class="border-product">
                                <h5 class="product-title">상품금액 합계</h5>
                             	<p id="totalprice" style="font-size: 38px; color: black; font-weight: bold;"></p>
                			</div> 
	                        <div class="product-buttons" style="justify-content: space-between; display: flex; align-items: center;"> 
	                           	<%
	                         	if(com.icia.web.util.CookieUtil.getHexValue(request, "SELLER_ID") == null || com.icia.web.util.CookieUtil.getHexValue(request, "SELLER_ID") == "")
	                         	{
	                         	%>
	                           		<button type="button" id="purchaseButton" class="btn btn-solid">구매하기</button>
	                            <%
	                            	if(com.icia.web.util.CookieUtil.getHexValue(request, "USER_ID") != null && com.icia.web.util.CookieUtil.getHexValue(request, "USER_ID") != "")
	                            	{
	                            %>
	                               		<div  id="checkFavoriteBox">
	                                  		<c:choose>
	                                     		<c:when test="${checkFavorite eq 0}">
	                                        		<b onclick="fn_reversal(${checkFavorite}, '${giftAdd.productSeq}')" style="font-size: 32px;">♡</b>
	                                     		</c:when>
	                                     		<c:otherwise>
	                                        		<b onclick="fn_reversal(${checkFavorite}, '${giftAdd.productSeq}')" style="font-size: 32px; color: red;">♥</b>
	                                     		</c:otherwise>
	                                  		</c:choose>
	                               		</div>
	                         	<%
	                            	}
	                         	}
	                         	%>
                            </div>
              				<div class="border-product"></div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
   	</div>
	<section class="tab-product m-0">
        <div class="container">
            <div class="row">
                <div class="col-sm-12 col-lg-12">
                    <ul class="nav nav-tabs nav-material" id="top-tab" role="tablist">
                        <li class="nav-item">
                        	<a class="nav-link active" id="top-home-tab" data-toggle="tab" href="#top-home" role="tab" aria-selected="true" style="font-size:18px;">상세 설명</a>
                            <div class="material-border"></div>
                        </li>
	                    <li class="nav-item-qna">
	                   		<a class="nav-link active text-danger" id="review-tab" style="cursor: pointer; font-size:18px;" role="tab" aria-selected="true">상품후기</a>
	                   		<div class="material-border"></div>
	               		</li>
                        
                        <%
                       	if(com.icia.web.util.CookieUtil.getHexValue(request, "SELLER_ID") == null || com.icia.web.util.CookieUtil.getHexValue(request, "SELLER_ID") == "")
                       	{
                          	if(com.icia.web.util.CookieUtil.getHexValue(request, "USER_ID") != null && com.icia.web.util.CookieUtil.getHexValue(request, "USER_ID") != "")
                          	{
                        %>     		
		                        <li class="nav-item-qna">                                 <!--afterSelected, productSeq 2가지 QNA화면으로 넘기는 용도의 onclick -->
		                			<a class="nav-link active text-danger"  id="top-home-tab" data-toggle="tab" onclick="fn_movePage('2', '${productSeq}')" style="cursor: pointer; font-size:18px;" role="tab" aria-selected="true">문의하기</a>   
		                            <div class="material-border"></div>
		                        </li>
                       	<%
                          	}
                       	}
                       	%>
					</ul>
					
					
					
                    <div class="tab-content nav-material" id="top-tabContent">
	                	<div style="display: flex; align-items: center; flex-direction: column;">
		                	<c:forEach var="giftFile" items="${giftAdd.giftFileList}" varStatus="status">
								<c:if test="${!status.first}">
							        <img src="/resources/upload/${giftFile.fileName}" alt="NO IMAGE " style="max-width: 100%; max-height: 100%; width: auto; height: auto;">
							        <br>
							    </c:if>
							</c:forEach>
							
		
							
	               		</div>
	               		
	               		
	               							                   <section id="product-review">
                <h2 style="margin-bottom : 70px;">상품후기</h2>
<c:if test="${!empty productReviewList}">
                   <c:forEach var="productReviewList" items="${productReviewList}" varStatus="status">      
                 
<ul class="list-unstyled">
    <li class="media mt-4" style="margin-bottom : 30px;" >
        <img src="${productReviewList.fileName}" style="width: 75px; height:75px; object-fit:cover; border-radius:20px;" class="mr-3" alt="avata">
        <div class="media-body" style="display: flex; justify-content: space-between; align-items: center;">
            <div>
                <h5 class="mt-0 mb-1" style="font-weight: bold; display: inline;">${productReviewList.userNickName}(${productReviewList.userId})</h5>
                <b style="margin-top: -15px; margin-left:10px; color: lightgray; display: inline;">${productReviewList.regDate}</b>
                <br />
                
                
                <div class="review" style="display:flex;">              
                  <c:set var="starCount" value="${productReviewList.reviewScore}" />
      
                  <c:choose>
                      <c:when test="${(starCount % 2) eq 0}"> <!-- 별점이 짝수일 경우 (꽉찬별만 있을때) -->
                         <c:forEach var="i" begin="1" end="${starCount / 2}">
                          <img src="/resources/images/fullStar.png" style="width:25px; height:25px; border:none !important;" alt="Full Star">
                          </c:forEach>
                          <c:forEach var="i" begin="1" end="${5 - (starCount / 2)}">
                          <img src="/resources/images/emptyStar.png" style="width:25px; height:25px; border:none !important;" alt="Empty Star">
                          </c:forEach>
                      </c:when>
                      
                      <c:otherwise>
                         <c:forEach var="i" begin="1" end="${starCount / 2}"> <!-- 별점이 홀수일 경우 (반개별 필요) -->
                          <img src="/resources/images/fullStar.png" style="width:25px; height:25px; border:none !important;" alt="Full Star">
                          </c:forEach>
                          <img src="/resources/images/halfStar.png" style="width:25px; height:25px; border:none !important;" alt="Half Star">
                          <c:forEach var="i" begin="1" end="${5 - (starCount / 2)}">
                          <img src="/resources/images/emptyStar.png" style="width:25px; height:25px; border:none !important;" alt="Empty Star">
                          </c:forEach>
                      </c:otherwise>
                  </c:choose>
               </div>     
                
                
                
                
                
                <b id="commentContent" style="font-size: 17px; margin-top: 3px; max-width:1000px;" value="${productReviewList.reviewContent}">${productReviewList.reviewContent}</b>
            </div>
        </div>
    </li>
</ul>
                 
                 </c:forEach>
</c:if>
                 
<c:if test="${empty productReviewList}">          
<h3>작성된 리뷰가 없습니다.</h3>
</c:if>      
                
                
                
                
                
               </section>
	               		
                  	</div>
                </div>
            </div>
        </div>
        
        
        
        
        
    </section>

<div class="floating-button" onclick="fn_moveList()">
	<img src="/resources/images/fList.png" style="width: 30px; height: 30px;" title="리스트로 이동">	
</div>    

<form name="bbsForm" id="bbsForm" method="post">
   <input type="hidden" name="searchTypeCategory" value="${searchTypeCategory}" />
   <input type="hidden" name="searchType" value="${searchType}" />
   <input type="hidden" name="searchValue" value="${searchValue}" />
   <input type="hidden" name="orderBy" value="${orderBy}" />
   <input type="hidden" name="productType" value="${productType}" />
   <input type="hidden" name="curPage" value="${curPage}" />
</form>
    
	<form name="orderPage" id="orderPage" method="post">
	    <input type="hidden" name="price" value="" />
	    <input type="hidden" name="quantity" value="" />
	    <input type="hidden" name="totalPrice" value="" />
	    <input type="hidden" name="giftFileName" value="" />
	    <input type="hidden" name="giftpName" value="" />
	    <input type="hidden" name="giftpContent" value="" />
		<input type="hidden" name="productSeq" value="" />    
	</form>
	<script>
	document.getElementById('review-tab').addEventListener('click', function() 
	{
	    document.getElementById('product-review').scrollIntoView({behavior: 'smooth'});
	});
	</script>
</body>
<footer style="background-color: black; color: lightgray; text-align: center; margin-top:80px; padding: 30px;">
 <a style="font-size:20px; letter-spacing:5px;">《 Dayiary 》 </a> <br>
    &copy; Copyright Dayiary Corp. All Rights Reserved. <br>
    Always with you 🎉 여러분의 일상을 함께합니다.
</footer> 
</html>