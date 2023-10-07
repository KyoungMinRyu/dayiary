package com.icia.web.controller;

import java.time.format.DateTimeFormatter;


import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.icia.common.util.StringUtil;
import com.icia.web.model.Anniversary;
import com.icia.web.model.CoupleAnniversary;
import com.icia.web.model.Response;
import com.icia.web.model.UserG2;
import com.icia.web.model.Weather;
import com.icia.web.service.AnniversaryService;
import com.icia.web.service.UserG2Service;
import com.icia.web.util.CookieUtil;
import com.icia.web.util.DayData;
import com.icia.web.util.HttpUtil;
import com.icia.web.util.PublicDataApi;

@Controller("calenderController")
public class CalenderController 
{
	private static Logger logger = LoggerFactory.getLogger(CalenderController.class);
   
	// 쿠키명
	@Value("#{env['auth.cookie.name']}")
	private String AUTH_COOKIE_NAME;
	
	@Autowired
	private HttpSession session; // HttpSession 객체를 주입받음
	
	@Autowired
	private AnniversaryService anniversaryService;	
	
	@Autowired
	private UserG2Service userG2Service;
	
	private PublicDataApi publicDataApi;
	
	public CalenderController() 
	{
		DayData.getDayData();
		publicDataApi = new PublicDataApi();
	}

	// 캘린더 페이지 이동
	@RequestMapping(value="/calender/calender", method=RequestMethod.GET)
	public String calender(ModelMap modelMap, HttpServletRequest request, HttpServletResponse response)
	{
		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		String year = HttpUtil.get(request, "year", publicDataApi.getLocalDateTime().format(DateTimeFormatter.ofPattern("yyyy")));
		String month = HttpUtil.get(request, "month", publicDataApi.getLocalDateTime().format(DateTimeFormatter.ofPattern("MM")));
		System.out.println(month);
        Map<String, List<String>> map = (Map<String, List<String>>)session.getAttribute(year);
		List<String> day = new ArrayList<String>();
		day.addAll(getList(month, 0));
		List<String> content = new ArrayList<String>();
		content.addAll(getList(month, 1));
		if(map != null)
		{
			if(StringUtil.equals(month, map.get("0").get(0)))
			{
				day.add(map.get("0").get(1));
				content.add(map.get("0").get(2));
			}
			else if(StringUtil.equals(month, map.get("1").get(0)))
			{
				day.add(map.get("1").get(1));
				content.add(map.get("1").get(2));
			}
		}
		UserG2 userG2 = userG2Service.userIdSelect(cookieUserId);
		
		if(userG2 != null)
		{
			if(StringUtil.equals(userG2.getUserBir().substring(4, 6), month))
			{
				day.add(userG2.getUserBir().substring(6));
				content.add(userG2.getUserNickName() + "님 생일축하합니다.");
			}
			
			CoupleAnniversary coupleAnniversary = anniversaryService.selectCoupleAnniversary(cookieUserId);
			if(coupleAnniversary != null)
			{
				if(coupleAnniversary.getDay100().indexOf(year + month) == 0)
				{
					day.add(coupleAnniversary.getDay100().substring(6));
					content.add("🧡 100일 🧡");
				}
				else if(coupleAnniversary.getDay200().indexOf(year + month) == 0)
				{
					day.add(coupleAnniversary.getDay200().substring(6));
					content.add("🧡 200일 🧡");
				}
				else if(coupleAnniversary.getDay300().indexOf(year + month) == 0)
				{
					day.add(coupleAnniversary.getDay300().substring(6));
					content.add("🧡 300일 🧡");
				}
				else if(coupleAnniversary.getStartDate().substring(4, 6).indexOf(month) == 0)
				{
					day.add(coupleAnniversary.getStartDate().substring(6));
					String calYear = Integer.toString(Integer.parseInt(year) - Integer.parseInt(coupleAnniversary.getStartDate().substring(0, 4)));
					if(!StringUtil.equals(calYear, "0"))
					{
						content.add("🧡 " + calYear + "주년 🧡");
					}
					else 
					{
						content.add("🧡사귄날🧡");
					}
				}
			}
			
			Anniversary anniversary = new Anniversary();
			anniversary.setUserId(cookieUserId);
			anniversary.setAnniversaryDate(year + month);
			
			List<Anniversary> anniversarieTitleList = anniversaryService.selectAnniversaryTitleList(anniversary);
			if(anniversarieTitleList != null && anniversarieTitleList.size() > 0)
			{
				for(int i = 0; i < anniversarieTitleList.size(); i++)
				{
					day.add(anniversarieTitleList.get(i).getAnniversaryDate().substring(6));
					content.add(anniversarieTitleList.get(i).getAnniversaryTitle());
				}
			}
			
			anniversary.setAnniversaryDate(month);
			List<Anniversary> birthdayTitleList = anniversaryService.selectFriendBirthday(anniversary);
			if(birthdayTitleList !=null && birthdayTitleList.size() > 0)
			{
				for(int i = 0; i < birthdayTitleList.size(); i++)
				{
					day.add(birthdayTitleList.get(i).getUserBir().substring(6));
					content.add(birthdayTitleList.get(i).getUserNickname() + "의 생일");
				}
			}
			
		}
		
//		sortList(day, content);	
		
		modelMap.addAttribute("day", day);
		modelMap.addAttribute("content", content);
		modelMap.addAttribute("year", year);
		modelMap.addAttribute("month", month);
		modelMap.addAttribute("userId", cookieUserId);
		return "/calender/calender"; 
	}
	
	
	@RequestMapping(value="/calender/moon", method=RequestMethod.POST)
	public void moon(HttpServletRequest request, HttpServletResponse response)
	{
		String year = HttpUtil.get(request, "year", publicDataApi.getLocalDateTime().format(DateTimeFormatter.ofPattern("yyyy")));
		Map<String, List<String>> map = (Map<String, List<String>>)session.getAttribute(year);
		if(map == null)
		{
			map = publicDataApi.getMoonDayData(year);
			session.setAttribute(year, map);
		}
	}
	
