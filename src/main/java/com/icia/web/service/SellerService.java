package com.icia.web.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.icia.web.dao.SellerDao;
import com.icia.web.model.GiftAdd;
import com.icia.web.model.GiftFile;
import com.icia.web.model.Menu;
import com.icia.web.model.MenuFile;
import com.icia.web.model.OrderList;
import com.icia.web.model.RestoFile;
import com.icia.web.model.RestoInfo;
import com.icia.web.model.Seller;

@Service("sellerService")
public class SellerService {
	private static Logger logger = LoggerFactory.getLogger(SellerService.class);

	@Autowired
	private SellerDao sellerDao;

	// 판매자 id 체크
	public Seller sellerIdSelect(String sellerId) {
		Seller seller = null;
		try {
			seller = sellerDao.sellerIdSelect(sellerId);
		} catch (Exception e) {
			logger.error("[SellerService](sellerIdSelect) Exception", e);
		}
		return seller;
	}

	// 판매자 사업자 번호 중복체크
	public Seller sellerBidSelect(String sellerBid) {
		Seller seller = null;
		try {
			seller = sellerDao.sellerBidSelect(sellerBid);
		} catch (Exception e) {
			logger.error("[SellerService](sellerIdSelect) Exception", e);
		}
		return seller;
	}

// 판매자 입력
	public int sellerInsert(Seller seller) {
		int count = 0;

		try {
			count = sellerDao.sellerInsert(seller);
		} catch (Exception e) {
			logger.error("[SellerService](sellerInsert)", e);
		}
		return count;
	}

	// 판매자 아이디 찾기
	public Seller lostsellerIdFind(Map<String, String> params) {
		Seller seller = null;
		try {
			// DAO의 lostIdFind 메서드 호출
			seller = sellerDao.lostsellerIdFind(params);
		} catch (Exception e) {
			logger.error("[SellerService] lostsellerIdFind Exception", e);
		}
		return seller;
	}

	// 판매자 비밀번호 찾기
	public int sellerpwdCheck(Seller seller) {
		int count = 0;
		try {
			count = sellerDao.sellerpwdCheck(seller);
		} catch (Exception e) {
			logger.error("[UserService](pwdCheck)", e);
		}
		return count;
	}

	public Seller selectReservCntRevenue(String sellerId) {
		Seller seller = null;
		try {
			seller = sellerDao.selectReservCntRevenue(sellerId);
		} catch (Exception e) {
			logger.error("[SellerService](selectReservCntRevenue)", e);
		}
		return seller;
	}

	// 셀러 등록 총 레스토랑 수
	public int myRestoTotalCnt(RestoInfo restoInfo) {
		int count = 0;

		try {
			count = sellerDao.myRestoTotalCnt(restoInfo);

		} catch (Exception e) {
			logger.error("[SellerService] myRestoTotalCnt Exception", e);
		}

		return count;
	}

	// 셀러 등록 레스토랑
	public List<RestoInfo> myResto(String sellerId) {
		List<RestoInfo> list = null;

		try {
			list = sellerDao.myResto(sellerId);
		} catch (Exception e) {
			logger.error("[SellerService] myResto Exception", e);
		}

		return list;
	}

	// 셀러 등록 총 선물 수
	public int myGiftTotalCnt(GiftAdd giftAdd) {
		int count = 0;

		try {
			count = sellerDao.myGiftTotalCnt(giftAdd);

		} catch (Exception e) {
			logger.error("[SellerService] myGiftTotalCnt Exception", e);
		}

		return count;
	}

	// 셀러 등록 선물
	public List<GiftAdd> myGift(String sellerId) {
		List<GiftAdd> list = null;

		try {
			list = sellerDao.myGift(sellerId);
		} catch (Exception e) {
			logger.error("[SellerService] myGift Exception", e);
		}

		return list;
	}

	// 판매자 정보 수정
	public int sellerUpdate(Seller seller) {
		int count = 0;

		try {
			count = sellerDao.sellerUpdate(seller);
		} catch (Exception e) {
			logger.error("[SellerUpdate]sellerUpdate Exception", e);
		}
		return count;
	}

	// 식당 하나에 대한 정보 보기
	public RestoInfo restoBring(String rSeq) {
		RestoInfo restoInfo = null;
		try {
			logger.debug("아아");
			restoInfo = sellerDao.restoBring(rSeq);
		} catch (Exception e) {
			logger.error("[SellerService] restoBring Exception", e);
		}
		return restoInfo;
	}

	// 식당 내용 수정

