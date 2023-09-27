/**
 * <pre>
 * 프로젝트명 : HiBoard
 * 패키지명   : com.icia.web.view
 * 파일명     : FileDownloadView.java
 * 작성일     : 2021. 1. 22.
 * 작성자     : daekk
 * </pre>
 */
package com.icia.web.view;

import java.io.File;
import java.io.FileInputStream;
import java.io.OutputStream;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.view.AbstractView;

import com.icia.common.util.FileUtil;
import com.icia.common.util.StringUtil;
import com.icia.web.util.HttpUtil;

/**
 * <pre>
 * 패키지명   : com.icia.web.view
 * 파일명     : FileDownloadView.java
 * 작성일     : 2021. 1. 22.
 * 작성자     : daekk
 * 설명       : 파일 다운로드 뷰
 * </pre>
 */
public class FileDownloadView extends AbstractView
{
	private static Logger logger = LoggerFactory.getLogger(FileDownloadView.class);
	
	/* (non-Javadoc)
	 * @see org.springframework.web.servlet.view.AbstractView#renderMergedOutputModel(java.util.Map, javax.servlet.http.HttpServletRequest, javax.servlet.http.HttpServletResponse)
	 */
	@Override
	protected void renderMergedOutputModel(Map<String, Object> model, HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		// TODO Auto-generated method stub
		File file = (File)model.get("file");             // 파일 객체
		String fileName = (String)model.get("fileName"); // 파일명
		FileInputStream inputStream = null;              // 파일을 읽는 스트림
		OutputStream outputStream = null;                // 파일을 쓰는 스트림
		
		// 파일이 존재 하면
		if(FileUtil.isFile(file))
		{
			try
			{
				// 파일명이 없다면 파일 객체의 파일명으로 변경
				if(StringUtil.isEmpty(fileName))
				{
					fileName = file.getName();
				}
				
				// 다운로드 파일명
				String downloadFileName = "";
				String userAgent = HttpUtil.getHeader(request, "User-Agent"); // 브라우저 식별 정보
				
				// 파일 다운로드시 원본 파일명으로 보내준다.
				if(userAgent.indexOf("MSIE") > -1 || userAgent.indexOf("Trident") > -1) // IE 브라우저 체크
				{
					downloadFileName = StringUtil.replace(HttpUtil.getUrlEncode(fileName, "UTF-8"), "\\+", "%20");
	            }
				else if(userAgent.indexOf("Chrome") > -1) // 크롬 브라우저 체크
				{
	            	StringBuilder sb = new StringBuilder();
	            	char[] charFileNames = fileName.toCharArray(); // 문자열에서 캐릭터 배열을 얻는다.
	            	
	            	for(int i=0; i<charFileNames.length; i++) 
	            	{
	            		char c = charFileNames[i];
	            		
	            		if(c > '~') 
	            		{
	            			sb.append(HttpUtil.getUrlEncode(""+c, "UTF-8"));
	            		}
	            		else 
	            		{
	            			sb.append(c);
	            		}
	            	}
	            	
	            	downloadFileName = sb.toString();
	            }
				else // 기타 브라우저
				{
					downloadFileName = new String(fileName.getBytes("UTF-8"));
	            }
				
				response.setContentType("application/octet-stream");
	            response.setContentLength((int)file.length());
	            response.setHeader("Content-Disposition", "attachment; filename=\""+downloadFileName+"\";");
	            response.setHeader("Content-Transfer-Encoding", "binary");
	            
	            inputStream = new FileInputStream(file);   // 파일을 읽는 스트림을 생성한다.
	            outputStream = response.getOutputStream(); // 파일을 쓰는 스트림을 HttpServletResponse 에서 얻는다.
	            
	            byte[] buffer = new byte[4096];
	            int byteRead = -1;
	            
	            while((byteRead = inputStream.read(buffer)) != -1) // 파일의 끝이면 -1 리턴
	            {
	            	// 파일을 읽는 스트림에서 읽은 바이트 만큼을 HttpServletResponse 스트림에 쓴다.
	            	outputStream.write(buffer, 0, byteRead);
	            }
			}
			catch(Exception e)
			{
				logger.error("[FileDownloadView] Exception", e);
				
				throw e;
			}
			finally
			{
				FileUtil.close(inputStream);  // FileInputStream 객체 닫기
				FileUtil.close(outputStream); // OutputStream 객체 닫기
			}
		}
		else
		{
			logger.error("[FileDownloadView] file not found");
			
			throw new Exception("[FileDownloadView] file not found");
		}
	}

}
