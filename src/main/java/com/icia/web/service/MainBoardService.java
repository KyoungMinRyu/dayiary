package com.icia.web.service;

import java.util.ArrayList;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.icia.common.util.FileUtil;
import com.icia.web.dao.MainBoardDao;
import com.icia.web.model.MainBoard;
import com.icia.web.model.MainBoardComment;
import com.icia.web.model.MainBoardFile;
import com.icia.web.model.MainBoardReaction;

@Service("mainBoardService")
public class MainBoardService {
	private static Logger logger = LoggerFactory.getLogger(MainBoardService.class);

	// 파일 저장 경로
	@Value("#{env['upload.save.dir']}")
	private String UPLOAD_SAVE_DIR;

	@Autowired
	private MainBoardDao mainBoardDao;

	// 게시판 등록
	@Transactional(propagation = Propagation.REQUIRED, rollbackFor = Exception.class)
	public int boardInsert(MainBoard mainBoard) throws Exception // 여기서 지정해놓은 예외처리는 얘를 "호출하는 쪽"에서 try~catch 처리해야함.
	{
		int count = 0;
		count = mainBoardDao.boardInsert(mainBoard);

		if (count > 0 && mainBoard.getMainBoardFile() != null) {

			for (int i = 0; i < mainBoard.getMainBoardFile().size(); i++) {
				mainBoard.getMainBoardFile().get(i).setBoardSeq(mainBoard.getBoardSeq());
				// mainBoard.getMainBoardFile().get(i).setFileSeq((short)i);

				mainBoardDao.boardFileInsert(mainBoard.getMainBoardFile().get(i));
			}

		}

		return count;
	}

	// 게시물 리스트
	public List<MainBoard> boardList(MainBoard mainBoard) {
		List<MainBoard> list = null;

		try {
			list = mainBoardDao.boardList(mainBoard);
		} catch (Exception e) {
			logger.error("[MainBoardService] boardList Exception", e);
		}

		return list;

	}

	// 총 게시물 수 조회
	public long boardListCount(MainBoard mainBoard) {
		long count = 0;

		try {
			count = mainBoardDao.boardListCount(mainBoard);

		} catch (Exception e) {
			logger.error("[MainBoardService]boardListCount Exception", e);
		}

		return count;
	}

	// 게시물 조회
	public MainBoard boardSelect(long boardSeq) {
		MainBoard mainBoard = null;

		try {
			mainBoard = mainBoardDao.boardSelect(boardSeq);
		} catch (Exception e) {
			logger.error("[MainBoardService] boardSelect Exception", e);
		}

		return mainBoard;
	}

	// 게시물 첨부파일 조회
	public List<MainBoardFile> boardFileSelect(long boardSeq) {
		List<MainBoardFile> mainBoardFileList = new ArrayList<MainBoardFile>();

		try {
			mainBoardFileList = mainBoardDao.boardFileSelect(boardSeq);
		} catch (Exception e) {
			logger.error("[MainBoardService] boardFileSelect Exception", e);
		}

		return mainBoardFileList;
	}

	// 게시물 조회(첨부파일 포함, 조회수 증가 포함)
	public MainBoard boardView(long boardSeq) {
		MainBoard mainBoard = null;

		try {
			mainBoard = mainBoardDao.boardSelect(boardSeq);

			if (mainBoard != null) {
				mainBoardDao.boardReadCntPlus(boardSeq);

				List<MainBoardFile> mainBoardFileList = mainBoardDao.boardFileSelect(boardSeq);

				if (mainBoardFileList != null) {
					mainBoard.setMainBoardFile(mainBoardFileList);
				}

			}
		} catch (Exception e) {
			logger.error("[MainBoardService] boardView Exception", e);
		}

		return mainBoard;
	}

	// 게시물 수정 폼 조회(첨부파일 포함) - 하이보드와 하이보드파일 연결해서 읽어오기
	public MainBoard boardViewUpdate(long boardSeq) {
		MainBoard mainBoard = null;

		try {
			mainBoard = mainBoardDao.boardSelect(boardSeq);

			if (mainBoard != null) {
				List<MainBoardFile> mainBoardFileList = mainBoardDao.boardFileSelect(boardSeq);

				if (mainBoardFileList != null) {
					mainBoard.setMainBoardFile(mainBoardFileList);
				}

			}
		} catch (Exception e) {
			logger.error("[MainBoardService] boardViewUpdate Exception", e);
		}

		return mainBoard;
	}

