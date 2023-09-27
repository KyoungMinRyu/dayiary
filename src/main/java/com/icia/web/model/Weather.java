package com.icia.web.model;

import java.io.Serializable;

public class Weather implements Serializable
{
	private static final long serialVersionUID = 1L;

	private String 
					precipitationType, // 강수 형태
					humidity, // 습도
					precipitationHourValue, // 시간당 강수량
					temperature; // 온도
	
	private GeoLocation geoLocation; // 위치 정보 객체
	
	public Weather() 
	{
		precipitationType = "";
		humidity = "";
		precipitationHourValue = "";
		temperature = "";
		geoLocation = null;
	}

	public String getPrecipitationType() 
	{
		return precipitationType;
	}

	public void setPrecipitationType(String precipitationType) 
	{
		this.precipitationType = precipitationType;
	}

	public String getHumidity() 
	{
		return humidity;
	}

	public void setHumidity(String humidity) 
	{
		this.humidity = humidity;
	}

	public String getPrecipitationHourValue() 
	{
		return precipitationHourValue;
	}

	public void setPrecipitationHourValue(String precipitationHourValue) 
	{
		this.precipitationHourValue = precipitationHourValue;
	}

	public String getTemperature() 
	{
		return temperature;
	}

	public void setTemperature(String temperature) 
	{
		this.temperature = temperature;
	}

	public GeoLocation getGeoLocation() 
	{
		return geoLocation;
	}

	public void setGeoLocation(GeoLocation geoLocation) 
	{
		this.geoLocation = geoLocation;
	}
}
