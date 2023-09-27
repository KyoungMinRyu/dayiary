package com.icia.web.model;

import java.io.Serializable;

/**
 *	클래스명 : GeoLocation
 *	설명 : 네이버 GeoLocation를 통해서 받아온 시 구 동 위도 경도를 저장함
 **/
public class GeoLocation implements Serializable
{
	private static final long serialVersionUID = 1L;

	private String
					country, // 국가 코드
					si, // 시
					gu, // 구
					dong, // 동
					lat, // 위도
					lon, // 경도
					net; // 통신사
	
	public GeoLocation()
	{
		country = "";
		si = "";
		gu = "";
		dong = "";
		lat = "";
		lon = "";
		net = "";
	}

	public String getCountry() {
		return country;
	}

	public void setCountry(String country) {
		this.country = country;
	}

	public String getSi() {
		return si;
	}

	public void setSi(String si) {
		this.si = si;
	}

	public String getGu() {
		return gu;
	}

	public void setGu(String gu) {
		this.gu = gu;
	}

	public String getDong() {
		return dong;
	}

	public void setDong(String dong) {
		this.dong = dong;
	}

	public String getLat() {
		return lat;
	}

	public void setLat(String lat) {
		this.lat = lat;
	}

	public String getLon() {
		return lon;
	}

	public void setLon(String lon) {
		this.lon = lon;
	}

	public String getNet() {
		return net;
	}

	public void setNet(String net) {
		this.net = net;
	}
}
