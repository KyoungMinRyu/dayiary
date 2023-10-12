package com.icia.web.service;

import java.util.HashMap;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.icia.web.dao.AnniversaryDao;
import com.icia.web.model.Anniversary;
import com.icia.web.model.CoupleAnniversary;

@Service("anniversaryService")
public class AnniversaryService {
	private static Logger logger = LoggerFactory.getLogger(AnniversaryService.class);

	@Autowired
	private AnniversaryDao anniversaryDao;

	public int insertAnniversary(Anniversary anniversary) {
		int count = 0;
		try {
			count = anniversaryDao.insertAnniversary(anniversary);
		} catch (Exception e) {
			logger.error("[AnniversaryService](insertAnniversary)", e);
		}
		return count;
	}

	public CoupleAnniversary selectCoupleAnniversary(String userId) {
		CoupleAnniversary coupleAnniversary = null;
		try {
			coupleAnniversary = anniversaryDao.selectCoupleAnniversary(userId);
		} catch (Exception e) {
			logger.error("[AnniversaryService](selectCoupleAnniversary)", e);
		}
		return coupleAnniversary;
	}

	public List<Anniversary> selectAnniversaryTitleList(Anniversary anniversary) {
		List<Anniversary> anniversaryTitleList = null;
		try {
			anniversaryTitleList = anniversaryDao.selectAnniversaryTitleList(anniversary);
		} catch (Exception e) {
			logger.error("[AnniversaryService](selectAnniversaryTitleList)", e);
		}
		return anniversaryTitleList;
	}

	public List<Anniversary> selectAnniversaryDetailList(Anniversary anniversary) {
		List<Anniversary> anniversaryTitleList = null;
		try {
			anniversaryTitleList = anniversaryDao.selectAnniversaryDetailList(anniversary);
		} catch (Exception e) {
			logger.error("[AnniversaryService](selectAnniversary)", e);
		}
		return anniversaryTitleList;
	}

	public int selechMyAnniversary(HashMap<String, Object> hashMap) {
		int count = 0;
		try {
			count = anniversaryDao.selechMyAnniversary(hashMap);
		} catch (Exception e) {
			logger.error("[AnniversaryService](selechMyAnniversary)", e);
		}
		return count;
	}

	public List<Anniversary> selectSharedList(HashMap<String, Object> hashMap) {
		List<Anniversary> selectShareList = null;
		try {
			selectShareList = anniversaryDao.selectSharedList(hashMap);
		} catch (Exception e) {
			logger.error("[AnniversaryService](selectShareList)", e);
		}
		return selectShareList;
	}

	public List<Anniversary> selectShareableList(HashMap<String, Object> hashMap) {
		List<Anniversary> selectShareableList = null;
		try {
			selectShareableList = anniversaryDao.selectShareableList(hashMap);
		} catch (Exception e) {
			logger.error("[AnniversaryService](selectShareList)", e);
		}
		return selectShareableList;
	}

	public int insertAnniversaryShare(HashMap<String, Object> hashMap) {
		int count = 0;
		try {
			count = anniversaryDao.insertAnniversaryShare(hashMap);
		} catch (Exception e) {
			logger.error("[AnniversaryService](insertAnniversaryShare)", e);
		}
		return count;
	}

	public int deleteAnniversaryShared(HashMap<String, Object> hashMap) {
		int count = 0;
		try {
			count = anniversaryDao.deleteAnniversaryShared(hashMap);
		} catch (Exception e) {
			logger.error("[AnniversaryService](insertAnniversaryShare)", e);
		}
		return count;
	}

	@Transactional(propagation = Propagation.REQUIRED, rollbackFor = Exception.class)
	public int deleteAnniversary(HashMap<String, Object> hashMap) throws Exception {
		int count = 0;
		anniversaryDao.deleteAnniversaryAllShared(hashMap);
		count = anniversaryDao.deleteAnniversary(hashMap);
		return count;
	}

	public int deleteRefuseSharedAnniversary(HashMap<String, Object> hashMap) {
		int count = 0;
		try {
			count = anniversaryDao.deleteRefuseSharedAnniversary(hashMap);
		} catch (Exception e) {
			logger.error("[AnniversaryService](selectFriendStatus)", e);
		}
		return count;
	}

	public List<Anniversary> selectFriendBirthday(Anniversary anniversary) {
		List<Anniversary> selectFriendBirthday = null;
		try {
			selectFriendBirthday = anniversaryDao.selectFriendBirthday(anniversary);
		} catch (Exception e) {
			logger.error("[AnniversaryService](selectFriendBirthday)", e);
		}
		return selectFriendBirthday;
	}

	public List<Anniversary> selectFriendBirProfile(String userId) {
		List<Anniversary> selectFriendBirProfile = null;
		try {
			selectFriendBirProfile = anniversaryDao.selectFriendBirProfile(userId);
		} catch (Exception e) {
			logger.error("[AnniversaryService](selectFriendBirthday)", e);
		}
		return selectFriendBirProfile;
	}

	public List<Anniversary> selectCoupleDate(String userId) {
		List<Anniversary> selectCoupleDate = null;
		try {
			selectCoupleDate = anniversaryDao.selectCoupleDate(userId);
		} catch (Exception e) {
			logger.error("[AnniversaryService](selectFriendBirthday)", e);
		}
		return selectCoupleDate;
	}
	

	public List<String> selectSharedAnniversaryProfileList(HashMap<String, Object> hashMap)
	{
		List<String> list = null;
		try 
		{
			list = anniversaryDao.selectSharedAnniversaryProfileList(hashMap);
		} 
		catch (Exception e) 
		{
			logger.error("[AnniversaryService](selectSharedAnniversaryProfileList)", e);
		}
		return list;
	}
}
