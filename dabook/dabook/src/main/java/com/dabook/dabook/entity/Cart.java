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

    @OneToOne(fetch = LAZY, cascade = CascadeType.ALL)
    @JoinColumn(name = "user_no")
    private User users;

    @OneToOne(fetch = LAZY, cascade = CascadeType.ALL)
    @JoinColumn(name = "order_no")
    private Order orders;

    @OneToMany(mappedBy = "cart")
    private List<Book> book = new ArrayList<>();

    private int OrderPrice;
    private int count;

}