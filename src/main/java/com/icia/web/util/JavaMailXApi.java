package com.icia.web.util;

import java.util.Properties;


import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.icia.common.util.StringUtil;

public class JavaMailXApi 
{
	private static final Logger logger = LoggerFactory.getLogger(JavaMailXApi.class);
	
	/**
	 * 인증메일 발송 
	 * 파라미터 : 이메일주소, 유저 구분 0일 시 유저, 1일 시 판매자 나머지 오류
	 * 리턴 타입 : 랜덤 숫자 6자리 (String 타입)
	 * **/
	public String sendMailPass(String userEmail, int type) // 메일 인증 버튼을 누르면 메일이 발송되고 DB에 저장하는 메소드
	{
		if(!StringUtil.isEmpty(userEmail) && userEmail != null) 
		{
			String ranNum = Integer.toString((int)(Math.random() * (999999 - 100000 + 1)) + 100000);
			String[] content = new String[]
				{
					"<a href='http://dayiary.com:8088/mail/userMailPass?userEmail=" + userEmail + "&ranNum=" + ranNum + "'><h1>인증</h1></a>",
					"<a href='http://dayiary.com:8088/mail/sellerMailPass?sellerEmail=" + userEmail + "&ranNum=" + ranNum + "'><h1>인증</h1></a>"
				};
			try 
			{
				Message message = getMessage();
				message.addRecipient(Message.RecipientType.TO, new InternetAddress(userEmail));
				message.setSubject("[Dayiary]회원가입을 위해 인증을 완료해주세요.");
				message.setContent(content[type], "text/html; charset=utf-8");
				Transport.send(message);
			} 
			catch (Exception e) 
			{
				logger.debug("===============================================================");
				logger.debug("MailSend Fail : " + e);
				logger.debug("===============================================================");
				return "";
			}
			logger.debug("===============================================================");
			logger.debug("MailSend Success, ranNum : " + ranNum);
			logger.debug("===============================================================");
			return ranNum; // 메일발송 성공 시 1	
		}
		else 
		{
			return "";
		}
	}
	
	
	
	/**
	 * 메일 발송
	 * 파라미터 : 이메일주소, 제목, 내용
	 * 리턴타입 : 성공 시 Y, 실패 시 N
	 * **/
	public String sendMailPass(String email, String title, String contentMsg) // mail은 메일 받을 주소 
	{
		String content = "<p style='font-size: 20px;'>"+ contentMsg +"</p>";
		try 
		{
			Message message = getMessage();
			message.addRecipient(Message.RecipientType.TO, new InternetAddress(email));
			message.setSubject(title);
			message.setContent(content, "text/html; charset=utf-8");
 
			Transport.send(message);
		} 
		catch (Exception e) 
		{
			logger.debug("===============================================================");
			logger.debug("MailSend Fail : " + e);
			logger.debug("===============================================================");
			return "N";
		}
		logger.debug("===============================================================");
		logger.debug("MailSend Success");
		logger.debug("===============================================================");
		return "Y";
	}
	
	public String sendRecoveryPassword(String userEmail) 
    {
       // 문자 + 숫자 조합의 6자리 임시 비밀번호 생성
       String CHARACTERS = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
       StringBuilder tempPassword = new StringBuilder();

       for (int i = 0; i < 6; i++) 
       {
          int index = (int) (Math.random() * CHARACTERS.length());
          tempPassword.append(CHARACTERS.charAt(index));
       }

       if(!StringUtil.isEmpty(userEmail)) 
       {
    	   if(StringUtil.equals(sendMailPass(userEmail, "[Dayiary] 임시 비밀번호가 발송되었습니다.", "임시 비밀번호가 발급되었습니다.<br> 임시비밀번호  :  " + tempPassword.toString() + "<br> 로그인 후 꼭 비밀번호를 변경하신 후 이용하시기 바랍니다.") , "Y"))
		   {
				logger.debug("===============================================================");
				logger.debug("MailSend Success, Temporary Password : " + tempPassword);
				logger.debug("===============================================================");
				return tempPassword.toString();  
		   }
       }

	   return "";
    }
	
	public String sellersendRecoveryPassword(String sellerEmail) 
    {
       // 문자 + 숫자 조합의 6자리 임시 비밀번호 생성
       String CHARACTERS = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
       StringBuilder tempPassword = new StringBuilder();

       for (int i = 0; i < 6; i++) 
       {
          int index = (int) (Math.random() * CHARACTERS.length());
          tempPassword.append(CHARACTERS.charAt(index));
       }

       if(!StringUtil.isEmpty(sellerEmail)) 
       {
          if(StringUtil.equals(sendMailPass(sellerEmail, "[Dayiary] 판매자 비밀번호가 발송되었습니다.", "임시 비밀번호가 발급되었습니다.<br> 임시비밀번호  :  " + tempPassword.toString() + "<br> 로그인 후 꼭 비밀번호를 변경하신 후 이용하시기 바랍니다.") , "Y"))
         {
            logger.debug("===============================================================");
            logger.debug("MailSend Success, Temporary Password : " + tempPassword);
            logger.debug("===============================================================");
            return tempPassword.toString();  
         }
       }

      return "";
    }
	
	/**
	 * 메소드명 :  getMessage
	 * 설명 : ini파일에서 Properties 넣어서 Message리턴
	 **/
	private Message getMessage() throws Exception
	{
		Properties props = new Properties();
		props.put("mail.smtp.host", "smtp.gmail.com");
		props.put("mail.smtp.port", "587");
		props.put("mail.smtp.auth", "true");
		props.put("mail.smtp.starttls.enable", "true");
		props.put("mail.smtp.ssl.trust", "smtp.gmail.com");
		Session session = Session.getInstance(props, new Authenticator() 
		{
			@Override
			protected PasswordAuthentication getPasswordAuthentication() 
			{
				return new PasswordAuthentication(ApiConfig.getProperties("javaMailX", "email", "apiConfig"), ApiConfig.getProperties("javaMailX", "secPwd", "apiConfig")); 
			}
		});
		Message message = new MimeMessage(session);
		message.setFrom(new InternetAddress(ApiConfig.getProperties("javaMailX", "email", "apiConfig"), "관리자", "utf-8"));
		return message;
	}	
}
