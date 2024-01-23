package com.dabook.dabook.repository;

import com.dabook.dabook.entity.Cart;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface CartRepository extends JpaRepository<Cart, Long> {

    @Modifying
    @Query("update Cart c set c.count = c.count + 1 where c.no = :no")
    int upCount(@Param("no") String no);

    @Modifying
    @Query("update Cart c set c.count = c.count - 1 where c.no = :no")
    int downCount(@Param("no") String no);

    @Modifying
    @Query("delete from Cart c where c.no in :noList")
    void delCartItems(@Param("noList") List<Long> noList);

    @Query("select c from Cart c " +
            "join fetch c.users u " +
            "join fetch c.books b " +
            "where c.no in :noList")
    List<Cart> orderItems(@Param("noList") List<Long> noList);

}