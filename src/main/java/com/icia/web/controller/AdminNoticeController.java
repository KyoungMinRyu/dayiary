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
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.icia.common.util.StringUtil;
import com.icia.web.model.AdminNotice;
import com.icia.web.model.Paging;
import com.icia.web.model.Response;
import com.icia.web.model.UserG2;
import com.icia.web.service.AdminNoticeService;
import com.icia.web.service.UserG2Service;
import com.icia.web.util.CookieUtil;
import com.icia.web.util.HttpUtil;

@Controller("adminNoticeController")

public class AdminNoticeController 
{
   private static Logger logger = LoggerFactory.getLogger(AdminNoticeController.class);
   
   //쿠키명
   @Value("#{env['auth.cookie.name']}")
   private String AUTH_COOKIE_NAME;  
   
   @Autowired
   private UserG2Service userG2Service;   
   
   @Autowired
   private AdminNoticeService adminNoticeService;
   
   private static final int LIST_COUNT = 6;   
   private static final int PAGE_COUNT = 5;   
   
   //공지 게시판 리스트
   @RequestMapping(value="/notice/adminNotice")
   public String notice(ModelMap model, HttpServletRequest request, HttpServletResponse response)
   {   
      String searchType = HttpUtil.get(request, "searchType", "");
      String searchValue = HttpUtil.get(request, "searchValue", "");
      long curPage = HttpUtil.get(request, "curPage", (long)1);
      List<AdminNotice> list = null;
      AdminNotice search = new AdminNotice();
      long totalCount = 0;
      Paging paging = null;
      String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
      //사용자 정보
      UserG2 user = userG2Service.userIdSelect(cookieUserId);
      
      
      if(!StringUtil.isEmpty(searchType) && !StringUtil.isEmpty(searchValue))
      {
         search.setSearchType(searchType);
         search.setSearchValue(searchValue);
      }
      
      totalCount = adminNoticeService.adminNoticeListCount(search);
      
      if(totalCount > 0)
      {
         paging = new Paging("/notice/adminNotice", totalCount, LIST_COUNT, PAGE_COUNT, curPage, "curPage");
         
         search.setStartRow(paging.getStartRow());
         search.setEndRow(paging.getEndRow());
         
         list = adminNoticeService.adminNoticeList(search);
      }
      
      model.addAttribute("list", list);
      model.addAttribute("searchType", searchType);
      model.addAttribute("searchValue", searchValue);
      model.addAttribute("curPage", curPage);
      model.addAttribute("paging", paging); 
      model.addAttribute("user", user);
      
      return "/notice/adminNotice";
   }
   
   //공지 게시판 등록 폼
   @RequestMapping(value="/notice/noticeWriteForm")
   public String noticeWriteForm(ModelMap model, HttpServletRequest request, HttpServletResponse response)
   {
      String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
      String searchType = HttpUtil.get(request, "searchType", "");
      String searchValue = HttpUtil.get(request, "searchValue", "");
      long curPage = HttpUtil.get(request, "curPage", (long)1);
      
      //사용자 정보 조회
      UserG2 user = userG2Service.userIdSelect(cookieUserId);
      
      model.addAttribute("user", user);
      model.addAttribute("searchType", searchType);
      model.addAttribute("searchValue", searchValue);
      model.addAttribute("curPage", curPage);
      
      return "/notice/noticeWriteForm";
   }
   
   
   //공지글 등록(ajax)
   @RequestMapping(value="/notice/noticeWriteProc", method=RequestMethod.POST)
   @ResponseBody
   public Response<Object> noticeWriteProc(MultipartHttpServletRequest request, HttpServletResponse response)
   {
      Response<Object> ajaxResponse = new Response<Object>();
      String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
      String bbsTitle = HttpUtil.get(request, "bbsTitle", "");
      String bbsContent = HttpUtil.get(request, "bbsContent", "");
      String searchSort = HttpUtil.get(request, "searchSort", "");
      
      if(!StringUtil.isEmpty(searchSort) && !StringUtil.isEmpty(bbsTitle) && !StringUtil.isEmpty(bbsContent))
      {
         AdminNotice adminNotice = new AdminNotice();
         
         adminNotice.setUserId(cookieUserId);
         adminNotice.setBbsTitle(bbsTitle);
         adminNotice.setBbsContent(bbsContent);
         
         if(StringUtil.equals(searchSort, "1"))
         {   
            searchSort = "Y";
            adminNotice.setStatus(searchSort);
         }
         else if(StringUtil.equals(searchSort, "2"))
         {
            searchSort = "N";
            adminNotice.setStatus(searchSort);
         }
         
         if(adminNoticeService.adminNoticeInsert(adminNotice) > 0)
         {
            ajaxResponse.setResponse(0, "success");
         }
         else
         {
            ajaxResponse.setResponse(500, "Interal server error");
         }
      }
      else
      {
         ajaxResponse.setResponse(400, "Bad Request");
      }
   
      return ajaxResponse;
   }
   
