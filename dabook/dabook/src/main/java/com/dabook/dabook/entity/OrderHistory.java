package com.dabook.dabook.entity;

import jakarta.persistence.*;
import lombok.Getter;

import java.util.List;

import static jakarta.persistence.FetchType.LAZY;

@Entity
@Getter
public class OrderHistory {

    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name="orderHistory_no")
    private Long no;

    @ManyToOne(fetch = LAZY, cascade = CascadeType.ALL)
    private Order orders;

    @ManyToOne(fetch = LAZY)
    @JoinColumn(name="book_no",nullable = false)
    private Book books;



}
