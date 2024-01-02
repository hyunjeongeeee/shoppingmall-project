package com.ezen.grrreung.domain.cart.service;

import com.ezen.grrreung.domain.cart.dto.Cart;
import com.ezen.grrreung.domain.cart.mapper.CartMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
@RequiredArgsConstructor
public class CartServiceImpl implements CartService {

    private final CartMapper cartMapper;


    @Override
    public List<Map<String, Object>> getCartList(String memberId) {
        return cartMapper.findById(memberId);
    }

    @Override
    public void addToCart(Cart cart) {
        cartMapper.insertItemToCart(cart);
    }

    @Override
    public void updateRegisteredAmount(Cart cart) {
        cartMapper.updateRegisteredAmount(cart);
    }

    @Override
    public List<Integer> itemIdDuplication(String memberId) {
        return cartMapper.itemIdDuplication(memberId);
    }

    @Override
    public void cartAmountPlus(int cartId) {
        cartMapper.cartAmountPlus(cartId);
    }

    @Override
    public void cartAmountMinus(int cartId) {
        cartMapper.cartAmountMinus(cartId);
    }

    @Override
    public void removeCartOne(String memberId, int itemId) {
        cartMapper.deleteItemToCart(memberId, itemId);
    }

    @Override
    public List<Map<String, Object>> getCheckedList(Map<String,Object> map) {
        return cartMapper.findByItemId(map);
    }
}
