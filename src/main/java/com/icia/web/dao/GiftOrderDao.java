package com.icia.web.dao;

import org.springframework.stereotype.Repository;

import com.icia.web.model.Delivery;
import com.icia.web.model.KakaoPayApprove2;
import com.icia.web.model.OrderList;

@Repository("giftOrderDao")
public interface GiftOrderDao {

   //선물 결제 완료 전 INSERT(STATUS W)
   public int giftOrderListInsert(OrderList orderList);

   
   //선물 결제 완료 후 PAY_LIST INSERT
   public int giftPayListInsert(KakaoPayApprove2 giftPayList);
   
   //선물 결제 완료 후 ORDER_LIST (STATUS W -> Y) UPDATE
   public int giftOrderListUpdate(String orderSeq);
   
   //선물 결제 완료 후 Delivery Insert
   public int deliveryInsert(Delivery delivery);
}