package com.icia.web.service;

import java.net.URI;

import java.net.URISyntaxException;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Service;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.client.RestClientException;
import org.springframework.web.client.RestTemplate;

import com.icia.web.dao.RestoDao;
import com.icia.web.model.KakaoPayApprove;
import com.icia.web.model.KakaoPayApprove2;
import com.icia.web.model.KakaoPayOrder;
import com.icia.web.model.KakaoPayOrder2;
import com.icia.web.model.KakaoPayReady;
import com.icia.web.model.KakaoPayReady2;

@Service("kakaoPayService")
public class KakaoPayService {
	private static Logger logger = LoggerFactory.getLogger(KakaoPayService.class);

	// 카카오페이 호스트
	@Value("#{env['kakao.pay.host']}")
	private String KAKAO_PAY_HOST;

	// 카카오페이 관리자 키
	@Value("#{env['kakao.pay.admin.key']}")
	private String KAKAO_PAY_ADMIN_KEY;

	// 카카오페이 가맹점 코드, 최대 10자
	@Value("#{env['kakao.pay.cid']}")
	private String KAKAO_PAY_CID;

	// 카카오페이 결제 URL
	@Value("#{env['kakao.pay.ready.url']}")
	private String KAKAO_PAY_READY_URL;

	// 카카오페이 결제 요청 URL
	@Value("#{env['kakao.pay.approve.url']}")
	private String KAKAO_PAY_APPROVE_URL;

	// 카카오페이 결제 성공 URL
	@Value("#{env['kakao.pay.success.url']}")
	private String KAKAO_PAY_SUCCESS_URL;

	// 카카오페이 결제 취소 URL
	@Value("#{env['kakao.pay.cancel.url']}")
	private String KAKAO_PAY_CANCEL_URL;

	// 카카오페이 결제 실패 URL
	@Value("#{env['kakao.pay.fail.url']}")
	private String KAKAO_PAY_FAIL_URL;

	@Autowired
	private RestoDao restoDao;

	   //카카오페이 호스트
    @Value("#{env['kakao.pay2.host']}")
    private String KAKAO_PAY_HOST2;
    
    //카카오페이 관리자 키
    @Value("#{env['kakao.pay2.admin.key']}")
    private String KAKAO_PAY_ADMIN_KEY2;
    
    //카카오페이 가맹점 코드, 최대 10자
    @Value("#{env['kakao.pay2.cid']}")
    private String KAKAO_PAY_CID2;
    
    //카카오페이 결제 URL
    @Value("#{env['kakao.pay2.ready.url']}")
    private String KAKAO_PAY_READY_URL2;
    
    //카카오페이 결제 요청 URL
    @Value("#{env['kakao.pay2.approve.url']}")
    private String KAKAO_PAY_APPROVE_URL2;
    
    //카카오페이 결제 성공 URL
    @Value("#{env['kakao.pay2.success.url']}")
    private String KAKAO_PAY_SUCCESS_URL2;
    
    //카카오페이 결제 취소 URL
    @Value("#{env['kakao.pay2.cancel.url']}")
    private String KAKAO_PAY_CANCEL_URL2;
    
    //카카오페이 결제 실패 URL
    @Value("#{env['kakao.pay2.fail.url']}")
    private String KAKAO_PAY_FAIL_URL2;
    
