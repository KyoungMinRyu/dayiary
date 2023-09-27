package com.icia.web.model;

import java.io.Serializable;

public class MainBoardComment implements Serializable {

   private static final long serialVersionUID = 1L;

   private long boardSeq;
   private long commentSeq;
   private String userId;
   private long commentGroup;
   private int commentOrder;
   private int commentIndent;
   private String commentContent;
   private long commentParent;
   private String regDate;

   private String userName;
   private String userNickName;
   private String status;
   private String fileName;

   public MainBoardComment() {
      boardSeq = 0;
      commentSeq = 0;
      userId = "";
      commentGroup = 0;
      commentOrder = 1;
      commentIndent = 0;
      commentContent = "";
      commentParent = 0;
      regDate = "";

      userName = "";
      userNickName = "";
      status = "";
      fileName = "";
   }
   

   public String getFileName() {
      return fileName;
   }

   public void setFileName(String fileName) {
      this.fileName = fileName;
   }

   public String getStatus() {
      return status;
   }

   public void setStatus(String status) {
      this.status = status;
   }

   public String getUserName() {
      return userName;
   }

   public void setUserName(String userName) {
      this.userName = userName;
   }

   public String getUserNickName() {
      return userNickName;
   }

   public void setUserNickName(String userNickName) {
      this.userNickName = userNickName;
   }

   public long getBoardSeq() {
      return boardSeq;
   }

   public void setBoardSeq(long boardSeq) {
      this.boardSeq = boardSeq;
   }

   public long getCommentSeq() {
      return commentSeq;
   }

   public void setCommentSeq(long commentSeq) {
      this.commentSeq = commentSeq;
   }

   public String getUserId() {
      return userId;
   }

   public void setUserId(String userId) {
      this.userId = userId;
   }

   public long getCommentGroup() {
      return commentGroup;
   }

   public void setCommentGroup(long commentGroup) {
      this.commentGroup = commentGroup;
   }

   public int getCommentOrder() {
      return commentOrder;
   }

   public void setCommentOrder(int commentOrder) {
      this.commentOrder = commentOrder;
   }

   public int getCommentIndent() {
      return commentIndent;
   }

   public void setCommentIndent(int commentIndent) {
      this.commentIndent = commentIndent;
   }

   public String getCommentContent() {
      return commentContent;
   }

   public void setCommentContent(String commentContent) {
      this.commentContent = commentContent;
   }

   public long getCommentParent() {
      return commentParent;
   }

   public void setCommentParent(long commentParent) {
      this.commentParent = commentParent;
   }

   public String getRegDate() {
      return regDate;
   }

   public void setRegDate(String regDate) {
      this.regDate = regDate;
   }

}