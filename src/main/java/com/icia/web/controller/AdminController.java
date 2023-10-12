package com.icia.web.controller;


import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
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
import com.icia.web.model.Admin;
import com.icia.web.model.Paging;
import com.icia.web.model.Response;
import com.icia.web.model.Seller;
import com.icia.web.model.UserG2;
import com.icia.web.model.UserProfileFile;
import com.icia.web.service.AdminService;
import com.icia.web.util.CookieUtil;
import com.icia.web.util.HttpUtil;
import com.icia.web.util.JsonUtil;

@Controller("adminController")
public class AdminController 
{
   private static Logger logger = LoggerFactory.getLogger(AdminController.class);
   
   @Autowired
   private AdminService adminService;   
   
   private static final int LIST_COUNT = 10;
   private static final int PAGE_COUNT = 5;
   
   // 쿠키명
   @Value("#{env['auth.cookie.name']}")
   private String AUTH_COOKIE_NAME;


   private LocalDateTime localDateTime = LocalDateTime.now();
	
   //유저 관리 페이지
   @RequestMapping(value="/admin/adminManageUserList")
   public String adminManageUserList(ModelMap model, HttpServletRequest request, HttpServletResponse response)
   {
      String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
      
      if(cookieUserId != null && StringUtil.equals(cookieUserId, "adm"))
      {   
         String status = HttpUtil.get(request, "status");
         String searchType = HttpUtil.get(request, "searchType");
         String searchValue = HttpUtil.get(request, "searchValue");
         int curPage = HttpUtil.get(request, "curPage", 1);
         int totalCount = 0;
         Paging paging = null;
         List<UserG2> list = null;
         UserG2 param = new UserG2();
      
         param.setStatus(status);
         
         if(!StringUtil.isEmpty(searchType) && !StringUtil.isEmpty(searchValue))
         {
            if(StringUtil.equals(searchType, "1"))
            {
               param.setUserId(searchValue);
            }
            else if(StringUtil.equals(searchType, "2"))
            {
               param.setUserName(searchValue);
            }
            else
            {
               searchType = "";
               searchValue = "";
            }
         }
         else
         {
            searchType = "";
            searchValue = "";
         }
         
         totalCount = adminService.userListCount(param);
         
         if(totalCount > 0)
         {
            paging = new Paging("/admin/adminManageUserList", totalCount, LIST_COUNT, PAGE_COUNT, curPage, "curPage");
            
            param.setStartRow(paging.getStartRow());
            param.setEndRow(paging.getEndRow());
            
            list = adminService.userList(param);
         }
         
         model.addAttribute("list", list);
         model.addAttribute("searchType", searchType);
         model.addAttribute("searchValue", searchValue);
         model.addAttribute("status", status);
         model.addAttribute("curPage", curPage);
         model.addAttribute("paging", paging);
         
         return "/admin/adminManageUserList";
      }
      else
      { 
         return "/index";
      }
   }
   
   //유저조회 수정
   @RequestMapping(value="/admin/adminManageUserUpdate")
   public String  adminManageUserUpdate(ModelMap model, HttpServletRequest request, HttpServletResponse response)
   {
      //유저아이디
      String userId = HttpUtil.get(request, "userId");
      
      if(!StringUtil.isEmpty(userId))
      {
         UserG2 user = adminService.userSelect(userId);
         
         if(!StringUtil.isEmpty(user.getUserGen()) && StringUtil.equals(user.getUserGen(), "0"))
         {
            user.setUserGen("남");
         }
         else
         {
            user.setUserGen("여");
         }
         if(user != null)
         {
            model.addAttribute("user", user);         
         }
      }   
         
      return "/admin/adminManageUserUpdate"; 
   }
   

