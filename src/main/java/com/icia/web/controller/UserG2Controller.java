package com.icia.web.controller;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
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
import org.springframework.web.servlet.ModelAndView;

import com.icia.common.model.FileData;
import com.icia.common.util.StringUtil;
import com.icia.web.model.Anniversary;
import com.icia.web.model.CoupleAnniversary;
import com.icia.web.model.Friend;
import com.icia.web.model.MainBoard;
import com.icia.web.model.OrderList;
import com.icia.web.model.Paging;
import com.icia.web.model.Response;
import com.icia.web.model.RestoInfo;
import com.icia.web.model.UserG2;
import com.icia.web.service.AnniversaryService;
import com.icia.web.service.FriendService;
import com.icia.web.service.MainBoardService;
import com.icia.web.service.RestoService;
import com.icia.web.service.SendMsgService;
import com.icia.web.service.UserG2Service;
import com.icia.web.util.CookieUtil;
import com.icia.web.util.HttpUtil;
import com.icia.web.util.JsonUtil;
import com.icia.web.util.NaverApi;

@Controller("userG2Controller")
public class UserG2Controller {
	private static Logger logger = LoggerFactory.getLogger(UserG2Controller.class);

	// 쿠키명
	@Value("#{env['auth.cookie.name']}")
	private String AUTH_COOKIE_NAME;

	// 파일 저장 경로
	@Value("#{env['upload.save.dir']}")
	private String UPLOAD_SAVE_DIR;

	@Autowired
	private UserG2Service userG2Service;

	@Autowired
	private HttpSession session; // HttpSession 객체를 주입받음

	@Autowired
	private FriendService friendService;

	@Autowired
	private MainBoardService mainBoardService;

	@Autowired
	private AnniversaryService anniversaryService;

	@Autowired
	private SendMsgService sendMsgService;

	@Autowired
	private RestoService restoService;

	private static final int LIST_COUNT = 3; // 한 페이지에 보여줄 게시물 수
	private static final int PAGE_COUNT = 5; // 페이징 수(밑에 버튼)

	// 로그인페이지
	@RequestMapping(value = "/user/login", method = RequestMethod.GET)
	public String login(HttpServletRequest request, HttpServletResponse response) {
		return "/user/login";
	}

