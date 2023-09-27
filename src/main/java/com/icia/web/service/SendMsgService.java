package com.icia.web.service;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.icia.web.dao.SendMsgDao;
import com.icia.web.model.MainBoardComment;
import com.icia.web.model.Msg;

@Service("sendMsgService")
public class SendMsgService 
{
   private static Logger logger = LoggerFactory.getLogger(SendMsgService.class);
   
   @Autowired
   private SendMsgDao sendMsgDao;
   
   public int sendMsg(Msg msg)
   {
      int count = 0;
      try 
      {
         count = sendMsgDao.sendMsg(msg);
      }
      catch (Exception e) 
      {
         logger.error("[SendMsgService](sendMsg)", e);
      }
      return count;
   }
   
   
   public int toCount(String cookieUserId)
   {
      int count = 0;
      try 
      {
         count = sendMsgDao.toCount(cookieUserId);
      }
      catch (Exception e) 
      {
         logger.error("[SendMsgService](toCount)", e);
      }
      return count;
   }
   
   public int fromCount(String cookieUserId)
   {
      int count = 0;
      try 
      {
         count = sendMsgDao.fromCount(cookieUserId);
      }
      catch (Exception e) 
      {
         logger.error("[SendMsgService](fromCount)", e);
      }
      return count;
   }
   
   public List<Msg> currentList(String cookieUserId)
   {
      List<Msg> currentList = null;
      try 
      {
         currentList = sendMsgDao.currentList(cookieUserId);
      }
      catch (Exception e) 
      {
         logger.error("[SendMsgService](currentList)", e);
      }
      return currentList;
   }
   
   public List<Msg> postList(Msg search)
   {
      List<Msg> postList = null;
      try 
      {
         postList = sendMsgDao.postList(search);
      }
      catch (Exception e) 
      {
         logger.error("[SendMsgService](postList)", e);
      }
      return postList;
   }
   
   public int readUpdate(Msg update)
   {
      int count = 0;
      
      try
      {
         count = sendMsgDao.readUpdate(update);
         
      }
      catch(Exception e)
      {
         logger.error("[SendMsgService]readUpdate Exception", e);
      }
      
         
       return count;
   }   
   
   
   
   
   
}


