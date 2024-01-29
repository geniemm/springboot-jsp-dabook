package com.dabook.dabook.repository;

import com.dabook.dabook.entity.OrderHistory;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface OrderHistoryRepository extends JpaRepository<OrderHistory,Long> {

    @Query("select oh from OrderHistory oh where oh.orders.no=:no")
    List<OrderHistory>findByOrderNo(@Param("no")Long no);

}
