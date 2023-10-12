package com.icia.web.model;

import java.io.Serializable;
import java.util.List;

public class RestoInfo implements Serializable {

   private static final long serialVersionUID = 1L;

   private String rSeq; // 레스토랑 시퀀스
   private String restoName; // 레스토랑 이름
   private String sellerId; // 판매자 아이디
   private String restoAddress; // 레스토랑 주소
   private String restoPh; // 레스토랑 전화번호
   private String restoContent; // 레스토랑 소개글
   private String regDate; // 레스토랑 등록일
   private String status; // 레스토랑 상태
   private String restoType; // 식당 종류
   private String foodType; // 음식 종류
   private String restoOff; // 휴무일

   // 레스토랑 검색 조건 - 어떤 셀렉트박스의 어떤값을 골랐는지 받아옴. (예: 음식 종류 - 한식을 골랐으면 searchTypeFood 값에
   // '한식'이 들어옴)
   private String searchTypeLocation; // 지역
   private String searchTypeShop; // 식당 종류
   private String searchTypeFood; // 음식 종류
   private String searchTypeDate; // 날짜
   private String searchTypePrice; // 가격

   // 페이징처리
   private long startRow; // 시작 rownum
   private long endRow; // 끝 rownum

   // 첨부파일 테이블
   private List<RestoFile> restoFileList; // 첨부파일

   // 메뉴 받아오기
   private List<Menu> menuList;

   // 영업시간
   private String restoOpen;
   private String restoClose;

   // 예약금
   private int restoDeposit;
   
   // 베스트 매장 추천할때 썸네일 받는용
   private String fileName;
   // 베스트 매장 예약건수 보여주기용
   private int cnt;

   // 시간당 최대 예약 인원수
   private int limitPerson;
   
   private int reviewScore;
   private int reviewCount;

   public RestoInfo() {
      rSeq = "";
      restoName = "";
      sellerId = "";
      restoAddress = "";
      restoPh = "";
      restoContent = "";
      regDate = "";
      status = "";
      restoType = "";
      foodType = "";
      restoOff = "";

      searchTypeLocation = "";
      searchTypeShop = "";
      searchTypeFood = "";
      searchTypeDate = "";
      searchTypePrice = "";

      startRow = 0;
      endRow = 0;

      restoFileList = null;
      menuList = null;

      restoOpen = "";
      restoClose = "";

      restoDeposit = 0;
      
      fileName = "";

      cnt = 0;
      limitPerson = 0;
      
      reviewScore = 0;
      reviewCount = 0;
   }
   

   public int getReviewScore() {
   return reviewScore;
   }


   public void setReviewScore(int reviewScore) {
      this.reviewScore = reviewScore;
   }


public int getReviewCount() {
   return reviewCount;
}


public void setReviewCount(int reviewCount) {
   this.reviewCount = reviewCount;
}



public int getLimitPerson() {
      return limitPerson;
   }

   public void setLimitPerson(int limitPerson) {
      this.limitPerson = limitPerson;
   }

   public int getCnt() {
      return cnt;
   }

   public void setCnt(int cnt) {
      this.cnt = cnt;
   }

   public String getFileName() {
      return fileName;
   }

   public void setFileName(String fileName) {
      this.fileName = fileName;
   }

   public int getRestoDeposit() {
      return restoDeposit;
   }

   public void setRestoDeposit(int restoDeposit) {
      this.restoDeposit = restoDeposit;
   }

   public String getRestoOpen() {
      return restoOpen;
   }

   public void setRestoOpen(String restoOpen) {
      this.restoOpen = restoOpen;
   }

   public String getRestoClose() {
      return restoClose;
   }

   public void setRestoClose(String restoClose) {
      this.restoClose = restoClose;
   }

   public List<Menu> getMenuList() {
      return menuList;
   }

   public void setMenuList(List<Menu> menuList) {
      this.menuList = menuList;
   }

   public List<RestoFile> getRestoFileList() {
      return restoFileList;
   }

   public void setRestoFileList(List<RestoFile> restoFileList) {
      this.restoFileList = restoFileList;
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

   public String getSearchTypeLocation() {
      return searchTypeLocation;
   }

   public void setSearchTypeLocation(String searchTypeLocation) {
      this.searchTypeLocation = searchTypeLocation;
   }

   public String getSearchTypeShop() {
      return searchTypeShop;
   }

   public void setSearchTypeShop(String searchTypeShop) {
      this.searchTypeShop = searchTypeShop;
   }

   public String getSearchTypeFood() {
      return searchTypeFood;
   }

   public void setSearchTypeFood(String searchTypeFood) {
      this.searchTypeFood = searchTypeFood;
   }

   public String getSearchTypeDate() {
      return searchTypeDate;
   }

   public void setSearchTypeDate(String searchTypeDate) {
      this.searchTypeDate = searchTypeDate;
   }

   public String getSearchTypePrice() {
      return searchTypePrice;
   }

   public void setSearchTypePrice(String searchTypePrice) {
      this.searchTypePrice = searchTypePrice;
   }

   public String getrSeq() {
      return rSeq;
   }

   public void setrSeq(String rSeq) {
      this.rSeq = rSeq;
   }

   public String getRestoName() {
      return restoName;
   }

   public void setRestoName(String restoName) {
      this.restoName = restoName;
   }

   public String getSellerId() {
      return sellerId;
   }

   public void setSellerId(String sellerId) {
      this.sellerId = sellerId;
   }

   public String getRestoAddress() {
      return restoAddress;
   }

   public void setRestoAddress(String restoAddress) {
      this.restoAddress = restoAddress;
   }

   public String getRestoPh() {
      return restoPh;
   }

   public void setRestoPh(String restoPh) {
      this.restoPh = restoPh;
   }

   public String getRestoContent() {
      return restoContent;
   }

   public void setRestoContent(String restoContent) {
      this.restoContent = restoContent;
   }

   public String getRegDate() {
      return regDate;
   }

   public void setRegDate(String regDate) {
      this.regDate = regDate;
   }

   public String getStatus() {
      return status;
   }

   public void setStatus(String status) {
      this.status = status;
   }

   public String getRestoType() {
      return restoType;
   }

   public void setRestoType(String restoType) {
      this.restoType = restoType;
   }

   public String getFoodType() {
      return foodType;
   }

   public void setFoodType(String foodType) {
      this.foodType = foodType;
   }

   public String getRestoOff() {
      return restoOff;
   }

   public void setRestoOff(String restoOff) {
      this.restoOff = restoOff;
   }

}