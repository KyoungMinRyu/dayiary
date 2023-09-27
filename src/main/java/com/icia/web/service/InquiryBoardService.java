package com.icia.web.service;

import java.util.ArrayList;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.icia.common.util.FileUtil;
import com.icia.common.util.StringUtil;
import com.icia.web.dao.InquiryBoardDao;
import com.icia.web.model.InquiryBoard;
import com.icia.web.model.InquiryBoardFile;
import com.icia.web.model.InquiryBoardInfo;

@Service("inquiryBoardService")
public class InquiryBoardService
{
   private static Logger logger = LoggerFactory.getLogger(InquiryBoardService.class);
   
   @Value("#{env['upload.save.dir']}")
   private String UPLOAD_SAVE_DIR;
   
   @Autowired
   private InquiryBoardDao inquiryBoardDao;
   
   
   //문의글 등록
   @Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class) 
   public int inquiryBoardInsert(InquiryBoard inquiryBoard) throws Exception   
   {   
      
      int count = 0;
      
      count = inquiryBoardDao.inquiryBoardInsert(inquiryBoard);   
      
      if(count > 0 && inquiryBoard.getInquiryBoardFile() != null)   
      {

         for(int f=0; f < inquiryBoard.getInquiryBoardFile().size(); f++) 
         {
            inquiryBoard.getInquiryBoardFile().get(f).setQnaSeq(inquiryBoard.getQnaSeq());
            //다중 파일 업로드시 inquiryBoard에 게시물 번호인 QnaSeq값을 for문을 통해 동일하게 담아준다 (게시글번호랑 해당게시물에 담기는 파일에 게시물 번호는 같아야함!_다중파일이라도 qnaSeq는 다 동일!)
         
            inquiryBoardDao.inquiryBoardFileInsert(inquiryBoard.getInquiryBoardFile().get(f));   //for문을 통해 list형태에 담긴 파일들을 한개씩 insert해준다
         }
      }
      
      return count;
   }
   
   
   //문의글쓰기 화면 셀렉트박스 product 조회
   public List<InquiryBoardInfo> productSelect()
   {
      List<InquiryBoardInfo> list1 = null;
      
      try
      {
         list1 = inquiryBoardDao.productSelect();
      }
      catch(Exception e)
      {
         logger.error("[InquiryBoardService] productSelect Exception", e);
      }
      
      return list1;
   }
   
   
   //문의글쓰기 화면 셀렉트박스 Resto 조회
   public List<InquiryBoardInfo> restoSelect()
   {
      List<InquiryBoardInfo> list2 = null;
      
      try
      {
         list2 = inquiryBoardDao.restoSelect();
      }
      catch(Exception e)
      {
         logger.error("[InquiryBoardService] restoSelect Exception", e);
      }
      
      return list2;
   }
   
   
   //문의글쓰기 화면 셀렉트박스 예약,선물(본인이 구매한) 조회
   public List<InquiryBoard> seqSelect(String userId)
   {
      List<InquiryBoard> list = null;
   
      try
      {
         list = inquiryBoardDao.seqSelect(userId);
      }
      catch(Exception e)
      {
         logger.error("[InquiryBoardService] seqSelect Exception", e);
      }
      
      return list;
   }

   
   //문의사항 게시판 리스트(사용자, 관리자)
   public List<InquiryBoard> inquiryBoardList(InquiryBoard inquiryBoard)
   {
      List<InquiryBoard> list = null;
   
      try
      {
         list = inquiryBoardDao.inquiryBoardList(inquiryBoard);
      }
      catch(Exception e)
      {
         logger.error("[InquiryBoardService] inquiryBoardList Exception", e);
      }
      
      return list;
   }
   
   
   //문의사항 게시판 총 게시물 수 조회(사용자, 관리자)
   public long inquiryBoardListCount(InquiryBoard inquiryBoard)
   {
      long count = 0;
      
      try
      {
         count = inquiryBoardDao.inquiryBoardListCount(inquiryBoard);
      }
      catch(Exception e)
      {
         logger.error("[InquiryBoardService] inquiryBoardListCount Exception", e);
      }
   
      return count;
   }
   
   
   //문의사항 게시판 총 게시물 수 조회(판매자)
   public long inquirySellerBoardListCount(InquiryBoard inquiryBoard)
   {
      long count = 0;
      
      try
      {
         count = inquiryBoardDao.inquirySellerBoardListCount(inquiryBoard);
      }
      catch(Exception e)
      {
         logger.error("[InquiryBoardService] inquirySellerBoardListCount Exception", e);
      }
   
      return count;
   } 
   
   
   //문의사항 게시판 리스트(판매자)
   public List<InquiryBoard> inquirySellerBoardList(InquiryBoard inquiryBoard)
   {
      List<InquiryBoard> list = null;
   
      try
      {
         list = inquiryBoardDao.inquirySellerBoardList(inquiryBoard);
      }
      catch(Exception e)
      {
         logger.error("[InquiryBoardService] inquirySellerBoardList Exception", e);
      }
      
      return list;
   }

   
   //문의글 조회(삭제-사용자,관리자,판매자)
   public InquiryBoard inquiryBoardSelect(long qnaSeq, String orderGubun, String userId)
   {
      InquiryBoard inquiryBoard = new InquiryBoard();
      
      inquiryBoard.setQnaSeq(qnaSeq);
      inquiryBoard.setUserId(userId);
      
      try
      {
         if(StringUtil.equals(orderGubun, "R"))
         {   //레스토랑정보
            inquiryBoard = inquiryBoardDao.inquiryBoardRSelect(inquiryBoard);
         }
         else
         {   //선물정보 'P'
            inquiryBoard = inquiryBoardDao.inquiryBoardPSelect(inquiryBoard);
         }
      }
      catch(Exception e)
      {
         inquiryBoard = null;
         logger.error("[InquiryBoardService] inquiryBoardSelect Exception", e);
      }
   
      return inquiryBoard;
   }
   
   
   //문의글 보기(첨부파일 포함/ 사용자, 관리자, 판매자)
   public InquiryBoard inquiryView(long qnaSeq, String orderGubun, String userId)
   {
      InquiryBoard inquiryBoard = new InquiryBoard();
      
      inquiryBoard.setQnaSeq(qnaSeq);
      inquiryBoard.setUserId(userId);
      
      try
      {
         if(StringUtil.equals(orderGubun, "R"))
         {   //레스토랑정보
            inquiryBoard = inquiryBoardDao.inquiryBoardRSelect(inquiryBoard);
         }
         else
         {   //선물정보 'P'
            inquiryBoard = inquiryBoardDao.inquiryBoardPSelect(inquiryBoard);
         }
         
         if(inquiryBoard != null)
         {
            List<InquiryBoardFile> inquiryBoardFileList = inquiryBoardDao.inquiryBoardFileSelect(qnaSeq);
            
            if(inquiryBoardFileList != null)
            {
               inquiryBoard.setInquiryBoardFile(inquiryBoardFileList);
            }
         }
      }
      catch(Exception e)
      {
         inquiryBoard = null;   //위에서 객체에 담아서 서비스 단에서 XML 쪽으로 보내기 때문에 만일 예외발생시 inquiryBoard에 담긴 값을 null처리 해주어야 함.
         logger.error("[InquiryBoardService] inquiryView Exception", e);
      }
      
      return inquiryBoard;
   }
   
   
   //첨부 파일 조회
   public List<InquiryBoardFile> inquiryBoardFileSelect(long qnaSeq)
   {
      List<InquiryBoardFile> inquiryBoardFileList = new ArrayList<InquiryBoardFile>();
      
      try
      {
         inquiryBoardFileList = inquiryBoardDao.inquiryBoardFileSelect(qnaSeq);
      }
      catch(Exception e)
      {
         logger.error("[InquiryBoardService] inquiryBoardFileSelect Exception", e);
      }
      
      return inquiryBoardFileList;
   }
   
   
   //문의글 수정폼 조회 (첨부파일 포함)
   public InquiryBoard inquiryBoardViewUpdate(long qnaSeq, String orderGubun, String userId)
   {

      InquiryBoard inquiryBoard = new InquiryBoard();
      
      inquiryBoard.setQnaSeq(qnaSeq);
      inquiryBoard.setUserId(userId);
      
      try
      {
         if(StringUtil.equals(orderGubun, "R"))
         {   //레스토랑정보
            inquiryBoard = inquiryBoardDao.inquiryBoardRSelect(inquiryBoard);
         }
         else
         {   //선물정보 'P'
            inquiryBoard = inquiryBoardDao.inquiryBoardPSelect(inquiryBoard);
         }
         
         if(inquiryBoard != null)
         {
            List<InquiryBoardFile> inquiryBoardFileList = new ArrayList<InquiryBoardFile>();
            
            
            inquiryBoardFileList = inquiryBoardDao.inquiryBoardFileSelect(qnaSeq);
            
            if(inquiryBoardFileList != null)
            {
               inquiryBoard.setInquiryBoardFile(inquiryBoardFileList);
            }
         }
      }
      catch(Exception e)
      {
         logger.error("[InquiryBoardService] inquiryBoardViewUpdate Exception", e);
      }
      
      return inquiryBoard;
   }
      
      
   //문의글 수정
   @Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
   public int inquiryBoardUpdate(InquiryBoard inquiryBoard) throws Exception
   {
      int count = inquiryBoardDao.inquiryBoardUpdate(inquiryBoard);
      
      if(count > 0 && inquiryBoard.getInquiryBoardFile() != null)
      {
         List<InquiryBoardFile> delInquiryBoardFileList = inquiryBoardDao.inquiryBoardFileSelect(inquiryBoard.getQnaSeq());
         
         //기존 파일이 있을 경우 삭제
         if(delInquiryBoardFileList != null)
         {
            for(int f=0; f<delInquiryBoardFileList.size(); f++)
            {   
               FileUtil.deleteFile(UPLOAD_SAVE_DIR + FileUtil.getFileSeparator() + delInquiryBoardFileList.get(f).getFileName());
               //UPLOAD_SAVE_DIR경로 + FileUtil.getFileSeparator()는 getFile메서드에 있는 디렉토리 구분자를 얻어오는것(즉, \를 의미) + delHiBoardFile.getFileName() 저장한 유효이름값을 가져온 것
            }
            
            inquiryBoardDao.inquiryBoardFileDelete(inquiryBoard.getQnaSeq()); 
         }

         InquiryBoardFile inquiryBoardFile = null;
         
         for(int f=0; f<inquiryBoard.getInquiryBoardFile().size(); f++)
         {
            inquiryBoardFile = inquiryBoard.getInquiryBoardFile().get(f);
            inquiryBoardFile.setQnaSeq(inquiryBoard.getQnaSeq());
         
            inquiryBoardDao.inquiryBoardFileInsert(inquiryBoard.getInquiryBoardFile().get(f));   
         }   
      
      }
      
      return count;
   }
   
      
   //문의글 삭제시 답변글 수 조회
   public int inquiryBoardAnswersCount(long qnaSeq)
   {
      int count = 0;
      
      try
      {
         count = inquiryBoardDao.inquiryBoardAnswersCount(qnaSeq);
      }
      catch(Exception e)
      {
         logger.error("[InquiryBoardService] inquiryBoardAnswersCount Exception", e);
      }
         
      return count;
   }
   

   //문의글 삭제(첨부파일이 있으면 함께 삭제)
   @Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
   public int inquiryBoardDelete(long qnaSeq, String orderGubun, String userId) throws Exception
   {
      int count = 0;
      
      InquiryBoard inquiryBoard = inquiryBoardViewUpdate(qnaSeq, orderGubun, userId);
      
      if(inquiryBoard != null)
      {
         
         if(inquiryBoard.getInquiryBoardFile() != null)
         {
            List<InquiryBoardFile> delInquiryBoardFileList = inquiryBoard.getInquiryBoardFile();
            
            if(delInquiryBoardFileList != null)
            {
               if(inquiryBoardDao.inquiryBoardFileDelete(qnaSeq) > 0)
               {
                  for(int f=0; f<delInquiryBoardFileList.size(); f++)
                  {   
                     FileUtil.deleteFile(UPLOAD_SAVE_DIR + FileUtil.getFileSeparator() + delInquiryBoardFileList.get(f).getFileName());
                     //UPLOAD_SAVE_DIR경로 + FileUtil.getFileSeparator()는 getFile메서드에 있는 디렉토리 구분자를 얻어오는것(즉, \를 의미) + delHiBoardFile.getFileName() 저장한 유효이름값을 가져온 것
                  }
               }
               
            }
         }
         
         inquiryBoardDao.inquiryBoardDeleteReplyStatusUpdate(inquiryBoard);     
         count = inquiryBoardDao.inquiryBoardDelete(qnaSeq);
      }
      
      return count;
   }
   
   
   //문의글 답글 등록
   @Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
   public int inquiryBoardReplyInsert(InquiryBoard inquiryBoard) throws Exception
   {
      int count = 0;
      
      inquiryBoardDao.inquiryBoardAddReplyStatusUpdate(inquiryBoard);
      inquiryBoardDao.inquiryBoardGroupOrderUpdate(inquiryBoard);     
      count = inquiryBoardDao.inquiryBoardReplyInsert(inquiryBoard); 

      //게시물이 정상등록 되고나면 첨부파일이 존재하면 첨부파일도 등록
      if(count > 0 && inquiryBoard.getInquiryBoardFile() != null)   
      {
         for(int f=0; f < inquiryBoard.getInquiryBoardFile().size(); f++) 
         {
            inquiryBoard.getInquiryBoardFile().get(f).setQnaSeq(inquiryBoard.getQnaSeq());
            //다중 파일 업로드시 inquiryBoard에 게시물 번호인 QnaSeq값을 for문을 통해 동일하게 담아준다 (게시글번호랑 해당게시물에 담기는 파일에 게시물 번호는 같아야함!_다중파일이라도 qnaSeq는 다 동일!)
         
            inquiryBoardDao.inquiryBoardFileInsert(inquiryBoard.getInquiryBoardFile().get(f));   //for문을 통해 list형태에 담긴 파일들을 한개씩 insert해준다
         }
      }   
      
      return count;
      
   }
   
}