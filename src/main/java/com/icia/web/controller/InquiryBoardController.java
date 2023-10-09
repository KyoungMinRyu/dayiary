package com.icia.web.controller;

import java.util.ArrayList;
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

import com.icia.common.model.FileData;
import com.icia.common.util.StringUtil;
import com.icia.web.model.InquiryBoard;
import com.icia.web.model.InquiryBoardInfo;
import com.icia.web.model.InquiryBoardFile;
import com.icia.web.model.Paging;
import com.icia.web.model.Response;
import com.icia.web.model.Seller;
import com.icia.web.model.UserG2;
import com.icia.web.service.InquiryBoardService;
import com.icia.web.service.SellerService;
import com.icia.web.service.UserG2Service;
import com.icia.web.util.CookieUtil;
import com.icia.web.util.HttpUtil;

@Controller("inquiryBoardController")

public class InquiryBoardController 
{
   private static Logger logger = LoggerFactory.getLogger(InquiryBoardController.class);

   @Value("#{env['auth.cookie.name']}")
   private String AUTH_COOKIE_NAME;  
   
   @Value("#{env['upload.save.dir']}")
   private String UPLOAD_SAVE_DIR;      

   @Autowired
   private UserG2Service userG2Service;   
   
   @Autowired
   private SellerService sellerService;
   
   @Autowired
   private InquiryBoardService inquiryBoardService;
   
