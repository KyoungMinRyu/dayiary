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
import com.icia.web.model.MainBoard;
import com.icia.web.model.MainBoardComment;
import com.icia.web.model.MainBoardFile;
import com.icia.web.model.MainBoardReaction;
import com.icia.web.model.Paging;
import com.icia.web.model.Response;
import com.icia.web.model.UserG2;
import com.icia.web.service.MainBoardService;
import com.icia.web.service.UserG2Service;
import com.icia.web.util.CookieUtil;
import com.icia.web.util.HttpUtil;

@Controller("MainBoardController")
public class MainBoardController {
   private static Logger logger = LoggerFactory.getLogger(MainBoardController.class);

   @Value("#{env['auth.cookie.name']}")
   private String AUTH_COOKIE_NAME;

   // 파일 저장 경로
   @Value("#{env['upload.save.dir']}")
   private String UPLOAD_SAVE_DIR; // 저장 경로

   @Autowired
   private UserG2Service userG2Service;

   @Autowired
   private MainBoardService mainBoardService;

   private static final int LIST_COUNT = 6; // 한 페이지에 보여줄 게시물 수
   private static final int PAGE_COUNT = 5; // 페이징 수(밑에 버튼)

   // 다이어리 리스트
   @RequestMapping(value = "/board/diaryList")
   public String diaryList(ModelMap model, HttpServletRequest request, HttpServletResponse response) {
      String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
      // 조회 항목
      String searchType = HttpUtil.get(request, "searchType", "");
      // 조회 값
      String searchValue = HttpUtil.get(request, "searchValue", "");
      // 현재 페이지
      long curPage = HttpUtil.get(request, "curPage", (long) 1);
      // 게시물 리스트
      List<MainBoard> list = null;
      // 조회 객체 선언
      MainBoard search = new MainBoard();
      // 총 게시물 수
      long totalCount = 0;
      // 페이징 객체
      Paging paging = null;
      // 내 다이어리 조회 했다는 표시 = 1
      String myBoard = HttpUtil.get(request, "myBoard", "2");

      if (!StringUtil.isEmpty(searchType) && !StringUtil.isEmpty(searchValue)) {
         search.setSearchType(searchType);
         search.setSearchValue(searchValue);
      }
      search.setUserId(cookieUserId);
      totalCount = mainBoardService.boardListCount(search);
      if (totalCount > 0) {
         paging = new Paging("/board/diaryList", totalCount, LIST_COUNT, PAGE_COUNT, curPage, "curPage");
         search.setStartRow(paging.getStartRow());
         search.setEndRow(paging.getEndRow());
         list = mainBoardService.boardList(search);
      }

      if (StringUtil.equals(myBoard, "1")) // 내다이어리보기 눌렀을때는 조회창에 서치타입,서치밸류 안보이게 하기 위함
      {
         searchValue = "";
         searchType = "";
      }

      model.addAttribute("list", list);
      model.addAttribute("searchType", searchType);
      model.addAttribute("searchValue", searchValue);
      model.addAttribute("curPage", curPage);
      model.addAttribute("paging", paging);
      model.addAttribute("myBoard", myBoard);

      return "/board/diaryList";
   }

   // 다이어리 등록 폼
   @RequestMapping(value = "/board/diaryWrite")
   public String writeForm(ModelMap model, HttpServletRequest request, HttpServletResponse response) {
      // 쿠키값
      String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
      String searchType = HttpUtil.get(request, "searchType", "");
      String searchValue = HttpUtil.get(request, "searchValue", "");
      long curPage = HttpUtil.get(request, "curPage", (long) 1);

      // 사용자 정보 조회
      UserG2 user = userG2Service.userIdSelect(cookieUserId);

      model.addAttribute("user", user); // "user"는 writeForm에 있는 value="${user.userName}" 부분임
      model.addAttribute("searchType", searchType);
      model.addAttribute("searchValue", searchValue);
      model.addAttribute("curPage", curPage);

      return "/board/diaryWrite";
   }