	// 게시물 수정
	@Transactional(propagation = Propagation.REQUIRED, rollbackFor = Exception.class)
	public int boardUpdate(MainBoard mainBoard) throws Exception {
		int count = mainBoardDao.boardUpdate(mainBoard);

		if (count > 0 && mainBoard.getMainBoardFile() != null) {
			List<MainBoardFile> delMainBoardFileList = mainBoardDao.boardFileSelect(mainBoard.getBoardSeq());

			// 기존 파일이 있으면 삭제
			if (delMainBoardFileList != null) {
				for (int i = 0; i < delMainBoardFileList.size(); i++) {
					FileUtil.deleteFile(
							UPLOAD_SAVE_DIR + FileUtil.getFileSeparator() + delMainBoardFileList.get(i).getFileName());
					// getFileSeparator()는 : "/" 슬래시 반환
					// 저장경로(UPLOAD_SAVE_DIR/)밑에 있던 기존 파일 삭제시킴
					// 여기는 폴더에서 지우는거
				}

				mainBoardDao.boardFileDelete(mainBoard.getBoardSeq());
				// 여기는 DB에서 지우는거
			}

			MainBoardFile mainBoardFile = null;
			// 새로 등록할 파일
			for (int i = 0; i < mainBoard.getMainBoardFile().size(); i++) {
				mainBoardFile = mainBoard.getMainBoardFile().get(i);
				mainBoardFile.setBoardSeq(mainBoard.getBoardSeq());

				mainBoardDao.boardFileInsert(mainBoard.getMainBoardFile().get(i));
			}
		}

		return count;
	}

	// 게시물 삭제(첨부파일이 있으면 함께 삭제 , 댓글도 삭제)
	@Transactional(propagation = Propagation.REQUIRED, rollbackFor = Exception.class)
	public int boardDelete(long boardSeq) throws Exception {
		int count = 0;
		MainBoard mainBoard = boardViewUpdate(boardSeq); // boardViewUpdate 메서드에서 보드와 보드파일을 연결해서 읽기 때문에 재활용해서 쓴다.

		if (mainBoard != null) {
			List<MainBoardComment> mainBoardCommentList = mainBoardDao.commentList(boardSeq);
			if (mainBoardCommentList != null) {
				mainBoardDao.commentDeleteAll(boardSeq); // 댓글이 존재하면 댓글도 삭제
				mainBoardDao.likeDeleteAll(boardSeq); // 좋아요 모두 삭제
			}

			count = mainBoardDao.boardDelete(boardSeq); // 게시물 먼저 지우고 파일 삭제
			if (count > 0) {
				List<MainBoardFile> mainBoardFileList = mainBoard.getMainBoardFile();

				if (mainBoardFileList != null) {
					if (mainBoardDao.boardFileDelete(boardSeq) > 0) // 첨부파일이 존재하면 첨부파일도 삭제
					{
						for (int i = 0; i < mainBoardFileList.size(); i++) {
							FileUtil.deleteFile(UPLOAD_SAVE_DIR + FileUtil.getFileSeparator()
									+ mainBoardFileList.get(i).getFileName());
						}
					}

				}

			}
		}

		return count;
	}

	// 댓글 등록
	public int commentInsert(MainBoardComment mainBoardComment) throws Exception // 여기서 지정해놓은 예외처리는 얘를 "호출하는 쪽"에서
																					// try~catch 처리해야함.
	{
		int count = 0;
		count = mainBoardDao.commentInsert(mainBoardComment);

		return count;
	}

	// 댓글 존재여부 조회
	public int commentCount(long boardSeq) {
		int count = 0;

		try {
			count = mainBoardDao.commentCount(boardSeq);
		} catch (Exception e) {
			logger.error("[mainBoardService] commentCount Exception", e);
		}

		return count;
	}

	// 댓글 조회
	public MainBoardComment commentSelect(long commentSeq) {
		MainBoardComment mainBoardComment = null;

		try {
			mainBoardComment = mainBoardDao.commentSelect(commentSeq);
		} catch (Exception e) {
			logger.error("[MainBoardService] commentSelect Exception", e);
		}

		return mainBoardComment;
	}

