package com.ezen.grrreung.web.board.controller;

import com.ezen.grrreung.domain.board.dto.ItemRev;
import com.ezen.grrreung.domain.board.service.ItemRevService;
import com.ezen.grrreung.domain.item.dto.Item;
import com.ezen.grrreung.domain.cart.dto.Cart;
import com.ezen.grrreung.domain.item.dto.Category;
import com.ezen.grrreung.domain.item.dto.Item;
import com.ezen.grrreung.domain.item.service.ItemService;
import com.ezen.grrreung.domain.member.dto.Member;
import com.ezen.grrreung.web.common.Pagination;
import com.ezen.grrreung.web.common.RequestParams;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.autoconfigure.web.servlet.DispatcherServletPath;
import org.springframework.core.io.FileSystemResource;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RequestMapping("/grrreung/itemrev")
@RequiredArgsConstructor
@Controller
@Slf4j
public class ItemRevController {

    // 이미지 경로
    @Value("${file.dir}")
    private String location;

    // 비지니스로직을 제공하는 객체생성
    private final ItemRevService itemRevService;
    private final ItemService itemService;

    // itemRev 전체 목록
    @GetMapping(value = {"myreview", ""})
    public String postList(@RequestParam(value = "page", required = false, defaultValue = "1") int page,
                           @RequestParam(value = "search", required = false, defaultValue = "") String search,
                           HttpSession session, HttpServletRequest request,
                           Model model) {
        // 세션에서 memberId 가져오기
        Member member = (Member) session.getAttribute("loginMember");
        String memberId = member.getMemberId();

        // 나의 후기 클릭시
        if (request.getRequestURI().endsWith("/myreview")) {
            // "myreview"로 매핑된 경우 처리
            search = memberId;
        }

        //==========페이징처리==========
        // 페이징 처리와 관련된 변수
        int elementSize = 5; // 화면에 보여지는 행의 갯수
        int pageSize = 3;     // 화면에 보여지는 페이지 갯수

        // 여러개의 요청 파라메터 정보 저장
        RequestParams params = new RequestParams(page, elementSize, pageSize, search);

        // 페이징처리 값 테이블의 전체 갯수
        int selectCount = itemRevService.postListCount(params);

        // params : 사용자가 선택한 페이지번호 , 검색값 여부
        // 페이징 처리 계산 유틸리티 활용
        Pagination pagination = new Pagination(params, selectCount);
        if (pagination.getEndPage() == 0) {
            pagination.setEndPage(1);
        }

        // db에서 list 가져오기
        List<ItemRev> list = itemRevService.postList(params);

        //==========이미지파일 가져오기===========
        for (ItemRev itemRev : list) {
            int itemId;
            itemId = itemRev.getItemId();
            // itemId로 item 가져오기
            Item item = itemService.findByItemId(itemId);
            // 가져온 item 을 itemRev에 담기
            itemRev.setItem(item);
        }

        model.addAttribute("params", params); // 요청 파라메터
        model.addAttribute("pagination", pagination); // 페이징 계산 결과
        model.addAttribute("list", list); // db 리스트

        return "/grrreung/sub/review";
    }


    // 겟매핑 -> 게시글 작성 화면으로 넘어감
    @GetMapping("/create/{itemId}")
    public String form(@PathVariable int itemId,  Model model) throws IOException {

        // itemId로 카테고리 가져오기
        Category category = itemService.getCateByItemId(itemId);
        model.addAttribute("category", category);

        // itemId로 item 가져오기
        Item item = itemService.findByItemId(itemId);
        model.addAttribute("item", item);


        return "/grrreung/sub/rev-write";
    }


    // 포스트매핑 -> 게시글 작성화면에서 submit 버튼 클릭시 작동 -> 리스트화면으로 넘어감
    @PostMapping("/create/{itemId}")
    public String posting(@ModelAttribute("itemRev") ItemRev itemRev, @PathVariable int itemId, HttpSession session, Model model) {
        //세션에서 memberId 가져오기
        Member member = (Member) session.getAttribute("loginMember");
        String memberId = member.getMemberId();

        // memberId 객체에 담아주기
        itemRev.setMemberId(memberId);

        // itemId 담아주기
        itemRev.setItemId(itemId);

        // 포스팅매소트 호출
        itemRevService.posting(itemRev);

        return "redirect:/grrreung/itemrev";
    }

    // 상세보기 겟매핑
    @GetMapping("/{revCode}")
    public String postInfo(@PathVariable int revCode, Model model) {
        ItemRev itemRevInfo = itemRevService.postInfo(revCode);
        model.addAttribute("itemRev",itemRevInfo);
        return "/grrreung/sub/rev-cont";
    }

    // 수정하기 겟매핑
    @GetMapping("/update/{revCode}")
    public String postView(@PathVariable int revCode, Model model) {
        ItemRev itemRevInfo = itemRevService.postInfo(revCode);
        model.addAttribute("itemRev", itemRevInfo);

        return "/grrreung/sub/rev-update";
    }


    // 포스트매핑 -> 수정버튼
    @PostMapping("/update/{revCode}")
    public String postUpdate(@ModelAttribute("itemRev") ItemRev itemRev) {
        itemRevService.updatePost(itemRev);
        return "redirect:/grrreung/itemrev";
    }

    // 겟매핑 -> 삭제버튼
    @GetMapping("/delete/{revCode}")
    public String delete(@PathVariable int revCode, Model model) {
        itemRevService.deletePost(revCode);
        return "redirect:/grrreung/itemrev";
    }

    // 아이템 상세보기 페이지에 보여줄 리뷰 목록 조회
    @ResponseBody
    @GetMapping("/all-reviews")
    public ResponseEntity<List<ItemRev>> findItemReviews(@RequestParam String itemId, Model model
            , @RequestParam(value = "page", required = false, defaultValue = "1") int page) {

        log.info("itemId : {}",itemId);
        log.info("page : {}", page);

        // 데이터
        RequestParams params = new RequestParams(page, 5, 5, itemId);
        int reviewCount = itemRevService.postListCount(params);
        List<ItemRev> list = itemRevService.postList(params);

        model.addAttribute("list", list);
        Pagination pagination = new Pagination(params, reviewCount);
        // 페이징 계산 로직을 여기서 생략하고, 페이지에 맞는 데이터를 가져오는 로직을 추가해야 함
        model.addAttribute("pagination", pagination);
        // 데이터를 가져와서 model에 추가하는 로직도 필요

        return ResponseEntity.ok(list);
    }


}
