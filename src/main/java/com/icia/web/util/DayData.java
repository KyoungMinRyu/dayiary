package com.icia.web.util;

import java.util.ArrayList;
import java.util.List;
import java.io.File;

public class DayData 
{
	private static List<String> mon1Day = new ArrayList<String>();
	private static List<String> mon1Content = new ArrayList<String>();
	private static List<String> mon2Day = new ArrayList<String>();
	private static List<String> mon2Content = new ArrayList<String>();
	private static List<String> mon3Day = new ArrayList<String>();
	private static List<String> mon3Content = new ArrayList<String>();
	private static List<String> mon4Day = new ArrayList<String>();
	private static List<String> mon4Content = new ArrayList<String>();
	private static List<String> mon5Day = new ArrayList<String>();
	private static List<String> mon5Content = new ArrayList<String>();
	private static List<String> mon6Day = new ArrayList<String>();
	private static List<String> mon6Content = new ArrayList<String>();
	private static List<String> mon7Day = new ArrayList<String>();
	private static List<String> mon7Content = new ArrayList<String>();
	private static List<String> mon8Day = new ArrayList<String>();
	private static List<String> mon8Content = new ArrayList<String>();
	private static List<String> mon9Day = new ArrayList<String>();
	private static List<String> mon9Content = new ArrayList<String>();
	private static List<String> mon10Day = new ArrayList<String>();
	private static List<String> mon10Content = new ArrayList<String>();
	private static List<String> mon11Day = new ArrayList<String>();
	private static List<String> mon11Content = new ArrayList<String>();
	private static List<String> mon12Day = new ArrayList<String>();
	private static List<String> mon12Content = new ArrayList<String>();

	
	public static List<String> getMon1Day() {
		return mon1Day;
	}


	public static void setMon1Day(List<String> mon1Day) {
		DayData.mon1Day = mon1Day;
	}


	public static List<String> getMon1Content() {
		return mon1Content;
	}


	public static void setMon1Content(List<String> mon1Content) {
		DayData.mon1Content = mon1Content;
	}


	public static List<String> getMon2Day() {
		return mon2Day;
	}


	public static void setMon2Day(List<String> mon2Day) {
		DayData.mon2Day = mon2Day;
	}


	public static List<String> getMon2Content() {
		return mon2Content;
	}


	public static void setMon2Content(List<String> mon2Content) {
		DayData.mon2Content = mon2Content;
	}


	public static List<String> getMon3Day() {
		return mon3Day;
	}


	public static void setMon3Day(List<String> mon3Day) {
		DayData.mon3Day = mon3Day;
	}


	public static List<String> getMon3Content() {
		return mon3Content;
	}


	public static void setMon3Content(List<String> mon3Content) {
		DayData.mon3Content = mon3Content;
	}


	public static List<String> getMon4Day() {
		return mon4Day;
	}


	public static void setMon4Day(List<String> mon4Day) {
		DayData.mon4Day = mon4Day;
	}


	public static List<String> getMon4Content() {
		return mon4Content;
	}


	public static void setMon4Content(List<String> mon4Content) {
		DayData.mon4Content = mon4Content;
	}


	public static List<String> getMon5Day() {
		return mon5Day;
	}


	public static void setMon5Day(List<String> mon5Day) {
		DayData.mon5Day = mon5Day;
	}


	public static List<String> getMon5Content() {
		return mon5Content;
	}


	public static void setMon5Content(List<String> mon5Content) {
		DayData.mon5Content = mon5Content;
	}


	public static List<String> getMon6Day() {
		return mon6Day;
	}


	public static void setMon6Day(List<String> mon6Day) {
		DayData.mon6Day = mon6Day;
	}


	public static List<String> getMon6Content() {
		return mon6Content;
	}


	public static void setMon6Content(List<String> mon6Content) {
		DayData.mon6Content = mon6Content;
	}


	public static List<String> getMon7Day() {
		return mon7Day;
	}


	public static void setMon7Day(List<String> mon7Day) {
		DayData.mon7Day = mon7Day;
	}


	public static List<String> getMon7Content() {
		return mon7Content;
	}


	public static void setMon7Content(List<String> mon7Content) {
		DayData.mon7Content = mon7Content;
	}


	public static List<String> getMon8Day() {
		return mon8Day;
	}


