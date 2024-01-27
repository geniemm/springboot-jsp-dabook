package com.dabook.dabook.entity;

import jakarta.persistence.*;
import lombok.Getter;

import java.util.ArrayList;
import java.util.List;

import static jakarta.persistence.FetchType.LAZY;

@Entity
@Getter
public class Cart {

    @Id @GeneratedValue
    @Column(name = "cart_no")
    private Long no;

    @ManyToOne(fetch = LAZY)
    @JoinColumn(name = "user_no")
    private User users;

    @ManyToOne(fetch = LAZY)
    @JoinColumn(name ="book_no")
    private Book books;

    private int count;

    @OneToMany(mappedBy = "cart", orphanRemoval = true)
    private List<CartBook> cartBooks = new ArrayList<>();

    public Cart() {

    }
    private Cart(User users, Book book, int count){
        this.users=users;
        this.books=book;
        this.count=count;
    }
    public static Cart createCart(User user,Book book, int count){
        return new Cart(user,book,count);
    }

    public void changeCount(int count){
        this.count = count;
    }


}