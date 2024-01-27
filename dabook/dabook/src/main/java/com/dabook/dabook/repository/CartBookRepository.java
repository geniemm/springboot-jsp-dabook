package com.dabook.dabook.repository;

import com.dabook.dabook.entity.CartBook;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

public interface CartBookRepository extends JpaRepository<CartBook,Long> {

    @Transactional(readOnly = true)
    @Query("SELECT cb FROM CartBook cb " +
            "JOIN FETCH cb.cart c " +
            "JOIN FETCH c.users u " +
            "JOIN FETCH c.books b " +
            "WHERE c.no = :cartNo")
    List<CartBook> cartList(@Param("cartNo")Long cartNo);

    @Query("SELECT cb FROM CartBook cb WHERE cb.cart.no = :cartNo AND cb.book.no = :bookNo")
    Optional<CartBook> findByCartNoAndBookNo(@Param("cartNo") Long cartNo, @Param("bookNo") Long bookNo);
}
