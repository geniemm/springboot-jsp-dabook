package com.dabook.dabook.repository;

import com.dabook.dabook.entity.CartBook;
import jakarta.persistence.EntityManager;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
@RequiredArgsConstructor
public class CartBookRepositoryImpl {

    private final EntityManager em;

    // 변경된 cartList 메서드
    public List<CartBook> cartList(String userId) {
        return em.createQuery(
                        "SELECT cb FROM CartBook cb " +
                                "JOIN FETCH cb.cart c " +
                                "JOIN FETCH c.users u " +
                                "JOIN FETCH c.books b " +
                                "WHERE u.userId = :userId", CartBook.class)
                .setParameter("userId", userId)
                .getResultList();
    }
}