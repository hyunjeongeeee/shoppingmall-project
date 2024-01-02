package com.ezen.grrreung.web.member.controller;

import com.ezen.grrreung.domain.member.dto.Member;
import com.ezen.grrreung.domain.member.service.MemberService;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/grrreung")
@RequiredArgsConstructor
@SessionAttributes
@Slf4j
public class MemberController {

    private final MemberService memberService;
    /*
     * 로그인 화면 요청
     */
    @GetMapping("/login")
    public String loginForm() {
        return "grrreung/sub/login";
    }

    /**
     * 로그인 처리 요청
     */
    @PostMapping("/login")
    public String login(Member member, HttpSession session, Model model) {
        Member loginMember = memberService.login(member.getMemberId(), member.getPassword());

        // 로그인한 사용자 정보가 세션에 있는 경우(세션 유지)
        if (loginMember != null) {
            model.addAttribute("loggedIn", true);
            model.addAttribute("loginMember", loginMember);

            session.setAttribute("loginMember", loginMember);
            return "redirect:/grrreung";
        } else {
            session.setAttribute("loginMember", null);
            return "redirect:/grrreung/login";
        }

    }

    /**
     * 로그아웃 처리 요청
     */
    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();

        return "redirect:/grrreung";
    }


    /**
     * 회원 가입 화면 요청
     */
    @GetMapping("/register")
    public String registerForm() {
        return "/grrreung/sub/register";
    }

    /**
     * 회원 가입 처리 요청
     */
    @PostMapping("/register")
    public String register(@ModelAttribute("member") Member member) {
        log.info("수신한 회원 정보 : {}", member.toString());
        memberService.register(member);  // 디비연결
        return "redirect:/grrreung/result";
    }

    /**
     * 회원가입 결과 페이지
     */
    @GetMapping("/result")
    public String result(HttpServletRequest request) {
        return "/grrreung/sub/result";
    }


    /**
     * 회원가입 아이디 중복 체크
     */
    @GetMapping("/idcheck")
    @ResponseBody
    public boolean idCheck(@RequestParam("memberId") String memberId) {
        Member member = memberService.getMember(memberId);
        if (member != null) {
            return true;
        }
        return false;
    }


    /**
     * 마이페이지 화면
     */
    @RequestMapping("/mypage/{memberId}")
    public String info(@PathVariable String memberId, Model model) {
        Member member = memberService.memberInfo(memberId);
        model.addAttribute("member", member);
        return "/grrreung/sub/mypage";
    }


    /**
     * 마이페이지 수정 화면
     */
    @GetMapping("/update/{memberId}")
    // 업데이트 페이지 불러오기
    public String update(@PathVariable String memberId, Model model) {
        // DB에서 내용을 가져오기
        Member member = memberService.memberInfo(memberId);
        // html로 전달해줌
        model.addAttribute("member", member);
        return "/grrreung/sub/update";
    }


    /**
     * 마이페이지 수정 처리
     */
    @PostMapping("/update")
    public String update(@ModelAttribute Member member) {
        memberService.updateInfo(member);
        return "/grrreung/sub/updateInfo";
    }


    /**
     * 회원 탈퇴 비밀번호 입력
     */
//    @PostMapping("/out")
//    public String deletePw(@RequestParam String password, Model model, Authentication authentication){
//        Member member = (Member) authentication.getP
//    }

    /**
     * 회원 탈퇴
     */
    @GetMapping("delete/{memberId}")
    public String delete(@PathVariable String memberId, HttpSession session) {
        memberService.deleteUser(memberId);
        session.invalidate();
        return "redirect:/";
    }

}