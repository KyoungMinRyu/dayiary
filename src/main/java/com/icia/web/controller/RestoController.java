package com.icia.web.controller;

import java.text.DecimalFormat;

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
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.icia.common.model.FileData;
import com.icia.common.util.StringUtil;
import com.icia.web.model.Menu;
import com.icia.web.model.MenuFile;
import com.icia.web.model.OrderList;
import com.icia.web.model.Paging;
import com.icia.web.model.Response;
import com.icia.web.model.RestoFile;
import com.icia.web.model.RestoInfo;
import com.icia.web.model.RestoReview;
import com.icia.web.service.RestoService;
import com.icia.web.util.CookieUtil;
import com.icia.web.util.HttpUtil;

import oracle.net.aso.a;

@Controller("restoController")
public class RestoController {

	private static Logger logger = LoggerFactory.getLogger(RestoController.class);

	@Value("#{env['auth.cookie.name']}")
	private String AUTH_COOKIE_NAME;

	// 파일 저장 경로
	@Value("#{env['upload.save.dir']}")
	private String UPLOAD_SAVE_DIR; // 저장 경로

	@Autowired
	private RestoService restoService;

	private static final int LIST_COUNT = 6; // 한 페이지에 보여줄 게시물 수
	private static final int PAGE_COUNT = 5; // 페이징 수(밑에 버튼)

	@RequestMapping(value = "/resto/restoList")
	public String restoList(ModelMap model, HttpServletRequest request, HttpServletResponse response) {
		// 검색조건 가져오기
		String searchTypeLocation = HttpUtil.get(request, "searchTypeLocation", "");
		String searchTypeShop = HttpUtil.get(request, "searchTypeShop", "");
		String searchTypeFood = HttpUtil.get(request, "searchTypeFood", "");
		String searchTypeDate = HttpUtil.get(request, "searchTypeDate", "");
		// String searchTypePrice = HttpUtil.get(request, "searchTypePrice", "");
		// 등록된 레스토랑 리스트
		List<RestoInfo> list = null;
		// 검색조건용 조회객체
		RestoInfo search = new RestoInfo();

		// 현재 페이지
		long curPage = HttpUtil.get(request, "curPage", (long) 1);
		// 총 게시물 수
		long totalCount = 0;
		// 페이징 객체
		Paging paging = null;

		if (!StringUtil.isEmpty(searchTypeLocation)) // 검색조건 있을 시 각각 알맞은 변수에 대입
		{
			search.setSearchTypeLocation(searchTypeLocation);
		}
		if (!StringUtil.isEmpty(searchTypeShop)) {
			search.setSearchTypeShop(searchTypeShop);
		}
		if (!StringUtil.isEmpty(searchTypeFood)) {
			search.setSearchTypeFood(searchTypeFood);
		}
		if (!StringUtil.isEmpty(searchTypeDate)) {
			search.setSearchTypeDate(searchTypeDate);
		}
		totalCount = restoService.restoCount(search);

		if (totalCount > 0) {
			paging = new Paging("/resto/restoList", totalCount, LIST_COUNT, PAGE_COUNT, curPage, "curPage");
			search.setStartRow(paging.getStartRow());
			search.setEndRow(paging.getEndRow());
			list = restoService.restoList(search);
		}
		model.addAttribute("list", list);
		model.addAttribute("searchTypeLocation", searchTypeLocation);
		model.addAttribute("searchTypeShop", searchTypeShop);
		model.addAttribute("searchTypeFood", searchTypeFood);
		model.addAttribute("searchTypeDate", searchTypeDate);
		model.addAttribute("curPage", curPage);
		model.addAttribute("paging", paging);
		return "/resto/restoList";
	}

