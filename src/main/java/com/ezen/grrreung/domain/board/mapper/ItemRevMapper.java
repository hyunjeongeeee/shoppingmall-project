package com.ezen.grrreung.domain.board.mapper;

import com.ezen.grrreung.domain.board.dto.ItemRev;
import com.ezen.grrreung.web.common.RequestParams;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;
import java.util.Map;

@Mapper
public interface ItemRevMapper {

    // 리뷰 작성하기
    public void create(ItemRev itemRev);

    // 리뷰 전체 + 검색 리스트
    public List<ItemRev> postList(RequestParams params);

    // 리뷰 리스트 행갯수
    public int postListCount(RequestParams params);

    // 리뷰 상세보기
    public ItemRev findByBno(int revCode);

    // 수정
    public void updateByBno(ItemRev itemRev);

    // 삭제
    public void deletePost(int revCode);

    // 조회수
    public void hitCountUpdate(int revCode);

    // 상품이름으로 상품코드itemId 가져오기
    public int getItemId(String itemName);

    // 구매 수량 조회
    public int numberOfPurchases(Map<String, Object> map);

    // 아이템별 작성된 후기 갯수
    public int writtenPost(Map<String, Object> map);

    // 아이템 상세페이지 리뷰목록 조회 - 아이템id
    public List<ItemRev> itemRevList(RequestParams params);

    // 아이템별 (전체 회원) 리뷰 개수 조회
    public int itemRevPostCount(int itemId);

    // 아이템 상세보기 페이지에서 보여줄 리뷰목록 조회
    public List<ItemRev> itemReviewAll(int ItemId);


}
