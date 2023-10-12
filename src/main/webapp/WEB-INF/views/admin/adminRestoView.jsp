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

#our-menu {
    width: 100%;
    background: white;
}
.h1-menu {
    text-align: center;
    color: #ffc107;
    padding-bottom: 10px;
    margin-top:40px;
}
.our-menu-all {
    width: 100%;
    position: relative;
    margin: auto;
    padding: 5px;
    padding-top: 10px;
}
.our-menu-all input {
    display: none;
}
.our-menu-container {
    text-align: center;
    padding: 5px;
}
.our-menu-all input:checked + .our-menu .our-menu-container {
    display: grid;
    grid-template-columns: 1fr 1fr;
    grid-gap: 5px;
    margin: 0;
    padding: 0;
}
.a-menu {
    position: absolute;
    top: -10px;
}
.a-menu-label {
    background: #fff;
    cursor: pointer;
    padding: 5px 10px;
    font-weight: 600;
}

.left-menu-container h3, h4 {
    margin: 0;
    font-size: 15px;
}



input#menu-main:checked ~ .a-menu label#a-menu-main,
input#menu-dessert:checked ~ .a-menu label#a-menu-dessert,
input#menu-drinks:checked ~ .a-menu label#a-menu-drinks {
   background: #ffc107;
}
.left-menu {
    display: flex;
    grid-gap: 20px;
    margin: 0;
    padding: 0;
    flex-direction: column;
}
.left-menu-container {
    display: flex;
    grid-template-columns: repeat(3, minmax(100px,1fr));
    background: #fff;
    padding: 10px;
    justify-items: center;
    justify-content: space-between;
    flex-direction: row;
    align-items: center;
}
.left-menu-container img {
    border-radius: 50%;
    object-fit:cover;
}
.left-menu-container h3 {
    margin: 0;
}
.left-menu-container:hover {
    background: #ffc107;
}
.right-menu {
    display: grid;
    grid-template-columns: 1fr;
    grid-gap: 20px;
    margin: 0;
    padding: 0;
}




</style>
<script type="text/javascript">



$(document).ready(function() 
{
	let rSeq = '${resto.rSeq}';
	
	let formData = {};
	
    $("#restoDetailRevenueButton").on("click", function()
    {
    	formData = 
        {
			rSeq: rSeq
        };

		fn_ajaxRequest("/admin/selectAdminRestoRevenue", formData, 1);
    });
	
    $("#resumptionRestoButton").on("click", function()
    {
    	if(confirm("레스토랑을 정지 해제하시겠습니까?"))
		{
    		formData = 
	        {
				rSeq: rSeq,
				status: 'Y'
	        };
			
    		fn_ajaxRequest("/admin/updateAdminRestoStatus", formData, 0, "레스토랑 정지상태가 해제되었습니다.");
		}
    });

    $("#suspendedRestoButton").on("click", function()
    {
    	if(confirm("레스토랑을 정지하시겠습니까?"))
		{
    		formData = 
	        {
				rSeq: rSeq,
				status: 'T'
	        };
			
			fn_ajaxRequest("/admin/updateAdminRestoStatus", formData, 0, "레스토랑이 정지되었습니다.");
		}
    });
});

