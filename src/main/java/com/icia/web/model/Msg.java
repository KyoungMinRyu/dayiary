package com.icia.web.model;

import java.io.Serializable;

public class Msg implements Serializable {
	private static final long serialVersionUID = 1L;

	private long msgSeq;
	private String toUserId;
	private String fromUserId;
	private String msgContent;
	private String sendDate;

	private String userNickName;
	private String fileName;
	private String status;

	public Msg() {
		msgSeq = 0;
		toUserId = "";
		fromUserId = "";
		msgContent = "";
		sendDate = "";
		userNickName = "";
		fileName = "";
		status = "";
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getUserNickName() {
		return userNickName;
	}

	public void setUserNickName(String userNickName) {
		this.userNickName = userNickName;
	}

	public String getFileName() {
		return fileName;
	}

	public void setFileName(String fileName) {
		this.fileName = fileName;
	}

	public long getMsgSeq() {
		return msgSeq;
	}

	public void setMsgSeq(long msgSeq) {
		this.msgSeq = msgSeq;
	}

	public String getToUserId() {
		return toUserId;
	}

	public void setToUserId(String toUserId) {
		this.toUserId = toUserId;
	}

	public String getFromUserId() {
		return fromUserId;
	}

	public void setFromUserId(String fromUserId) {
		this.fromUserId = fromUserId;
	}

	public String getMsgContent() {
		return msgContent;
	}

	public void setMsgContent(String msgContent) {
		this.msgContent = msgContent;
	}

	public String getSendDate() {
		return sendDate;
	}

	public void setSendDate(String sendDate) {
		this.sendDate = sendDate;
	}
}