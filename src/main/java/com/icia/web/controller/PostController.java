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
import com.icia.web.model.Friend;
import com.icia.web.model.Msg;
import com.icia.web.model.Response;
import com.icia.web.service.FriendService;
import com.icia.web.service.SendMsgService;
import com.icia.web.util.CookieUtil;
import com.icia.web.util.HttpUtil;

@Controller("postController")
public class PostController {

	private static Logger logger = LoggerFactory.getLogger(PostController.class);

	@Value("#{env['auth.cookie.name']}")
	private String AUTH_COOKIE_NAME;

	// 파일 저장 경로
	@Value("#{env['upload.save.dir']}")
	private String UPLOAD_SAVE_DIR; // 저장 경로

	@Autowired
	private FriendService friendService;
	@Autowired
	private SendMsgService sendMsgService;

	// @Autowired
	// private PostService postService;

	@RequestMapping(value = "/msg/sendMsg", method = RequestMethod.POST)
	@ResponseBody
	public Response<Object> sendMsg(HttpServletRequest request, HttpServletResponse response) {
		Response<Object> ajaxResponse = new Response<Object>();
		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		String yourId = HttpUtil.get(request, "yourId", "");
		String msgContent = HttpUtil.get(request, "msgContent", "");

		if (!StringUtil.isEmpty(cookieUserId) && !StringUtil.isEmpty(yourId) && !StringUtil.isEmpty(msgContent)) {
			if (!StringUtil.equals(cookieUserId, yourId)) {
				if (friendService.selectUser(yourId) != null) {
					Msg sendMsg = new Msg();
					sendMsg.setToUserId(cookieUserId);
					sendMsg.setFromUserId(yourId);
					sendMsg.setMsgContent(msgContent);
					if (sendMsgService.sendMsg(sendMsg) > 0) {
						ajaxResponse.setResponse(0, "Success", "쪽지 발송에 성공하였습니다.");
					} else {
						ajaxResponse.setResponse(500, "DB Sever Error", "서버에서 오류가 발생하였습니다. 다시 시도해 주세요.");
					}
				} else {
					ajaxResponse.setResponse(404, "Not Found", "해당 사용자가 존재하지 않습니다.");
				}

			} else {
				ajaxResponse.setResponse(100, "Same User", "같은 사용자 입니다.");
			}
		} else {
			ajaxResponse.setResponse(400, "Bad Request", "입력 값이 올바르지 않습니다.");
		}
		return ajaxResponse;
	}

	// 네비에서 POST 눌렀을때
	@RequestMapping(value = "/post/postIndex")
	public String postIndex(ModelMap model, HttpServletRequest request, HttpServletResponse response) {
		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		int toCount = sendMsgService.toCount(cookieUserId); // 보낸 쪽지 개수
		int fromCount = sendMsgService.fromCount(cookieUserId); // 받은 쪽지 개수

		model.addAttribute("toCount", toCount);
		model.addAttribute("fromCount", fromCount);

		return "/post/postIndex";
	}

	// 쪽지함 이동
	@RequestMapping(value = "/post/postBox")
	public String postBox(ModelMap model, HttpServletRequest request, HttpServletResponse response) {
		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		List<Msg> currentList = null;

		if (!StringUtil.isEmpty(cookieUserId)) {
			currentList = sendMsgService.currentList(cookieUserId);
		}

		model.addAttribute("currentList", currentList);
		model.addAttribute("cookieUserId", cookieUserId);

		return "/post/postBox";
	}

	// 받는사람 아이디 검색했을때 해당유저 반환
	@RequestMapping(value = "/post/searchUser", method = RequestMethod.POST)
	@ResponseBody
	public Response<Object> searchUser(HttpServletRequest request, HttpServletResponse response) {
		Response<Object> ajaxResponse = new Response<Object>();
		// 사용자가 찾으려는 유저 아이디
		String searchUser = HttpUtil.get(request, "searchInput", "");

		Friend user = null; // 유저찾기 용도로 friend 파트에 있는 객체랑 메서드 가져와서 재활용함

		if (!StringUtil.isEmpty(searchUser)) {
			user = friendService.selectUser(searchUser);

			if (user != null) {
				ajaxResponse.setResponse(0, "success");
				ajaxResponse.setData(user);
			} else // 해당하는 유저가 없음
			{
				ajaxResponse.setResponse(500, "Interal server error");
			}

		} else // 검색값이 없음
		{
			ajaxResponse.setResponse(400, "Bad Request");
		}

		return ajaxResponse;

	}