function fn_changeTexts(seq, type)
{
	let changeText = "";
	let formData = {};
	
	if(seq.indexOf('R') == 0)
	{
		// seq가 R로 시작하고 type이 0이면 레스토랑명 1이면 레스토랑 소개  
		if(type == 0)
		{
			changeText = prompt("변경하실 레스토랑명을 입력해주세요.");
			if(changeText.trim().length > 0)
			{
				if(confirm("레스토랑명을 " + changeText + "으로 수정하시겠습니까?"))
				{
					formData = 
			        {
						rSeq: seq,
						changeText: changeText,
						type: type
			        };
					
					fn_ajaxRequest("/admin/updateRestoText", formData, 0, "레스토랑명이 변경되었습니다.");
				}
			}
		}
		else if(type == 1)
		{
			changeText = prompt("변경하실 레스토랑 소개글을 입력해주세요.");
			if(changeText.trim().length > 0)
			{
				if(confirm("레스토랑 소개글을 " + changeText + "으로 수정하시겠습니까?"))
				{
					formData = 
			        {
						rSeq: seq,
						changeText: changeText,
						type: type
			        };
					
					fn_ajaxRequest("/admin/updateRestoText", formData, 0, "레스토랑 소개글이 변경되었습니다.");
				}
			}
		}
		else
		{
			return;	
		}
	}
	else if(seq.indexOf('M') == 0)
	{
		// seq가 M로 시작하고 type이 0이면 메뉴이름 변경 1이면 메뉴 내용 번경
		if(type == 0)
		{
			changeText = prompt("변경하실 메뉴명을 입력해주세요.");
			if(changeText.trim().length > 0)
			{
				if(confirm("메뉴명을 " + changeText + "으로 수정하시겠습니까?"))
				{
					formData = 
			        {
						menuSeq: seq,
						changeText: changeText,
						type: type
			        };					
					
					fn_ajaxRequest("/admin/updateMenuText", formData, 0, "메뉴명이 변경되었습니다.");
				}
			}
		}
		else if(type == 1)
		{
			changeText = prompt("변경하실 메뉴 소개글을 입력해주세요.");
			if(changeText.trim().length > 0)
			{
				if(confirm("메뉴 소개글을 " + changeText + "으로 수정하시겠습니까?"))
				{
					formData = 
			        {
						menuSeq: seq,
						changeText: changeText,
						type: type
			        };
					
					fn_ajaxRequest("/admin/updateMenuText", formData, 0, "메뉴 소개글이 변경되었습니다.");
				}
			}
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

function fn_changeImages(seq, fileSeq)
{
	let formData = {};
	
	if(seq.indexOf('R') == 0)
	{
		if(confirm("레스토랑 사진을 기본이미지로 수정하시겠습니까?"))
		{
			formData = 
	        {
				rSeq: seq,
				fileSeq: fileSeq
	        };
			
			fn_ajaxRequest("/admin/updateRestoImages", formData, 0, "레스토랑 사진이 기본이미지로 변경되었습니다.");
		}
	}
	else if(seq.indexOf('M') == 0)
	{
		if(confirm("메뉴 사진을 기본이미지로 수정하시겠습니까?"))
		{
			formData = 
		       {
				menuSeq: seq
		       };
			
			fn_ajaxRequest("/admin/updateMenuImages", formData, 0, "메뉴 사진이 기본이미지로 변경되었습니다.");
		}
	}
	else
	{
		return;
	}	
}

function fn_ajaxRequest(url, formData, returnType, msg)
{
	$.ajax
    ({
        type: "POST",
        url: url,
        data: formData,
        success: function(response)
        {
        	if(returnType == 0)
        	{
        		if(response.code == 0)
				{
					alert(msg);
	        		location.reload();
				}
				else if(response.code == 500)
				{
					alert("서버에서 오류가 발생하였습니다.");
				}
				else
				{
					return;
				}
        	}
        	else if(returnType == 1)
        	{
        		let json = response.data;
        		let totalReservPerson = 0;
        		let totalCount = 0;
        		let orderTotalCount = 0;
        		if(json.length > 0)
        		{
        			let popupWindow = window.open("", fn_getPopUpName(), "width=1000,height=800px;");
	                popupWindow.document.open();
	                popupWindow.document.write("<html><head><title>레스토랑 매출액 추이</title>");

	                popupWindow.document.write('<style>');
	                popupWindow.document.write('body { background-color: #fffbf4; }');           
	                popupWindow.document.write('.container { border: 2px solid #000; border-radius: 10px; max-width: 1000px; margin: 0 auto; font-size: 24px; padding: 20px; font-family: Arial, sans-serif; }');
	                popupWindow.document.write('.header { font-size: 24px; font-weight: bold; margin-bottom: 20px;  text-align: center;}');
	                popupWindow.document.write('.delivery-info { border: 1px solid #ccc; padding: 20px; margin-bottom: 20px; }');
	                popupWindow.document.write('.info-title { font-weight: bold;}');
	                popupWindow.document.write('.info-data { margin-left: 3%; display: inline-block;  }'); 
	                popupWindow.document.write('.info-none { display: inline-block;}'); 
	                popupWindow.document.write('</style>');

	                popupWindow.document.write('</head><body style="background: #fffbf4;">');

	                popupWindow.document.write('<div class="container">');

	                popupWindow.document.write('<div class="basic-info">');

	                popupWindow.document.write('<div class="info-data-container" style="display: flex;">');

	                popupWindow.document.write('<div class="info-none"><h2 style="margin: 0px;">' + json[0].restoName + '</h2></div>');
	                popupWindow.document.write('</div>');
	                
	                for(let i = 0; i < json.length; i++)
	                {

		                popupWindow.document.write("<div style='border: 2px solid #000; border-radius: 5px; padding: 10px;'>");
		                popupWindow.document.write(json[i].restoRegDate.slice(0,4) + "년 " +json[i].restoRegDate.slice(4) + "월");
		                popupWindow.document.write('<div class="info-data-container">');
		                popupWindow.document.write('<div class="info-none">당월 총 예약건수 : </div> <span id="sender" class="info-data">' + json[i].orderTotalCnt.replace(/\B(?=(\d{3})+(?!\d))/g, ',') + '건</span>');
		                popupWindow.document.write('</div>');
		                popupWindow.document.write('<div class="info-data-container">');
		                popupWindow.document.write('<div class="info-none">당월 총 예약 인원 : </div> <span id="sender" class="info-data">' + json[i].restoTotalCount.replace(/\B(?=(\d{3})+(?!\d))/g, ',') + '명</span>');
		                popupWindow.document.write('</div>');
		                popupWindow.document.write('<div class="info-data-container">');
		                popupWindow.document.write('<div class="info-none">당월 총 예약금 : </div> <span id="sender" class="info-data">' + json[i].restoTotalPrice.replace(/\B(?=(\d{3})+(?!\d))/g, ',') + '원</span>');
		                popupWindow.document.write('</div></div><br>');
		                totalReservPerson += Number(json[i].restoTotalCount);
		        		totalCount += Number(json[i].restoTotalPrice);
		        		orderTotalCount += Number(json[i].orderTotalCnt);
	                }

	                popupWindow.document.write("<div style='border: 2px solid #000; border-radius: 5px; padding: 10px;'>");
	                popupWindow.document.write("총 매출액");
	                popupWindow.document.write('<div class="info-data-container">');
	                popupWindow.document.write('<div class="info-none">총 예약건수 : </div> <span id="sender" class="info-data">' + orderTotalCount.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',') + '건</span>');
	                popupWindow.document.write('</div>');
	                popupWindow.document.write('<div class="info-data-container">');
	                popupWindow.document.write('<div class="info-none">총 예약 인원 : </div> <span id="sender" class="info-data">' + totalReservPerson.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',') + '명</span>');
	                popupWindow.document.write('</div>');
	                popupWindow.document.write('<div class="info-data-container">');
	                popupWindow.document.write('<div class="info-none">총 예약금 : </div> <span id="sender" class="info-data">' + totalCount.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',') + '원</span>');
	                popupWindow.document.write('</div></div><br>');
	                
				   	popupWindow.document.write('</div><br>');
					popupWindow.document.write("</body></html>");
	                popupWindow.document.close();	
        		}
        		else
        		{
        			alert("해당 레스토랑에 주문, 예약내역이 없습니다.");
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

function fn_getPopUpName()
{
	return "Detail" + Date.now();	
}

function fn_deleteReview(orderSeq)
{
	if(orderSeq != null && orderSeq != "")
	{
		if(confirm("사용자가 등록한 리뷰를 삭제하시겠습니까?"))
		{
			let formData = 
	        {
				orderSeq: orderSeq
	        };
			
			fn_ajaxRequest("/admin/deleteReview", formData, 0, "리뷰가 삭제되었습니다.");
		}	
	}
	else
	{
		return;
	}
}
</script>
</head>
<body style="">
<%@ include file="/WEB-INF/views/include/adminNavi.jsp" %>
      <!--list 객체가 비어있지 않을때 실행-->
<div style="height : auto; min-height: 100%;">
    <div class="collection-wrapper">
        <div class="container">
            <div class="row">   
                <div class="col-lg-5 col-sm-10 col-xs-12">
                    <div class="product-right-slick">
                        <div>
                        	<img src="/resources/upload/${resto.restoFileList.get(0).fileName}" style="width:480px; height:500px;" alt="NO IMAGE " />                       	
                        </div>
                    </div>
                </div>
                <div class="col-lg-1 col-sm-2 col-xs-12">
					<svg onclick="fn_changeImages('${resto.rSeq}', ${resto.restoFileList.get(0).fileSeq})" class="centered-svg" xmlns="http://www.w3.org/2000/svg" width="30" height="30" viewBox="0 0 24 24" fill="none" stroke="#000000" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" style="cursor: pointer;">
				    	<path fill="white" d="M19.4 15a1.65 1.65 0 0 0 .33 1.82l.06.06a2 2 0 0 1 0 2.83 2 2 0 0 1-2.83 0l-.06-.06a1.65 1.65 0 0 0-1.82-.33 1.65 1.65 0 0 0-1 1.51V21a2 2 0 0 1-2 2 2 2 0 0 1-2-2v-.09A1.65 1.65 0 0 0 9 19.4a1.65 1.65 0 0 0-1.82.33l-.06.06a2 2 0 0 1-2.83 0 2 2 0 0 1 0-2.83l.06-.06a1.65 1.65 0 0 0 .33-1.82 1.65 1.65 0 0 0-1.51-1H3a2 2 0 0 1-2-2 2 2 0 0 1 2-2h.09A1.65 1.65 0 0 0 4.6 9a1.65 1.65 0 0 0-.33-1.82l-.06-.06a2 2 0 0 1 0-2.83 2 2 0 0 1 2.83 0l.06.06a1.65 1.65 0 0 0 1.82.33H9a1.65 1.65 0 0 0 1-1.51V3a2 2 0 0 1 2-2 2 2 0 0 1 2 2v.09a1.65 1.65 0 0 0 1 1.51 1.65 1.65 0 0 0 1.82-.33l.06-.06a2 2 0 0 1 2.83 0 2 2 0 0 1 0 2.83l-.06.06a1.65 1.65 0 0 0-.33 1.82V9a1.65 1.65 0 0 0 1.51 1H21a2 2 0 0 1 2 2 2 2 0 0 1-2 2h-.09a1.65 1.65 0 0 0-1.51 1z">
				    	</path>
				   		<circle  cx="12" cy="12" r="3"></circle>
				   	</svg>
                </div>
                <div class="col-lg-6 rtl-text">
                    <div class="product-right">
                    	<h5 style="font-size:18px;">카테고리:${resto.restoType}</h5>
                    	<div onclick="fn_changeTexts('${resto.rSeq}', 0)" style="display: flex;">
                       		<h2>${resto.restoName}</h2>
                    		<svg class="centered-svg" xmlns="http://www.w3.org/2000/svg" width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="#000000" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" style="cursor: pointer;">
						    	<path fill="white" d="M19.4 15a1.65 1.65 0 0 0 .33 1.82l.06.06a2 2 0 0 1 0 2.83 2 2 0 0 1-2.83 0l-.06-.06a1.65 1.65 0 0 0-1.82-.33 1.65 1.65 0 0 0-1 1.51V21a2 2 0 0 1-2 2 2 2 0 0 1-2-2v-.09A1.65 1.65 0 0 0 9 19.4a1.65 1.65 0 0 0-1.82.33l-.06.06a2 2 0 0 1-2.83 0 2 2 0 0 1 0-2.83l.06-.06a1.65 1.65 0 0 0 .33-1.82 1.65 1.65 0 0 0-1.51-1H3a2 2 0 0 1-2-2 2 2 0 0 1 2-2h.09A1.65 1.65 0 0 0 4.6 9a1.65 1.65 0 0 0-.33-1.82l-.06-.06a2 2 0 0 1 0-2.83 2 2 0 0 1 2.83 0l.06.06a1.65 1.65 0 0 0 1.82.33H9a1.65 1.65 0 0 0 1-1.51V3a2 2 0 0 1 2-2 2 2 0 0 1 2 2v.09a1.65 1.65 0 0 0 1 1.51 1.65 1.65 0 0 0 1.82-.33l.06-.06a2 2 0 0 1 2.83 0 2 2 0 0 1 0 2.83l-.06.06a1.65 1.65 0 0 0-.33 1.82V9a1.65 1.65 0 0 0 1.51 1H21a2 2 0 0 1 2 2 2 2 0 0 1-2 2h-.09a1.65 1.65 0 0 0-1.51 1z">
						    	</path>
						   		<circle  cx="12" cy="12" r="3"></circle>
						   	</svg>
                    	</div>
                      	<p id="formattedPrice" style="font-size: 30px; color: black;"></p>
                        <div class="product-description">
                        <div class="border-product">
                        	<h5 class="product-title">레스토랑 소개</h5><br>
                            <div style="display: flex;" onclick="fn_changeTexts('${resto.rSeq}', 1)">
                                <p style="font-size: 20px;">${resto.restoContent}</p>
	                            <svg class="centered-svg" xmlns="http://www.w3.org/2000/svg" width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="#000000" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" style="cursor: pointer;">
							    	<path fill="white" d="M19.4 15a1.65 1.65 0 0 0 .33 1.82l.06.06a2 2 0 0 1 0 2.83 2 2 0 0 1-2.83 0l-.06-.06a1.65 1.65 0 0 0-1.82-.33 1.65 1.65 0 0 0-1 1.51V21a2 2 0 0 1-2 2 2 2 0 0 1-2-2v-.09A1.65 1.65 0 0 0 9 19.4a1.65 1.65 0 0 0-1.82.33l-.06.06a2 2 0 0 1-2.83 0 2 2 0 0 1 0-2.83l.06-.06a1.65 1.65 0 0 0 .33-1.82 1.65 1.65 0 0 0-1.51-1H3a2 2 0 0 1-2-2 2 2 0 0 1 2-2h.09A1.65 1.65 0 0 0 4.6 9a1.65 1.65 0 0 0-.33-1.82l-.06-.06a2 2 0 0 1 0-2.83 2 2 0 0 1 2.83 0l.06.06a1.65 1.65 0 0 0 1.82.33H9a1.65 1.65 0 0 0 1-1.51V3a2 2 0 0 1 2-2 2 2 0 0 1 2 2v.09a1.65 1.65 0 0 0 1 1.51 1.65 1.65 0 0 0 1.82-.33l.06-.06a2 2 0 0 1 2.83 0 2 2 0 0 1 0 2.83l-.06.06a1.65 1.65 0 0 0-.33 1.82V9a1.65 1.65 0 0 0 1.51 1H21a2 2 0 0 1 2 2 2 2 0 0 1-2 2h-.09a1.65 1.65 0 0 0-1.51 1z">
							    	</path>
							   		<circle  cx="12" cy="12" r="3"></circle>
							   	</svg>
						   	</div>
                        </div>
                    	<div class="border-product" >
                        	<h5 class="product-title">예약금</h5>
                            <p style="font-size: 20px;"><fmt:formatNumber value="${resto.restoDeposit}" pattern="#,###"/>원</p>
                        </div>
                        <div class="border-product">
                        	<h5 class="product-title">시간당 예약 인원</h5>
                            <p style="font-size: 20px;">${resto.limitPerson}</p>
                        </div>
                        <div class="product-buttons">                            
                       		<button type="button" id="restoDetailRevenueButton" class="btn btn-solid">상세 매출액 보기</button>
                        	<c:choose>
                        		<c:when test="${resto.status eq 'T'}">
                        			<button type="button" id="resumptionRestoButton" class="btn btn-solid">매장 정지 해제</button>
                        		</c:when>
                        		<c:otherwise>
                        			<button type="button" id="suspendedRestoButton" class="btn btn-solid">매장 정지</button>
                        		</c:otherwise>
                        	</c:choose>
                        </div>
                        <div class="border-product"> 
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
	                </ul>
	             	<div class="tab-content nav-material" id="top-tabContent">
	               		<h3 style="color: black; margin-left: 5px; margin-top: 5px;">매장 상세 사진</h3><br>
	               		<div style="display: flex; align-items: center; flex-direction: column;">
	                 	<c:forEach var="restoFile" items="${resto.restoFileList}" varStatus="status">
						    <c:if test="${!status.first}">
						        <div style="display: flex;" onclick="fn_changeImages('${resto.rSeq}', ${restoFile.fileSeq})">
						        <img src="/resources/upload/${restoFile.fileName}" alt="NO IMAGE " style="max-width: 95%; max-height: 95%; width: auto; height: auto;">
						        	<svg class="centered-svg" xmlns="http://www.w3.org/2000/svg" width="30" height="30" viewBox="0 0 24 24" fill="none" stroke="#000000" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" style="cursor: pointer;">
								    	<path fill="white" d="M19.4 15a1.65 1.65 0 0 0 .33 1.82l.06.06a2 2 0 0 1 0 2.83 2 2 0 0 1-2.83 0l-.06-.06a1.65 1.65 0 0 0-1.82-.33 1.65 1.65 0 0 0-1 1.51V21a2 2 0 0 1-2 2 2 2 0 0 1-2-2v-.09A1.65 1.65 0 0 0 9 19.4a1.65 1.65 0 0 0-1.82.33l-.06.06a2 2 0 0 1-2.83 0 2 2 0 0 1 0-2.83l.06-.06a1.65 1.65 0 0 0 .33-1.82 1.65 1.65 0 0 0-1.51-1H3a2 2 0 0 1-2-2 2 2 0 0 1 2-2h.09A1.65 1.65 0 0 0 4.6 9a1.65 1.65 0 0 0-.33-1.82l-.06-.06a2 2 0 0 1 0-2.83 2 2 0 0 1 2.83 0l.06.06a1.65 1.65 0 0 0 1.82.33H9a1.65 1.65 0 0 0 1-1.51V3a2 2 0 0 1 2-2 2 2 0 0 1 2 2v.09a1.65 1.65 0 0 0 1 1.51 1.65 1.65 0 0 0 1.82-.33l.06-.06a2 2 0 0 1 2.83 0 2 2 0 0 1 0 2.83l-.06.06a1.65 1.65 0 0 0-.33 1.82V9a1.65 1.65 0 0 0 1.51 1H21a2 2 0 0 1 2 2 2 2 0 0 1-2 2h-.09a1.65 1.65 0 0 0-1.51 1z">
								    	</path>
								   		<circle  cx="12" cy="12" r="3"></circle>
								   	</svg>
						        </div>
						        <br>
						    </c:if>
						</c:forEach>
	               		</div>
	               		<br>
	               		<h3 style="color: black; margin-left: 5px; margin-top: 5px;">메뉴 상세 사진</h3>
	               		
	               		<c:if test="${!empty resto.menuList}">      <!--list 객체가 비어있지 않을때 실행-->   
				<div class="our-menu">
	       						<div class="our-menu-container">
	                   
			   			<c:forEach var="menu" items="${resto.menuList}" varStatus="status">       
			            	<div class="left-menu">     
					           	<div class="left-menu-container">
					              	<div style="display: flex;" onclick="fn_changeImages('${menu.menuSeq}', 1)">
					              		<img src="/resources/upload/${menu.fileName}" style="width:95px; height:95px;">
					              		<svg class="centered-svg" xmlns="http://www.w3.org/2000/svg" width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="#000000" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" style="cursor: pointer;">
									    	<path fill="white" d="M19.4 15a1.65 1.65 0 0 0 .33 1.82l.06.06a2 2 0 0 1 0 2.83 2 2 0 0 1-2.83 0l-.06-.06a1.65 1.65 0 0 0-1.82-.33 1.65 1.65 0 0 0-1 1.51V21a2 2 0 0 1-2 2 2 2 0 0 1-2-2v-.09A1.65 1.65 0 0 0 9 19.4a1.65 1.65 0 0 0-1.82.33l-.06.06a2 2 0 0 1-2.83 0 2 2 0 0 1 0-2.83l.06-.06a1.65 1.65 0 0 0 .33-1.82 1.65 1.65 0 0 0-1.51-1H3a2 2 0 0 1-2-2 2 2 0 0 1 2-2h.09A1.65 1.65 0 0 0 4.6 9a1.65 1.65 0 0 0-.33-1.82l-.06-.06a2 2 0 0 1 0-2.83 2 2 0 0 1 2.83 0l.06.06a1.65 1.65 0 0 0 1.82.33H9a1.65 1.65 0 0 0 1-1.51V3a2 2 0 0 1 2-2 2 2 0 0 1 2 2v.09a1.65 1.65 0 0 0 1 1.51 1.65 1.65 0 0 0 1.82-.33l.06-.06a2 2 0 0 1 2.83 0 2 2 0 0 1 0 2.83l-.06.06a1.65 1.65 0 0 0-.33 1.82V9a1.65 1.65 0 0 0 1.51 1H21a2 2 0 0 1 2 2 2 2 0 0 1-2 2h-.09a1.65 1.65 0 0 0-1.51 1z">
									    	</path>
									   		<circle  cx="12" cy="12" r="3"></circle>
									   	</svg>
					              	</div>
					              	<div onclick="fn_changeTexts('${menu.menuSeq}', 0)" style="display: flex;">
					              		<h4>${menu.menuName}</h4> 
					              		<svg style="margin-right: 10px;" class="centered-svg" xmlns="http://www.w3.org/2000/svg" width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="#000000" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" style="cursor: pointer;">
									    	<path fill="white" d="M19.4 15a1.65 1.65 0 0 0 .33 1.82l.06.06a2 2 0 0 1 0 2.83 2 2 0 0 1-2.83 0l-.06-.06a1.65 1.65 0 0 0-1.82-.33 1.65 1.65 0 0 0-1 1.51V21a2 2 0 0 1-2 2 2 2 0 0 1-2-2v-.09A1.65 1.65 0 0 0 9 19.4a1.65 1.65 0 0 0-1.82.33l-.06.06a2 2 0 0 1-2.83 0 2 2 0 0 1 0-2.83l.06-.06a1.65 1.65 0 0 0 .33-1.82 1.65 1.65 0 0 0-1.51-1H3a2 2 0 0 1-2-2 2 2 0 0 1 2-2h.09A1.65 1.65 0 0 0 4.6 9a1.65 1.65 0 0 0-.33-1.82l-.06-.06a2 2 0 0 1 0-2.83 2 2 0 0 1 2.83 0l.06.06a1.65 1.65 0 0 0 1.82.33H9a1.65 1.65 0 0 0 1-1.51V3a2 2 0 0 1 2-2 2 2 0 0 1 2 2v.09a1.65 1.65 0 0 0 1 1.51 1.65 1.65 0 0 0 1.82-.33l.06-.06a2 2 0 0 1 2.83 0 2 2 0 0 1 0 2.83l-.06.06a1.65 1.65 0 0 0-.33 1.82V9a1.65 1.65 0 0 0 1.51 1H21a2 2 0 0 1 2 2 2 2 0 0 1-2 2h-.09a1.65 1.65 0 0 0-1.51 1z">
									    	</path>
									   		<circle  cx="12" cy="12" r="3"></circle>
									   	</svg>
					              	</div>
					             	<h4 class="price" style="margin-right: 10px;"><a class="price-element">${menu.menuPrice}</a>원</h4>
				            		<div onclick="fn_changeTexts('${menu.menuSeq}', 1)" style="display: flex;">
					              		<h4>${menu.menuContent}</h4> 
					           			<svg  style="margin-right: 10px;" class="centered-svg" xmlns="http://www.w3.org/2000/svg" width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="#000000" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" style="cursor: pointer;">
									    	<path fill="white" d="M19.4 15a1.65 1.65 0 0 0 .33 1.82l.06.06a2 2 0 0 1 0 2.83 2 2 0 0 1-2.83 0l-.06-.06a1.65 1.65 0 0 0-1.82-.33 1.65 1.65 0 0 0-1 1.51V21a2 2 0 0 1-2 2 2 2 0 0 1-2-2v-.09A1.65 1.65 0 0 0 9 19.4a1.65 1.65 0 0 0-1.82.33l-.06.06a2 2 0 0 1-2.83 0 2 2 0 0 1 0-2.83l.06-.06a1.65 1.65 0 0 0 .33-1.82 1.65 1.65 0 0 0-1.51-1H3a2 2 0 0 1-2-2 2 2 0 0 1 2-2h.09A1.65 1.65 0 0 0 4.6 9a1.65 1.65 0 0 0-.33-1.82l-.06-.06a2 2 0 0 1 0-2.83 2 2 0 0 1 2.83 0l.06.06a1.65 1.65 0 0 0 1.82.33H9a1.65 1.65 0 0 0 1-1.51V3a2 2 0 0 1 2-2 2 2 0 0 1 2 2v.09a1.65 1.65 0 0 0 1 1.51 1.65 1.65 0 0 0 1.82-.33l.06-.06a2 2 0 0 1 2.83 0 2 2 0 0 1 0 2.83l-.06.06a1.65 1.65 0 0 0-.33 1.82V9a1.65 1.65 0 0 0 1.51 1H21a2 2 0 0 1 2 2 2 2 0 0 1-2 2h-.09a1.65 1.65 0 0 0-1.51 1z">
									    	</path>
									   		<circle  cx="12" cy="12" r="3"></circle>
									   	</svg>
					              	</div>
					           	</div>
				           	</div>
				    	</c:forEach>
				    </div>
			    </div>
			</c:if>
			</div>
	              	<h3 style="color: black; margin-left: 5px; margin-top: 20px;">리뷰 관리</h3><br>
		            <c:choose>
						<c:when test="${!empty reviewList}">
							<c:forEach var="review" items="${reviewList}" varStatus="status">                      
								<ul class="list-unstyled" id="_reviewList">
								    <li class="media" style="margin-bottom : 30px;" >
								        <img src="${review.fileName}" style="width: 75px; height:75px; object-fit:cover; border-radius:20px;" class="mr-3" alt="avata">
								        <div class="media-body" style="display: flex; justify-content: space-between; align-items: center;">
								            <div>
								                <h5 class="mt-0 mb-1" style="font-weight: bold; display: inline;">${review.userNickName}(${review.userId})</h5>
								                <b style="margin-top: -15px; margin-left:10px; color: lightgray; display: inline;">${review.regDate}</b>
								                <br />
								                <div class="review" style="display:flex;">              
								                  	<c:set var="starCount" value="${review.reviewScore}" />
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
								               <b id="commentContent" style="font-size: 17px; margin-top: 3px; max-width:1000px;" value="${review.reviewContent}">${review.reviewContent}</b>
								            </div>
								            <div>
								            	<img alt="" src="/resources/images/X_icon.png" style="width: 50px; height: 50px;" onclick="fn_deleteReview('${review.orderSeq}')">
								            </div>
								        </div>
								    </li>
								</ul>
					        </c:forEach>
						</c:when>
						<c:otherwise>
							<h3>작성된 리뷰가 없습니다.</h3>
						</c:otherwise>
					</c:choose>  
	            </div>
	        </div>
	    </div>
	</section>
</div>

	<script>
	document.getElementById('review-tab').addEventListener('click', function() 
	{
	    document.getElementById('_reviewList').scrollIntoView({behavior: 'smooth'});
	});
	</script>
</body>
</html>