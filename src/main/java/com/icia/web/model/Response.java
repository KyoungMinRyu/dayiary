/**
 * <pre>
 * 프로젝트명 : HiBoard
 * 패키지명   : com.icia.web.model
 * 파일명     : Response.java
 * 작성일     : 2021. 1. 21.
 * 작성자     : daekk
 * </pre>
 */
package com.icia.web.model;

import java.io.Serializable;

import com.google.gson.annotations.Expose;

/**
 * <pre>
 * 패키지명   : com.icia.web.model
 * 파일명     : Response.java
 * 작성일     : 2021. 1. 21.
 * 작성자     : daekk
 * 설명       : Response (AJAX)
 * </pre>
 */
public class Response<T> implements Serializable
{
	private static final long serialVersionUID = 3671772454880897888L;
	
	@Expose
	private int code;   // 코드
	@Expose
	private String msg; // 메시지
	@Expose
	private T data;     // 데이터
	
	/**
	 * 생성자
	 */
	public Response()
	{
		this(-1, null, null);
	}
	
	/**
	 * 생성자 
	 * 
	 * @param code 결과 코드
	 * @param msg  결과 메시지
	 */
	public Response(int code, String msg)
	{
		this(code, msg, null);
	}
	
	/**
	 * 생성자
	 * 
	 * @param code 결과 코드
	 * @param msg  결과 메시지
	 * @param data 데이터
	 */
	public Response(int code, String msg, T data)
	{
		this.code = code;
		this.msg = msg;
		this.data = data;
	}

	/**
	 * <pre>
	 * 메소드명   : getCode
	 * 작성일     : 2021. 1. 21.
	 * 작성자     : daekk
	 * 설명       :
	 * </pre>
	 * @return 
	 */
	public int getCode()
	{
		return code;
	}

	/**
	 * <pre>
	 * 메소드명   : setCode
	 * 작성일     : 2021. 1. 21.
	 * 작성자     : daekk
	 * 설명       :
	 * </pre>
	 * @param code
	 */
	public void setCode(int code)
	{
		this.code = code;
	}

	/**
	 * <pre>
	 * 메소드명   : getMsg
	 * 작성일     : 2021. 1. 21.
	 * 작성자     : daekk
	 * 설명       :
	 * </pre>
	 * @return 
	 */
	public String getMsg()
	{
		return msg;
	}

	/**
	 * <pre>
	 * 메소드명   : setMsg
	 * 작성일     : 2021. 1. 21.
	 * 작성자     : daekk
	 * 설명       :
	 * </pre>
	 * @param msg
	 */
	public void setMsg(String msg)
	{
		this.msg = msg;
	}

	/**
	 * <pre>
	 * 메소드명   : getData
	 * 작성일     : 2021. 1. 21.
	 * 작성자     : daekk
	 * 설명       :
	 * </pre>
	 * @return 
	 */
	public T getData()
	{
		return data;
	}

	/**
	 * <pre>
	 * 메소드명   : setData
	 * 작성일     : 2021. 1. 21.
	 * 작성자     : daekk
	 * 설명       :
	 * </pre>
	 * @param data
	 */
	public void setData(T data)
	{
		this.data = data;
	}
	
	/**
	 * <pre>
	 * 메소드명   : setResponse
	 * 작성일     : 2021. 1. 21.
	 * 작성자     : daekk
	 * 설명       : 결과 입력
	 * </pre>
	 * @param code 결과 코드
	 * @param msg  결과 메시지
	 */
	public void setResponse(int code, String msg)
	{
		setResponse(code, msg, null);
	}
	
	/**
	 * <pre>
	 * 메소드명   : setResponse
	 * 작성일     : 2021. 1. 21.
	 * 작성자     : daekk
	 * 설명       : 결과 입력
	 * </pre>
	 * @param code 결과 코드
	 * @param msg  결과 메시지
	 * @param data 데이터
	 */
	public void setResponse(int code, String msg, T data)
	{
		this.code = code;
		this.msg = msg;
		this.data = data;
	}
}
