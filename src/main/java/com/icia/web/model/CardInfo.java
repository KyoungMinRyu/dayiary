package com.icia.web.model;

import java.io.Serializable;

public class CardInfo implements Serializable {
	private static final long serialVersionUID = 1L;

	private String purchase_corp; // 매입 카드사 한글명
	private String purchase_corp_code; // 매입 카드사 코드
	private String issuer_corp; // 카드 발급사 한글명
	private String issuer_corp_code; // 카드 발급사 코드
	private String kakaopay_purchase_corp; // 카카오페이 매입사명
	private String kakaopay_purchase_corp_code; // 카카오페이 매입사 코드
	private String kakaopay_issuer_corp; // 카카오페이 발급사명
	private String kakaopay_issuer_corp_code; // 카카오페이 발급사 코드
	private String bin; // 카드 BIN
	private String card_type; // 카드 타입
	private String install_month; // 할부 개월 수
	private String approved_id; // 카드사 승인번호
	private String card_mid; // 카드사 가맹점 번호
	private String interest_free_install; // 무이자할부 여부(Y/N)
	private String card_item_code; // 카드 상품 코드

	public CardInfo() {
		purchase_corp = "";
		purchase_corp_code = "";
		issuer_corp = "";
		issuer_corp_code = "";
		kakaopay_purchase_corp = "";
		kakaopay_purchase_corp_code = "";
		kakaopay_issuer_corp = "";
		kakaopay_issuer_corp_code = "";
		bin = "";
		card_type = "";
		install_month = "";
		approved_id = "";
		card_mid = "";
		interest_free_install = "";
		card_item_code = "";
	}

	public String getPurchase_corp() {
		return purchase_corp;
	}

	public void setPurchase_corp(String purchase_corp) {
		this.purchase_corp = purchase_corp;
	}

	public String getPurchase_corp_code() {
		return purchase_corp_code;
	}

	public void setPurchase_corp_code(String purchase_corp_code) {
		this.purchase_corp_code = purchase_corp_code;
	}

	public String getIssuer_corp() {
		return issuer_corp;
	}

	public void setIssuer_corp(String issuer_corp) {
		this.issuer_corp = issuer_corp;
	}

	public String getIssuer_corp_code() {
		return issuer_corp_code;
	}

	public void setIssuer_corp_code(String issuer_corp_code) {
		this.issuer_corp_code = issuer_corp_code;
	}

	public String getKakaopay_purchase_corp() {
		return kakaopay_purchase_corp;
	}

	public void setKakaopay_purchase_corp(String kakaopay_purchase_corp) {
		this.kakaopay_purchase_corp = kakaopay_purchase_corp;
	}

	public String getKakaopay_purchase_corp_code() {
		return kakaopay_purchase_corp_code;
	}

	public void setKakaopay_purchase_corp_code(String kakaopay_purchase_corp_code) {
		this.kakaopay_purchase_corp_code = kakaopay_purchase_corp_code;
	}

	public String getKakaopay_issuer_corp() {
		return kakaopay_issuer_corp;
	}

	public void setKakaopay_issuer_corp(String kakaopay_issuer_corp) {
		this.kakaopay_issuer_corp = kakaopay_issuer_corp;
	}

	public String getKakaopay_issuer_corp_code() {
		return kakaopay_issuer_corp_code;
	}

	public void setKakaopay_issuer_corp_code(String kakaopay_issuer_corp_code) {
		this.kakaopay_issuer_corp_code = kakaopay_issuer_corp_code;
	}

	public String getBin() {
		return bin;
	}

	public void setBin(String bin) {
		this.bin = bin;
	}

	public String getCard_type() {
		return card_type;
	}

	public void setCard_type(String card_type) {
		this.card_type = card_type;
	}

	public String getInstall_month() {
		return install_month;
	}

	public void setInstall_month(String install_month) {
		this.install_month = install_month;
	}

	public String getApproved_id() {
		return approved_id;
	}

	public void setApproved_id(String approved_id) {
		this.approved_id = approved_id;
	}

	public String getCard_mid() {
		return card_mid;
	}

	public void setCard_mid(String card_mid) {
		this.card_mid = card_mid;
	}

	public String getInterest_free_install() {
		return interest_free_install;
	}

	public void setInterest_free_install(String interest_free_install) {
		this.interest_free_install = interest_free_install;
	}

	public String getCard_item_code() {
		return card_item_code;
	}

	public void setCard_item_code(String card_item_code) {
		this.card_item_code = card_item_code;
	}

}