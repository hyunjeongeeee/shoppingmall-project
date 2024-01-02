package com.ezen.grrreung.domain.order.mapper;


import com.ezen.grrreung.domain.order.dto.OrderGr;
import com.ezen.grrreung.domain.order.dto.OrderItem;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;
import java.util.Map;

@Mapper
public interface OrderMapper {

	// 주문하기
	public void create(OrderGr order);
	public void createOrderItem(OrderItem orderItem);

	// 주문 내역 조회
	public List<Map<String, Object>> orderHistoryByMember(String memberId);

//	public int orderId create(OrderGr orderGr);
}