   // 게시물 등록(ajax)
   @RequestMapping(value = "/board/diaryWriteProc", method = RequestMethod.POST)
   @ResponseBody
   public Response<Object> diaryWriteProc(MultipartHttpServletRequest request, HttpServletResponse response)
   {
      Response<Object> ajaxResponse = new Response<Object>();
      String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
      String boardTitle = HttpUtil.get(request, "boardTitle", "");
      String editor = HttpUtil.get(request, "editor", "");
      List<FileData> fileData = HttpUtil.getFiles(request, "mainBoardFile", UPLOAD_SAVE_DIR);

      if (!StringUtil.isEmpty(boardTitle) && !StringUtil.isEmpty(editor)) {
         MainBoard mainBoard = new MainBoard();

         mainBoard.setUserId(cookieUserId);
         mainBoard.setBoardTitle(boardTitle);
         mainBoard.setBoardContent(editor);
         mainBoard.setBoardType("D");

         if (fileData != null) {
            List<MainBoardFile> mainBoardFileList = new ArrayList<MainBoardFile>();

            for (int i = 0; i < fileData.size(); i++) {
               MainBoardFile mainBoardFile = new MainBoardFile();

               mainBoardFile.setFileName(fileData.get(i).getFileName());
               mainBoardFile.setFileOrgName(fileData.get(i).getFileOrgName());
               mainBoardFile.setFileExt(fileData.get(i).getFileExt());
               mainBoardFile.setFileSize(fileData.get(i).getFileSize());

               mainBoardFileList.add(mainBoardFile);
            }

            mainBoard.setMainBoardFile(mainBoardFileList);
         }

         // 서비스 호출
         try {
            if (mainBoardService.boardInsert(mainBoard) > 0)
            {
               ajaxResponse.setResponse(0, "success");
            } else {
               ajaxResponse.setResponse(500, "Interal server error");
            }
         } catch (Exception e) {
            logger.error("[MainBoardController] writeProc Exception", e);
            ajaxResponse.setResponse(500, "internal server error");
         }
      } else {
         ajaxResponse.setResponse(400, "Bad Request");
      }

      return ajaxResponse;
   }

   // 게시물 조회
   @RequestMapping(value = "/board/diaryView")
   public String view(ModelMap model, HttpServletRequest request, HttpServletResponse response) {
      // 쿠키 값
      String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
      // 게시물 번호
      long boardSeq = HttpUtil.get(request, "boardSeq", (long) 0);
      // 조회 항목(1:작성자, 2:제목, 3:내용)
      String searchType = HttpUtil.get(request, "searchType", "");
      // 조회 값
      String searchValue = HttpUtil.get(request, "searchValue", "");
      // 현재 페이지
      long curPage = HttpUtil.get(request, "curPage", (long) 1);
      // 본인 글 여부
      String boardMe = "N";
      // 좋아요 여부
      int likeCheck = 0;
      // 댓글이 있을 시 댓글목록 같이 출력
      List<MainBoardComment> commentList = mainBoardService.commentList(boardSeq);
      // 해당 게시물 총 좋아요 개수
      int likeCount = mainBoardService.likeCount(boardSeq);

      MainBoard mainBoard = null;

      MainBoardReaction mainBoardReaction = new MainBoardReaction();
      mainBoardReaction.setBoardSeq(boardSeq);
      mainBoardReaction.setUserId(cookieUserId);

      if (boardSeq > 0) {
         mainBoard = mainBoardService.boardView(boardSeq);
         likeCheck = mainBoardService.likeCheck(mainBoardReaction);

         if (mainBoard != null && StringUtil.equals(mainBoard.getUserId(), cookieUserId)) {
            boardMe = "Y";
         }
      }

      model.addAttribute("boardMe", boardMe);
      model.addAttribute("boardSeq", boardSeq);
      model.addAttribute("mainBoard", mainBoard);
      model.addAttribute("searchType", searchType);
      model.addAttribute("searchValue", searchValue);
      model.addAttribute("curPage", curPage);
      model.addAttribute("commentList", commentList);
      model.addAttribute("cookieUserId", cookieUserId);
      model.addAttribute("likeCheck", likeCheck);
      model.addAttribute("likeCount", likeCount);

      return "/board/diaryView";
   }

