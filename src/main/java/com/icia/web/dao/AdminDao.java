package com.icia.web.dao;

import java.util.HashMap;
import java.util.List;

import org.springframework.stereotype.Repository;

import com.icia.web.model.Admin;
import com.icia.web.model.Seller;
import com.icia.web.model.UserG2;

@Repository("adminDao")
public interface AdminDao {
	// 사용자 리스트
	public List<UserG2> userList(UserG2 user);

	// 사용자 수 조회
	public int userListCount(UserG2 user);

	// 사용자 조회
	public UserG2 userSelect(String userId);

	// 사용자 수정
	public int userUpdate(UserG2 user);

	// 판매자 리스트
	public List<Seller> sellerList(Seller seller);

	// 판매자 수 조회
	public int sellerListCount(Seller seller);

	// 사용자 조회
	public Seller sellerSelect(String sellerId);

	// 판매자 수정
	public int sellerUpdate(Seller seller);

	public List<Admin> selectGiftTotalRevenue();

	public List<Admin> selectRestoTotalRevenue();

	public List<Admin> selectUserTotalCount();

	public List<Admin> selectSellerTotalCount();

	public List<Admin> selectRestoTotalRevenueList(HashMap<String, Object> hashMap);

	public int selectRestoTotalCount(String searchValue);

	public List<Admin> selectGiftTotalRevenueList(HashMap<String, Object> hashMap);

	public int selectGiftTotalCount(String searchValue);

}