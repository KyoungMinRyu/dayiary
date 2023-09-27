package com.icia.web.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.icia.common.util.StringUtil;
import com.icia.web.model.OrderList;
import com.icia.web.model.Response;
import com.icia.web.service.DeliveryTrackerService;
import com.icia.web.service.UserG2Service;
import com.icia.web.util.CookieUtil;
import com.icia.web.util.HttpUtil;
import com.icia.web.util.JsonParsing;
import com.icia.web.util.PublicDataApi;

@Controller("deliveryTrackerController")
public class DeliveryTrackerController 
{
	@Value("#{env['auth.cookie.name']}")
	private String AUTH_COOKIE_NAME;
	
	private PublicDataApi publicDataApi;
	
	private List<String> deliveryCompanyList;
	
	@Autowired
	private DeliveryTrackerService deliveryTrackerService;
	
	@Autowired 
	private UserG2Service userG2Service;
	
	public DeliveryTrackerController() 
	{
		publicDataApi = new PublicDataApi();
		deliveryCompanyList = new JsonParsing().parsingArr(new JsonParsing().readFile("C:/Code/webapps/dayiary/src/main/webapp/WEB-INF/views/resources/data/deliveryCompany.json"), "id");
	}
	
	@RequestMapping(value="/delivery/deliveryTracker", method=RequestMethod.POST)
	@ResponseBody
	public Response<Object> deliveryTracker(HttpServletRequest request, HttpServletResponse response)
	{
		Response<Object> ajaxResponse = new Response<Object>();
		String orderSeq = HttpUtil.get(request, "orderSeq", "");
		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		if(!StringUtil.isEmpty(orderSeq))
		{
			if(StringUtil.equals(cookieUserId, userG2Service.selectMyOrder(orderSeq)))
			{
				
				OrderList order = deliveryTrackerService.selectDeliveryTracker(orderSeq);
				if(order != null)
				{
					String deliveryTrackerJson = publicDataApi.deliveryTracker(deliveryCompanyList.get(Integer.parseInt(order.getDeliverCompany())), order.getOrderNum());
					if(deliveryTrackerJson.length() > 0)
					{
						ajaxResponse.setResponse(0, "Success", deliveryTrackerJson);
					}
					else
					{
						ajaxResponse.setResponse(500, "Delivery Num Error", "운송장 번호가 잘못되었습니다, 판매자에게 문의하세요.");
					}
				}
				else
				{
					ajaxResponse.setResponse(404, "Not Found");
				}
			}
			else
			{
				ajaxResponse.setResponse(404, "Not Found");
			}
		}
		else
		{
			ajaxResponse.setResponse(400, "Bad Request");
		}
		return ajaxResponse;
	}
}









