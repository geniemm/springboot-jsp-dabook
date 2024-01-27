package com.dabook.dabook.entity;

import jakarta.persistence.*;
import lombok.AccessLevel;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Entity
@Table(name = "cart_book")
@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class CartBook {

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        CartBook cartBook = (CartBook) o;

        if (getCart() != null ? !getCart().equals(cartBook.getCart()) : cartBook.getCart() != null) return false;
        return getBook() != null ? getBook().equals(cartBook.getBook()) : cartBook.getBook() == null;
    }
    @Override
    public int hashCode() {
        int result = getCart() != null ? getCart().hashCode() : 0;
        result = 31 * result + (getBook() != null ? getBook().hashCode() : 0);
        return result;
    }


    @Id
    @GeneratedValue
    @Column(name = "cart_book_no")
    private Long no;

    private int count;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "cart_no")
    private Cart cart;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "book_no")
    private Book book;

    public CartBook(int count, Cart cart, Book book) {
        this.count = count;
        this.cart = cart;
        this.book = book;
    }

    public static CartBook createCartItem(int count, Cart cart, Book book) {
        return new CartBook(count, cart, book);
    }

    public void changeCount(int count) {
        this.count = count;
    }
}