    //결제 준비
    public KakaoPayReady2 kakaoPayReady2(KakaoPayOrder2 kakaoPayOrder2)
    {
       KakaoPayReady2 kakaoPayReady2 = null;
       
       if(kakaoPayOrder2 != null)
       {   
          //spring에서 지원하는 객체로 간편하게 rest방식 API를 호출 할 수 있는 spring내장 클래스.
          RestTemplate restTemplate = new RestTemplate();
          
          //서버로 요청할 header 정의 (HttpHeaders도 spring에서 지원해주는 Util)
          HttpHeaders headers = new HttpHeaders();
          headers.add("Authorization", "KakaoAK " + KAKAO_PAY_ADMIN_KEY2); //KAKAO_PAY_ADMIN_KEY는 env.xml 정해놓은 값이며 실제 카카오페이 단건결재 페이지에서 각각 부여해주는 Admin Key값이다.
          headers.add("Content-type", MediaType.APPLICATION_FORM_URLENCODED_VALUE + ";charset=utf-8");
          //Content-type: application/x-www-form-urlencoded;charset=utf-8
          //MediaType.APPLICATION_FORM_URLENCODED_VALUE는 값이 application/x-www-form-urlencoded 까지를 의미하므로 뒤에 문자열로 ;charset=utf-8만 붙여 준 것.
          
          //서버로 요청할 body 정의
          MultiValueMap<String, String> params = new LinkedMultiValueMap<String, String>();
          
          params.add("cid", KAKAO_PAY_CID);
          params.add("partner_order_id", kakaoPayOrder2.getPartnerOrderId());
          params.add("partner_user_id", kakaoPayOrder2.getPartnerUserId());
          params.add("item_name", kakaoPayOrder2.getItemName());   
          params.add("item_code", kakaoPayOrder2.getItemCode());   
          params.add("quantity", String.valueOf(kakaoPayOrder2.getQuantity()));   
          params.add("total_amount", String.valueOf(kakaoPayOrder2.getTotalAmount()));   
          params.add("tax_free_amount", String.valueOf(kakaoPayOrder2.getTaxFreeAmount()));
          params.add("approval_url", KAKAO_PAY_SUCCESS_URL2);   //결제 성공시
          params.add("cancel_url", KAKAO_PAY_CANCEL_URL2);      //결제 취소시
          params.add("fail_url", KAKAO_PAY_FAIL_URL2);         //결제 실패시
          //kakaoPayController에서 kakaoPayOrder에 담아서 온 값을 카카오 페이측으로 보내기 위해 카카오페이 단걸결제 페이지에 있는 변수명과 똑같이 기입 후 넘길 준비 한것.(꼭 카카오페이 페이지에 변수명과 같아야 한다! _ 들어가는 게 그이유)
          
          
          //요청하기 위해 header와 body를 합치기
          //spring framework에서 제공해주는 HttpEntity클래스에 header와 body를 합치기.
          HttpEntity<MultiValueMap<String, String>> body = new HttpEntity<MultiValueMap<String, String>>(params, headers);
          
          try
          {   //postFordObject메서드는 요청을 보내고 객체로 결과를 반환                     //아래body는 header와body가 위에서 합쳐진것이며, 값들을 KakaoPayReady.class에 담아서 보내라는 것
             kakaoPayReady2 = restTemplate.postForObject(new URI(KAKAO_PAY_HOST2 + KAKAO_PAY_READY_URL2), body, KakaoPayReady2.class);
                                           //url은 위에 두개 +해주면 https://kapi.kakao.com/v1/payment/ready 되는 것 
             if(kakaoPayReady2 != null)
             {
                kakaoPayOrder2.settId(kakaoPayReady2.getTid());
             }
             
          }                                          
          catch(RestClientException e)
          {
             logger.error("[KakaoPayService2] kakaoPayReady2 RestClientException", e);
          }
          catch(URISyntaxException e)
          {
             logger.error("[KakaoPayService2] kakaoPayReady2 URISyntaxException", e);
          }
       }
       else
       {
          logger.error("[KakaoPayService2] kakaoPayReady2 kakaoPayOrder2 is null");   
       }
       
       return kakaoPayReady2;
    }
    
    
    public KakaoPayApprove2 kakaoPayApprove2(KakaoPayOrder2 kakaoPayOrder2)
    {
       KakaoPayApprove2 kakaoPayApprove2 = null;
       
       if(kakaoPayOrder2 != null)
       {
          RestTemplate restTemplate = new RestTemplate();
          
          //서버로 요청할 header 생성
          HttpHeaders headers = new HttpHeaders();
          headers.add("Authorization", "KakaoAK " + KAKAO_PAY_ADMIN_KEY2);
          headers.add("Content-type", MediaType.APPLICATION_FORM_URLENCODED_VALUE + ";charset=utf-8");
          
          //Content-type: application/x-www-form-urlencoded;charset=utf-8
          
          //서버로 요청할 body 생성
          MultiValueMap<String, String> params = new LinkedMultiValueMap<String, String>();         
          params.add("cid", KAKAO_PAY_CID2);
          params.add("tid", kakaoPayOrder2.gettId());
          params.add("partner_order_id", kakaoPayOrder2.getPartnerOrderId());
          params.add("partner_user_id", kakaoPayOrder2.getPartnerUserId());
          params.add("pg_token", kakaoPayOrder2.getPgToken());
          
          HttpEntity<MultiValueMap<String, String>> body = new HttpEntity<MultiValueMap<String, String>>(params, headers);
          try
          {
             kakaoPayApprove2 = restTemplate.postForObject(new URI(KAKAO_PAY_HOST2 + KAKAO_PAY_APPROVE_URL2), body, KakaoPayApprove2.class);
          }
          catch(RestClientException e)
          {
             logger.error("[KakaoPayService2] kakaoPayApprove2 RestClientException", e);
          }
          catch(URISyntaxException e)
          {
             logger.error("[KakaoPayService2] kakaoPayApprove2 URISyntaxException", e);
          }
       
       }
       else
       {
          logger.error("[KakaoPayService2] kakaoPayApprove2 kakaoPayOrder2 is null");
       }
       
       return kakaoPayApprove2;
    }
	
	
	// 결제 준비
	public KakaoPayReady kakaoPayReady(KakaoPayOrder kakaoPayOrder) {
		KakaoPayReady kakaoPayReady = null;

		if (kakaoPayOrder != null) {
			// spring에서 지원하는 객체로 간편하게 rest방식 API를 호출 할 수 있는 spring내장 클래스.
			RestTemplate restTemplate = new RestTemplate();

			// 서버로 요청할 header 정의 (HttpHeaders도 spring에서 지원해주는 Util)
			HttpHeaders headers = new HttpHeaders();
			headers.add("Authorization", "KakaoAK " + KAKAO_PAY_ADMIN_KEY);
			headers.add("Content-type", MediaType.APPLICATION_FORM_URLENCODED_VALUE + ";charset=utf-8");
			// Content-type: application/x-www-form-urlencoded;charset=utf-8
			// MediaType.APPLICATION_FORM_URLENCODED_VALUE는 값이
			// application/x-www-form-urlencoded 까지를 의미하므로 뒤에 문자열로 ;charset=utf-8만 붙여 준 것.

			// 서버로 요청할 body 정의
			MultiValueMap<String, String> params = new LinkedMultiValueMap<String, String>();

			params.add("cid", KAKAO_PAY_CID);
			params.add("partner_order_id", kakaoPayOrder.getPartnerOrderId());
			params.add("partner_user_id", kakaoPayOrder.getPartnerUserId());
			params.add("item_name", kakaoPayOrder.getItemName());
			params.add("quantity", String.valueOf(kakaoPayOrder.getQuantity()));
			params.add("total_amount", String.valueOf(kakaoPayOrder.getTotalAmount()));
			params.add("tax_free_amount", String.valueOf(kakaoPayOrder.getTaxFreeAmount()));
			params.add("approval_url", KAKAO_PAY_SUCCESS_URL); // 결제 성공시
			params.add("cancel_url", KAKAO_PAY_CANCEL_URL); // 결제 취소시
			params.add("fail_url", KAKAO_PAY_FAIL_URL); // 결제 실패시

			// 요청하기 위해 header와 body를 합치기
			// spring framework에서 제공해주는 HttpEntity클래스에 header와 body를 합치기.
			HttpEntity<MultiValueMap<String, String>> body = new HttpEntity<MultiValueMap<String, String>>(params,
					headers);

			try { // 아래body는 header와body가 위에서 합쳐진것이며, 값들을 KakaoPayReady.class에 담아서 보내라는 것
				kakaoPayReady = restTemplate.postForObject(new URI(KAKAO_PAY_HOST + KAKAO_PAY_READY_URL), body,
						KakaoPayReady.class);
				// url은 위에 두개 +해주면 https://kapi.kakao.com/v1/payment/ready 되는 것
				if (kakaoPayReady != null) {
					kakaoPayOrder.settId(kakaoPayReady.getTid());
				}

			} catch (RestClientException e) {
				logger.error("[KakaoPayService] kakaoPayReady RestClientException", e);
			} catch (URISyntaxException e) {
				logger.error("[KakaoPayService] kakaoPayReady URISyntaxException", e);
			}
		} else {
			logger.error("[KakaoPayService] kakaoPayReady kakaoPayOrder is null");
		}

		return kakaoPayReady;
	}

