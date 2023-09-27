/**
 * <pre>
 * 프로젝트명 : common
 * 패키지명   : com.icia.common.util
 * 파일명     : StringUtil.java
 * 작성일     : 2020. 12. 29.
 * 작성자     : daekk
 * </pre>
 */
package com.icia.common.util;

import java.io.UnsupportedEncodingException;
import java.math.BigDecimal;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
import java.util.UUID;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * <pre>
 * 패키지명   : com.icia.common.util
 * 파일명     : StringUtil.java
 * 작성일     : 2020. 12. 29.
 * 작성자     : daekk
 * 설명       : 문자열 관련 유틸리티
 * </pre>
 */
public final class StringUtil
{
	private StringUtil() {}

	/**
	 * <pre>
	 * 메소드명   : nvl
	 * 작성일     : 2020. 12. 29.
	 * 작성자     : daekk
	 * 설명       : 문자열이 null이면 공백 문자열로 변환
	 * </pre>
	 * @param str 문자열
	 * @return String
	 */
	public static String nvl(String str)
	{
		return nvl(str, "");
	}

	/**
	 * <pre>
	 * 메소드명   : nvl
	 * 작성일     : 2020. 12. 29.
	 * 작성자     : daekk
	 * 설명       : 문자열이 null이거나 비어있으면 기본값 적용
	 * </pre>
	 * @param str 문자열
	 * @param def 기본값
	 * @return String
	 */
	public static String nvl(String str, String def)
	{
		if (str != null && str.length() > 0)
		{
			return str;
		}
		else
		{
			return def;
		}
	}

	/**
	 * <pre>
	 * 메소드명   : isNull
	 * 작성일     : 2020. 12. 29.
	 * 작성자     : daekk
	 * 설명       : null 체크
	 * </pre>
	 * @param str 문자열
	 * @return boolean
	 */
	public static boolean isNull(String str)
	{
		return isNull((Object) str);
	}

	/**
	 * <pre>
	 * 메소드명   : isNull
	 * 작성일     : 2020. 12. 29.
	 * 작성자     : daekk
	 * 설명       : null 체크
	 * </pre>
	 * @param obj 객체
	 * @return boolean
	 */
	public static boolean isNull(Object obj)
	{
		if (obj != null)
		{
			return false;
		}
		else
		{
			return true;
		}
	}

	/**
	 * <pre>
	 * 메소드명   : isEmpty
	 * 작성일     : 2020. 12. 29.
	 * 작성자     : daekk
	 * 설명       : 문자열이 null이거나 비어있는지 체크
	 * </pre>
	 * @param str 문자열
	 * @return boolean
	 */
	public static boolean isEmpty(String str)
	{
		if (nvl(str).length() > 0)
		{
			return false;
		}
		else
		{
			return true;
		}
	}

	/**
	 * <pre>
	 * 메소드명   : isEmpty
	 * 작성일     : 2020. 12. 29.
	 * 작성자     : daekk
	 * 설명       : object null 인지 체크
	 * </pre>
	 * @param obj Object
	 * @return boolean
	 */
	public static boolean isEmpty(Object obj)
	{
		return (obj == null);
	}

	/**
	 * <pre>
	 * 메소드명   : isEmpty
	 * 작성일     : 2020. 12. 29.
	 * 작성자     : daekk
	 * 설명       : object 배열이 null 이거나 비어있는지 체크
	 * </pre>
	 * @param array Object[]
	 * @return boolean
	 */
	public static boolean isEmpty(Object[] array)
	{
		return ((array == null) || (array.length == 0));
	}

	/**
	 * <pre>
	 * 메소드명   : isNumeric
	 * 작성일     : 2020. 12. 29.
	 * 작성자     : daekk
	 * 설명       : 문자열 숫자인지 체크(음수, 양수, 부동소수도 체크)
	 * </pre>
	 * @param str 문자열
	 * @return boolean
	 */
	public static boolean isNumeric(String str)
	{
		if (isEmpty(str))
		{
			return false;
		}

		if (str.matches("^[-+]?\\d+(\\.\\d+)?$"))
		{
			return true;
		}
		else
		{
			try
			{
				Double.parseDouble(str);

				return true;
			}
			catch (NumberFormatException e)
			{
				try
				{
					new BigDecimal(str);

					return true;
				}
				catch (NumberFormatException e1)
				{
					return false;
				}
			}
		}
	}
	
