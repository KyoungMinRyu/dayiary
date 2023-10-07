package com.icia.web.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.icia.web.model.MainBoard;
import com.icia.web.model.MainBoardComment;
import com.icia.web.model.MainBoardFile;
import com.icia.web.model.MainBoardReaction;

@Repository("mainBoardDao")
public interface MainBoardDao 
{
   //게시물 등록
   public int boardInsert(MainBoard mainBoard);
   
   //게시물 첨부파일 등록
   public int boardFileInsert(MainBoardFile mainBoardFile);
   
   //게시물 리스트
   public List<MainBoard> boardList(MainBoard mainBoard);
   
   //총 게시물 수
   public long boardListCount(MainBoard mainBoard);
   
   //게시물 조회
   public MainBoard boardSelect(long boardSeq);
   
   //게시물 첨부파일 조회
   public List<MainBoardFile> boardFileSelect(long boardSeq);
   
   //게시물 조회수 증가
   public int boardReadCntPlus(long boardSeq);
   
   //게시물 삭제 시 모든 좋아요 삭제
   public int likeDeleteAll(long boardSeq);
   
   //게시물 그룹 순서 변경
   public int boardGroupOrderUpdate(MainBoard mainBoard);
   
   //게시물 답글 등록
   public int boardReplyInsert(MainBoard mainBoard);
   
   //게시물 수정
   public int boardUpdate(MainBoard mainBoard);
   
   //게시물 첨부파일 삭제
   public int boardFileDelete(long boardSeq);
   
   //게시물 삭제
   public int boardDelete(long boardSeq);
   
   //게시물 삭제시 자식게시물 조회
   public int boardAnswersCount(long boardSeq);
   
   //댓글 등록
   public int commentInsert(MainBoardComment mainBoardComment);
   
   //댓글 존재여부 조회(개수)
   public int commentCount(long boardSeq);
   
   //댓글 선택(해당댓글 하나만 - 댓글 삭제용)
   public MainBoardComment commentSelect(long commentSeq);
   
   //댓글 리스트(게시물에 달린 댓글 전체 - 댓글 출력용)
   public List<MainBoardComment> commentList(long boardSeq);
   
   //댓글 삭제
   public int commentDelete(long commentSeq);
   
   //게시물 삭제시 댓글 모두 삭제
   public int commentDeleteAll(long boardSeq);
   
   //댓글 수정
   public int commentUpdate(MainBoardComment mainBoardComment);
   
   //댓글의 답댓글 등록
   public int commentReplyInsert(MainBoardComment mainBoardComment);
   
   //답댓글들의 order 번호 1씩 증가
   public int commentGroupOrderUpdate(MainBoardComment mainBoardComment);
   
   //게시물 좋아요 인서트
   public int likeInsert(MainBoardReaction mainBoardReaction);
   
   //게시물 좋아요 취소 시 레코드 삭제
   public int likeDelete(MainBoardReaction mainBoardReaction);
   
   //게시물 좋아요 여부 확인
   public int likeCheck(MainBoardReaction mainBoardReaction);
   
   //해당 게시물 총 좋아요 개수
   public int likeCount(long boardSeq);
   
   //댓글 삭제시 답댓글이 있는지 조회
   public int replyCheck(long commentSeq);
   
   //답글이 존재하면 '삭제된 댓글입니다.'라고 업데이트
   public int deleteUpdate(long commentSeq);
   
   //부모댓글도 답글일 경우의 order 체크
   public int orderCheck(long commentSeq);
   
   //부모댓글이 답글이 아닌 조상댓글일 경우의 order 체크
   public int orderCheckZero(long commentSeq);
   
      
}