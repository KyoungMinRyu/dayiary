package com.icia.web.dao;

import java.util.HashMap;
import java.util.List;

import org.springframework.stereotype.Repository;

import com.icia.web.model.Anniversary;
import com.icia.web.model.CoupleAnniversary;

@Repository("anniversaryDao")
public interface AnniversaryDao 
{
	public int insertAnniversary(Anniversary anniversary); // 기념일 등록

	public CoupleAnniversary selectCoupleAnniversary(String userId); // 커플일 경우 기념일 가져옴

	public List<Anniversary> selectAnniversaryTitleList(Anniversary anniversary); // 타이틀 리스트

	public List<Anniversary> selectAnniversaryDetailList(Anniversary anniversary); // 날짜 클릭 했을 때 기념일 상세 보기

	public int selechMyAnniversary(HashMap<String, Object> hashMap); // 일정 공유 버튼 눌렀을 떄 내 일정인지 확인

	public List<Anniversary> selectSharedList(HashMap<String, Object> hashMap);// 일정 공유 중인 친구 리스트

	public List<Anniversary> selectShareableList(HashMap<String, Object> hashMap);// 일정 공유 가능 친구 리스트

	public int insertAnniversaryShare(HashMap<String, Object> hashMap); // 일정 공유

	public int deleteAnniversaryShared(HashMap<String, Object> hashMap); // 공유 삭제

	public int deleteAnniversaryAllShared(HashMap<String, Object> hashMap); // 일정 삭제 시 모든 공유 삭제

	public int deleteAnniversary(HashMap<String, Object> hashMap); // 일정 삭제

	public int deleteRefuseSharedAnniversary(HashMap<String, Object> hashMap); // 공유 받은 일정 삭제

	public List<Anniversary> selectFriendBirthday(Anniversary anniversary);

	public List<Anniversary> selectAllUserBirthday();

	public List<Anniversary> selectAllUserAnniversary();

	public List<CoupleAnniversary> selectAllCoupleAnniversary();

	// 추가한거
	public List<Anniversary> selectFriendBirProfile(String userId); // 친구 생일 이미지

	public List<Anniversary> selectCoupleDate(String userId);
	
	public List<String> selectSharedAnniversaryProfileList(HashMap<String, Object> hashMap);
	
	public List<Anniversary> selectMyPageAnniversary(String userId);
}
