package com.icia.web.model;

import java.io.Serializable;

public class MainBoardReaction implements Serializable {
   private static final long serialVersionUID = 1L;
   
   private String userId;
   private long boardSeq;
   

   public MainBoardReaction()
   {
      userId = "";
      boardSeq = 0;
   }


   public String getUserId() {
      return userId;
   }


   public void setUserId(String userId) {
      this.userId = userId;
   }


   public long getBoardSeq() {
      return boardSeq;
   }


   public void setBoardSeq(long boardSeq) {
      this.boardSeq = boardSeq;
   }
   
}