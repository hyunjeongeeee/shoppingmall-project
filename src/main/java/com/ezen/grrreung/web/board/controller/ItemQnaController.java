package com.ezen.grrreung.web.board.controller;

import com.ezen.grrreung.domain.board.dto.ItemQna;
import com.ezen.grrreung.domain.board.dto.ItemQnaRe;
import com.ezen.grrreung.domain.board.service.ItemQnaService;
import com.ezen.grrreung.domain.item.dto.Category;
import com.ezen.grrreung.domain.item.service.ItemService;
import com.ezen.grrreung.domain.member.dto.Member;
import com.ezen.grrreung.web.common.Pagination;
import com.ezen.grrreung.web.common.RequestParams;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RequestMapping("/grrreung/itemqna")
@RequiredArgsConstructor
@Controller
@Slf4j
public class ItemQnaController {

    // 비지니스로직을 제공하는 객체생성
    private final ItemQnaService itemQnaService;
    private final ItemService itemService;

    // itemQna 전체 목록
    @GetMapping()
    public String postList(@RequestParam(value = "page", required = false, defaultValue = "1") int page,
                           @RequestParam(value = "search", required = false, defaultValue = "") String search,
                           Model model) {
        // 페이징 처리와 관련된 변수
        int elementSize = 5; // 화면에 보여지는 행의 갯수
        int pageSize = 3;     // 화면에 보여지는 페이지 갯수

        // 여러개의 요청 파라메터 정보 저장
        RequestParams params = new RequestParams(page, elementSize, pageSize, search);

        // 페이징처리 값 테이블의 전체 갯수
        int selectCount = itemQnaService.postListCount(params);

        // params : 사용자가 선택한 페이지번호 , 검색값 여부
        // 페이징 처리 계산 유틸리티 활용
        Pagination pagination = new Pagination(params, selectCount);
        if (pagination.getEndPage() == 0) {
            pagination.setEndPage(1);
        }
        List<ItemQna> list = itemQnaService.postList(params);


        model.addAttribute("params", params); // 요청 파라메터
        model.addAttribute("pagination", pagination); // 페이징 계산 결과
        model.addAttribute("list", list); // db 리스트

        return "/grrreung/sub/qna";
    }


    // 겟매핑 -> 게시글 작성 화면으로 넘어감
    @GetMapping("/create")
    public String form(Model model) {


        List<Category> cateList = itemService.categoryAllList();
        model.addAttribute("cateList", cateList);
        return "grrreung/sub/qna-write";
    }

    // 포스트 매핑 -> 게시글 등록에서 submit 버튼 클릭시 작동 -> 리스트화 면으로 넘어감
    @PostMapping("/create")
    public String posting(@ModelAttribute("itemQna") ItemQna itemQna, HttpSession session) {
        //세션에서 memberId 가져오기
        Member member = (Member) session.getAttribute("loginMember");
        String memberId = member.getMemberId();

        itemQna.setMemberId(memberId);

        itemQnaService.posting(itemQna);
        return "redirect:/grrreung/itemqna";
    }

    // 상세보기 겟매핑
    @GetMapping("/{qnaCode}")
    public String postInfo(@PathVariable int qnaCode, Model model) {
        // ItemQna 데이터 가져오기
        ItemQna itemQnaInfo = itemQnaService.postInfo(qnaCode);
        model.addAttribute("itemQna", itemQnaInfo);

        // ItemQnaRe 데이터 가져오기
        List<ItemQnaRe> list = itemQnaService.getListByQnaCode(qnaCode);
        model.addAttribute("qnaReList", list);
        log.info("qnaReList : {}", list);

        return "/grrreung/sub/qna-cont";
    }

    // 수정하기 겟매핑
    @GetMapping("/update/{qnaCode}")
    public String postView(@PathVariable int qnaCode, Model model) {
        ItemQna itemQnaInfo = itemQnaService.postInfo(qnaCode);
        model.addAttribute("itemQna", itemQnaInfo);

        return "/grrreung/sub/qna-update";
    }

    // 포스트매핑 -> 수정버튼
    @PostMapping("/update/{qnaCode}")
    public String postUpdate(@ModelAttribute("itemQna") ItemQna itemQna) {
        itemQnaService.updatePost(itemQna);
        return "redirect:/grrreung/itemqna";
    }

    // 겟매핑 -> 삭제버튼
    @GetMapping("/delete/{qnaCode}")
    public String delete(@PathVariable int qnaCode, Model model) {
        itemQnaService.deletePost(qnaCode);
        return "redirect:/grrreung/itemqna";
    }

    //----------- 문의 답변 --------------------------

    // qna 답변 등록하기
    @GetMapping("/re-create")
    public ResponseEntity<ItemQnaRe> reCreate(@RequestParam String reCont, @RequestParam int qnaCode) {

        // 요청파라미터가 적용된 dto 생성
        ItemQnaRe itemQnaRe = new ItemQnaRe();
        itemQnaRe.setQnaCode(qnaCode);
        itemQnaRe.setReCont(reCont);

        // qna 답변 db에 등록 후 시퀀스로 생성된 reCode받아오기
        int reCode = itemQnaService.postRe(itemQnaRe);

        // 받아온 reCode로 db에 등록된 itemQnaRe 데이터 가져오기
        itemQnaRe = itemQnaService.getReByReCode(reCode);

        log.info("Qna 답변 {}", itemQnaRe);

        return new ResponseEntity<>(itemQnaRe, HttpStatus.OK);
    }


    // qna 답변 수정하기
    @GetMapping("/re-update")
    public ResponseEntity<ItemQnaRe> reUpdate(@RequestParam String reCont, @RequestParam int reCode, @RequestParam int qnaCode) {
        // 요청파라미터가 적용된 dto 생성
        ItemQnaRe itemQnaRe = new ItemQnaRe();
        itemQnaRe.setQnaCode(qnaCode);
        itemQnaRe.setReCont(reCont);
        itemQnaRe.setReCode(reCode);

        log.info("수정된내용1 {}", itemQnaRe);
        // db 내용 수정
        itemQnaService.updateQnaRe(itemQnaRe);


        // 수정된 itemQnRe 가져오기
        itemQnaRe = itemQnaService.getReByReCode(reCode);

        log.info("수정된내용2 {}", itemQnaRe);

        return new ResponseEntity<>(itemQnaRe, HttpStatus.OK);
    }

    // qna 답변 삭제하기
//    @GetMapping("/re-delete")
//    public ResponseEntity<ItemQnaRe> reDelete(@RequestParam int reCode) {
//        itemQnaService.deleteQnaRe(reCode);
//        return new ResponseEntity<>(HttpStatus.OK);
//    }
    @GetMapping("/re-delete")
    public ResponseEntity<ItemQnaRe> reDelete(@RequestParam int reCode, @RequestParam int qnaCode) {
        itemQnaService.deleteQnaRe(reCode);
        return new ResponseEntity<>(HttpStatus.OK);
    }
}
