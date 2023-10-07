package com.icia.web.model;

import java.io.Serializable;

public class UserG2 implements Serializable {
	private static final long serialVersionUID = 8638989512396268543L;
	private String userId, userPwd, userEmail, userName, userNickName, userPh, userGen, userBir, status, regDate,
			updateDate, userAddress, fileName;

	private UserProfileFile userProfileFile; // 첨부파일 //이미지프로필

	private long startRow; // 시작 rownum
	private long endRow; // 끝 rownum

	public UserG2() {
		userId = "";
		userPwd = "";
		userEmail = "";
		userName = "";
		userNickName = "";
		userPh = "";
		userGen = "";
		userBir = "";
		status = "";
		regDate = "";
		updateDate = "";
		userAddress = "";
		startRow = 0;
		endRow = 0;
		fileName = "";
	}

	public String getFileName() {
		return fileName;
	}

	public void setFileName(String fileName) {
		this.fileName = fileName;
	}

	public String getRegDate() {
		return regDate;
	}

	public void setRegDate(String regDate) {
		this.regDate = regDate;
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

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getUserPwd() {
		return userPwd;
	}

	public void setUserPwd(String userPwd) {
		this.userPwd = userPwd;
	}

	public String getUserEmail() {
		return userEmail;
	}

	public void setUserEmail(String userEmail) {
		this.userEmail = userEmail;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getUserNickName() {
		return userNickName;
	}

	public void setUserNickName(String userNickName) {
		this.userNickName = userNickName;
	}

	public String getUserPh() {
		return userPh;
	}

	public void setUserPh(String userPh) {
		this.userPh = userPh;
	}

	public String getUserGen() {
		return userGen;
	}

	public void setUserGen(String userGen) {
		this.userGen = userGen;
	}

	public String getUserBir() {
		return userBir;
	}

	public void setUserBir(String userBir) {
		this.userBir = userBir;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getregDate() {
		return regDate;
	}

	public void setregDate(String regDate) {
		this.regDate = regDate;
	}

	public String getUpdateDate() {
		return updateDate;
	}

	public void setUpdateDate(String updateDate) {
		this.updateDate = updateDate;
	}

	public String getUserAddress() {
		return userAddress;
	}

	public void setUserAddress(String userAddress) {
		this.userAddress = userAddress;
	}

	public UserProfileFile getUserProfileFile() {
		return userProfileFile;
	}

	public void setUserProfileFile(UserProfileFile userProfileFile) {
		this.userProfileFile = userProfileFile;
	}

}