	/**
	 * <pre>
	 * 메소드명   : isNumber
	 * 작성일     : 2020. 12. 29.
	 * 작성자     : daekk
	 * 설명       : 문자열이 숫자로 구성되어 있는지 체크
	 * </pre>
	 * @param str 문자열
	 * @return boolean
	 */
	public static boolean isNumber(String str) 
	{
	    if (isEmpty(str)) 
	    {
	        return false;
	    }
	    
	    int len = str.length();
	    
	    for (int i=0; i<len; i++) 
	    {
	        if (Character.isDigit(str.charAt(i)) == false) 
	        {
	            return false;
	        }
	    }
	    
	    return true;
	}

	/**
	 * <pre>
	 * 메소드명   : stringToShort
	 * 작성일     : 2020. 12. 29.
	 * 작성자     : daekk
	 * 설명       : 문자열을 short형으로 변경한다.
	 * </pre>
	 * @param str 문자열
	 * @param defVal 기본값
	 * @return short
	 */
	public static short stringToShort(String str, final short defVal)
	{
		short value = 0;

		if (StringUtil.isEmpty(str))
		{
			value = defVal;
		}
		else
		{
			try
			{
				value = Short.parseShort(str);
			}
			catch (NumberFormatException e)
			{
				return defVal;
			}
		}

		return value;
	}
	
	/**
	 * <pre>
	 * 메소드명   : isShort
	 * 작성일     : 2020. 12. 29.
	 * 작성자     : daekk
	 * 설명       : 문자열이 Short 형으로 변환 되는지 체크
	 * </pre>
	 * @param str 문자열
	 * @return boolean
	 */
	public static boolean isShort(String str)
	{
		if (StringUtil.isEmpty(str))
		{
			return false;
		}
		
		try
		{
			Short.parseShort(str);
		}
		catch (NumberFormatException e)
		{
			return false;
		}
		
		return true;
	}

	/**
	 * <pre>
	 * 메소드명   : stringToInteger
	 * 작성일     : 2020. 12. 29.
	 * 작성자     : daekk
	 * 설명       : 문자열을 int형으로 변경한다.
	 * </pre>
	 * @param str 문자열
	 * @param defVal 기본값
	 * @return int
	 */
	public static int stringToInteger(String str, final int defVal)
	{
		int value = 0;

		if (StringUtil.isEmpty(str))
		{
			value = defVal;
		}
		else
		{
			try
			{
				value = Integer.parseInt(str);
			}
			catch (NumberFormatException e)
			{
				return defVal;
			}
		}

		return value;
	}
	
	/**
	 * <pre>
	 * 메소드명   : isInteger
	 * 작성일     : 2020. 12. 29.
	 * 작성자     : daekk
	 * 설명       : 문자열이 Integer 형으로 변환 되는지 체크
	 * </pre>
	 * @param str 문자열
	 * @return boolean
	 */
	public static boolean isInteger(String str)
	{
		if (StringUtil.isEmpty(str))
		{
			return false;
		}
		
		try
		{
			Integer.parseInt(str);
		}
		catch (NumberFormatException e)
		{
			return false;
		}
		
		return true;
	}

	/**
	 * <pre>
	 * 메소드명   : stringToLong
	 * 작성일     : 2020. 12. 29.
	 * 작성자     : daekk
	 * 설명       : 문자열을 long형으로 변경한다.
	 * </pre>
	 * @param str 문자열
	 * @param defVal 기본값
	 * @return long
	 */
	public static long stringToLong(String str, final long defVal)
	{
		long value = 0;

		if (StringUtil.isEmpty(str))
		{
			value = defVal;
		}
		else
		{
			try
			{
				value = Long.parseLong(str);
			}
			catch (NumberFormatException e)
			{
				return defVal;
			}
		}

		return value;
	}
	
