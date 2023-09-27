package com.icia.web.model;

import java.io.Serializable;
import java.util.List;

public class InquiryBoard implements Serializable
{
   private static final long serialVersionUID = 1L;
   
   private long qnaSeq;             //문의사항 글 번호
   private String userId;            //QNA하는 사용자 아이디
   private String sellerId;         //QNA답변하는 판매자 아이디
   private long qnaGroup;              //문의사항 글 그룹 번호
   private int qnaOrder;            //문의사항 글 그룹내 순서
   private int qnaIndent;            //문의사항 글 들여쓰기
   private String qnaTitle;         //문의사항 글 제목
   private String qnaContent;         //문의사항 글 내용
   private long qnaParent;            //부모 문의사항 글 번호
   private String regDate;            //등록일
   private String rSeq;            //레스토랑 예약 시퀀스 번호
   private String productSeq;         //상품 구매 시퀀스 번호
   private String replyStatus;         //답변상태(Y: 답변완료, N: 답변대기중)
   
   private long startRow;             //시작 rownum
   private long endRow;            //끝 rownum
   
   private String userName;         //사용자 이름
   
   private String orderedSeq;         //주문한 식당 또는 물품 시퀀스
   private String orderedName;         //주문한 식당명 또는 물품명
    
   private String searchCategory;      //카테고리(예약, 선물)
   private String searchType;        //검색타입 
   private String searchValue;       //검색값
   
   private String orderSeq;         //주문리스트에 주문시에 부여받는 주문 번호(예약, 선물)
   
   private String orderGubun;         //order구분 역할
   
   private   List<InquiryBoardFile> inquiryBoardFile;   //첨부파일(다중첨부파일 시 리스트형태로 객체 선언)

   public InquiryBoard()
   {
      qnaSeq = 0;
      userId = "";
      sellerId = "";
      qnaGroup = 0;
      qnaOrder = 0;
      qnaIndent = 0;
      qnaTitle = "";
      qnaContent = "";
      qnaParent = 0;
      regDate = "";
      rSeq = "";
      productSeq = "";
      replyStatus   = "N";
      
      startRow = 0;
      endRow = 0;
      
      userName = "";
      
      orderedSeq = "";
      orderedName = "";
      
      searchCategory = "";
      searchType = "";
      searchValue = "";
      
      orderSeq = "";
      
      orderGubun = "";
      
      inquiryBoardFile = null;
   }

   public long getQnaSeq() {
      return qnaSeq;
   }

   public void setQnaSeq(long qnaSeq) {
      this.qnaSeq = qnaSeq;
   }

   public String getUserId() {
      return userId;
   }

   public void setUserId(String userId) {
      this.userId = userId;
   }

   public String getSellerId() {
      return sellerId;
   }

   public void setSellerId(String sellerId) {
      this.sellerId = sellerId;
   }

   public long getQnaGroup() {
      return qnaGroup;
   }

   public void setQnaGroup(long qnaGroup) {
      this.qnaGroup = qnaGroup;
   }

   public int getQnaOrder() {
      return qnaOrder;
   }

   public void setQnaOrder(int qnaOrder) {
      this.qnaOrder = qnaOrder;
   }

   public int getQnaIndent() {
      return qnaIndent;
   }

   public void setQnaIndent(int qnaIndent) {
      this.qnaIndent = qnaIndent;
   }

   public String getQnaTitle() {
      return qnaTitle;
   }

   public void setQnaTitle(String qnaTitle) {
      this.qnaTitle = qnaTitle;
   }

   public String getQnaContent() {
      return qnaContent;
   }

   public void setQnaContent(String qnaContent) {
      this.qnaContent = qnaContent;
   }

   public long getQnaParent() {
      return qnaParent;
   }

   public void setQnaParent(long qnaParent) {
      this.qnaParent = qnaParent;
   }

   public String getRegDate() {
      return regDate;
   }

   public void setRegDate(String regDate) {
      this.regDate = regDate;
   }

   public String getrSeq() {
      return rSeq;
   }

   public void setrSeq(String rSeq) {
      this.rSeq = rSeq;
   }

   public String getProductSeq() {
      return productSeq;
   }

   public void setProductSeq(String productSeq) {
      this.productSeq = productSeq;
   }

   public String getReplyStatus() {
      return replyStatus;
   }

   public void setReplyStatus(String replyStatus) {
      this.replyStatus = replyStatus;
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

   public String getUserName() {
      return userName;
   }

   public void setUserName(String userName) {
      this.userName = userName;
   }

   public String getOrderedSeq() {
      return orderedSeq;
   }

   public void setOrderedSeq(String orderedSeq) {
      this.orderedSeq = orderedSeq;
   }

   public String getOrderedName() {
      return orderedName;
   }

   public void setOrderedName(String orderedName) {
      this.orderedName = orderedName;
   }

   public String getSearchCategory() {
      return searchCategory;
   }

   public void setSearchCategory(String searchCategory) {
      this.searchCategory = searchCategory;
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

   public String getOrderSeq() {
      return orderSeq;
   }

   public void setOrderSeq(String orderSeq) {
      this.orderSeq = orderSeq;
   }


   public List<InquiryBoardFile> getInquiryBoardFile() {
      return inquiryBoardFile;
   }

   public void setInquiryBoardFile(List<InquiryBoardFile> inquiryBoardFile) {
      this.inquiryBoardFile = inquiryBoardFile;
   }

   public String getOrderGubun() {
      return orderGubun;
   }

   public void setOrderGubun(String orderGubun) {
      this.orderGubun = orderGubun;
   }   

   
}