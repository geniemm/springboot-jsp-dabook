package com.dabook.dabook.dto;

import com.dabook.dabook.entity.*;
import lombok.Data;

import java.time.LocalDateTime;

@Data
public class BookDTO {

    private Long bookNo;
    private String bookName;
    private int price;
    private String author;
    private String publisher;
    private LocalDateTime publishDate;
    private int salesVolume;
    private BookDetail bookDetail;
    private Cart carts;
    private Review review;
    private OrderHistory orderHistory;

    public BookDTO(){ }

    public BookDTO(Book book) {
       bookNo=book.getNo();
       bookName=book.getBookName();
       price=book.getPrice();
    }
}
