package com.icia.web.model;

import java.io.Serializable;

public class Admin implements Serializable 
{
	private static final long serialVersionUID = 1L;
	
	private String 
					restoTotalPrice,  
					restoTotalCount,
					restoRegDate,
					userTotalCount,
					userRegDate,
					sellerTotalCount,
					sellerRegDate,
				    giftRegDate,
				    giftTotalCnt,
				    giftTotalPrice,
				    restoName,
				    fileName,
				    rSeq,
				    pName,
				    productSeq,
				    restoDeposit,
				    reservPerson,
				    orderTotalCnt,
				    pPrice;
	
	public Admin() 
	{
		restoTotalPrice = "";  
		restoTotalCount = "";
		restoRegDate = "";
		userTotalCount = "";
		userRegDate = "";
		sellerTotalCount = "";
		sellerRegDate = "";
	    giftRegDate = "";
	    giftTotalCnt = "";
	    giftTotalPrice = "";
	    restoName = "";
	    fileName = "";
	    rSeq = "";
	    pName = "";
	    productSeq = "";
	    restoDeposit = "";
	    reservPerson = "";
	    orderTotalCnt = "";
	    pPrice = "";
	}
	
	public String getpPrice() {
		return pPrice;
	}

	public void setpPrice(String pPrice) {
		this.pPrice = pPrice;
	}

	public String getOrderTotalCnt() {
		return orderTotalCnt;
	}

	public void setOrderTotalCnt(String orderTotalCnt) {
		this.orderTotalCnt = orderTotalCnt;
	}

	public String getRestoDeposit() {
		return restoDeposit;
	}

	public void setRestoDeposit(String restoDeposit) {
		this.restoDeposit = restoDeposit;
	}

	public String getReservPerson() {
		return reservPerson;
	}

	public void setReservPerson(String reservPerson) {
		this.reservPerson = reservPerson;
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

	public String getrSeq() {
		return rSeq;
	}

	public void setrSeq(String rSeq) {
		this.rSeq = rSeq;
	}

	public String getpName() {
		return pName;
	}

	public void setpName(String pName) {
		this.pName = pName;
	}

	public String getProductSeq() {
		return productSeq;
	}

	public void setProductSeq(String productSeq) {
		this.productSeq = productSeq;
	}

	public String getRestoTotalPrice() {
		return restoTotalPrice;
	}

	public void setRestoTotalPrice(String restoTotalPrice) {
		this.restoTotalPrice = restoTotalPrice;
	}

	public String getRestoTotalCount() {
		return restoTotalCount;
	}

	public void setRestoTotalCount(String restoTotalCount) {
		this.restoTotalCount = restoTotalCount;
	}

	public String getRestoRegDate() {
		return restoRegDate;
	}

	public void setRestoRegDate(String restoRegDate) {
		this.restoRegDate = restoRegDate;
	}

	public String getUserTotalCount() {
		return userTotalCount;
	}

	public void setUserTotalCount(String userTotalCount) {
		this.userTotalCount = userTotalCount;
	}

	public String getUserRegDate() {
		return userRegDate;
	}

	public void setUserRegDate(String userRegDate) {
		this.userRegDate = userRegDate;
	}

	public String getSellerTotalCount() {
		return sellerTotalCount;
	}

	public void setSellerTotalCount(String sellerTotalCount) {
		this.sellerTotalCount = sellerTotalCount;
	}

	public String getSellerRegDate() {
		return sellerRegDate;
	}

	public void setSellerRegDate(String sellerRegDate) {
		this.sellerRegDate = sellerRegDate;
	}

	public String getGiftRegDate() {
		return giftRegDate;
	}

	public void setGiftRegDate(String giftRegDate) {
		this.giftRegDate = giftRegDate;
	}

	public String getGiftTotalCnt() {
		return giftTotalCnt;
	}

	public void setGiftTotalCnt(String giftTotalCnt) {
		this.giftTotalCnt = giftTotalCnt;
	}

	public String getGiftTotalPrice() {
		return giftTotalPrice;
	}

	public void setGiftTotalPrice(String giftTotalPrice) {
		this.giftTotalPrice = giftTotalPrice;
	}
}
