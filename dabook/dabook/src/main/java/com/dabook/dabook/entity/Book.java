package com.dabook.dabook.entity;

import jakarta.persistence.*;
import lombok.Getter;

import java.time.LocalDateTime;

import static jakarta.persistence.FetchType.*;

@Entity
@Getter
public class Book {

    @Id @GeneratedValue
    @Column(name = "book_no")
    private Long no;

    private String bookName;
    private String publisher;
    private int price;
    private LocalDateTime publishDate;
    private String author;
    private int salesVolume;

    @ManyToOne(fetch = LAZY, cascade = CascadeType.ALL)
    @JoinColumn(name = "cart_no")
    private Cart cart;

    @Embedded
    private BookDetail bookDetail;
}