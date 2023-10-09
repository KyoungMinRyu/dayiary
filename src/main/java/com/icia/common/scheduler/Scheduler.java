package com.icia.common.scheduler;

import java.io.UnsupportedEncodingException;

import java.time.LocalDateTime;

import java.time.format.DateTimeFormatter;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

import com.icia.common.util.StringUtil;
import com.icia.web.dao.AnniversaryDao;
import com.icia.web.dao.DeliveryTrackerDao;
import com.icia.web.dao.MailPassDao;
import com.icia.web.dao.RestoDao;
import com.icia.web.model.Anniversary;
import com.icia.web.model.CoupleAnniversary;
import com.icia.web.model.OrderList;
import com.icia.web.util.JsonParsing;
import com.icia.web.util.NaverApi;
import com.icia.web.util.PublicDataApi;

@Service("scheduler")
@EnableScheduling
public class Scheduler 
{
	private static Logger logger = LoggerFactory.getLogger(Scheduler.class);
	
	@Autowired
	private AnniversaryDao anniversaryDao;

	@Autowired
	private MailPassDao mailPassDao;

	@Autowired
	private RestoDao restoDao;
	
	@Autowired
	private DeliveryTrackerDao deliveryTrackerDao;
	
	private NaverApi naverApi;
	
	private PublicDataApi publicDataApi;
	
	public Scheduler() 
	{
		naverApi = new NaverApi();
		publicDataApi = new PublicDataApi();
		deliveryCompanyList = new JsonParsing().parsingArr(new JsonParsing().readFile("C:/Code/webapps/dayiary/src/main/webapp/WEB-INF/views/resources/data/deliveryCompany.json"), "id");
	}

	private List<String> deliveryCompanyList;
	
	private List<Anniversary> allUserBirthdayList;
	
	private List<Anniversary> allUserAnniversaryList;
	
	private List<CoupleAnniversary> allCoupleAnniversaryList;

	private LocalDateTime localDateTime = LocalDateTime.now();
	
	private String charset = "euc-kr";
	
	@Scheduled(cron = "0 */30 * * * *")
	private void deliveryTracker()
	{
		logger.debug("#############################################################");
		logger.debug("=============================================================");
		logger.debug("deliveryTracker Scheduling 시작");
		List<OrderList> list = deliveryTrackerDao.selectNeedDeliveryTracker();
		OrderList order = null;
		StringBuilder stringBuilder = new StringBuilder();                                                                                                                                                                   
		JsonParsing jsonParsing = new JsonParsing();
		int count = 0;
		if(list != null && list.size() > 0)
		{
			for(int i = 0; i < list.size(); i++)
			{ 
				order = list.get(i);
				stringBuilder.append(publicDataApi.deliveryTracker(deliveryCompanyList.get(Integer.parseInt(order.getDeliverCompany())), order.getOrderNum()));
				if(stringBuilder.length() > 0)
				{
					if(StringUtil.equals("delivered", jsonParsing.parsingJson(jsonParsing.parsingJson(stringBuilder.toString(), "state"), "id")))
					{
						count += deliveryTrackerDao.updateDeliveryStatus(order.getOrderSeq());
					}
				}
				stringBuilder.setLength(0);
			}
			logger.debug("배송완료 된 상품 수 : " + count);
		}
		else
		{
			logger.debug("deliveryTracker할 클라이언트가 없음");
		}		
		logger.debug("deliveryTracker Scheduling 끝");
		logger.debug("=============================================================");
		logger.debug("#############################################################");
	}
	
	@Scheduled(cron = "0 */10 * * * *")
	private void deleteOneHourLaterReserv()
	{
		logger.debug("#############################################################");
		logger.debug("=============================================================");
		logger.debug("deleteOneHourLaterReserv Scheduling 시작");
		try 
		{
			logger.debug("삭제된 예약 대기 1시간 지난 또는 결재 대기중 삭제 개수 : " + restoDao.deleteOneHourLaterReserv());
		} 
		catch (Exception e) 
		{
			logger.error("deleteOneHourLaterReserv Scheduling 오류");
			logger.error("[Scheduler](deleteOneHourLaterReserv)", e);
		}
		logger.debug("deleteOneHourLaterReserv Scheduling 끝");
		logger.debug("=============================================================");
		logger.debug("#############################################################");
	}
	
