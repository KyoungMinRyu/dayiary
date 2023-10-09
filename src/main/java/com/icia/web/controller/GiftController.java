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
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.icia.common.model.FileData;
import com.icia.common.util.StringUtil;
import com.icia.web.model.GiftAdd;
import com.icia.web.model.GiftFile;
import com.icia.web.model.Paging;
import com.icia.web.model.Response;
import com.icia.web.model.RestoReview;
import com.icia.web.model.UserG2;
import com.icia.web.service.GiftService;
import com.icia.web.service.UserG2Service;
import com.icia.web.util.CookieUtil;
import com.icia.web.util.HttpUtil;

@Controller("giftController")
public class GiftController {
	private static Logger logger = LoggerFactory.getLogger(GiftController.class);

	private String AUTH_COOKIE_NAME = "SELLER_ID";

	@Value("#{env['auth.cookie.name']}")
	private String AUTH_COOKIE_USER_NAME;

	// 파일 저장 경로
	@Value("#{env['upload.save.dir']}")
	private String UPLOAD_SAVE_DIR;

	@Autowired
	private GiftService giftService;

	@Autowired
	private UserG2Service userG2Service;

	private static final int LIST_COUNT = 12; // 한 페이지에 보여줄 게시물 수
	private static final int PAGE_COUNT = 5; // 페이징 수(밑에 버튼)

	// 판매자 인덱스에서 giftAdd 눌렀을 때 가는 위치
	@RequestMapping(value = "/gift/giftAdd")
	public String giftAdd(HttpServletRequest request, HttpServletResponse response) {
		return "/gift/giftAdd";
	}

	// 선물 등록하기 눌렀을 때 가는 곳
	@RequestMapping(value = "/gift/giftProc", method = RequestMethod.POST)
	@ResponseBody
	public Response<Object> giftProc(MultipartHttpServletRequest request, HttpServletResponse response) {
		Response<Object> ajaxResponse = new Response<Object>();
		String cookieSellerId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		String pName = HttpUtil.get(request, "giftName", "");
		String pPrice = HttpUtil.get(request, "giftPrice", "");
		String pContent = HttpUtil.get(request, "giftContent", "");
		String productCategory = HttpUtil.get(request, "giftCategory", "");
		FileData thumFile = HttpUtil.getFile(request, "giftThum", UPLOAD_SAVE_DIR);
		List<FileData> fileData = HttpUtil.getFiles(request, "product_detail_image", UPLOAD_SAVE_DIR);

		if (!StringUtil.isEmpty(pName) && !StringUtil.isEmpty(pPrice) && !StringUtil.isEmpty(pContent)) {
			GiftAdd giftAdd = new GiftAdd();
			giftAdd.setSellerId(cookieSellerId);
			giftAdd.setpName(pName);
			giftAdd.setpPrice(pPrice);
			giftAdd.setpContent(pContent);
			giftAdd.setProductCategory(productCategory);
			GiftFile giftFile;
			if (thumFile != null && fileData != null && fileData.size() > 0) {
				// 리스트 화
				List<GiftFile> giftFileList = new ArrayList<GiftFile>();
				if (thumFile.getFileSize() > 0) {
					giftFile = new GiftFile();
					giftFile.setFileName(thumFile.getFileName());
					giftFileList.add(giftFile);
				}
				for (int i = 0; i < fileData.size(); i++) {
					if (fileData.get(i).getFileSize() > 0) {
						giftFile = new GiftFile();
						giftFile.setFileName(fileData.get(i).getFileName());
						giftFileList.add(giftFile);
					}
				}
				giftAdd.setGiftFileList(giftFileList);
			}
			// 서비스 호출
			try {
				if (giftService.giftInsert(giftAdd) > 0) {
					ajaxResponse.setResponse(0, "success", giftAdd.getProductSeq());
					logger.debug("[GiftController.giftInsert] 성공 ");
				} 
				else 
				{
					ajaxResponse.setResponse(500, "Internal server error");
				}
			} catch (Exception e) {
				logger.error("[GiftController] giftInsert Exception", e);
				ajaxResponse.setResponse(500, "internal server error");
			}
		} else {
			ajaxResponse.setResponse(400, "Bad Request");
		}

		return ajaxResponse;
	}

