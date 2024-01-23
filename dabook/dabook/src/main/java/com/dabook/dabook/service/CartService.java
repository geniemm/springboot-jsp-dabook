package com.dabook.dabook.service;

import com.dabook.dabook.dto.CartDTO;
import com.dabook.dabook.entity.Cart;
import com.dabook.dabook.repository.CartRepository;
import com.dabook.dabook.repository.CartRepositoryImpl;
import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
@Transactional
public class CartService {

    private final CartRepositoryImpl cartRepositoryImpl;
    private final CartRepository cartRepository;

    // 장바구니 리스트
    public List<CartDTO> cartList(String userId) {
        List<Cart> cartList = cartRepositoryImpl.cartList(userId);
        System.out.println(cartList);
        return cartList.stream()
                .map(CartDTO::new)
                .collect(Collectors.toList());
    }

    public boolean delCartItem(Long no){
        try {
            cartRepository.deleteById(no);
            return true;
        }catch (Exception e){
            e.printStackTrace();
            return false;
        }
    }

    public int countUpdate(String cartNo, String action) {
        boolean plus = action.equals("increase");

        if(plus){
            return cartRepository.upCount(cartNo);
        }else {
            return cartRepository.downCount(cartNo);
        }

    }

    public boolean delCartItems(List<Long> noList){
        try {
            cartRepository.delCartItems(noList);
            return true;
        }catch (Exception e){
            e.printStackTrace();
            return false;
        }
    }

    public List<CartDTO> orderItems(List<Long> noList){
        List<Cart> chkCart = cartRepository.orderItems(noList);

        return chkCart.stream()
                .map(CartDTO::new)
                .collect(Collectors.toList());
    }
}