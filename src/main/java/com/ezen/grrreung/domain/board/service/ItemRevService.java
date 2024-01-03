package com.ezen.grrreung.domain.board.service;

import com.ezen.grrreung.domain.board.dto.ItemRev;
import com.ezen.grrreung.web.common.RequestParams;

import java.util.List;
import java.util.Map;


public interface ItemRevService {
//    private final BoardRepository boardRepository;
//    private final ItemRevMapper itemRevMapper;

    // 리뷰 등록
    public void posting(ItemRev itemRev);

    // 리뷰 전체 + 검색 목록
    public List<ItemRev> postList(RequestParams params);

    // 리뷰 목록 행갯수
    public int postListCount(RequestParams params);

    // 리뷰 상세보기
    public ItemRev postInfo(int revCode);

    // 리뷰 삭제
    public void deletePost(int revCode);

    // 리뷰 수정
    public void updatePost(ItemRev itemRev);

    // 상품명으로 상품id 가져오기
    public int getItemId(String itemName);

    // 구매 수량 검색
    public int numberOfPurchases(Map<String, Object> map);

    // 아이템별 작성된 게시글 수 검색
    public int writtenPost(Map<String, Object> map);

    // 아이템 상세페이지 리뷰목록 조회 - 아이템id
    public List<ItemRev> itemReviews(RequestParams params);

    // 아이템별 (전체 회원) 리뷰 개수 조회
    public int itemRevPostCount(int itemId);

    // 아이템 상세보기 페이지에서 보여줄 리뷰목록 조회
    public List<ItemRev> itemReviewAll(int ItemId);

}
