package com.icia.web.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.icia.web.model.Msg;

@Repository("sendMsgDao")
public interface SendMsgDao {
	public int sendMsg(Msg msg);

	public int toCount(String cookieUserId);

	public int fromCount(String cookieUserId);

	public List<Msg> currentList(String cookieUserId);

	public List<Msg> postList(Msg search);

	public String readCheck(Msg msg);

	public int readUpdate(Msg msg);
}