   //유저정보 수정
   @RequestMapping(value="/admin/adminManageUserUpdateProc", method=RequestMethod.POST)
   @ResponseBody
   public Response<Object> adminManageUserUpdateProc(HttpServletRequest request, HttpServletResponse response)
   {
      Response<Object> res = new Response<Object>();
      
      String userId = HttpUtil.get(request, "userId");
      String userPwd = HttpUtil.get(request, "userPwd");
      String userEmail = HttpUtil.get(request, "userEmail");
      String userName = HttpUtil.get(request, "userName");
      String userNickName = HttpUtil.get(request, "userNickName");
      String userPh = HttpUtil.get(request, "userPh");
      String userGen = HttpUtil.get(request, "userGen");
      String userBir = HttpUtil.get(request, "userBir");
      String status = HttpUtil.get(request,    "status");
      String regDate = HttpUtil.get(request,    "regDate");
      String updateDate = HttpUtil.get(request, "updateDate");
      String userAddress = HttpUtil.get(request, "userAddress");
      
      if(!StringUtil.isEmpty(userId) && !StringUtil.isEmpty(userPwd) && !StringUtil.isEmpty(userEmail) && !StringUtil.isEmpty(userName) 
            && !StringUtil.isEmpty(userNickName) && !StringUtil.isEmpty(userPh) && !StringUtil.isEmpty(userGen) && !StringUtil.isEmpty(userBir)
            && !StringUtil.isEmpty(status) && !StringUtil.isEmpty(regDate) && !StringUtil.isEmpty(updateDate) && !StringUtil.isEmpty(userAddress))
      {
         UserG2 user = adminService.userSelect(userId);
         
         if(user != null)
         {
            user.setUserId(userId);
            user.setUserPwd(userPwd);
            user.setUserEmail(userEmail);
            user.setUserName(userName);
            user.setUserNickName(userNickName);
            user.setUserPh(userPh);
            user.setUserGen(userGen);
            user.setUserBir(userBir);
            user.setStatus(status);
            user.setregDate(regDate);
            user.setUpdateDate(updateDate);
            user.setUserAddress(userAddress);
            
            if(adminService.userUpdate(user) > 0)
            {
               res.setResponse(0, "success");
            }
            else
            {
               res.setResponse(-1, "fail");
            }
         }
         else
         {
            res.setResponse(404, "not found");   //사용자 정보 없음.
         }
      }
      else
      {
         res.setResponse(400, "bad request");
      }
      
      if(logger.isDebugEnabled()) 
      {
         logger.debug("[AdminController] /adminManageUserUpdateProc response\n" +JsonUtil.toJsonPretty(res));
      }
      
      return res;
   }
   
 //유저 프로필 사진 삭제
   @RequestMapping(value="/admin/adminManageUserProfileDelete", method=RequestMethod.POST)
   @ResponseBody
   public Response<Object> adminManageUserProfileDelete(HttpServletRequest request, HttpServletResponse response)
   {
      Response<Object> ajaxResponse = new Response<Object>();
      String userId = HttpUtil.get(request, "userId", "");
      String fileName = HttpUtil.get(request, "fileName", "");
      
      
      if(userId != "" && userId != null && fileName != "" && fileName != null)
      {
          UserProfileFile userProfileFile = adminService.adminManageUserProfileSelect(fileName);
            
          if(userProfileFile != null)
          {
             if((StringUtil.equals(userProfileFile.getUserId(), userId)) && (StringUtil.equals(userProfileFile.getFileName(), fileName)))
            {
                   if(adminService.adminManageUserProfileDelete(userId, fileName) > -1)
                  {
                     ajaxResponse.setResponse(0, "success");
                  }
                  else
                  {
                     ajaxResponse.setResponse(500, "server error");
                  }
            }
             else
               {
                  ajaxResponse.setResponse(403, "server error");
               }
          }
         else
         {
            ajaxResponse.setResponse(404, "not found");
         }
      }
      else
      {
         ajaxResponse.setResponse(400, "bad request");
      }
         
      return ajaxResponse;
   }
   
   
   //판매자 관리 페이지
   @RequestMapping(value="/admin/adminManageSellerList")
   public String adminManageSellerList(ModelMap model, HttpServletRequest request, HttpServletResponse response)
   {
      String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
      
      if(cookieUserId != null && StringUtil.equals(cookieUserId, "adm"))
      {   
         String status = HttpUtil.get(request, "status");
         String searchType = HttpUtil.get(request, "searchType");
         String searchValue = HttpUtil.get(request, "searchValue");
         int curPage = HttpUtil.get(request, "curPage", 1);
         int totalCount = 0;
         Paging paging = null;
         List<Seller> list = null;
         Seller param = new Seller();
      
         param.setStatus(status);
         
         if(!StringUtil.isEmpty(searchType) && !StringUtil.isEmpty(searchValue))
         {
            if(StringUtil.equals(searchType, "1"))
            {
               param.setSellerId(searchValue);
            }
            else if(StringUtil.equals(searchType, "2"))
            {
               param.setSellerShopName(searchValue);
            }
            else
            {
               searchType = "";
               searchValue = "";
            }
         }
         else
         {
            searchType = "";
            searchValue = "";
         }
         
         totalCount = adminService.sellerListCount(param);
         
         if(totalCount > 0)
         {
            paging = new Paging("/admin/adminManageSellerList", totalCount, LIST_COUNT, PAGE_COUNT, curPage, "curPage");
            
            param.setStartRow(paging.getStartRow());
            param.setEndRow(paging.getEndRow());
            
            list = adminService.sellerList(param);
         }
         
         model.addAttribute("list", list);
         model.addAttribute("searchType", searchType);
         model.addAttribute("searchValue", searchValue);
         model.addAttribute("status", status);
         model.addAttribute("curPage", curPage);
         model.addAttribute("paging", paging);
         
         return "/admin/adminManageSellerList";
      }
      else
      { 
         return "/index";
      }
   }
   
   
   //판매자조회 수정
   @RequestMapping(value="/admin/adminManageSellerUpdate")
   public String adminManageSellerUpdate(ModelMap model, HttpServletRequest request, HttpServletResponse response)
   {
      //판매자아이디
      String sellerId = HttpUtil.get(request, "sellerId");
      
      if(!StringUtil.isEmpty(sellerId))
      {
         Seller seller = adminService.sellerSelect(sellerId);
         
         if(seller != null)
         {
            model.addAttribute("seller", seller);         
         }
      }   
         
      return "/admin/adminManageSellerUpdate"; 
   }
   
