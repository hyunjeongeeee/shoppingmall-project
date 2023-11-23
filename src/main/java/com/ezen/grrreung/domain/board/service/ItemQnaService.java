package com.ezen.grrreung.domain.board.service;

import com.ezen.grrreung.domain.board.dto.ItemQna;
import com.ezen.grrreung.domain.board.dto.Notice;
import com.ezen.grrreung.web.common.RequestParams;

import java.util.List;


public interface ItemQnaService {

    // 상품 문의 등록
    public void posting(ItemQna itemQna);

    // 상품 문의 목록
    public List<ItemQna> postList(RequestParams params);

    // 상품 문의 목록 행갯수
    public int postListCount(RequestParams params);

    // 상품 문의상세보기
    public ItemQna postInfo(int qnaCode);

    // 상품 문의 삭제
    public void deletePost(int qnaCode);

    // 상품 문의 수정
    public void updatePost(ItemQna itemQna);


}
