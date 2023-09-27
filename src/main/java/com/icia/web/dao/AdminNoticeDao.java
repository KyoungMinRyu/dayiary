package com.icia.web.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.icia.web.model.AdminNotice;

@Repository("adminNoticeDao")
public interface AdminNoticeDao 
{
   //공지글 등록
   public int adminNoticeInsert(AdminNotice adminNotice);
   
   //공지글 리스트 
   public List<AdminNotice> adminNoticeList(AdminNotice adminNotice);
   
   //총 공지글 수
   public long adminNoticeListCount(AdminNotice adminNotice);

   //공지글 조회
   public AdminNotice adminNoticeSelect(long BbsSeq);
   
   //공지글 삭제
   public int noticeDelete(long bbsSeq);
   
   //게시물 수정
   public int noticeUpdate(AdminNotice adminNotice);
   
}