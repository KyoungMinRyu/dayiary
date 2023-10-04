package com.icia.web.model;

import java.io.Serializable;

public class AdminNotice implements Serializable {

	private static final long serialVersionUID = 1L;

	private long bbsSeq; // 공지 번호
	private String userId; // 관리자 아이디
	private String bbsTitle; // 공지 제목
	private String bbsContent; // 공지 내용
	private String regDate; // 등록일
	private String status; // 상태

	private String userName; // 이름

	private long startRow; // 시작 rownum
	private long endRow; // 끝 rownum

	private String searchType; // 검색타입 (1:이름, 2:제목, 3:내용)
	private String searchValue; // 검색값

	private String searchSort; // 상단고정

	public AdminNotice() {
		bbsSeq = 0;
		userId = "";
		bbsTitle = "";
		bbsContent = "";
		regDate = "";
		status = "";

		userName = "";

		startRow = 0;
		endRow = 0;

		searchType = "";
		searchValue = "";

		searchSort = "";
	}

	public long getBbsSeq() {
		return bbsSeq;
	}

	public void setBbsSeq(long bbsSeq) {
		this.bbsSeq = bbsSeq;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getBbsTitle() {
		return bbsTitle;
	}

	public void setBbsTitle(String bbsTitle) {
		this.bbsTitle = bbsTitle;
	}

	public String getBbsContent() {
		return bbsContent;
	}

	public void setBbsContent(String bbsContent) {
		this.bbsContent = bbsContent;
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

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
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

	public String getSearchSort() {
		return searchSort;
	}

	public void setSearchSort(String searchSort) {
		this.searchSort = searchSort;
	}

}