   //유저정보 수정
   @RequestMapping(value="/admin/adminManageSellerUpdateProc", method=RequestMethod.POST)
   @ResponseBody
   public Response<Object> adminManageSellerUpdateProc(HttpServletRequest request, HttpServletResponse response)
   {
      Response<Object> res = new Response<Object>();
      
      String sellerId = HttpUtil.get(request, "sellerId");
      String sellerBusinessId = HttpUtil.get(request, "sellerBusinessId");
      String sellerEmail = HttpUtil.get(request, "sellerEmail");
      String sellerPwd = HttpUtil.get(request, "sellerPwd");
      String sellerShopName = HttpUtil.get(request, "sellerShopName");
      String sellerPh = HttpUtil.get(request, "sellerPh");
      String sellerAddress = HttpUtil.get(request, "sellerAddress");
      String status = HttpUtil.get(request, "status");
      String regDate = HttpUtil.get(request, "regDate");
   
      
      if(!StringUtil.isEmpty(sellerId) && !StringUtil.isEmpty(sellerBusinessId) && !StringUtil.isEmpty(sellerEmail) && !StringUtil.isEmpty(sellerPwd) 
            && !StringUtil.isEmpty(sellerShopName) && !StringUtil.isEmpty(sellerPh) && !StringUtil.isEmpty(sellerAddress) && !StringUtil.isEmpty(status)
            && !StringUtil.isEmpty(regDate))
      {
         Seller seller = adminService.sellerSelect(sellerId);
         
         if(seller != null)
         {
            seller.setSellerId(sellerId);
            seller.setSellerBusinessId(sellerBusinessId);
            seller.setSellerEmail(sellerEmail);
            seller.setSellerPwd(sellerPwd);
            seller.setSellerShopName(sellerShopName);
            seller.setSellerPh(sellerPh);
            seller.setSellerAddress(sellerAddress);
            seller.setStatus(status);
            seller.setRegDate(regDate);
            
            if(adminService.sellerUpdate(seller) > 0)
            {
               res.setResponse(0, "success");
            }
            else
            {
               res.setResponse(-1, "fail");
            }
         }
         else
         {
            res.setResponse(404, "not found");   
         }
      }
      else
      {
         res.setResponse(400, "bad request");
      }
      
      if(logger.isDebugEnabled()) 
      {
         logger.debug("[AdminController] /adminManageSellerUpdateProc response\n" +JsonUtil.toJsonPretty(res));
      }
      
      return res;
   }
   
   
   
   

   // =============================== ADMININDEX ============================================== //
   
   
   
   
   
