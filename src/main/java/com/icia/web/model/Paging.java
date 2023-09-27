/**
 * <pre>
 * 프로젝트명 : BasicBoard
 * 패키지명   : com.icia.web.model
 * 파일명     : Paging.java
 * 작성일     : 2021. 1. 5.
 * 작성자     : daekk
 * </pre>
 */
package com.icia.web.model;

import java.io.Serializable;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

import com.icia.common.util.StringUtil;

/**
 * <pre>
 * 패키지명   : com.icia.web.model
 * 파일명     : Paging.java
 * 작성일     : 2021. 1. 5.
 * 작성자     : daekk
 * 설명       : 페이징
 * </pre>
 */
public class Paging implements Serializable
{
	private static final long serialVersionUID = -6316602959627374690L;
	
	private String url;         // url
	private String formName;    // 폼 이름
	private long totalCount;    // 총 게시물 수
	private long totalPage;      // 총 페이지 수
	private long startRow;      // 게시물 시작 ROW (ORACLE ROWNUM)
	private long endRow;        // 게시물 끝 ROW (ORACLE ROWNUM)
	private long listCount;      // 한 페이지의 게시물 수
	private long pageCount;      // 페이징 범위 수
	private long curPage;        // 현재 페이지
	
	private long startPage;      // 시작 페이지 번호
	private long endPage;        // 종료 페이지 번호
	
	private long firstPage;      // 첫 번째 페이지 번호
	private long lastPage;       // 마지막 페이지 번호
	
	private long totalBlock;     // 총 블럭 수
	private long curBlock;       // 현재 블럭
	
	private long prevBlockPage;  // 이전 블럭 페이지
	private long nextBlockPage;  // 다음 블럭 페이지
	
	private long startNum;      // 시작 번호 (게시물 번호 적용 DESC)
	
	private String pageTagName; // 페이지번호 태그명
	
	private String scriptFuncName;      // 함수명
	
	private Map<String, Object> param; // 파라미터 맵
	
	/**
	 * 생성자 
	 * 
	 * @param url         이동 url 
	 * @param totalCount  총 게시물 수
	 * @param listCount   한 페이지의 게시물 수
	 * @param pageCount   페이징 범위 수
	 * @param curPage     현재 페이지
	 * @param pageTagName 페이지번호 태그명
	 */
	public Paging(String url, long totalCount, long listCount, long pageCount, long curPage, String pageTagName)
	{
		this(url, null, totalCount, listCount, pageCount, curPage, pageTagName);
	}

	/**
	 * 생성자
	 * 
	 * @param url
	 * @param formName
	 * @param totalCount
	 * @param listCount
	 * @param pageCount
	 * @param curPage
	 * @param pageTagName
	 */
	public Paging(String url, String formName, long totalCount, long listCount, long pageCount, long curPage, String pageTagName)
	{
		this.url = url;
		this.formName = (StringUtil.isEmpty(formName) ? StringUtil.uniqueValue() : formName);
		this.totalCount = totalCount;
		this.listCount = listCount;
		this.pageCount = pageCount;
		this.curPage = curPage;
		this.pageTagName = pageTagName;
		
		param = new HashMap<String, Object>();
		
		if(totalCount > 0)
		{
			pagingProc();
		}
		
		scriptFuncName = "fn_paging_" + formName;
	}

	/**
	 * <pre>
	 * 메소드명   : getUrl
	 * 작성일     : 2021. 1. 7.
	 * 작성자     : daekk
	 * 설명       : 이동 URL을 얻는다.
	 * </pre>
	 * @return 
	 */
	public String getUrl()
	{
		return url;
	}

	/**
	 * <pre>
	 * 메소드명   : getFormName
	 * 작성일     : 2021. 1. 7.
	 * 작성자     : daekk
	 * 설명       : 폼 이름을 얻는다.
	 * </pre>
	 * @return String
	 */
	public String getFormName()
	{
		return formName;
	}

	/**
	 * <pre>
	 * 메소드명   : getTotalCount
	 * 작성일     : 2021. 1. 7.
	 * 작성자     : daekk
	 * 설명       : 총 게시물 수를 얻는다.
	 * </pre>
	 * @return long
	 */
	public long getTotalCount()
	{
		return totalCount;
	}

	/**
	 * <pre>
	 * 메소드명   : getTotalPage
	 * 작성일     : 2021. 1. 7.
	 * 작성자     : daekk
	 * 설명       : 총 페이지 수를 얻는다.
	 * </pre>
	 * @return long
	 */
	public long getTotalPage()
	{
		return totalPage;
	}

