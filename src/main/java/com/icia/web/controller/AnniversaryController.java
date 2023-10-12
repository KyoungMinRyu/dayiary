package com.icia.web.controller;

import java.util.ArrayList;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.icia.common.util.StringUtil;
import com.icia.web.model.Anniversary;
import com.icia.web.model.CoupleAnniversary;
import com.icia.web.model.Friend;
import com.icia.web.model.Response;
import com.icia.web.model.UserG2;
import com.icia.web.service.AnniversaryService;
import com.icia.web.service.FriendService;
import com.icia.web.service.UserG2Service;
import com.icia.web.util.CookieUtil;
import com.icia.web.util.HttpUtil;

@Controller("anniversaryController")
public class AnniversaryController 
{
	private static Logger logger = LoggerFactory.getLogger(AnniversaryController.class);
	   
	// 쿠키명
	@Value("#{env['auth.cookie.name']}")
	private String AUTH_COOKIE_NAME;
	
	@Autowired
	private AnniversaryService anniversaryService;
	
	@Autowired 
	private FriendService friendService;
	
	@Autowired
	private UserG2Service userG2Service;
	
	@RequestMapping(value="/anniversary/addAnniversary", method=RequestMethod.POST)
	@ResponseBody
	public Response<Object> addAnniversary(HttpServletRequest request, HttpServletResponse response)
	{
		Response<Object> ajaxResponse = new Response<Object>();
		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		String calTitle = HttpUtil.get(request, "calTitle", "");
		String calContent = HttpUtil.get(request, "calContent", "");
		String year = HttpUtil.get(request, "year", "");
		String month = HttpUtil.get(request, "month", "");
		String day = HttpUtil.get(request, "day", "");
		String calTime = HttpUtil.get(request, "calTime", "");
		String orderSeq = HttpUtil.get(request, "orderSeq", "");
		if(!StringUtil.isEmpty(calTitle) && !StringUtil.isEmpty(calContent) && !StringUtil.isEmpty(year) && !StringUtil.isEmpty(month) && !StringUtil.isEmpty(day))
		{
			if(friendService.selectUser(cookieUserId) != null)
			{
				Anniversary anniversary = new Anniversary();
				anniversary.setUserId(cookieUserId);
				anniversary.setAnniversaryTitle(calTitle);
				anniversary.setAnniversaryContent(calContent);
				anniversary.setAnniversaryDate(year + month + day);
				anniversary.setAnniversaryTime(calTime);
				anniversary.setOrderSeq(orderSeq);
				if(anniversaryService.insertAnniversary(anniversary) > 0)
				{
					ajaxResponse.setResponse(0, "Success", "일정 등록에 성공하였습니다.");
				}
				else
				{
					ajaxResponse.setResponse(500, "DB Sever Error", "서버에서 오류가 발생하였습니다. 다시 시도해 주세요.");
				}
			}
			else 
			{
				ajaxResponse.setResponse(404, "Not Found", "해당 사용자가 존재하지 않습니다.");	
			}
		}
		else
		{
			ajaxResponse.setResponse(400, "Bad Request", "입력 값이 올바르지 않습니다.");	
		}
		return ajaxResponse;
	}
	
