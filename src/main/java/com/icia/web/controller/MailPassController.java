package com.icia.web.controller;

import java.util.HashMap;




import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.icia.common.util.StringUtil;
import com.icia.web.model.Response;
import com.icia.web.service.MailPassService;
import com.icia.web.util.HttpUtil;
import com.icia.web.util.JavaMailXApi;

@Controller("mailPassController")
public class MailPassController
{
	private static Logger logger = LoggerFactory.getLogger(MailPassController.class);
	
	@Autowired
	private MailPassService mailPassService;
		
	@RequestMapping(value="/mail/userEmailCheck", method=RequestMethod.POST)
	@ResponseBody
	public Response<Object> userEmailCheck(HttpServletRequest request, HttpServletResponse response)
	{
		Response<Object> ajaxResponse = new Response<Object>();
		String userEmail = HttpUtil.get(request, "userEmail");
		if(!StringUtil.isEmpty(userEmail))
		{
			try 
			{
				if(StringUtil.equals(mailPassService.userMailSelectCount(userEmail), "0"))
				{
					String ranNum = new JavaMailXApi().sendMailPass(userEmail, 0);
					if(ranNum != "" && ranNum != null)
					{
						HashMap<String, String> hashMap = new HashMap<String, String>();
						hashMap.put("userEmail", userEmail);
						hashMap.put("ranNum", ranNum);
						if(mailPassService.mailPassInsert(hashMap) == 1)
						{
							ajaxResponse.setResponse(0, "메일 발송 성공, DB저장 성공");
						}
						else 
						{
							ajaxResponse.setResponse(500, "DB저장 실패");
						}
					}
					else
					{
						ajaxResponse.setResponse(400, "메일 발송 실패");
					}
				}
				else
				{
					ajaxResponse.setResponse(100, "사용불가 이메일");
				}
			}
			catch (Exception e)
			{
				logger.debug("[MailPassController](userEmailCheck)", e);
			}
		}
		return ajaxResponse;
	}
	
	@RequestMapping(value="/mail/sellerMailPass", method=RequestMethod.POST)
	@ResponseBody
	public Response<Object> sellerMailPass(HttpServletRequest request, HttpServletResponse response)
	{
		Response<Object> ajaxResponse = new Response<Object>();
		String sellerEmail = HttpUtil.get(request, "sellerEmail");
		if(!StringUtil.isEmpty(sellerEmail))
		{
			try 
			{
				if(StringUtil.equals(mailPassService.userMailSelectCount(sellerEmail), "0"))
				{
					String ranNum = new JavaMailXApi().sendMailPass(sellerEmail, 0);
					if(ranNum != "" && ranNum != null)
					{
						HashMap<String, String> hashMap = new HashMap<String, String>();
						hashMap.put("userEmail", sellerEmail);
						hashMap.put("ranNum", ranNum);
						if(mailPassService.mailPassInsert(hashMap) == 1)
						{
							ajaxResponse.setResponse(0, "메일 발송 성공, DB저장 성공");
						}
						else 
						{
							ajaxResponse.setResponse(500, "DB저장 실패");
						}
					}
					else
					{
						ajaxResponse.setResponse(400, "메일 발송 실패");
					}
				}
				else
				{
					ajaxResponse.setResponse(100, "사용불가 이메일");
				}
			}
			catch (Exception e)
			{
				logger.debug("[MailPassController](sellerMailPass)", e);
			}
		}
		return ajaxResponse;
	}
	
	
	@RequestMapping(value="/mail/selectStatus", method=RequestMethod.POST)
	@ResponseBody
	public Response<Object> selectStatus(HttpServletRequest request, HttpServletResponse response)
	{
		Response<Object> ajaxResponse = new Response<Object>();
		String userEmail = HttpUtil.get(request, "userEmail");
		if(!StringUtil.isEmpty(userEmail) && userEmail != null)
		{
			try 
			{
				String status = mailPassService.selectStatus(userEmail);
				if(StringUtil.equals(status, "Y"))
				{ // 이메일 인증 성공
					ajaxResponse.setResponse(0, "이메일 인증 테이블 status Y");
				}
				else if(StringUtil.equals(status, "N"))
				{ // 이메일 인증을 하지 않아서 N일 때
					ajaxResponse.setResponse(100, "이메일 인증 테이블 status N");
				}
				else
				{ // 시간이 지나 컬럼이 삭제되었을 때
					ajaxResponse.setResponse(400, "이메일 인증 테이블 컬럼 없음");
				}
			} 
			catch (Exception e) 
			{
				logger.debug("[MailPassController](selectStatus)", e);
			}
		}
		else
		{ // 파라미터 오류
			ajaxResponse.setResponse(500, "파라미터 없음");
		}
		return ajaxResponse;
	}
	
