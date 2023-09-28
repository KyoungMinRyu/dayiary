package com.icia.web.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;


import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.icia.web.model.OrderList;
import com.icia.web.model.UserG2;


@Repository("userDaoG2")
public interface UserDaoG2 
{
   //아이디 중복확인
   public UserG2 userIdSelect(String userId);

   //닉네임 중복확인
   public UserG2 userNickNameSelect(String userNickName);

   //회원가입
   public int userInsert(UserG2 user);

   //회원정보수정
   public int userUpdate(UserG2 user);

   //아이디찾기
   public UserG2 lostIdFind(Map<String, String> params);
   
   //비밀번호 찾기 
   public int pwdCheck(UserG2 user);

   //프로필 이미지 업로드
   public int saveProfileImageFileName(@Param("fileName") String fileName, @Param("userId") String userId);

   //프로필 이미지 조회
   public String getProfileImageFileNameByUserId(String userId);

   //프로필 이미지 업데이트 
   public int updateProfileImageFileName(@Param("fileName") String fileName, @Param("userId") String userId);

   public List<OrderList> selectRestoOrderList(OrderList orderList);
   
   public int selectRestoOrderTotalCnt(OrderList orderList);
   
   public int updateCancleOrder(String orderSeq);
   
   public String selectMyOrder(String orderSeq);
   
   public int insertReview(HashMap<String, Object> hashMap);
   
   public int updateReviewed(String orderSeq);
   
   public int updateCanclePayList(String orderSeq);
   
   public int deleteReservCancleAnniversary(String orderSeq);
   
   public int deleteSharedReserv(String orderSeq);
   
   public List<OrderList> selectProductOrderList(OrderList orderList);
   
   public int selectProductOrderTotalCount(OrderList orderList);
 
   public int deleteDelivery(String orderSeq);
   
   public OrderList selectGiftOrderDetail(String orderSeq);
   
   public OrderList selectRestoOrderDetail(String orderSeq);
}