	@RequestMapping(value="/calender/weather", method=RequestMethod.POST)
	@ResponseBody
	public Response<Object> refuseShared(HttpServletRequest request, HttpServletResponse response)
	{
		Response<Object> ajaxResponse = new Response<Object>();
		Weather weather = publicDataApi.weatherApi(request);
		if(weather != null)
		{
			ajaxResponse.setResponse(0, "success", weather);
			return ajaxResponse;
		}
		return null;
	}
	
	/**
	 * <pre>
	 * 메소드명 : getList
	 * 파라미터 : String month, int type
	 * 리턴타입 : List<String>
	 * 설명 : type이 0이면 해당 월에 있는 기념일 날짜를 1이면 날짜에 대한 기념일 정보 리스트를 반환
	 **/
	private List<String> getList(String month, int type)
	{
		if(type == 0)
		{
			switch(Integer.parseInt(month)) 
			{
				case 1:
					return DayData.getMon1Day();
					
				case 2:
					return DayData.getMon2Day();
					
				case 3:
					return DayData.getMon3Day();
					
				case 4:
					return DayData.getMon4Day();
					
				case 5:
					return DayData.getMon5Day();
					
				case 6:
					return DayData.getMon6Day();
					
				case 7:
					return DayData.getMon7Day();
					
				case 8:
					return DayData.getMon8Day();
					
				case 9:
					return DayData.getMon9Day();
					
				case 10:
					return DayData.getMon10Day();
					
				case 11:
					return DayData.getMon11Day();
					
				case 12:
					return DayData.getMon12Day();
			}
		}
		else if(type == 1)
		{
			switch(Integer.parseInt(month)) 
			{
			case 1:
				return DayData.getMon1Content();
				
			case 2:
				return DayData.getMon2Content();
				
			case 3:
				return DayData.getMon3Content();
				
			case 4:
				return DayData.getMon4Content();
				
			case 5:
				return DayData.getMon5Content();
				
			case 6:
				return DayData.getMon6Content();
				
			case 7:
				return DayData.getMon7Content();
				
			case 8:
				return DayData.getMon8Content();
				
			case 9:
				return DayData.getMon9Content();
				
			case 10:
				return DayData.getMon10Content();
				
			case 11:
				return DayData.getMon11Content();
				
			case 12:
				return DayData.getMon12Content();
			}
		}
		return null;
	}
	
	/**
	 * <pre>
	 * 메소드명 : sortList
	 * 파라미터 : List<String> day, List<String> content
	 * 리턴타입 : void
	 * 설명 : 리스트를 day를 기준으로 오름차순 정렬 한다
	 **/
	private void sortList(List<String> day, List<String> content)
	{
		System.out.println("Bubble Sort 실행");
		String temp = "";
		
		for(int i = 0; i < day.size(); i++) 
		{
			for(int j = 0; j < day.size(); j++) 
			{
				if(Integer.parseInt(day.get(i)) < Integer.parseInt(day.get(j))) 
				{
					temp = day.get(i);
					day.set(i, day.get(j));
					day.set(j, temp);
					temp = content.get(i);
					content.set(i, content.get(j));
					content.set(j, temp);
				}
			}
		}
		System.out.println("Bubble Sort 된 리스트");
		System.out.println(day);
		System.out.println(content);
	}
}
