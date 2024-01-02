package com.ezen.grrreung.domain.item.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
@Builder
public class Item {
    private int itemId;
    private int cateCode;
    private String itemName;
    private int itemPrice;
    private int itemAmount;
    private String itemDetail;
    private String itemSellStatus; // 'sell' , 'sold_out'

    public Item (int itemId, int cateCode, String itemName, int itemPrice, int itemAmount, String itemDetail) {
        this.itemId = itemId;
        this.cateCode = cateCode;
        this.itemName = itemName;
        this.itemPrice = itemPrice;
        this.itemAmount = itemAmount;
        this.itemDetail = itemDetail;
    }

}
