package com.dabook.dabook.dto;

import com.dabook.dabook.entity.Cart;
import lombok.Data;

@Data
public class CartDTO {

    private Long userNo;
    private Long bookNo;
    private Long cartNo;
    private String bookName;
    private String bookPhoto;
    private int bookPrice;
    private int bookCount;
    private int total;

    public CartDTO() {

    }

    public CartDTO(Long userNo, Long bookNo, Long cartNo, String bookName, String bookPhoto, int bookPrice, int bookCount, int total) {
        this.userNo = userNo;
        this.bookNo = bookNo;
        this.cartNo = cartNo;
        this.bookName = bookName;
        this.bookPhoto = bookPhoto;
        this.bookPrice = bookPrice;
        this.bookCount = bookCount;
        this.total = bookCount * bookPrice;
    }

    public CartDTO(Cart cart) {
        userNo = cart.getUsers().getNo();
        bookNo = cart.getBooks().getNo();
        cartNo = cart.getNo();
        bookCount = cart.getCount();
        bookName = cart.getBooks().getBookName();
        bookPrice = cart.getBooks().getPrice();
        bookPhoto = cart.getBooks().getBookDetail().getPhoto();
        total = bookPrice * bookCount;
    }


}
