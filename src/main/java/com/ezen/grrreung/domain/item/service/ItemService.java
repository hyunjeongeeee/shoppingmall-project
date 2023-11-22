package com.ezen.grrreung.domain.item.service;

import com.ezen.grrreung.domain.item.dto.Category;
import com.ezen.grrreung.domain.item.dto.Item;
import com.ezen.grrreung.domain.item.dto.ItemImg;
import com.ezen.grrreung.web.common.page.RequestParams;

import java.util.List;
import java.util.Map;

public interface ItemService {

    // item 등록
    public void registerItem(Item item);

    // item 전체 조회
    public List<Item> allItems();

    // 카테고리로 조회
    public List<Item> findByCate(String cateTop);

    // item 1개 조회
    public Item findByItemId(int itemId);

    // item 썸네일
    public String showThumbnail(int itemId);

    // 상품 이미지 전체 조회하기
    public  List<Map<String, Object>> showImageSlide(int itemId);
    
    // 상품 상세정보 description 이미지 불러오기
    public  List<Map<String, Object>> showDescriptionImages(int itemId);

    // 카테고리명 불러오기
    public List<Category> showCateName(String cateTop);

//--------------------------------------------------------------------------------------------------------

    // 요청 파라미터 값에 따른 아이템 목록
    public List<Item> searchItem(RequestParams params);

   // 요청 파라미터에 해당하는 상품 개수
    public int countByParams(RequestParams params);
}