   // 게시물 수정 화면
   @RequestMapping(value = "/board/diaryUpdateForm")
   public String updateForm(ModelMap model, HttpServletRequest request, HttpServletResponse response) {
      String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
      long boardSeq = HttpUtil.get(request, "boardSeq", (long) 0);
      String searchType = HttpUtil.get(request, "searchType", "");
      String searchValue = HttpUtil.get(request, "searchValue", "");
      long curPage = HttpUtil.get(request, "curPage", (long) 1);

      MainBoard mainBoard = null;
      UserG2 user = null;

      if (boardSeq > 0) {
         mainBoard = mainBoardService.boardSelect(boardSeq);

         if (mainBoard != null) {
            if (StringUtil.equals(mainBoard.getUserId(), cookieUserId)) {
               user = userG2Service.userIdSelect(cookieUserId);
            } else {
               mainBoard = null;
            }
         }
      }

      model.addAttribute("searchType", searchType);
      model.addAttribute("searchValue", searchValue);
      model.addAttribute("curPage", curPage);
      model.addAttribute("mainBoard", mainBoard);
      model.addAttribute("user", user);

      return "/board/diaryUpdateForm";
   }

   // 게시물 수정
   @RequestMapping(value = "/board/diaryUpdateProc", method = RequestMethod.POST)
   @ResponseBody
   public Response<Object> diaryUpdateProc(MultipartHttpServletRequest request, HttpServletResponse response) {
      Response<Object> ajaxResponse = new Response<Object>();
      String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
      long boardSeq = HttpUtil.get(request, "boardSeq", (long) 0);
      String boardTitle = HttpUtil.get(request, "boardTitle", "");
      String boardContent = HttpUtil.get(request, "editor", "");
      List<FileData> fileData = HttpUtil.getFiles(request, "mainBoardFile", UPLOAD_SAVE_DIR);

      if (boardSeq > 0 && !StringUtil.isEmpty(boardTitle) && !StringUtil.isEmpty(boardContent)) {
         MainBoard mainBoard = mainBoardService.boardSelect(boardSeq);

         if (mainBoard != null) {
            if (StringUtil.equals(mainBoard.getUserId(), cookieUserId)) // 본인의 게시물이 맞으면
            {
               mainBoard.setBoardTitle(boardTitle);
               mainBoard.setBoardContent(boardContent);

               if (fileData != null) // 첨부파일이 존재하면
               {
                  List<MainBoardFile> mainBoardFileList = new ArrayList<MainBoardFile>();

                  for (int i = 0; i < fileData.size(); i++) {
                     MainBoardFile mainBoardFile = new MainBoardFile();

                     mainBoardFile.setFileName(fileData.get(i).getFileName());
                     mainBoardFile.setFileOrgName(fileData.get(i).getFileOrgName());
                     mainBoardFile.setFileExt(fileData.get(i).getFileExt());
                     mainBoardFile.setFileSize(fileData.get(i).getFileSize());

                     mainBoardFileList.add(mainBoardFile);
                  }

                  mainBoard.setMainBoardFile(mainBoardFileList); // 하이보드와 파일 연결
               }

               try {
                  if (mainBoardService.boardUpdate(mainBoard) > 0) // 게시물 수정 성공
                  {
                     ajaxResponse.setResponse(0, "success");
                  } else {
                     ajaxResponse.setResponse(500, "internal server error2222");
                  }
               } catch (Exception e) {
                  logger.error("[MainBoardController] updateProc Exception", e);
                  ajaxResponse.setResponse(500, "internal server error");
               }
            } else {
               ajaxResponse.setResponse(403, "server error");
            }
         } else {
            ajaxResponse.setResponse(404, "not found");
         }
      } else {
         ajaxResponse.setResponse(400, "bad request");
      }

      return ajaxResponse;
   }