   @RequestMapping(value="/index/adminIndex")
   public String adminIndex(ModelMap modelMap, HttpServletRequest request, HttpServletResponse response)
   {
	   	String yearMonth = localDateTime.format(DateTimeFormatter.ofPattern("yyyyMM"));
	   	List<Admin> list = adminService.selectGiftTotalRevenue();
	   	long totalCount = 0;
	   	long totalPrice = 0;
	   	Admin admin = null;
	   	for(int i = 0; i < list.size(); i++)
	   	{
	   		admin = list.get(i);
	   		totalCount += Long.parseLong(admin.getGiftTotalCnt());
	   		totalPrice += Long.parseLong(admin.getGiftTotalPrice());
	   		if(StringUtil.equals(yearMonth, admin.getGiftRegDate()))
	   		{
	   			modelMap.addAttribute("giftMonthlyTotalCount", admin.getGiftTotalCnt());
	   			modelMap.addAttribute("giftMonthlyTotalPrice", admin.getGiftTotalPrice());
	   		}
	   	}
		modelMap.addAttribute("giftTotalCount", totalCount);
		modelMap.addAttribute("giftTotalPrice", totalPrice);
		totalCount = 0;
		totalPrice = 0;
		list = adminService.selectRestoTotalRevenue();
		for(int i = 0; i < list.size(); i++)
	   	{
	   		admin = list.get(i);
	   		totalCount += Long.parseLong(admin.getRestoTotalCount());
	   		totalPrice += Long.parseLong(admin.getRestoTotalPrice());
	   		if(StringUtil.equals(yearMonth, admin.getRestoRegDate()))
	   		{
	   			modelMap.addAttribute("restoMonthlyTotalCount", admin.getRestoTotalCount());
	   			modelMap.addAttribute("restoMonthlyTotalPrice", admin.getRestoTotalPrice());
	   		}
	   	}
		modelMap.addAttribute("restoTotalCount", totalCount);
		modelMap.addAttribute("restoTotalPrice", totalPrice);
		totalCount = 0;
		
		list = adminService.selectUserTotalCount();
		for(int i = 0; i < list.size(); i++)
	   	{
	   		admin = list.get(i);
	   		totalCount += Long.parseLong(admin.getUserTotalCount());
	   		if(StringUtil.equals(yearMonth, admin.getUserRegDate()))
	   		{
	   			modelMap.addAttribute("userMonthlyTotalCount", admin.getUserTotalCount());
	   		}
	   	}
		if(modelMap.getAttribute("userMonthlyTotalCount") == null || modelMap.getAttribute("userMonthlyTotalCount") == "")
		{
   			modelMap.addAttribute("userMonthlyTotalCount", 0);
		}
		modelMap.addAttribute("userTotalCount", totalCount);
		totalCount = 0;
		
		list = adminService.selectSellerTotalCount();
		for(int i = 0; i < list.size(); i++)
	   	{
	   		admin = list.get(i);
	   		totalCount += Long.parseLong(admin.getSellerTotalCount());
	   		if(StringUtil.equals(yearMonth, admin.getSellerRegDate()))
	   		{
	   			modelMap.addAttribute("sellerMonthlyTotalCount", admin.getSellerTotalCount());
	   		}
	   	}
		if(modelMap.getAttribute("sellerMonthlyTotalCount") == null || modelMap.getAttribute("sellerMonthlyTotalCount") == "")
		{
   			modelMap.addAttribute("sellerMonthlyTotalCount", 0);
		}
		modelMap.addAttribute("sellerTotalCount", totalCount);
		
	   	return "/index/adminIndex";
   }
      
   
   
   

   // =============================== RESTO ============================================== //
   
   
   
   
   
   @RequestMapping(value="/admin/adminRestoList")
   public String adminRestoList(ModelMap modelMap, HttpServletRequest request, HttpServletResponse response)
   {
	   HashMap<String, Object> hashMap = new HashMap<String, Object>();
	   hashMap.put("startRow", 1);
	   hashMap.put("endRow", 6);
	   modelMap.addAttribute("list", adminService.selectRestoTotalRevenueList(hashMap));
	   modelMap.addAttribute("totalCount", adminService.selectRestoTotalCount(null));
	   modelMap.addAttribute("hashMap", hashMap);
	   return "/admin/adminRestoList";   
   }
   
   @RequestMapping(value="/admin/getRestoTotalRevenueList", method=RequestMethod.POST)
   @ResponseBody
   public Response<Object> getRestoTotalRevenueList(HttpServletRequest request, HttpServletResponse response)
   {
	   Response<Object> ajaxResponse = new Response<Object>();
	   int startRow = HttpUtil.get(request, "startRow", 0);
	   int endRow = HttpUtil.get(request, "endRow", 0);
	   String searchValue = HttpUtil.get(request, "searchValue", "");
	   if(startRow > 0 && endRow > 0)
	   {
		   HashMap<String, Object> hashMap = new HashMap<String, Object>();
		   hashMap.put("startRow", startRow);
		   hashMap.put("endRow", endRow);
		   hashMap.put("searchValue", searchValue);
		   ajaxResponse.setResponse(0, "Success", adminService.selectRestoTotalRevenueList(hashMap));
	   }
	   else
	   {
		   ajaxResponse.setResponse(400, "Bad Request");
	   }
	   return ajaxResponse;
   }
   