	/**
	 * <pre>
	 * 메소드명   : isLong
	 * 작성일     : 2020. 12. 29.
	 * 작성자     : daekk
	 * 설명       : 문자열이 Long 형으로 변환 되는지 체크
	 * </pre>
	 * @param str 문자열
	 * @return boolean
	 */
	public static boolean isLong(String str)
	{
		if (StringUtil.isEmpty(str))
		{
			return false;
		}
		
		try
		{
			Long.parseLong(str);
		}
		catch (NumberFormatException e)
		{
			return false;
		}
		
		return true;
	}

	/**
	 * <pre>
	 * 메소드명   : stringToFloat
	 * 작성일     : 2020. 12. 29.
	 * 작성자     : daekk
	 * 설명       : 문자열을 float형으로 변경한다.
	 * </pre>
	 * @param str 문자열
	 * @param defVal 기본값
	 * @return float
	 */
	public static float stringToFloat(String str, final float defVal)
	{
		float value = 0;

		if (StringUtil.isEmpty(str))
		{
			value = defVal;
		}
		else
		{
			try
			{
				value = Float.parseFloat(str);
			}
			catch (NumberFormatException e)
			{
				return defVal;
			}
		}

		return value;
	}
	
	/**
	 * <pre>
	 * 메소드명   : isFloat
	 * 작성일     : 2020. 12. 29.
	 * 작성자     : daekk
	 * 설명       : 문자열이 Float 형으로 변환 되는지 체크
	 * </pre>
	 * @param str 문자열
	 * @return boolean
	 */
	public static boolean isFloat(String str)
	{
		if (StringUtil.isEmpty(str))
		{
			return false;
		}
		
		try
		{
			Float.parseFloat(str);
		}
		catch (NumberFormatException e)
		{
			return false;
		}
		
		return true;
	}

	/**
	 * <pre>
	 * 메소드명   : stringToDouble
	 * 작성일     : 2020. 12. 29.
	 * 작성자     : daekk
	 * 설명       : 문자열을 double형으로 변경한다.
	 * </pre>
	 * @param str 문자열
	 * @param defVal 기본값
	 * @return double
	 */
	public static double stringToDouble(String str, final double defVal)
	{
		double value = 0;

		if (StringUtil.isEmpty(str))
		{
			value = defVal;
		}
		else
		{
			try
			{
				value = Double.parseDouble(str);
			}
			catch (NumberFormatException e)
			{
				return defVal;
			}
		}

		return value;
	}
	
	/**
	 * <pre>
	 * 메소드명   : isDouble
	 * 작성일     : 2020. 12. 29.
	 * 작성자     : daekk
	 * 설명       : 문자열이 Double 형으로 변환 되는지 체크
	 * </pre>
	 * @param str 문자열
	 * @return boolean
	 */
	public static boolean isDouble(String str)
	{
		if (StringUtil.isEmpty(str))
		{
			return false;
		}
		
		try
		{
			Double.parseDouble(str);
		}
		catch (NumberFormatException e)
		{
			return false;
		}
		
		return true;
	}

	/**
	 * <pre>
	 * 메소드명   : equals
	 * 작성일     : 2020. 12. 29.
	 * 작성자     : daekk
	 * 설명       : 문자열을 비교한다.
	 * </pre>
	 * @param strTarget 문자열
	 * @param strCompare 비교문자열
	 * @return boolean
	 */
	public static boolean equals(String strTarget, String strCompare)
	{
		if (strTarget != null && strCompare != null)
		{
			return strTarget.equals(strCompare);
		}

		return false;
	}

	/**
	 * <pre>
	 * 메소드명   : equalsIgnoreCase
	 * 작성일     : 2020. 12. 29.
	 * 작성자     : daekk
	 * 설명       : 문자열을 비교한다. (대소문자 구분안함)
	 * </pre>
	 * @param strTarget 문자열
	 * @param strCompare 비교문자열
	 * @return boolean
	 */
	public static boolean equalsIgnoreCase(String strTarget, String strCompare)
	{
		if (strTarget != null && strCompare != null)
		{
			return strTarget.equalsIgnoreCase(strCompare);
		}

		return false;
	}

