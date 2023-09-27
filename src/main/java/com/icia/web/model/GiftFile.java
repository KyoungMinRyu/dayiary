package com.icia.web.model;

import java.io.Serializable;

public class GiftFile implements Serializable {
	private static final long serialVersionUID = 1L;

	private String productSeq, fileName;
	private short fileSeq;

	public GiftFile() {
		productSeq = "";
		fileName = "";
		fileSeq = 0;

	}

	public String getProductSeq() {
		return productSeq;
	}

	public void setProductSeq(String productSeq) {
		this.productSeq = productSeq;
	}

	public String getFileName() {
		return fileName;
	}

	public void setFileName(String fileName) {
		this.fileName = fileName;
	}

	public short getFileSeq() {
		return fileSeq;
	}

	public void setFileSeq(short fileSeq) {
		this.fileSeq = fileSeq;
	}

}