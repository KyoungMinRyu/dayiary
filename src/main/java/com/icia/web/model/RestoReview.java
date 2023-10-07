package com.icia.web.model;

import java.io.Serializable;

public class RestoReview implements Serializable {

   private static final long serialVersionUID = 1L;

   private String orderSeq;
   private String reviewContent;
   private int reviewScore;
   private String rSeq;
   private String userId;
   private String fileName;
   private String userNickName;
   private String reservDate;
   private String productSeq; // 10/04추가
   private String regDate; 

   public RestoReview() {
      orderSeq = "";
      reviewContent = "";
      reviewScore = 0;
      rSeq = "";
      userId = "";
      fileName = "";
      userNickName = "";
      reservDate = "";
      productSeq = "";
      regDate = "";
   }

   public String getOrderSeq() {
      return orderSeq;
   }

   public void setOrderSeq(String orderSeq) {
      this.orderSeq = orderSeq;
   }

   public String getReviewContent() {
      return reviewContent;
   }

   public void setReviewContent(String reviewContent) {
      this.reviewContent = reviewContent;
   }

   public int getReviewScore() {
      return reviewScore;
   }

   public void setReviewScore(int reviewScore) {
      this.reviewScore = reviewScore;
   }

   public String getrSeq() {
      return rSeq;
   }

   public void setrSeq(String rSeq) {
      this.rSeq = rSeq;
   }

   public String getUserId() {
      return userId;
   }

   public void setUserId(String userId) {
      this.userId = userId;
   }

   public String getFileName() {
      return fileName;
   }

   public void setFileName(String fileName) {
      this.fileName = fileName;
   }

   public String getUserNickName() {
      return userNickName;
   }

   public void setUserNickName(String userNickName) {
      this.userNickName = userNickName;
   }

   public String getReservDate() {
      return reservDate;
   }

   public void setReservDate(String reservDate) {
      this.reservDate = reservDate;
   }

   public String getProductSeq() {
      return productSeq;
   }

   public void setProductSeq(String productSeq) {
      this.productSeq = productSeq;
   }

   public String getRegDate() {
      return regDate;
   }

   public void setRegDate(String regDate) {
      this.regDate = regDate;
   }

   
   
}