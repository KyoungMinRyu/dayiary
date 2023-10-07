package com.icia.web.util;

import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.net.HttpURLConnection;
import java.net.URL;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.SortedMap;
import java.util.SortedSet;
import java.util.TreeMap;
import java.util.TreeSet;

import javax.crypto.Mac;
import javax.crypto.spec.SecretKeySpec;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.icia.common.util.StringUtil;
import com.icia.web.model.GeoLocation;

import org.json.JSONArray;
import org.json.JSONObject;

import org.apache.commons.codec.binary.Base64;
import org.apache.http.client.config.RequestConfig;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClientBuilder;	

public class NaverApi 
{
	private static final Logger logger = LoggerFactory.getLogger(NaverApi.class);
	private final String ACCESSKEY = ApiConfig.getProperties("naverSENSApi", "ownKey", "apiConfig"); // 네이버 개인 인증키
	private final String SECRETKEY = ApiConfig.getProperties("naverSENSApi", "secPwd", "apiConfig"); // 네이버 2차 인증키
	private final String SENSHOSTNAMEURL = ApiConfig.getProperties("naverSENSApi", "hostUrl", "apiConfig"); // 호스트 URL	    
	private final String SENSREQUESTURL = ApiConfig.getProperties("naverSENSApi", "requestUrl", "apiConfig"); // 요청 URL  
	private final String SENSSERVICEID = ApiConfig.getProperties("naverSENSApi", "projectId", "apiConfig"); // 프로젝트에 할당된 SMS 서비스 ID
	private final String GEOHOSTNAME = ApiConfig.getProperties("geoLocation", "hostUrl", "apiConfig"); // 호스트 URL
	private final String GEOREQUESTURL= ApiConfig.getProperties("geoLocation", "requestUrl", "apiConfig"); // 요청 URL
	private final String CLOVAHOSTURL = ApiConfig.getProperties("clovaChatbot", "hostUrl", "apiConfig"); // 호스트 URL
	private final String CLOVASECRETKEY = ApiConfig.getProperties("clovaChatbot", "secPwd", "apiConfig"); // 2차 인증키
	private final String CLOVADOMAINID = ApiConfig.getProperties("clovaChatbot", "domainId", "apiConfig"); // 도메인 아이디
	
	private JsonParsing jsonParsing;
	
	public NaverApi() 
	{
		jsonParsing = new JsonParsing();
	}
	
