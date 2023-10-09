package com.icia.web.util;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.io.StringWriter;
import java.util.ArrayList;
import java.util.List;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.transform.OutputKeys;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.dom.DOMSource;
import javax.xml.transform.stream.StreamResult;

import org.json.*;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.w3c.dom.Document;

import com.google.gson.JsonArray;

/**
 * <pre>
 * 클래스명 : JsonParsing
 * 설명 : xml과 Json타입의 데이터를 다룸
 **/
public class JsonParsing
{	
	private static final Logger logger = LoggerFactory.getLogger(JsonParsing.class);
	
	/**
	 * <pre>
	 * 메소드명 : length
	 * 파라미터 : JSONArray
	 * 설명 : jsonArray의 len를 구해준다 
	 **/
	public int length(JSONArray jsonArray)
	{
		return jsonArray.length();
	}
	
	/**
	 * <pre>
	 * 메소드명 : length
	 * 파라미터 : String
	 * 설명 : jsonArray의 len를 구해준다 
	 **/
	public int length(String jsonArray)
	{
		return length(new JSONArray(jsonArray));
	}
	
	/**
	 * <pre>
	 * 메소드명 : parsingJson
	 * 파라미터 : JSONObject json, String key
	 * 리턴타입 : String
	 * 설명 : parsingJson(String json, String key) 다시 호출함
	 **/
	public String parsingJson(JSONObject json, String key) 
	{
		return parsingJson(json.toString(), key);
	}
	
	/**
	 * <pre>
	 * 메소드명 : parsingJson
	 * 파라미터 : JSONObject json, String key[]
	 * 리턴타입 : String 
	 * 설명 : parsingJson(String json, String key[]) 다시 호출함
	 **/
	public String parsingJson(JSONObject json, String key[]) 
	{
		return parsingJson(json.toString(), key);
	}
	
	/**
	 * <pre>
	 * 메소드명 : parsingJson
	 * 파라미터 : String json, String key[]
	 * 리턴타입 : String
	 * 설명 : json데이터에서 해당 key[]의 길이 만큼 key : value를 통해서 마지막에 있는 데이터를 가져옴
	 **/
	public String parsingJson(String json, String key[]) 
	{
		for(int i = 0; i < key.length; i++)
		{
			json = parsingJson(json, key[i]);
		}
		return json;
	}
	
	/**
	 * <pre>
	 * 메소드명 : parsingJson
	 * 파라미터 : String json, String key
	 * 리턴타입 : String
	 * 설명 : 문자열 타입에 Json데이터에서 key에 해당하는 value를 가져옴
	 * JSON타입의 데이터는 key : value로 이루어져 있음
	 **/
	public String parsingJson(String json, String key) 
	{
		JSONObject jsonObject;
		try 
		{
			jsonObject = new JSONObject(json);
			json = jsonObject.get(key).toString();				
			return json;
		} 
		catch (JSONException e) 
		{
            logger.error("[JsonParsing](parsingJson) Exception : ", e);
		}
		return null;
	}
	
	/**
	 * <pre>
	 * 메소드명 : parsingArr
	 * 파라미터 : Json데이터 안에서 JSONArray 
	 * 리턴타입 : List<String> 
	 * 설명 : parsingArr(String jsonArr) 다시 호출함
	 **/
	public List<String> parsingArr(JSONArray jsonArray)
	{
		return parsingArr(jsonArray.toString());
	}

	/**
	 * <pre>
	 * 메소드명 : parsingArr
	 * 파라미터 : 문자열타입에 JSON데이터 안에 있는 Array
	 * 리턴타입 : List<String> 
	 * 설명 : Json데이터 안에서 Array를 넘기면 해당 Array의 길이만큼 배열 안에 있는 json데이터를 list<String>으로 반환해줌
	 **/ 
	public List<String> parsingArr(String jsonArr)
	{
		List<String> list = new ArrayList<String>();
		JSONArray jsonArray = new JSONArray(jsonArr);
		JSONObject jsonObject;
		try 
		{
			//System.out.println(jsonArray.length());
			for (int i = 0; i < jsonArray.length(); i++) 
			{ 
				jsonObject = jsonArray.getJSONObject(i); // JSON파일의 i번째 배열마다 데이터 파싱
				list.add(jsonObject.toString());
			}
		}
		catch (JSONException e) 
		{
            logger.error("[JsonParsing](parsingArr) Exception : ", e);
		}
		return list;
	}
	
