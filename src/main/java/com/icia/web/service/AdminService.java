package com.icia.web.service;

import java.util.HashMap;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.icia.web.model.Admin;
import com.icia.web.model.Seller;
import com.icia.web.model.UserG2;
import com.icia.web.dao.AdminDao;

@Service("adminService")
public class AdminService 
{
   private static Logger logger = LoggerFactory.getLogger(AdminService.class);
   
   @Autowired
   private AdminDao adminDao;
   
   //사용자 리스트
   public List<UserG2> userList(UserG2 user)
   {   
      List<UserG2> list = null;
      
      try   
      {
         list = adminDao.userList(user);
      }
      catch(Exception e)
      {
   
         logger.error("[AdminService] userList Exception", e);
      }
         
      return list;
   
      }
      
   //사용자 수 조회
   public int userListCount(UserG2 user)
   {
      int count = 0;
         
      try
      {
         count = adminDao.userListCount(user);
      }
      catch(Exception e)
      {
         logger.error("[AdminService] userListCount Exception", e);
      }
         
      return count;
   }
   
   //사용자 조회
   public UserG2 userSelect(String userId)
   {
      UserG2 user = null;
      
      try
      {   
         user = adminDao.userSelect(userId);
      }
      catch(Exception e)
      {
         logger.error("[AdminService] userSelect Exception", e);
      }
      
      return user;
   }
      
   //사용자 수정
   public int userUpdate(UserG2 user)
   {
      int count = 0;

      try
      {
         count = adminDao.userUpdate(user);
      }
      catch(Exception e)
      {
         logger.error("[AdminService] userUpdate Exception", e);
      }
      
      return count;
   }
      
   //판매자 수 리스트
   public List<Seller> sellerList(Seller seller)
   {   
      List<Seller> list = null;
      
      try   
      {
         list = adminDao.sellerList(seller);
      }
      catch(Exception e)
      {
   
         logger.error("[AdminService] sellerList Exception", e);
      }
         
      return list;
   }
      
   //판매자 수 조회
   public int sellerListCount(Seller seller)
   {
      int count = 0;
         
      try
      {
         count = adminDao.sellerListCount(seller);
      }
      catch(Exception e)
      {
         logger.error("[AdminService] sellerListCount Exception", e);
      }
         
      return count;
   }
      
   //판매자 조회
   public Seller sellerSelect(String sellerId)
   {
      Seller seller = null;
      
      try
      {   
         seller = adminDao.sellerSelect(sellerId);
      }
      catch(Exception e)
      {
         logger.error("[AdminService] sellerSelect Exception", e);
      }
      
      return seller;
   }
      
   //판매자 수정
   public int sellerUpdate(Seller seller)
   {
      int count = 0;

      try
      {
         count = adminDao.sellerUpdate(seller);
      }
      catch(Exception e)
      {
         logger.error("[AdminService] userUpdate Exception", e);
      }
      
      return count;
   }
      


	public List<Admin> selectGiftTotalRevenue()
	{
		List<Admin> list = null;
		try 
		{
			list = adminDao.selectGiftTotalRevenue();
		}
		catch (Exception e) 
		{
	         logger.error("[AdminService](selectGiftTotalRevenue)", e);
		}
		return list;
	}

	
	public List<Admin> selectRestoTotalRevenue()
	{
		List<Admin> list = null;
		try 
		{
			list = adminDao.selectRestoTotalRevenue();
		}
		catch (Exception e) 
		{
	         logger.error("[AdminService](selectRestoTotalRevenue)", e);
		}
		return list;
	}
	

	public List<Admin> selectUserTotalCount()
	{
		List<Admin> list = null;
		try 
		{
			list = adminDao.selectUserTotalCount();
		}
		catch (Exception e) 
		{
	         logger.error("[AdminService](selectUserTotalCount)", e);
		}
		return list;
	}


	public List<Admin> selectSellerTotalCount()
	{
		List<Admin> list = null;
		try 
		{
			list = adminDao.selectSellerTotalCount();
		}
		catch (Exception e) 
		{
	         logger.error("[AdminService](selectSellerTotalCount)", e);
		}
		return list;
	}


	public List<Admin> selectRestoTotalRevenueList(HashMap<String, Object> hashMap)
	{
		List<Admin> list = null;
		try 
		{
			list = adminDao.selectRestoTotalRevenueList(hashMap);
		}
		catch (Exception e) 
		{
	         logger.error("[AdminService](selectRestoTotalRevenueList)", e);
		}
		return list;
	}
	

	public int selectRestoTotalCount(String searchValue)
	{
		int count = 0;
		try 
		{
			count = adminDao.selectRestoTotalCount(searchValue);
		} 
		catch (Exception e) 
		{
	         logger.error("[AdminService](selectRestoTotalCount)", e);
		}
		return count;
	}
	
	public List<Admin> selectGiftTotalRevenueList(HashMap<String, Object> hashMap)
	{
		List<Admin> list = null;
		try 
		{
			list = adminDao.selectGiftTotalRevenueList(hashMap);
		}
		catch (Exception e) 
		{
	         logger.error("[AdminService](selectGiftTotalRevenueList)", e);
		}
		return list;
	}

	public int selectGiftTotalCount(String searchValue)
	{
		int count = 0;
		try 
		{
			count = adminDao.selectGiftTotalCount(searchValue);
		} 
		catch (Exception e) 
		{
	         logger.error("[AdminService](selectGiftTotalCount)", e);
		}
		return count;
	}
}