	@RequestMapping(value="/anniversary/detailAnniversary", method=RequestMethod.POST)
	@ResponseBody
	public Response<Object> detailAnniversary(HttpServletRequest request, HttpServletResponse response)
	{
		Response<Object> ajaxResponse = new Response<Object>();
		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		String year = HttpUtil.get(request, "year", "");
		String month = HttpUtil.get(request, "month", "");
		String day = HttpUtil.get(request, "day", "");
		if(!StringUtil.isEmpty(year) && !StringUtil.isEmpty(month) && !StringUtil.isEmpty(day))
		{
			String ymd = year + month + day;
			List<Anniversary> anniversaryList = null;
			List<Anniversary> birthdayList = null;
			Anniversary anniversary = null;
			UserG2 userG2 = userG2Service.userIdSelect(cookieUserId);
			if(friendService.selectUser(cookieUserId) != null)
			{
				anniversary = new Anniversary();
				anniversary.setUserId(cookieUserId);
				anniversary.setAnniversaryDate(ymd);
				anniversaryList = anniversaryService.selectAnniversaryDetailList(anniversary);
				
				if(anniversaryList != null && anniversaryList.size() > 0)
				{
					for(int i = 0; i < anniversaryList.size(); i++)
					{
						if(StringUtil.equals(cookieUserId, anniversaryList.get(i).getUserId()))
						{
							anniversaryList.get(i).setUserId("");
						}
					}
					
					anniversary.setAnniversaryDate(month + day);
					birthdayList = anniversaryService.selectFriendBirthday(anniversary);
					Anniversary birthdayAnniversary = null;
					if(birthdayList != null && birthdayList.size() > 0)
					{
						for(int i = 0; i < birthdayList.size(); i++)
						{
							birthdayAnniversary = birthdayList.get(i);
							birthdayAnniversary.setAnniversaryTitle(birthdayAnniversary.getUserNickname() + "님의 생일입니다.");
							birthdayAnniversary.setAnniversaryContent(birthdayAnniversary.getUserNickname() + "님의 생일을 축하해주세요.");
							
						}
						anniversaryList.addAll(birthdayList);
					}
					
					anniversary = getCoupleAnniversary(ymd, cookieUserId);
					if(anniversary != null)
					{
						anniversaryList.add(anniversary);
					}
					
					if(StringUtil.equals(userG2.getUserBir().substring(4), month + day))
					{
						birthdayAnniversary = new Anniversary();
						birthdayAnniversary.setAnniversaryTitle(userG2.getUserNickName() + "님의 생일을 축하합니다.");
						birthdayAnniversary.setAnniversaryContent("Dayiary는 " + userG2.getUserNickName() + "님의 생일을 함께합니다.");
						anniversaryList.add(birthdayAnniversary);
					}
					ajaxResponse.setResponse(0, "Success", anniversaryList);
				}
				else
				{
					anniversaryList = new ArrayList<Anniversary>();
					anniversary.setAnniversaryDate(month + day);
					birthdayList = anniversaryService.selectFriendBirthday(anniversary);
					Anniversary birthdayAnniversary = null;
					if(birthdayList != null && birthdayList.size() > 0)
					{
						for(int i = 0; i < birthdayList.size(); i++)
						{
							birthdayAnniversary = birthdayList.get(i);
							birthdayAnniversary.setAnniversaryTitle(birthdayAnniversary.getUserNickname() + "님의 생일입니다.");
							birthdayAnniversary.setAnniversaryContent(birthdayAnniversary.getUserNickname() + "님의 생일을 축하해주세요.");
							
						}
						anniversaryList.addAll(birthdayList);
					}
					if(StringUtil.equals(userG2.getUserBir().substring(4), month + day))
					{
						birthdayAnniversary = new Anniversary();
						birthdayAnniversary.setAnniversaryTitle(userG2.getUserNickName() + "님의 생일을 축하합니다.");
						birthdayAnniversary.setAnniversaryContent("Dayiary는 " + userG2.getUserNickName() + "님의 생일을 함께합니다.");
						anniversaryList.add(birthdayAnniversary);
					}
					
					anniversary = getCoupleAnniversary(ymd, cookieUserId);
					if(anniversary != null)
					{
						anniversaryList.add(anniversary);
					}
					
					if(anniversaryList.size() == 0)
					{
						anniversary = new Anniversary();
						anniversary.setAnniversaryTitle("해당하는 날에 등록된 일정이 없어요.");
						anniversaryList.add(anniversary);
						ajaxResponse.setResponse(1, "Success", anniversaryList);
						return ajaxResponse;
					}

					ajaxResponse.setResponse(0, "Success", anniversaryList);
				}
			}
			else 
			{
				ajaxResponse.setResponse(404, "Not Found", "해당 사용자가 존재하지 않습니다.");	
			}
		}
		else
		{
			ajaxResponse.setResponse(400, "Bad Request", "입력 값이 올바르지 않습니다.");	
		}
		return ajaxResponse;
	}
	
