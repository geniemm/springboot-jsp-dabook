package com.dabook.dabook.entity;

import jakarta.persistence.*;
import lombok.Getter;

import java.time.LocalDateTime;

import static jakarta.persistence.FetchType.*;

@Entity
@Getter
public class Review {

    @Id @GeneratedValue
    @Column(name = "review_no")
    private Long no;

    private String reviewContent;
    private LocalDateTime reviewDate;
    private int rating; // 별점

    @ManyToOne(fetch = LAZY, cascade = CascadeType.ALL)
    @JoinColumn(name = "book_no")
    private Book book;

    @ManyToOne(fetch = LAZY, cascade = CascadeType.ALL)
    @JoinColumn(name = "user_no")
    private User users;

}