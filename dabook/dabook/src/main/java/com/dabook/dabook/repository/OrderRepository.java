package com.dabook.dabook.repository;

import com.dabook.dabook.entity.Order;
import org.springframework.data.jpa.repository.JpaRepository;

public interface OrderRepository extends JpaRepository<Order, Long> {
}
