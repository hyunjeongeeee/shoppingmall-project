package com.ezen.grrreung.domain.item.mapper;

import com.ezen.grrreung.domain.item.dto.Item;
import com.ezen.grrreung.domain.item.dto.ItemImg;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

@Mapper
public interface ItemMapper {

    /*
    * item 전체 목록 조회
    *
    * */
    public List<Item> findAllItems();

    // item_id로 1개 item 조회
    public Item findByItemId(int itemId);

    // 카테고리로 상품 조회
    public List<Item> findByCategory(String cateTop);

    // item 등록
    public void createItem(Item item);

    // 검색 타입별 item 검색
    public List<Item> findBySearchType(@Param("type") String type, @Param("value") String value);

   // 통합 검색
    public List<Item> findBySearchAll(String value);

    // 통합 검색
    public List<Item> findBySearchAllOption();

    // 상품 썸네일 1장 불러오기
    public String findThumbnail(int itemId);

    // 상품 이미지 전체 불러오기 => 컬럼 이름 key , 컬럼 값이 value
    public  List<Map<String, Object>> findItemImages(int itemId);


}
