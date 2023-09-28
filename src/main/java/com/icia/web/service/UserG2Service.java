package com.icia.web.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.icia.web.dao.UserDaoG2;
import com.icia.web.model.OrderList;
import com.icia.web.model.UserG2;

@Service("userG2Service")
public class UserG2Service {
	private static Logger logger = LoggerFactory.getLogger(UserG2Service.class);

	/**
	 * @Autowired : IoC컨테이너 안에 존재하는 Bean을 자동으로 주입한다.
	 */
	@Autowired
	private UserDaoG2 userG2Dao;

	// 파일 저장 경로
	@Value("#{env['upload.save.dir']}")
	private String UPLOAD_SAVE_DIR;

	// 로그인
	public UserG2 userIdSelect(String userId) {
		UserG2 userG2 = null;
		try {
			userG2 = userG2Dao.userIdSelect(userId);
		} catch (Exception e) {
			logger.error("[UserG2Service](userIdSelect) Exception", e);
		}
		return userG2;
	}

	// 닉네임 일치여부
	public UserG2 userNickNameSelect(String userNickName) {
		UserG2 userG2 = null;
		try {
			userG2 = userG2Dao.userNickNameSelect(userNickName);
		} catch (Exception e) {
			logger.error("[UserG2Service](userNickNameSelect) Exception", e);
		}
		return userG2;
	}

	// 회원가입
	public int userInsert(UserG2 userG2) {
		int count = 0;
		try {
			count = userG2Dao.userInsert(userG2);
		} catch (Exception e) {
			logger.error("[UserService](userInsert)", e);
		}
		return count;
	}

	// 정보수정
	public int userUpdate(UserG2 userG2) {
		int count = 0;
		try {
			count = userG2Dao.userUpdate(userG2);
		} catch (Exception e) {
			logger.error("[UserService](userUpdate)", e);
		}
		return count;
	}

	// 아이디찾기
	public UserG2 lostIdFind(Map<String, String> params) {
		UserG2 userG2 = null;
		try {
			// DAO의 lostIdFind 메서드 호출
			userG2 = userG2Dao.lostIdFind(params);
		} catch (Exception e) {
			logger.error("[UserG2Service]lostIdFind Exception", e);
		}
		return userG2;
	}

	// 비밀번호 찾기
	public int pwdCheck(UserG2 userG2) {
		int count = 0;
		try {
			count = userG2Dao.pwdCheck(userG2);
		} catch (Exception e) {
			logger.error("[UserService](pwdCheck)", e);
		}
		return count;
	}

	// 이미지 업로드
	public int saveProfileImage(String userId, String fileUrl) {
		int count = 0;

		try {

			// DB에서 사용자의 프로필 이미지 파일 이름을 가져옵니다.
			String existingFileName = getProfileImageFileNameByUserId(userId);

			// 이미지 파일 이름이 이미 존재하는지 확인합니다.
			if (existingFileName != null && !existingFileName.isEmpty()) {
				// 기존 이미지가 있으면, 업데이트
				count = userG2Dao.updateProfileImageFileName(fileUrl, userId);
			} else {
				// 기존 이미지가 없으면, 추가
				count = userG2Dao.saveProfileImageFileName(fileUrl, userId);
			}
		} catch (Exception e) {
			logger.error("[UserG2Service]saveProfileImage Exception", e);
		}

		return count;
	}

	// 프로필 이미지 가져오기

	public String getProfileImageFileNameByUserId(String userId) {
		String profileImageFileName = null;

		try {
			profileImageFileName = userG2Dao.getProfileImageFileNameByUserId(userId);
		} catch (Exception e) {
			logger.error("[UserG2Service](getProfileImageFileNameByUserId) Exception", e);
		}

		return profileImageFileName;
	}