	// 댓글 목록
	public List<MainBoardComment> commentList(long boardSeq) {
		List<MainBoardComment> list = null;

		try {
			list = mainBoardDao.commentList(boardSeq);
		} catch (Exception e) {
			logger.error("[MainBoardService] commentList Exception", e);
		}

		return list;
	}

	// 댓글 삭제
	public int commentDelete(long commentSeq) {
		int count = 0;
		MainBoardComment mainBoardComment = mainBoardDao.commentSelect(commentSeq);

		if (mainBoardComment != null) {
			count = mainBoardDao.commentDelete(commentSeq);

		}

		return count;
	}

	// 댓글 수정
	public int commentUpdate(MainBoardComment mainBoardComment) {
		int count = 0;

		try {
			count = mainBoardDao.commentUpdate(mainBoardComment);

		} catch (Exception e) {
			logger.error("[MainBoardService]commentUpdate Exception", e);
		}

		return count;
	}

	// 댓글의 답댓글 등록
	public int commentReplyInsert(MainBoardComment mainBoardComment) {
		int count = 0;

		if (mainBoardComment.getCommentIndent() >= 2) // 해당 댓글이 답답글이라면
		{
			mainBoardDao.commentGroupOrderUpdate(mainBoardComment);
			// 답답글을 인서트하기 전에 ! 아래에 있던 같은그룹 댓글들의 Order를 모두 +1 해서 밀어줌. 내댓글은 사이에 끼워넣기 위해서
		}

		try {
			count = mainBoardDao.commentReplyInsert(mainBoardComment);

		} catch (Exception e) {
			logger.error("[MainBoardService]commentReplyInsert Exception", e);
		}

		return count;
	}

	// 다이어리 게시물 좋아요 처리
	public int likeInsert(MainBoardReaction mainBoardReaction) {
		int count = 0;

		try {
			count = mainBoardDao.likeInsert(mainBoardReaction);
		} catch (Exception e) {
			logger.error("[MainBoardService]likeInsert Exception", e);
		}

		return count;
	}

	// 다이어리 좋아요 취소 시 레코드 삭제
	public int likeDelete(MainBoardReaction mainBoardReaction) {
		int count = 0;

		try {
			count = mainBoardDao.likeDelete(mainBoardReaction);
		} catch (Exception e) {
			logger.error("[MainBoardService]likeDelete Exception", e);
		}

		return count;
	}

	// 다이어리 좋아요 여부 확인용
	public int likeCheck(MainBoardReaction mainBoardReaction) {
		int count = 0;

		try {
			count = mainBoardDao.likeCheck(mainBoardReaction);
		} catch (Exception e) {
			logger.error("[MainBoardService] likeCheck Exception", e);
		}

		return count;
	}

	// 해당글의 총 좋아요 개수
	public int likeCount(long boardSeq) {
		int count = 0;

		try {
			count = mainBoardDao.likeCount(boardSeq);
		} catch (Exception e) {
			logger.error("[MainBoardService] likeCount Exception", e);
		}

		return count;
	}

	// 댓글 삭제시 답댓글이 있는지 조회
	public int replyCheck(long commentSeq) {
		int count = 0;

		try {
			count = mainBoardDao.replyCheck(commentSeq);
		} catch (Exception e) {
			logger.error("[MainBoardService] replyCheck Exception", e);
		}

		return count;
	}

	// 답글이 존재하면 '삭제된 댓글입니다'라고 업데이트
	public int deleteUpdate(long commentSeq) {
		int count = 0;

		try {
			count = mainBoardDao.deleteUpdate(commentSeq);

		} catch (Exception e) {
			logger.error("[MainBoardService]deleteUpdate Exception", e);
		}

		return count;
	}

	// 답글 달때 부모댓글에 달린 답글중 가장 높은 order번호 셀렉트
	public int orderCheck(long commentSeq) {
		int count = 0;

		try {
			count = mainBoardDao.orderCheck(commentSeq);

		} catch (Exception e) {
			logger.error("[MainBoardService]orderCheck Exception", e);
		}

		return count;
	}

	// 답글 달때 부모댓글에 달린 답글중 가장 높은 order번호 셀렉트
	public int orderCheckZero(long commentSeq) {
		int count = 0;

		try {
			count = mainBoardDao.orderCheckZero(commentSeq);

		} catch (Exception e) {
			logger.error("[MainBoardService]orderCheckZero Exception", e);
		}

		return count;
	}

}