	// 로그인
	@RequestMapping(value = "/user/loginProc", method = RequestMethod.POST)
	@ResponseBody
	public Response<Object> loginProc(HttpServletRequest request, HttpServletResponse response) {
		String userId = HttpUtil.get(request, "userId");
		String userPwd = HttpUtil.get(request, "userPwd");
		Response<Object> ajaxResponse = new Response<Object>();

		if (!StringUtil.isEmpty(userId) && !StringUtil.isEmpty(userPwd)) {
			UserG2 userG2 = userG2Service.userIdSelect(userId);

			if (userG2 != null) {
				if (StringUtil.equals(userG2.getUserPwd(), userPwd)) {
					CookieUtil.addCookie(response, "/", -1, AUTH_COOKIE_NAME, CookieUtil.stringToHex(userId));
					Friend friend = (Friend) session.getAttribute(userId);
					if (friend == null) {
						session.setAttribute(userId, friendService.selectUser(userId));
					} else {
						Friend search = friendService.selectUser(userId);
						if (!StringUtil.equals(friend.getUserNickName(), search.getUserNickName())
								|| !StringUtil.equals(friend.getFileName(), search.getFileName())) {
							session.setAttribute(userId, search);
						}
					}
					if (StringUtil.equals(userId, "adm")) {
						ajaxResponse.setResponse(1, "Success"); // 로그인 성공 //adm 관리자
					} else {
						ajaxResponse.setResponse(0, "Success"); // 로그인 성공
					}
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
			logger.debug("[UserController] /user/login response\n" + JsonUtil.toJsonPretty(ajaxResponse));
		}

		return ajaxResponse;
	}

	// 로그아웃
	@RequestMapping(value = "/user/logout", method = RequestMethod.GET)
	public String logout(HttpServletRequest request, HttpServletResponse response) {
		if (CookieUtil.getCookie(request, AUTH_COOKIE_NAME) != null) {
			session.removeAttribute(CookieUtil.getHexValue(request, AUTH_COOKIE_NAME));
			CookieUtil.deleteCookie(request, response, "/", AUTH_COOKIE_NAME);
		}
		return "redirect:/";
	}

	// 회원가입 페이지 경로
	@RequestMapping(value = "/user/signUp", method = RequestMethod.GET)
	public String signUp(HttpServletRequest request, HttpServletResponse response) {
		return "/user/signUp";
	}

	// 아이디 찾기 페이지 경로
	@RequestMapping(value = "/user/lostId", method = RequestMethod.GET)
	public String lostId(HttpServletRequest request, HttpServletResponse response) {
		return "/user/lostId";
	}

	// 비밀번호 찾기 페이지 경로
	@RequestMapping(value = "/user/lostPwd", method = RequestMethod.GET)
	public String lostPwd(HttpServletRequest request, HttpServletResponse response) {
		return "/user/lostPwd";
	}

	// 휴대폰 인증번호 발송 Ajax통신
	@RequestMapping(value = "/user/userPhCheck", method = RequestMethod.POST)
	@ResponseBody
	public Response<Object> userPhCheck(HttpServletRequest request, HttpServletResponse response) {
		Response<Object> ajaxResponse = new Response<Object>();
		String userPh = HttpUtil.get(request, "userPh");
		if (!StringUtil.isEmpty(userPh)) {
			String ranNum = new NaverApi().naverSENSApi(userPh);
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
	@RequestMapping(value = "/user/userIdCheckAjax", method = RequestMethod.POST)
	@ResponseBody
	public Response<Object> userIdCheckAjax(HttpServletRequest request, HttpServletResponse response) {
		Response<Object> ajaxResponse = new Response<Object>();
		String userId = HttpUtil.get(request, "userId");
		if (!StringUtil.isEmpty(userId)) {
			if (userG2Service.userIdSelect(userId) == null) {
				ajaxResponse.setResponse(0, "success");
			} else {
				ajaxResponse.setResponse(100, "Deplicate ID");
			}
		} else {
			ajaxResponse.setResponse(400, "Bad Request");
		}
		if (logger.isDebugEnabled()) {
			logger.debug("[userG2Controller]/user/userIdCheckAjax response\n" + JsonUtil.toJsonPretty(ajaxResponse));
		}
		return ajaxResponse;
	}

	// 닉네임 중복체크 Ajax통신
	@RequestMapping(value = "/user/userNickNameAjax", method = RequestMethod.POST)
	@ResponseBody
	public Response<Object> userNickNameAjax(HttpServletRequest request, HttpServletResponse response) {
		Response<Object> ajaxResponse = new Response<Object>();
		String userNickName = HttpUtil.get(request, "userNickName");

		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		UserG2 currentUser = userG2Service.userIdSelect(cookieUserId);
		String currentNickName = currentUser != null ? currentUser.getUserNickName() : null;

		if (!StringUtil.isEmpty(userNickName)) {
			if (userNickName.equals(currentNickName)) {
				ajaxResponse.setResponse(0, "success"); // 닉네임이 변경되지 않았으므로 성공 응답을 반환합니다.
			} else if (userG2Service.userNickNameSelect(userNickName) == null) {
				ajaxResponse.setResponse(0, "success");
			} else {
				ajaxResponse.setResponse(100, "Duplicate ID");
			}
		} else {
			ajaxResponse.setResponse(400, "Bad Request");
		}

		if (logger.isDebugEnabled()) {
			logger.debug("[userG2Controller]/user/userNickNameAjax response\n" + JsonUtil.toJsonPretty(ajaxResponse));
		}

		return ajaxResponse;
	}

	// 회원가입 버튼 클릭시 Ajax 통신
	@RequestMapping(value = "/user/userProc", method = RequestMethod.POST)
	@ResponseBody
	public Response<Object> userProc(HttpServletRequest request, HttpServletResponse response) {
		Response<Object> ajaxResponse = new Response<Object>();
		String userId = HttpUtil.get(request, "userId");
		String userPwd = HttpUtil.get(request, "userPwd");
		String userEmail = HttpUtil.get(request, "userEmail");
		String userName = HttpUtil.get(request, "userName");
		String userNickName = HttpUtil.get(request, "userNickName");
		String userBir = HttpUtil.get(request, "userBir");
		String userGen = HttpUtil.get(request, "userGen");
		String userPh = HttpUtil.get(request, "userPh");
		String userChPh = HttpUtil.get(request, "userChPh"); // 1 사용가능
		String userAdd = HttpUtil.get(request, "userAdd");

		if (StringUtil.equals(userChPh, "1")) {
			if (!StringUtil.isEmpty(userId) && !StringUtil.isEmpty(userPwd) && !StringUtil.isEmpty(userEmail)
					&& !StringUtil.isEmpty(userName) && !StringUtil.isEmpty(userNickName)
					&& !StringUtil.isEmpty(userBir) && !StringUtil.isEmpty(userGen) && !StringUtil.isEmpty(userPh)
					&& !StringUtil.isEmpty(userAdd)) {
				if (userG2Service.userIdSelect(userId) == null
						&& userG2Service.userNickNameSelect(userNickName) == null) {
					UserG2 userG2 = new UserG2();
					userG2.setUserId(userId);
					userG2.setUserPwd(userPwd);
					userG2.setUserEmail(userEmail);
					userG2.setUserName(userName);
					userG2.setUserNickName(userNickName);
					userG2.setUserPh(userPh);
					userG2.setUserGen(userGen);
					userG2.setUserBir(userBir);
					userG2.setUserAddress(userAdd);
					if (userG2Service.userInsert(userG2) > 0) {
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
			logger.debug("[userG2Controller]/user/userProc response\n" + JsonUtil.toJsonPretty(ajaxResponse));
		}
		return ajaxResponse;
	}

	// 이메일 인증 성공 시 보낼 경로
	@RequestMapping(value = "/user/userMailSuccess", method = RequestMethod.GET)
	public String userMailSuccess(HttpServletRequest request, HttpServletResponse response) {
		return "/user/userMailSuccess";
	}

	// 이메일 인증 실패 시 보낼 경로
	@RequestMapping(value = "/user/userMailFail", method = RequestMethod.GET)
	public String userMailFail(HttpServletRequest request, HttpServletResponse response) {
		return "/user/userMailFail";
	}

	// 이메일 인증 시 시간이 지났을 떄 보낼 경로
	@RequestMapping(value = "/user/userMailTimeOut", method = RequestMethod.GET)
	public String userMailTimeOut(HttpServletRequest request, HttpServletResponse response) {
		return "/user/userMailTimeOut";
	}

	// 아이디 찾기 Proc
	@RequestMapping(value = "/user/lostIdProc", method = RequestMethod.POST)
	@ResponseBody
	public Response<Object> lostIdProc(HttpServletRequest request, HttpServletResponse response) {
		Response<Object> ajaxResponse = new Response<Object>();
		Map<String, String> params = extractParams(request);

		if (!params.isEmpty()) {
			UserG2 userG2 = userG2Service.lostIdFind(params);
			if (userG2 != null) {
				request.getSession().setAttribute("foundUserId", userG2.getUserId());
				ajaxResponse.setResponse(0, "Success", userG2.getUserId()); // userId를 data로 설정

			} else {
				ajaxResponse.setResponse(404, "Not Found");
			}
		} else {
			ajaxResponse.setResponse(400, "Bad Request");
		}
		return ajaxResponse;
	}

	// 아이디 찾기 결과창
	@RequestMapping(value = "/user/findId", method = RequestMethod.GET)
	public String findId(ModelMap modelMap, HttpServletRequest request) {
		String userId = (String) request.getSession().getAttribute("foundUserId");
		if (userId != null) {
			modelMap.addAttribute("userId", userId);
			request.getSession().removeAttribute("foundUserId"); // 세션에서 userId 제거
		}
		return "/user/findId";
	}

	// 중복된 부분을 메서드로 추출
	private Map<String, String> extractParams(HttpServletRequest request) {
		String userName = request.getParameter("userName");
		String userEmail = request.getParameter("userEmail");

		Map<String, String> params = new HashMap<String, String>();
		params.put("userName", userName);
		params.put("userEmail", userEmail);

		return params;
	}

	// 비밀번호찾기
	@RequestMapping(value = "/user/lostPwdProc", method = RequestMethod.POST)
	@ResponseBody
	public Response<Object> lostPwdProc(HttpServletRequest request, HttpServletResponse response) {
		Response<Object> ajaxResponse = new Response<Object>();
		String userId = HttpUtil.get(request, "userId");
		String userName = HttpUtil.get(request, "userName");
		String userEmail = HttpUtil.get(request, "userEmail");

		UserG2 userG2 = new UserG2();
		userG2.setUserId(userId);
		userG2.setUserName(userName);
		userG2.setUserEmail(userEmail);

		if (!StringUtil.isEmpty(userId) && !StringUtil.isEmpty(userName) && !StringUtil.isEmpty(userEmail)) {
			if (userG2Service.pwdCheck(userG2) == 1) {
				ajaxResponse.setResponse(0, "사용자 정보가 일치합니다.");

			} else {
				ajaxResponse.setResponse(400, "사용자 정보가 일치하지 않습니다.");
			}
		}

		return ajaxResponse;
	}

	@RequestMapping(value = "/user/userOrderList", method = RequestMethod.GET)
	public String userOrderList(ModelMap modelMap, HttpServletRequest request, HttpServletResponse response) {
		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		List<OrderList> restoOrderList = null;
		OrderList search = new OrderList();
		search.setUserId(cookieUserId);

		int totalCount = userG2Service.selectRestoOrderTotalCnt(search);
		if (totalCount > 0) {
			search.setStartRow(1);
			search.setEndRow(10);
			restoOrderList = userG2Service.selectRestoOrderList(search);
		}
		modelMap.addAttribute("restoOrderList", restoOrderList);
		modelMap.addAttribute("listType", "0");
		modelMap.addAttribute("totalCount", totalCount);
		return "/user/userOrderList";
	}

	@RequestMapping(value = "/user/getMoreRestoList", method = RequestMethod.POST)
	@ResponseBody
	public Response<Object> getMoreRestoList(HttpServletRequest request, HttpServletResponse response) {
		Response<Object> ajaxResponse = new Response<Object>();
		String searchType = HttpUtil.get(request, "searchType", "");
		String searchValue = HttpUtil.get(request, "searchValue", "");
		long startRow = HttpUtil.get(request, "startRow", (long) 1);
		long endRow = HttpUtil.get(request, "endRow", (long) 10);
		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		List<OrderList> restoOrderList = null;
		OrderList search = new OrderList();
		search.setUserId(cookieUserId);
		if (startRow > 0 && endRow > 0) {
			if (userG2Service.userIdSelect(cookieUserId) != null) {
				if (!StringUtil.isEmpty(searchType) && !StringUtil.isEmpty(searchValue)) {
					search.setSearchType(searchType);
					search.setSearchValue(searchValue);
				}
				search.setStartRow(startRow);
				search.setEndRow(endRow);
				restoOrderList = userG2Service.selectRestoOrderList(search);
				HashMap<String, Object> hashMap = new HashMap<String, Object>();
				hashMap.put("searchType", searchType);
				hashMap.put("searchValue", searchValue);
				hashMap.put("list", restoOrderList);
				ajaxResponse.setResponse(0, "Success", hashMap);
			} else {
				ajaxResponse.setResponse(404, "Not Found");
			}
		} else {
			ajaxResponse.setResponse(400, "Bad Request");
		}

		return ajaxResponse;
	}

	@RequestMapping(value = "/user/getMoreProductList", method = RequestMethod.POST)
	@ResponseBody
	public Response<Object> getMoreProductList(HttpServletRequest request, HttpServletResponse response) {
		Response<Object> ajaxResponse = new Response<Object>();
		String searchType = HttpUtil.get(request, "searchType", "");
		String searchValue = HttpUtil.get(request, "searchValue", "");
		long startRow = HttpUtil.get(request, "startRow", (long) 1);
		long endRow = HttpUtil.get(request, "endRow", (long) 10);
		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		List<OrderList> restoOrderList = null;
		OrderList search = new OrderList();
		search.setUserId(cookieUserId);
		if (startRow > 0 && endRow > 0) {
			if (userG2Service.userIdSelect(cookieUserId) != null) {
				if (!StringUtil.isEmpty(searchType) && !StringUtil.isEmpty(searchValue)) {
					search.setSearchType(searchType);
					search.setSearchValue(searchValue);
				}
				search.setStartRow(startRow);
				search.setEndRow(endRow);
				restoOrderList = userG2Service.selectProductOrderList(search);
				HashMap<String, Object> hashMap = new HashMap<String, Object>();
				hashMap.put("searchType", searchType);
				hashMap.put("searchValue", searchValue);
				hashMap.put("list", restoOrderList);
				ajaxResponse.setResponse(0, "Success", hashMap);
			} else {
				ajaxResponse.setResponse(404, "Not Found");
			}
		} else {
			ajaxResponse.setResponse(400, "Bad Request");
		}
		return ajaxResponse;
	}

	@RequestMapping(value = "/user/getTotalCount", method = RequestMethod.POST)
	@ResponseBody
	public Response<Object> getTotalCount(HttpServletRequest request, HttpServletResponse response) {
		Response<Object> ajaxResponse = new Response<Object>();
		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		String type = HttpUtil.get(request, "type", "");
		if (!StringUtil.isEmpty(type)) {
			if (userG2Service.userIdSelect(cookieUserId) != null) {
				OrderList search = new OrderList();
				search.setUserId(cookieUserId);
				if (StringUtil.equals("0", type)) {
					ajaxResponse.setResponse(0, "Success", userG2Service.selectRestoOrderTotalCnt(search));
				} else if (StringUtil.equals("1", type)) {
					ajaxResponse.setResponse(0, "Sucess", userG2Service.selectProductOrderTotalCount(search));
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

	@RequestMapping(value = "/user/cancleReserv", method = RequestMethod.POST)
	@ResponseBody
	public Response<Object> cancleReserv(HttpServletRequest request, HttpServletResponse response) {
		Response<Object> ajaxResponse = new Response<Object>();
		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		String orderSeq = HttpUtil.get(request, "orderSeq", "");
		if (!StringUtil.isEmpty(orderSeq)) {
			if (userG2Service.userIdSelect(cookieUserId) != null) {
				if (StringUtil.equals(cookieUserId, userG2Service.selectMyOrder(orderSeq))) {
					try {
						if (userG2Service.cancleReserv(orderSeq) > 0) {
							ajaxResponse.setResponse(0, "Success", "예약 취소되었습니다.");
						} else {
							ajaxResponse.setResponse(500, "DB Sever Error", "서버에서 오류가 발생하였습니다. 다시 시도해 주세요.");
						}
					} catch (Exception e) {
						logger.error("[UserG2Controller](cancleReserv)", e);
					}
				} else {
					ajaxResponse.setResponse(100, "주문번호가 잘못 되었거나 본인 주문번호가 아닙니다.");
				}
			} else {
				ajaxResponse.setResponse(404, "Not Found");
			}
		} else {
			ajaxResponse.setResponse(400, "Bad Request");
		}
		return ajaxResponse;
	}

	@RequestMapping(value = "/user/writeReview", method = RequestMethod.POST)
	@ResponseBody
	public Response<Object> writeReview(HttpServletRequest request, HttpServletResponse response) {
		Response<Object> ajaxResponse = new Response<Object>();
		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		String orderSeq = HttpUtil.get(request, "orderSeq", "");
		int reviewNum = HttpUtil.get(request, "reviewNum", -1);
		String reviewComment = HttpUtil.get(request, "reviewComment", "");
		if (!StringUtil.isEmpty(orderSeq) && !StringUtil.isEmpty(reviewComment) && reviewNum >= 0) {
			if (StringUtil.equals(cookieUserId, userG2Service.selectMyOrder(orderSeq))) {
				HashMap<String, Object> hashMap = new HashMap<String, Object>();
				hashMap.put("orderSeq", orderSeq);
				hashMap.put("reviewComment", reviewComment);
				hashMap.put("reviewNum", reviewNum);
				try {
					if (userG2Service.insertReview(hashMap) > 0) {
						ajaxResponse.setResponse(0, "Success", "리뷰 등록에 성공하셨습니다.");
					} else {
						ajaxResponse.setResponse(500, "DB Sever Error", "서버에서 오류가 발생하였습니다. 다시 시도해 주세요.");
					}
				} catch (Exception e) {
					logger.error("[UserG2Controller](writeReview)", e);
				}
			} else {
				ajaxResponse.setResponse(404, "Not Found");
			}
		} else {
			ajaxResponse.setResponse(400, "Bad Request");
		}
		return ajaxResponse;
	}

	@RequestMapping(value = "/user/cancleOrder", method = RequestMethod.POST)
	@ResponseBody
	public Response<Object> cancleOrder(HttpServletRequest request, HttpServletResponse response) {
		Response<Object> ajaxResponse = new Response<Object>();
		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		String orderSeq = HttpUtil.get(request, "orderSeq", "");
		if (!StringUtil.isEmpty(orderSeq)) {
			if (userG2Service.userIdSelect(cookieUserId) != null) {
				if (StringUtil.equals(cookieUserId, userG2Service.selectMyOrder(orderSeq))) {
					try {
						if (userG2Service.cancleOrder(orderSeq) > 0) {
							ajaxResponse.setResponse(0, "Success", "주문 취소되었습니다.");
						} else {
							ajaxResponse.setResponse(500, "DB Sever Error", "서버에서 오류가 발생하였습니다. 다시 시도해 주세요.");
						}
					} catch (Exception e) {
						logger.error("[UserG2Controller](cancleReserv)", e);
					}
				} else {
					ajaxResponse.setResponse(100, "주문번호가 잘못 되었거나 본인 주문번호가 아닙니다.");
				}
			} else {
				ajaxResponse.setResponse(404, "Not Found");
			}
		} else {
			ajaxResponse.setResponse(400, "Bad Request");
		}
		return ajaxResponse;
	}

	@RequestMapping(value = "/user/giftOrderDetail", method = RequestMethod.POST)
	@ResponseBody
	public Response<Object> giftOrderDetail(HttpServletRequest request, HttpServletResponse response) {
		Response<Object> ajaxResponse = new Response<Object>();
		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		String orderSeq = HttpUtil.get(request, "orderSeq", "");
		if (!StringUtil.isEmpty(orderSeq)) {
			if (userG2Service.userIdSelect(cookieUserId) != null) {
				if (StringUtil.equals(cookieUserId, userG2Service.selectMyOrder(orderSeq))) {
					ajaxResponse.setResponse(0, "Success", userG2Service.selectGiftOrderDetail(orderSeq));
				} else {
					ajaxResponse.setResponse(404, "Not Found");
				}
			} else {
				ajaxResponse.setResponse(404, "Not Found");
			}
		} else {
			ajaxResponse.setResponse(400, "Bad Request");
		}
		return ajaxResponse;
	}

	@RequestMapping(value = "/user/restoOrderDetail", method = RequestMethod.POST)
	@ResponseBody
	public Response<Object> restoOrderDetail(HttpServletRequest request, HttpServletResponse response) {
		Response<Object> ajaxResponse = new Response<Object>();
		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		String orderSeq = HttpUtil.get(request, "orderSeq", "");
		if (!StringUtil.isEmpty(orderSeq)) {
			if (userG2Service.userIdSelect(cookieUserId) != null) {
				if (StringUtil.equals(cookieUserId, userG2Service.selectMyOrder(orderSeq))) {
					ajaxResponse.setResponse(0, "Success", userG2Service.selectRestoOrderDetail(orderSeq));
				} else {
					ajaxResponse.setResponse(404, "Not Found");
				}
			} else {
				ajaxResponse.setResponse(404, "Not Found");
			}
		} else {
			ajaxResponse.setResponse(400, "Bad Request");
		}
		return ajaxResponse;
	}

	@RequestMapping(value = "/user/userMyPage")
	public String userMyPage(ModelMap model, HttpServletRequest request, HttpServletResponse response) {

		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		UserG2 user = userG2Service.userIdSelect(cookieUserId);
		String profileImageFileName = userG2Service.getProfileImageFileNameByUserId(cookieUserId);
		HashMap<String, String> hashMap = new HashMap<String, String>();
		hashMap.put("userId", cookieUserId);
		hashMap.put("yourId", cookieUserId);
		Friend friend = friendService.selectYourUser(hashMap);
		int toCount = sendMsgService.toCount(cookieUserId); // 보낸 쪽지 개수
		int fromCount = sendMsgService.fromCount(cookieUserId); // 받은 쪽지 개수

		model.addAttribute("toCount", toCount);
		model.addAttribute("fromCount", fromCount);

		if (friend != null) {

			Friend yourFriend = friendService.selectYourId(cookieUserId);

			if (yourFriend != null) {

				model.addAttribute("myId", yourFriend.getMyId());
				model.addAttribute("yourId", yourFriend.getYourId());
				model.addAttribute("yourProfileImage", yourFriend.getYourProfileImage());
				model.addAttribute("myBir", yourFriend.getMyBir());
				model.addAttribute("yourBir", yourFriend.getYourBir());
				model.addAttribute("myName", yourFriend.getMyName());
				model.addAttribute("yourName", yourFriend.getYourName());
				model.addAttribute("myGen", yourFriend.getMyGen());
				model.addAttribute("yourGen", yourFriend.getYourGen());
				model.addAttribute("yourFriend", yourFriend);
				CoupleAnniversary coupleAnniversary = anniversaryService.selectCoupleAnniversary(cookieUserId);
				model.addAttribute("coupleAnniversary", coupleAnniversary);

				List<Anniversary> anniversaryFriend = anniversaryService.selectFriendBirProfile(cookieUserId);
				List<Anniversary> selectcouple = anniversaryService.selectCoupleDate(cookieUserId);
				if (anniversaryFriend != null) {
					if (selectcouple != null) {
						model.addAttribute("selectcouple1", selectcouple.get(0));
						model.addAttribute("selectcouple0", selectcouple);
					}

					model.addAttribute("anniversaryFriend", anniversaryFriend.get(0));
					model.addAttribute("anniversaryFriend0", anniversaryFriend);
					DateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
					String currentDate = dateFormat.format(new Date());
					model.addAttribute("currentDate", currentDate);

				}

			}
			if (!StringUtil.isEmpty(profileImageFileName)) {

				model.addAttribute("url", profileImageFileName);

			} else {

				model.addAttribute("url", "/resources/images/profile.png");

			}
		}

		model.addAttribute("friend", friend);
		model.addAttribute("user", user);

		return "/user/userMyPage";
	}

	// 마이페이지 회원정보 수정 경로
	@RequestMapping(value = "/user/updateuserForm", method = RequestMethod.GET)
	public String updateuserForm(ModelMap model, HttpServletRequest request, HttpServletResponse response) {
		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);

		UserG2 user = userG2Service.userIdSelect(cookieUserId);

		model.addAttribute("user", user);

		return "/user/updateuserForm";
	}

	// 프로필 이미지 변경 팝업 경로
	@RequestMapping(value = "/user/userProfileImg", method = RequestMethod.GET)
	public String userProfileImg(ModelMap modelMap, HttpServletRequest request, HttpServletResponse response) {

		String userId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		String profileImageFileName = userG2Service.getProfileImageFileNameByUserId(userId);
		if (profileImageFileName != null) {
			modelMap.addAttribute("url", profileImageFileName);
		} else {
			modelMap.addAttribute("url", "/resources/images/profile.png");
		}
		return "/user/userProfileImg";
	}

	// 마이페이지 동적 페이징 처리
	@RequestMapping(value = "/user/updateuserPageContent", method = RequestMethod.GET)
	public ModelAndView updateuserPageContent() {
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("/user/updateuserForm");
		return modelAndView;
	}

	// 이미지 업로드
	@RequestMapping(value = "/user/uploadProfileImage", method = RequestMethod.POST)
	@ResponseBody
	public Response<Object> uploadProfileImage(MultipartHttpServletRequest request, HttpServletResponse response) {
		Response<Object> ajaxResponse = new Response<Object>();
		FileData fileData = HttpUtil.getFile((MultipartHttpServletRequest) request, "profileImage", UPLOAD_SAVE_DIR);
		System.out.println(fileData.getFileName());
		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		UserG2 user = userG2Service.userIdSelect(cookieUserId);
		if (fileData == null || fileData.getFileSize() <= 0) {
			ajaxResponse.setResponse(401, "Bad Request");
			return ajaxResponse;
		}

		// 사용자가 존재하지 않는 경우
		if (user == null || user.getUserId() == null || user.getUserId().isEmpty()) {
			ajaxResponse.setResponse(400, "Bad Request");
			return ajaxResponse;
		}

		if (userG2Service.saveProfileImage(user.getUserId(), "/resources/upload/" + fileData.getFileName()) > 0) {
			ajaxResponse.setResponse(0, "Success");

			Friend friend = (Friend) session.getAttribute(cookieUserId);
			if (friend == null) {
				session.setAttribute(cookieUserId, friendService.selectUser(cookieUserId));
			} else {
				Friend search = friendService.selectUser(cookieUserId);
				if (!StringUtil.equals(friend.getUserNickName(), search.getUserNickName())
						|| !StringUtil.equals(friend.getFileName(), search.getFileName())) {
					session.setAttribute(cookieUserId, search);
				}
			}

		} else {
			ajaxResponse.setResponse(500, "Server Error");
		}

		return ajaxResponse;
	}

	// 팝업창에서 이미지불러오기
	@RequestMapping(value = "/user/userMyProfileImg", method = RequestMethod.GET)
	public ModelAndView userMyProfileImg(HttpServletRequest request) {
		ModelAndView modelAndView = new ModelAndView("userMyPage");

		String userId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);

		String profileImageFileName = userG2Service.getProfileImageFileNameByUserId(userId);

		modelAndView.addObject("profileImageFileName", profileImageFileName);

		return modelAndView;
	}

	// 이미지 가져오기
	@RequestMapping(value = "/user/profileImage")
	@ResponseBody
	public String getProfileImage(HttpServletRequest request) {
		String userId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		String profileImageFileName = userG2Service.getProfileImageFileNameByUserId(userId);

		if (profileImageFileName != null) {

			return profileImageFileName;
		} else {

			return "/resources/images/profile.png";
		}

	}

	// 회원정보수정
	@RequestMapping(value = "/user/updateuserInfo", method = RequestMethod.POST)
	@ResponseBody
	public Response<Object> updateuserInfo(HttpServletRequest request, HttpServletResponse response) {
		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);

		String userPwd = HttpUtil.get(request, "userPwd");
		String userNickname = HttpUtil.get(request, "userNickName");
		String userAddress = HttpUtil.get(request, "userAddress");

		Response<Object> ajaxResponse = new Response<Object>();

		if (!StringUtil.isEmpty(cookieUserId)) {
			UserG2 user = userG2Service.userIdSelect(cookieUserId);

			if (user != null) {
				boolean isUpdated = false;

				if (!StringUtil.isEmpty(userPwd)) {
					user.setUserPwd(userPwd);
					isUpdated = true;
				}

				if (!StringUtil.isEmpty(userNickname)) {
					user.setUserNickName(userNickname);
					isUpdated = true;
				}

				if (!StringUtil.isEmpty(userAddress)) {
					user.setUserAddress(userAddress);
					isUpdated = true;
				}

				if (isUpdated) {
					if (userG2Service.userUpdate(user) > 0) {
						// 정상처리됨
						ajaxResponse.setResponse(0, "success");
						Friend friend = (Friend) session.getAttribute(cookieUserId);
						if (friend == null) {
							session.setAttribute(cookieUserId, friendService.selectUser(cookieUserId));
						} else {
							Friend search = friendService.selectUser(cookieUserId);
							if (!StringUtil.equals(friend.getUserNickName(), search.getUserNickName())
									|| !StringUtil.equals(friend.getFileName(), search.getFileName())) {
								session.setAttribute(cookieUserId, search);
							}
						}

					} else {
						// 업데이트하다 실패
						ajaxResponse.setResponse(500, "Internal Server error");
					}
				} else {
					// 입력 파라미터가 올바르지 않을 경우
					ajaxResponse.setResponse(400, "Bad Request not found value");
				}
			} else {
				// 고객이 없는것
				CookieUtil.deleteCookie(request, response, "/", AUTH_COOKIE_NAME);
				ajaxResponse.setResponse(404, "Not Found");
			}
		} else {
			ajaxResponse.setResponse(400, "Bad Request cookie");
		}

		if (logger.isDebugEnabled()) {
			logger.debug("[UserController]/user/updateProc response\n" + JsonUtil.toJsonPretty(ajaxResponse));
		}

		return ajaxResponse;
	}

	// 마이페이지 메인 카테고리 분류
	@RequestMapping(value = "/user/loadContent", method = RequestMethod.GET)
	public String loadContent(ModelMap modelMap, HttpServletRequest request, HttpServletResponse response) {
		String category = request.getParameter("category");

		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		UserG2 user = userG2Service.userIdSelect(cookieUserId);
		String profileImageFileName = userG2Service.getProfileImageFileNameByUserId(cookieUserId);
		String searchType = HttpUtil.get(request, "searchType", "4"); // 조회항목 ( 0 : 전체, 1 : 아이디, 2 : 닉네임, 3 : 이메일 )
		String searchValue = HttpUtil.get(request, "searchValue", cookieUserId); // 조회값

		if (StringUtil.equals(category, "프로필")) {
			modelMap.addAttribute("url", profileImageFileName);
			modelMap.addAttribute("user", user);

			// model에 데이터 추가 (옵션)
			// model.addAttribute("key", value);
			return "/user/myPagePaging/page-content-profile"; // 페이지로 이동
		}

		else if (StringUtil.equals(category, "다이어리")) {

			Friend search = new Friend(); // 검색 조건 객체 선언
			MainBoard board = new MainBoard();
			// 현재 페이지
			long curPage = HttpUtil.get(request, "curPage", (long) 1);
			// 게시물 리스트
			List<MainBoard> list = null;
			// 총 게시물 수
			long totalCount = 0;
			// 페이징 객체
			Paging paging = null;
			// 내 다이어리 조회 했다는 표시 = 1
			String myBoard = HttpUtil.get(request, "myBoard", "1");
			if (!StringUtil.isEmpty(searchType) && !StringUtil.isEmpty(searchValue)) {
				board.setSearchType(searchType);
				board.setSearchValue(searchValue);
			}

			board.setUserId(cookieUserId);

			totalCount = mainBoardService.boardListCount(board);
			if (totalCount > 0) {
				paging = new Paging("../user/myPagePaging/page-content-diary", totalCount, LIST_COUNT, PAGE_COUNT,
						curPage, "curPage");

				board.setStartRow(paging.getStartRow());
				board.setEndRow(paging.getEndRow());

				list = mainBoardService.boardList(board);


			}

			modelMap.addAttribute("list", list);
			modelMap.addAttribute("searchType", searchType);
			modelMap.addAttribute("searchValue", searchValue);
			modelMap.addAttribute("curPage", curPage);
			modelMap.addAttribute("paging", paging);
			modelMap.addAttribute("myBoard", myBoard);

			return "/user/myPagePaging/page-content-diary";

		}

		else if (StringUtil.equals(category, "연인상태")) {
			Friend yourFriend = friendService.selectYourId(cookieUserId);
			if (yourFriend != null) {
				CoupleAnniversary coupleAnniversary = anniversaryService.selectCoupleAnniversary(cookieUserId);
				modelMap.addAttribute("myId", yourFriend.getMyId());
				modelMap.addAttribute("yourId", yourFriend.getYourId());
				modelMap.addAttribute("myProfileImage", yourFriend.getMyProfileImage());
				modelMap.addAttribute("yourProfileImage", yourFriend.getYourProfileImage());
				modelMap.addAttribute("myBir", yourFriend.getMyBir());
				modelMap.addAttribute("yourBir", yourFriend.getYourBir());
				modelMap.addAttribute("myName", yourFriend.getMyName());
				modelMap.addAttribute("yourName", yourFriend.getYourName());
				modelMap.addAttribute("myGen", yourFriend.getMyGen());
				modelMap.addAttribute("yourGen", yourFriend.getYourGen());
				modelMap.addAttribute("yourNickName", yourFriend.getYourNickName());
				modelMap.addAttribute("myNickName", yourFriend.getMyNickName());
				modelMap.addAttribute("coupleAnniversary", coupleAnniversary);

				modelMap.addAttribute("yourFriend", yourFriend);
			}

			return "/user/myPagePaging/page-content-couple";
		}

		else if (StringUtil.equals(category, "친구관리")) {

			return "/user/myPagePaging/left-content-friend";
		}

		else if (StringUtil.equals(category, "좋아요")) {
			List<RestoInfo> list = restoService.selectRestoFavoriteList(cookieUserId);
			modelMap.addAttribute("list", list);

			return "/user/myPagePaging/page-content-favorite";
		}

		else {
			return "errorPage"; // 잘못된 카테고리에 대한 오류 페이지로 이동
		}
	}

	// 마이페이지 왼쪽 카테고리 분류
	@RequestMapping(value = "/user/loadleftContent")
	public String loadleftContent(ModelMap modelMap, HttpServletRequest request, HttpServletResponse response) {
		String item = request.getParameter("item");

		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		UserG2 user = userG2Service.userIdSelect(cookieUserId);
		String profileImageFileName = userG2Service.getProfileImageFileNameByUserId(cookieUserId);
		String searchType = HttpUtil.get(request, "searchType", "4"); // 조회항목 ( 0 : 전체, 1 : 아이디, 2 : 닉네임, 3 : 이메일 )
		String searchValue = HttpUtil.get(request, "searchValue", ""); // 조회값
		String listType = HttpUtil.get(request, "listType", "3"); // 조회할 친구 리스트 ( 0 : 일반 유저 목록, 1 : 친구 요청 받은 목록, 2 : 친구
																	// 요청 보낸 목록, 3: 내 친구 목록 )
		String relationalType = HttpUtil.get(request, "relationalType", "0"); // 요청 구분 ( 0 : 친구, 1 : 연인 )
		List<Friend> friendList = null; // 게시물 리스트

		Friend search = new Friend(); // 검색 조건 객체 선언
		MainBoard board = new MainBoard();
		// 현재 페이지
		long curPage = HttpUtil.get(request, "curPage", (long) 1);
		// 게시물 리스트
		List<MainBoard> list = null;
		// 총 게시물 수
		long totalCount = 0;
		// 페이징 객체
		Paging paging = null;
		// 내 다이어리 조회 했다는 표시 = 1
		String myBoard = HttpUtil.get(request, "myBoard", "1");

		if (StringUtil.equals(item, "프로필")) {
			HashMap<String, String> hashMap = new HashMap<String, String>();
			hashMap.put("userId", cookieUserId);
			hashMap.put("yourId", cookieUserId);
			Friend friend = friendService.selectYourUser(hashMap);
			if (friend != null) {
				Friend yourFriend = friendService.selectYourId(cookieUserId);
				if (yourFriend != null) {

				}

				modelMap.addAttribute("url", profileImageFileName);
				modelMap.addAttribute("user", user);
			}

			return "/user/myPagePaging/page-content-profile"; // 페이지로 이동
		}

		else if (StringUtil.equals(item, "다이어리")) {
			searchValue = HttpUtil.get(request, "searchValue", cookieUserId);

			if (!StringUtil.isEmpty(searchType) && !StringUtil.isEmpty(searchValue)) {
				board.setSearchType(searchType);
				board.setSearchValue(searchValue);
			}

			board.setUserId(cookieUserId);

			totalCount = mainBoardService.boardListCount(board);

			if (totalCount > 0) {
				paging = new Paging("/user/myPagePaging/page-content-diary", totalCount, LIST_COUNT, PAGE_COUNT,
						curPage, "curPage");

				board.setStartRow(paging.getStartRow());
				board.setEndRow(paging.getEndRow());

				list = mainBoardService.boardList(board);

			}

			modelMap.addAttribute("list", list);
			modelMap.addAttribute("searchType", searchType);
			modelMap.addAttribute("searchValue", searchValue);
			modelMap.addAttribute("curPage", curPage);
			modelMap.addAttribute("paging", paging);
			modelMap.addAttribute("myBoard", myBoard);
			modelMap.addAttribute("friend", search);
			modelMap.addAttribute("url", profileImageFileName);
			modelMap.addAttribute("user", user);

			return "/user/myPagePaging/page-content-diary";
		}

		else if (StringUtil.equals(item, "내 정보수정")) {
			modelMap.addAttribute("user", user);
			return "/user/updateuserForm";
		}

		else if (StringUtil.equals(item, "캘린더")) {

			return "/calender/calender";
		}

		else if (StringUtil.equals(item, "친구관리")) {
			if (!StringUtil.isEmpty(searchType) && !StringUtil.isEmpty(searchValue)) {
				search.setSearchType(searchType);
				search.setSearchValue(searchValue);
			}
			search.setUserId(cookieUserId);
			if (StringUtil.equals(listType, "1")) {
				friendList = friendService.requestForMeList(search);
			} else if (StringUtil.equals(listType, "2")) {
				friendList = friendService.requestForYouList(search);
			} else if (StringUtil.equals(listType, "3")) {
				friendList = friendService.myFriendList(search);
			} else {
				friendList = friendService.friendList(search);
			}
			modelMap.addAttribute("list", friendList);
			modelMap.addAttribute("searchType", searchType);
			modelMap.addAttribute("searchValue", searchValue);
			modelMap.addAttribute("listType", listType);
			modelMap.addAttribute("relationalType", relationalType);

			return "/user/myPagePaging/left-content-friend";
		}

		else if (StringUtil.equals(item, "결제내역")) {

			return "/user/myPagePaging/page-content-paylist";
		}

		else if (StringUtil.equals(item, "쪽지")) {

			return "/user/myPagePaging/page-content-post";
		} else if (StringUtil.equals(item, "리뷰")) {

			return "/user/myPagePaging/page-content-review";
		}

		else {
			return "errorPage"; // 잘못된 카테고리에 대한 오류 페이지로 이동
		}
	}

	// 유저 마이페이지 다이어리 페이징 처리
	@RequestMapping(value = "/user/myPagePaging/page-content-diary")

	public String handlePostRequestForDiary(ModelMap modelMap, HttpServletRequest request) {
		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		String searchType = HttpUtil.get(request, "searchType", "");
		String searchValue = HttpUtil.get(request, "searchValue", "");
		long curPage = HttpUtil.get(request, "curPage", (long) 1);
		String myBoard = HttpUtil.get(request, "myBoard");

		MainBoard board = new MainBoard();

		if (!StringUtil.isEmpty(searchType) && !StringUtil.isEmpty(searchValue)) {
			board.setSearchType(searchType);
			board.setSearchValue(searchValue);

		}

		board.setUserId(cookieUserId);
		long totalCount = mainBoardService.boardListCount(board);

		if (totalCount > 0) {
			Paging paging = new Paging("/user/myPagePaging/page-content-diary", totalCount, LIST_COUNT, PAGE_COUNT,
					curPage, "curPage");
			board.setStartRow(paging.getStartRow());
			board.setEndRow(paging.getEndRow());

			List<MainBoard> list = mainBoardService.boardList(board);
			modelMap.addAttribute("list", list);
			modelMap.addAttribute("paging", paging);
			System.out.println(list);
		}

		modelMap.addAttribute("searchType", searchType);
		modelMap.addAttribute("searchValue", searchValue);
		modelMap.addAttribute("curPage", curPage);
		modelMap.addAttribute("myBoard", myBoard);

		return "/user/myPagePaging/page-content-diary";
	}

	// 유저 마이페이지 친구관리 페이징 처리
	@RequestMapping(value = "/user/myPagePaging/left-content-friend")

	public String handlePostRequestForFriend(ModelMap modelMap, HttpServletRequest request) {
		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		String searchType = HttpUtil.get(request, "searchType", ""); // 조회항목 ( 0 : 전체, 1 : 아이디, 2 : 닉네임, 3 : 이메일 )
		String searchValue = HttpUtil.get(request, "searchValue", ""); // 조회값
		String listType = HttpUtil.get(request, "listType", "0"); // 조회할 친구 리스트 ( 0 : 일반 유저 목록, 1 : 친구 요청 받은 목록, 2 : 친구
																	// 요청 보낸 목록, 3: 내 친구 목록 )
		String relationalType = HttpUtil.get(request, "relationalType", "0"); // 요청 구분 ( 0 : 친구, 1 : 연인 )
		List<Friend> friendList = null; // 게시물 리스트
		Friend search = new Friend(); // 검색 조건 객체 선언
		if (!StringUtil.isEmpty(searchType) && !StringUtil.isEmpty(searchValue)) {
			search.setSearchType(searchType);
			search.setSearchValue(searchValue);
		}
		search.setUserId(cookieUserId);
		if (StringUtil.equals(listType, "1")) {
			friendList = friendService.requestForMeList(search);
		} else if (StringUtil.equals(listType, "2")) {
			friendList = friendService.requestForYouList(search);
		} else if (StringUtil.equals(listType, "3")) {
			friendList = friendService.myFriendList(search);
		} else {
			friendList = friendService.friendList(search);
		}
		modelMap.addAttribute("list", friendList);
		modelMap.addAttribute("searchType", searchType);
		modelMap.addAttribute("searchValue", searchValue);
		modelMap.addAttribute("listType", listType);
		modelMap.addAttribute("relationalType", relationalType);

		return "/user/myPagePaging/left-content-friend";
	}

}