	@RequestMapping(value="/anniversary/checkMyAnniversary", method=RequestMethod.POST)
	@ResponseBody
	public Response<Object> checkMyAnniversary(HttpServletRequest request, HttpServletResponse response)
	{
		Response<Object> ajaxResponse = new Response<Object>();
		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		long anniversarySeq = HttpUtil.get(request, "anniversarySeq", (long)0);
		if(anniversarySeq > 0)
		{
			if(friendService.selectUser(cookieUserId) != null)
			{
				HashMap<String, Object> hashMap = new HashMap<String, Object>();
				hashMap.put("userId", cookieUserId);
				hashMap.put("anniversarySeq", anniversarySeq);
				if(anniversaryService.selechMyAnniversary(hashMap) > 0)
				{
					ajaxResponse.setResponse(0, "Success", "");
				}
				else
				{
					ajaxResponse.setResponse(500, "Success", "본인 일정만 공유할 수 있습니다.");
				}
			}
			else
			{
				ajaxResponse.setResponse(404, "Not Found", "해당 사용자가 존재하지 않습니다.");	
			}
		}
		else
		{
			ajaxResponse.setResponse(400, "Bad Request", "입력 값이 올바르지 않습니다.");	
		}
		return ajaxResponse;
	}
	
	@RequestMapping(value="/anniversary/getShareableList", method=RequestMethod.POST)
	@ResponseBody
	public Response<Object> getShareableList(HttpServletRequest request, HttpServletResponse response)
	{
		Response<Object> ajaxResponse = new Response<Object>();
		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		long anniversarySeq = HttpUtil.get(request, "anniversarySeq", (long)0);
		if(anniversarySeq > 0)
		{
			if(friendService.selectUser(cookieUserId) != null)
			{
				HashMap<String, Object> hashMap = new HashMap<String, Object>();
				hashMap.put("userId", cookieUserId);
				hashMap.put("anniversarySeq", anniversarySeq);
				if(anniversaryService.selechMyAnniversary(hashMap) > 0)
				{
					List<Anniversary> anniversaryList = anniversaryService.selectShareableList(hashMap);
					if(anniversaryList != null && anniversaryList.size() > 0)
					{
						ajaxResponse.setResponse(0, "Success", anniversaryList);
					}
					else
					{
						anniversaryList = new ArrayList<Anniversary>();
						ajaxResponse.setResponse(0, "Success", anniversaryList);
					}
				}
				else 
				{
					ajaxResponse.setResponse(500, "Success", "본인 일정만 공유할 수 있습니다.");
				}
			}
			else
			{
				ajaxResponse.setResponse(404, "Not Found", "해당 사용자가 존재하지 않습니다.");	
			}
		}
		else
		{
			ajaxResponse.setResponse(400, "Bad Request", "입력 값이 올바르지 않습니다.");	
		}
		return ajaxResponse;
	}
	