	// 전송버튼 누르면 쪽지 보내기
	@RequestMapping(value = "/post/sendPost", method = RequestMethod.POST)
	@ResponseBody
	public Response<Object> sendPost(HttpServletRequest request, HttpServletResponse response) {
		Response<Object> ajaxResponse = new Response<Object>();
		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		String yourId = HttpUtil.get(request, "yourId", "");
		String msgContent = HttpUtil.get(request, "msgContent", "");

		if (!StringUtil.isEmpty(cookieUserId) && !StringUtil.isEmpty(yourId) && !StringUtil.isEmpty(msgContent)) {
			if (!StringUtil.equals(cookieUserId, yourId)) {
				if (friendService.selectUser(yourId) != null) {
					Msg sendMsg = new Msg();
					sendMsg.setToUserId(cookieUserId);
					sendMsg.setFromUserId(yourId);
					sendMsg.setMsgContent(msgContent);
					if (sendMsgService.sendMsg(sendMsg) > 0) {
						ajaxResponse.setResponse(0, "Success", "쪽지 발송에 성공하였습니다.");
					} else {
						ajaxResponse.setResponse(500, "DB Sever Error", "서버에서 오류가 발생하였습니다. 다시 시도해 주세요.");
					}
				} else {
					ajaxResponse.setResponse(404, "Not Found", "해당 사용자가 존재하지 않습니다.");
				}

			} else {
				ajaxResponse.setResponse(100, "Same User", "자신에게는 쪽지를 보낼 수 없답니다.. 일기장에 쓰세요");
			}
		} else {
			ajaxResponse.setResponse(400, "Bad Request", "입력 값이 올바르지 않습니다.");
		}
		return ajaxResponse;

	}

	// 채팅방 유저 선택했을때 주고받은 쪽지내역 모두 보여주기
	@RequestMapping(value = "/post/postList", method = RequestMethod.POST)
	@ResponseBody
	public Response<Object> postList(HttpServletRequest request, HttpServletResponse response) {
		Response<Object> ajaxResponse = new Response<Object>();
		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		String yourId = HttpUtil.get(request, "yourId", "");

		// 읽음확인 업데이트용 객체
		Msg update = new Msg();
		// 조회객체. 내 아이디를 toUserId에 넣고 상대방아이디는 fromUserId에 넣어야함 (쿼리를 그렇게 작성했뜸)
		Msg search = new Msg();
		List<Msg> postList = null;

		if (!StringUtil.isEmpty(cookieUserId) && !StringUtil.isEmpty(yourId)) {
			if (!StringUtil.equals(cookieUserId, yourId)) {
				update.setToUserId(yourId);
				update.setFromUserId(cookieUserId);
				sendMsgService.readUpdate(update); // 읽음표시 업데이트

				search.setToUserId(cookieUserId);
				search.setFromUserId(yourId);
				postList = sendMsgService.postList(search); // 쪽지리스트 가져오기

				if (postList != null) {
					ajaxResponse.setResponse(0, "Success", "리스트 전달");
					ajaxResponse.setData(postList);
					ajaxResponse.setMsg(cookieUserId);
				} else {
					ajaxResponse.setResponse(500, "DB Sever Error", "서버에서 오류가 발생하였습니다. 다시 시도해 주세요.");
				}
			} else {
				ajaxResponse.setResponse(100, "Same User", "쿠키아이디나 유저아이디 잘못 가져온듯");
			}
		} else {
			ajaxResponse.setResponse(400, "Bad Request", "입력 값이 올바르지 않습니다.");
		}

		return ajaxResponse;

	}

}