	/**
	 * <pre>
	 * 메소드명   : getStartRow
	 * 작성일     : 2021. 1. 7.
	 * 작성자     : daekk
	 * 설명       : 시작 ROWNUM 번호를 얻는다. (ORACLE ROWNUM)
	 * </pre>
	 * @return long
	 */
	public long getStartRow()
	{
		return startRow;
	}

	/**
	 * <pre>
	 * 메소드명   : getEndRow
	 * 작성일     : 2021. 1. 7.
	 * 작성자     : daekk
	 * 설명       : 끝 ROWNUM 번호를 얻는다. (ORACLE ROWNUM)
	 * </pre>
	 * @return long
	 */
	public long getEndRow()
	{
		return endRow;
	}

	/**
	 * <pre>
	 * 메소드명   : getListCount
	 * 작성일     : 2021. 1. 7.
	 * 작성자     : daekk
	 * 설명       : 한 페이지에 노출될 게시물 수를 얻는다.
	 * </pre>
	 * @return long
	 */
	public long getListCount()
	{
		return listCount;
	}

	/**
	 * <pre>
	 * 메소드명   : getPageCount
	 * 작성일     : 2021. 1. 7.
	 * 작성자     : daekk
	 * 설명       : 페이징 블럭에 표시될 최대 페이징 수를 얻는다.
	 * </pre>
	 * @return long
	 */
	public long getPageCount()
	{
		return pageCount;
	}

	/**
	 * <pre>
	 * 메소드명   : getCurPage
	 * 작성일     : 2021. 1. 7.
	 * 작성자     : daekk
	 * 설명       : 현재 페이지 번호를 얻는다.
	 * </pre>
	 * @return long
	 */
	public long getCurPage()
	{
		return curPage;
	}

	/**
	 * <pre>
	 * 메소드명   : getStartPage
	 * 작성일     : 2021. 1. 7.
	 * 작성자     : daekk
	 * 설명       : 화면에 표시될 페이지 시작 값을 얻는다.
	 * </pre>
	 * @return long
	 */
	public long getStartPage()
	{
		return startPage;
	}

	/**
	 * <pre>
	 * 메소드명   : getEndPage
	 * 작성일     : 2021. 1. 7.
	 * 작성자     : daekk
	 * 설명       : 화면에 표시될 페이지 끝 값을 얻는다.
	 * </pre>
	 * @return long
	 */
	public long getEndPage()
	{
		return endPage;
	}

	/**
	 * <pre>
	 * 메소드명   : getFirstPage
	 * 작성일     : 2021. 1. 7.
	 * 작성자     : daekk
	 * 설명       : 제일 첫 페이지 번호를 얻는다.
	 * </pre>
	 * @return long
	 */
	public long getFirstPage()
	{
		return firstPage;
	}

	/**
	 * <pre>
	 * 메소드명   : getLastPage
	 * 작성일     : 2021. 1. 7.
	 * 작성자     : daekk
	 * 설명       : 마지막 페이지 번호를 얻는다.
	 * </pre>
	 * @return long
	 */
	public long getLastPage()
	{
		return lastPage;
	}

	/**
	 * <pre>
	 * 메소드명   : getTotalBlock
	 * 작성일     : 2021. 1. 7.
	 * 작성자     : daekk
	 * 설명       : 총 페이징 불럭 수를 얻는다.
	 * </pre>
	 * @return long
	 */
	public long getTotalBlock()
	{
		return totalBlock;
	}

	/**
	 * <pre>
	 * 메소드명   : getCurBlock
	 * 작성일     : 2021. 1. 7.
	 * 작성자     : daekk
	 * 설명       : 현재 페이징 블럭을 얻는다.
	 * </pre>
	 * @return long
	 */
	public long getCurBlock()
	{
		return curBlock;
	}

	/**
	 * <pre>
	 * 메소드명   : getPrevBlockPage
	 * 작성일     : 2021. 1. 7.
	 * 작성자     : daekk
	 * 설명       : 이전 페이징 블럭의 끝 페이지 번호를 얻는다.
	 * </pre>
	 * @return long
	 */
	public long getPrevBlockPage()
	{
		return prevBlockPage;
	}

	/**
	 * <pre>
	 * 메소드명   : getNextBlockPage
	 * 작성일     : 2021. 1. 7.
	 * 작성자     : daekk
	 * 설명       : 다음 페이징 블럭의 시작 페이지 번호를 얻는다.
	 * </pre>
	 * @return long
	 */
	public long getNextBlockPage()
	{
		return nextBlockPage;
	}