   //공지글 조회
   @RequestMapping(value="/notice/noticeView")
   public String noticeView(ModelMap model, HttpServletRequest request, HttpServletResponse response)
   {   
      String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
      long bbsSeq = HttpUtil.get(request, "bbsSeq", (long)0);
      String searchType = HttpUtil.get(request, "searchType", "");
      String searchValue = HttpUtil.get(request, "searchValue", "");
      long curPage = HttpUtil.get(request, "curPage", (long)1);
      //관리자글 여부
      String noticeAdmin = "N";   //noticeAdm가 "Y"면 내글이라는 의미
      
      AdminNotice adminNotice = null; 
      
      if(bbsSeq > 0)
      {
         adminNotice = adminNoticeService.adminNoticeView(bbsSeq);
         
         if(adminNotice != null && StringUtil.equals(adminNotice.getUserId(), cookieUserId))   
         {   
            noticeAdmin = "Y";
         }
      }
      
      model.addAttribute("noticeAdmin", noticeAdmin);
      model.addAttribute("bbsSeq", bbsSeq);
      model.addAttribute("adminNotice", adminNotice);
      model.addAttribute("searchType", searchType);
      model.addAttribute("searchValue", searchValue);
      model.addAttribute("curPage", curPage);
      
      return "/notice/noticeView";
   }
   
   //공지글 수정 화면
   @RequestMapping(value="/notice/noticeUpdateForm")
   public String noticeUpdateForm(ModelMap model, HttpServletRequest request, HttpServletResponse response)
   {
      String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
      long bbsSeq = HttpUtil.get(request, "bbsSeq", (long)0);
      String searchType = HttpUtil.get(request, "searchType", "");
      String searchValue = HttpUtil.get(request, "searchValue", "");
      long curPage = HttpUtil.get(request, "curPage", (long)1);
      
      AdminNotice adminNotice = null;
      UserG2 user = null;
      
      if(bbsSeq > 0) 
      {
         adminNotice = adminNoticeService.noticeViewUpdate(bbsSeq);
         
         if(adminNotice != null)
         {
            if(StringUtil.equals(adminNotice.getUserId(), cookieUserId))   
            {
               user = userG2Service.userIdSelect(cookieUserId); 
            }   
            else
            {
               adminNotice = null;   
            }
         }
      }
      
      model.addAttribute("searchType", searchType);
      model.addAttribute("searchValue", searchValue);
      model.addAttribute("curPage", curPage);
      model.addAttribute("adminNotice", adminNotice);
      model.addAttribute("user", user);
      
      return "/notice/noticeUpdateForm";
   }
   
   //공지글 수정
   @RequestMapping(value="/notice/noticeUpdateProc", method=RequestMethod.POST)
   @ResponseBody
   public Response<Object> noticeUpdateProc(MultipartHttpServletRequest request, HttpServletResponse response)
   {
      Response<Object> ajaxResponse = new Response<Object>();
      
      String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
      long bbsSeq = HttpUtil.get(request, "bbsSeq", (long)0);
      String bbsTitle = HttpUtil.get(request, "bbsTitle", "");
      String bbsContent = HttpUtil.get(request, "bbsContent", "");
      String searchSort = HttpUtil.get(request, "searchSort", "");
      
      if(bbsSeq > 0 && !StringUtil.isEmpty(searchSort) && !StringUtil.isEmpty(bbsTitle) && !StringUtil.isEmpty(bbsContent))
      {
         AdminNotice adminNotice = adminNoticeService.adminNoticeSelect(bbsSeq);
         
         if(adminNotice != null)
         {
            if(StringUtil.equals(adminNotice.getUserId(), cookieUserId))
            {
               adminNotice.setBbsTitle(bbsTitle);
               adminNotice.setBbsContent(bbsContent);
               
               if(StringUtil.equals(searchSort, "1"))
               {   
                  searchSort = "Y";
                  adminNotice.setStatus(searchSort);
               }
               else if(StringUtil.equals(searchSort, "2"))
               {
                  searchSort = "N";
                  adminNotice.setStatus(searchSort);
               }
               
               if(adminNoticeService.noticeUpdate(adminNotice) > 0)
               {
                  ajaxResponse.setResponse(0, "success");
               }
               else
               {
                  ajaxResponse.setResponse(500, "internal server error");
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
         ajaxResponse.setResponse(400, "Bad request");
      }               
      
      return ajaxResponse;
   }

   //공지글 삭제
   @RequestMapping(value="/notice/delete", method=RequestMethod.POST)
   @ResponseBody
   public Response<Object> noticeDelete(HttpServletRequest request, HttpServletResponse response)
   {
      Response<Object> ajaxResponse = new Response<Object>();
      String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
      long bbsSeq = HttpUtil.get(request, "bbsSeq", (long)0);      
      
      if(bbsSeq > 0)
      {
         AdminNotice adminNotice = adminNoticeService.adminNoticeSelect(bbsSeq);
         
         if(adminNotice != null)
         {
            if(StringUtil.equals(adminNotice.getUserId(), cookieUserId))
            {
               
                  if(adminNoticeService.noticeDelete(bbsSeq) > 0)
                  {
                     ajaxResponse.setResponse(0, "success");
                  }
                  else
                  {
                     ajaxResponse.setResponse(500, "server error222");
                  }
               }
            else
            {
               ajaxResponse.setResponse(404, "server error");
            }
         }
         else
         {
            ajaxResponse.setResponse(404, "not found");
         }
      }
      else
      {
         ajaxResponse.setResponse(400, "bad Request");
      }
      
      return ajaxResponse;
   }
   
   
}