package com.icia.web.service;

import java.util.HashMap;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.icia.web.dao.MailPassDao;

@Service("mailPassService")
public class MailPassService {
	private static Logger logger = LoggerFactory.getLogger(MailPassService.class);

	@Autowired
	private MailPassDao mailPassDao;

	public String userMailSelectCount(String userEmail) {
		String count = "0";
		try {
			count = mailPassDao.userMailSelectCount(userEmail);
		} catch (Exception e) {
			logger.error("[MailPassService](userMailSelectCount)", e);
		}
		return count;
	}

	public String selectStatus(String userEmail) {
		String status = "";
		try {
			status = mailPassDao.selectStatus(userEmail);
		} catch (Exception e) {
			logger.error("[MailPassService](selectStatus)", e);
		}
		return status;
	}

	public int mailPassInsert(HashMap<String, String> hashMap) {
		int count = 0;
		try {
			count = mailPassDao.mailPassInsert(hashMap);
		} catch (Exception e) {
			logger.error("[MailPassService](userMailSelectCount)", e);
		}
		return count;
	}

	public int mailPassDelete(String userEmail) {
		int count = 0;
		try {
			count = mailPassDao.mailPassDelete(userEmail);
		} catch (Exception e) {
			logger.error("[MailPassService](userMailSelectCount)", e);
		}
		return count;
	}

	public int mailPassUpdate(HashMap<String, String> hashMap) {
		int count = 0;
		try {
			count = mailPassDao.mailPassUpdate(hashMap);
		} catch (Exception e) {
			logger.error("[MailPassService](mailPassUpdate)", e);
		}
		return count;
	}

	// 일반회원 비밀번호 찾기 수정
	public int passwordUpdate(HashMap<String, String> hashMap) {
		int count = 0;
		try {
			count = mailPassDao.passwordUpdate(hashMap);
		} catch (Exception e) {
			logger.error("[MailPassService](mailPassUpdate)", e);
		}
		return count;
	}

	// 판매자 비밀번호 찾기 수정
	public int sellerpasswordUpdate(HashMap<String, String> hashMap) {
		int count = 0;
		try {
			count = mailPassDao.sellerpasswordUpdate(hashMap);
		} catch (Exception e) {
			logger.error("[MailPassService](mailPassUpdate)", e);
		}
		return count;
	}
}