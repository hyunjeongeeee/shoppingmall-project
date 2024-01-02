package com.ezen.grrreung.web.board.controller;

import com.ezen.grrreung.domain.board.dto.Notice;
import com.ezen.grrreung.domain.board.dto.Notice;
import com.ezen.grrreung.domain.board.service.NoticeService;
import com.ezen.grrreung.web.common.Pagination;
import com.ezen.grrreung.web.common.RequestParams;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;


@RequestMapping("/grrreung/notice")
@RequiredArgsConstructor
@Controller
@Slf4j
public class NoticeController {

    // 비지니스로직을 제공하는 객체생성
    private final NoticeService noticeService;


    // notice 전체 목록
    @GetMapping()
    public String postList(@RequestParam(value = "page", required = false, defaultValue = "1") int page,
                           @RequestParam(value = "search", required = false, defaultValue = "") String search,
                           Model model){

        // 페이징 처리와 관련된 변수
        int elementSize = 5; // 화면에 보여지는 행의 갯수
        int pageSize = 3;     // 화면에 보여지는 페이지 갯수

        // 여러개의 요청 파라메터 정보 저장
        RequestParams params = new RequestParams(page, elementSize, pageSize, search);
        log.info("page 값 : {}", params.getRequestPage());
        // 페이징처리 값 테이블의 전체 갯수
        int selectCount = noticeService.postListCount(params);
        
        // params : 사용자가 선택한 페이지번호 , 검색값 여부
        // 페이징 처리 계산 유틸리티 활용
        Pagination pagination = new Pagination(params, selectCount);
        if (pagination.getEndPage() == 0) {
            pagination.setEndPage(1);
        }
        List<Notice> list = noticeService.postList(params);
        
        
        
        model.addAttribute("params", params); // 요청 파라메터
        model.addAttribute("pagination", pagination); // 페이징 계산 결과
        model.addAttribute("list",list); // db 리스트
        
        return "/grrreung/sub/notice";
    }


    // 게시글 등록 겟매핑 -> 게시글 등록 화면으로 넘어감
    @GetMapping("/create")
    public String form(){
        return "/grrreung/sub/notice-write";
    }

    // 포스트매핑 -> 게시글 등록에서 submit 버튼 클릭시 작동 -> 리스트화면으로 넘어감
    @PostMapping("/create")
    public String posting(@ModelAttribute("notice")Notice notice){
        noticeService.posting(notice);
        return "redirect:/grrreung/notice";
    }

    // 상세보기 겟매핑
    @GetMapping("/{notiCode}")
    public String postInfo(@PathVariable int notiCode, Model model){
        Notice noticeInfo = noticeService.postInfo(notiCode);
        model.addAttribute("notice",noticeInfo);
        return "/grrreung/sub/notice-cont";
    }

    // 수정하기 겟매핑
    @GetMapping("/update/{notiCode}")
    public String postView(@PathVariable int notiCode, Model model) {
        Notice noticeInfo = noticeService.postInfo(notiCode);
        model.addAttribute("notice", noticeInfo);

        return "/grrreung/sub/notice-update";
    }

    // 포스트매핑 -> 수정버튼
    @PostMapping("/update/{notiCode}")
    public String postUpdate(@ModelAttribute("notice") Notice notice) {
        noticeService.updatePost(notice);
        return "redirect:/grrreung/notice";
    }

    // 겟매핑 -> 삭제버튼
    @GetMapping("/delete/{notiCode}")
    public String delete(@PathVariable int notiCode, Model model) {
        noticeService.deletePost(notiCode);
        return "redirect:/grrreung/notice";
    }



}
