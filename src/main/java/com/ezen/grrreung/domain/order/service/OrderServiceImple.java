package com.ezen.grrreung.domain.order.service;

import com.ezen.grrreung.domain.order.dto.OrderGr;
import com.ezen.grrreung.domain.order.dto.OrderItem;
import com.ezen.grrreung.domain.order.mapper.OrderMapper;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

import java.util.List;
import java.util.Map;

@Service
@Slf4j
@RequiredArgsConstructor
public class OrderServiceImple implements OrderService{
	
	private final OrderMapper orderMapper;

	@Override
	public List<Map<String, Object>> orderHistory(String memberId) {
		return orderMapper.orderHistoryByMember(memberId);
	}


	@Transactional
	@Override
	public void orderComplete(OrderGr orderGr) {
		// orderGr 테이블 insert 및 orderId 받아오기
        orderMapper.create(orderGr);
		
		// orderItem 테이블에 insert 하기위한 list 추출 및 받아온 orderId 할당하기
		List<OrderItem> list = orderGr.getOrderItems();
		
		// orderItem 별로 insert 하기
		for (OrderItem orderItem: list) {
			orderItem.setOrderId(orderGr.getOrderId());
			orderMapper.createOrderItem(orderItem);
		}

    }




}




