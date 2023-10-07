package com.icia.web.util;

import java.io.BufferedReader;




import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.icia.common.util.StringUtil;
import com.icia.web.model.GeoLocation;
import com.icia.web.model.Weather;


public class PublicDataApi 
{
	private static final Logger logger = LoggerFactory.getLogger(PublicDataApi.class);
	
	private final String WEATHERAPIURL = ApiConfig.getProperties("weatherApi", "url", "apiConfig");
	private final String MOONDAYAPIURL = ApiConfig.getProperties("moonDayApi", "moonDayUrl", "apiConfig");
	private final String APIKEY = ApiConfig.getProperties("weatherApi", "key", "apiConfig");
	private LocalDateTime localDateTime = LocalDateTime.now();
	
	public LocalDateTime getLocalDateTime() 
	{
		return localDateTime;
	}


	/**
	 * <pre>
	 * 메소드명 : getMoonDayData
	 * 파라미터 : String year
	 * 리턴타입 : Map<List<String>, List<String>>
	 * 설명 : 파라미터로 들어온 해당 year에 대해서 설날과 추석을 계산해서 리턴한다 
	 * 		Map key값이 0이면 설날 1이면 추석 
	 * 		value값이 List에서 0번쨰는 월 1번쨰는 일 2번쨰는 추석 or 설날
	 **/
	public Map<String, List<String>> getMoonDayData(String year)
	{
        Map<String, List<String>> map = new HashMap<String, List<String>>();
		List<String> chuseok = new ArrayList<String>();
		List<String> newYear = new ArrayList<String>();
        JsonParsing jsonParsing = new JsonParsing();
		StringBuilder chuseokUrlBuilder = makeURL(1);
		stringAppend(chuseokUrlBuilder, "lunYear", year);
		
        StringBuilder newYearUrlBuilder = new StringBuilder(chuseokUrlBuilder.toString());
        
        stringAppend(chuseokUrlBuilder, "lunMonth", "08");
        stringAppend(chuseokUrlBuilder, "lunDay", "15");
        
        stringAppend(newYearUrlBuilder, "lunMonth", "01");
        stringAppend(newYearUrlBuilder, "lunDay", "01");
        
        logger.debug("Api Request Chuseok Url : " + chuseokUrlBuilder.toString());
        
        logger.debug("Api Request New Year Url : " + newYearUrlBuilder.toString());
        
        String chuseokDate = requestRestApi(chuseokUrlBuilder.toString(), "GET");
        
        String newYearDate = requestRestApi(newYearUrlBuilder.toString(), "GET");
    	

        logger.debug("Api Response Chuseok Data : " + chuseokDate);
        
        logger.debug("Api Response New Year Data : " + newYearDate);
        
        String[] parsingArr = {"response", "body", "items", "item"};
        String chuseokJson = jsonParsing.parsingJson(jsonParsing.xmlToJson(chuseokDate), parsingArr);
        String newYearJson = jsonParsing.parsingJson(jsonParsing.xmlToJson(newYearDate), parsingArr);
        
        chuseok.add(jsonParsing.parsingJson(chuseokJson, "solMonth"));
        chuseok.add(jsonParsing.parsingJson(chuseokJson, "solDay"));
        chuseok.add("추석");
        
        newYear.add(jsonParsing.parsingJson(newYearJson, "solMonth"));
        newYear.add(jsonParsing.parsingJson(newYearJson, "solDay"));
        newYear.add("설날");
        
        map.put("0", newYear);
        map.put("1", chuseok);
        
		return map;
	}
	
	
	/** 
	 * <pre>
	 * /getUltraSrtFcst	초단기예보조회  baseTime 30분 단위 발표 (00, 30) + 15분 호출 ex) 00 -> 15, 30 -> 45
	 * /getVilageFcst		단기예보조회
	 * /getFcstVersion		예보버전조회
	 * /getUltraSrtNcst 	초단기실황조회 baseTime 매 정시 발표 ex) 1800
	 * PTY 강수형태 (초단기) 없음(0), 비(1), 비/눈(2), 눈(3), 빗방울(5), 빗방울눈날림(6), 눈날림(7)
	 * REH 습도(%) RN1 1시간 강수량(mm) T1H 기온() UUU 동서풍(m/s) VEC 풍향(deg) VVV 남북풍(m/s) WSD 풍속(m/s)
	 * 매소드명 : weatherApi
	 * 파라미터 : HttpServletRequest request
	 * 리턴타입 : Weather
	 * 설명 : 클라이언트가 접속 했을 때 ip address를 얻어와 naver api를 통해 클라이언트 위도 경도 값을 얻어와 해당 위치에 대한 날씨 정보를 얻어옴
	 **/
	public Weather weatherApi(HttpServletRequest request)
	{
		String weatherDate = "";
		String data = "";
		String category = "";
		NaverApi naverApi = new NaverApi();
		GeoLocation geoLocation = null;
//		geoLocation = naverApi.geoLocation(HttpUtil.getIP(request)); // 원래 외부에서 들어올 수 있는 서버라면 이코드가 들어가야하지만 지금 내부에서만 들어오기 떄문에 따른 공인 아이피를 넣어줘야함
		geoLocation = naverApi.geoLocation(requestRestApi("https://api.ip.pe.kr/", "GET")); // 우리가 접속 할 떄는 127.0.0.1로 나오기 떄문에 다른 api를 호출하여 공인ip주소를 얻어야함
    	if(geoLocation != null)
    	{
			StringBuilder urlBuilder = makeURL(0);
	    	stringAppend(urlBuilder, "pageNo", "1"); // 페이지 번호
	    	stringAppend(urlBuilder, "numOfRows", "1000"); // 한 페이지 결과 수
	    	stringAppend(urlBuilder, "dataType", "JSON"); // 요청 자료 형식 xml 또는 json
	    	stringAppend(urlBuilder, "base_date", localDateTime.format(DateTimeFormatter.ofPattern("yyyyMMdd"))); // 최근 1일 자료만 지원해줌 오늘 날짜 8자리 ex) 20230817
	    	stringAppend(urlBuilder, "base_time", localDateTime.minusHours(1).format(DateTimeFormatter.ofPattern("HHmm"))); // 30분 단위 발표 (00, 30) + 15분이후 호출해야 오류 안남 ex) 1800 (24시간단위) 
	    	stringAppend(urlBuilder, "nx", "60"); // 예보 지점의 위도값(int타입의 String)
	    	stringAppend(urlBuilder, "ny", "127"); // 예보 지점의 경도값(int타입의 String	
//	    	stringAppend(urlBuilder, "nx", geoLocation.getLat().substring(0, geoLocation.getLat().indexOf("."))); // 예보 지점의 위도값(int타입의 String)
//	    	stringAppend(urlBuilder, "ny", geoLocation.getLon().substring(0, geoLocation.getLon().indexOf("."))); // 예보 지점의 경도값(int타입의 String)
	    	logger.debug("Api Request Url : " + urlBuilder.toString());
	    	weatherDate =  requestRestApi(urlBuilder.toString(), "GET");
	    	logger.debug(weatherDate);
	    	if(weatherDate != null && !StringUtil.isEmpty(weatherDate))
	    	{
	    		String[] parsingArr = {"response", "body" ,"items", "item"};
	    		Weather weather = new Weather();
	    		JsonParsing jsonParsing = new JsonParsing();
	    		weatherDate = jsonParsing.parsingJson(weatherDate, parsingArr);
	    		List<String> weatherList = jsonParsing.parsingArr(weatherDate);
	    		for(int i = 0; i < weatherList.size(); i++)
	    		{
	    			data = weatherList.get(i);
	    			category = jsonParsing.parsingJson(data, "category");
	    			if(StringUtil.equals(category, "PTY"))
	    			{
	    				weather.setPrecipitationType(jsonParsing.parsingJson(data, "obsrValue"));
//	    				System.out.println(jsonParsing.parsingJson(data, "obsrValue"));
	    			}
	    			else if(StringUtil.equals(category, "REH"))
	    			{
	    				weather.setHumidity(jsonParsing.parsingJson(data, "obsrValue"));
//	    				System.out.println(jsonParsing.parsingJson(data, "obsrValue"));
	    			}
	    			else if(StringUtil.equals(category, "RN1"))
	    			{
	    				weather.setPrecipitationHourValue(jsonParsing.parsingJson(data, "obsrValue"));
//	    				System.out.println(jsonParsing.parsingJson(data, "obsrValue"));
	    			}
	    			else if(StringUtil.equals(category, "T1H"))
	    			{
	    				weather.setTemperature(jsonParsing.parsingJson(data, "obsrValue"));
//	    				System.out.println(jsonParsing.parsingJson(data, "obsrValue"));
	    			}
	    		}
	    		weather.setGeoLocation(geoLocation);
	    		return weather;
	    	}
    	}
		return null;
	}
	
