package com.icia.web.dao;

import java.util.HashMap;
import java.util.List;

import org.springframework.stereotype.Repository;

import com.icia.web.model.KakaoPayApprove;
import com.icia.web.model.Menu;
import com.icia.web.model.MenuFile;
import com.icia.web.model.OrderList;
import com.icia.web.model.RestoFile;
import com.icia.web.model.RestoInfo;
import com.icia.web.model.RestoReview;

@Repository("restoDao")
public interface RestoDao {

	// 레스토랑 등록
	public int restoInsert(RestoInfo restoInfo);

	// 레스토랑 리스트
	public List<RestoInfo> restoList(RestoInfo restoInfo);

	// 총 레스토랑 수
	public long restoCount(RestoInfo restoInfo);

	// 레스토랑 조회
	public RestoInfo restoSelect(String rSeq);

	// 매장 정보 등록
	public int restoListInsert(RestoInfo restoInfo);

	// 매장 첨부파일 등록
	public int restoFileInsert(RestoFile restoFile);

	// 매장 대표메뉴 등록
	public int restoMenuInsert(Menu menu);

	// 매장 메뉴파일 등록
	public int menuFileInsert(MenuFile menuFile);

	// 게시물 첨부파일 조회
	public List<RestoFile> restoFileSelect(String rSeq);

	// 메뉴 + 메뉴사진 조회
	public List<Menu> menuSelect(String rSeq);

	// 레스토랑 예약정보 등록(W:결제대기중)
	public int restoReservationInsert(OrderList orderList);

	// 인기 레스토랑 TOP4 조회
	public List<RestoInfo> bestRestoList();

	// 날짜,시간별 몇명이 예약했는지 조회(잔여좌석체크용)
	public int limitPersonCheck(OrderList orderList);

	// 레스토랑 예약정보 업데이트(W -> Y:결제완료)
	public int restoReservationUpdate(String orderSeq);

	// 결제 완료 후 카카오페이 PAY_LIST 인서트
	public int payListInsert(KakaoPayApprove kakaoPayApprove);

	// 해당 레스토랑의 리뷰 조회
	public List<RestoReview> reviewList(String rSeq);

	public int deleteOneHourLaterReserv();
	
	public int selectCheckFavorite(HashMap<String, String> hashMap);
	
	public int deleteRestoFavorite(HashMap<String, String> hashMap);
	
	public int insertRestoFavorite(HashMap<String, String> hashMap);
	
	public List<RestoInfo> selectRestoFavoriteList(String userId);
	
	public int deleteOneHourLaterReservPayList();
}