package com.ezen.grrreung.domain.board.service;

import com.ezen.grrreung.domain.board.dto.ItemRev;
import com.ezen.grrreung.domain.board.mapper.ItemRevMapper;
import com.ezen.grrreung.web.common.RequestParams;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;


@Service
public class ItemRevServiceImpl implements ItemRevService{

    private final ItemRevMapper itemRevMapper;

    @Autowired
    public ItemRevServiceImpl(ItemRevMapper itemRevMapper){
        this.itemRevMapper = itemRevMapper;
    }

    // 리뷰 작성
    @Override
    public void posting(ItemRev itemRev) { itemRevMapper.create(itemRev); }

    // 리뷰 전체 + 검색 리스트
    @Override
    public List<ItemRev> postList(RequestParams params) {
        return itemRevMapper.postList(params);
    }

    // 리뷰 리스트 행갯수
    @Override
    public int postListCount(RequestParams params) {
        return itemRevMapper.postListCount(params);
    }

    // 리뷰 상세 보기
    @Override
    public ItemRev postInfo(int revCode) { return itemRevMapper.findByBno(revCode); }

    // 리뷰 삭제
    @Override
    public void deletePost(int revCode) { itemRevMapper.deletePost(revCode);  }

    // 리뷰 수정
    @Override
    public void updatePost(ItemRev itemRev) { itemRevMapper.updateByBno(itemRev);  }
    
    // 상품명으로 상품아이디가져오기
    @Override
    public int getItemId(String itemName) {
        return itemRevMapper.getItemId(itemName);
    }

    // 구매 수량 조회
    @Override
    public int numberOfPurchases(Map<String, Object> map) {
        return itemRevMapper.numberOfPurchases(map);
    }

    @Override
    public int writtenPost(Map<String, Object> map) {
        return itemRevMapper.writtenPost(map);
    }

    @Override
    public List<ItemRev> itemReviews(RequestParams params) {
        return itemRevMapper.itemRevList(params);
    }

    @Override
    public int itemRevPostCount(int itemId) {
        return itemRevMapper.itemRevPostCount(itemId);
    }

    @Override
    public List<ItemRev> itemReviewAll(int itemId) {
        return itemRevMapper.itemReviewAll(itemId);
    }




}
