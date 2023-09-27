package com.icia.web.controller;

import java.util.HashMap;



import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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
import com.icia.web.model.CoupleAnniversary;
import com.icia.web.model.Friend;
import com.icia.web.model.Response;
import com.icia.web.service.FriendService;
import com.icia.web.util.CookieUtil;
import com.icia.web.util.HttpUtil;


@Controller("friendController")
public class FriendController 
{
	private static Logger logger = LoggerFactory.getLogger(FriendController.class);
	
	@Autowired
	private FriendService friendService;

	@Value("#{env['auth.cookie.name']}")
	private String AUTH_COOKIE_NAME;
	
	@RequestMapping(value="/friend/friendList")
	public String friendList(ModelMap modelMap, HttpServletRequest request, HttpServletResponse response)
	{
		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME); 
		String searchType = HttpUtil.get(request, "searchType", ""); // 조회항목 ( 0 : 전체, 1 : 아이디, 2 : 닉네임, 3 : 이메일 )
		String searchValue = HttpUtil.get(request, "searchValue", ""); // 조회값
		String listType = HttpUtil.get(request, "listType", "0"); // 조회할 친구 리스트 ( 0 : 일반 유저 목록, 1 : 친구 요청 받은 목록, 2 : 친구 요청 보낸 목록, 3: 내 친구 목록 )
		String relationalType = HttpUtil.get(request, "relationalType", "0"); // 요청 구분 ( 0 : 친구, 1 : 연인 )
		List<Friend> friendList = null; // 게시물 리스트	
		Friend search = new Friend(); // 검색 조건 객체 선언
		if(!StringUtil.isEmpty(searchType) && !StringUtil.isEmpty(searchValue))
		{
			search.setSearchType(searchType);
			search.setSearchValue(searchValue);
		}
		search.setUserId(cookieUserId);
		if(StringUtil.equals(listType, "1"))
		{
			friendList = friendService.requestForMeList(search);
		}
		else if(StringUtil.equals(listType, "2"))
		{
			friendList = friendService.requestForYouList(search);			
		}
		else if(StringUtil.equals(listType, "3"))
		{
			friendList = friendService.myFriendList(search);
		}
		else
		{
			friendList = friendService.friendList(search);
		}
		modelMap.addAttribute("list", friendList);
		modelMap.addAttribute("searchType", searchType);
		modelMap.addAttribute("searchValue", searchValue);
		modelMap.addAttribute("listType", listType);
		modelMap.addAttribute("relationalType", relationalType);	
		return "/friend/friendList"; 
	}
	
	@RequestMapping(value="/friend/yourPage")
	public String yourPage(ModelMap modelMap, HttpServletRequest request, HttpServletResponse response)
	{
		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		String searchType = HttpUtil.get(request, "searchType", ""); // 조회항목 0. 전체 1. 아이디, 2. 닉네임, 3. 이메일	
		String searchValue = HttpUtil.get(request, "searchValue", ""); // 조회값
		String listType = HttpUtil.get(request, "listType", "0"); // 조회할 친구 리스트 0 : 일반 유저 목록, 1 : 친구 요청 받은 목록, 2 : 친구 요청 보낸 목록, 3: 내 친구 목록
		String relationalType = HttpUtil.get(request, "relationalType", "0");
		String yourId =  HttpUtil.get(request, "yourId", ""); // 상대방 아이디
		modelMap.addAttribute("listType", listType);
		modelMap.addAttribute("searchType", searchType);
		modelMap.addAttribute("searchValue", searchValue);
		modelMap.addAttribute("relationalType", relationalType);	
		if(!StringUtil.equals(cookieUserId, yourId) && !StringUtil.isEmpty(yourId))
		{
			HashMap<String, String> hashMap = new HashMap<String, String>();
			hashMap.put("userId", cookieUserId);
			hashMap.put("yourId", yourId);
			Friend friend = friendService.selectYourUser(hashMap);
			if(friend != null)
			{
				modelMap.addAttribute("friend", friend);
			}
			else
			{
				return "/friend/friendList"; 
			}
		}
		else
		{
			return "/friend/friendList"; 
		}
		return "/friend/yourPage"; 
	}

	@RequestMapping(value="/friend/deleteFriend", method=RequestMethod.POST)
	@ResponseBody
	public Response<Object> deleteFriend(HttpServletRequest request, HttpServletResponse response)
	{
		Response<Object> ajaxResponse = new Response<Object>();
		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		String yourId = HttpUtil.get(request, "yourId", "");
		String status = HttpUtil.get(request, "status", "");
		long relationalSeq = HttpUtil.get(request, "relationalSeq", (long)0);	
		if(!StringUtil.isEmpty(cookieUserId) && !StringUtil.isEmpty(yourId) && !StringUtil.isEmpty(status))
		{
			if(!StringUtil.equals(cookieUserId, yourId))
			{
				HashMap<String, String> hashMap = new HashMap<String, String>();
				hashMap.put("userId", cookieUserId);
				hashMap.put("yourId", yourId);
				if(StringUtil.equals(status, friendService.selectYourUser(hashMap).getStatus()))
				{
					if(friendService.deleteFriend(relationalSeq) > 0)
					{
						ajaxResponse.setResponse(0, "Success", "친구 끊기에 성공하였습니다.");
					}
					else
					{
						ajaxResponse.setResponse(500, "DB Sever Error", "서버에서 오류가 발생하였습니다. 다시 시도해 주세요.");
					}
				}
				else
				{
					ajaxResponse.setResponse(404, "Not Found", "해당 사용자와 친구가 아니거나 해당 사용자가 존재하지 않습니다.");	
				}
			}
			else
			{
				ajaxResponse.setResponse(100, "Same User", "같은 사용자 입니다.");	
			}
		}
		else
		{
			ajaxResponse.setResponse(400, "Bad Request", "입력 값이 올바르지 않습니다.");			
		}
		return ajaxResponse;
	}
	
	
	@RequestMapping(value="/friend/requestFriend", method=RequestMethod.POST)
	@ResponseBody
	public Response<Object> requestFriend(HttpServletRequest request, HttpServletResponse response)
	{
		Response<Object> ajaxResponse = new Response<Object>();
		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		String yourId = HttpUtil.get(request, "yourId", "");
		String status = HttpUtil.get(request, "status", "");
		if(!StringUtil.isEmpty(cookieUserId) && !StringUtil.isEmpty(yourId) && !StringUtil.isEmpty(status))
		{
			if(!StringUtil.equals(cookieUserId, yourId))
			{
				if(friendService.selectUser(yourId) != null)
				{
					Friend requestFriend = new Friend();
					requestFriend.setUserId(cookieUserId);
					requestFriend.setYourId(yourId);
					requestFriend.setRelationalType("0");
					requestFriend.setStatus("N");		
					if(friendService.requestFriend(requestFriend) > 0)
					{
						ajaxResponse.setResponse(0, "Success", "친구 요청에 성공하였습니다.");
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
				ajaxResponse.setResponse(100, "Same User", "같은 사용자 입니다.");	
			}
		}
		else
		{
			ajaxResponse.setResponse(400, "Bad Request", "입력 값이 올바르지 않습니다.");			
		}	
		return ajaxResponse;
	}

	@RequestMapping(value="/friend/requestCouple", method=RequestMethod.POST)
	@ResponseBody
	public Response<Object> requestCouple(HttpServletRequest request, HttpServletResponse response)
	{
		Response<Object> ajaxResponse = new Response<Object>();
		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		String yourId = HttpUtil.get(request, "yourId", "");
		long relationalSeq = HttpUtil.get(request, "relationalSeq", (long)0);	
		String checkFri = HttpUtil.get(request, "checkFri", ""); // 친구 확인용 ( 0 : 친구가 아닐 경우, 1 : 친구 일 경우 )
   		String startDate = HttpUtil.get(request, "startDate", "");
   		String after100 = HttpUtil.get(request, "after100", "");
   		String after200 = HttpUtil.get(request, "after200", "");
   		String after300 = HttpUtil.get(request, "after300", "");
   		if(!StringUtil.isEmpty(cookieUserId) && !StringUtil.isEmpty(yourId) && !StringUtil.isEmpty(checkFri) && 
   			!StringUtil.isEmpty(startDate) && !StringUtil.isEmpty(after100) && !StringUtil.isEmpty(after200) && !StringUtil.isEmpty(after300))
		{
   			if(!StringUtil.equals(cookieUserId, yourId))
   			{
   				HashMap<String, String> search = new HashMap<String, String>();
				search.put("userId", cookieUserId);
				search.put("yourId", yourId);
				CoupleAnniversary coupleAnniversary = new CoupleAnniversary();
				coupleAnniversary.setStartDate(startDate);
				coupleAnniversary.setDay100(after100);
				coupleAnniversary.setDay200(after200);
				coupleAnniversary.setDay300(after300);
				coupleAnniversary.setStatus("N");
   				if(StringUtil.equals(checkFri, "0")) // 그냥 연인 등록
   	   			{
   					if(friendService.selectUser(yourId) != null)
   					{
	   					if(friendService.coupleSelect(search) > 0)
	   					{
							ajaxResponse.setResponse(500, "Already Haved Couple", "이미 등록한 커플이 있습니다. 확인 후 다시 시도해주세요.");
	   					}
	   					else
	   					{
	   						Friend requestCouple = new Friend();
	   						requestCouple.setUserId(cookieUserId);
	   						requestCouple.setYourId(yourId);
	   						requestCouple.setRelationalType("1");
	   						requestCouple.setStatus("N");
	   						try 
	   						{
								if(friendService.requestCouple(requestCouple, coupleAnniversary) > 0)
								{
									ajaxResponse.setResponse(0, "Success", "연인 요청에 성공하였습니다.");
								}
								else 
								{
									ajaxResponse.setResponse(500, "DB Sever Error", "서버에서 오류가 발생하였습니다. 다시 시도해 주세요.");
								}
							} 
	   						catch (Exception e) 
	   						{
	   							logger.error("[FriendController](requestCouple)", e);
							}
	   					}
   					}
   					else
   					{
   						ajaxResponse.setResponse(404, "Not Found", "해당 사용자가 존재하지 않습니다.");
   					}
   	   			}
   	   			else if(StringUtil.equals(checkFri, "1")) // 친구 상태에서 연인 등록
   	   			{
   	   				if(friendService.selectUser(yourId) != null)
					{
	   					if(friendService.coupleSelect(search) > 0)
	   					{
							ajaxResponse.setResponse(500, "Already Haved Couple", "이미 등록한 커플이 있습니다. 확인 후 다시 시도해주세요.");
	   					}
	   					else
	   					{
	   						try 
	   						{
	   							if(relationalSeq > 0)
	   							{
	   								coupleAnniversary.setRelationalSeq(relationalSeq);
									if(friendService.changeCouple(relationalSeq, coupleAnniversary) > 0)
									{
										ajaxResponse.setResponse(0, "Success", "연인 요청에 성공하였습니다.");
									}
									else 
									{
										ajaxResponse.setResponse(500, "DB Sever Error", "서버에서 오류가 발생하였습니다. 다시 시도해 주세요.");
									}
	   							}
	   							else
	   							{
	   								ajaxResponse.setResponse(400, "Bad Request", "입력 값이 올바르지 않습니다.");
	   							}
							} 
	   						catch (Exception e) 
	   						{
	   							logger.error("[FriendController](requestCouple)", e);
							}
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
   			}
   			else
   			{
				ajaxResponse.setResponse(100, "Same User", "같은 사용자 입니다.");
   			}
		}
   		else
   		{
			ajaxResponse.setResponse(400, "Bad Request", "입력 값이 올바르지 않습니다.");	
   		}
		return ajaxResponse;
	}
	
	@RequestMapping(value="/friend/cancleFriend", method=RequestMethod.POST)
	@ResponseBody
	public Response<Object> cancleFriend(HttpServletRequest request, HttpServletResponse response)
	{
		Response<Object> ajaxResponse = new Response<Object>();
		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		String yourId = HttpUtil.get(request, "yourId", "");
		String status = HttpUtil.get(request, "status", "");
		long relationalSeq = HttpUtil.get(request, "relationalSeq", (long)0);	
		if(relationalSeq > 0)
		{
			if(!StringUtil.equals(cookieUserId, yourId))
			{
				HashMap<String, String> hashMap = new HashMap<String, String>();
				hashMap.put("userId", cookieUserId);
				hashMap.put("yourId", yourId);
				if(StringUtil.equals(status, friendService.selectYourUser(hashMap).getStatus()))
				{
					if(friendService.deleteFriend(relationalSeq) > 0)
					{
						ajaxResponse.setResponse(0, "Success", "친구 요청 취소에 성공하였습니다.");
					}
					else
					{
						ajaxResponse.setResponse(500, "DB Sever Error", "서버에서 오류가 발생하였습니다. 다시 시도해 주세요.");
					}
				}
				else
				{
					ajaxResponse.setResponse(404, "Not Found", "해당 사용자가 요청을 받았거나 해당 사용자가 존재하지 않습니다.");	
				}
			}
			else
			{
				ajaxResponse.setResponse(100, "Same User", "같은 사용자 입니다.");	
			}
		}
		else
		{
			ajaxResponse.setResponse(400, "Bad Request", "입력 값이 올바르지 않습니다.");			
		}
		return ajaxResponse;
	}
	
	@RequestMapping(value="/friend/refuseFriend", method=RequestMethod.POST)
	@ResponseBody
	public Response<Object> refuseFriend(HttpServletRequest request, HttpServletResponse response)
	{
		Response<Object> ajaxResponse = new Response<Object>();
		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		String yourId = HttpUtil.get(request, "yourId", "");
		String status = HttpUtil.get(request, "status", "");
		long relationalSeq = HttpUtil.get(request, "relationalSeq", (long)0);
		if(!StringUtil.isEmpty(cookieUserId) && !StringUtil.isEmpty(yourId) && !StringUtil.isEmpty(status) && relationalSeq > 0)
		{
			if(!StringUtil.equals(cookieUserId, yourId)) 
			{
				if(friendService.selectUser(yourId) != null)
				{
					if(StringUtil.equals(friendService.selectStatus(relationalSeq), status))
					{
						if(friendService.refuseFriend(relationalSeq) > 0)
						{
							ajaxResponse.setResponse(0, "Success", "친구 거절에 성공하였습니다.");
						}
						else
						{
							ajaxResponse.setResponse(500, "DB Sever Error", "서버에서 오류가 발생하였습니다. 다시 시도해 주세요.");
						}
					}
					else
					{
						ajaxResponse.setResponse(404, "Not Found", "해당 사용자가 요청을 취소했습니다.");	
					}
					
				}
				else
				{
					ajaxResponse.setResponse(404, "Not Found", "해당 사용자가 존재하지 않습니다.");	
				}
			}
			else
			{
				ajaxResponse.setResponse(100, "Same User", "같은 사용자 입니다.");	
			}
		}
		else
		{
			ajaxResponse.setResponse(400, "Bad Request", "입력 값이 올바르지 않습니다.");	
		}
		return ajaxResponse;
	}
	
	@RequestMapping(value="/friend/acceptFriend", method=RequestMethod.POST)
	@ResponseBody
	public Response<Object> acceptFriend(HttpServletRequest request, HttpServletResponse response)
	{
		Response<Object> ajaxResponse = new Response<Object>();
		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		String yourId = HttpUtil.get(request, "yourId", "");
		String status = HttpUtil.get(request, "status", "");
		long relationalSeq = HttpUtil.get(request, "relationalSeq", (long)0);
		if(!StringUtil.isEmpty(cookieUserId) && !StringUtil.isEmpty(yourId) && !StringUtil.isEmpty(status) && relationalSeq > 0)
		{
			if(!StringUtil.equals(cookieUserId, yourId)) 
			{
				if(friendService.selectUser(yourId) != null)
				{
					if(StringUtil.equals(friendService.selectStatus(relationalSeq), status))
					{
						if(friendService.acceptFriend(relationalSeq) > 0)
						{
							ajaxResponse.setResponse(0, "Success", "친구 요청 수락에 성공하였습니다.");
						}
						else
						{
							ajaxResponse.setResponse(500, "DB Sever Error", "서버에서 오류가 발생하였습니다. 다시 시도해 주세요.");
						}
					}
					else
					{
						ajaxResponse.setResponse(404, "Not Found", "해당 사용자가 요청을 취소했습니다.");	
					}
				}
				else
				{
					ajaxResponse.setResponse(404, "Same User", "해당 사용자가 존재하지 않습니다.");	
				}
			}
			else
			{
				ajaxResponse.setResponse(100, "Same User", "같은 사용자 입니다.");	
			}
		}
		else
		{
			ajaxResponse.setResponse(400, "Bad Request", "입력 값이 올바르지 않습니다.");	
		}
		return ajaxResponse;
	} 
	
	@RequestMapping(value="/friend/acceptCouple", method=RequestMethod.POST)
	@ResponseBody
	public Response<Object> acceptCouple(HttpServletRequest request, HttpServletResponse response)
	{
		Response<Object> ajaxResponse = new Response<Object>();
		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		String yourId = HttpUtil.get(request, "yourId", "");
		String status = HttpUtil.get(request, "status", "");
		long relationalSeq = HttpUtil.get(request, "relationalSeq", (long)0);
		if(!StringUtil.isEmpty(cookieUserId) && !StringUtil.isEmpty(yourId) && !StringUtil.isEmpty(status) && relationalSeq > 0)
		{
			if(!StringUtil.equals(cookieUserId, yourId)) 
			{
				HashMap<String, String> hashMap = new HashMap<String, String>();
				hashMap.put("userId", cookieUserId);
				hashMap.put("yourId", yourId);
				Friend friend = friendService.selectYourUser(hashMap);
				if(friend != null && StringUtil.equals(friend.getStatus(), status) && StringUtil.equals(friend.getRelationalType(), "1"))
				{
					try 
					{
						if(friendService.acceptCouple(relationalSeq) > 0)
						{
							ajaxResponse.setResponse(0, "Success", "연인 요청 수락에 성공하였습니다.");
						}
						else
						{
							ajaxResponse.setResponse(500, "DB Sever Error", "서버에서 오류가 발생하였습니다. 다시 시도해 주세요.");
						}
					}
					catch (Exception e) 
					{
						logger.error("[FriendController](acceptCouple)", e);
					}
				}
				else
				{
					ajaxResponse.setResponse(404, "Not Found", "해당 사용자가 요청을 취소했거나 해당 사용자가 존재하지 않습니다.");	
				}
			}
			else
			{
				ajaxResponse.setResponse(100, "Same User", "같은 사용자 입니다.");	
			}
		}
		else
		{
			ajaxResponse.setResponse(400, "Bad Request", "입력 값이 올바르지 않습니다.");	
		}
		return ajaxResponse;
	}
	
	@RequestMapping(value="/friend/deleteCouple", method=RequestMethod.POST)
	@ResponseBody
	public Response<Object> deleteCouple(HttpServletRequest request, HttpServletResponse response)
	{
		Response<Object> ajaxResponse = new Response<Object>();
		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		String yourId = HttpUtil.get(request, "yourId", "");
		String status = HttpUtil.get(request, "status", "");
		long relationalSeq = HttpUtil.get(request, "relationalSeq", (long)0);
		if(!StringUtil.isEmpty(cookieUserId) && !StringUtil.isEmpty(yourId) && !StringUtil.isEmpty(status) && relationalSeq > 0)
		{
			if(!StringUtil.equals(cookieUserId, yourId)) 
			{
				HashMap<String, String> hashMap = new HashMap<String, String>();
				hashMap.put("userId", cookieUserId);
				hashMap.put("yourId", yourId);
				Friend friend = friendService.selectYourUser(hashMap);
				if(friend != null && StringUtil.equals(friend.getStatus(), status) && StringUtil.equals(friend.getRelationalType(), "1"))
				{
					try 
					{
						if(friendService.deleteCouple(relationalSeq) > 0)
						{
							ajaxResponse.setResponse(0, "Success", "연인 끊기에 성공하였습니다.");
						}
						else
						{
							ajaxResponse.setResponse(500, "DB Sever Error", "서버에서 오류가 발생하였습니다. 다시 시도해 주세요.");
						}
					}
					catch (Exception e) 
					{
						logger.error("[FriendController](deleteCouple)", e);
					}
				}
				else
				{
					ajaxResponse.setResponse(404, "Not Found", "해당 사용자가 친구를 끊었거나, 해당 사용자가 존재하지 않습니다.");	
				}
			}
			else
			{
				ajaxResponse.setResponse(100, "Same User", "같은 사용자 입니다.");	
			}
		}
		else
		{
			ajaxResponse.setResponse(400, "Bad Request", "입력 값이 올바르지 않습니다.");	
		}
		return ajaxResponse;
	}
	
	@RequestMapping(value="/friend/refuseCouple", method=RequestMethod.POST)
	@ResponseBody
	public Response<Object> refuseCouple(HttpServletRequest request, HttpServletResponse response)
	{
		Response<Object> ajaxResponse = new Response<Object>();
		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		String yourId = HttpUtil.get(request, "yourId", "");
		String status = HttpUtil.get(request, "status", "");
		long relationalSeq = HttpUtil.get(request, "relationalSeq", (long)0);
		if(!StringUtil.isEmpty(cookieUserId) && !StringUtil.isEmpty(yourId) && !StringUtil.isEmpty(status) && relationalSeq > 0)
		{
			if(!StringUtil.equals(cookieUserId, yourId)) 
			{
				HashMap<String, String> hashMap = new HashMap<String, String>();
				hashMap.put("userId", cookieUserId);
				hashMap.put("yourId", yourId);
				Friend friend = friendService.selectYourUser(hashMap);
				if(friend != null && StringUtil.equals(friend.getStatus(), status) && StringUtil.equals(friend.getRelationalType(), "1"))
				{
					try 
					{
						if(friendService.refuseCouple(relationalSeq) > 0)
						{
							ajaxResponse.setResponse(0, "Success", "연인 요청 거절에 성공하였습니다.");
						}
						else
						{
							ajaxResponse.setResponse(500, "DB Sever Error", "서버에서 오류가 발생하였습니다. 다시 시도해 주세요.");
						}
					}
					catch (Exception e) 
					{
						logger.error("[FriendController](refuseCouple)", e);
					}
				}
				else
				{
					ajaxResponse.setResponse(404, "Not Found", "해당 사용자가 요청을 취소했거나 해당 사용자가 존재하지 않습니다.");	
				}
			}
			else
			{
				ajaxResponse.setResponse(100, "Same User", "같은 사용자 입니다.");	
			}
		}
		else
		{
			ajaxResponse.setResponse(400, "Bad Request", "입력 값이 올바르지 않습니다.");	
		}
		return ajaxResponse;
	}
	
	@RequestMapping(value="/friend/cancleCouple", method=RequestMethod.POST)
	@ResponseBody
	public Response<Object> cancleCouple(HttpServletRequest request, HttpServletResponse response)
	{
		Response<Object> ajaxResponse = new Response<Object>();
		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		String yourId = HttpUtil.get(request, "yourId", "");
		String status = HttpUtil.get(request, "status", "");
		long relationalSeq = HttpUtil.get(request, "relationalSeq", (long)0);
		if(!StringUtil.isEmpty(cookieUserId) && !StringUtil.isEmpty(yourId) && !StringUtil.isEmpty(status) && relationalSeq > 0)
		{
			if(!StringUtil.equals(cookieUserId, yourId)) 
			{
				HashMap<String, String> hashMap = new HashMap<String, String>();
				hashMap.put("userId", cookieUserId);
				hashMap.put("yourId", yourId);
				Friend friend = friendService.selectYourUser(hashMap);
				if(friend != null && StringUtil.equals(friend.getStatus(), status) && StringUtil.equals(friend.getRelationalType(), "1"))
				{
					try 
					{
						if(friendService.cancleCouple(relationalSeq) > 0)
						{
							ajaxResponse.setResponse(0, "Success", "연인 요청 취소에 성공하였습니다.");
						}
						else
						{
							ajaxResponse.setResponse(500, "DB Sever Error", "서버에서 오류가 발생하였습니다. 다시 시도해 주세요.");
						}
					}
					catch (Exception e) 
					{
						logger.error("[FriendController](refuseCouple)", e);
					}
				}
				else
				{
					ajaxResponse.setResponse(404, "Not Found", "해당 사용자가 요청을 수락했거나 해당 사용자가 존재하지 않습니다.");	
				}
			}
			else
			{
				ajaxResponse.setResponse(100, "Same User", "같은 사용자 입니다.");	
			}
		}
		else
		{
			ajaxResponse.setResponse(400, "Bad Request", "입력 값이 올바르지 않습니다.");	
		}
		return ajaxResponse;
	}	
}