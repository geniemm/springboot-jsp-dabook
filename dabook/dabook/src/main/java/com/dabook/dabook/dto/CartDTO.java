package com.dabook.dabook.dto;

import com.dabook.dabook.entity.Cart;
import lombok.Data;

@Data
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


}
