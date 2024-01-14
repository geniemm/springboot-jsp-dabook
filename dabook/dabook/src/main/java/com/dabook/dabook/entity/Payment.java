package com.dabook.dabook.entity;

import jakarta.persistence.*;
import lombok.Getter;

import java.time.LocalDateTime;

@Entity
@Getter
public class Payment {

    @Id @GeneratedValue
    @Column(name = "payment_no")
    private Long no;

    @OneToOne(fetch = FetchType.LAZY, cascade = CascadeType.ALL)
    @JoinColumn(name = "order_no")
    private Order orders;

    private LocalDateTime payDate;
    private String paymentApi;

}