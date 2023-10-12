package com.icia.web.model;

import java.io.Serializable;
import java.util.List;

public class Anniversary implements Serializable {
	private static final long serialVersionUID = 1L;

	private long anniversarySeq;
	private String userId;
	private String anniversaryDate;
	private String anniversaryTime;
	private String anniversaryTitle;
	private String anniversaryContent;

	private String yourId;
	private String userNickname;
	private String userBir;
	private String userPh;
	private long relationalSeq;
	private String fileName;
	private String sharedStatus;
	private String orderSeq;

	private List<String> sharedAnniversaryProfileList;
	
	public Anniversary() {
		anniversarySeq = 0;
		userId = "";
		anniversaryDate = "";
		anniversaryTime = "";
		anniversaryTitle = "";
		anniversaryContent = "";
		yourId = "";
		userNickname = "";
		relationalSeq = 0;
		fileName = "";
		userBir = "";
		userPh = "";
		sharedStatus = "";
		orderSeq = "";
		sharedAnniversaryProfileList = null;
	}
	
	public List<String> getSharedAnniversaryProfileList() {
		return sharedAnniversaryProfileList;
	}

	public void setSharedAnniversaryProfileList(List<String> sharedAnniversaryProfileList) {
		this.sharedAnniversaryProfileList = sharedAnniversaryProfileList;
	}

	public String getOrderSeq() {
		return orderSeq;
	}

	public void setOrderSeq(String orderSeq) {
		this.orderSeq = orderSeq;
	}

	public String getSharedStatus() {
		return sharedStatus;
	}

	public void setSharedStatus(String sharedStatus) {
		this.sharedStatus = sharedStatus;
	}

	public String getUserPh() {
		return userPh;
	}

	public void setUserPh(String userPh) {
		this.userPh = userPh;
	}

	public String getUserBir() {
		return userBir;
	}

	public void setUserBir(String userBir) {
		this.userBir = userBir;
	}

	public String getYourId() {
		return yourId;
	}

	public void setYourId(String yourId) {
		this.yourId = yourId;
	}

	public String getUserNickname() {
		return userNickname;
	}

	public void setUserNickname(String userNickname) {
		this.userNickname = userNickname;
	}

	public long getRelationalSeq() {
		return relationalSeq;
	}

	public void setRelationalSeq(long relationalSeq) {
		this.relationalSeq = relationalSeq;
	}

	public String getFileName() {
		return fileName;
	}

	public void setFileName(String fileName) {
		this.fileName = fileName;
	}

	public long getAnniversarySeq() {
		return anniversarySeq;
	}

	public void setAnniversarySeq(long anniversarySeq) {
		this.anniversarySeq = anniversarySeq;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getAnniversaryDate() {
		return anniversaryDate;
	}

	public void setAnniversaryDate(String anniversaryDate) {
		this.anniversaryDate = anniversaryDate;
	}

	public String getAnniversaryTime() {
		return anniversaryTime;
	}

	public void setAnniversaryTime(String anniversaryTime) {
		this.anniversaryTime = anniversaryTime;
	}

	public String getAnniversaryTitle() {
		return anniversaryTitle;
	}

	public void setAnniversaryTitle(String anniversaryTitle) {
		this.anniversaryTitle = anniversaryTitle;
	}

	public String getAnniversaryContent() {
		return anniversaryContent;
	}

	public void setAnniversaryContent(String anniversaryContent) {
		this.anniversaryContent = anniversaryContent;
	}
}
