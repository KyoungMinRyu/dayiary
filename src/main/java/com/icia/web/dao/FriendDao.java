package com.icia.web.dao;

import java.util.HashMap;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.icia.web.model.CoupleAnniversary;
import com.icia.web.model.Friend;

@Repository("friendDao")
public interface FriendDao 
{
	public Friend selectUser(String userId);

	public List<Friend> friendList(Friend search);

	public Friend selectYourUser(HashMap<String, String> hashMap);

	public int deleteFriend(long relationalSeq);

	public int requestFriend(Friend requestFriend);

	public List<Friend> requestForMeList(Friend search);

	public int refuseFriend(long relationalSeq);

	public String selectStatus(long relationalSeq);

	public int acceptFriend(long relationalSeq);

	public List<Friend> myFriendList(Friend search);

	public int coupleSelect(HashMap<String, String> hashMap);

	public List<Friend> requestForYouList(Friend search);

	public int insertCoupleAnniversary(CoupleAnniversary coupleAnniversary);

	public int changeCouple(long relationalSeq);

	public int deleteCoupleAnniversary(long relationalSeq);

	public int updateCoupleAnniversary(long relationalSeq);

	public int deleteShareAnniversary(long relationalSeq);

	public List<Friend> selectYourId(String userId);

	public Friend selectFreind(long relationalSeq);

	public int selectFriendStatus(HashMap<String, Object> hashMap);
}
