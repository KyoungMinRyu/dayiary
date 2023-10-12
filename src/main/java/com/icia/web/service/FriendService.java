package com.icia.web.service;

import java.util.HashMap;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.icia.web.dao.FriendDao;
import com.icia.web.model.CoupleAnniversary;
import com.icia.web.model.Friend;

@Service("friendService")
public class FriendService {
	private static Logger logger = LoggerFactory.getLogger(FriendService.class);

	@Autowired
	private FriendDao friendDao;

	public Friend selectUser(String userId) {
		Friend friend = null;
		try {
			friend = friendDao.selectUser(userId);
		} catch (Exception e) {
			logger.error("[FriendService](selectUser)", e);
		}
		return friend;
	}

	public List<Friend> friendList(Friend search) {
		List<Friend> friendList = null;
		try {
			friendList = friendDao.friendList(search);
		} catch (Exception e) {
			logger.error("[FriendService](friendList)", e);
		}

		return friendList;
	}

	public Friend selectYourUser(HashMap<String, String> hashMap) {
		Friend friend = null;
		try {
			friend = friendDao.selectYourUser(hashMap);
		} catch (Exception e) {
			logger.error("[FriendService](selectYourUser)", e);
		}
		return friend;
	}

	public int deleteFriend(long relationalSeq) {
		int count = 0;
		friendDao.deleteShareAnniversary(relationalSeq);
		try {
			count = friendDao.deleteFriend(relationalSeq);
		} catch (Exception e) {
			logger.error("[FriendService](deleteFriend)", e);
		}
		return count;
	}

	public int requestFriend(Friend requestFriend) {
		int count = 0;
		try {
			count = friendDao.requestFriend(requestFriend);
		} catch (Exception e) {
			logger.error("[FriendService](requestFriend)", e);
		}
		return count;
	}

	/**
	 * <pre>
	 * 친구가 아닌 상태에서 연인 신청
	 **/
	@Transactional(propagation = Propagation.REQUIRED, rollbackFor = Exception.class)
	public int requestCouple(Friend requestCouple, CoupleAnniversary coupleAnniversary) throws Exception {
		int count = 0;
		count = friendDao.requestFriend(requestCouple);
		if (count > 0) {
			coupleAnniversary.setRelationalSeq(requestCouple.getRelationalSeq());
			count = friendDao.insertCoupleAnniversary(coupleAnniversary);
		}
		return count;
	}

	@Transactional(propagation = Propagation.REQUIRED, rollbackFor = Exception.class)
	public int changeCouple(long relationalSeq, CoupleAnniversary coupleAnniversary) throws Exception {
		int count = 0;
		count = friendDao.changeCouple(relationalSeq);
		if (count > 0) {
			count = friendDao.insertCoupleAnniversary(coupleAnniversary);
		}
		return count;
	}

	@Transactional(propagation = Propagation.REQUIRED, rollbackFor = Exception.class)
	public int cancleCouple(long relationalSeq) throws Exception {
		int count = 0;
		count = friendDao.deleteCoupleAnniversary(relationalSeq);
		if (count > 0) {
			count = friendDao.deleteFriend(relationalSeq);
		}
		return count;
	}

	@Transactional(propagation = Propagation.REQUIRED, rollbackFor = Exception.class)
	public int refuseCouple(long relationalSeq) throws Exception {
		int count = 0;
		count = friendDao.deleteCoupleAnniversary(relationalSeq);
		if (count > 0) {
			count = friendDao.refuseFriend(relationalSeq);
		}
		return count;
	}

	@Transactional(propagation = Propagation.REQUIRED, rollbackFor = Exception.class)
	public int deleteCouple(long relationalSeq) throws Exception {
		int count = 0;
		friendDao.deleteShareAnniversary(relationalSeq);
		count = friendDao.deleteCoupleAnniversary(relationalSeq);
		if (count > 0) {
			count = friendDao.deleteFriend(relationalSeq);
		}
		return count;
	}

	@Transactional(propagation = Propagation.REQUIRED, rollbackFor = Exception.class)
	public int acceptCouple(long relationalSeq) throws Exception {
		int count = 0;
		count = friendDao.acceptFriend(relationalSeq);
		if (count > 0) {
			count = friendDao.updateCoupleAnniversary(relationalSeq);
		}
		return count;
	}

	public List<Friend> requestForMeList(Friend search) {
		List<Friend> friendList = null;
		try {
			friendList = friendDao.requestForMeList(search);
		} catch (Exception e) {
			logger.error("[FriendService](requestForMeList)", e);
		}

		return friendList;
	}

	public String selectStatus(long relationalSeq) {
		String status = "";
		try {
			status = friendDao.selectStatus(relationalSeq);
		} catch (Exception e) {
			logger.error("[FriendService](selectStatus)", e);
		}
		return status;
	}

	public int refuseFriend(long relationalSeq) {
		int count = 0;
		try {
			count = friendDao.refuseFriend(relationalSeq);
		} catch (Exception e) {
			logger.error("[FriendService](refuseFriend)", e);
		}
		return count;
	}

	public int acceptFriend(long relationalSeq) {
		int count = 0;
		try {
			count = friendDao.acceptFriend(relationalSeq);
		} catch (Exception e) {
			logger.error("[FriendService](refuseFriend)", e);
		}
		return count;
	}

	public List<Friend> myFriendList(Friend search) {
		List<Friend> myFriendList = null;
		try {
			myFriendList = friendDao.myFriendList(search);
		} catch (Exception e) {
			logger.error("[FriendService](requestForMeList)", e);
		}

		return myFriendList;
	}

	public int coupleSelect(HashMap<String, String> hashMap) {
		int count = 0;
		try {
			count = friendDao.coupleSelect(hashMap);
		} catch (Exception e) {
			logger.error("[FriendService](coupleSelect)", e);
		}
		return count;
	}

	public List<Friend> requestForYouList(Friend search) {
		List<Friend> myFriendList = null;
		try {
			myFriendList = friendDao.requestForYouList(search);
		} catch (Exception e) {
			logger.error("[FriendService](requestForMeList)", e);
		}

		return myFriendList;
	}

	public List<Friend> selectYourId(String userId) {
		List<Friend> list = null;
		try {
			list = friendDao.selectYourId(userId);
		} catch (Exception e) {
			logger.error("[FriendService](selectYourId)", e);
		}
		return list;
	}

	public Friend selectFreind(long relationalSeq) {
		Friend friend = null;
		try {
			friend = friendDao.selectFreind(relationalSeq);
		} catch (Exception e) {
			logger.error("[FriendService](selectFreind)", e);
		}
		return friend;
	}

	public int selectFriendStatus(HashMap<String, Object> hashMap) {
		int count = 0;
		try {
			count = friendDao.selectFriendStatus(hashMap);
		} catch (Exception e) {
			logger.error("[FriendService](selectFriendStatus)", e);
		}
		return count;
	}

}
