package com.icia.web.dao;

import java.util.HashMap;
import java.util.List;

import org.springframework.stereotype.Repository;

import com.icia.web.model.GiftAdd;
import com.icia.web.model.GiftFile;
import com.icia.web.model.RestoReview;

@Repository("giftDao")
public interface GiftDao {

	// 선물 등록
	public int giftInsert(GiftAdd giftAdd);

	// 선물 이미지 등록
	public int giftFileInsert(GiftFile giftFile);

	// 선물 리스트 조회
	public List<GiftAdd> giftList(GiftAdd giftAdd);

	// 선물 낮게
	public List<GiftAdd> giftLowList(GiftAdd giftAdd);

	// 선물 높게
	public List<GiftAdd> giftHighList(GiftAdd giftAdd);

	// 선물 최신
	public List<GiftAdd> giftRecentList(GiftAdd giftAdd);

	// 선물 조회
	public GiftAdd giftSelect(String productSeq);

	// 선물 수
	public long giftCount(GiftAdd giftAdd);

	public int selectCheckFavorite(HashMap<String, String> hashMap);
	
	public int insertProductFavorite(HashMap<String, String> hashMap);
	
	public int deleteProductFavorite(HashMap<String, String> hashMap);
	
	public List<GiftAdd> selectGiftFavoriteList(String userId);
	
	public GiftAdd selectAdminGiftView(String productSeq);

	public List<GiftFile> selectGiftFIleList(String productSeq);  
	
	public List<RestoReview> productReviewList(String productSeq);
}
