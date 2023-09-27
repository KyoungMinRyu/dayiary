package com.icia.web.controller;

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
import com.icia.web.model.Paging;
import com.icia.web.model.Response;
import com.icia.web.model.Seller;
import com.icia.web.model.UserG2;
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
   public String  adminManageSellerUpdate(ModelMap model, HttpServletRequest request, HttpServletResponse response)
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
}