	/**
	 * <pre>
	 * 메소드명   : getStartNum
	 * 작성일     : 2021. 1. 7.
	 * 작성자     : daekk
	 * 설명       : 화면에 표시될 게시물 번호를 얻는다. (DESC)
	 * </pre>
	 * @return long
	 */
	public long getStartNum()
	{
		return startNum;
	}

	/**
	 * <pre>
	 * 메소드명   : getPageTagName
	 * 작성일     : 2021. 1. 7.
	 * 작성자     : daekk
	 * 설명       : 페이지 번호의 태그명을 얻는다.
	 * </pre>
	 * @return String
	 */
	public String getPageTagName()
	{
		return pageTagName;
	}

	/**
	 * <pre>
	 * 메소드명   : getParam
	 * 작성일     : 2021. 1. 6.
	 * 작성자     : daekk
	 * 설명       : 파라미터 값을 얻는다.
	 * </pre>
	 * @return java.util.Map<String, Object>
	 */
	public Map<String, Object> getParam()
	{
		return param;
	}

	/**
	 * <pre>
	 * 메소드명   : setParam
	 * 작성일     : 2021. 1. 6.
	 * 작성자     : daekk
	 * 설명       : 파라미터를 입력한다.
	 * </pre>
	 * @param param java.util.Map<String, Object>
	 */
	public void setParam(Map<String, Object> param)
	{
		if(this.param.size() > 0)
		{
			this.param.clear();
		}
		
		if(param != null && param.size() > 0)
		{
			this.param.putAll(param);
		}
	}
	
	/**
	 * <pre>
	 * 메소드명   : addParam
	 * 작성일     : 2021. 1. 7.
	 * 작성자     : daekk
	 * 설명       : 파라미터를 추가한다.
	 * </pre>
	 * @param name  파라미터 명
	 * @param value 파라미터 값
	 */
	public void addParam(String name, Object value)
	{
		if(!StringUtil.isEmpty(name))
		{
			if(param.containsKey(name))
			{
				removeParam(name);
			}
			
			param.put(name, value);
		}
	}
	
	/**
	 * <pre>
	 * 메소드명   : removeParam
	 * 작성일     : 2021. 1. 7.
	 * 작성자     : daekk
	 * 설명       : name과 일치하는 파라미터를 삭제한다.
	 * </pre>
	 * @param name 파라미터명
	 */
	public void removeParam(String name)
	{
		if(!StringUtil.isEmpty(name) && param.size() > 0)
		{
			if(param.containsKey(name))
			{
				param.remove(name);
			}
		}
	}
	
	/**
	 * <pre>
	 * 메소드명   : clearParam
	 * 작성일     : 2021. 1. 7.
	 * 작성자     : daekk
	 * 설명       : 파라미터를 전부 삭제한다.
	 * </pre>
	 */
	public void clearParam()
	{
		if(param.size() > 0)
		{
			param.clear();
		}
	}
	
	/**
	 * <pre>
	 * 메소드명   : getFormStrng
	 * 작성일     : 2021. 1. 7.
	 * 작성자     : daekk
	 * 설명       : 폼 구성 문자열을 얻는다.
	 * </pre>
	 * @return String
	 */
	public String getFormStrng()
	{
		StringBuilder sbForm = new StringBuilder();
		
		if(!StringUtil.isEmpty(url) && !StringUtil.isEmpty(formName) && totalCount > 0)
		{
			sbForm.append("<form name=\""+formName+"\" id=\""+formName+"\" method=\"post\" action=\""+url+"\">\n");
			
			if(param != null && param.size() > 0)
			{
				Iterator<String> iterator = param.keySet().iterator();
				while(iterator.hasNext())
				{
					String key = iterator.next();
					String value = "";
					Object _value = param.get(key);
					
					if(_value != null)
					{
						value = _value.toString();
					}
					
					sbForm.append("<input type=\"hidden\" name=\""+key+"\" value=\""+value+"\" />\n");
				}
				
				if(!StringUtil.isEmpty(pageTagName))
				{
					 if(!param.containsKey(pageTagName))
					 {
						 sbForm.append("<input type=\"hidden\" name=\""+pageTagName+"\" value=\""+curPage+"\" />\n");
					 }
				}
			}
			else
			{
				if(!StringUtil.isEmpty(pageTagName))
				{
					sbForm.append("<input type=\"hidden\" name=\""+pageTagName+"\" value=\""+curPage+"\" />\n");
				}
			}
			
			sbForm.append("</form>");
		}
		
		return sbForm.toString();
	}
	