	@Scheduled(cron = "0 0 * * * *")
	private void deleteNotUsedEmail()
	{
		logger.debug("#############################################################");
		logger.debug("=============================================================");
		logger.debug("deleteNotUsedEmail Scheduling 시작");
		try 
		{
			logger.debug("삭제된 이메일 개수 : " + mailPassDao.deleteNotUsedEmail());
		} 
		catch (Exception e) 
		{
			logger.error("deleteNotUsedEmail Scheduling 오류");
			logger.error("[Scheduler](deleteNotUsedEmail)", e);
		}
		logger.debug("deleteNotUsedEmail Scheduling 끝");
		logger.debug("=============================================================");
		logger.debug("#############################################################");
	}
	
	@Scheduled(cron = "0 30 9 * * ?")
	private void sendBatchMsg()
	{
		logger.debug("#############################################################");
		logger.debug("=============================================================");
		logger.debug("sendBatchMsg Scheduling 시작");
		try 
		{
			allUserBirthdayList = anniversaryDao.selectAllUserBirthday();
			allUserAnniversaryList = anniversaryDao.selectAllUserAnniversary();
			allCoupleAnniversaryList = anniversaryDao.selectAllCoupleAnniversary();
			// logger.debug("발송된 문자 개수 : " + selectSendList());
		} 
		catch (Exception e) 
		{
			logger.error("sendBatchMsg Scheduling 오류");
			logger.error("[Scheduler](sendBatchMsg)", e);
		}
		
		logger.debug("sendBatchMsg Scheduling 끝");
		logger.debug("=============================================================");
		logger.debug("#############################################################");
	}
	
	@Scheduled(cron = "0 30 10-18 * * *")
	private void sendNewlyBatchMsg()
	{
		logger.debug("#############################################################");
		logger.debug("=============================================================");
		logger.debug("sendNewlyBatchMsg Scheduling 시작");
		try 
		{
//			 logger.debug("새롭게 발송된 문자 개수 : " + selectSendList(anniversaryDao.selectAllUserBirthday(), anniversaryDao.selectAllUserAnniversary(), anniversaryDao.selectAllCoupleAnniversary()));
		} 
		catch (Exception e) 
		{
			logger.error("sendNewlyBatchMsg Scheduling 오류");
			logger.error("[Scheduler](sendNewlyBatchMsg)", e);
		}
		
		logger.debug("sendNewlyBatchMsg Scheduling 끝");
		logger.debug("=============================================================");
		logger.debug("#############################################################");
	}
	
	/**
	 * <pre>
	 * 메소드명 : selectSendList
	 * 파라미터 : none
	 * 리턴타입 : int
	 * 설명 : 아침에 스케줄러를 돌고 나서 문자를 보낼 건수가 있는 거에 대해서만 문자를 발송해준다
	 **/
	private int selectSendList()
	{
		int count = 0;
		if(allUserBirthdayList != null && allUserBirthdayList.size() > 0)
		{
			count = sendMsg(allUserBirthdayList, 0);
		}
		if(allUserAnniversaryList != null && allUserAnniversaryList.size() > 0)
		{
			count = count + sendMsg(allUserAnniversaryList, 1);
		}
		if(allCoupleAnniversaryList != null && allCoupleAnniversaryList.size() > 0)
		{
			count = count + sendMsg(allCoupleAnniversaryList);
		}
		return count;
	}
	