	@RequestMapping(value="/anniversary/shareForYou", method=RequestMethod.POST)
	@ResponseBody
	public Response<Object> shareForYou(HttpServletRequest request, HttpServletResponse response)
	{
		Response<Object> ajaxResponse = new Response<Object>();
		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		long anniversarySeq = HttpUtil.get(request, "anniversarySeq", (long)0);
		long relationalSeq = HttpUtil.get(request, "relationalSeq", (long)0);
		if(anniversarySeq > 0 && relationalSeq > 0)
		{
			if(friendService.selectUser(cookieUserId) != null)
			{
				HashMap<String, Object> hashMap = new HashMap<String, Object>();
				hashMap.put("anniversarySeq", anniversarySeq);
				hashMap.put("userId", cookieUserId);
				if(anniversaryService.selechMyAnniversary(hashMap) > 0)
				{
					Friend friend = friendService.selectFreind(relationalSeq);
					if(friend != null)
					{
						System.out.println();
						System.out.println("cookieUserId : " + cookieUserId);
						System.out.println("friend.getUserId : " + friend.getUserId());
						System.out.println("friend.getYourId : " + friend.getYourId());
						System.out.println();
						
						if(StringUtil.equals(cookieUserId, friend.getUserId()) || StringUtil.equals(cookieUserId, friend.getYourId()))
						{
							hashMap.clear();
							hashMap.put("anniversarySeq", anniversarySeq);
							hashMap.put("relationalSeq", relationalSeq);
							if(anniversaryService.insertAnniversaryShare(hashMap) > 0)
							{
								ajaxResponse.setResponse(0, "Success", "일정 공유되었습니다.");
							}
							else
							{
								ajaxResponse.setResponse(500, "DB Sever Error", "서버에서 오류가 발생하였습니다. 다시 시도해 주세요.");
							}
						}
						else
						{
							ajaxResponse.setResponse(404, "Not Found", "친구가 아닙니다.");	
						}
					}
					else
					{
						ajaxResponse.setResponse(404, "Not Found", "해당 사용자가 존재하지 않습니다.");	
					}
				}
				else
				{
					ajaxResponse.setResponse(404, "Not Found", "본인 일정만 공유할 수 있습니다.");
				}
			}
			else
			{
				ajaxResponse.setResponse(404, "Not Found", "해당 사용자가 존재하지 않습니다.");
			}
		}
		else
		{
			ajaxResponse.setResponse(400, "Bad Request", "입력 값이 올바르지 않습니다.");	
		}
		return ajaxResponse;
	}
	
	@RequestMapping(value="/anniversary/cancleShared", method=RequestMethod.POST)
	@ResponseBody
	public Response<Object> cancleShared(HttpServletRequest request, HttpServletResponse response)
	{
		Response<Object> ajaxResponse = new Response<Object>();
		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		long anniversarySeq = HttpUtil.get(request, "anniversarySeq", (long)0);
		long relationalSeq = HttpUtil.get(request, "relationalSeq", (long)0);
		if(anniversarySeq > 0 && relationalSeq > 0)
		{
			if(friendService.selectUser(cookieUserId) != null)
			{
				HashMap<String, Object> hashMap = new HashMap<String, Object>();
				hashMap.put("anniversarySeq", anniversarySeq);
				hashMap.put("userId", cookieUserId);
				if(anniversaryService.selechMyAnniversary(hashMap) > 0)
				{
					Friend friend = friendService.selectFreind(relationalSeq);
					if(friend != null)
					{
						if(StringUtil.equals(cookieUserId, friend.getUserId()) || StringUtil.equals(cookieUserId, friend.getYourId()))
						{
							hashMap.clear();
							hashMap.put("anniversarySeq", anniversarySeq);
							hashMap.put("relationalSeq", relationalSeq);
							if(anniversaryService.deleteAnniversaryShared(hashMap) > 0)
							{
								ajaxResponse.setResponse(0, "Success", "일정 공유가 취소 되었습니다.");
							}
							else
							{
								ajaxResponse.setResponse(500, "DB Sever Error", "서버에서 오류가 발생하였습니다. 다시 시도해 주세요.");
							}
						}
						else
						{
							ajaxResponse.setResponse(404, "Not Found", "친구가 아닙니다.");	
						}
					}
					else
					{
						ajaxResponse.setResponse(404, "Not Found", "해당 사용자가 존재하지 않습니다.");	
					}
				}
				else
				{
					ajaxResponse.setResponse(404, "Not Found", "본인 일정만 공유할 수 있습니다.");
				}
			}
			else
			{
				ajaxResponse.setResponse(404, "Not Found", "해당 사용자가 존재하지 않습니다.");
			}
		}
		else
		{
			ajaxResponse.setResponse(400, "Bad Request", "입력 값이 올바르지 않습니다.");	
		}
		return ajaxResponse;
	}
	