	/**
	 * <pre>
	 * 메소드명 : geoLocation
	 * 파라미터 : ip add를 String 타입으로 받아옴
	 * 리턴타입 : GeoLocation
	 * 설명 : 공인 아이피를 얻어와 네이버 GeoLocation Api를 통해 클라이언트에 위도 경도 값을 얻는다
	 **/
	public GeoLocation geoLocation(String ip)
	{
		GeoLocation geoLocation = null;
		final int timeout = 5000; // API Gateway 서버와 시간 차가 5분 이상 나는 경우 유효하지 않은 요청으로 간주
		final RequestConfig requestConfig = RequestConfig.custom().setSocketTimeout(timeout).setConnectTimeout(timeout).build();
		CloseableHttpClient httpClient = HttpClientBuilder.create().setDefaultRequestConfig(requestConfig).build();
    	final String requestMethod = "GET";
		final Map<String, List<String>> requestParameters = new HashMap<String, List<String>>();
		requestParameters.put("ip", Arrays.asList(ip)); // 지역 정보를 알고 싶은 ip 공인ip주소 들어가야함
		requestParameters.put("ext", Arrays.asList("t")); // 추가 정보 포함 여부 t : 포함, f : 비포함
		requestParameters.put("responseFormatType", Arrays.asList("json")); // 응답 결과의 포맷 타입 xml(기본값) 또는 json
		SortedMap<String, SortedSet<String>> parameters = convertTypeToSortedMap(requestParameters);
		String timestamp = generateTimestamp();
//		System.out.println("timestamp: " + timestamp);
		String baseString = GEOREQUESTURL + "?" + getRequestQueryString(parameters);
//		System.out.println("baseString : " + baseString);
		String msg = "";

		
		try 
		{
			String signature = makeSignature(requestMethod, baseString, timestamp, ACCESSKEY, SECRETKEY); // 3번째 매개변수 : accessKey, 4번쨰 매개변수 : secretKey
//			System.out.println("signature : " + signature);
			final String requestFullUrl = GEOHOSTNAME + baseString;
			final HttpGet request = new HttpGet(requestFullUrl);
			request.setHeader("x-ncp-apigw-timestamp", timestamp);
			request.setHeader("x-ncp-iam-access-key", ACCESSKEY); // accessKey
			request.setHeader("x-ncp-apigw-signature-v2", signature);
			final CloseableHttpResponse response;
			response = httpClient.execute(request);
			msg = getResponse(response);
			logger.debug(msg);
		}
		catch (Exception e) 
		{
            logger.error("[NaverApi](geoLocation) Exception : ", e);
		}
		if(msg != null && !StringUtil.isEmpty(msg))
		{
			geoLocation = new GeoLocation();
			msg = jsonParsing.parsingJson(msg, "geoLocation");
			geoLocation.setCountry(jsonParsing.parsingJson(msg, "country"));
	    	geoLocation.setSi(jsonParsing.parsingJson(msg, "r1"));
	    	geoLocation.setGu(jsonParsing.parsingJson(msg, "r2"));
	    	geoLocation.setDong(jsonParsing.parsingJson(msg, "r3"));
	    	geoLocation.setLat(jsonParsing.parsingJson(msg, "lat"));
	    	geoLocation.setLon(jsonParsing.parsingJson(msg, "long"));
	    	geoLocation.setNet(jsonParsing.parsingJson(msg, "net"));
		}
		return geoLocation;
	}
	
