package com.icia.web.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.icia.web.model.GiftAdd;
import com.icia.web.model.GiftFile;
import com.icia.web.model.Menu;
import com.icia.web.model.MenuFile;
import com.icia.web.model.OrderList;
import com.icia.web.model.RestoFile;
import com.icia.web.model.RestoInfo;
import com.icia.web.model.Seller;

@Repository("sellerDao")
public interface SellerDao {
	// 판매자 아이디 중복체크
	public Seller sellerIdSelect(String sellerId);

	// 판매자 사업자 번호 중복체크
	public Seller sellerBidSelect(String sellerBid);

	// 판매자 값 db 등록
	public int sellerInsert(Seller seller);

	// 판매자 아이디찾기
	public Seller lostsellerIdFind(Map<String, String> params);

	// 판매자 비밀번호찾기
	public int sellerpwdCheck(Seller seller);

	public Seller selectReservCntRevenue(String sellerId);

	// 판매자 레스토랑 리스트
	public List<RestoInfo> myResto(String sellerId);

	// 판매자 레스토랑 수
	public int myRestoTotalCnt(RestoInfo restoInfo);

	// 판매자 선물 리스트
	public List<GiftAdd> myGift(String sellerId);

	// 판매자 선물 수
	public int myGiftTotalCnt(GiftAdd giftAdd);

	// 판매자 선물 조회
	public RestoInfo restoBring(String rSeq);

	// 판매자 정보 수정
	public int sellerUpdate(Seller seller);

	// 판매자 레스토랑 정보수정
	public int restoUpdate(RestoInfo restoInfo);

	// 판매자 메뉴 정보수정
	public int menuUpdate(Menu menu);

	// 판매자 레스토랑 사진 수정
	public int restoFileUpdate(RestoFile restoFile);

	// 판매자 메뉴 사진 수정
	public int menuFileUpdate(MenuFile menuFile);

	// 레스토랑 결제리스트
	public List<OrderList> myRestoOrder(OrderList orderList);

	// 선물 결제리스트
	public List<OrderList> myGiftOrder(OrderList orderList);

	// 선물 결제 수
	public int GiftOrderTotalCnt(OrderList orderList);

	// 주문확인>배송준비중(운송장번호입력)으로 상태바꾸기
	public int confirmGiftOrder(String orderSeq);

	// 운송장번호&회사 입력하기
	public int updateDeliver(HashMap<String, Object> hashMap);

	// 배송중상태로 변경하기
	public int confirmGiftOrder2(String orderSeq);

	// 하나의 레스토랑 정보
	public RestoInfo restoInfoBring(String rSeq);

	// 하나의 레스토랑에 대한 파일들 정보
	public List<RestoFile> restoFileBring(String rSeq);

	// 하나의 레스토랑의 메뉴 정보
	public List<Menu> menuBring(String rSeq);

	// 하나의 선물에 대한 파일들 정보
	public MenuFile menuFileBring(String rSeq);

	public List<MenuFile> menuFileListBring(String rSeq);

	public int menuInsert(Menu menu);

	public int insertMenuFile(MenuFile menuFile);

	// 하나의 선물 정보
	public GiftAdd giftInfoBring(String productSeq);

	// 하나의 선물에 대한 파일들 정보
	public List<GiftFile> giftFileBring(String productSeq);

	// 하나의 선물 정보 수정
	public int giftUpdate(GiftAdd giftAdd);

	// 하나의 선물 사진 정보 삭제 int boardFileDelete(long hiBbsSeq);
	public int giftFileDelete(HashMap<String, Object> hashMap);

	public int updateGiftFile(GiftFile giftFile);

	// 선물 이미지 재등록
	public int insertGiftFile(GiftFile giftFile);

	public int restoFileDelete(HashMap<String, Object> hashMap);

	public int insertRestoFile(RestoFile restoFile);

	public int menuDelete(String rSeq);

	public int menuFileDelete(String menuSeq);

	public List<OrderList> selectMyGift(String sellerId);

	public List<OrderList> selectMyResto(String sellerId);

	public List<OrderList> selectRestoPeriodRevenue(HashMap<String, String> hashMap);

	public List<OrderList> selectGiftPeriodRevenue(HashMap<String, String> hashMap);
}
