package com.icia.web.model;

import java.io.Serializable;

public class Seller implements Serializable
{
	private static final long serialVersionUID = 8638989512396268543L;

	private String 
			    sellerId, // 판매자 Id
			    sellerBusinessId, // 판매자 사업자번호
			    sellerEmail, // 판매자 이메일
			    sellerPwd, // 판매자 Pwd
			    sellerShopName, // 판매자 상호명
			    sellerPh, // 판매자 전화번호
			    sellerAddress, // 판매자 주소
			    status, // 상태
			    regDate,
			    totalReservCnt,
			    totalRevenue;
	

	private long startRow;      //시작 rownum
	private long endRow;      //끝 rownum
	
	public Seller() 
	{
		sellerId = "";
	    sellerBusinessId = "";
	    sellerEmail = "";
	    sellerPwd = "";
	    sellerShopName = "";
	    sellerPh = "";
	    sellerAddress = "";
	    status = "";
	    regDate = "";
	    startRow = 0;   
        endRow = 0;
        totalReservCnt = "0";
        totalRevenue = "0";
	}
	
	
	public String getTotalReservCnt() {
		return totalReservCnt;
	}

	public void setTotalReservCnt(String totalReservCnt) {
		this.totalReservCnt = totalReservCnt;
	}

	public String getTotalRevenue() {
		return totalRevenue;
	}

	public void setTotalRevenue(String totalRevenue) {
		this.totalRevenue = totalRevenue;
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

	public String getSellerId() 
	{
		return sellerId;
	}

	public void setSellerId(String sellerId) 
	{
		this.sellerId = sellerId;
	}

	public String getSellerBusinessId() 
	{
		return sellerBusinessId;
	}

	public void setSellerBusinessId(String sellerBusinessId) 
	{
		this.sellerBusinessId = sellerBusinessId;
	}

	public String getSellerEmail() 
	{
		return sellerEmail;
	}

	public void setSellerEmail(String sellerEmail) 
	{
		this.sellerEmail = sellerEmail;
	}

	public String getSellerPwd() 
	{
		return sellerPwd;
	}

	public void setSellerPwd(String sellerPwd) 
	{
		this.sellerPwd = sellerPwd;
	}

	public String getSellerShopName() 
	{
		return sellerShopName;
	}

	public void setSellerShopName(String sellerShopName) 
	{
		this.sellerShopName = sellerShopName;
	}

	public String getSellerPh() 
	{
		return sellerPh;
	}

	public void setSellerPh(String sellerPh) 
	{
		this.sellerPh = sellerPh;
	}

	public String getSellerAddress() 
	{
		return sellerAddress;
	}

	public void setSellerAddress(String sellerAddress) 
	{
		this.sellerAddress = sellerAddress;
	}

	public String getStatus() 
	{
		return status;
	}

	public void setStatus(String status) 
	{
		this.status = status;
	}

	public String getRegDate() 
	{
		return regDate;
	}

	public void setRegDate(String regDate) 
	{
		this.regDate = regDate;
	}
}