	/** 
	 * <pre>
	 * 메소드명 : naverSENSApi
	 * 파라미터 : String userPh, String content
	 * 리턴 타입 : String타입에 202 또는 null
	 * 설명 : userPh에 해당하는 번호로 content를 발송함 성공시 202 실패 시 null 반환
	 * 		msgType 0일 경우 SMS 
	 * 		msgType 1일 경우 LMS
	 **/
	public String naverSENSApi(String userPh, String content, int msgType)
	{
        String requestUrlType = "/messages"; // 요청 URL Type     
        String method = "POST"; // 요청 method
        String timestamp = Long.toString(System.currentTimeMillis());
        String apiUrl = SENSHOSTNAMEURL + getSENSRequestUrl(requestUrlType);
        //System.out.println(apiUrl);
//        System.out.println(timestamp);
        JSONObject toJson = new JSONObject();
        JSONObject bodyJson = new JSONObject();
        JSONArray jsonArray = new JSONArray();
        // 전송할 메세지
        //toJson.put("subject","");							// Optional, messages.subject	개별 메시지 제목, LMS, MMS에서만 사용 가능
	    //toJson.put("content","sms test in spring 111");	// Optional, messages.content	개별 메시지 내용, SMS: 최대 80byte, LMS, MMS: 최대 2000byte
	    toJson.put("to", userPh);						// Mandatory(필수), messages.to	수신번호, -를 제외한 숫자만 입력 가능
	    
	    jsonArray.put(toJson);
	    if(msgType == 0)
	    {
	    	bodyJson.put("type","SMS");							// Madantory, 메시지 Type (SMS | LMS | MMS), (소문자 가능)
	    }
    	else if(msgType == 1)
    	{
	    	bodyJson.put("type","LMS");							// Madantory, 메시지 Type (SMS | LMS | MMS), (소문자 가능)
    	}
    	else
    	{
    		return null;
    	}
    	//bodyJson.put("contentType","");					// Optional, 메시지 내용 Type (AD | COMM) * AD: 광고용, COMM: 일반용 (default: COMM) * 광고용 메시지 발송 시 불법 스팸 방지를 위한 정보통신망법 (제 50조)가 적용됩니다.
	    //bodyJson.put("countryCode","82");					// Optional, 국가 전화번호, (default: 82)
	    bodyJson.put("from","01096047420");					// Mandatory, 발신번호, 사전 등록된 발신번호만 사용 가능		
	    //bodyJson.put("subject","");						// Optional, 기본 메시지 제목, LMS, MMS에서만 사용 가능
	    bodyJson.put("content", content);	// Mandatory(필수), 기본 메시지 내용, SMS: 최대 80byte, LMS, MMS: 최대 2000byte
	    bodyJson.put("messages", jsonArray);					// Mandatory(필수), 아래 항목들 참조 (messages.XXX), 최대 1,000개

	    try 
        {
	    	URL url = new URL(apiUrl);
	        HttpURLConnection con = (HttpURLConnection)url.openConnection();
	        con.setUseCaches(false);
	        con.setDoOutput(true);
	        con.setDoInput(true);
	        con.setRequestProperty("Content-Type", "application/json");
	        con.setRequestProperty("x-ncp-apigw-timestamp", timestamp);
	        con.setRequestProperty("x-ncp-iam-access-key", ACCESSKEY);
	        con.setRequestProperty("x-ncp-apigw-signature-v2", makeSignature(method, getSENSRequestUrl(requestUrlType), timestamp, ACCESSKEY, SECRETKEY));
	        con.setRequestMethod(method);
	        con.setDoOutput(true);
	        DataOutputStream wr = new DataOutputStream(con.getOutputStream());
	        wr.write(bodyJson.toString().getBytes());
            wr.flush();
            wr.close();
            int responseCode = con.getResponseCode();
            BufferedReader br;
            logger.debug("naverSENSApi responseCode : " + responseCode);
            if(responseCode==202) 
            { // 정상 호출
                br = new BufferedReader(new InputStreamReader(con.getInputStream()));
            } 
            else 
            {  // 에러 발생
                br = new BufferedReader(new InputStreamReader(con.getErrorStream()));
                return null;
            }
            String inputLine;
            StringBuffer response = new StringBuffer();
            while ((inputLine = br.readLine()) != null) 
            {
                response.append(inputLine);
            }
            br.close();
            return Integer.toString(responseCode);
        } 
        catch (Exception e) 
        {
            logger.error("[NaverApi](naverSENSApi) Exception : ", e);
        }
		return null;
	}
	
	
	/** 
	 * <pre>
	 * 메소드명 : naverSENSApi
	 * 파라미터 : String userPh
	 * 리턴 타입 : 랜덤 숫자 6자리 (String 타입)
	 * 설명 : naverSENSApi(String userPh, String content) 다시 호출 후 리턴 값이 202일 경우 정상 호출
	 **/
	public String naverSENSApi(String userPh)
	{
		String ranNum = Integer.toString((int)(Math.random() * (999999 - 100000 + 1)) + 100000);
		String content = "[Dayiary]\n인증번호 [" + ranNum + "]를 입력창에 입력해주세요.";
        if(StringUtil.equals(naverSENSApi(userPh, content, 0), "202"))
		{
        	return ranNum;
		}
        else
        {
        	return null;
        }
	}
	
