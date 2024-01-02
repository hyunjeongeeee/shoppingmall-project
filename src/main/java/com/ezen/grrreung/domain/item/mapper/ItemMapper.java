package com.ezen.grrreung.domain.item.mapper;

import com.ezen.grrreung.domain.cart.dto.Cart;
import com.ezen.grrreung.domain.item.dto.Category;
import com.ezen.grrreung.domain.item.dto.Item;
import com.ezen.grrreung.domain.item.dto.ItemImg;
import com.ezen.grrreung.web.common.RequestParams;
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
    public List<Item> findByCategory(RequestParams params);

    // 검색 타입별 item 검색
    public List<Item> findBySearchType(@Param("type") String type, @Param("value") String value);

   // 통합 검색
    public List<Item> findBySearchAll(String value);

    // 통합 검색
    public List<Item> findBySearchAllOption();

    // 상품 썸네일 1장 불러오기
    public String findThumbnail(int itemId);

    // 상품 이미지 전체 불러오기
    // => Map의 key: 컬럼 명 , value: 컬럼 값
    public  List<Map<String, Object>> findItemImages(int itemId);
//    public  List<ItemImg> findItemImages(int itemId);


    // 상세설명(이미지파일) 가져오기
    public  List<Map<String, Object>> findDescriptionImages(int itemId);

    // 카테고리 이름 가져오기
    public  List<Category> findCateAll();

    // 상세 카테고리 가져오기 => 상위카테고리명으로 검색함
    public List<Category> findCateName(String cateTop);

    // 요청 파라미터 값에 따른 아이템 목록
    public List<Item> findByParams(RequestParams params);

    // 요청 파라미터에 해당하는 상품 개수
    public int countByParams(RequestParams params);
//======================================================================================
    // 상품 등록하기
    public void createItem(Item item);

    // 상품 이미지 업로드 처리
    public void insertItemImg(ItemImg itemImg);

    // 시퀀스 번호 가져오기
    public int selectNextItemImgId();
//======================================================================================
    
    // 상품 수정 페이지에서 나타낼 수정이 가능한 상품 정보 가져오기
    public Map<String, Object> updateItemInfo(int itemId);

//====================================================================================== jiyeon
   public Category getCateByItemId(int itemId);

}