	/**
	 * <pre>
	 * 메소드명 : deliveryTracker
	 * 파라미터 : String companyId, String deliveryNum
	 * 리턴타입 : String
	 * 설명 : companyId, deliveryNum를 url에 붙여서 배송조회하여 조회값을 받아온다.
	 **/
	public String deliveryTracker(String companyId, String deliveryNum)
	{
		return requestRestApi("https://apis.tracker.delivery/carriers/" + companyId + "/tracks/" + deliveryNum, "GET");
	}

	/**
	 * <pre>
	 * 메소드명 : requestRestApi
	 * 파라미터 : requestUrl(요청보낼 url), methodType(get, post)
	 * 리턴타입 : String(xml, json)
	 * 설명 : 완성된 url로 요청을 보내면 xml 또는 json타입의 String을 넘겨준다
	 **/
	public String requestRestApi(String requestUrl, String methodType) 
	{
		try 
		{
			URL url = new URL(requestUrl);    	
	    	HttpURLConnection conn = (HttpURLConnection) url.openConnection();
	    	conn.setRequestMethod(methodType);
		    conn.setRequestProperty("Content-type", "application/json");
		    logger.debug("Response code: " + conn.getResponseCode());
		    BufferedReader rd;
		    if(conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300) 
		    {
		        rd = new BufferedReader(new InputStreamReader(conn.getInputStream()));
		    } 
		    else 
		    {
		        rd = new BufferedReader(new InputStreamReader(conn.getErrorStream()));
		    }
	        StringBuilder sb = new StringBuilder();
	        String line;
	        while ((line = rd.readLine()) != null) 
	        {
	            sb.append(line);
	        }
	        rd.close();
	        conn.disconnect();
	        logger.debug(sb.toString());
	        if(conn.getResponseCode() == 404)
	        {
	        	return "";
	        }
	        return sb.toString();
		} 
		catch (Exception e) 
		{
            logger.error("[PublicDataApi](requestRestApi) Exception : ", e);
		}	
		return "";
	}
	
