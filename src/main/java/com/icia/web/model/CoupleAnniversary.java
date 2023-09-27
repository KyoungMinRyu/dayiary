package com.icia.web.model;

import java.io.Serializable;

public class CoupleAnniversary implements Serializable
{
	private static final long serialVersionUID = 1L;

	private long relationalSeq;
    private String day100;
	private String day200;
	private String day300;
	private String startDate;
	private String status;
	private String userId;
	private String userBir;
	private String userPh;
	private String userNickname;
		
	public CoupleAnniversary() 
	{
		relationalSeq = 0;
	    day100 = "";
		day200 = "";
		day300 = "";
		startDate = "";
		status = "";
		userId = "";
	    userBir = "";
	    userPh = "";
	    userNickname = "";
	}
	
	public String getUserNickname() {
		return userNickname;
	}

	public void setUserNickname(String userNickname) {
		this.userNickname = userNickname;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getUserBir() {
		return userBir;
	}

	public void setUserBir(String userBir) {
		this.userBir = userBir;
	}

	public String getUserPh() {
		return userPh;
	}

	public void setUserPh(String userPh) {
		this.userPh = userPh;
	}

	public long getRelationalSeq() 
	{
		return relationalSeq;
	}

	public void setRelationalSeq(long relationalSeq) 
	{
		this.relationalSeq = relationalSeq;
	}

	public String getDay100() 
	{
		return day100;
	}

	public void setDay100(String day100) 
	{
		this.day100 = day100;
	}

	public String getDay200() 
	{
		return day200;
	}

	public void setDay200(String day200) 
	{
		this.day200 = day200;
	}

	public String getDay300() 
	{
		return day300;
	}

	public void setDay300(String day300) 
	{
		this.day300 = day300;
	}

	public String getStartDate() 
	{
		return startDate;
	}

	public void setStartDate(String startDate) 
	{
		this.startDate = startDate;
	}

	public String getStatus() 
	{
		return status;
	}

	public void setStatus(String status) 
	{
		this.status = status;
	}
}