	public String clovaChatbot(String msg, String userId)
	{
		String chatbotMessage = "";

        try {
            //String apiURL = "https://ex9av8bv0e.apigw.ntruss.com/custom_chatbot/prod/";

            URL url = new URL(CLOVAHOSTURL);

            String message = getReqMessage(msg, userId);
            System.out.println("##" + message);

            String encodeBase64String = makeSignature(message, CLOVASECRETKEY);

            HttpURLConnection con = (HttpURLConnection)url.openConnection();
            con.setRequestMethod("POST");
            con.setRequestProperty("Content-Type", "application/json;UTF-8");
            con.setRequestProperty("X-NCP-CHATBOT_SIGNATURE", encodeBase64String);

            // post request
            con.setDoOutput(true);
            DataOutputStream wr = new DataOutputStream(con.getOutputStream());
            wr.write(message.getBytes("UTF-8"));
            wr.flush();
            wr.close();
            int responseCode = con.getResponseCode();

            if(responseCode==200) { // Normal call
                System.out.println(con.getResponseMessage());

                BufferedReader in = new BufferedReader(
                        new InputStreamReader(
                                con.getInputStream()));
                String decodedString;
                while ((decodedString = in.readLine()) != null) {
                    chatbotMessage = decodedString;
                }
                //chatbotMessage = decodedString;
                in.close();


				logger.debug("###############################################");
				System.out.println(chatbotMessage);
				logger.debug("###############################################");
			}
			else 
			{  // 에러 발생
				BufferedReader in = new BufferedReader(new InputStreamReader(con.getInputStream(), "UTF-8"));
	            String decodedString;
	            StringBuilder jsonStringBuilder = new StringBuilder();
	            while ((decodedString = in.readLine()) != null) 
	            {
	                jsonStringBuilder.append(decodedString);
	            }
				logger.debug("###############################################");
				logger.debug("clovaChatbot Error Code : " + responseCode);
				logger.debug(jsonStringBuilder.toString());
				logger.debug("###############################################");
				
	        }
		}
		catch (Exception e) 
		{
            logger.error("[NaverApi](clovaChatbot) Exception : ", e);
		}
		
		return chatbotMessage;
	}
	
	
	
	/**
	 * <pre>
	 * 메소드명 : getSENSRequestUrl
	 * 파라미터 : 없음
	 * 리턴타입 : String
	 * 설명 : naver sensApi를 호출하기 위해 url만들어서 리턴
	 **/
	private String getSENSRequestUrl(String requestUrlType)
	{
		return SENSREQUESTURL + SENSSERVICEID + requestUrlType;
	}
	
	private static String getResponse(final CloseableHttpResponse response) throws Exception 
	{
		final StringBuffer buffer = new StringBuffer();
		final BufferedReader reader = new BufferedReader(new InputStreamReader(response.getEntity().getContent()));

		String msg;

		try 
		{
			while ((msg = reader.readLine()) != null) 
			{
				buffer.append(msg);
			}
		} 
		catch (final Exception e) 
		{
			throw e;
		} 
		finally 
		{
			response.close();
		}
		return buffer.toString();
	}
	
	/**
	 * @param requestParameters
	 * @param significateParameters
	 */
	private SortedMap<String, SortedSet<String>> convertTypeToSortedMap(final Map<String, List<String>> requestParameters) 
	{
		final SortedMap<String, SortedSet<String>> significateParameters = new TreeMap<String, SortedSet<String>>();
		final Iterator<String> parameterNames = requestParameters.keySet().iterator();
		while (parameterNames.hasNext()) 
		{
			final String parameterName = parameterNames.next();
			List<String> parameterValues = requestParameters.get(parameterName);
			if (parameterValues == null) 
			{
				parameterValues = new ArrayList<String>();
			}
			for (String parameterValue : parameterValues) 
			{
				if (parameterValue == null) 
				{
					parameterValue = "";
				}
				SortedSet<String> significantValues = significateParameters.get(parameterName);
				if (significantValues == null) 
				{
					significantValues = new TreeSet<String>();
					significateParameters.put(parameterName, significantValues);
				}
				significantValues.add(parameterValue);
			}
		}
		return significateParameters;
	}

	private static String generateTimestamp() 
	{
		return Long.toString(System.currentTimeMillis());
	}