	/**
	 * 메소드명 : makeURL
	 * 파라미터 : 0, 1, 2
	 * 리턴타입 : StringBuilder
	 * 설명 0일 시 weather Api, 1일 시 holiday Api(getAnniversaryInfo),  2일 시 holiday Api(getAnniversaryInfo) 
	 **/
	public StringBuilder makeURL(int type)
	{	
		StringBuilder urlBuilder = null;
		if(type == 0) // weather Api
		{
			urlBuilder = new StringBuilder(WEATHERAPIURL + "?" + encoderUTF("serviceKey") + "=" + APIKEY);
		}
		else if(type == 1) //  holiday Api(getAnniversaryInfo)
		{
			urlBuilder = new StringBuilder(MOONDAYAPIURL + "?" + encoderUTF("serviceKey") + "=" + APIKEY);
		}
		else
		{
			return null;
		}
		logger.debug("request Url" + urlBuilder.toString());
		return urlBuilder;
	}

	/**
	 * <pre>
	 * 메소드명 : stringAppend
	 * 파라미터 : StringBuilder, key, value
	 * 리턴타입 : StringBuilder
	 * 설명 : url에 &와 =을 자동으로 붙여준다.
	 **/
	public StringBuilder stringAppend(StringBuilder stringBuilder, String key, String value)
	{
		return stringBuilder.append("&" + encoderUTF(key) + "=" + encoderUTF(value));
	}
	
	
	/**
	 * <pre>
	 * 메소드명 : encoderUTF
	 * 파라미터 : 인코딩할 문자열
	 * 리턴타입 : String
	 * 설명 : Api호출 url을 UTF-8로 인코딩해준다
	 **/
	public String encoderUTF(String data) 
	{
		try
		{
			return URLEncoder.encode(data, "UTF-8");	
		}
		catch(UnsupportedEncodingException e)
		{
            logger.error("[PublicDataApi](encoderUTF) Exception : ", e);
		}
		return null;
	}
}