   @RequestMapping(value="/admin/getRestoTotalCount", method=RequestMethod.POST)
   @ResponseBody
   public Response<Object> getRestoTotalCount(HttpServletRequest request, HttpServletResponse response)
   {
	   Response<Object> ajaxResponse = new Response<Object>();
	   String searchValue = HttpUtil.get(request, "searchValue", "");
	   ajaxResponse.setResponse(0, "Success", adminService.selectRestoTotalCount(searchValue));
	   return ajaxResponse;
   }
   
   @RequestMapping(value="/admin/adminRestoView")
   public String adminRestoView(ModelMap modelMap, HttpServletRequest request, HttpServletResponse response)
   {
	   String rSeq = HttpUtil.get(request, "rSeq", "");
	   modelMap.addAttribute("resto", adminService.selectAdminRestoView(rSeq));
	   modelMap.addAttribute("reviewList", adminService.selectRestoReviewList(rSeq));
	   return "/admin/adminRestoView";   
   }
   
   @RequestMapping(value="/admin/updateRestoText", method=RequestMethod.POST)
   @ResponseBody
   public Response<Object> updateRestoText(HttpServletRequest request, HttpServletResponse response)
   {
	   Response<Object> ajaxResponse = new Response<Object>();
	   String cookieAdminId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
	   String changeText = HttpUtil.get(request, "changeText", "");
	   String rSeq = HttpUtil.get(request, "rSeq", "");
	   int type = HttpUtil.get(request, "type", -1);
	   if(!StringUtil.isEmpty(changeText) && !StringUtil.isEmpty(rSeq) && type >= 0)
	   {
		   if(StringUtil.equals(cookieAdminId, "adm"))
		   {
			   if(type == 0 || type == 1)
			   {
				   HashMap<String, Object> hashMap = new HashMap<String, Object>();
				   hashMap.put("rSeq", rSeq);
				   hashMap.put("changeText", changeText);
				   hashMap.put("type", type);
				   if(adminService.updateRestoText(hashMap) > 0)
				   {
					   ajaxResponse.setResponse(0, "Success");
				   }
				   else
				   {
					   ajaxResponse.setResponse(500, "DB Server Error");
				   }
			   }
			   else 
			   {
				   ajaxResponse.setResponse(400, "Bad Request");
			   }
		   }
		   else
		   {
			   ajaxResponse.setResponse(404, "Not Found");
		   }
	   }
	   else
	   {
		   ajaxResponse.setResponse(400, "Bad Request");
	   }
	   return ajaxResponse;
   }
   
   @RequestMapping(value="/admin/updateMenuText", method=RequestMethod.POST)
   @ResponseBody
   public Response<Object> updateMenuText(HttpServletRequest request, HttpServletResponse response)
   {
	   Response<Object> ajaxResponse = new Response<Object>();
	   String cookieAdminId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
	   String changeText = HttpUtil.get(request, "changeText", "");
	   String menuSeq = HttpUtil.get(request, "menuSeq", "");
	   int type = HttpUtil.get(request, "type", -1);
	   if(!StringUtil.isEmpty(changeText) && !StringUtil.isEmpty(menuSeq) && type >= 0)
	   {
		   if(StringUtil.equals(cookieAdminId, "adm"))
		   {
			   if(type == 0 || type == 1)
			   {
				   HashMap<String, Object> hashMap = new HashMap<String, Object>();
				   hashMap.put("menuSeq", menuSeq);
				   hashMap.put("changeText", changeText);
				   hashMap.put("type", type);
				   if(adminService.updateMenuText(hashMap) > 0)
				   {
					   ajaxResponse.setResponse(0, "Success");
				   }
				   else
				   {
					   ajaxResponse.setResponse(500, "DB Server Error");
				   }
			   }
			   else 
			   {
				   ajaxResponse.setResponse(400, "Bad Request");
			   }
		   }
		   else
		   {
			   ajaxResponse.setResponse(404, "Not Found");
		   }
	   }
	   else
	   {
		   ajaxResponse.setResponse(400, "Bad Request");
	   }
	   return ajaxResponse;
   }
   