   // 게시물 삭제 (첨부파일 & 댓글 있으면 같이 삭제)
   @RequestMapping(value = "/board/diaryDelete", method = RequestMethod.POST)
   @ResponseBody
   public Response<Object> delete(HttpServletRequest request, HttpServletResponse resonse) {
      Response<Object> ajaxResponse = new Response<Object>();
      String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
      long boardSeq = HttpUtil.get(request, "boardSeq", (long) 0);

      if (boardSeq > 0) {
         MainBoard mainBoard = mainBoardService.boardSelect(boardSeq);

         if (mainBoard != null) {
            if (StringUtil.equals(mainBoard.getUserId(), cookieUserId)) // 내 게시물이 맞으면
            {
               // 게시물과 첨부파일 둘 다 삭제 (트랜잭션 묶어줘야함. 둘다 성공적으로 삭제되었을때 커밋)
               try {
                  if (mainBoardService.boardDelete(boardSeq) > 0) // 삭제성공
                  {
                     ajaxResponse.setResponse(0, "success");
                  } else {
                     ajaxResponse.setResponse(500, "server error222");
                  }
               } catch (Exception e) {
                  logger.error("[MainBoardController] delete Exception", e);
                  ajaxResponse.setResponse(500, "server error");
               }
            } else {
               // 내 게시물이 아닌 경우
               ajaxResponse.setResponse(403, "");
            }

         } else // 게시물이 존재하지 않음
         {
            ajaxResponse.setResponse(404, "not found");
         }
      } else {
         ajaxResponse.setResponse(400, "bad request");
      }

      return ajaxResponse;
   }

   // 댓글 등록(ajax)
   @RequestMapping(value = "/board/commentWriteProc", method = RequestMethod.POST)
   @ResponseBody
   public Response<Object> commentWriteProc(MultipartHttpServletRequest request, HttpServletResponse response)
   // 보내는 방식이 enctype="multipart/form-data"로 보내므로 위에 받는 매개변수도 Multipart로 맞춰줘야한다.
   {
      Response<Object> ajaxResponse = new Response<Object>();
      long boardSeq = HttpUtil.get(request, "boardSeq", (long) 0);
      String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
      String commentContent = HttpUtil.get(request, "commentContent", "");


      if (!StringUtil.isEmpty(commentContent) && !StringUtil.isEmpty(cookieUserId))
      // 로그인했고, 댓글내용 작성했을때
      {
         MainBoard parentMainBoard = mainBoardService.boardSelect(boardSeq);
         // 부모게시글 가져와서, 실제로 존재하는지 확인(다이렉트로 들어올수있기때문에)

         if (parentMainBoard != null) {
            MainBoardComment mainBoardComment = new MainBoardComment(); // 댓글 객체 생성

            // 인서트를 위해 유저아이디, 댓글내용, 게시물번호 세터
            mainBoardComment.setUserId(cookieUserId);
            mainBoardComment.setCommentContent(commentContent);
            mainBoardComment.setBoardSeq(boardSeq);

            // 서비스 호출
            try {
               if (mainBoardService.commentInsert(mainBoardComment) > 0)
               {
                  ajaxResponse.setResponse(0, "success");
               } else {
                  ajaxResponse.setResponse(500, "Interal server error");
               }
            } catch (Exception e) {
               logger.error("[MainBoardController] CommentWriteProc Exception", e);
               ajaxResponse.setResponse(500, "internal server error");
            }
         } else // 부모글이 없을 경우
         {
            ajaxResponse.setResponse(404, "not found");
         }
      } else {
         ajaxResponse.setResponse(400, "Bad Request");
      }

      return ajaxResponse;

   }

