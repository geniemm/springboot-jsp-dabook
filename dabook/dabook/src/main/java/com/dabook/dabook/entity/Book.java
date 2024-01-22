package com.dabook.dabook.entity;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

@Entity
@Getter
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class Book {

    @Id @GeneratedValue
    @Column(name = "book_no")
    private Long no;

    private String bookName;
    private int price;
    private String author;
    private String publisher;
    private LocalDateTime publishDate;
    private int salesVolume;

    @Embedded
    private BookDetail bookDetail;

    @OneToMany(mappedBy = "books")
    private List<Cart> carts = new ArrayList<>();

    @OneToMany(mappedBy = "books")
    private List<Review> reviews = new ArrayList<>();

    public void setPublishDate(LocalDateTime publishDate) {
        this.publishDate = publishDate;
    }
}