   @RequestMapping(value="/admin/updateRestoImages", method=RequestMethod.POST)
   @ResponseBody
   public Response<Object> updateRestoImages(HttpServletRequest request, HttpServletResponse response)
   {
	   Response<Object> ajaxResponse = new Response<Object>();
	   String cookieAdminId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
	   String rSeq = HttpUtil.get(request, "rSeq", "");
	   short fileSeq = HttpUtil.get(request, "fileSeq", (short)0);
	   
	   if(!StringUtil.isEmpty(rSeq) && fileSeq > 0)
	   {
		   if(StringUtil.equals(cookieAdminId, "adm"))
		   {
			   HashMap<String, Object> hashMap = new HashMap<String, Object>();
			   hashMap.put("rSeq", rSeq);
			   hashMap.put("fileSeq", fileSeq);
			   
			   if(adminService.updateRestoImages(hashMap) > 0)
			   {
				   ajaxResponse.setResponse(0, "Success");
			   }
			   else
			   {
				   ajaxResponse.setResponse(500, "DB Server Error");
			   }
		   }
		   else
		   {
			   ajaxResponse.setResponse(404, "Not Found");
		   }
	   }
	   else
	   {
		   ajaxResponse.setResponse(400, "Bad Request");
	   }
	   return ajaxResponse;
   }
   
   @RequestMapping(value="/admin/updateMenuImages", method=RequestMethod.POST)
   @ResponseBody
   public Response<Object> updateMenuImages(HttpServletRequest request, HttpServletResponse response)
   {
	   Response<Object> ajaxResponse = new Response<Object>();
	   String cookieAdminId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
	   String menuSeq = HttpUtil.get(request, "menuSeq", "");
	   
	   if(!StringUtil.isEmpty(menuSeq))
	   {
		   if(StringUtil.equals(cookieAdminId, "adm"))
		   {
			   
			   if(adminService.updateMenuImages(menuSeq) > 0)
			   {
				   ajaxResponse.setResponse(0, "Success");
			   }
			   else
			   {
				   ajaxResponse.setResponse(500, "DB Server Error");
			   }
		   }
		   else
		   {
			   ajaxResponse.setResponse(404, "Not Found");
		   }
	   }
	   else
	   {
		   ajaxResponse.setResponse(400, "Bad Request");
	   }
	   return ajaxResponse;
   }
   
   @RequestMapping(value="/admin/updateAdminRestoStatus", method=RequestMethod.POST)
   @ResponseBody
   public Response<Object> updateAdminRestoStatus(HttpServletRequest request, HttpServletResponse response)
   {
	   Response<Object> ajaxResponse = new Response<Object>();
	   String cookieAdminId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
	   String rSeq = HttpUtil.get(request, "rSeq", "");
	   String status = HttpUtil.get(request, "status", "");
	   
	   if(!StringUtil.isEmpty(rSeq) && !StringUtil.isEmpty(status))
	   {
		   if(StringUtil.equals(cookieAdminId, "adm"))
		   {
			   HashMap<String, String> hashMap = new HashMap<String, String>();
			   hashMap.put("rSeq", rSeq);
			   hashMap.put("status", status);
			   
			   if(adminService.updateAdminRestoStatus(hashMap) > 0)
			   {
				   ajaxResponse.setResponse(0, "Success");
			   }
			   else
			   {
				   ajaxResponse.setResponse(500, "DB Server Error");
			   }
		   }
		   else
		   {
			   ajaxResponse.setResponse(404, "Not Found");
		   }
	   }
	   else
	   {
		   ajaxResponse.setResponse(400, "Bad Request");
	   }
	   return ajaxResponse;
   }
   
   @RequestMapping(value="/admin/selectAdminRestoRevenue", method=RequestMethod.POST)
   @ResponseBody
   public Response<Object> selectAdminRestoRevenue(HttpServletRequest request, HttpServletResponse response)
   {
	   Response<Object> ajaxResponse = new Response<Object>();
	   String cookieAdminId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
	   String rSeq = HttpUtil.get(request, "rSeq", "");
	   
	   if(!StringUtil.isEmpty(rSeq))
	   {
		   if(StringUtil.equals(cookieAdminId, "adm"))
		   { 
			   ajaxResponse.setResponse(0, "Success", adminService.selectAdminRestoRevenue(rSeq));
		   }
		   else
		   {
			   ajaxResponse.setResponse(404, "Not Found");
		   }
	   }
	   else
	   {
		   ajaxResponse.setResponse(400, "Bad Request");
	   }
	   return ajaxResponse;
   }
   
   
   
   
   