	/**
	 * <pre>
	 * 메소드명 : selectSendList
	 * 파라미터 : List<Anniversary> newAllUserBirthdayList, List<Anniversary> newAllUserAnniversaryList, List<CoupleAnniversary> newAllCoupleAnniversaryList
	 * 리턴타입 : int
	 * 설명 : 아침에 스케줄러를 통해서 돌았던 리스트와 비교하여 새롭게 보낼 문자가 있는 건수에 대해서만 문자를 발송해준다
	 **/
	private int selectSendList(List<Anniversary> newAllUserBirthdayList, List<Anniversary> newAllUserAnniversaryList, List<CoupleAnniversary> newAllCoupleAnniversaryList)
	{
		int count = 0, i, j;
		Anniversary anniversary = null;
		Anniversary checkAnniversary = null;
		CoupleAnniversary coupleAnniversary = null;
		CoupleAnniversary checkCoupleAnniversary = null;
		if(newAllUserBirthdayList != null && newAllUserBirthdayList.size() > 0)
		{
			if(allUserBirthdayList == null || allUserBirthdayList.size() == 0)
			{
				allUserBirthdayList = newAllUserBirthdayList;
				count = sendMsg(newAllUserBirthdayList, 0);
			}
			else
			{
				for(i = 0; i < newAllUserBirthdayList.size(); i ++)
				{
					anniversary = newAllUserBirthdayList.get(i);
					for(j = 0; j < allUserBirthdayList.size(); j++)
					{
						checkAnniversary = allUserBirthdayList.get(j);
						if(StringUtil.equals(anniversary.getUserId(), checkAnniversary.getUserId()))
						{
							newAllUserBirthdayList.remove(i);
							break;
						}
					}
				}
				if(newAllUserBirthdayList.size() > 0)
				{
					allUserBirthdayList.addAll(newAllUserBirthdayList);
					count = sendMsg(newAllUserBirthdayList, 0);
				}
			}
		}
		if(newAllUserAnniversaryList != null && newAllUserAnniversaryList.size() > 0)
		{
			if(allUserAnniversaryList == null || allUserAnniversaryList.size() == 0)
			{
				allUserAnniversaryList = newAllUserAnniversaryList;
				count = count + sendMsg(newAllUserAnniversaryList, 1);
			}
			else
			{
				for(i = 0; i < newAllUserAnniversaryList.size(); i ++)
				{
					anniversary = newAllUserAnniversaryList.get(i);
					for(j = 0; j < allUserAnniversaryList.size(); j++)
					{
						checkAnniversary = allUserAnniversaryList.get(j);
						if(anniversary.getAnniversarySeq() == checkAnniversary.getAnniversarySeq())
						{
							newAllUserAnniversaryList.remove(i);
							break;
						}
					}
				}
				if(newAllUserAnniversaryList.size() > 0)
				{
					allUserAnniversaryList.addAll(newAllUserAnniversaryList);
					count = count + sendMsg(newAllUserAnniversaryList, 1);
				}
			}
		}
		if(newAllCoupleAnniversaryList != null && newAllCoupleAnniversaryList.size() > 0)
		{
			if(allCoupleAnniversaryList == null || allCoupleAnniversaryList.size() == 0)
			{
				allCoupleAnniversaryList = newAllCoupleAnniversaryList;
				count = count + sendMsg(newAllCoupleAnniversaryList);
			}
			else
			{
				for(i = 0; i < newAllCoupleAnniversaryList.size(); i ++)
				{
					coupleAnniversary = newAllCoupleAnniversaryList.get(i);
					for(j = 0; j < allCoupleAnniversaryList.size(); j++)
					{
						checkCoupleAnniversary = allCoupleAnniversaryList.get(j);
						if(coupleAnniversary.getRelationalSeq() == checkCoupleAnniversary.getRelationalSeq() && StringUtil.equals(coupleAnniversary.getUserId(), checkCoupleAnniversary.getUserId()))
						{
							newAllCoupleAnniversaryList.remove(i);
							break;
						}
					}
				}
				if(newAllCoupleAnniversaryList.size() > 0)
				{
					allCoupleAnniversaryList.addAll(newAllCoupleAnniversaryList);
					count = count + sendMsg(newAllCoupleAnniversaryList);
				}
			}
		}
		return count;
	}
	
