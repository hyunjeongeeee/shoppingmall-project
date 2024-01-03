package com.ezen.grrreung.domain.board.service;

import com.ezen.grrreung.domain.board.dto.ItemQna;
import com.ezen.grrreung.domain.board.dto.ItemQnaRe;
import com.ezen.grrreung.domain.board.mapper.ItemQnaMapper;
import com.ezen.grrreung.web.common.RequestParams;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Slf4j
@Service
public class ItemQnaServiceImpl implements ItemQnaService{

    private final ItemQnaMapper itemQnaMapper;

    @Autowired
    public ItemQnaServiceImpl(ItemQnaMapper itemQnaMapper) {
        this.itemQnaMapper = itemQnaMapper;
    }

    // QNA 작성
    @Override
    public void posting(ItemQna itemQna) {
        itemQnaMapper.create(itemQna);
    }

    // QNA 전체 + 검색 리스트
    @Override
    public List<ItemQna> postList(RequestParams params) {
        return itemQnaMapper.postList(params);
    }

    // QNA 리스트 행갯수
    @Override
    public int postListCount(RequestParams params) {
        return itemQnaMapper.postListCount(params);
    }

    // QNA 상세 보기
    @Override
    public ItemQna postInfo(int qnaCode) {
        return itemQnaMapper.findByBno(qnaCode);
    }

    // QNA 삭제
    @Override
    public void deletePost(int qnaCode) { itemQnaMapper.deletePost(qnaCode); }

    // QNA 수정
    @Override
    public void updatePost(ItemQna itemQna) { itemQnaMapper.updateByBno(itemQna); }

    @Override
    public List<ItemQnaRe> getListByQnaCode(int qnaCode) {
        return itemQnaMapper.qnaReByQnaCode(qnaCode);
    }

    // Qna 답변 등록
    @Override
    public int postRe(ItemQnaRe itemQnaRe) {
        // 답변 db에 insert
        itemQnaMapper.createRe(itemQnaRe);
        // insert이후 생성된 reCode 가져오기
        int reCode = itemQnaRe.getReCode();
        return reCode;
    }

    // Qna 답변 가져오기
    public ItemQnaRe getReByReCode(int reCode){
        return itemQnaMapper.getQnaRe(reCode);
    }

    // Qna 답변 수정하기
    @Override
    public void updateQnaRe(ItemQnaRe itemQnaRe) {
        itemQnaMapper.updateQnaRe(itemQnaRe);
    }

    // Qna 답변 삭제하기
    @Override
    public void deleteQnaRe(int reCode) {
        itemQnaMapper.deleteQnaRe(reCode);
    }

}
