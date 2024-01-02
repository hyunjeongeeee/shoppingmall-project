package com.ezen.grrreung;

import com.ezen.grrreung.domain.board.dto.Notice;
import com.ezen.grrreung.domain.board.mapper.NoticeMapper;
import com.ezen.grrreung.domain.cart.mapper.CartMapper;
import lombok.extern.slf4j.Slf4j;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import java.util.List;

@SpringBootTest
@Slf4j
public class CartTest {

    @Autowired
    private CartMapper cartMapper;

    @Test
    public void createTest(){
        String memberId = "ddalang";
        List<Integer> list = cartMapper.itemIdDuplication(memberId);
        for (int i: list) {
            log.info("검색된 itemId: {}", i);
        }
        
    }


}
