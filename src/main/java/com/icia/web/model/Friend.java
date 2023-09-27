package com.icia.web.model;

import java.io.Serializable;

public class Friend implements Serializable
{
   private static final long serialVersionUID = 1L;
   
   private long relationalSeq;
   private String relationalType;
   private String userId;
   private String myId; //추가한거
   private String yourId;
   private String status;
   private String userEmail;
   private String userNickName;
   private String regDate;
   private String fileName;
   private int friendCnt;
   private int diaryCnt;
   private String searchType; // 검색 타입 (0: 전체 1 : 아이디, 2 : 닉네임, 3 : 이메일)
   private String searchValue; // 검색값
   private String myProfileImage; //추가한거
   private String yourProfileImage; //추가한거
   private String yourName;  //추가한거
   private String myName;    //추가한거
   private String yourBir;
   private String myBir;
   private String yourGen;
   private String myGen;
   private String yourNickName;
   private String myNickName;
   
   
   public Friend() 
   {
      relationalSeq = 0;
      relationalType = "";
      userId = "";
      myId = "";
      yourId = "";
      status = "";
      userEmail = "";
      userNickName = "";
      regDate = "";
      fileName = "";
      diaryCnt = 0;
      friendCnt = 0; 
      searchType = "";
      searchValue = "";
      myProfileImage = "";
      yourProfileImage = "";
      yourName = "";
      myName = "";
      yourBir = "";
      myBir = "";
      yourGen = "";
      myGen = "";
      yourNickName = "";
      myNickName = "";
   }

   public String getYourId() 
   {
      return yourId;
   }

   public void setYourId(String yourId) 
   {
      this.yourId = yourId;
   }

   public String getStatus() 
   {
      return status;
   }

   public void setStatus(String status) 
   {
      this.status = status;
   }

   public long getRelationalSeq() 
   {
      return relationalSeq;
   }

   public void setRelationalSeq(long relationalSeq) 
   {
      this.relationalSeq = relationalSeq;
   }

   public String getRelationalType() 
   {
      return relationalType;
   }

   public void setRelationalType(String relationalType) 
   {
      this.relationalType = relationalType;
   }

   public int getDiaryCnt() 
   {
      return diaryCnt;
   }

   public void setDiaryCnt(int diaryCnt) 
   {
      this.diaryCnt = diaryCnt;
   }

   public int getFriendCnt() 
   {
      return friendCnt;
   }

   public void setFriendCnt(int friendCnt) 
   {
      this.friendCnt = friendCnt;
   }

   public String getSearchType() 
   {
      return searchType;
   }

   public void setSearchType(String searchType) 
   {
      this.searchType = searchType;
   }

   public String getSearchValue() 
   {
      return searchValue;
   }

   public void setSearchValue(String searchValue) 
   {
      this.searchValue = searchValue;
   }

   public String getUserId() 
   {
      return userId;
   }

   public void setUserId(String userId) 
   {
      this.userId = userId;
   }

   public String getUserEmail() 
   {
      return userEmail;
   }

   public void setUserEmail(String userEmail) 
   {
      this.userEmail = userEmail;
   }

   public String getUserNickName() 
   {
      return userNickName;
   }

   public void setUserNickName(String userNickName) 
   {
      this.userNickName = userNickName;
   }

   public String getRegDate() 
   {
      return regDate;
   }

   public void setRegDate(String regDate) 
   {
      this.regDate = regDate;
   }

   public String getFileName() 
   {
      return fileName;
   }

   public void setFileName(String fileName) 
   {
      this.fileName = fileName;
   }

   public String getMyId() 
   {
      return myId;
   }

   public void setMyId(String myId)
   {
      this.myId = myId;
   }

   public String getYourProfileImage()
   {
      return yourProfileImage;
   }

   public void setYourProfileImage(String yourProfileImage)
   {
      this.yourProfileImage = yourProfileImage;
   }

   public String getMyProfileImage()
   {
      return myProfileImage;
   }

   public void setMyProfileImage(String myProfileImage)
   {
      this.myProfileImage = myProfileImage;
   }

   public String getYourName() 
   {
      return yourName;
   }

   public void setYourName(String yourName) 
   {
      this.yourName = yourName;
   }

   public String getMyName() 
   {
      return myName;
   }

   public void setMyName(String myName) 
   {
      this.myName = myName;
   }

   public String getYourBir()
   {
      return yourBir;
   }

   public void setYourBir(String yourBir) 
   {
      this.yourBir = yourBir;
   }

   public String getMyBir() 
   {
      return myBir;
   }

   public void setMyBir(String myBir)
   {
      this.myBir = myBir;
   }

   public String getYourGen()
   {
      return yourGen;
   }

   public void setYourGen(String yourGen)
   {
      this.yourGen = yourGen;
   }

   public String getMyGen() 
   {
      return myGen;
   }

   public void setMyGen(String myGen) 
   {
      this.myGen = myGen;
   }

   public String getYourNickName()
   {
      return yourNickName;
   }

   public void setYourNickName(String yourNickName)
   {
      this.yourNickName = yourNickName;
   }

   public String getMyNickName()
{
      return myNickName;
   }

   public void setMyNickName(String myNickName)
   {
      this.myNickName = myNickName;
   }
   
   
   
   
}