	/**
	 * <pre>
	 * 메소드명   : isRegexPatternMatch
	 * 작성일     : 2020. 12. 29.
	 * 작성자     : daekk
	 * 설명       : 정규식 패턴 검사
	 * </pre>
	 * @param str 문자열
	 * @param pattern 패턴 문자열
	 * @return boolean
	 */
	public static boolean isRegexPatternMatch(String str, String pattern)
	{
		Pattern p = Pattern.compile(pattern);
		Matcher m = p.matcher(str);

		return m.matches();
	}

	/**
	 * <pre>
	 * 메소드명   : rightPad
	 * 작성일     : 2020. 12. 29.
	 * 작성자     : daekk
	 * 설명       : 문자열 길이가 len보다 작다면 우측에 (문자열 길이 - len) padStr을 붙인다.
	 * </pre>
	 * @param str 문자열
	 * @param len 길이
	 * @param padStr 붙일문자열
	 * @return String
	 */
	public static String rightPad(String str, int size, String padStr)
	{
		return padString(str, size, padStr, false);
	}

	/**
	 * <pre>
	 * 메소드명   : leftPad
	 * 작성일     : 2020. 12. 29.
	 * 작성자     : daekk
	 * 설명       : 문자열 길이가 len보다 작다면 좌측에 (문자열 길이 - len) padStr을 붙인다.
	 * </pre>
	 * @param str 문자열
	 * @param len 길이
	 * @param padStr 붙일문자열
	 * @return String
	 */
	public static String leftPad(String str, int len, String padStr)
	{
		return padString(str, len, padStr, true);
	}

	/**
	 * <pre>
	 * 메소드명   : padString
	 * 작성일     : 2020. 12. 29.
	 * 작성자     : daekk
	 * 설명       : 문자열 길이가 len보다 작다면 좌측 또는 우측에 (문자열 길이 - len) padStr을 붙인다.
	 * </pre>
	 * @param str    문자열
	 * @param len    길이
	 * @param padStr 붙일 문자열
	 * @param isLeft 좌측 우측 구분 (true:좌측, false:우측)
	 * @return String
	 */
	private static String padString(String str, int len, String padStr, boolean isLeft)
	{
		if (str == null)
		{
			return null;
		}

		int originalStrLength = str.length();

		if (len < originalStrLength)
		{
			return str;
		}

		int difference = len - originalStrLength;

		String tempPad = "";

		if (difference > 0)
		{
			if (padStr == null || "".equals(padStr))
			{
				padStr = " ";
			}

			do
			{
				for (int j = 0; j < padStr.length(); j++)
				{
					tempPad += padStr.charAt(j);
					if (str.length() + tempPad.length() >= len)
					{
						break;
					}
				}
			} while (difference > tempPad.length());

			if (isLeft)
			{
				str = tempPad + str;
			}
			else
			{
				str = str + tempPad;
			}
		}

		return str;
	}

	/**
	 * <pre>
	 * 메소드명   : trim
	 * 작성일     : 2016. 11. 24.
	 * 작성자     : daekk
	 * 설명       : 문자열 좌측,우측 공백 제거
	 * </pre>
	 * @param str 문자열
	 * @return String
	 */
	public static String trim(String str)
	{
		if (!isNull(str))
		{
			return str.trim();
		}
		else
		{
			return str;
		}
	}

	/**
	 * 
	 * <pre>
	 * 메소드명   : leftTrim
	 * 작성일     : 2016. 11. 24.
	 * 작성자     : daekk
	 * 설명       : 좌측 공백 제거
	 * </pre>
	 * @param str 문자열
	 * @return String
	 */
	public static String leftTrim(String str)
	{
		if (isNull(str))
		{
			return str;
		}
		else
		{
			StringBuilder sb = new StringBuilder(str);

			while (sb.length() > 0 && Character.isWhitespace(sb.charAt(0)))
			{
				sb.deleteCharAt(0);
			}

			return sb.toString();
		}
	}

	/**
	 * <pre>
	 * 메소드명   : rightTrim
	 * 작성일     : 2016. 11. 24.
	 * 작성자     : daekk
	 * 설명       : 우측 공백 제거
	 * </pre>
	 * @param str 문자열
	 * @return String
	 */
	public static String rightTrim(String str)
	{
		if (isNull(str))
		{
			return str;
		}
		else
		{
			StringBuilder sb = new StringBuilder(str);

			while (sb.length() > 0 && Character.isWhitespace(sb.charAt(sb.length() - 1)))
			{
				sb.deleteCharAt(sb.length() - 1);
			}

			return sb.toString();
		}
	}

