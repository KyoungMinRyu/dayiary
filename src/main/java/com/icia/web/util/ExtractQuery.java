package com.icia.web.util;

import java.util.List;

import com.icia.common.util.StringUtil;


// SQL QUERY String으로 출력하는 클래스

public class ExtractQuery 
{	
	public String extractQuery(StringBuilder sql, String column)
    {
    	return extractQuery(sql.toString(), column);
    }
	
	public String extractQuery(StringBuilder sql, long column)
    {
    	return extractQuery(sql.toString(), column);
    }
	
	public String extractQuery(StringBuilder sql, int column)
    {
    	return extractQuery(sql.toString(), column);
    }
    
    public String extractQuery(StringBuilder sql, List<Object> list)
    {
    	return extractQuery(sql.toString(), list);
    }
	
	public String extractQuery(String sql, String column) // 들어온 컬럼이 String일 때 
    {
    	if(sql.indexOf("?") != -1) // String클래스에서 indexOf는 특정 문자위치를 찾음 특정문자가 없을 경무 -1을 반환
    	{
	    	String temp1 = "", temp2 = "";
	    	temp1 = sql.substring(0, sql.indexOf("?") + 1).replace("?", "'"  + column + "'");
	    	temp2 = sql.substring(sql.indexOf("?") + 1);
	    	sql = temp1 + temp2;
    		sql += ";";
    		sql = sql.replaceAll("\\s+", " ");
	    	return sql;
    	}
    	else
    	{		
    		sql += ";";
    		sql = sql.replaceAll("\\s+", " ");
    		return sql;
    	}
    }
	
	public String extractQuery(String sql, int column) // 들어온 컬럼이 int일 때 
    {
    	if(sql.indexOf("?") != -1) // String클래스에서 indexOf는 특정 문자위치를 찾음 특정문자가 없을 경무 -1을 반환
    	{
	    	String temp1 = "", temp2 = "";
	    	temp1 = sql.substring(0, sql.indexOf("?") + 1).replace("?", Integer.toString(column));
	    	temp2 = sql.substring(sql.indexOf("?") + 1);
	    	sql = temp1 + temp2;
    		sql += ";";
    		sql = sql.replaceAll("\\s+", " ");
	    	return sql;
    	}
    	else
    	{		
    		sql += ";";
    		sql = sql.replaceAll("\\s+", " ");
    		return sql;
    	}
    }
	
	public String extractQuery(String sql, long column) // 들어온 컬럼이 long일 때 
    {
    	if(sql.indexOf("?") != -1) // String클래스에서 indexOf는 특정 문자위치를 찾음 특정문자가 없을 경무 -1을 반환
    	{
	    	String temp1 = "", temp2 = "";
	    	temp1 = sql.substring(0, sql.indexOf("?") + 1).replace("?", Long.toString(column));
	    	temp2 = sql.substring(sql.indexOf("?") + 1);
	    	sql = temp1 + temp2;
    		sql += ";";
    		sql = sql.replaceAll("\\s+", " ");
	    	return sql;
    	}
    	else
    	{		
    		sql += ";";
    		sql = sql.replaceAll("\\s+", " ");
    		return sql;
    	}
    }

    public String extractQuery(String sql, List<Object> list) // ? 즉 매개변수가 여러개일 경우 List로 데이터를 받음
    {
    	for(int i = 0; i < list.size(); i ++)
    	{
	    	if(sql.indexOf("?") != -1)
	    	{
	    		if(StringUtil.equals("I", StringUtil.typeof(list.get(i)))) // int타입일 때
	    		{
	    			sql = extractQuery(sql, (Integer)list.get(i));
	    		}
	    		else if(StringUtil.equals("L", StringUtil.typeof(list.get(i)))) // Long타입일 때
	    		{
	    			sql = extractQuery(sql, (Long)list.get(i));
	    		}
	    		else if(StringUtil.equals("S", StringUtil.typeof(list.get(i)))) // String타입일 때
	    		{
	    			sql = extractQuery(sql, (String)list.get(i));
	    		}
	    	}
	    	else
	    	{
	    		sql = sql.replaceAll(";", "");
	    		sql = sql.replaceAll("\\s+", " ");
	    		sql += ";";
	    		return sql;
	    	}
    	}
		sql = sql.replaceAll(";", "");
		sql = sql.replaceAll("\\s+", " ");
		
		sql += ";";
    	return sql;
    }
}