	@RequestMapping(value="/mail/userMailPass", method=RequestMethod.GET)
	public String userMailPass(HttpServletRequest request, HttpServletResponse response)
	{
		String userEmail = HttpUtil.get(request, "userEmail");
		String ranNum = HttpUtil.get(request, "ranNum");
		HashMap<String, String> hashMap = new HashMap<String, String>();
		hashMap.put("userEmail", userEmail);
		hashMap.put("ranNum", ranNum);
		if(!StringUtil.isEmpty(userEmail) && !StringUtil.isEmpty(ranNum))
		{
			try 
			{
				if(StringUtil.equals(mailPassService.userMailSelectCount(userEmail), "1"))
				{ // 인증 요청을 눌러서 DB에 저장된 값이 있을 떄
					if(mailPassService.mailPassUpdate(hashMap) > 0)
					{ // 5분 이내에 인증 요청버튼을 눌렀음
						return "/user/userMailSuccess";
					}
					else
					{ // 5분이 지났을 경우 해당 이메일에 대한 컬럼 삭제
						mailPassService.mailPassDelete(userEmail);
						return "/user/userMailTimeOut";
					}
				}
			} 
			catch (Exception e) 
			{
				logger.debug("[MailPassController](userMailPass)", e);
			}
		}
		return "/user/userMailFail";
	}
	
	//일반 회원 비밀번호찾기 이메일 발송
    @RequestMapping(value="/mail/passwordRecovery", method=RequestMethod.POST)
    @ResponseBody
    public Response<Object> passwordReset(HttpServletRequest request, HttpServletResponse response)
    {
       Response<Object> ajaxResponse = new Response<Object>();
       String userEmail = HttpUtil.get(request, "userEmail");
       
       if(!StringUtil.isEmpty(userEmail))
       {
          try 
          {
             // 사용자의 이메일이 DB에 있는지 확인
             if(StringUtil.equals(mailPassService.userMailSelectCount(userEmail), "1"))
             {
                // 임시 비밀번호 생성 및 메일 발송
                String tempPassword = new JavaMailXApi().sendRecoveryPassword(userEmail);
                
                if(tempPassword != "" && tempPassword != null)
                {
                   HashMap<String, String> hashMap = new HashMap<String, String>();
                   hashMap.put("userEmail", userEmail);
                   hashMap.put("tempPassword", tempPassword);
                   
                   // DB에 임시 비밀번호 저장
                   if(mailPassService.passwordUpdate(hashMap) == 1)
                   {
                      ajaxResponse.setResponse(0, "임시 비밀번호 메일 발송 성공, DB 업데이트 성공");
                   }
                   else 
                   {
                      ajaxResponse.setResponse(500, "DB 업데이트 실패");
                   }
                }
                else
                {
                   ajaxResponse.setResponse(400, "임시 비밀번호 메일 발송 실패");
                }
             }
             else
             {
                ajaxResponse.setResponse(100, "등록되지 않은 이메일");
             }
          }
          catch (Exception e)
          {
             logger.debug("[MailPassController](passwordRecovery)", e);
          }
       }
       else
       {
          ajaxResponse.setResponse(500, "이메일 파라미터 없음");
       }
       return ajaxResponse;
    }
    
    //판매자 비밀번호찾기 이메일 발송
    @RequestMapping(value="/mail/sellerpasswordRecovery", method=RequestMethod.POST)
    @ResponseBody
    public Response<Object> sellerpasswordRecovery(HttpServletRequest request, HttpServletResponse response)
    {
       Response<Object> ajaxResponse = new Response<Object>();
       String sellerEmail = HttpUtil.get(request, "sellerEmail");
       
       if(!StringUtil.isEmpty(sellerEmail))
       {
          try 
          {
             // 사용자의 이메일이 DB에 있는지 확인   //판매자도 userMailSelectCount로감 왜냐 MailPass테이블에 전부 포함되어있음 
             if(StringUtil.equals(mailPassService.userMailSelectCount(sellerEmail), "1"))
             {
                // 임시 비밀번호 생성 및 메일 발송
                String tempPassword = new JavaMailXApi().sellersendRecoveryPassword(sellerEmail);
                
                if(tempPassword != "" && tempPassword != null)
                {
                   HashMap<String, String> hashMap = new HashMap<String, String>();
                   hashMap.put("sellerEmail", sellerEmail);
                   hashMap.put("tempPassword", tempPassword);
                   
                   // DB에 임시 비밀번호 저장
                   if(mailPassService.sellerpasswordUpdate(hashMap) == 1)
                   {
                      ajaxResponse.setResponse(0, "임시 비밀번호 메일 발송 성공, DB 업데이트 성공");
                   }
                   else 
                   {
                      ajaxResponse.setResponse(500, "DB 업데이트 실패");
                   }
                }
                else
                {
                   ajaxResponse.setResponse(400, "임시 비밀번호 메일 발송 실패");
                }
             }
             else
             {
                ajaxResponse.setResponse(100, "등록되지 않은 이메일");
             }
          }
          catch (Exception e)
          {
             logger.debug("[MailPassController](passwordRecovery)", e);
          }
       }
       else
       {
          ajaxResponse.setResponse(500, "이메일 파라미터 없음");
       }
       return ajaxResponse;
    }
}
