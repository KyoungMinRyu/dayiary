package com.icia.web.model;

import java.io.Serializable;

public class OrderList implements Serializable {
	private static final long serialVersionUID = 1L;

	private String orderSeq; // 주문번호
	private String productSeq; // 상품 시퀀스 - 선물 구매일 경우
	private String userId; // 유저 아이디(예약자)
	private String regDate; // 주문 등록 날짜
	private String status; // 주문 상태(대기, 완료 등)
	private String reservDate; // 예약 날짜
	private String rSeq; // 레스토랑 시퀀스 - 레스토랑 예약일 경우

	private String reservTime;

	private String restoName; // 레스토랑 이름
	private String restoAddress;
	private String restoPh;
	
	private String fileName;
	private long totalPrice;
	private int reservPerson;

	private String changeable;
	private String reviewed;

	private long startRow; // 시작 rownum
	private long endRow; // 끝 rownum

	private String searchType; // 검색타입 (1:이름, 2:제목, 3:내용)
	private String searchValue; // 검색값
	
	private String orderTotalCnt;

	private int totalCnt;
	private String pName;
	private String deliveryStatus;
	private String orderNum;
	private String deliverCompany;
	private String sellerId;
	private String sellerShopName;
	private String sellerPh;
	private String orderAddress;
	private String orderMsg;
	private String userName;
	private String userPh;
	private String payMethod;
	
	public OrderList() {
		orderSeq = "";
		productSeq = "";
		userId = "";
		regDate = "";
		status = "";
		reservDate = "";
		rSeq = "";
		fileName = "";
		restoName = "";
		reservTime = "";
		reservPerson = 0;
		totalPrice = 0;
		startRow = 0;
		endRow = 0;
		searchType = "";
		searchValue = "";
		changeable = "";
		reviewed = "";
		totalCnt = 0;
		pName = "";
		deliveryStatus = "";
		orderNum = "";
		deliverCompany = "";
		sellerShopName = "";
		sellerPh = "";
		orderAddress = "";
		userName = "";
		userPh = "";
		payMethod = "";
		orderMsg = "";
		sellerId = "";
		restoAddress = "";
		restoPh = "";
		orderTotalCnt = "";
	}
		
	public String getOrderTotalCnt() {
		return orderTotalCnt;
	}

	public void setOrderTotalCnt(String orderTotalCnt) {
		this.orderTotalCnt = orderTotalCnt;
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

	public String getSellerId() {
		return sellerId;
	}

	public void setSellerId(String sellerId) {
		this.sellerId = sellerId;
	}

	public String getOrderMsg() {
		return orderMsg;
	}

	public void setOrderMsg(String orderMsg) {
		this.orderMsg = orderMsg;
	}

	public String getPayMethod() {
		return payMethod;
	}

	public void setPayMethod(String payMethod) {
		this.payMethod = payMethod;
	}

	public String getSellerShopName() {
		return sellerShopName;
	}

	public void setSellerShopName(String sellerShopName) {
		this.sellerShopName = sellerShopName;
	}

	public String getSellerPh() {
		return sellerPh;
	}

	public void setSellerPh(String sellerPh) {
		this.sellerPh = sellerPh;
	}

	public String getOrderAddress() {
		return orderAddress;
	}

	public void setOrderAddress(String orderAddress) {
		this.orderAddress = orderAddress;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getUserPh() {
		return userPh;
	}

	public void setUserPh(String userPh) {
		this.userPh = userPh;
	}

	public String getOrderNum() {
		return orderNum;
	}

	public void setOrderNum(String orderNum) {
		this.orderNum = orderNum;
	}

	public String getDeliverCompany() {
		return deliverCompany;
	}

	public void setDeliverCompany(String deliverCompany) {
		this.deliverCompany = deliverCompany;
	}

	public int getTotalCnt() {
		return totalCnt;
	}

	public void setTotalCnt(int totalCnt) {
		this.totalCnt = totalCnt;
	}

	public String getpName() {
		return pName;
	}

	public void setpName(String pName) {
		this.pName = pName;
	}

	public String getDeliveryStatus() {
		return deliveryStatus;
	}

	public void setDeliveryStatus(String deliveryStatus) {
		this.deliveryStatus = deliveryStatus;
	}

	public String getReviewed() {
		return reviewed;
	}

	public void setReviewed(String reviewed) {
		this.reviewed = reviewed;
	}

	public String getChangeable() {
		return changeable;
	}

	public void setChangeable(String changeable) {
		this.changeable = changeable;
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

	public String getRestoName() {
		return restoName;
	}

	public void setRestoName(String restoName) {
		this.restoName = restoName;
	}

	public String getFileName() {
		return fileName;
	}

	public void setFileName(String fileName) {
		this.fileName = fileName;
	}

	public long getTotalPrice() {
		return totalPrice;
	}

	public void setTotalPrice(long totalPrice) {
		this.totalPrice = totalPrice;
	}

	public String getReservTime() {
		return reservTime;
	}

	public void setReservTime(String reservTime) {
		this.reservTime = reservTime;
	}

	public int getReservPerson() {
		return reservPerson;
	}

	public void setReservPerson(int reservPerson) {
		this.reservPerson = reservPerson;
	}

	public String getOrderSeq() {
		return orderSeq;
	}

	public void setOrderSeq(String orderSeq) {
		this.orderSeq = orderSeq;
	}

	public String getProductSeq() {
		return productSeq;
	}

	public void setProductSeq(String productSeq) {
		this.productSeq = productSeq;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
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

	public String getReservDate() {
		return reservDate;
	}

	public void setReservDate(String reservDate) {
		this.reservDate = reservDate;
	}

	public String getrSeq() {
		return rSeq;
	}

	public void setrSeq(String rSeq) {
		this.rSeq = rSeq;
	}

}