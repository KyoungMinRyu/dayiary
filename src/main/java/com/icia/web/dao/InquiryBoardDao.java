package com.icia.web.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.icia.web.model.InquiryBoard;
import com.icia.web.model.InquiryBoardFile;
import com.icia.web.model.InquiryBoardInfo;

@Repository("inquiryBoardDao")
public interface InquiryBoardDao 
{
   //문의글 등록
   public int inquiryBoardInsert(InquiryBoard inquiryBoard);
   
   //문의글 첨부파일 등록
   public int inquiryBoardFileInsert(InquiryBoardFile inquiryBoardFile);
   
   //문의글쓰기 화면 셀렉트박스 product 조회
   public List<InquiryBoardInfo> productSelect();
   
   //문의글쓰기 화면 셀렉트박스 Resto 조회
   public List<InquiryBoardInfo> restoSelect();

   //문의글쓰기 화면 셀렉트박스 예약,선물(본인이 구매한) 조회
   public List<InquiryBoard> seqSelect(String userId);
   
   //문의글 리스트(사용자, 관리자)
   public List<InquiryBoard> inquiryBoardList(InquiryBoard inquiryBoard);
   
   //총 문의글 수(사용자, 관리자)
   public long inquiryBoardListCount(InquiryBoard inquiryBoard);
   
   //문의글 리스트(판매자)
   public List<InquiryBoard> inquirySellerBoardList(InquiryBoard inquiryBoard);
   
   //총 문의글 수(판매자)
   public long inquirySellerBoardListCount(InquiryBoard inquiryBoard);
   
   //문의글 조회(레스토랑)
   public InquiryBoard inquiryBoardRSelect(InquiryBoard inquiryBoard);
   
   //문의글 조회(선물)
   public InquiryBoard inquiryBoardPSelect(InquiryBoard inquiryBoard);

   //문의글 첨부파일 조회
   public List<InquiryBoardFile> inquiryBoardFileSelect(long qnaSeq);
   
   //문의글 수정
   public int inquiryBoardUpdate(InquiryBoard inquiryBoard);
   
   //문의글 첨부 파일 삭제
   public int inquiryBoardFileDelete(long qnaSeq);
   
   //문의글 삭제
   public int inquiryBoardDelete(long qnaSeq);
   
   //문의글 삭제시 답변글 조회
   public int inquiryBoardAnswersCount(long qnaSeq);
   
   //문의글 그룹 순서 변경
   public int inquiryBoardGroupOrderUpdate(InquiryBoard inquiryBoard);
   
   //문의글 답글 등록
   public int inquiryBoardReplyInsert(InquiryBoard inquiryBoard);
   
   //문의글 답변상태 변경("Y")
   public int inquiryBoardAddReplyStatusUpdate(InquiryBoard inquiryBoard);
   
   //문의글 답변상태 변경("N")
   public int inquiryBoardDeleteReplyStatusUpdate(InquiryBoard inquiryBoard);

}