   // 댓글 삭제
   @RequestMapping(value = "/board/diaryCommentDelete", method = RequestMethod.POST)
   @ResponseBody
   public Response<Object> diaryCommentDelete(HttpServletRequest request, HttpServletResponse resonse) {
      Response<Object> ajaxResponse = new Response<Object>();
      String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
      long boardSeq = HttpUtil.get(request, "boardSeq", (long) 0);
      long commentSeq = HttpUtil.get(request, "commentSeq", (long) 0);

      if (boardSeq > 0) {
         MainBoard mainBoard = mainBoardService.boardSelect(boardSeq);
         MainBoardComment mainBoardComment = mainBoardService.commentSelect(commentSeq);

         if (mainBoard != null) // 게시물이 정상적으로 존재하고
         {
            if (mainBoardComment != null) // 삭제하려는 댓글이 존재하면
            {
               if (StringUtil.equals(mainBoardComment.getUserId(), cookieUserId)) // 본인의 댓글이 맞는지 확인
               {
                  if (mainBoardService.replyCheck(commentSeq) > 0) // 내 밑으로 달린 답댓글이 존재하면
                  {
                     mainBoardService.deleteUpdate(commentSeq);
                     ajaxResponse.setResponse(1, "updateSuccess");
                  } else // 답글이 존재하지 않으면
                  {
                     if (mainBoardService.commentDelete(commentSeq) > 0) // 삭제성공
                     {
                        ajaxResponse.setResponse(0, "success");
                     } else {
                        ajaxResponse.setResponse(500, "server error222");
                     }
                  }
               } else {
                  // 내 댓글이 아닌 경우
                  ajaxResponse.setResponse(403, "내 댓글이 아님");
               }
            } else // 댓글이 존재하지 않음
            {
               ajaxResponse.setResponse(404, "NOT FOUND");
            }
         } else // 게시물이 존재하지 않음
         {
            ajaxResponse.setResponse(404, "not found");
         }
      } else {
         ajaxResponse.setResponse(400, "bad request");
      }

      return ajaxResponse;
   }

   // 댓글 수정
   @RequestMapping(value = "/board/diaryCommentUpdate", method = RequestMethod.POST)
   @ResponseBody
   public Response<Object> diaryCommentUpdate(HttpServletRequest request, HttpServletResponse resonse) {
      Response<Object> ajaxResponse = new Response<Object>();
      String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
      long boardSeq = HttpUtil.get(request, "boardSeq", (long) 0);
      long commentSeq = HttpUtil.get(request, "commentSeq", (long) 0);
      String updateCommentContent = HttpUtil.get(request, "updateCommentContent", "");


      if (boardSeq > 0) {
         MainBoard mainBoard = mainBoardService.boardSelect(boardSeq);
         MainBoardComment mainBoardComment = mainBoardService.commentSelect(commentSeq);

         if (mainBoard != null) // 게시물이 정상적으로 존재하고
         {
            if (mainBoardComment != null) // 수정하려는 댓글이 존재하면
            {
               if (StringUtil.equals(mainBoardComment.getUserId(), cookieUserId)) // 본인의 댓글이 맞는지 확인
               {
                  mainBoardComment.setCommentContent(updateCommentContent);

                  if (mainBoardService.commentUpdate(mainBoardComment) > 0) // 수정성공
                  {
                     ajaxResponse.setResponse(0, "success");
                  } else {
                     ajaxResponse.setResponse(500, "server error222");
                  }
               } else {
                  // 내 댓글이 아닌 경우
                  ajaxResponse.setResponse(403, "내 댓글이 아님");
               }
            } else // 댓글이 존재하지 않음
            {
               ajaxResponse.setResponse(404, "NOT FOUND");
            }
         } else // 게시물이 존재하지 않음
         {
            ajaxResponse.setResponse(404, "not found");
         }
      } else {
         ajaxResponse.setResponse(400, "bad request");
      }

      return ajaxResponse;
   }

