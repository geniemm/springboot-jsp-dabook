package com.dabook.dabook.entity;

import jakarta.annotation.Nullable;
import jakarta.persistence.*;
import lombok.Getter;

import java.time.LocalDateTime;

import static jakarta.persistence.FetchType.*;

@Entity
@Getter
@Table(name = "Orders")
public class Order {

    @Id @GeneratedValue
    @Column(name = "order_no")
    private Long no;

    private LocalDateTime orderDate;
    private int totalPrice;

    @ManyToOne(fetch = LAZY, cascade = CascadeType.ALL)
    @JoinColumn(name = "user_no")
    private User users;

    private String orderRequest;

    @OneToOne(fetch = LAZY, cascade = CascadeType.ALL)
    @JoinColumn(name = "payment_no")
    private Payment payment;

    @Enumerated(EnumType.STRING)
    private OrderStatus orderStatus;

    @OneToOne(fetch = LAZY, mappedBy = "orders")
    private Cart cart;

}