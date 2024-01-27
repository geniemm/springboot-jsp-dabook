package com.dabook.dabook.service;

import com.dabook.dabook.dto.CartDTO;
import com.dabook.dabook.entity.Book;
import com.dabook.dabook.entity.Cart;
import com.dabook.dabook.entity.CartBook;
import com.dabook.dabook.entity.User;
import com.dabook.dabook.repository.*;
import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
@Transactional
@Slf4j
public class CartService {

    private final CartRepository cartRepository;
    private final UserRepository userRepository;
    private final BookRepository bookRepository;
    private final CartBookRepository cartBookRepository;
    private final CartBookRepositoryImpl cartBookRepositoryimpl;

    // 장바구니 리스트
    public List<CartDTO> cartList(String userId) {
        List<Cart> cartList = cartRepository.cartList(userId);
        System.out.println(cartList);
        return cartList.stream()
                .map(CartDTO::new)
                .collect(Collectors.toList());
    }


    public Long addCartItem(Long userNo, Long bookNo, int count, String userId) {
        // 엔티티 조회
        User user = userRepository.findById(userNo)
                .orElseThrow(() -> new IllegalArgumentException("사용자가 존재하지 않습니다."));
        Book book = bookRepository.findById(bookNo)
                .orElseThrow(() -> new IllegalArgumentException("책이 존재하지 않습니다."));

        // 장바구니 조회
        Cart cart = cartRepository.findByUserNo(userNo).orElseGet(() -> {
            log.info("장바구니 신규 생성");
            Cart newCart = Cart.createCart(user, book, count);
            cartRepository.save(newCart);
            return newCart;
        });

        // 장바구니 상품이 이미 존재하면 수량 변경
        Optional<CartBook> existingCartBook = cartBookRepository.findByCartNoAndBookNo(cart.getNo(), book.getNo());
        if (existingCartBook.isPresent() && cart.getUsers().getUserId().equals(userId)) {
            existingCartBook.get().changeCount(count);
            log.info("장바구니 수량 변경 완료");
        } else {
            // 새로운 상품이면 CartBook에 추가
            CartBook cartBook = CartBook.createCartItem(count, cart, book);
            cartBookRepository.save(cartBook);

            // 새로운 CartBook을 Cart에 추가
            cart.getCartBooks().add(cartBook);
        }

        return cart.getNo();
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