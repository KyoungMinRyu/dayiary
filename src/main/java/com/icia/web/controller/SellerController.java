package com.icia.web.controller;


import java.util.ArrayList;
import java.util.HashMap;
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
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.icia.common.model.FileData;
import com.icia.common.util.FileUtil;
import com.icia.common.util.StringUtil;
import com.icia.web.model.GiftAdd;
import com.icia.web.model.GiftFile;
import com.icia.web.model.Menu;
import com.icia.web.model.MenuFile;
import com.icia.web.model.OrderList;
import com.icia.web.model.Response;
import com.icia.web.model.RestoFile;
import com.icia.web.model.RestoInfo;
import com.icia.web.model.Seller;
import com.icia.web.service.RestoService;
import com.icia.web.service.SellerService;
import com.icia.web.util.CookieUtil;
import com.icia.web.util.HttpUtil;
import com.icia.web.util.JsonUtil;
import com.icia.web.util.NaverApi;

@Controller("sellerController")
public class SellerController {
	private static Logger logger = LoggerFactory.getLogger(SellerController.class);

	// auth_cookie_name 하드코딩
	private String AUTH_COOKIE_NAME = "SELLER_ID";

	// 파일 저장 경로
	@Value("#{env['upload.save.dir']}")
	private String UPLOAD_SAVE_DIR;

	@Autowired
	private SellerService sellerService;

	@Autowired
	private RestoService restoService;

	@Autowired
	private HttpSession session; // HttpSession 객체를 주입받음

	@RequestMapping(value = "/seller/loginProc", method = RequestMethod.POST)
	@ResponseBody
	public Response<Object> loginProc(HttpServletRequest request, HttpServletResponse response) {
		String sellerId = HttpUtil.get(request, "userId");
		String sellerPwd = HttpUtil.get(request, "userPwd");
		Response<Object> ajaxResponse = new Response<Object>();

		if (!StringUtil.isEmpty(sellerId) && !StringUtil.isEmpty(sellerPwd)) {
			Seller seller = sellerService.sellerIdSelect(sellerId);

			if (seller != null) {
				if (StringUtil.equals(seller.getSellerPwd(), sellerPwd)) {
					CookieUtil.addCookie(response, "/", -1, AUTH_COOKIE_NAME, CookieUtil.stringToHex(sellerId));
					session.setAttribute(sellerId, seller.getSellerShopName());
					ajaxResponse.setResponse(0, "Success"); // 로그인 성공
				} else {
					ajaxResponse.setResponse(-1, "Passwords do not match"); // 비밀번호 불일치
				}
			} else {
				ajaxResponse.setResponse(404, "Not Found"); // 사용자 정보 없음 (Not Found)
			}
		} else {
			ajaxResponse.setResponse(400, "Bad Request"); // 파라미터가 올바르지 않음 (Bad Request)
		}

		if (logger.isDebugEnabled()) {
			logger.debug("[SellerController] /seller/loginProc response\n" + JsonUtil.toJsonPretty(ajaxResponse));
		}

		return ajaxResponse;
	}

	@RequestMapping(value = "/seller/signUp", method = RequestMethod.GET)
	public String signUp(HttpServletRequest request, HttpServletResponse response) {
		return "/seller/signUp";
	}

	// 휴대폰 인증번호 발송 Ajax통신
	@RequestMapping(value = "/seller/sellerPhCheck", method = RequestMethod.POST)
	@ResponseBody
	public Response<Object> sellerPhCheck(HttpServletRequest request, HttpServletResponse response) {
		Response<Object> ajaxResponse = new Response<Object>();
		String sellerPh = HttpUtil.get(request, "userPh");
		if (!StringUtil.isEmpty(sellerPh)) {
			String ranNum = new NaverApi().naverSENSApi(sellerPh);
			if (!StringUtil.isEmpty(ranNum) && ranNum != null) { // 문자 발송 성공
				ajaxResponse.setResponse(0, "인증번호 발송 성공", ranNum);
			} else { // 문자 발송 실패
				ajaxResponse.setResponse(400, "문자 발송 실패");
			}
		} else { // 파라미터 없음
			ajaxResponse.setResponse(500, "파라미터 없음");
		}
		return ajaxResponse;
	}

	// 아이디 중복체크 Ajax통신
	@RequestMapping(value = "/seller/sellerIdCheckAjax", method = RequestMethod.POST)
	@ResponseBody
	public Response<Object> sellerIdCheckAjax(HttpServletRequest request, HttpServletResponse response) {
		Response<Object> ajaxResponse = new Response<Object>();
		String userId = HttpUtil.get(request, "userId");
		if (!StringUtil.isEmpty(userId)) {
			if (sellerService.sellerIdSelect(userId) == null) {
				ajaxResponse.setResponse(0, "success");
			} else {
				ajaxResponse.setResponse(100, "Deplicate ID");
			}
		} else {
			ajaxResponse.setResponse(400, "Bad Request");
		}
		if (logger.isDebugEnabled()) {
			logger.debug("[SellerController](sellerIdCheckAjax)" + JsonUtil.toJsonPretty(ajaxResponse));
		}
		return ajaxResponse;
	}

