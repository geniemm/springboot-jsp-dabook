package com.dabook.dabook.repository;

import com.dabook.dabook.entity.Cart;
import jakarta.persistence.EntityManager;
import lombok.RequiredArgsConstructor;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
@RequiredArgsConstructor
public class CartRepositoryImpl {

    private final EntityManager em;

    @Query
    public List<Cart> cartList(String no) {
        return em.createQuery(
                        "select c from Cart c " +
                                "join fetch c.users u " +
                                "join fetch c.books b " +
                                "where u.no = :no", Cart.class)
                .setParameter("no", no)
                .getResultList();
    }

}
