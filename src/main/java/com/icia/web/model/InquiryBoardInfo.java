package com.icia.web.model;

import java.io.Serializable;

public class InquiryBoardInfo implements Serializable
{

   private static final long serialVersionUID = 1L;
   
   //PRODUCT_INFO
    private String productSeq;         //상품 시퀀스 번호
    private String pName;            //상품명
    private String pSellerId;         //상품 판매자 아이디
    private String pPrice;            //상품 가격
    private String pContent;         //상품 설명
    private String pRegDate;         //상품 등록일
    private String pStatus;         //상품 상태(Y:공개, N:비공개)
    
   //RESTO_INFO
    private String rSeq;            //예약 시퀀스 번호
    private String restoName;         //식당 이름
    private String rSellerId;         //식당 판매자
    private String restoAddress;      //식당 주소
    private String restoPh;         //식당 번호
    private String restoContent;      //식당 소개
    private String rRegDate;         //식당 등록일
    private String rStatus;         //식당 상태(Y:공개, N:비공개)
    private String restoType;         //식당 종류
    private String foodType;         //음식 종류(한식, 중식, 일식)
    private String restoOff;         //식당 휴무일
    private String restoOpen;         //식당 영업시작시간
    private String restoClose;         //식당 영업종료시간
    private int restoDeposit;         //식당 예약금
    private int limitPerson;         //시간당 예약가능 인원수
    

      public InquiryBoardInfo()
      {
         productSeq = "";
         pName = "";
         pSellerId = "";
         pPrice = "";
         pContent = "";
         pRegDate = "";
         pStatus = "";
         
         
         rSeq = "";
         restoName = "";
         rSellerId = "";
         restoAddress = "";
         restoPh = "";
         restoContent = "";
         rRegDate = "";
         rStatus = "";
         restoType = "";
         foodType = "";
         restoOff = "";
         restoOpen = "";
         restoClose = "";
         restoDeposit = 0;
         limitPerson = 0;
            
      }


      public String getProductSeq() {
         return productSeq;
      }


      public void setProductSeq(String productSeq) {
         this.productSeq = productSeq;
      }


      public String getpName() {
         return pName;
      }


      public void setpName(String pName) {
         this.pName = pName;
      }


      public String getpSellerId() {
         return pSellerId;
      }


      public void setpSellerId(String pSellerId) {
         this.pSellerId = pSellerId;
      }


      public String getpPrice() {
         return pPrice;
      }


      public void setpPrice(String pPrice) {
         this.pPrice = pPrice;
      }


      public String getpContent() {
         return pContent;
      }


      public void setpContent(String pContent) {
         this.pContent = pContent;
      }


      public String getpRegDate() {
         return pRegDate;
      }


      public void setpRegDate(String pRegDate) {
         this.pRegDate = pRegDate;
      }


      public String getpStatus() {
         return pStatus;
      }


      public void setpStatus(String pStatus) {
         this.pStatus = pStatus;
      }


      public String getrSeq() {
         return rSeq;
      }


      public void setrSeq(String rSeq) {
         this.rSeq = rSeq;
      }


      public String getRestoName() {
         return restoName;
      }


      public void setRestoName(String restoName) {
         this.restoName = restoName;
      }


      public String getrSellerId() {
         return rSellerId;
      }


      public void setrSellerId(String rSellerId) {
         this.rSellerId = rSellerId;
      }


      public String getRestoAddress() {
         return restoAddress;
      }


      public void setRestoAddress(String restoAddress) {
         this.restoAddress = restoAddress;
      }


      public String getRestoPh() {
         return restoPh;
      }


      public void setRestoPh(String restoPh) {
         this.restoPh = restoPh;
      }


      public String getRestoContent() {
         return restoContent;
      }


      public void setRestoContent(String restoContent) {
         this.restoContent = restoContent;
      }


      public String getrRegDate() {
         return rRegDate;
      }


      public void setrRegDate(String rRegDate) {
         this.rRegDate = rRegDate;
      }


      public String getrStatus() {
         return rStatus;
      }


      public void setrStatus(String rStatus) {
         this.rStatus = rStatus;
      }


      public String getRestoType() {
         return restoType;
      }


      public void setRestoType(String restoType) {
         this.restoType = restoType;
      }


      public String getFoodType() {
         return foodType;
      }


      public void setFoodType(String foodType) {
         this.foodType = foodType;
      }


      public String getRestoOff() {
         return restoOff;
      }


      public void setRestoOff(String restoOff) {
         this.restoOff = restoOff;
      }


      public String getRestoOpen() {
         return restoOpen;
      }


      public void setRestoOpen(String restoOpen) {
         this.restoOpen = restoOpen;
      }


      public String getRestoClose() {
         return restoClose;
      }


      public void setRestoClose(String restoClose) {
         this.restoClose = restoClose;
      }


      public int getRestoDeposit() {
         return restoDeposit;
      }


      public void setRestoDeposit(int restoDeposit) {
         this.restoDeposit = restoDeposit;
      }


      public int getLimitPerson() {
         return limitPerson;
      }


      public void setLimitPerson(int limitPerson) {
         this.limitPerson = limitPerson;
      }
      
      
      
}