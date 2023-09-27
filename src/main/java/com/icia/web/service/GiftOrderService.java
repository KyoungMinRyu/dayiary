package com.icia.web.service;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.icia.web.dao.GiftOrderDao;
import com.icia.web.model.Delivery;
import com.icia.web.model.KakaoPayApprove2;
import com.icia.web.model.OrderList;

@Service("giftOrderService")

public class GiftOrderService {

   @Autowired
   private GiftOrderDao giftOrderDao;
   
   private static Logger logger = LoggerFactory.getLogger(GiftOrderService.class);
   
   //선물 결제 완료 전 INSERT(STATUS W)
   public int giftOrderListInsert(OrderList orderList)
   {
        int count = 0;
         
         try
         {
            count = giftOrderDao.giftOrderListInsert(orderList);
         }
         catch(Exception e)
         {
            logger.error("[GiftOrderService] giftOrderListInsert Exception", e);
         }
      
         return count;
         
   }
   
   //선물 결제 완료 후 PAY_LIST INSERT
   public int giftPayListInsert(KakaoPayApprove2 giftPayList)
   {
      int count = 0;
      
      try
      {
         count = giftOrderDao.giftPayListInsert(giftPayList);
      }
      catch(Exception e)
      {
         logger.error("[GiftOrderService] giftPayListInsert Exception", e);
      }
      
      return count;
   }
   
   //선물 결제 완료 후 ORDER_LIST (STATUS W -> Y) UPDATE
   public int giftOrderListUpdate(String orderSeq)
   {
      int count = 0;
      
      try
      {
         count = giftOrderDao.giftOrderListUpdate(orderSeq);
      }
      catch(Exception e)
      {
         logger.error("[GiftOrderService] giftOrderListUpdate Exception", e);
      }
      
      return count;
      
   }
   
   //선물 결제 완료 후 Delivery Insert
   public int deliveryInsert(Delivery delivery)
   {
      int count = 0;
      
      try
      {
         count =giftOrderDao.deliveryInsert(delivery);
      }
      catch(Exception e)
      {
         logger.error("[GiftOrderService] deliveryInsert Exception", e);
      }
      
      return count;
   }
   
   
}