	/**
	 * <pre>
	 * 메소드명 : parsingArr
	 * 파라미터 : JSONArray jsonArray, String key
	 * 리턴타입 : List<String> 
	 * 설명 : parsingArr(String jsonArr, String key) 다시 호출함
	 **/
	public List<String> parsingArr(JSONArray jsonArray, String key)
	{
		return parsingArr(jsonArray.toString(), key);
	}
	
	/**
	 * <pre>
	 * 메소드명 : parsingArr
	 * 파라미터 : String jsonArr, String key
	 * 리턴타입 : List<String> 
	 * 설명 : Json데이터 안에서 Array를 넘기면 해당 Array의 안에 해당 key값에 있는 json데이터를 list<String>으로 반환해줌
	 **/
	public List<String> parsingArr(String jsonArr, String key)
	{
		List<String> list = new ArrayList<String>();
		JSONArray jsonArray = new JSONArray(jsonArr);
		JSONObject jsonObject;
		try 
		{
			for (int i = 0; i < jsonArray.length(); i++) 
			{ 
				jsonObject = jsonArray.getJSONObject(i); // JSON파일의 i번째 배열마다 데이터 파싱
				logger.debug(parsingJson(jsonObject, key));
				list.add(parsingJson(jsonObject, key));
			}
		}
		catch (JSONException e) 
		{
            logger.error("[JsonParsing](parsingArr) Exception : ", e);
		}
		return list;
	}
	
	/**
	 * <pre>
	 * 메소드명 : xmlToJson
	 * 파라미터 : JSONObject xml
	 * 리턴타입 : String
	 * 설명 : xmlToJson(String xml) 다시 호출함
	 **/
	public String xmlToJson(JSONObject xml) 
	{
		return xmlToJson(xml.toString());
	}
	
	/**
	 * <pre> 
	 * 메소드명 : xmlToJson
	 * 파라미터 : String xml
	 * 리턴타입 : String
	 * 설명 : xml형식의 파일을 Json형식의 파일로 변경하여 문자열로 리턴해줌
	 **/
	public String xmlToJson(String xml) // XML파일을 JSON형식으로 변환
	{
		String json = "";
		try 
		{
			JSONObject jsonObject = XML.toJSONObject(xml);
			json = jsonObject.toString();
			System.out.println(json);
			return json;
		}
		catch (JSONException e) 
		{
            logger.error("[JsonParsing](xmlToJson) Exception : ", e);
		}
		return null;
	}
	
	/**
	 * <pre>
	 * 뭔지 기억안남 
	 **/
	public String setJsonArray(String jsonData[]) 
	{
		JSONArray jsonArray = new JSONArray();
		try 
		{
			for(int i = 0; i < jsonData.length; i++)
			{
				jsonArray.put(jsonData[i]);
			} 
			return jsonArray.toString();
		}
		catch (JSONException e)
		{
            logger.error("[JsonParsing](setJsonArray) Exception : ", e);
		}
		return null;
	}
	
	/**
	 * <pre>
	 * 메소드명 : putJsonArr
	 * 파라미터 : String key, JsonArray jsonArray
	 * 리턴타입 : String
	 * 설명 : putJsonArr(String key, String jsonArr) 다시 호출함
	 **/
	public String putJsonArr(String key, JsonArray jsonArray)
	{
		return putJsonArr(key, jsonArray.toString());
	}
	
	/**
	 * <pre>
	 * 메소드명 : putJsonArr
	 * 파라미터 : String key, String jsonArray
	 * 리턴타입 : String
	 * 설명 : jsonArr를 key : value값으로 넣는다.
	 **/
	public String putJsonArr(String key, String jsonArr)
	{
        JSONObject jsonObject = new JSONObject();
        return jsonObject.put(key, jsonArr).toString();
	}
	
	/**
	 * <pre>
	 * 메소드명 : putJsonValue
	 * 파라미터 : String key, String value
	 * 리턴타입 : String
	 * 설명 : key : value JSON 형식으로 넣는다.
	 **/
	public String putJsonValue(String key, String value)
	{
		return new JSONObject().put(key, value).toString();
	}
	