   // =============================== GIFT ============================================== //

   
   
   
   
   @RequestMapping(value="/admin/adminGiftList")
   public String adminGiftList(ModelMap modelMap, HttpServletRequest request, HttpServletResponse response)
   {
	   HashMap<String, Object> hashMap = new HashMap<String, Object>();
	   hashMap.put("startRow", 1);
	   hashMap.put("endRow", 6);
	   modelMap.addAttribute("list", adminService.selectGiftTotalRevenueList(hashMap));
	   modelMap.addAttribute("totalCount", adminService.selectGiftTotalCount(null));
	   modelMap.addAttribute("hashMap", hashMap);
	   return "/admin/adminGiftList";   
   }
   
   @RequestMapping(value="/admin/getGiftTotalRevenueList", method=RequestMethod.POST)
   @ResponseBody
   public Response<Object> getGiftTotalRevenueList(HttpServletRequest request, HttpServletResponse response)
   {
	   Response<Object> ajaxResponse = new Response<Object>();
	   int startRow = HttpUtil.get(request, "startRow", 0);
	   int endRow = HttpUtil.get(request, "endRow", 0);
	   String searchValue = HttpUtil.get(request, "searchValue", "");
	   if(startRow > 0 && endRow > 0)
	   {
		   HashMap<String, Object> hashMap = new HashMap<String, Object>();
		   hashMap.put("startRow", startRow);
		   hashMap.put("endRow", endRow);
		   hashMap.put("searchValue", searchValue);
		   ajaxResponse.setResponse(0, "Success", adminService.selectGiftTotalRevenueList(hashMap));
	   }
	   else
	   {
		   ajaxResponse.setResponse(400, "Bad Request");
	   }
	   return ajaxResponse;
   }
   

   @RequestMapping(value="/admin/getGiftTotalCount", method=RequestMethod.POST)
   @ResponseBody
   public Response<Object> getGiftTotalCount(HttpServletRequest request, HttpServletResponse response)
   {
	   Response<Object> ajaxResponse = new Response<Object>();
	   String searchValue = HttpUtil.get(request, "searchValue", "");
	   ajaxResponse.setResponse(0, "Success", adminService.selectGiftTotalCount(searchValue));
	   return ajaxResponse;
   }
   
   @RequestMapping(value="/admin/adminGiftView")
   public String adminGiftView(ModelMap modelMap, HttpServletRequest request, HttpServletResponse response)
   {
	   String productSeq = HttpUtil.get(request, "productSeq", "");
	   modelMap.addAttribute("giftAdd", adminService.selectAdminGiftView(productSeq));
	   modelMap.addAttribute("reviewList", adminService.selectGiftReviewList(productSeq));
	   return "/admin/adminGiftView";   
   }
   
   
   @RequestMapping(value="/admin/updateAdminGiftStatus", method=RequestMethod.POST)
   @ResponseBody
   public Response<Object> updateAdminGiftStatus(HttpServletRequest request, HttpServletResponse response)
   {
	   Response<Object> ajaxResponse = new Response<Object>();
	   String cookieAdminId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
	   String productSeq = HttpUtil.get(request, "productSeq", "");
	   String status = HttpUtil.get(request, "status", "");
	   
	   if(!StringUtil.isEmpty(productSeq) && !StringUtil.isEmpty(status))
	   {
		   if(StringUtil.equals(cookieAdminId, "adm"))
		   {
			   HashMap<String, String> hashMap = new HashMap<String, String>();
			   hashMap.put("productSeq", productSeq);
			   hashMap.put("status", status);
			   
			   if(adminService.updateAdminGiftStatus(hashMap) > 0)
			   {
				   ajaxResponse.setResponse(0, "Success");
			   }
			   else
			   {
				   ajaxResponse.setResponse(500, "DB Server Error");
			   }
		   }
		   else
		   {
			   ajaxResponse.setResponse(404, "Not Found");
		   }
	   }
	   else
	   {
		   ajaxResponse.setResponse(400, "Bad Request");
	   }
	   return ajaxResponse;
   }
   