	/**
	 * <pre>
	 * 메소드명   : left
	 * 작성일     : 2016. 11. 24.
	 * 작성자     : daekk
	 * 설명       : 좌측에서 len 만큼 자른다.
	 * </pre>
	 * @param str 문자열
	 * @param len 길이
	 * @return String
	 */
	public static String left(String str, int len)
	{
		if (isNull(str))
		{
			return null;
		}
		else if (len <= 0 || str.length() <= len)
		{
			return str;
		}
		else
		{
			return str.substring(0, len);
		}
	}

	/**
	 * <pre>
	 * 메소드명   : right
	 * 작성일     : 2016. 11. 24.
	 * 작성자     : daekk
	 * 설명       : 우측에서 len 만큼 자른다.
	 * </pre>
	 * @param str 문자열
	 * @param len 길이
	 * @return String
	 */
	public static String right(String str, int len)
	{
		if (isNull(str))
		{
			return null;
		}
		else if (len <= 0 || str.length() <= len)
		{
			return str;
		}
		else
		{
			return str.substring(str.length() - len);
		}
	}

	/**
	 * <pre>
	 * 메소드명   : substring
	 * 작성일     : 2016. 11. 24.
	 * 작성자     : daekk
	 * 설명       : 문자열을 좌측 start위치 부터 자른다.
	 * </pre>
	 * @param str 문자열
	 * @param len 길이
	 * @return String
	 */
	public static String substring(String str, int len)
	{
		if (!isEmpty(str) && len <= str.length())
		{
			return substring(str, len, str.length());
		}
		else
		{
			return "";
		}
	}

	/**
	 * <pre>
	 * 메소드명   : substring
	 * 작성일     : 2016. 11. 24.
	 * 작성자     : daekk
	 * 설명       : 문자열을 좌측 start위치 부터 end위치까지 자른다.
	 * </pre>
	 * @param str 문자열
	 * @param start 시작위치
	 * @param end 종료위치
	 * @return String
	 */
	public static String substring(String str, int start, int end)
	{
		if (!isEmpty(str) && start <= str.length() && end <= str.length() && start <= end)
		{
			return str.substring(start, end);
		}
		else
		{
			return "";
		}
	}

	/**
	 * <pre>
	 * 메소드명   : uniqueValue
	 * 작성일     : 2016. 11. 24.
	 * 작성자     : daekk
	 * 설명       : unique 문자열 값을 얻는다.
	 * </pre>
	 * @return String
	 */
	public static String uniqueValue()
	{
		return replace(UUID.randomUUID().toString(), "-", "");
	}

	/**
	 * <pre>
	 * 메소드명   : replace
	 * 작성일     : 2016. 11. 24.
	 * 작성자     : daekk
	 * 설명       : str 문자열에서 oldPattern 문자열을 newPattern 문자열로 변환한다.
	 * </pre>
	 * @param str 문자열
	 * @param oldPattern 검색 문자열
	 * @param newPattern 변경 문자열
	 * @return String
	 */
	public static String replace(String str, String oldPattern, String newPattern)
	{
		if (!isEmpty(str) && !isNull(oldPattern) && !isNull(newPattern))
		{
			StringBuilder sb = new StringBuilder();

			int pos = 0;
			int index = str.indexOf(oldPattern);
			int patLen = oldPattern.length();

			while (index >= 0)
			{
				sb.append(str.substring(pos, index));
				sb.append(newPattern);
				pos = index + patLen;
				index = str.indexOf(oldPattern, pos);
			}

			sb.append(str.substring(pos));

			return sb.toString();
		}
		else
		{
			return str;
		}
	}
	
	/**
	 * <pre>
	 * 메소드명   : crlfClear
	 * 작성일     : 2018. 4. 25.
	 * 작성자     : daekk
	 * 설명       : 개행 문자를 지운다.
	 * </pre>
	 * @param value 문자열
	 * @return String
	 */
	public static String crlfClear(String value)
	{
		return (!isEmpty(value) ? value.replaceAll("(\r\n|\r|\n|\n\r)", " ") : "");
	}

