package com.icia.web.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.icia.web.dao.RestoDao;
import com.icia.web.model.Menu;
import com.icia.web.model.MenuFile;
import com.icia.web.model.OrderList;
import com.icia.web.model.RestoFile;
import com.icia.web.model.RestoInfo;
import com.icia.web.model.RestoReview;

@Service("restoService")
public class RestoService {
	private static Logger logger = LoggerFactory.getLogger(RestoService.class);

	@Autowired
	private RestoDao restoDao;

	// 레스토랑 리스트
	public List<RestoInfo> restoList(RestoInfo restoInfo) {
		List<RestoInfo> list = null;

		try {
			list = restoDao.restoList(restoInfo);
		} catch (Exception e) {
			logger.error("[RestoService] restoList Exception", e);
		}

		return list;
	}

	// 총 레스토랑 수 조회
	public long restoCount(RestoInfo restoInfo) {
		long count = 0;

		try {
			count = restoDao.restoCount(restoInfo);

		} catch (Exception e) {
			logger.error("[RestoService] restoCount Exception", e);
		}

		return count;
	}

	// 레스토랑 조회
	public RestoInfo restoSelect(String rSeq) {
		RestoInfo restoInfo = null;

		try {
			restoInfo = restoDao.restoSelect(rSeq);
		} catch (Exception e) {
			logger.error("[RestoService] restoSelect Exception", e);
		}

		return restoInfo;
	}

	// 게시물 첨부파일 조회
	public List<RestoFile> restoFileSelect(String rSeq) {
		List<RestoFile> restoFileList = new ArrayList<RestoFile>();

		try {
			restoFileList = restoDao.restoFileSelect(rSeq);
		} catch (Exception e) {
			logger.error("[RestoService] restoFileSelect Exception", e);
		}

		return restoFileList;
	}

	// 레스토랑 조회(첨부파일 포함)
	public RestoInfo restoView(String rSeq) {
		RestoInfo restoInfo = null;

		try {
			restoInfo = restoDao.restoSelect(rSeq);

			if (restoInfo != null) {
				List<RestoFile> restoFileList = restoDao.restoFileSelect(rSeq);
				List<Menu> menuList = restoDao.menuSelect(rSeq);

				if (restoFileList != null) {
					restoInfo.setRestoFileList(restoFileList);
				}

				if (menuList != null) {
					restoInfo.setMenuList(menuList);
				}

			}
		} catch (Exception e) {
			logger.error("[RestoService] restoView Exception", e);
		}

		return restoInfo;
	}

	// 메뉴 조회 - 메뉴와 메뉴파일 연결해서 읽어오기
	// 연결했는데 트랜잭션 안걸어도 되는 이유 : select문이라서. DB를 건드리는게 아니니까 롤백도 필요 없기 때문
	public List<Menu> menuSelect(String rSeq) {
		List<Menu> menuList = new ArrayList<Menu>();

		try {
			menuList = restoDao.menuSelect(rSeq);
		} catch (Exception e) {
			logger.error("[RestoService] menuSelect Exception", e);
		}

		return menuList;
	}

	// 레스토랑 예약신청 들어온거 인서트
	public int restoReservationInsert(OrderList orderList) {
		int count = 0;

		try {
			count = restoDao.restoReservationInsert(orderList);
		} catch (Exception e) {
			logger.error("[RestoService]restoReservationInsert Exception", e);
		}

		return count;
	}

	// 레스토랑 인기 TOP4 매장
	public List<RestoInfo> bestRestList() {
		List<RestoInfo> bestRestoList = null;

		try {
			bestRestoList = restoDao.bestRestoList();
		} catch (Exception e) {
			logger.error("[RestoService] bestRestoList Exception", e);
		}

		return bestRestoList;
	}

	// 레스토랑 날짜,시간별 예약인원 (잔여좌석 확인용)
	public int limitPersonCheck(OrderList orderList) {
		int count = 0;

		try {
			count = restoDao.limitPersonCheck(orderList);
		} catch (Exception e) {
			logger.error("[RestoService] limitPersonCheck Exception", e);
		}

		return count;
	}