   private static final int LIST_COUNT = 6;   
   private static final int PAGE_COUNT = 10;   
   
   
   //문의글 리스트
   @RequestMapping(value="/inquiry/inquiryList")   
   public String inquiryList(ModelMap model, HttpServletRequest request, HttpServletResponse response)
   {   
      String searchCategory = HttpUtil.get(request, "searchCategory", "");
      String searchType = HttpUtil.get(request, "searchType", "");
      String searchValue = HttpUtil.get(request, "searchValue", "");
      long curPage = HttpUtil.get(request, "curPage", (long)1);
      String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
      String cookieSellerId = CookieUtil.getHexValue(request, "SELLER_ID");
      
      if(!StringUtil.isEmpty(cookieUserId))
      {
         List<InquiryBoard> list = null;
         InquiryBoard search = new InquiryBoard();
         
         long totalCount = 0;
         Paging paging = null;
         
         UserG2 user = userG2Service.userIdSelect(cookieUserId);
         
         if(user != null)
         {
            search.setUserId(user.getUserId());
         }
         
         if(!StringUtil.isEmpty(searchCategory))
         {
            search.setSearchCategory(searchCategory);
         }
         
         if(!StringUtil.isEmpty(searchType) && !StringUtil.isEmpty(searchValue))
         {
            search.setSearchType(searchType);
            search.setSearchValue(searchValue);   
         }
         
         totalCount = inquiryBoardService.inquiryBoardListCount(search);
         
         if(totalCount > 0)
         {
            paging = new Paging("/inquiry/inquiryList", totalCount, LIST_COUNT, PAGE_COUNT, curPage, "curPage");
            
            search.setStartRow(paging.getStartRow());
            search.setEndRow(paging.getEndRow());
            
            list = inquiryBoardService.inquiryBoardList(search);
            
         }
         
         model.addAttribute("user", user);
         model.addAttribute("list", list);
         model.addAttribute("searchType", searchType);
         model.addAttribute("searchValue", searchValue);
         model.addAttribute("searchCategory", searchCategory);
         model.addAttribute("curPage", curPage);
         model.addAttribute("paging", paging); 
         
      }
      
      else if(!StringUtil.isEmpty(cookieSellerId))
      { 
         List<InquiryBoard> list = null;
         InquiryBoard search = new InquiryBoard();
         
         long totalCount = 0;
         Paging paging = null;
         
         Seller seller = sellerService.sellerIdSelect(cookieSellerId);
         
         if(seller != null) 
         {
            search.setSellerId(seller.getSellerId());
         }
         
         if(!StringUtil.isEmpty(searchCategory))
         {
            search.setSearchCategory(searchCategory);
         }
         
         if(!StringUtil.isEmpty(searchType) && !StringUtil.isEmpty(searchValue))
         {
            search.setSearchType(searchType);
            search.setSearchValue(searchValue);   
         }
         
         totalCount = inquiryBoardService.inquirySellerBoardListCount(search);
         
         if(totalCount > 0)
         {
            paging = new Paging("/inquiry/inquiryList", totalCount, LIST_COUNT, PAGE_COUNT, curPage, "curPage");
            
            search.setStartRow(paging.getStartRow());
            search.setEndRow(paging.getEndRow());
            
            list = inquiryBoardService.inquirySellerBoardList(search);
         }
         
         model.addAttribute("seller", seller);
         model.addAttribute("list", list);
         model.addAttribute("searchType", searchType);
         model.addAttribute("searchValue", searchValue);
         model.addAttribute("curPage", curPage);
         model.addAttribute("paging", paging);
         
      }   
      
      return "/inquiry/inquiryList";
   }
   
   
   //문의글 등록 폼
   @RequestMapping(value="/inquiry/inquiryWriteForm")
   public String inquiryWriteForm(ModelMap model, HttpServletRequest request, HttpServletResponse response)
   {
      String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
      String searchType = HttpUtil.get(request, "searchType", "");
      String searchValue = HttpUtil.get(request, "searchValue", "");
      String searchCategory = HttpUtil.get(request, "searchCategory", "");
      String afterSelected = HttpUtil.get(request, "afterSelected");
      String orderSeq = HttpUtil.get(request, "orderSeq");
      String productSeq = HttpUtil.get(request, "productSeq");
      
      long curPage = HttpUtil.get(request, "curPage", (long)1);
      List<InquiryBoard> list = null;
      
      List<InquiryBoardInfo> list1 = null;
      List<InquiryBoardInfo> list2 = null;
      
      list1 = inquiryBoardService.productSelect();
      list2 = inquiryBoardService.restoSelect();
      
      UserG2 user = userG2Service.userIdSelect(cookieUserId);
      
      if(user != null)
      {
         list = inquiryBoardService.seqSelect(user.getUserId());
      }
      
      
      model.addAttribute("list", list);
      model.addAttribute("list1", list1);
      model.addAttribute("list2", list2);
      model.addAttribute("user", user);
      model.addAttribute("searchType", searchType);
      model.addAttribute("searchValue", searchValue);
      model.addAttribute("searchCategory", searchCategory);
      model.addAttribute("curPage", curPage);
      model.addAttribute("afterSelected", afterSelected);
      model.addAttribute("productSeq", productSeq);
      model.addAttribute("orderSeq", orderSeq);
      return "/inquiry/inquiryWriteForm";
   }
   

