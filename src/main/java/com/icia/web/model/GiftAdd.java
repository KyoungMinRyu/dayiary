package com.icia.web.model;

import java.io.Serializable;
import java.util.List;

public class GiftAdd implements Serializable {

   private static final long serialVersionUID = 1L;

   private String productSeq, pName, sellerId, pPrice, pContent, regDate, status, productCategory;

   private String searchType; // 검색타입(1:이름, 2:제목, 3:내용)
   private String searchValue; // 검색값
   private String searchTypeCategory; // 카테고리
   private String orderBy; // 정렬순
   private String productType; // 카테고리별
   private List<GiftFile> giftFileList; // 첨부파일
   private String fileName;
   private short fileSeq;

   private long startRow; // 시작 rownum
   private long endRow; // 끝 rownum

   private int reviewScore;
   private int reviewCount;
   
   public GiftAdd() {

      productSeq = "";
      pName = "";
      sellerId = "";
      pPrice = "";
      pContent = "";
      productCategory = "";
      regDate = "";
      status = "";
      searchType = "";
      searchValue = "";
      searchTypeCategory = "";
      giftFileList = null;
      startRow = 0;
      endRow = 0;
      fileName = "";
      fileSeq = 0;
      orderBy = "";
      productType = "";
      reviewScore = 0;
      reviewCount = 0;
   }

   
   public int getReviewCount() {
      return reviewCount;
   }

   public void setReviewCount(int reviewCount) {
      this.reviewCount = reviewCount;
   }

   public int getReviewScore() {
      return reviewScore;
   }

   public void setReviewScore(int reviewScore) {
      this.reviewScore = reviewScore;
   }

   public String getProductType() {
      return productType;
   }

   public void setProductType(String productType) {
      this.productType = productType;
   }

   public String getOrderBy() {
      return orderBy;
   }

   public void setOrderBy(String orderBy) {
      this.orderBy = orderBy;
   }

   public String getFileName() {
      return fileName;
   }

   public void setFileName(String fileName) {
      this.fileName = fileName;
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

   public String getProductCategory() {
      return productCategory;
   }

   public void setProductCategory(String productCategory) {
      this.productCategory = productCategory;
   }

   public List<GiftFile> getGiftFileList() {
      return giftFileList;
   }

   public void setGiftFileList(List<GiftFile> giftFileList) {
      this.giftFileList = giftFileList;
   }

   public String getProductSeq() {
      return productSeq;
   }

   public void setProductSeq(String productSeq) {
      this.productSeq = productSeq;
   }

   public String getpName() {
      return pName;
   }

   public void setpName(String pName) {
      this.pName = pName;
   }

   public String getSellerId() {
      return sellerId;
   }

   public void setSellerId(String sellerId) {
      this.sellerId = sellerId;
   }

   public String getpPrice() {
      return pPrice;
   }

   public void setpPrice(String pPrice) {
      this.pPrice = pPrice;
   }

   public String getpContent() {
      return pContent;
   }

   public void setpContent(String pContent) {
      this.pContent = pContent;
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

   public String getSearchTypeCategory() {
      return searchTypeCategory;
   }

   public void setSearchTypeCategory(String searchTypeCategory) {
      this.searchTypeCategory = searchTypeCategory;
   }

   public int getFileSeq() {
      return fileSeq;
   }

   public void setFileSeq(short fileSeq) {
      this.fileSeq = fileSeq;
   }

}