	public JSONObject putJsonValue(JSONObject jsonObject, String key, String value)
	{
		return jsonObject.put(key, value);
	}
		

	public String putJsonValue(List<String> key, List<Object> value)
	{
		return putJsonValue(new JSONObject(), key, value).toString();
	}
	
	public JSONObject putJsonValue(JSONObject jsonObject, List<String> key, List<Object> value)
	{
		for(int j = 0; j < value.size(); j++)
    	{
			jsonObject.put(key.get(j), value.get(j));
    	}
		return jsonObject;
	}
	
	
	
	public String[][] parsingArray(JSONObject arr, String key1, String key2) //JSON 안에 있는 배열을 파싱
	{		
		return parsingArray(arr.toString(), key1, key2);
	}
	
	public String[][] parsingArray(String arr, String key1, String key2) //JSON 안에 있는 배열을 파싱
	{		

		JSONArray jsonArray = new JSONArray(arr);
		JSONObject jsonObject;
		String arrData[][] = new String[2][jsonArray.length()];
		try 
		{
			for (int i = 0; i < jsonArray.length(); i++) 
			{ 
				jsonObject = jsonArray.getJSONObject(i); // JSON파일의 i번째 배열마다 데이터 파싱
				arrData[0][i] = jsonObject.get(key1).toString(); // i번째 배열의 JSON파일 key값 통해서 value저장
				arrData[1][i] = jsonObject.get(key2).toString(); // i번째 배열의 JSON파일 key값 통해서 value저장
	//			System.out.println(arrData[0][i] + " : " + arrData[1][i]); //배열 파싱되고 있는지 확인
			}
			return arrData;
		}
		catch (JSONException e) 
		{
            logger.error("[JsonParsing](setJsonArray) : ", e);
		}
		return null;
	}
	
	/**
	 * <pre>
	 * 메소드명 : readXml
	 * 파라미터 : String fileName
	 * 리턴타입 : String
	 * 설명 : readXml(File file) 다시 호출함
	 **/
	public String readXml(String fileName) // xml파일을 읽어와 String으로 반환
	{
		return readXml(new File("C:/Code/webapps/dayiary/src/main/resources/com/icia/web/mapper/" + fileName));
	}
	
	/**
	 * <pre>
	 * 메소드명 : readXml
	 * 파라미터 : File file
	 * 리턴타입 : String
	 * 설명 : 해당 파일 객체에 경로에 있는 xml파일을 읽어와 String 타입으로 변환 후 리턴
	 **/
	public String readXml(File file) // 파일객체에서 xml파일을 읽어와 String으로 반환
	{
		DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
    	try 
    	{
    		DocumentBuilder builder = factory.newDocumentBuilder();
        	Document doc = builder.parse(file);
        	TransformerFactory tf = TransformerFactory.newInstance();
        	Transformer transformer = tf.newTransformer();
        	transformer.setOutputProperty(OutputKeys.OMIT_XML_DECLARATION, "yes");
        	StringWriter writer = new StringWriter();
        	transformer.transform(new DOMSource(doc), new StreamResult(writer));
        	return writer.getBuffer().toString();
		} 
    	catch (Exception e) 
    	{
            logger.error("[JsonParsing](readXml) : ", e);
		}
		return "";
	}
	
	/**
	 * <pre>
	 * 메소드명 : readFile
	 * 파라미터 : String path
	 * 리턴타입 : String
	 * 설명 : 경로에 있는 파일을 읽어와서 String으로 반환해줌
	 **/
	public String readFile(String path)
	{
		try 
		{
			BufferedReader bufferedReader = new BufferedReader(new FileReader(path));
	        StringBuilder stringBuilder = new StringBuilder();

	        String line;
	        
	        while((line = bufferedReader.readLine()) != null) 
	        {
	        	stringBuilder.append(line);
	        }
   
	        bufferedReader.close();
          	return stringBuilder.toString();
		} 
		catch (IOException e) 
		{
            logger.error("[JsonParsing](readFile) : ", e);
		}
		return "";
	}
}