	// 선물 리스트 보기
	@RequestMapping(value = "/gift/giftList")
	public String giftList(ModelMap model, HttpServletRequest request, HttpServletResponse response) {
		// 검색조건 가져오기

		String searchType = HttpUtil.get(request, "searchType", "");
		String searchValue = HttpUtil.get(request, "searchValue", "");
		String productSeq = HttpUtil.get(request, "productSeq", "");
		String orderBy = HttpUtil.get(request, "orderBy", "regDesc");
		String productType = HttpUtil.get(request, "productType", "all");
		String searchTypeCategory = HttpUtil.get(request, "searchTypeCategory", "");
		// 등록된 선물 리스트
		List<GiftAdd> list = null;
		// 검색조건용 조회객체
		GiftAdd search = new GiftAdd();

		// 현재 페이지
		long curPage = HttpUtil.get(request, "curPage", (long) 1);
		// 총 게시물 수
		long totalCount = 0;
		// 페이징 객체
		Paging paging = null;

		if (!StringUtil.isEmpty(searchType) && !StringUtil.isEmpty(searchValue)) {
			search.setSearchType(searchType);
			search.setSearchValue(searchValue);

		}

		if (!StringUtil.isEmpty(orderBy)) {
			search.setOrderBy(orderBy);
		}

		if (!StringUtil.equals(productType, "all")) {
			if (!StringUtil.isEmpty(productType)) {
				search.setProductType(productType);
			}
		}

		totalCount = giftService.giftCount(search);

		if (totalCount > 0) {
			paging = new Paging("/gift/giftList", totalCount, LIST_COUNT, PAGE_COUNT, curPage, "curPage");

			search.setStartRow(paging.getStartRow());
			search.setEndRow(paging.getEndRow());
			list = giftService.giftList(search);
		}

		model.addAttribute("productSeq", productSeq);
		model.addAttribute("list", list);
		model.addAttribute("searchType", searchType);
		model.addAttribute("searchValue", searchValue);
		model.addAttribute("curPage", curPage);
		model.addAttribute("paging", paging);
		model.addAttribute("orderBy", orderBy);
		model.addAttribute("productType", productType);
		model.addAttribute("searchTypeCategory", searchTypeCategory);
		return "/gift/giftList";
	}

	// 선물 상세페이지
	@RequestMapping(value = "/gift/giftView")
	public String giftView(ModelMap model, HttpServletRequest request, HttpServletResponse response) {
		// 쿠키 값
		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_USER_NAME);
		// 해당 선물 번호
		String searchType = HttpUtil.get(request, "searchType", "");
		String searchValue = HttpUtil.get(request, "searchValue", "");
		String productSeq = HttpUtil.get(request, "productSeq", "");
		String searchTypeCategory = HttpUtil.get(request, "searchTypeCategory", "");
		String orderBy = HttpUtil.get(request, "orderBy", "regDesc");
		String productType = HttpUtil.get(request, "productType", "all");

		// 현재 페이지
		long curPage = HttpUtil.get(request, "curPage", (long) 1);
		// 본인 글 여부(판매자일 경우 수정 가능하도록)
		// String boardMe = "N";

		GiftAdd giftAdd = null;
		GiftFile giftFile = null;

		List<RestoReview> productReviewList = new ArrayList<RestoReview>();

		if (!StringUtil.isEmpty(productSeq)) {

			HashMap<String, String> hashMap = new HashMap<String, String>();
			hashMap.put("userId", cookieUserId);
			hashMap.put("productSeq", productSeq);
			model.addAttribute("checkFavorite", giftService.selectCheckFavorite(hashMap));
			giftAdd = giftService.giftView(productSeq);
			model.addAttribute("giftFile", giftFile);
			productReviewList = giftService.productReviewList(productSeq);

		} 
		else 
		{
			return "/gift/giftList";
		}