	/**
	 * <pre>
	 * 메소드명   : tokenizeToStringArray
	 * 작성일     : 2016. 11. 24.
	 * 작성자     : daekk
	 * 설명       : 문자열을 delimiter로 구분하여 문자열 배열을 만든다.
	 * </pre>
	 * @param str 문자열
	 * @param delimiters 구분 문자열
	 * @return String[]
	 */
	public static String[] tokenizeToStringArray(String str, String delimiters)
	{
		if (isNull(str))
		{
			return new String[0];
		}

		if (isNull(delimiters))
		{
			return (new String[]{str});
		}

		List<String> result = new ArrayList<String>();
		if ("".equals(delimiters))
		{
			for (int i = 0; i < str.length(); i++)
			{
				result.add(str.substring(i, i + 1));
			}
		}
		else
		{
			int pos = 0;
			int delPos;
			while ((delPos = str.indexOf(delimiters, pos)) != -1)
			{
				result.add(str.substring(pos, delPos));
				pos = delPos + delimiters.length();
			}
			
			if (str.length() > 0 && pos <= str.length())
			{
				result.add(str.substring(pos));
			}
		}
		
		return toStringArray(result);
	}

	/**
	 * <pre>
	 * 메소드명   : toStringArray
	 * 작성일     : 2016. 11. 24.
	 * 작성자     : daekk
	 * 설명       : Collection 값을 문자열 배열로 생성한다.
	 * </pre>
	 * @param collection java.util.Collection<String>
	 * @return String[]
	 */
	public static String[] toStringArray(Collection<String> collection)
	{
		if (collection == null)
		{
			return null;
		}

		return collection.toArray(new String[collection.size()]);
	}
	
	/**
	 * <pre>
	 * 메소드명   : encoding
	 * 작성일     : 2021. 1. 7.
	 * 작성자     : daekk
	 * 설명       : 입력 받은 문자열(str)을 charset으로 인코딩 한다.
	 * </pre>
	 * @param str     문자열
	 * @param charset 캐릭터 셋
	 * @return String
	 */
	public static String encoding(String str, String charset)
	{
		return encoding(str.getBytes(), charset);
	}
	
	/**
	 * <pre>
	 * 메소드명   : encoding
	 * 작성일     : 2021. 1. 7.
	 * 작성자     : daekk
	 * 설명       : 입력 받은 바이트 배열을(bytes)을 charset으로 인코딩 한다.
	 * </pre>
	 * @param bytes 바이트 배열
	 * @param charset 캐릭터셋
	 * @return String
	 */
	public static String encoding(byte[] bytes, String charset)
	{
		try
		{
			return (new String(bytes, charset));
		}
		catch (UnsupportedEncodingException e)
		{
			return null;
		}
	}
	
	/**
	 * <pre>
	 * 메소드명   : toNumberFormat
	 * 작성일     : 2021. 1. 7.
	 * 작성자     : daekk
	 * 설명       : 숫자형(short) 포멧을 얻는다.
	 * </pre>
	 * @param value 값
	 * @return String
	 */
	public static String toNumberFormat(short value)
	{
		return toNumberFormat((long)value, null);
	}
	
	/**
	 * <pre>
	 * 메소드명   : toNumberFormat
	 * 작성일     : 2021. 1. 7.
	 * 작성자     : daekk
	 * 설명       : 숫자형(int) 포멧을 얻는다.
	 * </pre>
	 * @param value 값
	 * @return String
	 */
	public static String toNumberFormat(int value)
	{
		return toNumberFormat((long)value, null);
	}
	
	/**
	 * <pre>
	 * 메소드명   : toNumberFormat
	 * 작성일     : 2021. 1. 7.
	 * 작성자     : daekk
	 * 설명       : 숫자형(long) 포멧을 얻는다.
	 * </pre>
	 * @param value 값
	 * @return String
	 */
	public static String toNumberFormat(long value)
	{
		return toNumberFormat(value, null);
	}
	
