package com.dabook.dabook.dto;

import com.dabook.dabook.entity.Book;
import com.dabook.dabook.entity.Cart;
import com.dabook.dabook.entity.CartBook;
import lombok.Data;
import lombok.extern.slf4j.Slf4j;

@Data
@Slf4j
public class CartDTO {

    private Long userNo;
    private Long bookNo;
    private Long cartNo;
    private String userId;
    private String bookName;
    private String bookPhoto;
    private int bookPrice;
    private int bookCount;
    private int total;

    // 무인자 생성자 추가
    public CartDTO() {
    }

    // 기존 생성자
    public CartDTO(Cart cart) {
        userNo = cart.getUsers().getNo();
        bookNo = cart.getBooks().getNo();
        cartNo = cart.getNo();
        userId = cart.getUsers().getUserId();
        bookCount = cart.getCount();
        bookName = cart.getBooks().getBookName();
        bookPrice = cart.getBooks().getPrice();
        bookPhoto = cart.getBooks().getBookDetail().getPhoto();
        total = bookPrice * bookCount;
    }

    public CartDTO(Book book, int count) {
        bookNo = book.getNo();
        bookName = book.getBookName();
        bookPrice = book.getPrice();
        bookPhoto = book.getBookDetail().getPhoto();
        bookCount = count;
        total = bookPrice * bookCount;
    }

}