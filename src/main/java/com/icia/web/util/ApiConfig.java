package com.icia.web.util;

import java.io.File;
import java.io.FileWriter;
import java.io.IOException;

import org.ini4j.Ini;
import org.ini4j.InvalidFileFormatException;
import org.ini4j.Wini;

public class ApiConfig 
{
	// ini 파일 경로
	final static String CONFIG = "C:/Code/webapps/dayiary/src/main/webapp/WEB-INF/config/apiConfig/";
    
	/**
	 * <pre>
	 * 메소드명   : getProperties
	 * 작성일     : 2023.08.08
	 * 작성자     : LookAtMe
	 * 설명       : ini 파일에 properties가져옴
	 *  @param apiName 
	 *  @param key 
	 *  @param value 
	 *  @param fileName 
	 * </pre>
	 */
	public static String getProperties(String apiName, String key, String fileName)
	{
		try 
		{
			File iniFile = new File(CONFIG + fileName + ".ini");
			Ini ini = new Ini(iniFile);
	        return ini.get(apiName, key);
		} 
		catch (InvalidFileFormatException e) 
		{
			e.printStackTrace();
			return null;
		} 
		catch (IOException e) 
		{
			e.printStackTrace();
			return null;
		}
		catch (Exception e) 
		{
			e.printStackTrace();
			return null;
		}
	}
	
	/**
	 * <pre>
	 * 메소드명   : setProperties
	 * 작성일     : 2023.08.08
	 * 작성자     : LookAtMe
	 * 설명       : ini 파일에 properties추가
	 *  @param apiName 
	 *  @param key 
	 *  @param value 
	 *  @param fileName 
	 * </pre>
	 */
	public void setProperties(String apiName, String key, String value, String fileName)
	{
		try 
		{
			File file = new File(CONFIG + File.separator + fileName + ".ini");
	        Wini iniFile;
	        if (file.exists()) 
	        {
	            iniFile = new Wini(file);
	        }
	        else 
	        {
	            file.createNewFile();
	            iniFile = new Wini(file);
	        }
	        iniFile.put(apiName, key, value);
	        iniFile.store();
		} 
		catch (InvalidFileFormatException e) 
		{
			e.printStackTrace();
		} 
		catch (IOException e) 
		{
			e.printStackTrace();
		}
		catch (Exception e) 
		{
			e.printStackTrace();
		}
	}
	
	/**
	 * <pre>
	 * 메소드명   : createIni
	 * 작성일     : 2023.08.08
	 * 작성자     : LookAtMe
	 * 설명       : ini 파일 생성
	 *  @param path 
	 *  @param fileName 
	 * </pre>
	 */
	public void createIni(String path, String fileName) 
	{
        try 
        {
            File file = new File(path);
            if(!file.exists()) 
            {
                file.mkdirs();
            }
            file = new File(path + File.separator + fileName + ".ini");
            FileWriter fileWriter = new FileWriter(file);
            fileWriter.close();
            Wini iniFile = new Wini(file);
            iniFile.store();
        } 
        catch(Exception e) 
        {
        	e.printStackTrace();
        }
    }
}
