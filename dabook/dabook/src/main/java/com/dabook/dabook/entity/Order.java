package com.dabook.dabook.entity;

import jakarta.persistence.*;
import lombok.Getter;

import java.time.LocalDateTime;
import java.util.List;

import static jakarta.persistence.FetchType.LAZY;

@Entity
@Getter
@Table(name = "Orders")
public class Order {

    @Id @GeneratedValue
    @Column(name = "order_no")
    private Long no;

    @ManyToOne(fetch = LAZY)
    @JoinColumn(name = "user_no")
    private User users;

    private int totalPrice;
    private LocalDateTime orderDate;
    private String orderRequest;

    @Enumerated(EnumType.STRING)
    private OrderStatus orderStatus;

    @OneToOne(fetch = LAZY, mappedBy = "orders")
    private Payment payment;

    @OneToMany(mappedBy = "orders")
    private List<OrderHistory> orderHistory;
}