	@Transactional(propagation = Propagation.REQUIRED, rollbackFor = Exception.class)
	public int restoUpdate(RestoInfo restoInfo) throws Exception {

		int count = 0;
		count = sellerDao.restoUpdate(restoInfo);

		List<RestoFile> restoFileList = restoInfo.getRestoFileList();
		List<Menu> menuList = restoInfo.getMenuList();

		if (count > 0 && restoFileList != null && menuList != null) {
			logger.debug("[sellerservice] restoUpdate");

			for (int i = 0; i < restoFileList.size(); i++) {
				sellerDao.restoFileUpdate(restoInfo.getRestoFileList().get(i));
			}

			MenuFile menuFile;
			for (int i = 0; i < menuList.size(); i++) {
				Menu menu = menuList.get(i);
				menuFile = menu.getMenuFileList(); // 각 반복에서 새로운 MenuFile 객체 생성

				sellerDao.menuUpdate(menu);

				System.out.println(menuFile.getFileName());
				logger.debug("[sellerservice] restoUpdate2");

				sellerDao.menuFileUpdate(menuFile);

			}

		}

		return count;

	}

	// 선물 하나에 대한 정보
	public GiftAdd giftInfoBring(String productSeq) {
		GiftAdd giftAdd = null;
		try {
			logger.debug("아아");
			giftAdd = sellerDao.giftInfoBring(productSeq);
		} catch (Exception e) {
			logger.error("[SellerService] giftInfoBring Exception", e);
		}
		return giftAdd;
	}

	// 선물 하나에 대한 파일 정보
	public List<GiftFile> giftFileBring(String productSeq) {
		List<GiftFile> list = null;
		try {
			list = sellerDao.giftFileBring(productSeq);
		} catch (Exception e) {
			logger.error("[SellerService] giftFileBring Exception", e);
		}
		return list;
	}

	// 셀러 등록 결제된 레스토랑
	public List<OrderList> myRestoOrder(OrderList orderList) {
		List<OrderList> list = null;

		try {
			list = sellerDao.myRestoOrder(orderList);
		} catch (Exception e) {
			logger.error("[SellerService] myRestoOrder Exception", e);
		}

		return list;
	}

	// 셀러 등록 결제된 선물
	public List<OrderList> myGiftOrder(OrderList orderList) {
		List<OrderList> list = null;

		try {
			list = sellerDao.myGiftOrder(orderList);
		} catch (Exception e) {
			logger.error("[SellerService] myGiftOrder Exception", e);
		}

		return list;
	}

	// 선물 수
	public int GiftOrderTotalCnt(OrderList orderList) {
		int count = 0;
		try {
			count = sellerDao.GiftOrderTotalCnt(orderList);
		} catch (Exception e) {
			logger.error("[SellerService](GiftOrderTotalCnt)", e);
		}
		return count;
	}

	// 결제완료에서 배송준비중
	public int confirmGiftOrder(String orderSeq) {
		int count = 0;
		try {
			count = sellerDao.confirmGiftOrder(orderSeq);
		} catch (Exception e) {
			logger.error("[SellerService](confirmGiftOrder)", e);
		}
		return count;
	}

	// 운송장 번호, 택배 회사 데이터 넣기
	@Transactional(propagation = Propagation.REQUIRED, rollbackFor = Exception.class)
	public int updateDeliver(HashMap<String, Object> hashMap) {
		int count = 0;
		count = sellerDao.updateDeliver(hashMap);
		count = sellerDao.confirmGiftOrder2((String) hashMap.get("orderSeq"));
		return count;
	}
	

	public List<OrderList> selectMyGift(String sellerId)
	{
		List<OrderList> list = null;
		try 
		{
			list = sellerDao.selectMyGift(sellerId);
		}
		catch (Exception e) 
		{
			logger.error("[SellerService](selectMyGift)", e);
		}
		return list;
	}

	public List<OrderList> selectMyResto(String sellerId)
	{
		List<OrderList> list = null;
		try 
		{
			list = sellerDao.selectMyResto(sellerId);
		}
		catch (Exception e) 
		{
			logger.error("[SellerService](selectMyResto)", e);
		}
		return list;
	}
	

	public List<OrderList> selectRestoPeriodRevenue(HashMap<String, String> hashMap)
	{
		List<OrderList> list = null;
		try 
		{
			list = sellerDao.selectRestoPeriodRevenue(hashMap);
		}
		catch (Exception e) 
		{
			logger.error("[SellerService](selectRestoPeriodRevenue)", e);
		}
		return list;
	}
	
	public List<OrderList> selectGiftPeriodRevenue(HashMap<String, String> hashMap)
	{
		List<OrderList> list = null;
		try 
		{
			list = sellerDao.selectGiftPeriodRevenue(hashMap);
		}
		catch (Exception e) 
		{
			logger.error("[SellerService](selectGiftPeriodRevenue)", e);
		}
		return list;
	}
}