	// 예약건 w -> y 업데이트
	public int restoReservationUpdate(String orderSeq) {
		int count = 0;

		try {
			count = restoDao.restoReservationUpdate(orderSeq);

		} catch (Exception e) {
			logger.error("[RestoService]restoReservationUpdate Exception", e);
		}

		return count;
	}

	// 레스토랑 리뷰 리스트
	public List<RestoReview> reviewList(String rSeq) {
		List<RestoReview> reviewList = null;

		try {
			reviewList = restoDao.reviewList(rSeq);
		} catch (Exception e) {
			logger.error("[RestoService] reviewList Exception", e);
		}

		return reviewList;
	}

	// 리스트에 등록

	@Transactional(propagation = Propagation.REQUIRED, rollbackFor = Exception.class)
	public int restoListInsert(RestoInfo restoInfo) throws Exception {

		int count = 0;
		count = restoDao.restoListInsert(restoInfo);

		List<RestoFile> restoFileList = restoInfo.getRestoFileList();
		List<Menu> menuList = restoInfo.getMenuList();

		String rSeq = "R" + restoInfo.getrSeq();

		if (count > 0 && restoFileList != null && menuList != null) {

			for (int i = 0; i < restoFileList.size(); i++) {
				restoInfo.getRestoFileList().get(i).setrSeq(rSeq);
				restoDao.restoFileInsert(restoInfo.getRestoFileList().get(i));
			}

			MenuFile menuFile;
			for (int i = 0; i < menuList.size(); i++) {
				Menu menu = menuList.get(i);
				menu.setrSeq(rSeq);
				menuFile = menu.getMenuFileList(); // 각 반복에서 새로운 MenuFile 객체 생성

				restoDao.restoMenuInsert(menu);

				String mSeq = "M" + menu.getMenuSeq();
				menuFile.setMenuSeq(mSeq);
				System.out.println(menuFile.getFileName());
				restoDao.menuFileInsert(menuFile);

			}

		}

		return count;

	}

	// 메뉴 추가
	public int restoMenuInsert(Menu menu) {
		int count = 0;

		try {
			count = restoDao.restoMenuInsert(menu);
		} catch (Exception e) {
			logger.error("[RestoService](restoMenuInsertCount) Exception", e);
		}

		return count;
	}

	public int deleteOneHourLaterReserv() {
		int count = 0;
		try {
			count = restoDao.deleteOneHourLaterReserv();
		} catch (Exception e) {
			logger.error("[RestoService](deleteOneHourLaterReserv)", e);
		}

		return count;
	}
	

	public int selectCheckFavorite(HashMap<String, String> hashMap)
	{
		int count = 0;
		try 
		{
			count = restoDao.selectCheckFavorite(hashMap);
		}
		catch (Exception e) 
		{
			logger.error("[RestoService](selectCheckFavorite)", e);
		}
		return count;
	}
	
	public int deleteRestoFavorite(HashMap<String, String> hashMap)
	{
		int count = 0;
		try 
		{
			count = restoDao.deleteRestoFavorite(hashMap);
		}
		catch (Exception e) 
		{
			logger.error("[RestoService](deleteRestoFavorite)", e);
		}
		return count;
	}
	
	public int insertRestoFavorite(HashMap<String, String> hashMap)
	{
		int count = 0;
		try 
		{
			count = restoDao.insertRestoFavorite(hashMap);
		}
		catch (Exception e) 
		{
			logger.error("[RestoService](insertRestoFavorite)", e);
		}
		return count;
	}
	
	public List<RestoInfo> selectRestoFavoriteList(String userId)
	{
		List<RestoInfo> list = null;
		try 
		{
			list = restoDao.selectRestoFavoriteList(userId);
		}
		catch (Exception e) 
		{
			logger.error("[RestoService](selectRestoFavoriteList)", e);
		}
		return list;
		
	}
}