	// 사업자번호 중복체크 Ajax통신
	@RequestMapping(value = "/seller/sellerBusinnesIdAjax", method = RequestMethod.POST)
	@ResponseBody
	public Response<Object> sellerBusinnesIdAjax(HttpServletRequest request, HttpServletResponse response) {
		Response<Object> ajaxResponse = new Response<Object>();
		String userBid = HttpUtil.get(request, "userBid");
		if (!StringUtil.isEmpty(userBid)) {
			if (sellerService.sellerBidSelect(userBid) == null) {
				ajaxResponse.setResponse(0, "success");
			} else {
				ajaxResponse.setResponse(100, "Deplicate ID");
			}
		} else {
			ajaxResponse.setResponse(400, "Bad Request");
		}
		if (logger.isDebugEnabled()) {
			logger.debug("[SellerController](sellerBusinnesIdAjax)" + JsonUtil.toJsonPretty(ajaxResponse));
		}
		return ajaxResponse;
	}

	// 회원가입 버튼 클릭시 Ajax 통신
	@RequestMapping(value = "/seller/sellerProc", method = RequestMethod.POST)
	@ResponseBody
	public Response<Object> sellerProc(HttpServletRequest request, HttpServletResponse response) {
		Response<Object> ajaxResponse = new Response<Object>();
		String userId = HttpUtil.get(request, "userId");
		String userBid = HttpUtil.get(request, "userBid");
		String userEmail = HttpUtil.get(request, "userEmail");
		String userPwd = HttpUtil.get(request, "userPwd");
		String userShopName = HttpUtil.get(request, "userShopName");
		String userPh = HttpUtil.get(request, "userPh");
		String userChPh = HttpUtil.get(request, "userChPh"); // 1 사용가능
		String userAdd = HttpUtil.get(request, "userAdd");

		if (StringUtil.equals(userChPh, "1")) {
			if (!StringUtil.isEmpty(userId) && !StringUtil.isEmpty(userBid) && !StringUtil.isEmpty(userEmail)
					&& !StringUtil.isEmpty(userPwd) && !StringUtil.isEmpty(userShopName) && !StringUtil.isEmpty(userPh)
					&& !StringUtil.isEmpty(userAdd)) {
				if (sellerService.sellerIdSelect(userId) == null && sellerService.sellerBidSelect(userBid) == null) {
					Seller seller = new Seller();
					seller.setSellerId(userId);
					seller.setSellerBusinessId(userBid);
					seller.setSellerEmail(userEmail);
					seller.setSellerPwd(userPwd);
					seller.setSellerShopName(userShopName);
					seller.setSellerPh(userPh);
					seller.setSellerAddress(userAdd);

					if (sellerService.sellerInsert(seller) > 0) {
						ajaxResponse.setResponse(0, "회원가입 성공");
					} else {
						ajaxResponse.setResponse(500, "Server error");
					}
				} else {
					ajaxResponse.setResponse(100, "회원이 이미 존재");
				}
			} else {
				ajaxResponse.setResponse(400, "파라미터 오류");
			}
		}
		if (logger.isDebugEnabled()) {
			logger.debug("[sellerController]/seller/sellerProc response\n" + JsonUtil.toJsonPretty(ajaxResponse));
		}
		return ajaxResponse;
	}

	// 이메일 인증 성공 시 보낼 경로
	@RequestMapping(value = "/seller/sellerMailSuccess", method = RequestMethod.GET)
	public String userMailSuccess(HttpServletRequest request, HttpServletResponse response) {
		return "/seller/sellerMailSuccess";
	}

	// 이메일 인증 실패 시 보낼 경로
	@RequestMapping(value = "/seller/userMailFail", method = RequestMethod.GET)
	public String userMailFail(HttpServletRequest request, HttpServletResponse response) {
		return "/seller/sellerMailFail";
	}

	// 이메일 인증 시 시간이 지났을 떄 보낼 경로
	@RequestMapping(value = "/seller/userMailTimeOut", method = RequestMethod.GET)
	public String userMailTimeOut(HttpServletRequest request, HttpServletResponse response) {
		return "/seller/sellerMailTimeOut";
	}

	// 로그아웃
	@RequestMapping(value = "/seller/logout", method = RequestMethod.GET)
	public String logout(HttpServletRequest request, HttpServletResponse response) {
		session.removeAttribute(CookieUtil.getHexValue(request, AUTH_COOKIE_NAME));
		CookieUtil.deleteCookie(request, response, "/", AUTH_COOKIE_NAME);

		return "redirect:/";
	}

	// 판매자 로그인 후 첫 화면 내가 추가
	@RequestMapping(value = "/index/sellerIndex")
	public String sellerIndex(HttpServletRequest request, HttpServletResponse response) {
		return "/index/sellerIndex";
	}

	@RequestMapping(value = "/seller/lostIdProc", method = RequestMethod.POST)
	@ResponseBody
	public Response<Object> lostIdProc(HttpServletRequest request, HttpServletResponse response) {
		Response<Object> ajaxResponse = new Response<Object>();
		Map<String, String> params = extractParams(request);

		if (!params.isEmpty()) {
			Seller seller = sellerService.lostsellerIdFind(params);

			if (seller != null) {
				request.getSession().setAttribute("foundSellerId", seller.getSellerId());
				ajaxResponse.setResponse(0, "Success", seller.getSellerId()); // userId를 data로 설정

			} else {
				ajaxResponse.setResponse(404, "Not Found");
			}
		} else {
			ajaxResponse.setResponse(400, "Bad Request");
		}
		return ajaxResponse;
	}

