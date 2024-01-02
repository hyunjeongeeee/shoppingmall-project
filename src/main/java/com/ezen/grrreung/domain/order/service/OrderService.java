package com.ezen.grrreung.domain.order.service;

import com.ezen.grrreung.domain.order.dto.OrderGr;

import java.util.List;
import java.util.Map;


public interface OrderService {
//	public void order(OrderGr order) throws NotEnoughMoneyException;

	// 주문하기
	public void orderComplete(OrderGr orderGr);

	// 주문 내역 조회
	public List<Map<String,Object>> orderHistory(String memberId);
}




