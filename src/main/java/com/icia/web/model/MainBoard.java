package com.icia.web.model;

import java.io.Serializable;
import java.util.List;

public class MainBoard implements Serializable
{

   private static final long serialVersionUID = 1L;
   
   private long boardSeq;
   private String userId;
   private String boardTitle;
   private String boardContent;
   private int readCnt;
   private String regDate;
   private String boardType;
   
   private String userName;      //사용자 이름
   private String userNickName;
   private String userEmail;      //사용자 이메일
   
   private long startRow;      //시작 rownum
   private long endRow;         //끝 rownum
   
   private String searchType;   //1:게시물제목 2:게시물내용 3:작성자닉네임 4:작성자아이디(&쿠키유저) 5.작성자이름
   private String searchValue;   //검색값(검색키워드)
   
   private List<MainBoardFile> mainBoardFile;   //첨부파일. 하이보드파일 객체의 시작주소만 바라보게 함
   
   private String fileName;
   
   private int commentCount; //각 게시물당 댓글 개수
   private int likeCount;
   
   public MainBoard()
   {
      boardSeq = 0;
      userId = "";
      boardTitle = "";
      boardContent = "";
      readCnt = 0;
      regDate = "";
      boardType = "";
      
      userName = "";    
      userNickName = "";
      userEmail = "";    
      
      mainBoardFile = null;
      
      fileName = "";
      
      startRow = 0;   
      endRow = 0;      
      searchType = "";
      searchValue = "";   
      
      commentCount = 0;
      likeCount = 0;
   }
   
   
   
   public int getLikeCount() {
   return likeCount;
   }


   public void setLikeCount(int likeCount) {
      this.likeCount = likeCount;
   }


   public int getCommentCount() {
   return commentCount;
   }
   
   public void setCommentCount(int commentCount) {
      this.commentCount = commentCount;
   }

   public String getUserNickName() {
      return userNickName;
   }
   
   
   
   public void setUserNickName(String userNickName) {
      this.userNickName = userNickName;
   }
   
   
   
   public String getFileName() {
      return fileName;
   }
   
   
   
   public void setFileName(String fileName) {
      this.fileName = fileName;
   }
   
   
   
   public long getBoardSeq() {
      return boardSeq;
   }
   
   public void setBoardSeq(long boardSeq) {
      this.boardSeq = boardSeq;
   }
   
   public String getUserId() {
      return userId;
   }
   
   public void setUserId(String userId) {
      this.userId = userId;
   }
   
   public String getBoardTitle() {
      return boardTitle;
   }
   
   public void setBoardTitle(String boardTitle) {
      this.boardTitle = boardTitle;
   }
   
   public String getBoardContent() {
      return boardContent;
   }
   
   public void setBoardContent(String boardContent) {
      this.boardContent = boardContent;
   }
   
   public int getReadCnt() {
      return readCnt;
   }
   
   public void setReadCnt(int readCnt) {
      this.readCnt = readCnt;
   }
   
   public String getRegDate() {
      return regDate;
   }
   
   public void setRegDate(String regDate) {
      this.regDate = regDate;
   }
   
   public String getBoardType() {
      return boardType;
   }
   
   public void setBoardType(String boardType) {
      this.boardType = boardType;
   }
   
   public String getUserName() {
      return userName;
   }
   
   public void setUserName(String userName) {
      this.userName = userName;
   }
   
   public String getUserEmail() {
      return userEmail;
   }
   
   public void setUserEmail(String userEmail) {
      this.userEmail = userEmail;
   }
   
   public long getStartRow() {
      return startRow;
   }
   
   public void setStartRow(long startRow) {
      this.startRow = startRow;
   }
   
   public long getEndRow() {
      return endRow;
   }
   
   public void setEndRow(long endRow) {
      this.endRow = endRow;
   }
   
   public String getSearchType() {
      return searchType;
   }
   
   public void setSearchType(String searchType) {
      this.searchType = searchType;
   }
   
   public String getSearchValue() {
      return searchValue;
   }
   
   public void setSearchValue(String searchValue) {
      this.searchValue = searchValue;
   }
   
   
   
   public List<MainBoardFile> getMainBoardFile() {
      return mainBoardFile;
   }
   
   
   
   public void setMainBoardFile(List<MainBoardFile> mainBoardFile) {
      this.mainBoardFile = mainBoardFile;
   }

}
   
   