	// 중복된 부분을 메서드로 추출
	private Map<String, String> extractParams(HttpServletRequest request) {
		String sellerBusinessId = request.getParameter("sellerBusinessId");
		String sellerEmail = request.getParameter("sellerEmail");

		Map<String, String> params = new HashMap<String, String>();
		params.put("sellerBusinessId", sellerBusinessId);
		params.put("sellerEmail", sellerEmail);

		return params;
	}

	// 아이디 찾기 결과창
	@RequestMapping(value = "/seller/findId", method = RequestMethod.GET)
	public String findId(ModelMap modelMap, HttpServletRequest request) {
		String sellerId = (String) request.getSession().getAttribute("foundSellerId");
		if (sellerId != null) {
			modelMap.addAttribute("sellerId", sellerId);
			request.getSession().removeAttribute("foundSellerId"); // 세션에서 userId 제거
		}
		return "/seller/findId";
	}

	// 비밀번호찾기 proc
	// 비밀번호찾기
	@RequestMapping(value = "/seller/sellerlostPwdProc", method = RequestMethod.POST)
	@ResponseBody
	public Response<Object> sellerlostPwdProc(HttpServletRequest request, HttpServletResponse response) {
		Response<Object> ajaxResponse = new Response<Object>();
		String sellerId = HttpUtil.get(request, "sellerId");
		String sellerBusinessId = HttpUtil.get(request, "sellerBusinessId");
		String sellerEmail = HttpUtil.get(request, "sellerEmail");

		Seller seller = new Seller();
		seller.setSellerId(sellerId);
		seller.setSellerBusinessId(sellerBusinessId);
		seller.setSellerEmail(sellerEmail);

		if (!StringUtil.isEmpty(sellerId) && !StringUtil.isEmpty(sellerBusinessId)
				&& !StringUtil.isEmpty(sellerEmail)) {
			if (sellerService.sellerpwdCheck(seller) == 1) {
				ajaxResponse.setResponse(0, "사용자 정보가 일치합니다.");

			} else {
				ajaxResponse.setResponse(400, "사용자 정보가 일치하지 않습니다.");
			}
		}

		return ajaxResponse;
	}

	// 판매자 아이디 찾기 페이지 경로
	@RequestMapping(value = "/seller/sellerlostId", method = RequestMethod.GET)
	public String sellerlostId(HttpServletRequest request, HttpServletResponse response) {
		return "/seller/sellerlostId";
	}

	// 판매자 비밀번호 찾기 페이지 경로
	@RequestMapping(value = "/seller/sellerlostPwd", method = RequestMethod.GET)
	public String sellerlostPwd(HttpServletRequest request, HttpServletResponse response) {
		return "/seller/sellerlostPwd";
	}

	@RequestMapping(value = "/seller/getRevenue", method = RequestMethod.POST)
	@ResponseBody
	public Response<Object> getRevenue(HttpServletRequest request, HttpServletResponse response) {
		Response<Object> ajaxResponse = new Response<Object>();
		String cookieSellerId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		int type = HttpUtil.get(request, "type", -1);

		if (type >= 0) {
			if (sellerService.sellerIdSelect(cookieSellerId) != null) {
				if (type == 0) {
					ajaxResponse.setResponse(0, "Success", sellerService.selectReservCntRevenue(cookieSellerId));
				} else if (type == 1) {

				} else {
					ajaxResponse.setResponse(400, "Bad Request");
				}
			} else {
				ajaxResponse.setResponse(404, "Not Found");
			}
		} else {
			ajaxResponse.setResponse(400, "Bad Request");
		}
		return ajaxResponse;
	}

	// 셀러 마이페이지 시작합니다.
	// 레스토랑 수정하기 위한 레스토랑 정보 조회
	@RequestMapping(value = "/seller/restoUpdateForm", method = RequestMethod.GET)
	public String updateForm(ModelMap model, HttpServletRequest request, HttpServletResponse response) {
		String rSeq = HttpUtil.get(request, "rSeq", "");

		RestoInfo restoInfo = null;

		if (!StringUtil.isEmpty(rSeq)) {
			restoInfo = sellerService.restoInfoBring(rSeq);
			model.addAttribute("restoInfo", restoInfo);

		}

		return "/seller/restoupdateForm";
	}

	// 검색 조건 없음 list랑 type이랑.

	@RequestMapping(value = "/seller/getMyRestoList", method = RequestMethod.POST)
	@ResponseBody
	public Response<Object> getMyRestoList(HttpServletRequest request, HttpServletResponse response) {
		Response<Object> ajaxResponse = new Response<Object>();
		String cookieSellerId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);