	@RequestMapping(value="/anniversary/getSharedList", method=RequestMethod.POST)
	@ResponseBody
	public Response<Object> getSharedList(HttpServletRequest request, HttpServletResponse response)
	{
		Response<Object> ajaxResponse = new Response<Object>();
		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		long anniversarySeq = HttpUtil.get(request, "anniversarySeq", (long)0);
		if(anniversarySeq > 0)
		{
			if(friendService.selectUser(cookieUserId) != null)
			{
				HashMap<String, Object> hashMap = new HashMap<String, Object>();
				hashMap.put("userId", cookieUserId);
				hashMap.put("anniversarySeq", anniversarySeq);
				if(anniversaryService.selechMyAnniversary(hashMap) > 0)
				{
					List<Anniversary> anniversaryList = anniversaryService.selectSharedList(hashMap);
					if(anniversaryList != null && anniversaryList.size() > 0)
					{
						ajaxResponse.setResponse(0, "Success", anniversaryList);
					}
					else
					{
						anniversaryList = new ArrayList<Anniversary>();
						ajaxResponse.setResponse(0, "Success", anniversaryList);
					}
				}
				else 
				{
					ajaxResponse.setResponse(500, "Success", "본인 일정만 공유할 수 있습니다.");
				}
			}
			else
			{
				ajaxResponse.setResponse(404, "Not Found", "해당 사용자가 존재하지 않습니다.");	
			}
		}
		else
		{
			ajaxResponse.setResponse(400, "Bad Request", "입력 값이 올바르지 않습니다.");	
		}
		return ajaxResponse;
	}
	
	@RequestMapping(value="/anniversary/deleteAnniversary", method=RequestMethod.POST)
	@ResponseBody
	public Response<Object> deleteAnniversary(HttpServletRequest request, HttpServletResponse response)
	{
		Response<Object> ajaxResponse = new Response<Object>();
		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		long anniversarySeq = HttpUtil.get(request, "anniversarySeq", (long)0);
		if(anniversarySeq > 0)
		{
			if(friendService.selectUser(cookieUserId) != null)
			{
				HashMap<String, Object> hashMap = new HashMap<String, Object>();
				hashMap.put("userId", cookieUserId);
				hashMap.put("anniversarySeq", anniversarySeq);
				if(anniversaryService.selechMyAnniversary(hashMap) > 0)
				{
					try 
					{
						if(anniversaryService.deleteAnniversary(hashMap) > 0)
						{
							ajaxResponse.setResponse(0, "Success", "일정이 삭제 되었습니다.");
						}
						else
						{
							ajaxResponse.setResponse(500, "DB Sever Error", "서버에서 오류가 발생하였습니다. 다시 시도해 주세요.");
						}
					}
					catch (Exception e) 
					{
						logger.error("[AnniversaryController](deleteAnniversary)", e);
					}
				}
				else 
				{
					ajaxResponse.setResponse(500, "Success", "본인 일정만 삭제할 수 있습니다.");
				}
			}
			else
			{
				ajaxResponse.setResponse(404, "Not Found", "해당 사용자가 존재하지 않습니다.");	
			}
		}
		else
		{
			ajaxResponse.setResponse(400, "Bad Request", "입력 값이 올바르지 않습니다.");	
		}
		return ajaxResponse;
	}
	
