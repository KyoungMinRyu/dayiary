package com.icia.web.service;

import java.util.HashMap;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.icia.web.dao.GiftDao;
import com.icia.web.model.GiftAdd;
import com.icia.web.model.GiftFile;
import com.icia.web.model.RestoReview;

@Service("giftService")
public class GiftService {
	private static Logger logger = LoggerFactory.getLogger(GiftService.class);

	@Autowired
	private GiftDao giftDao;

	// 선물&선물 첨부파일 등록

	public int giftInsert(GiftAdd giftAdd) throws Exception {

		int count = 0;
		count = giftDao.giftInsert(giftAdd);

		List<GiftFile> giftFileList = giftAdd.getGiftFileList();

		String productSeq = "P" + giftAdd.getProductSeq();
		giftAdd.setProductSeq(productSeq);
		if (count > 0 && giftFileList != null) {

			for (int i = 0; i < giftFileList.size(); i++) {
				giftAdd.getGiftFileList().get(i).setProductSeq(productSeq);
				giftDao.giftFileInsert(giftFileList.get(i));
			}

		}

		return count;

	}

	// 선물 리스트
	public List<GiftAdd> giftList(GiftAdd giftAdd) {
		List<GiftAdd> list = null;

		try {
			list = giftDao.giftList(giftAdd);
		} catch (Exception e) {
			logger.error("[GiftService] giftList Exception", e);
		}

		return list;
	}

	// 선물 조회(첨부파일 포함, 포함)
	public GiftAdd giftView(String productSeq) 
	{
		GiftAdd giftAdd = null;
		try 
		{
			giftAdd = giftDao.selectAdminGiftView(productSeq);
			giftAdd.setGiftFileList(giftDao.selectGiftFIleList(productSeq));
		}
		catch (Exception e) 
		{
	         logger.error("[GiftService](giftView)", e);
		}
		return giftAdd;
	}

	// 총 선물 수 조회
	public long giftCount(GiftAdd giftAdd) {
		long count = 0;

		try {
			count = giftDao.giftCount(giftAdd);

		} catch (Exception e) {
			logger.error("[giftService]giftCount Exception", e);
		}

		return count;
	}

	

	public int selectCheckFavorite(HashMap<String, String> hashMap)
	{
		int count = 0;
		try 
		{
			count = giftDao.selectCheckFavorite(hashMap);
		}
		catch (Exception e) 
		{
			logger.error("[GiftService](selectCheckFavorite)", e);
		}
		return count;
	}
	

	public int insertProductFavorite(HashMap<String, String> hashMap)
	{
		int count = 0;
		try 
		{
			count = giftDao.insertProductFavorite(hashMap);
		}
		catch (Exception e) 
		{
			logger.error("[GiftService](insertProductFavorite)", e);
		}
		return count;
	}
	
	public int deleteProductFavorite(HashMap<String, String> hashMap)
	{
		int count = 0;
		try 
		{
			count = giftDao.deleteProductFavorite(hashMap);
		}
		catch (Exception e) 
		{
			logger.error("[GiftService](deleteProductFavorite)", e);
		}
		return count;
	}
	
	public List<GiftAdd> selectGiftFavoriteList(String userId)
	{
		List<GiftAdd> list = null;
		try 
		{
			list = giftDao.selectGiftFavoriteList(userId);
		} 
		catch (Exception e) 
		{
			logger.error("[GiftService](selectGiftFavoriteList)", e);
		}
		return list;
	}
	
	   // 선물 리뷰 리스트
    public List<RestoReview> productReviewList(String productSeq)
    {
       List<RestoReview> productReviewList = null;

       try 
       {
          productReviewList = giftDao.productReviewList(productSeq);
       } 
       catch (Exception e)
       {
          logger.error("[GiftService] productReviewList Exception", e);
       }

       return productReviewList;
    }
}



