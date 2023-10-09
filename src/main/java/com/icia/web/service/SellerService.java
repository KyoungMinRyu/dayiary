package com.icia.web.service;

import java.util.HashMap;


import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
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

	// 파일 저장 경로
    @Value("#{env['upload.save.dir']}")
    private String UPLOAD_SAVE_DIR;
 
	
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

	// 레스토랑 하나에 대한 정보
	public RestoInfo restoInfoBring(String rSeq) {
		RestoInfo restoInfo = null;
		try {
			restoInfo = sellerDao.restoInfoBring(rSeq);
		} catch (Exception e) {
			logger.error("[SellerService] restoInfoBring Exception", e);
		}
		return restoInfo;
	}

	// 레스토랑 하나에 대한 파일 정보
	public List<RestoFile> restoFileBring(String rSeq) {
		List<RestoFile> list = null;
		try {
			list = sellerDao.restoFileBring(rSeq);
		} catch (Exception e) {
			logger.error("[SellerService] menuBring Exception", e);
		}
		return list;
	}

	// 레스토랑 에 대한 메뉴 정보
	public List<Menu> menuBring(String rSeq) {
		List<Menu> list = null;
		try {
			list = sellerDao.menuBring(rSeq);
		} catch (Exception e) {
			logger.error("[SellerService] restoFileBring Exception", e);
		}
		return list;
	}

	// 레스토랑 에 대한 메뉴 파일 정보 ...
	public MenuFile menuFileBring(String menuSeq) {
		MenuFile list = null;
		try {
			list = sellerDao.menuFileBring(menuSeq);
		} catch (Exception e) {
			logger.error("[SellerService] menuFileBring Exception", e);
		}
		return list;
	}

	// 식당 내용 수정


	public List<MenuFile> menuFileListBring(String rSeq)
	{
		List<MenuFile> list = null;
		try 
		{
			list = sellerDao.menuFileListBring(rSeq);
		} 
		catch (Exception e) 
		{
			logger.error("[SellerService](menuFileListBring)", e);
		}
		return list;
	}
	
	@Transactional(propagation = Propagation.REQUIRED, rollbackFor = Exception.class)
	public int restoUpdate(RestoInfo restoInfo, int flag) throws Exception 
	{
		int count = 0;
		count = sellerDao.restoUpdate(restoInfo);
		List<RestoFile> restoFileList = null;
		restoFileList = restoInfo.getRestoFileList();
		HashMap<String, Object> hashMap = new HashMap<String, Object>();
		hashMap.put("rSeq", restoInfo.getrSeq());
		if(flag == 0) 
		{
			hashMap.put("flag", 0);
			sellerDao.restoFileDelete(hashMap);
			for(int i = 0; i < restoFileList.size(); i++) 
			{
				count = sellerDao.insertRestoFile(restoFileList.get(i));
			}			
		} 
		else if(flag == 1) 
		{
			count = sellerDao.restoFileUpdate(restoFileList.get(0));
		} 
		else if(flag == 2) 
		{
			hashMap.put("flag", 1);
			sellerDao.restoFileDelete(hashMap);
			for(int i = 0; i < restoFileList.size(); i++) 
			{
				count = sellerDao.insertRestoFile(restoFileList.get(i));
			}
		}
		List<Menu> menuList = restoInfo.getMenuList();
		MenuFile menuFile = null;
		sellerDao.menuFileDelete(restoInfo.getrSeq());
		sellerDao.menuDelete(restoInfo.getrSeq());
		for (int i = 0; i < menuList.size(); i++) 
		{
			sellerDao.menuInsert(menuList.get(i));
			menuFile = menuList.get(i).getMenuFileList();
			menuFile.setMenuSeq("M" + menuList.get(i).getMenuSeq());
			count = sellerDao.insertMenuFile(menuFile);
		}
		return count;
	}

	
	
	// 선물
	@Transactional(propagation = Propagation.REQUIRED, rollbackFor = Exception.class)
	public int giftUpdate(GiftAdd giftAdd, int flag) throws Exception 
	{
		int count = 0;
		count = sellerDao.giftUpdate(giftAdd);
		List<GiftFile> giftFileList = null;
		String productSeq = giftAdd.getProductSeq();
		giftFileList = giftAdd.getGiftFileList();
		HashMap<String, Object> hashMap = new HashMap<String, Object>();
		hashMap.put("productSeq", productSeq);
		if (flag == 0) 
		{
			count = sellerDao.giftFileDelete(hashMap);
			for (int i = 0; i < giftFileList.size(); i++) 
			{
				giftFileList.get(i).setProductSeq(productSeq);
				count = sellerDao.insertGiftFile(giftFileList.get(i));
			}
		}
		else if (flag == 1) 
		{
			giftFileList.get(0).setProductSeq(productSeq);
			count = sellerDao.updateGiftFile(giftFileList.get(0));
		} 
		else if (flag == 2) 
		{
			hashMap.put("flag", 1);
			count = sellerDao.giftFileDelete(hashMap);
			for (int i = 0; i < giftFileList.size(); i++) 
			{
				giftFileList.get(i).setProductSeq(productSeq);
				count = sellerDao.insertGiftFile(giftFileList.get(i));
			}
		}
		return count;
	}

	
	
	// 선물 하나에 대한 정보
	public GiftAdd giftInfoBring(String productSeq) {
		GiftAdd giftAdd = null;
		try {
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

	public List<OrderList> selectMyGift(String sellerId) {
		List<OrderList> list = null;
		try {
			list = sellerDao.selectMyGift(sellerId);
		} catch (Exception e) {
			logger.error("[SellerService](selectMyGift)", e);
		}
		return list;
	}

	public List<OrderList> selectMyResto(String sellerId) {
		List<OrderList> list = null;
		try {
			list = sellerDao.selectMyResto(sellerId);
		} catch (Exception e) {
			logger.error("[SellerService](selectMyResto)", e);
		}
		return list;
	}

	public List<OrderList> selectRestoPeriodRevenue(HashMap<String, String> hashMap) {
		List<OrderList> list = null;
		try {
			list = sellerDao.selectRestoPeriodRevenue(hashMap);
		} catch (Exception e) {
			logger.error("[SellerService](selectRestoPeriodRevenue)", e);
		}
		return list;
	}

	public List<OrderList> selectGiftPeriodRevenue(HashMap<String, String> hashMap) {
		List<OrderList> list = null;
		try {
			list = sellerDao.selectGiftPeriodRevenue(hashMap);
		} catch (Exception e) {
			logger.error("[SellerService](selectGiftPeriodRevenue)", e);
		}
		return list;
	}
}