	// 이미지 이미 있으면 update문
	public String updateProfileImageFileName(MultipartFile file, String userId) {
		String updateProfile = null;

		try {
			// TODO: file 처리 로직 (예: 저장 경로로 파일 이동 및 파일 이름 추출)
			String fileName = file.getOriginalFilename(); // 예시로 파일의 원래 이름을 사용

			String existingFileName = getProfileImageFileNameByUserId(userId);
			if (existingFileName != null && !existingFileName.isEmpty()) {
				if (userG2Dao.updateProfileImageFileName(fileName, userId) > 0) {
					updateProfile = "update";
				}
			} else {
				if (userG2Dao.saveProfileImageFileName(fileName, userId) > 0) {
					updateProfile = "insert";
				}
			}
		} catch (Exception e) {
			logger.error("[UserG2Service](updateProfileImageFileName) Exception", e);
		}

		return updateProfile;
	}
	
	public List<OrderList> selectRestoOrderList(OrderList orderList)
	{
		List<OrderList> restoOrderList = null;
		try 
		{
			restoOrderList = userG2Dao.selectRestoOrderList(orderList);
		} 
		catch (Exception e) 
		{
			logger.error("[UserG2Service](selectRestoOrderList)", e);
		}
		return restoOrderList;
	}
	   
	public int selectRestoOrderTotalCnt(OrderList orderList)
	{
		int count = 0;
		try 
		{
			count = userG2Dao.selectRestoOrderTotalCnt(orderList);
		} 
		catch (Exception e) 
		{
			logger.error("[UserG2Service](selectRestoOrderTotalCnt)", e);
		}
		return count;
	}
	
	@Transactional(propagation = Propagation.REQUIRED, rollbackFor = Exception.class)
	public int cancleReserv(String orderSeq) throws Exception 
	{
		int count = 0;
		count = userG2Dao.updateCanclePayList(orderSeq);
		if(count > 0)
		{
			count = userG2Dao.updateCancleOrder(orderSeq);
			if(count > 0)
			{
				userG2Dao.deleteSharedReserv(orderSeq);
				userG2Dao.deleteReservCancleAnniversary(orderSeq);
				userG2Dao.deleteDelivery(orderSeq);
			}
		}
		return count;
	}
	

	public String selectMyOrder(String orderSeq)
	{
		String userId = "";
		try 
		{
			userId = userG2Dao.selectMyOrder(orderSeq);
		} 
		catch (Exception e) 
		{
			logger.error("[UserG2Service](selectMyOrder)", e);
		}
		return userId;
	}
	
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class) 
	public int insertReview(HashMap<String, Object> hashMap)
	{
		int count = 0;
		count = userG2Dao.insertReview(hashMap);
		count = userG2Dao.updateReviewed((String)hashMap.get("orderSeq"));
		return count;
	}
	
	public List<OrderList> selectProductOrderList(OrderList orderList)
	{
		List<OrderList> list = null;
		try 
		{
			list = userG2Dao.selectProductOrderList(orderList);
		}
		catch (Exception e) 
		{
			logger.error("[UserG2Service](selectProductOrderList)", e);
		}
		return list;
	}
   
	public int selectProductOrderTotalCount(OrderList orderList)
	{
		int count = 0;
		try 
		{
			count = userG2Dao.selectProductOrderTotalCount(orderList);
		}
		catch (Exception e) 
		{
			logger.error("[UserG2Service](selectProductOrderTotalCount)", e);
		}
		return count;
	}

	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class) 
	public int cancleOrder(String orderSeq)
	{
		int count = 0;
		if(userG2Dao.deleteDelivery(orderSeq) > 0)
		{
			if(userG2Dao.updateCanclePayList(orderSeq) > 0)
			{
				count = userG2Dao.updateCancleOrder(orderSeq);
			}
		}
		return count;
	}
	

	public OrderList selectGiftOrderDetail(String orderSeq)
	{
		OrderList orderDetail = null;
		try 
		{
			orderDetail = userG2Dao.selectGiftOrderDetail(orderSeq);
		} 
		catch (Exception e) 
		{
			logger.error("[UserG2Service](selectGiftOrderDetail)", e);
		}
		return orderDetail;
	}
	

	public OrderList selectRestoOrderDetail(String orderSeq)
	{
		OrderList orderDetail = null;
		try 
		{
			orderDetail = userG2Dao.selectRestoOrderDetail(orderSeq);
		} 
		catch (Exception e) 
		{
			logger.error("[UserG2Service](selectGiftOrderDetail)", e);
		}
		return orderDetail;
	}
}