	/**
	 * <pre>
	 * 메소드명   : getScriptFuncString
	 * 작성일     : 2021. 1. 21.
	 * 작성자     : daekk
	 * 설명       : 페이징 자바스크립트를 얻는다.
	 * </pre>
	 * @return String
	 */
	public String getScriptFuncString()
	{
		StringBuilder sbScript = new StringBuilder();
		
		if(!StringUtil.isEmpty(url) && !StringUtil.isEmpty(formName) && totalCount > 0)
		{
			// fnCall
			
			sbScript.append("function " + scriptFuncName + "(curPage)\n"); 
			sbScript.append("{\n");
			sbScript.append("    document."+formName+"."+pageTagName+".value = curPage;\n");
			sbScript.append("    document."+formName+".action = \""+url+"\";\n");
			sbScript.append("    document."+formName+".submit();\n");
			sbScript.append("}");
		}
		
		return sbScript.toString();
	}
	
	/**
	 * <pre>
	 * 메소드명   : getPagingString
	 * 작성일     : 2021. 1. 21.
	 * 작성자     : daekk
	 * 설명       : 페이징 문자열을 얻는다.
	 * </pre>
	 * @return String
	 */
	public String getPagingString()
	{
		StringBuilder sbPaging = new StringBuilder();
		
		if(!StringUtil.isEmpty(url) && !StringUtil.isEmpty(formName) && totalCount > 0)
		{
			if(prevBlockPage > 0)
			{
				sbPaging.append("<li class=\"page-item\"><a class=\"page-link\" href=\"javascript:void(0)\" onclick=\""+scriptFuncName+"("+prevBlockPage+")\">이전블럭</a></li>\n");
			}
			
			for(long i=startPage; i<=endPage; i++)
			{
				if(curPage != i)
				{
					// 현재 페이지와 같지 않다면
					sbPaging.append("<li class=\"page-item\"><a class=\"page-link\" href=\"javascript:void(0)\" onclick=\""+scriptFuncName+"("+i+")\">"+i+"</a></li>\n");
				}
				else
				{
					// 현제 페이지와 같다면
					sbPaging.append("<li class=\"page-item active\"><a class=\"page-link\" href=\"javascript:void(0)\" style=\"cursor:default;\">"+i+"</a></li>\n");
				}
			}
			
			if(nextBlockPage > 0)
			{
				sbPaging.append("<li class=\"page-item\"><a class=\"page-link\" href=\"javascript:void(0)\" onclick=\""+scriptFuncName+"("+nextBlockPage+")\">다음블럭</a></li>\n");
			}
		}
		
		return sbPaging.toString();
	}
	
	/**
	 * <pre>
	 * 메소드명   : pagingProc
	 * 작성일     : 2021. 1. 7.
	 * 작성자     : daekk
	 * 설명       : 페이징 계산 프로세스
	 * </pre>
	 */
	private void pagingProc()
	{
		// 총 페이지 수를 구한다.
		totalPage = (long)Math.ceil((double)totalCount / listCount);
		// 총 블럭 수를 구한다.
		totalBlock = (long)Math.ceil((double)totalPage / pageCount);
		// 현재 블럭을 구한다.		
		curBlock = (long)Math.ceil((double)curPage / pageCount);
		
		// 시작 페이지 
		startPage = ((curBlock - 1) * pageCount) + 1;
		// 끝 페이지
		endPage = (startPage + pageCount) - 1; 
		
		// 마지막 페이지 보정
		// 총 페이지 보다 끝 페이지가 크다면 총 페이지를 마지막 페이지로 변환한다. 
		if (endPage > totalPage) 
		{
			endPage = totalPage;
		}
		
		// 시작 ROWNUM (ORACLE ROWNUM)
		startRow = ( ( ( curPage - 1 ) * listCount ) + 1 );
		// 끝 ROWNUM (ORACLE ROWNUM)
		endRow = ( ( startRow + listCount ) - 1 );
		
		// 게시물 시작 번호
		startNum = ( totalCount - ( ( curPage - 1 ) * listCount ) );
		
		// 이전 블럭 페이지 번호
		if(curBlock > 1)
		{
			prevBlockPage = ( startPage - 1 );
		}
		
		// 이전 블럭 페이지 번호
		if(curBlock > 1)
		{
			prevBlockPage = ( startPage - 1 );
		}
		
		// 다음 블럭 페이지 번호
		if(curBlock < totalBlock)
		{
			nextBlockPage = endPage + 1;
		}
	}
}
