package com.ezen.grrreung.domain.order.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

import java.util.List;

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
@ToString
@Builder
public class OrderGr {

	private int orderId;
	private String memberId;
	private String orderDate;
	private String orderStatus;
	private String orderMemo;
	private String orderName;
	private String orderAdd;
	private String orderHp;
	private String orderPriceAll;
	private List<OrderItem> orderItems;

}