		if (!StringUtil.isEmpty(cookieSellerId)) {
			List<RestoInfo> list = sellerService.myResto(cookieSellerId);

			ajaxResponse.setResponse(0, "Success", list);

		}
		return ajaxResponse;
	}

	@RequestMapping(value = "/seller/getMyGiftList", method = RequestMethod.POST)
	@ResponseBody
	public Response<Object> getMyGiftList(HttpServletRequest request, HttpServletResponse response) {
		Response<Object> ajaxResponse = new Response<Object>();
		String cookieSellerId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);

		if (!StringUtil.isEmpty(cookieSellerId)) {
			List<GiftAdd> list = sellerService.myGift(cookieSellerId);

			ajaxResponse.setResponse(0, "Success", list);

		}
		return ajaxResponse;
	}

	// 판매자 정보 수정(ajax -리턴타입 객체)
	@RequestMapping(value = "/seller/updateProc", method = RequestMethod.POST)
	@ResponseBody
	public Response<Object> updateProc(HttpServletRequest request, HttpServletResponse response) 
	{
		String cookieSellerId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		String sellerPwd = HttpUtil.get(request, "sellerPwd");
		String sellerShopName = HttpUtil.get(request, "sellerShopName");
		String sellerAddress = HttpUtil.get(request, "sellerAddress");

		Response<Object> ajaxResponse = new Response<Object>();

		if (!StringUtil.isEmpty(cookieSellerId)) {
			Seller seller = sellerService.sellerIdSelect(cookieSellerId);

			if (seller != null) {
				if (!StringUtil.isEmpty(sellerPwd) && !StringUtil.isEmpty(sellerShopName)
						&& !StringUtil.isEmpty(sellerAddress)) {
					seller.setSellerPwd(sellerPwd);
					seller.setSellerShopName(sellerShopName);
					seller.setSellerAddress(sellerAddress);

					if (sellerService.sellerUpdate(seller) > 0) 
					{
						session.removeAttribute(cookieSellerId);
						session.setAttribute(cookieSellerId, seller.getSellerShopName());
						ajaxResponse.setResponse(0, "Success", seller.getSellerShopName());
					} 
					else 
					{
						ajaxResponse.setResponse(500, "Internal Server error");
					}
				} else {
					// 입력 파라미터가 올바르지 않을 경우
					ajaxResponse.setResponse(400, "Bad Request");
				}
			} else {
				// 사용자정보 없을 경우
				CookieUtil.deleteCookie(request, response, "/", AUTH_COOKIE_NAME);
				ajaxResponse.setResponse(404, "Not Found");
			}
		} else {
			ajaxResponse.setResponse(400, "Bad Request");
		}

		if (logger.isDebugEnabled()) 
		{
			logger.debug("[SellerController]/seller/updateProc response\n" + JsonUtil.toJsonPretty(ajaxResponse));
		}
		return ajaxResponse;
	}

	@RequestMapping(value = "/seller/getSellerProfile", method = RequestMethod.POST)
	@ResponseBody
	public Response<Object> getSellerProfile(HttpServletRequest request, HttpServletResponse response) 
	{
		Response<Object> ajaxResponse = new Response<Object>();
		String cookieSellerId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		if(!StringUtil.isEmpty(cookieSellerId))
		{
			Seller seller = sellerService.sellerIdSelect(cookieSellerId);
			if(StringUtil.equals(cookieSellerId, seller.getSellerId()))
			{
				ajaxResponse.setResponse(0, "Success", seller);
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
	
	// 레스토랑 정보 수정하기 위한 레스토랑 정보 조회
	@RequestMapping(value = "/seller/restoBring")
	public String restoBring(ModelMap model, HttpServletRequest request, HttpServletResponse response) {
		// 쿠키 값
		String cookieSellerId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		// 해당 레스토랑 번호
		String restoSeq = HttpUtil.get(request, "rSeq", "");
		RestoInfo restoInfo = null;
		List<RestoFile> list = null;
		List<Menu> menuList = null;
		MenuFile menuFile = null;
		if (!StringUtil.isEmpty(restoSeq)) {	
			restoInfo = sellerService.restoInfoBring(restoSeq);
			list = sellerService.restoFileBring(restoSeq);
			menuList = sellerService.menuBring(restoSeq);
			for (int i = 0; i < menuList.size(); i++) {
				menuList.get(i).setMenuFileList(sellerService.menuFileBring(menuList.get(i).getMenuSeq()));
			}

			model.addAttribute("menuFile", menuFile);
			model.addAttribute("restoFileList", list);
		}

		model.addAttribute("menuList", menuList);
		model.addAttribute("restoInfo", restoInfo);
		model.addAttribute("cookieSellerId", cookieSellerId);

		return "/seller/restoBring";
	}

	// 레스토랑 정보수정 하기
	@RequestMapping(value = "/seller/restoUpdateProc", method = RequestMethod.POST)
	@ResponseBody
	public Response<Object> restoUpdateProc(MultipartHttpServletRequest request, HttpServletResponse response) {
		Response<Object> ajaxResponse = new Response<Object>();

		String rSeq = HttpUtil.get(request, "rSeq", "");
		String cookieSellerId = CookieUtil.getHexValue(request, "SELLER_ID");
		String restoName = HttpUtil.get(request, "restoName", "");
		String restoAdd = HttpUtil.get(request, "hiddenAdd", "");
		String restoPh = HttpUtil.get(request, "restoPh", "");
		String restoContent = HttpUtil.get(request, "restoContent", "");
		String restoType = HttpUtil.get(request, "restoType", "");
		String restoMenuType = HttpUtil.get(request, "restoMenuType", "");
		String restoOff = HttpUtil.get(request, "hiddenRestoOff", "");
		FileData thumFile = HttpUtil.getFile(request, "restoThum", UPLOAD_SAVE_DIR);
		List<FileData> fileData = HttpUtil.getFiles(request, "restoFile", UPLOAD_SAVE_DIR);
		int restoDeposit = HttpUtil.get(request, "restoDeposit", 0);
		String restoOpen = HttpUtil.get(request, "restoOpen", "");
		String restoClose = HttpUtil.get(request, "restoClose", "");
		int restoLimitPpl = HttpUtil.get(request, "restoLimitPpl", 0);
		int menuCount = HttpUtil.get(request, "menuCount", 0); // 5
		int flag = -1;
		if (!StringUtil.isEmpty(rSeq)) 
		{
			RestoInfo restoInfo = restoService.restoSelect(rSeq);

			if (!StringUtil.isEmpty(restoName) && !StringUtil.isEmpty(restoAdd) && !StringUtil.isEmpty(restoPh)
					&& !StringUtil.isEmpty(restoContent) && !StringUtil.isEmpty(restoType)
					&& !StringUtil.isEmpty(restoMenuType) && !StringUtil.isEmpty(cookieSellerId)) 
			{

				restoInfo.setSellerId(cookieSellerId);
				restoInfo.setRestoName(restoName);
				restoInfo.setRestoAddress(restoAdd);
				restoInfo.setRestoContent(restoContent);
				restoInfo.setRestoPh(restoPh);
				restoInfo.setRestoType(restoType);
				restoInfo.setFoodType(restoMenuType);
				restoInfo.setRestoDeposit(restoDeposit);
				restoInfo.setLimitPerson(restoLimitPpl);
				restoInfo.setRestoOpen(restoOpen);
				restoInfo.setRestoClose(restoClose);
				restoInfo.setRestoOff(restoOff);
				RestoFile restoFile;

				List<RestoFile> restoFileList = new ArrayList<RestoFile>();

				if(thumFile != null && fileData != null) 
				{
					flag = 0;
					if (thumFile.getFileSize() > 0) 
					{
						fileData.add(0, thumFile);
					}
					for (int i = 0; i < fileData.size(); i++) 
					{
						if (fileData.get(i).getFileSize() > 0) 
						{
							restoFile = new RestoFile();
							restoFile.setrSeq(rSeq);
							restoFile.setFileName(fileData.get(i).getFileName());
							restoFileList.add(restoFile);
						}
					}
					restoInfo.setRestoFileList(restoFileList);
				} 
				else if (thumFile != null) 
				{
					flag = 1;
					restoFile = new RestoFile();
					restoFile.setrSeq(rSeq);
					restoFile.setFileName(thumFile.getFileName());
					restoFile.setFileSeq(1);
					restoInfo.setRestoFileList(restoFileList);
					restoFileList.add(restoFile);
				} 
				else if (fileData != null) 
				{
					flag = 2;
					for (int i = 0; i < fileData.size(); i++) 
					{
						if (fileData.get(i).getFileSize() > 0) 
						{
							restoFile = new RestoFile();
							restoFile.setrSeq(rSeq);
							restoFile.setFileName(fileData.get(i).getFileName());
							restoFileList.add(restoFile);
						}
					}
					restoInfo.setRestoFileList(restoFileList);
				}

				List<Menu> menuList = new ArrayList<Menu>();
				MenuFile menuFile = null;
				for (int i = 1; i <= menuCount; i++) 
				{
					Menu menu = new Menu();
					String menuName = HttpUtil.get(request, "menuName" + i, "");
					String menuPrice = HttpUtil.get(request, "menuPrice" + i, "");
					String menuDescription = HttpUtil.get(request, "menuDescription" + i, "");
					FileData getMenuFile = HttpUtil.getFile(request, "menuFile" + i, UPLOAD_SAVE_DIR);
					String orgMenuFileName = HttpUtil.get(request, "orgMenuFileName" + i, "");

					menu.setMenuName(menuName);
					menu.setMenuPrice(menuPrice);
					menu.setMenuContent(menuDescription);
					menu.setrSeq(rSeq);
					if (getMenuFile != null && getMenuFile.getFileSize() > 0) 
					{
						menuFile = new MenuFile();
						menuFile.setFileName(getMenuFile.getFileName());
						menu.setFileName(getMenuFile.getFileName());
					} 
					else 
					{
						menuFile = new MenuFile();
						menuFile.setFileName(orgMenuFileName);
						menu.setFileName(orgMenuFileName);
					}
					menu.setMenuFileList(menuFile);
					menuList.add(menu);
				}

				restoInfo.setMenuList(menuList);

				// 서비스 호출
				try 
				{
					List<RestoFile> orgRestoFileList = sellerService.restoFileBring(restoInfo.getrSeq());
					List<MenuFile> orgMenuFileList = sellerService.menuFileListBring(rSeq);
					
					if(sellerService.restoUpdate(restoInfo, flag) > 0) 
					{
						ajaxResponse.setResponse(0, "success");
						if(flag != -1)
						{
							if(flag == 1)
							{
								if(!StringUtil.equals(orgRestoFileList.get(0).getFileName(), "resto.jpg"))
								{
									FileUtil.deleteFile(UPLOAD_SAVE_DIR + FileUtil.getFileSeparator() + orgRestoFileList.get(0).getFileName());
								}
								orgRestoFileList = null;
							}
							else if(flag == 2)
							{
								orgRestoFileList.remove(0);
							}
							
							if(orgRestoFileList != null && orgRestoFileList.size() > 0)
							{
								for(int i = 0; i < orgRestoFileList.size(); i++)
								{
									if(!StringUtil.equals(orgRestoFileList.get(i).getFileName(), "resto.jpg"))
									{
										FileUtil.deleteFile(UPLOAD_SAVE_DIR + FileUtil.getFileSeparator() + orgRestoFileList.get(i).getFileName());
									}
								}
							}						
						}
						for(int i = 0; i < orgMenuFileList.size(); i++)
						{
							for(int j = 0; j < menuList.size(); j++)
							{
								if(StringUtil.equals(menuList.get(j).getFileName(), orgMenuFileList.get(i).getFileName()))
								{
									orgMenuFileList.remove(i);
								}
							}
						}
						if(orgMenuFileList.size() > 0)
						{
							for(int i = 0; i < orgMenuFileList.size(); i++)
							{
								if(!StringUtil.equals(orgMenuFileList.get(i).getFileName(), "normalMenu.png"))
								{
									FileUtil.deleteFile(UPLOAD_SAVE_DIR + FileUtil.getFileSeparator() + orgMenuFileList.get(i).getFileName());
								}
							}
						}
					} 
					else 
					{
						ajaxResponse.setResponse(500, "Internal server error");
					}
				} 
				catch (Exception e) 
				{
					logger.error("[RestoController] restoProc Exception", e);
					ajaxResponse.setResponse(500, "internal server error");
				}
			} 
			else 
			{
				ajaxResponse.setResponse(400, "Bad Request");
			}

		}
		return ajaxResponse;
	}

	// 선물 정보 수정하기 위한 선물 정보 조회

	@RequestMapping(value = "/seller/giftBring")
	public String giftBring(ModelMap model, HttpServletRequest request, HttpServletResponse response) {
		// 쿠키 값
		String cookieSellerId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		// 해당 선물 번호
		String productSeq = HttpUtil.get(request, "productSeq", "");
		GiftAdd giftAdd = null;
		List<GiftFile> list = null;

		if (!StringUtil.isEmpty(productSeq)) {
			giftAdd = sellerService.giftInfoBring(productSeq);
			list = sellerService.giftFileBring(productSeq);
			model.addAttribute("giftFileList", list);

		}

		// model.addAttribute("boardMe", boardMe);
		model.addAttribute("giftAdd", giftAdd);
		model.addAttribute("cookieSellerId", cookieSellerId);

		return "/seller/giftBring";
	}

	//선물&선물파일 정보 수정(ajax -리턴타입 객체)
	@RequestMapping(value = "/seller/giftUpdateProc", method = RequestMethod.POST)
	@ResponseBody
	public Response<Object> giftUpdateProc(MultipartHttpServletRequest request, HttpServletResponse response) 
	{
		Response<Object> ajaxResponse = new Response<Object>();
		String cookieSellerId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		String productSeq = HttpUtil.get(request, "productSeq", "");
		String giftName = HttpUtil.get(request, "giftName", "");
		String giftPrice = HttpUtil.get(request, "giftPrice", "");
		String giftContent = HttpUtil.get(request, "giftContent", "");
		String giftStatus = HttpUtil.get(request, "giftStatus", "");
		String productCategory = HttpUtil.get(request, "giftCategory", "");
		FileData thumFile = HttpUtil.getFile(request, "giftThum", UPLOAD_SAVE_DIR);
		List<FileData> fileData = HttpUtil.getFiles(request, "detailImage", UPLOAD_SAVE_DIR);
		GiftFile giftFile = null;
		int flag = -1;
		if (!StringUtil.isEmpty(productSeq) && !StringUtil.isEmpty(giftName) && !StringUtil.isEmpty(giftPrice)
				&& !StringUtil.isEmpty(giftContent) && !StringUtil.isEmpty(giftStatus) && !StringUtil.isEmpty(productCategory)) 
		{ 
			GiftAdd giftAdd = new GiftAdd();
			giftAdd.setProductSeq(productSeq);
			giftAdd.setSellerId(cookieSellerId);
			giftAdd.setpName(giftName);
			giftAdd.setpPrice(giftPrice);
			giftAdd.setpContent(giftContent);
			giftAdd.setStatus(giftStatus);
			giftAdd.setProductCategory(productCategory);
			List<GiftFile> giftFileList = new ArrayList<GiftFile>();
			if (thumFile != null && fileData != null) 
			{
				flag = 0;
				if (thumFile.getFileSize() > 0) 
				{
					fileData.add(0, thumFile);
				}
				for (int i = 0; i < fileData.size(); i++) 
				{
					giftFile = new GiftFile();
					giftFile.setFileName(fileData.get(i).getFileName());
					giftFileList.add(giftFile);
				}
				giftAdd.setGiftFileList(giftFileList);
			}
			else if (thumFile != null) 
			{
				flag = 1;
				if (thumFile.getFileSize() > 0) 
				{
					giftFile = new GiftFile();
					giftFile.setFileName(thumFile.getFileName());
					giftFile.setProductSeq(productSeq);
					giftFile.setFileSeq((short)1); 
					giftFileList.add(giftFile);

				}
				giftAdd.setGiftFileList(giftFileList);
			} 
			else if (fileData != null) 
			{
				flag = 2;
				for (int i = 0; i < fileData.size(); i++) 
				{
					giftFile = new GiftFile();
					giftFile.setFileName(fileData.get(i).getFileName());
					giftFileList.add(giftFile);
				}

				giftAdd.setGiftFileList(giftFileList);
			}
			try {
				List<GiftFile> orgGiftFileList = sellerService.giftFileBring(productSeq);
				if (sellerService.giftUpdate(giftAdd, flag) > 0) 
				{
					ajaxResponse.setResponse(0, "success");
					if(flag > -1)
					{
						if(flag == 1)
						{
							if(!StringUtil.equals(orgGiftFileList.get(0).getFileName(), "gift.png"))
							{
								FileUtil.deleteFile(UPLOAD_SAVE_DIR + FileUtil.getFileSeparator() + orgGiftFileList.get(0).getFileName());
							}
							orgGiftFileList = null;
						}
						else if(flag == 2)
						{
							orgGiftFileList.remove(0);
						}
						
						if(orgGiftFileList != null && orgGiftFileList.size() > 0)
						{
							for(int i = 0; i < orgGiftFileList.size(); i++)
							{
								if(!StringUtil.equals(orgGiftFileList.get(i).getFileName(), "gift.png"))
								{
									FileUtil.deleteFile(UPLOAD_SAVE_DIR + FileUtil.getFileSeparator() + orgGiftFileList.get(i).getFileName());
								}
							}
						}
					}
				}
				else 
				{
					ajaxResponse.setResponse(500, "Internal server error");
				}
			}
			catch (Exception e) 
			{
				logger.error("[SellerController] giftUpdateProc Exception", e);
				ajaxResponse.setResponse(500, "internal server error");
			}
		} 
		else 
		{
			ajaxResponse.setResponse(400, "Bad Request");
		}
		return ajaxResponse;
	}

	// 내가 등록한 선물 중 결제된레스토랑리스트

	@RequestMapping(value = "/seller/getRestoOrderList", method = RequestMethod.POST)
	@ResponseBody
	public Response<Object> moreRestoList(HttpServletRequest request, HttpServletResponse response) {
		Response<Object> ajaxResponse = new Response<Object>();
		String searchType = HttpUtil.get(request, "searchType", "");
		String searchValue = HttpUtil.get(request, "searchValue", "");
		long startRow = HttpUtil.get(request, "startRow", (long) 1);
		long endRow = HttpUtil.get(request, "endRow", (long) 10);
		String cookieSellerId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		List<OrderList> restoOrderList = null;
		OrderList search = new OrderList();
		search.setSellerId(cookieSellerId);
		if (startRow > 0 && endRow > 0) {

			if (!StringUtil.isEmpty(searchType) && !StringUtil.isEmpty(searchValue)) {
				search.setSearchType(searchType);
				search.setSearchValue(searchValue);
			}
			search.setStartRow(startRow);
			search.setEndRow(endRow);
			restoOrderList = sellerService.myRestoOrder(search);
			HashMap<String, Object> hashMap = new HashMap<String, Object>();
			hashMap.put("searchType", searchType);
			hashMap.put("searchValue", searchValue);
			hashMap.put("list", restoOrderList);
			ajaxResponse.setResponse(0, "Success", hashMap);

		}

		else {
			ajaxResponse.setResponse(400, "Bad Request");
		}

		return ajaxResponse;
	}

	// 내가 등록한 선물 중 결제된선물리스트

	@RequestMapping(value = "/seller/getGiftOrderList", method = RequestMethod.POST)
	@ResponseBody
	public Response<Object> moreGiftList(HttpServletRequest request, HttpServletResponse response) {
		Response<Object> ajaxResponse = new Response<Object>();
		String searchType = HttpUtil.get(request, "searchType", "");
		String searchValue = HttpUtil.get(request, "searchValue", "");
		long startRow = HttpUtil.get(request, "startRow", (long) 1);
		long endRow = HttpUtil.get(request, "endRow", (long) 10);
		String cookieSellerId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		List<OrderList> giftOrderList = null;
		OrderList search = new OrderList();
		search.setSellerId(cookieSellerId);
		if (startRow > 0 && endRow > 0) {

			if (!StringUtil.isEmpty(searchType) && !StringUtil.isEmpty(searchValue)) {
				search.setSearchType(searchType);
				search.setSearchValue(searchValue);
			}
			search.setStartRow(startRow);
			search.setEndRow(endRow);
			giftOrderList = sellerService.myGiftOrder(search);
			HashMap<String, Object> hashMap = new HashMap<String, Object>();
			hashMap.put("searchType", searchType);
			hashMap.put("searchValue", searchValue);
			hashMap.put("list", giftOrderList);
			ajaxResponse.setResponse(0, "Success", hashMap);

		}

		else {
			ajaxResponse.setResponse(400, "Bad Request");
		}

		return ajaxResponse;
	}

	@RequestMapping(value = "/seller/confirmGiftOrder", method = RequestMethod.POST)
	@ResponseBody
	public Response<Object> confirmGiftOrder(HttpServletRequest request, HttpServletResponse response) {
		Response<Object> ajaxResponse = new Response<Object>();
		String cookieSellerId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		String orderSeq = HttpUtil.get(request, "orderSeq", "");

		if (!StringUtil.isEmpty(orderSeq)) {
			if (sellerService.sellerIdSelect(cookieSellerId) != null) {
				if (sellerService.confirmGiftOrder(orderSeq) > 0) {
					// logger.debug("11111111111111111111111111111111111");
					ajaxResponse.setResponse(0, "Success");
				} else {
					// logger.debug("22222222222222222222222222222222222");
					ajaxResponse.setResponse(500, "DB Sever Error", "서버에서 오류가 발생하였습니다. 다시 시도해 주세요.");
				}
			} else {
				// logger.debug("3333333333333333333333333333");
				ajaxResponse.setResponse(404, "Not Found");
			}
		} else {
			// logger.debug("44444444444444444444444444");
			ajaxResponse.setResponse(400, "Bad Request");
		}

		return ajaxResponse;
	}

	@RequestMapping(value = "/seller/deliveryNumProc", method = RequestMethod.POST)
	@ResponseBody
	public Response<Object> deliveryNumProc(HttpServletRequest request, HttpServletResponse response) {
		Response<Object> ajaxResponse = new Response<Object>();
		String cookieSellerId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		String orderSeq = HttpUtil.get(request, "orderSeq", "");
		String deliverCompany = HttpUtil.get(request, "deliverCompany", "");
		String orderNum = HttpUtil.get(request, "orderNum", "");
		if (!StringUtil.isEmpty(orderSeq) && !StringUtil.isEmpty(deliverCompany) && !StringUtil.isEmpty(orderNum)) {
			HashMap<String, Object> hashMap = new HashMap<String, Object>();
			hashMap.put("cookieSellerId", cookieSellerId);
			hashMap.put("orderSeq", orderSeq);
			hashMap.put("deliverCompany", deliverCompany);
			hashMap.put("orderNum", orderNum);
			try {
				if (sellerService.updateDeliver(hashMap) > 0) {
					ajaxResponse.setResponse(0, "Success", "배송 등록에 성공하셨습니다.");
				} else {
					ajaxResponse.setResponse(500, "DB Sever Error", "서버에서 오류가 발생하였습니다. 다시 시도해 주세요.");
				}
			} catch (Exception e) {
				logger.error("[UserG2Controller](writeReview)", e);
			}
		}
		return ajaxResponse;
	}

	@RequestMapping(value = "/seller/sellerMyPage", method = RequestMethod.GET)
	public String sellerMyPage(HttpServletRequest request, HttpServletResponse response) {
		return "/seller/sellerMyPage";
	}

	@RequestMapping(value = "/seller/getMyThings", method = RequestMethod.POST)
	@ResponseBody
	public Response<Object> getMyThings(HttpServletRequest request, HttpServletResponse response) {
		Response<Object> ajaxResponse = new Response<Object>();
		String cookieSellerId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		int type = HttpUtil.get(request, "type", -1);
		if (type == 0) {
			ajaxResponse.setResponse(0, "Success", sellerService.selectMyResto(cookieSellerId));
		} else if (type == 1) {
			ajaxResponse.setResponse(0, "Success", sellerService.selectMyGift(cookieSellerId));
		} else {
			ajaxResponse.setResponse(400, "Bad Request");
		}
		return ajaxResponse;
	}

	@RequestMapping(value = "/seller/getPeriodRevenue", method = RequestMethod.POST)
	@ResponseBody
	public Response<Object> getPeriodRevenue(HttpServletRequest request, HttpServletResponse response) {
		Response<Object> ajaxResponse = new Response<Object>();
		String cookieSellerId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		String startDate = HttpUtil.get(request, "startDate", "");
		String endDate = HttpUtil.get(request, "endDate", "");
		int listType = HttpUtil.get(request, "listType", -1);
		String searchType = HttpUtil.get(request, "searchType", "");
		if (!StringUtil.isEmpty(searchType) && listType >= 0) {
			if (StringUtil.equals(searchType, "0")) {
				searchType = "";
			}
			HashMap<String, String> hashMap = new HashMap<String, String>();
			hashMap.put("startDate", startDate);
			hashMap.put("endDate", endDate);
			hashMap.put("searchType", searchType);
			hashMap.put("cookieSellerId", cookieSellerId);
			if (listType == 0) {
				ajaxResponse.setResponse(0, "Success", sellerService.selectRestoPeriodRevenue(hashMap));
			} else if (listType == 1) {
				ajaxResponse.setResponse(0, "Success", sellerService.selectGiftPeriodRevenue(hashMap));
			} else {
				ajaxResponse.setResponse(404, "Not Found");
			}
		} else {
			ajaxResponse.setResponse(400, "Bad Request");
		}

		return ajaxResponse;
	}
}