   //문의글 등록(ajax)
   @RequestMapping(value="/inquiry/inquiryWriteProc", method=RequestMethod.POST)
   @ResponseBody
   public Response<Object> inquiryWriteProc(MultipartHttpServletRequest request, HttpServletResponse response)
   {
      Response<Object> ajaxResponse = new Response<Object>();   
      String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
      String qnaTitle = HttpUtil.get(request, "qnaTitle", "");
      String qnaContent = HttpUtil.get(request, "qnaContent", "");
      String cateQnaType = HttpUtil.get(request, "cateQnaType");
      String sellerId = HttpUtil.get(request, "sellerId");
      List<FileData> fileData = HttpUtil.getFiles(request, "inquiryFile", UPLOAD_SAVE_DIR);   //다중파일 업로드시 FileData객체도 List로 선언 //"inquiryFile"은 inquiryWriteForm.jsp에 있는 input태그의 id값을 기입!
      
      
      if(!StringUtil.isEmpty(qnaTitle) && !StringUtil.isEmpty(qnaContent))
      {
         InquiryBoard inquiryBoard = new InquiryBoard();
         
         inquiryBoard.setUserId(cookieUserId);
         inquiryBoard.setQnaTitle(qnaTitle);
         inquiryBoard.setQnaContent(qnaContent);
      
         if(!StringUtil.isEmpty(cateQnaType))
         {
            String cateQnaType1 = cateQnaType.substring(0, 1);
            
            if(StringUtil.equals(cateQnaType1, "R"))
            {
               inquiryBoard.setrSeq(cateQnaType);
            }
            else if(StringUtil.equals(cateQnaType1, "P"))
            {
               inquiryBoard.setProductSeq(cateQnaType);
            }
         }
         
         if(!StringUtil.isEmpty(sellerId))
         {
            inquiryBoard.setSellerId(sellerId);
         }
      
            if(fileData != null)   
            { //if문안에 fileData는 List<FileData> 변수를 가리키며, 이 리스트에는 여러 개의 FileData 객체가 포함될 수 있습니다. null이 아닐시 각각의 FileData 객체는 업로드된 파일에 대한 정보를 담고 있다.
               //업로드된 파일이 없을 경우(null일 경우), fileData는 보통 null이 아니라 빈 리스트(List<FileData>)가 된다. 
               List<InquiryBoardFile> inquiryBoardFileList = new ArrayList<InquiryBoardFile>();   //다중파일 업로드시 List로 객체 선언하며, 사용변수는 InquiryBoard.java에 변수도 List로 선언필수!
               
               for(int f=0 ; f < fileData.size() ; f++)      //다중파일 업로드이기 때문에 for문으로 업로드되는 사진 수까지 돌리면서 파일1개씩 읽어서 값을 넣어야 한다
               {   
                  InquiryBoardFile inquiryBoardFile = new InquiryBoardFile();   //InquiyBoardFile객체를 선언해서 InquiryBoardFile.java에 변수에 하나씩 담는것
                  
                  inquiryBoardFile.setFileName(fileData.get(f).getFileName());   
                  inquiryBoardFile.setFileOrgName(fileData.get(f).getFileOrgName());   
                  inquiryBoardFile.setFileExt(fileData.get(f).getFileExt());         
                  inquiryBoardFile.setFileSize(fileData.get(f).getFileSize());      
                           
                   inquiryBoardFileList.add(inquiryBoardFile);      //위에서 각각 담을 값들을 for문을 통해 1개씩 담아서 마지막에 inquiryBoardFileList인 List에 한개씩 배치해놓는 것
               }
            
                  inquiryBoard.setInquiryBoardFile(inquiryBoardFileList); // for문을 통해 값을 담은 inquiryBoardFileList인 List를 inquiryBoard에 선언되있는 InquiryBoardFile인 List가 같은곳을 바라볼수 있게함
            }
            //서비스 호출 
            try
            {
               if(inquiryBoardService.inquiryBoardInsert(inquiryBoard) > 0)   //값들이 담기고 파일이 담긴 list를 바라보게한 inquiryBoard를 매개변수로 객체를 넘김
               {
                  ajaxResponse.setResponse(0, "success");
               }
               else
               {
                  ajaxResponse.setResponse(500, "Interal server error");
               }
            }
            catch(Exception e)
            {
               logger.error("[InquiryBoardController] inquiryWriteProc Exception", e);
               ajaxResponse.setResponse(500, "Interal server error");
            }
         }      
      else
      {
         ajaxResponse.setResponse(400, "Bad Request");
      }
   
      return ajaxResponse;
   }
   
   
   //문의글 조회
   @RequestMapping(value="/inquiry/inquiryView")
   public String inquiryView(ModelMap model, HttpServletRequest request, HttpServletResponse response)
   {
      String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
      String cookieSellerId = CookieUtil.getHexValue(request, "SELLER_ID");
      String userId = HttpUtil.get(request, "userId", "");
      long qnaSeq = HttpUtil.get(request, "qnaSeq", (long)0);
      String orderGubun = HttpUtil.get(request, "orderGubun", "");
      String searchType = HttpUtil.get(request, "searchType", "");
      String searchValue = HttpUtil.get(request, "searchValue", "");
      String searchCategory = HttpUtil.get(request, "searchCategory", "");
      long curPage = HttpUtil.get(request, "curPage", (long)1);
      String boardMe = "N";   //boardMe가 "Y"면 내글이라는 의미
      
      if(!StringUtil.isEmpty(cookieUserId))
      { 
      
         InquiryBoard inquiryBoard = null; 
         
         if(qnaSeq > 0)
         {
            inquiryBoard = inquiryBoardService.inquiryView(qnaSeq, orderGubun, userId);
            
            if(inquiryBoard != null && StringUtil.equals(inquiryBoard.getUserId(), cookieUserId))   
            {   //위 조건 만족시 내글이므로 boardMe를 Y로 N에서 엎어침
               boardMe = "Y";
            }
            
         }
         
         model.addAttribute("orderGubun", orderGubun);
         model.addAttribute("boardMe", boardMe);
         model.addAttribute("qnaSeq", qnaSeq);
         model.addAttribute("inquiryBoard", inquiryBoard);
         model.addAttribute("searchType", searchType);
         model.addAttribute("searchValue", searchValue);
         model.addAttribute("searchCategory", searchCategory);
         model.addAttribute("curPage", curPage);
         
      }
      else if(!StringUtil.isEmpty(cookieSellerId))
      {
               InquiryBoard inquiryBoard = null; 
         
         if(qnaSeq > 0)
         {
            inquiryBoard = inquiryBoardService.inquiryView(qnaSeq, orderGubun, userId);
            
            if(inquiryBoard != null && StringUtil.equals(inquiryBoard.getSellerId(), cookieSellerId))   
            {   //위 조건 만족시 내글이므로 boardMe를 Y로 N에서 엎어침
               boardMe = "Y";
            }
            
         }
         
         model.addAttribute("orderGubun", orderGubun);
         model.addAttribute("boardMe", boardMe);
         model.addAttribute("qnaSeq", qnaSeq);
         model.addAttribute("inquiryBoard", inquiryBoard);
         model.addAttribute("searchType", searchType);
         model.addAttribute("searchValue", searchValue);
         model.addAttribute("searchCategory", searchCategory);
         model.addAttribute("curPage", curPage);
         
      }
      
      return "/inquiry/inquiryView";
   }
   
   
   //문의글 수정 화면
   @RequestMapping(value="/inquiry/inquiryUpdateForm")
   public String inquiryUpdateForm(ModelMap model, HttpServletRequest request, HttpServletResponse response)
   {
      String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
      String cookieSellerId = CookieUtil.getHexValue(request, "SELLER_ID");
      String userId = HttpUtil.get(request, "userId", "");
      long qnaSeq = HttpUtil.get(request, "qnaSeq", (long)0);
      String orderGubun = HttpUtil.get(request, "orderGubun", "");
      String searchType = HttpUtil.get(request, "searchType", "");
      String searchValue = HttpUtil.get(request, "searchValue", "");
      String searchCategory = HttpUtil.get(request, "searchCategory", "");
      long curPage = HttpUtil.get(request, "curPage", (long)1);
      
      //logger.debug("================" + userId);
      //logger.debug("================" + orderGubun);
      //logger.debug("================" + qnaSeq);
      
      InquiryBoard inquiryBoard = null;
      UserG2 user = null;
      Seller seller = null;

      if(!StringUtil.isEmpty(cookieUserId))
      {
         if(qnaSeq > 0) 
         {
            inquiryBoard = inquiryBoardService.inquiryBoardViewUpdate(qnaSeq, orderGubun, userId);
            
            if(inquiryBoard != null)
            {
               
                  if(StringUtil.equals(inquiryBoard.getUserId(), cookieUserId))   
                  {
                     user = userG2Service.userIdSelect(cookieUserId); 
                     model.addAttribute("user", user);
                  }   
                  else
                  {
                     inquiryBoard = null;   //작성한 사용자와 로그인 사용자가 다를시 게시판 화면을 보여주지 않은 것
                  }
            }      
         }
      }      
      else if(!StringUtil.isEmpty(cookieSellerId))
      {
         if(qnaSeq > 0) 
         {
            inquiryBoard = inquiryBoardService.inquiryBoardViewUpdate(qnaSeq, orderGubun, userId);
            
            if(inquiryBoard != null)
            {
                  if(StringUtil.equals(inquiryBoard.getSellerId(), cookieSellerId))   
                  {
                     seller = sellerService.sellerIdSelect(cookieSellerId); 
                     model.addAttribute("seller", seller);
                  }   
                  else
                  {
                     inquiryBoard = null;   //작성한 판매자와 로그인 판매자가 다를시 게시판 화면을 보여주지 않은 것
                  }
            }
         }
      }
      
      model.addAttribute("orderGubun", orderGubun);
      model.addAttribute("searchType", searchType);
      model.addAttribute("qnaSeq", qnaSeq);
      model.addAttribute("searchValue", searchValue);
      model.addAttribute("curPage", curPage);
      model.addAttribute("searchCategory", searchCategory);
      model.addAttribute("inquiryBoard", inquiryBoard);
      
      return "/inquiry/inquiryUpdateForm";
   }
   
   
   //문의글 수정
   @RequestMapping(value="/inquiry/inquiryUpdateProc", method=RequestMethod.POST)
   @ResponseBody
   public Response<Object> updateProc(MultipartHttpServletRequest request, HttpServletResponse response)
   {
      Response<Object> ajaxResponse = new Response<Object>();
      
      String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
      String cookieSellerId = CookieUtil.getHexValue(request, "SELLER_ID");
      String sellerId = HttpUtil.get(request, "sellerId");
      String userId = HttpUtil.get(request, "userId", "");
      String orderGubun = HttpUtil.get(request, "orderGubun", "");
      long qnaSeq = HttpUtil.get(request, "qnaSeq", (long)0);
      String qnaTitle = HttpUtil.get(request, "qnaTitle", "");
      String qnaContent = HttpUtil.get(request, "qnaContent", "");
      List<FileData> fileData = HttpUtil.getFiles(request, "inquiryFile", UPLOAD_SAVE_DIR);
      
      
      if(!StringUtil.isEmpty(cookieUserId))
      {
      
            if(qnaSeq > 0 && !StringUtil.isEmpty(qnaTitle) && !StringUtil.isEmpty(qnaContent))
            {
               
               InquiryBoard inquiryBoard = inquiryBoardService.inquiryBoardSelect(qnaSeq, orderGubun, userId);
               
               if(inquiryBoard != null)
               {
                  if(StringUtil.equals(inquiryBoard.getUserId(), cookieUserId))
                  {
                     inquiryBoard.setQnaTitle(qnaTitle);
                     inquiryBoard.setQnaContent(qnaContent);
                     
                     if(fileData != null)
                     {
                        List<InquiryBoardFile> inquiryBoardFileList = new ArrayList<InquiryBoardFile>();
                        
                        for(int f=0 ; f < fileData.size() ; f++)
                        {
                           InquiryBoardFile inquiryBoardFile = new InquiryBoardFile();   
                        
                           inquiryBoardFile.setFileName(fileData.get(f).getFileName());   
                           inquiryBoardFile.setFileOrgName(fileData.get(f).getFileOrgName());   
                           inquiryBoardFile.setFileExt(fileData.get(f).getFileExt());         
                           inquiryBoardFile.setFileSize(fileData.get(f).getFileSize());      
                                    
                            inquiryBoardFileList.add(inquiryBoardFile);      
                        }
                        inquiryBoard.setInquiryBoardFile(inquiryBoardFileList); 
                     }
                     try
                     {
                        if(inquiryBoardService.inquiryBoardUpdate(inquiryBoard) > 0)
                        {
                           ajaxResponse.setResponse(0, "success");
                        }
                        else
                        {
                           ajaxResponse.setResponse(500, "internal server error222");
                        }
                     }
                     catch(Exception e)
                     {
                        logger.error("[InquiryBoardController] inquiryUpdateProc Exception", e);
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
            }               //파라미터값이 안넘어 왔을 경우 오류
      }
      else if(!StringUtil.isEmpty(cookieSellerId))
      {
         if(qnaSeq > 0 && !StringUtil.isEmpty(qnaTitle) && !StringUtil.isEmpty(qnaContent))
         {
            
            InquiryBoard inquiryBoard = inquiryBoardService.inquiryBoardSelect(qnaSeq, orderGubun, userId);
            
            if(inquiryBoard != null)
            {
               if(StringUtil.equals(inquiryBoard.getSellerId(), cookieSellerId))
               {
                  inquiryBoard.setQnaTitle(qnaTitle);
                  inquiryBoard.setQnaContent(qnaContent);
                  
                  if(fileData != null)
                  {
                     List<InquiryBoardFile> inquiryBoardFileList = new ArrayList<InquiryBoardFile>();
                     
                     for(int f=0 ; f < fileData.size() ; f++)
                     {
                        InquiryBoardFile inquiryBoardFile = new InquiryBoardFile();   
                     
                        inquiryBoardFile.setFileName(fileData.get(f).getFileName());   
                        inquiryBoardFile.setFileOrgName(fileData.get(f).getFileOrgName());   
                        inquiryBoardFile.setFileExt(fileData.get(f).getFileExt());         
                        inquiryBoardFile.setFileSize(fileData.get(f).getFileSize());      
                                 
                         inquiryBoardFileList.add(inquiryBoardFile);      
                     }
                     inquiryBoard.setInquiryBoardFile(inquiryBoardFileList); 
                  }
                  try
                  {
                     if(inquiryBoardService.inquiryBoardUpdate(inquiryBoard) > 0)
                     {
                        ajaxResponse.setResponse(0, "success");
                     }
                     else
                     {
                        ajaxResponse.setResponse(500, "internal server error222");
                     }
                  }
                  catch(Exception e)
                  {
                     logger.error("[InquiryBoardController] inquiryUpdateProc Exception", e);
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
         }               //파라미터값이 안넘어 왔을 경우 오류
         
      }
         
      return ajaxResponse;
   }

   
   //문의글 삭제
   @RequestMapping(value="/inquiry/inquiryDelete", method=RequestMethod.POST)
   @ResponseBody
   public Response<Object> inquiryDelete(HttpServletRequest request, HttpServletResponse response)
   {
      Response<Object> ajaxResponse = new Response<Object>();
      String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
      String cookieSellerId = CookieUtil.getHexValue(request, "SELLER_ID");
      long qnaSeq = HttpUtil.get(request, "qnaSeq", (long)0);      
      String orderGubun = HttpUtil.get(request, "orderGubun", "");
      String userId = HttpUtil.get(request, "userId", "");
      
      //사용자,관리자 삭제
      if(!StringUtil.isEmpty(cookieUserId))   
      { 
         if(qnaSeq > 0)
         {
            InquiryBoard inquiryBoard = inquiryBoardService.inquiryBoardSelect(qnaSeq, orderGubun, userId);
            
               if(inquiryBoard != null)
               {
                  
                     if(StringUtil.equals(inquiryBoard.getUserId(), cookieUserId) || StringUtil.equals(cookieUserId, "adm"))
                     {
                        try
                        {
                           if(inquiryBoardService.inquiryBoardAnswersCount(inquiryBoard.getQnaSeq()) > 0)  
                           {
                              //답글이 있으면 삭제 못하도록
                              ajaxResponse.setResponse(-999, "answers exists and cannot be deleted");
                           }
                           else
                           {
                              if(inquiryBoardService.inquiryBoardDelete(qnaSeq, orderGubun, userId) > 0)
                              {
                                 ajaxResponse.setResponse(0, "success");
                                 
                              }
                              else
                              {
                                 ajaxResponse.setResponse(500, "server error22222");
                              }
                           }
                        }
                        catch(Exception e)
                        {
                           logger.error("[InquiryBoardController] inquiryDelete Exception", e);
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
                  ajaxResponse.setResponse(400, "bad Request");
               }
         }
         //판매자 삭제
         else if(!StringUtil.isEmpty(cookieSellerId))
         {
            if(qnaSeq > 0)
            {
               InquiryBoard inquiryBoard = inquiryBoardService.inquiryBoardSelect(qnaSeq, orderGubun, userId);
               
                  if(inquiryBoard != null)
                  {
                     
                        if(StringUtil.equals(inquiryBoard.getSellerId(), cookieSellerId))
                        {
                           try
                           {
                              if(inquiryBoardService.inquiryBoardAnswersCount(inquiryBoard.getQnaSeq()) > 0)  
                              {
                                 //답글이 있으면 삭제 못하도록
                                 ajaxResponse.setResponse(-999, "answers exists and cannot be deleted");
                              }
                              else
                              {
                                 if(inquiryBoardService.inquiryBoardDelete(qnaSeq, orderGubun, userId) > 0)
                                 {
                                    ajaxResponse.setResponse(0, "success");
                                 }
                                 else
                                 {
                                    ajaxResponse.setResponse(500, "server error22222");
                                 }
                              }
                           }
                           catch(Exception e)
                           {
                              logger.error("[InquiryBoardController] inquiryDelete Exception", e);
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
                     ajaxResponse.setResponse(400, "bad Request");
                  }
            
         }
      
      return ajaxResponse;
   }
   
   
   //문의글 답변 화면
   @RequestMapping(value="/inquiry/inquiryReplyForm", method=RequestMethod.POST)
   public String inquiryReplyForm(ModelMap model, HttpServletRequest request, HttpServletResponse response)
   {
      
      String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
      String cookieSellerId = CookieUtil.getHexValue(request, "SELLER_ID");
      long qnaSeq = HttpUtil.get(request, "qnaSeq", (long)0);      
      String orderGubun = HttpUtil.get(request, "orderGubun", "");
      String userId = HttpUtil.get(request, "userId", "");
      String beforeQnaTitle = HttpUtil.get(request, "beforeQnaTitle", "");
      String searchType = HttpUtil.get(request, "searchType", "");
      String searchValue = HttpUtil.get(request, "searchValue", "");
      long curPage = HttpUtil.get(request, "curPage", (long)1);
      
      InquiryBoard inquiryBoard = null;
      UserG2 user = null;   
      Seller seller = null;
      
      if(qnaSeq > 0)
      {
         inquiryBoard = inquiryBoardService.inquiryBoardSelect(qnaSeq, orderGubun, userId);
         
         if(inquiryBoard != null)
         {
            if(!StringUtil.isEmpty(cookieUserId))
            {
               user = userG2Service.userIdSelect(cookieUserId); //브라우저에 로그인 되어있는 사용자를 말한 것(게시글에 답글을 작성하는 사람에 대한 것)
         
            }
            else if(!StringUtil.isEmpty(cookieSellerId))
            {
               seller = sellerService.sellerIdSelect(cookieSellerId);   //브라우저에 로그인 되어있는 판매자를 말한 것(게시글에 답글을 작성하는 사람에 대한 것)
            }
         }
      }
      
      model.addAttribute("orderGubun", orderGubun);
      model.addAttribute("beforeQnaTitle", beforeQnaTitle);
      model.addAttribute("searchType", searchType);
      model.addAttribute("searchValue", searchValue);
      model.addAttribute("curPage", curPage);
      model.addAttribute("inquiryBoard", inquiryBoard);
      model.addAttribute("user", user);
      model.addAttribute("seller", seller);
      
      return "/inquiry/inquiryReplyForm";
   }
   
   
   //문의글 답변
   @RequestMapping(value="/inquiry/inquiryReplyProc", method=RequestMethod.POST)
   @ResponseBody
   public Response<Object> inquiryReplyProc(MultipartHttpServletRequest request, HttpServletResponse response)
   {   
      Response<Object> ajaxResponse = new Response<Object>();
      
      String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
      String cookieSellerId = CookieUtil.getHexValue(request, "SELLER_ID");
      long qnaSeq = HttpUtil.get(request, "qnaSeq", (long)0);
      String orderGubun = HttpUtil.get(request, "orderGubun", "");
      String userId = HttpUtil.get(request, "userId", "");
      String sellerId = HttpUtil.get(request, "sellerId", "");
      String qnaTitle = HttpUtil.get(request, "qnaTitle", "");
      String qnaContent = HttpUtil.get(request, "qnaContent", "");
      List<FileData> fileData = HttpUtil.getFiles(request, "inquiryFile", UPLOAD_SAVE_DIR);
      
      
      if(qnaSeq > 0 && !StringUtil.isEmpty(qnaTitle) && !StringUtil.isEmpty(qnaContent))
      {
         InquiryBoard parentInquiryBoard = inquiryBoardService.inquiryBoardSelect(qnaSeq, orderGubun, userId); //댓글화면에서 부모의 정보를 가지고 온것
         
         if(parentInquiryBoard != null)
         {
            InquiryBoard inquiryBoard = new InquiryBoard();
            
            inquiryBoard.setUserId(userId);
            inquiryBoard.setSellerId(sellerId);
            inquiryBoard.setQnaTitle(qnaTitle);
            inquiryBoard.setQnaContent(qnaContent);            
            inquiryBoard.setReplyStatus("N");
            inquiryBoard.setQnaGroup(parentInquiryBoard.getQnaGroup());      //그룹->메인게시물의 시퀀스를 따라감
            inquiryBoard.setQnaOrder(parentInquiryBoard.getQnaOrder() + 1);   //그룹번호 내에서의 순서
            inquiryBoard.setQnaIndent(parentInquiryBoard.getQnaIndent() + 1);   //들여쓰기
            
            if(StringUtil.equals(orderGubun, "R"))
            {   //레스토랑정보
               inquiryBoard.setrSeq(parentInquiryBoard.getOrderedSeq());
            }
            else
            {   //선물정보 'P'
               inquiryBoard.setProductSeq(parentInquiryBoard.getOrderedSeq());
            }
            inquiryBoard.setQnaParent(qnaSeq);                     
            
            if(fileData != null)
            {
               List<InquiryBoardFile> inquiryBoardFileList = new ArrayList<InquiryBoardFile>();
               
               for(int f=0 ; f < fileData.size() ; f++)
               {
                  InquiryBoardFile inquiryBoardFile = new InquiryBoardFile();   
               
                  inquiryBoardFile.setFileName(fileData.get(f).getFileName());   
                  inquiryBoardFile.setFileOrgName(fileData.get(f).getFileOrgName());   
                  inquiryBoardFile.setFileExt(fileData.get(f).getFileExt());         
                  inquiryBoardFile.setFileSize(fileData.get(f).getFileSize());      
                           
                   inquiryBoardFileList.add(inquiryBoardFile);      
               }
               
               inquiryBoard.setInquiryBoardFile(inquiryBoardFileList); 
            }
            try
            {
               if(inquiryBoardService.inquiryBoardReplyInsert(inquiryBoard) > 0)
               {                        
                  ajaxResponse.setResponse(0, "success");
               }
               else
               {
                  ajaxResponse.setResponse(500, "internal server error22222");
               }
            }
            catch(Exception e)
            {
               logger.error("[InquiryBoardController] inquiryReplyProc Exception", e);
               ajaxResponse.setResponse(500, "internal server error");
            }
         }
         else
         {
            //부모글이 없을때
            ajaxResponse.setResponse(404, "not found");
         }
      }   
      else
      {
         ajaxResponse.setResponse(400, "Bad request");
      }
      
      return ajaxResponse;
   }
   
}