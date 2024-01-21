package com.dabook.dabook.entity;

import jakarta.persistence.*;
import lombok.Getter;

import java.time.LocalDateTime;

import static jakarta.persistence.FetchType.LAZY;

@Entity
@Getter
@Table(name = "Orders")
public class Order {

    @Id @GeneratedValue
    @Column(name = "order_no")
    private Long no;

    @ManyToOne(fetch = LAZY, cascade = CascadeType.ALL)
    @JoinColumn(name = "user_no")
    private User users;

    private int totalPrice;
    private LocalDateTime orderDate;
    private String orderRequest;

    @Enumerated(EnumType.STRING)
    private OrderStatus orderStatus;

    @OneToOne(fetch = LAZY, mappedBy = "orders")
    private Payment payment;

}