   // 댓글의 답글 작성
   @RequestMapping(value = "/board/diaryReplyComment", method = RequestMethod.POST)
   @ResponseBody
   public Response<Object> diaryReplyComment(HttpServletRequest request, HttpServletResponse response) {
      Response<Object> ajaxResponse = new Response<Object>();
      String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
      long boardSeq = HttpUtil.get(request, "boardSeq", (long) 0);
      long commentSeq = HttpUtil.get(request, "commentSeq", (long) 0);
      String replyCommentContent = HttpUtil.get(request, "replyCommentContent", "");


      if (boardSeq > 0 && !StringUtil.isEmpty(replyCommentContent)) // 게시물 존재하고, 답글 내용 비어있지 않으면
      {
         MainBoardComment parentBoardComment = mainBoardService.commentSelect(commentSeq);
         MainBoardComment mainBoardComment = new MainBoardComment(); // 답댓글 객체 생성

         if (parentBoardComment.getCommentIndent() == 0) // 부모댓글이 답글이 아닌 원댓글(조상댓글)이면
         {
            mainBoardComment.setBoardSeq(boardSeq);
            mainBoardComment.setCommentContent(replyCommentContent);
            mainBoardComment.setCommentGroup(parentBoardComment.getCommentGroup());
            mainBoardComment.setCommentIndent(parentBoardComment.getCommentIndent() + 1);
            mainBoardComment.setCommentOrder(mainBoardService.orderCheckZero(commentSeq) + 1);
            mainBoardComment.setCommentParent(commentSeq);
            mainBoardComment.setUserId(cookieUserId);
         } else // 부모댓글도 답글이면 (인덴트가 1보다 크면)
         {
            mainBoardComment.setBoardSeq(boardSeq);
            mainBoardComment.setCommentContent(replyCommentContent);
            mainBoardComment.setCommentGroup(parentBoardComment.getCommentGroup());
            mainBoardComment.setCommentIndent(parentBoardComment.getCommentIndent() + 1);
            mainBoardComment.setCommentOrder(mainBoardService.orderCheck(commentSeq) + 1);
            mainBoardComment.setCommentParent(commentSeq);
            mainBoardComment.setUserId(cookieUserId);
         }

         if (mainBoardService.commentReplyInsert(mainBoardComment) > 0) // 인서트는 여기서 함! 답글시퀀스와 파일시퀀스도 여기서 세팅됨.
         {
            ajaxResponse.setResponse(0, "success");
         } else {
            ajaxResponse.setResponse(500, "internal server error2222222");
         }
      } else {
         ajaxResponse.setResponse(400, "bad request");
      }

      return ajaxResponse;
   }

   // 다이어리 게시물 좋아요 처리
   @RequestMapping(value = "/board/diaryLike", method = RequestMethod.POST)
   @ResponseBody
   public Response<Object> diaryLike(HttpServletRequest request, HttpServletResponse response) {
      Response<Object> ajaxResponse = new Response<Object>();
      String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
      long boardSeq = HttpUtil.get(request, "boardSeq", (long) 0);
      int likeCheck = HttpUtil.get(request, "likeCheck", 3); // 3이면 ajax에서 값 못가져온거임. 1이면 like, 0이면 unlike
      int likeCount = 0;

      if (boardSeq > 0) // 게시물 존재하면
      {
         MainBoardReaction mainBoardReaction = new MainBoardReaction();

         mainBoardReaction.setUserId(cookieUserId);
         mainBoardReaction.setBoardSeq(boardSeq);

         if (likeCheck == 1) // 좋아요(1) 누른게 맞으면
         {
            if (mainBoardService.likeInsert(mainBoardReaction) > 0) // 좋아요 인서트 성공
            {
               likeCount = mainBoardService.likeCount(boardSeq);
               ajaxResponse.setResponse(0, "like : insert success");
               ajaxResponse.setData(likeCount);
            } else // 좋아요 인서트 실패
            {
               ajaxResponse.setResponse(500, "internal server error2222222");
            }
         } else if (likeCheck == 0) // 좋아요 취소(0) 했으면
         {
            if (mainBoardService.likeDelete(mainBoardReaction) > 0) // 레코드 삭제 성공
            {
               likeCount = mainBoardService.likeCount(boardSeq);
               ajaxResponse.setResponse(0, "unlike : delete success");
               ajaxResponse.setData(likeCount);
            } else // 레코드 삭제 실패
            {
               ajaxResponse.setResponse(500, "internal server error2222222");
            }
         }
      } else {
         ajaxResponse.setResponse(400, "bad request");
      }

      return ajaxResponse;
   }

}