	@RequestMapping(value="/anniversary/refuseShared", method=RequestMethod.POST)
	@ResponseBody
	public Response<Object> refuseShared(HttpServletRequest request, HttpServletResponse response)
	{
		Response<Object> ajaxResponse = new Response<Object>();
		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		long anniversarySeq = HttpUtil.get(request, "anniversarySeq", (long)0);
		String yourId = HttpUtil.get(request, "yourId", "");
		if(anniversarySeq > 0 && !StringUtil.isEmpty(yourId))
		{
			if(!StringUtil.equals(cookieUserId, yourId))
			{
				if(friendService.selectUser(cookieUserId) != null && friendService.selectUser(yourId) != null)
				{
					HashMap<String, Object> hashMap = new HashMap<String, Object>();
					hashMap.put("userId", cookieUserId);
					hashMap.put("yourId", yourId);
					if(friendService.selectFriendStatus(hashMap) > 0)
					{
						hashMap.put("anniversarySeq", anniversarySeq);
						if(anniversaryService.deleteRefuseSharedAnniversary(hashMap) > 0)
						{
							ajaxResponse.setResponse(0, "Success", "공유 받은 일정이 삭제 되었습니다.");
						}
						else
						{
							ajaxResponse.setResponse(500, "DB Sever Error", "서버에서 오류가 발생하였습니다. 다시 시도해 주세요.");
						}
					}
					else
					{
						ajaxResponse.setResponse(404, "Not Found", "해당 사용자와 친구 상태가 아닙니다.");
					}
				}
				else
				{
					ajaxResponse.setResponse(404, "Not Found", "해당 사용자가 존재하지 않습니다.");	
				}
			}
			else
			{
				ajaxResponse.setResponse(404, "Not Found", "같은 사용자 입니다.");
			}
		}
		else
		{
			ajaxResponse.setResponse(400, "Bad Request", "입력 값이 올바르지 않습니다.");
		}
		return ajaxResponse;
	}
	
	private Anniversary getCoupleAnniversary(String date, String cookieUserId)
	{
		Anniversary anniversary = null;
		CoupleAnniversary coupleAnniversary = anniversaryService.selectCoupleAnniversary(cookieUserId);
		if(coupleAnniversary != null)
		{
			if(StringUtil.equals(coupleAnniversary.getDay100(), date))
			{
				anniversary = new Anniversary();
				anniversary.setAnniversaryDate(date);
				anniversary.setAnniversaryTitle("🧡 100일 🧡");
				anniversary.setAnniversaryContent("🧡 사귄지 100일 되는 날이에요 🧡");
				return anniversary;
			}
			else if(StringUtil.equals(coupleAnniversary.getDay200(), date))
			{
				anniversary = new Anniversary();
				anniversary.setAnniversaryDate(date);
				anniversary.setAnniversaryTitle("🧡 200일 🧡");
				anniversary.setAnniversaryContent("🧡 사귄지 200일 되는 날이에요 🧡");
				return anniversary;
			}
			else if(StringUtil.equals(coupleAnniversary.getDay300(), date))
			{
				anniversary = new Anniversary();
				anniversary.setAnniversaryDate(date);
				anniversary.setAnniversaryTitle("🧡 300일 🧡");
				anniversary.setAnniversaryContent("🧡 사귄지 300일 되는 날이에요 🧡");
				return anniversary;
				
			}
			else if(StringUtil.equals(coupleAnniversary.getStartDate().substring(4, 8), date.substring(4, 8)))
			{
				anniversary = new Anniversary();
				anniversary.setAnniversaryDate(date);
				String calYear = Integer.toString(Integer.parseInt(date.substring(0, 4)) - Integer.parseInt(coupleAnniversary.getStartDate().substring(0, 4)));
				if(!StringUtil.equals(calYear, "0"))
				{
					anniversary.setAnniversaryTitle("🧡 " + calYear + "주년 🧡");
					anniversary.setAnniversaryContent("🧡 사귄지 " + calYear + "주년이 되는 날이에요. 🧡");
				}
				else 
				{
					anniversary.setAnniversaryTitle("🧡 사귀기시작한날 🧡");
					anniversary.setAnniversaryContent("🧡 사귀기 시작한 날이에요 🧡");
				}
				return anniversary;
			}
		}
		return null;
	}
}