	/**
	 * query string 생성
	 * @param significantParameters
	 * @return
	 */
	private String getRequestQueryString(final SortedMap<String, SortedSet<String>> significantParameters) 
	{
		final StringBuilder queryString = new StringBuilder();
		final Iterator<Map.Entry<String, SortedSet<String>>> paramIt = significantParameters.entrySet().iterator();
		while (paramIt.hasNext()) 
		{
			final Map.Entry<String, SortedSet<String>> sortedParameter = paramIt.next();
			final Iterator<String> valueIt = sortedParameter.getValue().iterator();
			while (valueIt.hasNext()) 
			{
				final String parameterValue = valueIt.next();
				queryString.append(sortedParameter.getKey()).append('=').append(parameterValue);
				if (paramIt.hasNext() || valueIt.hasNext()) 
				{
					queryString.append('&');
				}
			}
		}
		return queryString.toString();
	}	
	
	/**
	 * * base string과 , access key, secret key를 가지고 signature 생성
	 * @param method
	 * @param baseString or Url
	 * @param timestamp
	 * @param accessKey
	 * @param secretKey
	 * @return
	 * @throws NoSuchAlgorithmException
	 * @throws UnsupportedEncodingException
	 * @throws InvalidKeyException
	 */
	private String makeSignature
			(
				String method, 
				String baseString, 
				String timestamp, 
				String accessKey, 
				String secretKey
			) throws UnsupportedEncodingException, NoSuchAlgorithmException, InvalidKeyException{
	    String space = " ";                       // one space
	    String newLine = "\n";                    // new line
	    String message = new StringBuilder()
	        .append(method)
	        .append(space)
	        .append(baseString)
	        .append(newLine)
	        .append(timestamp)
	        .append(newLine)
	        .append(accessKey)
	        .toString();
	    SecretKeySpec signingKey = new SecretKeySpec(secretKey.getBytes("UTF-8"), "HmacSHA256");
		Mac mac = Mac.getInstance("HmacSHA256");
	    mac.init(signingKey);
	    byte[] rawHmac = mac.doFinal(message.getBytes("UTF-8"));
	    String encodeBase64String = Base64.encodeBase64String(rawHmac);
	    System.out.println(encodeBase64String);
	    return encodeBase64String;
	}
	
	
	public static String makeSignature(String message, String secretKey) 
	{

        String encodeBase64String = "";

        try 
        {
            byte[] secrete_key_bytes = secretKey.getBytes("UTF-8");

            SecretKeySpec signingKey = new SecretKeySpec(secrete_key_bytes, "HmacSHA256");
            Mac mac = Mac.getInstance("HmacSHA256");
            mac.init(signingKey);

            byte[] rawHmac = mac.doFinal(message.getBytes("UTF-8"));
    	    encodeBase64String = Base64.encodeBase64String(rawHmac);
            return encodeBase64String;

        } 
        catch (Exception e)
        {
            System.out.println(e);
        }

        return encodeBase64String;

    }
	
	public String getReqMessage(String msg, String userId) 
	{

		String requestBody = "";

		try 
		{

			JSONObject obj = new JSONObject();

			long timestamp = new Date().getTime();

			System.out.println("##" + timestamp);

			obj.put("version", "v2");
			obj.put("userId", userId);
			// => userId is a unique code for each chat user, not a fixed value, recommend
			// use UUID. use different id for each user could help you to split chat history
			// for users.

			obj.put("timestamp", timestamp);

			JSONObject bubbles_obj = new JSONObject();

			bubbles_obj.put("type", "text");

			JSONObject data_obj = new JSONObject();
			data_obj.put("description", msg);

			bubbles_obj.put("type", "text");
			bubbles_obj.put("data", data_obj);

			JSONArray bubbles_array = new JSONArray();
			bubbles_array.put(bubbles_obj);

			obj.put("bubbles", bubbles_array);
			obj.put("event", "send");

			requestBody = obj.toString();

		} 
		catch (Exception e) 
		{
			System.out.println("## Exception : " + e);
		}

		return requestBody;

	}
}


