   @RequestMapping(value="/admin/updateGiftText", method=RequestMethod.POST)
   @ResponseBody
   public Response<Object> updateGiftText(HttpServletRequest request, HttpServletResponse response)
   {
	   Response<Object> ajaxResponse = new Response<Object>();
	   String cookieAdminId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
	   String changeText = HttpUtil.get(request, "changeText", "");
	   String productSeq = HttpUtil.get(request, "productSeq", "");
	   int type = HttpUtil.get(request, "type", -1);
	   if(!StringUtil.isEmpty(changeText) && !StringUtil.isEmpty(productSeq) && type >= 0)
	   {
		   if(StringUtil.equals(cookieAdminId, "adm"))
		   {
			   if(type == 0 || type == 1)
			   {
				   HashMap<String, Object> hashMap = new HashMap<String, Object>();
				   hashMap.put("productSeq", productSeq);
				   hashMap.put("changeText", changeText);
				   hashMap.put("type", type);
				   if(adminService.updateGiftText(hashMap) > 0)
				   {
					   ajaxResponse.setResponse(0, "Success");
				   }
				   else
				   {
					   ajaxResponse.setResponse(500, "DB Server Error");
				   }
			   }
			   else 
			   {
				   ajaxResponse.setResponse(400, "Bad Request");
			   }
		   }
		   else
		   {
			   ajaxResponse.setResponse(404, "Not Found");
		   }
	   }
	   else
	   {
		   ajaxResponse.setResponse(400, "Bad Request");
	   }
	   return ajaxResponse;
   }
   
   @RequestMapping(value="/admin/updateGiftImages", method=RequestMethod.POST)
   @ResponseBody
   public Response<Object> updateGiftImages(HttpServletRequest request, HttpServletResponse response)
   {
	   Response<Object> ajaxResponse = new Response<Object>();
	   String cookieAdminId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
	   String productSeq = HttpUtil.get(request, "productSeq", "");
	   short fileSeq = HttpUtil.get(request, "fileSeq", (short)0);
	   
	   if(!StringUtil.isEmpty(productSeq) && fileSeq > 0)
	   {
		   if(StringUtil.equals(cookieAdminId, "adm"))
		   {
			   HashMap<String, Object> hashMap = new HashMap<String, Object>();
			   hashMap.put("productSeq", productSeq);
			   hashMap.put("fileSeq", fileSeq);
			   
			   if(adminService.updateGiftImages(hashMap) > 0)
			   {
				   ajaxResponse.setResponse(0, "Success");
			   }
			   else
			   {
				   ajaxResponse.setResponse(500, "DB Server Error");
			   }
		   }
		   else
		   {
			   ajaxResponse.setResponse(404, "Not Found");
		   }
	   }
	   else
	   {
		   ajaxResponse.setResponse(400, "Bad Request");
	   }
	   return ajaxResponse;
   }
   
   @RequestMapping(value="/admin/selectAdminGiftRevenue", method=RequestMethod.POST)
   @ResponseBody
   public Response<Object> selectAdminGiftRevenue(HttpServletRequest request, HttpServletResponse response)
   {
	   Response<Object> ajaxResponse = new Response<Object>();
	   String cookieAdminId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
	   String productSeq = HttpUtil.get(request, "productSeq", "");
	   
	   if(!StringUtil.isEmpty(productSeq))
	   {
		   if(StringUtil.equals(cookieAdminId, "adm"))
		   { 
			   ajaxResponse.setResponse(0, "Success", adminService.selectAdminGiftRevenue(productSeq));
		   }
		   else
		   {
			   ajaxResponse.setResponse(404, "Not Found");
		   }
	   }
	   else
	   {
		   ajaxResponse.setResponse(400, "Bad Request");
	   }
	   return ajaxResponse;
   }
   
   @RequestMapping(value="/admin/deleteReview", method=RequestMethod.POST)
   @ResponseBody
   public Response<Object> deleteReview(HttpServletRequest request, HttpServletResponse response)
   {
	   Response<Object> ajaxResponse = new Response<Object>();
	   String cookieAdminId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
	   String orderSeq = HttpUtil.get(request, "orderSeq", "");
	   if(!StringUtil.isEmpty(orderSeq))
	   {
		   if(StringUtil.equals(cookieAdminId, "adm"))
		   { 
			   ajaxResponse.setResponse(0, "Success", adminService.deleteReview(orderSeq));
		   }
		   else
		   {
			   ajaxResponse.setResponse(404, "Not Found");
		   }
	   }
	   else
	   {
		   ajaxResponse.setResponse(400, "Bad Request");
	   }
	   return ajaxResponse;
   }
     
   
}
		