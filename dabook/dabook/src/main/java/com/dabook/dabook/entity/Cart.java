package com.dabook.dabook.entity;

import jakarta.persistence.*;
import lombok.Getter;

import java.util.ArrayList;
import java.util.List;

import static jakarta.persistence.FetchType.*;

@Entity
@Getter
public class Cart {

    @Id @GeneratedValue
    @Column(name = "cart_no")
    private Long no;

    @ManyToOne(fetch = LAZY, cascade = CascadeType.ALL)
    @JoinColumn(name = "user_no")
    private User users;

    @ManyToOne(fetch = LAZY)
    @JoinColumn(name ="book_no")
    private Book books;

    private int count;

}