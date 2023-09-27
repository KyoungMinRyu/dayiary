package com.icia.web.model;

import java.io.Serializable;

public class Delivery implements Serializable{

   private static final long serialVersionUID = 1L;

   private String deliverCompany;         //배송사
   private String orderAddress;          //사용자 배송지
   private String orderNum;            //운송장 번호
   private String orderSeq;             //주문 번호
   private String orderMsg;            //배송 요청 메시지

   
   public Delivery()
   {
      deliverCompany = "";
      orderAddress = "";
      orderNum = "";
      orderSeq = "";
      orderMsg = "";
   }

   public String getDeliverCompany() {
      return deliverCompany;
   }

   public void setDeliverCompany(String deliverCompany) {
      this.deliverCompany = deliverCompany;
   }

   public String getOrderAddress() {
      return orderAddress;
   }

   public void setOrderAddress(String orderAddress) {
      this.orderAddress = orderAddress;
   }

   public String getOrderNum() {
      return orderNum;
   }

   public void setOrderNum(String orderNum) {
      this.orderNum = orderNum;
   }

   public String getOrderSeq() {
      return orderSeq;
   }

   public void setOrderSeq(String orderSeq) {
      this.orderSeq = orderSeq;
   }

   public String getOrderMsg() {
      return orderMsg;
   }

   public void setOrderMsg(String orderMsg) {
      this.orderMsg = orderMsg;
   }
   
   
}