	@RequestMapping(value = "/resto/restoView")
	public String restoView(ModelMap model, HttpServletRequest request, HttpServletResponse response) {
		// 쿠키 값
		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		// 해당 레스토랑 번호
		String rSeq = HttpUtil.get(request, "rSeq", "");
		// 리스트로 돌아가도 검색조건 유지시키기
		String searchTypeLocation = HttpUtil.get(request, "searchTypeLocation", "");
		String searchTypeShop = HttpUtil.get(request, "searchTypeShop", "");
		String searchTypeFood = HttpUtil.get(request, "searchTypeFood", "");
		String searchTypeDate = HttpUtil.get(request, "searchTypeDate", "");
		// String searchTypePrice = HttpUtil.get(request, "searchTypePrice", "");
		// 현재 페이지
		long curPage = HttpUtil.get(request, "curPage", (long) 1);
		// 본인 글 여부(판매자일 경우 수정 가능하도록)
		String boardMe = "N";
		RestoInfo restoInfo = null;
		List<RestoInfo> bestRestoList = null;
		List<RestoReview> reviewList = null;

		if (!StringUtil.equals(rSeq, "")) {
			restoInfo = restoService.restoView(rSeq);
			bestRestoList = restoService.bestRestList();
			reviewList = restoService.reviewList(rSeq);
			HashMap<String, String> hashMap = new HashMap<String, String>();
			hashMap.put("userId", cookieUserId);
			hashMap.put("rSeq", rSeq);
			model.addAttribute("checkFavorite", restoService.selectCheckFavorite(hashMap));
		}

		model.addAttribute("boardMe", boardMe);
		model.addAttribute("rSeq", rSeq);
		model.addAttribute("restoInfo", restoInfo);
		model.addAttribute("bestRestoList", bestRestoList);
		model.addAttribute("searchTypeLocation", searchTypeLocation);
		model.addAttribute("searchTypeShop", searchTypeShop);
		model.addAttribute("searchTypeFood", searchTypeFood);
		model.addAttribute("searchTypeDate", searchTypeDate);
		model.addAttribute("curPage", curPage);
		model.addAttribute("cookieUserId", cookieUserId);
		model.addAttribute("reviewList", reviewList);

		return "/resto/restoView";
	}

	// 레스토랑 예약건 등록
	@RequestMapping(value = "/resto/restoReservationProc", method = RequestMethod.POST)
	@ResponseBody
	public Response<Object> restoReservationProc(HttpServletRequest request, HttpServletResponse response) {
		Response<Object> ajaxResponse = new Response<Object>();
		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		String rSeq = HttpUtil.get(request, "rSeq", "");

		// 예약 정보
		String orderDate = HttpUtil.get(request, "orderDate", "");
		String orderTime = HttpUtil.get(request, "orderTime", "");
		int orderPerson = HttpUtil.get(request, "orderPerson", (int) 0);

		if (!StringUtil.isEmpty(orderDate) && !StringUtil.isEmpty(orderTime) && !StringUtil.isEmpty(orderPerson)
				&& !StringUtil.isEmpty(cookieUserId)) {
			RestoInfo restoInfo = restoService.restoSelect(rSeq);
			// 해당 레스토랑 정상적으로 등록되어 있는지 확인

			if (restoInfo != null) {
				OrderList orderList = new OrderList(); // 주문정보 등록하기 위한 객체 생성

				// 인서트를 위해 예약날짜, 예약시간, 예약인원, 예약자아이디 세터
				orderList.setReservDate(orderDate);
				orderList.setReservTime(orderTime);
				orderList.setReservPerson(orderPerson);
				orderList.setUserId(cookieUserId);
				orderList.setrSeq(rSeq);

				// 서비스 호출
				try {
					if (restoService.restoReservationInsert(orderList) > 0) // 결제대기중(status:W)상태로 예약건 인서트
					{
						ajaxResponse.setResponse(0, "success");
						ajaxResponse.setMsg(orderList.getOrderSeq()); // 주문번호 보냄.현재는 결제대기중인데 결제 완료시 update하기 위해서 가지고
																		// 다녀야함
					} else {
						ajaxResponse.setResponse(500, "Interal server error");
					}
				} catch (Exception e) {
					logger.error("[RestoController] restoReservationProc Exception", e);
					ajaxResponse.setResponse(500, "internal server error");
				}
			} else {
				ajaxResponse.setResponse(404, "not found");
			}
		} else {
			ajaxResponse.setResponse(400, "Bad Request");
		}

		return ajaxResponse;

	}

	// 레스토랑 예약 시 날짜,시간별 잔여좌석 출력
	@RequestMapping(value = "/resto/limitPersonCheck", method = RequestMethod.POST)
	@ResponseBody
	public Response<Object> limitPersonCheck(HttpServletRequest request, HttpServletResponse response) {
		Response<Object> ajaxResponse = new Response<Object>();
		String rSeq = HttpUtil.get(request, "rSeq", "");
		// 사용자가 선택한 날짜와 시간
		String orderDate = HttpUtil.get(request, "orderDate", "");
		String orderTime = HttpUtil.get(request, "orderTime", "");

		if (!StringUtil.isEmpty(orderDate) && !StringUtil.isEmpty(orderTime)) {
			// xml 쿼리에 대입하기 위한 OrderList 변수 선언
			OrderList orderList = new OrderList();

			// xml 쿼리에 가져가서 검색할 값들 세팅
			orderList.setrSeq(rSeq);
			orderList.setReservDate(orderDate);
			orderList.setReservTime(orderTime);

			// 서비스 호출
			try {
				if (restoService.limitPersonCheck(orderList) > 0) {
					ajaxResponse.setResponse(0, "success");
					ajaxResponse.setData(restoService.limitPersonCheck(orderList));
				} else // 값이 0일 경우? 예약인원이 없으면
				{
					ajaxResponse.setResponse(500, "Interal server error");
					ajaxResponse.setData(restoService.limitPersonCheck(orderList));
				}
			} catch (Exception e) {
				logger.error("[RestoController] restoReservationProc Exception", e);
				ajaxResponse.setResponse(500, "internal server error");
				ajaxResponse.setData(0);
			}
		} else // orderDate나 orderTime이 비어있음
		{
			ajaxResponse.setResponse(400, "Bad Request");
		}

		return ajaxResponse;

	}