	/**
	 * <pre>
	 * 메소드명   : toNumberFormat
	 * 작성일     : 2021. 1. 7.
	 * 작성자     : daekk
	 * 설명       : 숫자형(short) 포멧을 얻는다.
	 * </pre>
	 * @param value   값
	 * @param pattern 패턴
	 * @return String
	 */
	public static String toNumberFormat(short value, String pattern)
	{
		return toNumberFormat((long)value, pattern);
	}
	
	/**
	 * <pre>
	 * 메소드명   : toNumberFormat
	 * 작성일     : 2021. 1. 7.
	 * 작성자     : daekk
	 * 설명       : 숫자형(int) 포멧을 얻는다.
	 * </pre>
	 * @param value   값
	 * @param pattern 패턴
	 * @return String
	 */
	public static String toNumberFormat(int value, String pattern)
	{
		return toNumberFormat((long)value, pattern);
	}
	
	/**
	 * <pre>
	 * 메소드명   : toNumberFormat
	 * 작성일     : 2021. 1. 7.
	 * 작성자     : daekk
	 * 설명       : 숫자형(long) 포멧을 얻는다.
	 * </pre>
	 * @param value   값
	 * @param pattern 패턴
	 * @return String
	 */
	public static String toNumberFormat(long value, String pattern)
	{
		DecimalFormat decimalFormat = null;
		
		if(StringUtil.isEmpty(pattern))
		{
			decimalFormat = new DecimalFormat("#,###"); 
		}
		else
		{
			try
			{
				decimalFormat = new DecimalFormat(pattern); 
			}
			catch(Exception e)
			{
				decimalFormat = new DecimalFormat("#,###"); 
			}
		}
		
		return decimalFormat.format(value);
	}
	
	/**
	 * <pre>
	 * 메소드명   : toNumberFormat
	 * 작성일     : 2021. 1. 7.
	 * 작성자     : daekk
	 * 설명       : 숫자형(float) 포멧을 얻는다.
	 * </pre>
	 * @param value 값
	 * @return String
	 */
	public static String toNumberFormat(float value)
	{
		return toNumberFormat((double)value, null);
	}
	
	/**
	 * <pre>
	 * 메소드명   : toNumberFormat
	 * 작성일     : 2021. 1. 7.
	 * 작성자     : daekk
	 * 설명       : 숫자형(double) 포멧을 얻는다.
	 * </pre>
	 * @param value 값
	 * @return String
	 */
	public static String toNumberFormat(double value)
	{
		return toNumberFormat(value, null);
	}
	
	/**
	 * <pre>
	 * 메소드명   : toNumberFormat
	 * 작성일     : 2021. 1. 7.
	 * 작성자     : daekk
	 * 설명       : 숫자형(double) 포멧을 얻는다.
	 * </pre>
	 * @param value   값
	 * @param pattern 패턴
	 * @return String
	 */
	public static String toNumberFormat(double value, String pattern)
	{
		DecimalFormat decimalFormat = null;
		
		if(StringUtil.isEmpty(pattern))
		{
			decimalFormat = new DecimalFormat("#,##0.0"); 
		}
		else
		{
			try
			{
				decimalFormat = new DecimalFormat(pattern); 
			}
			catch(Exception e)
			{
				decimalFormat = new DecimalFormat("#,##0.0"); 
			}
		}
		
		return decimalFormat.format(value);
	}
	
	/**
	 * <pre>
	 * 메소드명   : typeof
	 * 작성일     : 2023. 07. 21.
	 * 작성자     : LookAtMe
	 * 설명       : 변수의 타입을 확인한다
	 * </pre>
	 * value   값
	 * @return String 각각  타입을 리턴해줌
	 */
	public static String typeof(Object value)
	{
		if(value instanceof String) 
		{
			return "S";
		}
		
		if(value instanceof Integer) 
		{
			return "I";
		}
		
		if(value instanceof Long) 
		{
			return "L";
		}
		
		if(value instanceof Double) 
		{
			return "D";
		}
		
		if(value instanceof Float) 
		{
			return "F";
		}
		
		if(value instanceof Character) 
		{
			return "C";
		}
		return null;
	}	
}