	public static void setMon8Day(List<String> mon8Day) {
		DayData.mon8Day = mon8Day;
	}


	public static List<String> getMon8Content() {
		return mon8Content;
	}


	public static void setMon8Content(List<String> mon8Content) {
		DayData.mon8Content = mon8Content;
	}


	public static List<String> getMon9Day() {
		return mon9Day;
	}


	public static void setMon9Day(List<String> mon9Day) {
		DayData.mon9Day = mon9Day;
	}


	public static List<String> getMon9Content() {
		return mon9Content;
	}


	public static void setMon9Content(List<String> mon9Content) {
		DayData.mon9Content = mon9Content;
	}


	public static List<String> getMon10Day() {
		return mon10Day;
	}


	public static void setMon10Day(List<String> mon10Day) {
		DayData.mon10Day = mon10Day;
	}


	public static List<String> getMon10Content() {
		return mon10Content;
	}


	public static void setMon10Content(List<String> mon10Content) {
		DayData.mon10Content = mon10Content;
	}


	public static List<String> getMon11Day() {
		return mon11Day;
	}


	public static void setMon11Day(List<String> mon11Day) {
		DayData.mon11Day = mon11Day;
	}


	public static List<String> getMon11Content() {
		return mon11Content;
	}


	public static void setMon11Content(List<String> mon11Content) {
		DayData.mon11Content = mon11Content;
	}


	public static List<String> getMon12Day() {
		return mon12Day;
	}


	public static void setMon12Day(List<String> mon12Day) {
		DayData.mon12Day = mon12Day;
	}


	public static List<String> getMon12Content() {
		return mon12Content;
	}


	public static void setMon12Content(List<String> mon12Content) {
		DayData.mon12Content = mon12Content;
	}


	public static void getDayData()
	{
		JsonParsing jsonParsing = new JsonParsing();
    	String json = jsonParsing.readFile("C:/Code/webapps/dayiary/src/main/webapp/WEB-INF/views/resources/data/dayData.json");   			
    	json = jsonParsing.parsingJson(json, "dayData");
//    	System.out.println(json);
    	json = jsonParsing.parsingJson(json, "days");
//    	System.out.println(json);
    	List<String> list = jsonParsing.parsingArr(json);
//    	System.out.println(list.size());
    	String data = "";
    	String month = "";
    	String day = "";
    	String content = "";
    	for(int i = 0; i < list.size(); i++)
    	{
    		data = list.get(i);
    		month = jsonParsing.parsingJson(data, "month");
    		day = jsonParsing.parsingJson(data, "day");
    		content = jsonParsing.parsingJson(data, "content");
    		System.out.println(day + " : " + content);
    		switch(Integer.parseInt(month)) 
    		{
				case 1:
					mon1Day.add(day);
					mon1Content.add(content);
					break;
					
				case 2:
					mon2Day.add(day);
					mon2Content.add(content);
					break;
					
				case 3:
					mon3Day.add(day);
					mon3Content.add(content);
					break;
					
				case 4:
					mon4Day.add(day);
					mon4Content.add(content);
					break;
					
				case 5:
					mon5Day.add(day);
					mon5Content.add(content);
					break;
					
				case 6:
					mon6Day.add(day);
					mon6Content.add(content);
					break;
					
				case 7:
					mon7Day.add(day);
					mon7Content.add(content);
					break;
					
				case 8:
					mon8Day.add(day);
					mon8Content.add(content);
					break;
					
				case 9:
					mon9Day.add(day);
					mon9Content.add(content);
					break;
					
				case 10:
					mon10Day.add(day);
					mon10Content.add(content);
					break;
					
				case 11:
					mon11Day.add(day);
					mon11Content.add(content);
					break;
					
				case 12:
					mon12Day.add(day);
					mon12Content.add(content);
					break;
			}
    	}	
//    	System.out.println(mon1Day.size());
//    	System.out.println(mon2Day.size());
//    	System.out.println(mon3Day.size());
//    	System.out.println(mon4Day.size());
//    	System.out.println(mon5Day.size());
//    	System.out.println(mon6Day.size());
//    	System.out.println(mon7Day.size());
//    	System.out.println(mon8Day.size());
//    	System.out.println(mon9Day.size());
//    	System.out.println(mon10Day.size());
//    	System.out.println(mon11Day.size());
//    	System.out.println(mon12Day.size());
	}
}