	// 레스토랑 예약 성공 후 띄워줄 예약완료 안내 페이지
	@RequestMapping(value = "/resto/restoReserv")
	public String restoReserv(ModelMap model, HttpServletRequest request, HttpServletResponse response) 
	{
		// itemCode는 필수가 아니길래 삭제했음
		String itemName = HttpUtil.get(request, "restoName", ""); // reservationForm에 있는 레스토랑명을 itemName으로 가져옴
		int quantity = HttpUtil.get(request, "orderPerson", (int) 0); // reservationForm에 있는 예약인원수를 quantity로 가져옴
		int deposit = HttpUtil.get(request, "deposit", (int) 0); // reservationForm에 있는 예약금을 가져옴
		String orderDate = HttpUtil.get(request, "orderDate", "");
		String orderTime = HttpUtil.get(request, "orderTime", "");
		String orderSeq = HttpUtil.get(request, "orderSeq", "");
		if (deposit == 0) 
		{
			int totalAmount = HttpUtil.get(request, "totalAmount", (int) 0);
			model.addAttribute("totalAmount", totalAmount);
		} 
		else if (deposit != 0) 
		{
			int totalAmount = quantity * deposit; // 예약인원수 * 예약금을 totalAmount로 사용
			model.addAttribute("totalAmount", totalAmount);
		}
		// 총금액을 30,000 형식으로 변환
		model.addAttribute("itemName", itemName);
		model.addAttribute("quantity", quantity);
		model.addAttribute("orderDate", orderDate);
		model.addAttribute("orderTime", orderTime);
		model.addAttribute("orderSeq", orderSeq);
		return "/resto/restoReserv";
	}
   
	// 판매자 로그인 후 restraunt 네비 눌렀을 때 가는 위치
	@RequestMapping(value = "/resto/restoAdd")
	public String restoAdd(HttpServletRequest request, HttpServletResponse response) {
		return "/resto/restoAdd";
	}

	// 매장 정보 등록
	@RequestMapping(value = "/resto/restoProc", method = RequestMethod.POST)
	@ResponseBody
	public Response<Object> restoProc(MultipartHttpServletRequest request, HttpServletResponse response) 
	{
		Response<Object> ajaxResponse = new Response<Object>();
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

		if (!StringUtil.isEmpty(restoName) && !StringUtil.isEmpty(restoAdd) && !StringUtil.isEmpty(restoPh)
				&& !StringUtil.isEmpty(restoContent) && !StringUtil.isEmpty(restoType)
				&& !StringUtil.isEmpty(restoMenuType) && !StringUtil.isEmpty(cookieSellerId)) {
			RestoInfo restoInfo = new RestoInfo();
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
			List<Menu> menuList = new ArrayList<Menu>();
			for (int i = 0; i < menuCount; i++) {
				Menu menu = new Menu(); // 각 반복에서 새로운 Menu 객체 생성
				MenuFile menuFile1 = new MenuFile(); // 각 반복에서 새로운 MenuFile
				if (i == 0) {
					String menuName = HttpUtil.get(request, "menuName", "");
					String menuPrice = HttpUtil.get(request, "menuPrice", "");
					String menuDescription = HttpUtil.get(request, "menuDescription", "");
					FileData menuFile = HttpUtil.getFile(request, "menuFile", UPLOAD_SAVE_DIR);
					menu.setMenuName(menuName);
					menu.setMenuPrice(menuPrice);
					menu.setMenuContent(menuDescription);
					menuFile1.setFileName(menuFile.getFileName());
					menu.setMenuFileList(menuFile1);
				} else {
					String menuName = HttpUtil.get(request, "menuName" + i);
					String menuPrice = HttpUtil.get(request, "menuPrice" + i);
					String menuDescription = HttpUtil.get(request, "menuDescription" + i);
					FileData menuFile = HttpUtil.getFile(request, "menuFile" + i, UPLOAD_SAVE_DIR);
					menu.setMenuName(menuName);
					menu.setMenuPrice(menuPrice);
					menu.setMenuContent(menuDescription);
					menuFile1.setFileName(menuFile.getFileName());
					menu.setMenuFileList(menuFile1);
				}
				menuList.add(menu);
			}
			restoInfo.setMenuList(menuList);
			if (thumFile != null && fileData != null && fileData.size() > 0 && menuCount > 0) {
				List<RestoFile> restoFileList = new ArrayList<RestoFile>();
				if (thumFile.getFileSize() > 0) {
					restoFile = new RestoFile();
					restoFile.setFileName(thumFile.getFileName());
					restoFileList.add(restoFile);
				}
				for (int i = 0; i < fileData.size(); i++) {
					if (fileData.get(i).getFileSize() > 0) {
						restoFile = new RestoFile();

						restoFile.setFileName(fileData.get(i).getFileName());

						restoFileList.add(restoFile);
					}
				}
				restoInfo.setRestoFileList(restoFileList);
			}
			try {
				if (restoService.restoListInsert(restoInfo) > 0) {
					ajaxResponse.setResponse(0, "success");
				} else {
					ajaxResponse.setResponse(500, "Internal server error");
				}
			} catch (Exception e) {
				logger.error("[RestoController] restoProc Exception", e);
				ajaxResponse.setResponse(500, "internal server error");
			}
		} else {
			ajaxResponse.setResponse(400, "Bad Request");
		}
		return ajaxResponse;

	}

