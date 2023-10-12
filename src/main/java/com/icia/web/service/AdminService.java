package com.icia.web.service;

import java.util.HashMap;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import com.icia.web.model.Admin;
import com.icia.web.model.GiftAdd;
import com.icia.web.model.RestoInfo;
import com.icia.web.model.RestoReview;
import com.icia.web.model.Seller;
import com.icia.web.model.UserG2;
import com.icia.web.model.UserProfileFile;
import com.icia.common.util.FileUtil;
import com.icia.web.dao.AdminDao;
import com.icia.web.dao.GiftDao;
import com.icia.web.dao.RestoDao;

@Service("adminService")
public class AdminService 
{
   private static Logger logger = LoggerFactory.getLogger(AdminService.class);
   
   //파일 저장 경로
   @Value("#{env['upload.save.dir']}")
   private String UPLOAD_SAVE_DIR;      //저장 경로
   
   @Autowired
   private AdminDao adminDao;
   
   @Autowired
   private GiftDao giftDao;
   
   @Autowired
   private RestoDao restoDao;
   
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
      
 //사용자(유저) 프로필 사진 삭제
   public int adminManageUserProfileDelete(String userId, String fileName) 
   {
      int count = -1;
      
      try
      {
         UserProfileFile userProfileFile = adminDao.adminManageUserProfileSelect(fileName);
         
         if(userProfileFile != null)
         {
            count = adminDao.adminManageUserProfileDelete(userId);
         
            if(count > 0)
            {
               UserProfileFile delUserProfileFile = new UserProfileFile();
               
               //  UUID 앞에 경로 잘라서 담음
               String fullFilePath = userProfileFile.getFileName();
                   int lastSlashIndex = fullFilePath.lastIndexOf('/');
                   
                   if (lastSlashIndex != -1) 
                   {
                       String desiredFileName = fullFilePath.substring(lastSlashIndex + 1);
                   
                  
                       delUserProfileFile.setFileName(desiredFileName);
                  
                  if(delUserProfileFile != null)
                  {
                     FileUtil.deleteFile(UPLOAD_SAVE_DIR + FileUtil.getFileSeparator() + delUserProfileFile.getFileName());
                  }
                   }
            }
         }
      }      
      catch(Exception e)
      {
         logger.error("[AdminService] adminManageUserProfileDelete Exception", e);
         return -1;
      }  
          
      return count;
   }      
   
