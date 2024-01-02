package com.ezen.grrreung.domain.item.service;

import com.ezen.grrreung.domain.cart.dto.Cart;
import com.ezen.grrreung.domain.item.dto.Category;
import com.ezen.grrreung.domain.item.dto.Item;
import com.ezen.grrreung.domain.item.dto.ItemImg;
import com.ezen.grrreung.web.common.RequestParams;

import java.util.List;
import java.util.Map;

public interface ItemService {

    // item 전체 조회
    public List<Item> allItems();

    // 카테고리로 조회
    public List<Item> findByCate(RequestParams params);

    // item 1개 조회
    public Item findByItemId(int itemId);

    // item 썸네일
    public String showThumbnail(int itemId);

    // 상품 이미지 전체 조회하기
    public  List<Map<String, Object>> showImageSlide(int itemId);
    
    // 상품 상세정보 description 이미지 불러오기
    public  List<Map<String, Object>> showDescriptionImages(int itemId);


    // 저장된 카테고리 불러오기
    public List<Category> categoryAllList();

    // 상세 카테고리명 불러오기
    public List<Category> showCateName(String cateTop);


//--------------------------------------------------------------------------------------------------------

    // 요청 파라미터 값에 따른 아이템 목록
    public List<Item> searchItem(RequestParams params);

   // 요청 파라미터에 해당하는 상품 개수
    public int countBySearchValue(RequestParams params);


//--------------------------------------------------------------------------------------------------------

    public void registerItem(Item item);
    // 상품 등록

    public void uploadItemImg(ItemImg itemImg);
    // 상품 이미지 업로드

    public int itemIdSequence();
    // item_img_id 시퀀스 조회

    public Map<String, Object> updateInfo(int itemId);
    // 상품 수정 페이지 출력

//--------------------------------------------------------------------------------------------------------jiyeon

    // itemId로 카테고리 가져오기
    public Category getCateByItemId(int itemId);


}