	/**
	 * <pre>
	 * 메소드명 : sendMsg
	 * 파라미터 : List<Anniversary> anniversarieList, int type
	 * 리턴타입 : int 문자 발송 건수
	 * 설명 : 문자 발송 후에 해당 건수를 반환한다. type이 0이면 생일 1이면 일정
	 **/
	private int sendMsg(List<Anniversary> anniversarieList, int type)
	{
		int count = 0;
		Anniversary anniversary = null;
		String startMsg = "[Dayiary]\n당신의 일상을 함께합니다.\n\n";
		StringBuilder msgBuilder = new StringBuilder();
		if(type == 0)
		{
			for(int i = 0; i < anniversarieList.size(); i++)
			{
				anniversary = anniversarieList.get(i);
				msgBuilder
					.append(startMsg)
					.append("Dayiary를 사랑해주시는 ")
					.append(anniversary.getUserNickname())
					.append("~\n")
					.append(anniversary.getUserNickname())
					.append("님의 생일을 진심으로 축하드립니다!");

				count += checkBytesAndSend(anniversary.getUserPh(), msgBuilder.toString());
				
				msgBuilder.setLength(0);
			}
		}
		else if(type == 1)
		{
			for(int i = 0; i < anniversarieList.size(); i++)
			{
				anniversary = anniversarieList.get(i);
				msgBuilder
					.append(startMsg)
					.append("오늘은 ")
					.append(anniversary.getUserNickname())
					.append("님이 등록한 ")
					.append(anniversary.getAnniversaryTitle())
					.append("일정이 있는 날입니다.");
				
				count += checkBytesAndSend(anniversary.getUserPh(), msgBuilder.toString());
				
				msgBuilder.setLength(0);
			}
		}
		return count;
	}
	
	/**
	 * <pre>
	 * 메소드명 : sendMsg
	 * 파라미터 : List<CoupleAnniversary> anniversarieList
	 * 리턴타입 : int 문자 발송 건수
	 * 설명 : 문자 발송 후에 해당 건수를 반환한다.
	 **/
	private int sendMsg(List<CoupleAnniversary> coupleAnniversarieList)
	{
		int count = 0;
		String date = localDateTime.format(DateTimeFormatter.ofPattern("yyyyMMdd"));
		String calYear = "";
		CoupleAnniversary coupleAnniversary = null;
		String startMsg = "[Dayiary]\n당신의 일상을 함께합니다.\n\n";
		StringBuilder msgBuilder = new StringBuilder();
		for(int i = 0; i < coupleAnniversarieList.size(); i++)
		{
			coupleAnniversary = coupleAnniversarieList.get(i);
			msgBuilder
				.append(startMsg)
				.append(coupleAnniversary.getUserNickname())
				.append("님 ");
			if(StringUtil.equals(coupleAnniversary.getDay100(), date))
			{
				msgBuilder.append("오늘은 연인이 된지 100일이 되는 날입니다.");
			}
			else if(StringUtil.equals(coupleAnniversary.getDay200(), date))
			{
				msgBuilder.append("오늘은 연인이 된지 200일이 되는 날입니다.");
			}
			else if(StringUtil.equals(coupleAnniversary.getDay300(), date))
			{
				msgBuilder.append("오늘은 연인이 된지 300일이 되는 날입니다.");
			}
			else if(StringUtil.equals(coupleAnniversary.getStartDate().substring(4, 8), date.substring(4, 8)))
			{
				calYear = Integer.toString(Integer.parseInt(date.substring(0, 4)) - Integer.parseInt(coupleAnniversary.getStartDate().substring(0, 4)));
				if(StringUtil.equals(calYear, "0"))
				{
					msgBuilder.append("연인이 된 것을 진심으로 축하드립니다!");
				}
				else 
				{
					msgBuilder
						.append("오늘은 연인이 된지 ")
						.append(calYear)
						.append("주년이 되는 날입니다.");
				}
			}
			
			count += checkBytesAndSend(coupleAnniversary.getUserPh(), msgBuilder.toString());
			
			msgBuilder.setLength(0);
		}
		return count;
	}
	
	/**
	 * <pre>
	 * 메소드명 : checkBytesAndSend
	 * 파라미터 : String ph, String msg
	 * 리턴타입 : int
	 * 설명 : 인스턴스변수 charset에 있는 인코딩방식으로 변환하여 bytes체크 후에 sms 또는 lms로 문자 발송후 성공시 1 반환 아니면 0 반환한다
	 **/
	private int checkBytesAndSend(String ph, String msg)
	{
		try 
		{
			if(msg.getBytes(charset).length <= 80)
			{
				if(StringUtil.equals(naverApi.naverSENSApi(ph, msg, 0), "202"))
				{
					return 1;
				}
			}
			else
			{
				if(StringUtil.equals(naverApi.naverSENSApi(ph, msg, 1), "202"))
				{
					return 1;
				}
			}
		}
		catch(UnsupportedEncodingException e) 
		{
			logger.error("UnsupportedEncodingException 오류");
		}
		return 0;
	}
}