   //사용자(유저) 프로필 사진 조회
   public UserProfileFile adminManageUserProfileSelect(String fileName)
   {
      UserProfileFile userProfileFile = null;
      
      try
      {
         userProfileFile = adminDao.adminManageUserProfileSelect(fileName);
      }
      catch(Exception e)
      {
         logger.error("[AdminService] adminManageUserProfileSelect Exception", e);
      }
      
      return userProfileFile;
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
	
	public GiftAdd selectAdminGiftView(String productSeq)
	{
		GiftAdd giftAdd = null;
		try 
		{
			giftAdd = giftDao.selectAdminGiftView(productSeq);
			giftAdd.setGiftFileList(giftDao.selectGiftFIleList(productSeq));
		}
		catch (Exception e) 
		{
	         logger.error("[AdminService](selectAdminGiftView)", e);
		}
		return giftAdd;
	}
	
	public RestoInfo selectAdminRestoView(String rSeq)
	{
		RestoInfo restoInfo = null;
		try 
		{
			restoInfo = restoDao.restoSelect(rSeq);
			restoInfo.setRestoFileList(restoDao.restoFileSelect(rSeq));
			restoInfo.setMenuList(restoDao.menuSelect(rSeq));
		}
		catch (Exception e) 
		{
	         logger.error("[AdminService](selectAdminRestoView)", e);
		}
		return restoInfo;
	}
	
	public int updateRestoText(HashMap<String, Object> hashMap)
	{
		int count = 0;
		try 
		{
			count = adminDao.updateRestoText(hashMap);
		}
		catch (Exception e) 
		{
	         logger.error("[AdminService](updateRestoText)", e);
		}
		return count;
	}
	
	public int updateMenuText(HashMap<String, Object> hashMap)
	{
		int count = 0;
		try 
		{
			count = adminDao.updateMenuText(hashMap);
		}
		catch (Exception e) 
		{
	         logger.error("[AdminService](updateMenuText)", e);
		}
		return count;
	}
	
	public int updateRestoImages(HashMap<String, Object> hashMap)
	{
		int count = 0;
		try 
		{
			count = adminDao.updateRestoImages(hashMap);
		}
		catch (Exception e) 
		{
	         logger.error("[AdminService](updateRestoImages)", e);
		}
		return count;
	}
	
	public int updateMenuImages(String menuSeq)
	{
		int count = 0;
		try 
		{
			count = adminDao.updateMenuImages(menuSeq);
		}
		catch (Exception e) 
		{
	         logger.error("[AdminService](updateMenuImages)", e);
		}
		return count;
	}

	public int updateAdminRestoStatus(HashMap<String, String> hashMap)
	{
		int count = 0;
		try 
		{
			count = adminDao.updateAdminRestoStatus(hashMap);
		}
		catch (Exception e) 
		{
	         logger.error("[AdminService](updateAdminRestoStatus)", e);
		}
		return count;
	}
	
	public List<Admin> selectAdminGiftRevenue(String productSeq)
	{
		List<Admin> list = null;
		try 
		{
			list = adminDao.selectAdminGiftRevenue(productSeq);
		}
		catch (Exception e) 
		{
	         logger.error("[AdminService](selectAdminGiftRevenue)", e);
		}
		return list;
	}

	public List<Admin> selectAdminRestoRevenue(String rSeq)
	{
		List<Admin> list = null;
		try 
		{
			list = adminDao.selectAdminRestoRevenue(rSeq);
		}
		catch (Exception e) 
		{
	         logger.error("[AdminService](selectAdminRestoRevenue)", e);
		}
		return list;
	}

	public int updateAdminGiftStatus(HashMap<String, String> hashMap)
	{
		int count = 0;
		try 
		{
			count = adminDao.updateAdminGiftStatus(hashMap);
		}
		catch (Exception e) 
		{
	         logger.error("[AdminService](updateAdminGiftStatus)", e);
		}
		return count;
	}
	
	public int updateGiftText(HashMap<String, Object> hashMap) 
	{
		int count = 0;
		try 
		{
			count = adminDao.updateGiftText(hashMap);
		}
		catch (Exception e) 
		{
	         logger.error("[AdminService](updateGiftText)", e);
		}
		return count;
	}

	public int updateGiftImages(HashMap<String, Object> hashMap)
	{
		int count = 0;
		try 
		{
			count = adminDao.updateGiftImages(hashMap);
		}
		catch (Exception e) 
		{
	         logger.error("[AdminService](updateGiftImages)", e);
		}
		return count;
	}
	
	public int deleteReview(String orderSeq)
	{
		int count = 0;
		try 
		{
			count = adminDao.deleteReview(orderSeq);
		}
		catch (Exception e) 
		{
	         logger.error("[AdminService](deleteReview)", e);
		}
		return count;
	}
	
	public List<RestoReview> selectRestoReviewList(String rSeq)
	{

		List<RestoReview> list = null;
		try 
		{
			list = adminDao.selectRestoReviewList(rSeq);
		}
		catch (Exception e) 
		{
	         logger.error("[AdminService](selectReviewList)", e);
		}
		return list;
	}
	
	public List<RestoReview> selectGiftReviewList(String productSeq)
	{

		List<RestoReview> list = null;
		try 
		{
			list = adminDao.selectGiftReviewList(productSeq);
		}
		catch (Exception e) 
		{
	         logger.error("[AdminService](selectGiftReviewList)", e);
		}
		return list;
	}
}







































