package com.dabook.dabook.repository;

import com.dabook.dabook.entity.Order;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface OrderRepository extends JpaRepository<Order, Long> {

    @Query("select o from Order o where o.users.userId=:id")
    List<Order> findByUserId(@Param("id") String id);
}
