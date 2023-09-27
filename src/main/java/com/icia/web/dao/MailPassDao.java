package com.icia.web.dao;

import java.util.HashMap;

import org.springframework.stereotype.Repository;

@Repository("mailPassDao")
public interface MailPassDao {
	public String userMailSelectCount(String userEmail);

	public String selectStatus(String userEmail);

	public int mailPassInsert(HashMap<String, String> hashMap);

	public int mailPassDelete(String userEmail);

	public int mailPassUpdate(HashMap<String, String> hashMap);

	public int deleteNotUsedEmail();

	public int passwordUpdate(HashMap<String, String> hashMap);

	public int sellerpasswordUpdate(HashMap<String, String> hashMap);
}