	@RequestMapping(value = "/resto/reversalFavorite", method = RequestMethod.POST)
	@ResponseBody
	public Response<Object> reversalFavorite(HttpServletRequest request, HttpServletResponse response) 
	{
		Response<Object> ajaxResponse = new Response<Object>();
		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		int checkFavorite = HttpUtil.get(request, "checkFavorite", -1);
		String rSeq = HttpUtil.get(request, "rSeq", "");
		if(checkFavorite >= 0 && !StringUtil.isEmpty(rSeq))
		{
			HashMap<String, String>hashMap = new HashMap<String, String>();
			hashMap.put("userId", cookieUserId);
			hashMap.put("rSeq", rSeq);
			if(checkFavorite == 0)
			{
				if(restoService.insertRestoFavorite(hashMap) > 0)
				{
					hashMap.put("cnt", "1");
					hashMap.remove("userId");
					ajaxResponse.setResponse(0, "Success", hashMap);
				}
				else
				{
					ajaxResponse.setResponse(500, "DB Sever Error");
				}
			}
			else if(checkFavorite == 1)
			{
				if(restoService.deleteRestoFavorite(hashMap) > 0)
				{
					hashMap.put("cnt", "0");
					hashMap.remove("userId");
					ajaxResponse.setResponse(0, "Success", hashMap);
				}
				else
				{
					ajaxResponse.setResponse(500, "DB Sever Error");
				}
			}
			else
			{
				ajaxResponse.setResponse(400, "Bad Request");
			}
		}
		else
		{
			ajaxResponse.setResponse(400, "Bad Request");
		}
		
		return ajaxResponse;
	}
	
	@RequestMapping(value = "/resto/restoReservationUpdate", method = RequestMethod.POST)
	@ResponseBody
	public Response<Object> restoReservationUpdate(HttpServletRequest request, HttpServletResponse resonse) {
		Response<Object> ajaxResponse = new Response<Object>();
		String orderSeq = HttpUtil.get(request, "orderSeq", "");

		logger.debug("예약업데이트 시도 시 주문번호" + orderSeq);

		if (!StringUtil.isEmpty(orderSeq) && !StringUtil.equals(orderSeq, "")) {
			if (restoService.restoReservationUpdate(orderSeq) > 0) {
				ajaxResponse.setResponse(0, "success");
			} else // 주문정보가 존재하지 않음(DB ORDER_LIST에)
			{
				ajaxResponse.setResponse(404, "NOT FOUND");
			}
		} else // 주문번호(orderSeq) 못가져왔음
		{
			ajaxResponse.setResponse(400, "bad request");
		}

		return ajaxResponse;
	}
	
	@RequestMapping(value = "/resto/restoFavoriteList", method = RequestMethod.POST)
	@ResponseBody
	public Response<Object> restoFavoriteList(HttpServletRequest request, HttpServletResponse response) {
		Response<Object> ajaxResponse = new Response<Object>();
		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		if (!StringUtil.isEmpty(cookieUserId)) {
			List<RestoInfo> list = restoService.selectRestoFavoriteList(cookieUserId);
			ajaxResponse.setResponse(0, "Success", list);
		} else {
			ajaxResponse.setResponse(404, "Not Found");
		}
		return ajaxResponse;
	}

	@RequestMapping(value = "/resto/noneUserRestoReservationProc")
	public void noneUserRestoReservationProc(HttpServletRequest request, HttpServletResponse response) {
	}
}
