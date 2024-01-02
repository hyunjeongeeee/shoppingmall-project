package com.ezen.grrreung.web.cart.controller;

import com.ezen.grrreung.domain.cart.dto.Cart;
import com.ezen.grrreung.domain.cart.service.CartService;
import com.ezen.grrreung.domain.item.dto.Item;
import com.ezen.grrreung.domain.member.dto.Member;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/grrreung")
@RequiredArgsConstructor
@SessionAttributes
@Slf4j
public class CartController {

    private final CartService cartService;

    /**
     * 장바구니 목록 조회
     */
    @GetMapping("/cart")
    public String list(HttpSession session, Model model) {
        // 세션에서 memberId 가져오기
        Member member = (Member)session.getAttribute("loginMember");
        String memberId = member.getMemberId();

        List<Map<String, Object>> list = cartService.getCartList(memberId);
        model.addAttribute("list", list);

        for (Map<String, Object> map : list) {
            log.info("**** 카트 정보 확인 : {}", map);
        }

        return "/grrreung/sub/cart";
    }

    // 장바구니 상품 추가
    @PostMapping("/cart")
    public String addToCartItem(HttpSession session, @ModelAttribute Cart cart, @ModelAttribute Item item) {
        // 세션에서 memberId 가져오기
        Member member = (Member)session.getAttribute("loginMember");
        String memberId = member.getMemberId();

        int itemId = item.getItemId();  // 아이템 아이디
        int cartAmount = cart.getCartAmount();  // 상품 수량
        log.info("itemId : {}", itemId);
        log.info("memberId : {}", memberId);
        log.info("상품 수량: {}", cartAmount);
        log.info("장바구니 넣기/ 넘겨받은 정보 : {}", cart);

        // 서버로부터 전송받은 값 Cart객체에 저장
        cart.setMemberId(memberId);
        cart.setItemId(itemId);
        cart.setCartAmount(cartAmount);

        // 장바구니에 담겨있는 상품인지 확인 => 중복값일경우 업데이트, 중복값이 아닌경우 인서트
        List<Integer> list = cartService.itemIdDuplication(memberId);

        if (list.contains(itemId)) {
            cartService.updateRegisteredAmount(cart);
            log.info("########### 업데이트됨 ##############");
        } else {
            cartService.addToCart(cart);
            log.info("########### 추가됨 ##############");
        }

        return "redirect:/grrreung/cart";
    }



    // 장바구니 수량 증가
    @ResponseBody
    @GetMapping("/cart/amount-plus")
    public void cartAmountPlus(@RequestParam int cartId){
        log.info("****** 선택한 카트 아이디 :{}", cartId);
        cartService.cartAmountPlus(cartId);
    }


    // 장바구니 수량 감소
    @ResponseBody
    @GetMapping("/cart/amount-minus")
    public void cartAmountMinus(@RequestParam int cartId){
        log.info("****** 선택한 카트 아이디 :{}",cartId);
        cartService.cartAmountMinus(cartId);
    }







    // 장바구니 개별 삭제
    @GetMapping("/cart/delete/{itemId}")
    public String deleteItemToCart(@PathVariable int itemId, HttpSession session) {
        Member member = (Member) session.getAttribute("loginMember");
        String memberId = member.getMemberId();
        log.info("가져온 memberId : {}", memberId);
        cartService.removeCartOne(memberId, itemId);
        return "redirect:/grrreung/cart";
    }


    // 장바구니 선택 삭제
    @GetMapping("/cart/delete")
    public String selectItemToCart(@RequestParam("itemId") List<Integer> itemId, HttpSession session) {
        Member member = (Member) session.getAttribute("loginMember");
        String memberId = member.getMemberId();
        for (int selectItem : itemId) {
            cartService.removeCartOne(memberId, selectItem);
        }
        log.info("가져온 memberId : {}", memberId);
        return "redirect:/grrreung/cart";

    }

}