	public KakaoPayApprove kakaoPayApprove(KakaoPayOrder kakaoPayOrder) {
		KakaoPayApprove kakaoPayApprove = null;
		int count = 0;

		if (kakaoPayOrder != null) {
			RestTemplate restTemplate = new RestTemplate();

			// 서버로 요청할 header 생성
			HttpHeaders headers = new HttpHeaders();
			headers.add("Authorization", "KakaoAK " + KAKAO_PAY_ADMIN_KEY);
			headers.add("Content-type", MediaType.APPLICATION_FORM_URLENCODED_VALUE + ";charset=utf-8");

			// Content-type: application/x-www-form-urlencoded;charset=utf-8

			// 서버로 요청할 body 생성
			MultiValueMap<String, String> params = new LinkedMultiValueMap<String, String>();
			params.add("cid", KAKAO_PAY_CID);
			params.add("tid", kakaoPayOrder.gettId());
			params.add("partner_order_id", kakaoPayOrder.getPartnerOrderId());
			params.add("partner_user_id", kakaoPayOrder.getPartnerUserId());
			params.add("pg_token", kakaoPayOrder.getPgToken());

			HttpEntity<MultiValueMap<String, String>> body = new HttpEntity<MultiValueMap<String, String>>(params,
					headers);
			try {
				kakaoPayApprove = restTemplate.postForObject(new URI(KAKAO_PAY_HOST + KAKAO_PAY_APPROVE_URL), body,
						KakaoPayApprove.class);
				kakaoPayApprove.setPgToken(kakaoPayOrder.getPgToken()); // 어프루브를 DB PAY_LIST 인서트용 객체로 쓰기 위해서 pgToken 값도
																		// 세팅함
				kakaoPayApprove.setTotalPrice(kakaoPayApprove.getAmount().getTotal()); // 위와 마찬가지 (amount는 객체라서
																						// getTotal로 꺼냈음)

				if (kakaoPayApprove != null) {

					count = restoDao.payListInsert(kakaoPayApprove);

				}
			} catch (RestClientException e) {
				logger.error("[KakaoPayService] kakaoPayApprove RestClientException", e);
			} catch (URISyntaxException e) {
				logger.error("[KakaoPayService] kakaoPayApprove URISyntaxException", e);
			}

		} else {
			logger.error("[KakaoPayService] kakaoPayApprove kakaoPayOrder is null");
		}

		return kakaoPayApprove;
	}
}