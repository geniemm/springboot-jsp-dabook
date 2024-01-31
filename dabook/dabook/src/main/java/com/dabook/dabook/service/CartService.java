package com.dabook.dabook.service;

import com.dabook.dabook.dto.CartDTO;
import com.dabook.dabook.entity.Cart;
import com.dabook.dabook.repository.CartRepository;
import com.dabook.dabook.repository.UserRepository;
import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.util.Collections;
import java.util.List;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
@Transactional
@Slf4j
public class CartService {

    private final CartRepository cartRepository;
    private final UserRepository userRepository;

    // 장바구니 리스트
    public List<CartDTO> cartList(String userId) {
        List<Cart> cartList = cartRepository.cartList(userId);
        System.out.println(cartList);
        return cartList.stream()
                .map(CartDTO::new)
                .collect(Collectors.toList());

    }

    // 상품 수량 변경
    public int countUpdate(String cartNo, String action) {
        boolean plus = action.equals("increase");
        int count;
        if(plus){
            count = 1;
            return cartRepository.editCount(cartNo, count);
        }else {
            count = -1;
            return cartRepository.editCount(cartNo, count);
        }

    }

    // 상품 단독 삭제
    public boolean delCartItem(Long no){
        try {
            cartRepository.deleteById(no);
            return true;
        }catch (Exception e){
            e.printStackTrace();
            return false;
        }
    }

    // 체크 된 상품 삭제
    public boolean delCartItems(List<Long> noList){
        try {
            cartRepository.delCartItems(noList);
            return true;
        }catch (Exception e){
            e.printStackTrace();
            return false;
        }
    }

    // 주문 상품 리스트 저장
    public List<CartDTO> orderItems(List<Long> noList){
        List<Cart> chkCart = cartRepository.orderItems(noList);

        return chkCart.stream()
                .map(CartDTO::new)
                .collect(Collectors.toList());
    }


    // cart에 같은 상품이 있는지 확인
    public List<Cart> ifBook(Long bookNo, String userId){
        Long userNo = userRepository.findOneUser(userId).getNo();
        List<Cart> carts = cartRepository.ifBook(userNo, bookNo);
    
        System.out.println("service: " + carts.isEmpty());
        return carts;
    }

    // 상품이 없다면 상품 넣어주기
    public boolean insertBook(String userId, Long bookNo, int bookCount){
        Long userNo = userRepository.findOneUser(userId).getNo();
        try {
            cartRepository.insertBook(userNo, bookNo, bookCount);
            return true;
        }catch (Exception e){
            e.printStackTrace();
            return false;
        }
    }

    // 상품이 있다면 수량수정
    public boolean editCount(String userId, Long bookNo, int bookCount){
        Long userNo = userRepository.findOneUser(userId).getNo();
        try{
            cartRepository.setCount(userNo, bookNo, bookCount);
            return true;
        }catch (Exception e){
            e.printStackTrace();
            return false;
        }
    }

}