		// model.addAttribute("boardMe", boardMe);
		model.addAttribute("giftAdd", giftAdd);
		model.addAttribute("productType", productType);
		model.addAttribute("orderBy", orderBy);
		model.addAttribute("curPage", curPage);
		model.addAttribute("cookieUserId", cookieUserId);
		model.addAttribute("productSeq", productSeq);
		model.addAttribute("productReviewList", productReviewList);
		model.addAttribute("searchValue", searchValue);
		model.addAttribute("searchType", searchType);
		model.addAttribute("searchTypeCategory", searchTypeCategory);

		// 리스트

		return "/gift/giftView";
	}

	@RequestMapping(value = "/gift/reversalFavorite", method = RequestMethod.POST)
	@ResponseBody
	public Response<Object> reversalFavorite(HttpServletRequest request, HttpServletResponse response) {

		Response<Object> ajaxResponse = new Response<Object>();
		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_USER_NAME);
		int checkFavorite = HttpUtil.get(request, "checkFavorite", -1);
		String productSeq = HttpUtil.get(request, "productSeq", "");
		if (checkFavorite >= 0 && !StringUtil.isEmpty(productSeq)) {
			HashMap<String, String> hashMap = new HashMap<String, String>();
			hashMap.put("userId", cookieUserId);
			hashMap.put("productSeq", productSeq);
			if (checkFavorite == 0) {
				if (giftService.insertProductFavorite(hashMap) > 0) {
					hashMap.put("cnt", "1");
					hashMap.remove("userId");
					ajaxResponse.setResponse(0, "Success", hashMap);
				} else {
					ajaxResponse.setResponse(500, "DB Sever Error");
				}
			} else if (checkFavorite == 1) {
				if (giftService.deleteProductFavorite(hashMap) > 0) {
					hashMap.put("cnt", "0");
					hashMap.remove("userId");
					ajaxResponse.setResponse(0, "Success", hashMap);
				} else {
					ajaxResponse.setResponse(500, "DB Sever Error");
				}
			} else {
				ajaxResponse.setResponse(400, "Bad Request");
			}
		} else {
			ajaxResponse.setResponse(400, "Bad Request");
		}

		return ajaxResponse;
	}

	@RequestMapping(value = "/gift/giftFavoriteList", method = RequestMethod.POST)
	@ResponseBody
	public Response<Object> restoFavoriteList(HttpServletRequest request, HttpServletResponse response) {
		Response<Object> ajaxResponse = new Response<Object>();
		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_USER_NAME);
		if (!StringUtil.isEmpty(cookieUserId)) {
			List<GiftAdd> list = giftService.selectGiftFavoriteList(cookieUserId);
			ajaxResponse.setResponse(0, "Success", list);
		} else {
			ajaxResponse.setResponse(404, "Not Found");
		}
		return ajaxResponse;
	}

	@RequestMapping(value = "/gift/giftOrder")
	public String giftOrder(ModelMap model, HttpServletRequest request, HttpServletResponse response) {

		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_USER_NAME);

		String price = HttpUtil.get(request, "price", "");
		int quantity = HttpUtil.get(request, "quantity", 0);
		int totalPrice = HttpUtil.get(request, "totalPrice", 0);
		String giftFileName = HttpUtil.get(request, "giftFileName", "");
		String giftpName = HttpUtil.get(request, "giftpName", "");
		String giftpContent = HttpUtil.get(request, "giftpContent", "");
		String productSeq = HttpUtil.get(request, "productSeq", "");

		UserG2 user = userG2Service.userIdSelect(cookieUserId);

		if (!StringUtil.isEmpty(cookieUserId)) {
			if (user != null) {
				model.addAttribute("user", user);
			}

			model.addAttribute("price", price);
			model.addAttribute("quantity", quantity);
			model.addAttribute("totalPrice", totalPrice);
			model.addAttribute("giftFileName", giftFileName);
			model.addAttribute("giftpName", giftpName);
			model.addAttribute("giftpContent", giftpContent);
			model.addAttribute("productSeq", productSeq);
		}

		return "/gift/giftOrder";
	}
}
