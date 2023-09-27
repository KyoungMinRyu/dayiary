package com.icia.web.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.icia.web.model.OrderList;

@Repository("deliveryTrackerDao")
public interface DeliveryTrackerDao 
{
	public int updateDeliveryStatus(String orderSeq);
	
	public List<OrderList> selectNeedDeliveryTracker();
	
	public OrderList selectDeliveryTracker(String orderSeq);
}
