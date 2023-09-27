package com.icia.web.service;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.icia.web.dao.DeliveryTrackerDao;
import com.icia.web.model.OrderList;

@Service("deliveryTrackerService")
public class DeliveryTrackerService 
{
	private static Logger logger = LoggerFactory.getLogger(DeliveryTrackerService.class);
	
	@Autowired
	private DeliveryTrackerDao deliveryTrackerDao;
	

	public OrderList selectDeliveryTracker(String orderSeq)
	{
		OrderList orderList = null;
		try 
		{
			orderList = deliveryTrackerDao.selectDeliveryTracker(orderSeq);
		}
		catch (Exception e) 
		{
			logger.error("[DeliveryTrackerService](selectDeliveryTracker)", e);
		}
		return orderList;
	}
}
