package com.icia.web.service;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;	
import org.springframework.stereotype.Service;

import com.icia.web.dao.AdminNoticeDao;
import com.icia.web.model.AdminNotice;

@Service("adminNoticeService")
public class AdminNoticeService
{
   private static Logger logger = LoggerFactory.getLogger(AdminNoticeService.class);
   
   @Autowired
   private AdminNoticeDao adminNoticeDao;
   
   //공지글 등록 
   public int adminNoticeInsert(AdminNotice adminNotice)
   {
      int count = 0;
      
      try
      {
         count = adminNoticeDao.adminNoticeInsert(adminNotice);
      }
      catch(Exception e)
      {
         logger.error("[AdminNoticeService] adminNoticeInsert Exception", e);
      }
      
      return count;
   }
   
   //공지글 리스트
   public List<AdminNotice> adminNoticeList(AdminNotice adminNotice)
   {
      List<AdminNotice> list = null;
   
      try
      {
         list = adminNoticeDao.adminNoticeList(adminNotice);
      }
      catch(Exception e)
      {
         logger.error("[AdminNoticeService] adminNoticeList Exception", e);
      }
      
      return list;
   }
   
   //총 공지글 수 조회
   public long adminNoticeListCount(AdminNotice adminNotice)
   {
      long count = 0;
      
      try
      {
         count = adminNoticeDao.adminNoticeListCount(adminNotice);
      }
      catch(Exception e)
      {
         logger.error("[AdminNoticeService] adminNoticeListCount Exception", e);
      }
      
      return count;
      
   }
   
   //공지글 조회
   public AdminNotice adminNoticeSelect(long BbsSeq)
   {
      AdminNotice adminNotice = null;
      
      try
      {
         adminNotice = adminNoticeDao.adminNoticeSelect(BbsSeq);
      }
      catch(Exception e)
      {
         logger.error("[AdminNoticeService] adminNoticeSelect Exception", e);
      }
   
      return adminNotice;
   }
   
   //공지글 보기
   public AdminNotice adminNoticeView(long BbsSeq)
   {
      AdminNotice adminNotice = null;
      
      try
      {
         adminNotice = adminNoticeDao.adminNoticeSelect(BbsSeq);
      }
      catch(Exception e)
      {
         logger.error("[AdminNoticeService] adminNoticeView Exception", e);
      }
      
      return adminNotice;
   }
   
   //공지글 수정폼 조회 
   public AdminNotice noticeViewUpdate(long bbsSeq)
   {
      AdminNotice adminNotice = null;
      
      try
      {
         adminNotice = adminNoticeDao.adminNoticeSelect(bbsSeq);
      }
      catch(Exception e)
      {
         logger.error("[AdminNoticeService] noticeViewUpdate Exception", e);
      }
      
      return adminNotice;
   }
   
   //공지글 수정
   public int noticeUpdate(AdminNotice adminNotice)
   {
      int count = 0;
      
      try
      {
         count = adminNoticeDao.noticeUpdate(adminNotice);
      }
      catch(Exception e)
      {
         logger.error("[AdminNoticeService] noticeUpdate Exception", e);
      }
      
      return count;
   }
   
   //공지글 삭제
   public int noticeDelete(long bbsSeq)
   {
      int count = 0;
      
      try 
      {
         AdminNotice adminNotice = adminNoticeSelect(bbsSeq);
      
         if(adminNotice != null)
         {
            count = adminNoticeDao.noticeDelete(bbsSeq);
         
         }
      }
      catch(Exception e)
      {
         logger.error("[AdminNoticeService] noticeDelete Exception", e);
      }
      return count;
      
   }
   
   
}