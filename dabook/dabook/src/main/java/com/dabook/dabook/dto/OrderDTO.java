package com.dabook.dabook.dto;

import com.dabook.dabook.entity.Order;
import com.dabook.dabook.entity.OrderHistory;
import com.dabook.dabook.entity.OrderStatus;
import lombok.Data;

import java.time.LocalDateTime;
import java.util.Collections;
import java.util.List;
import java.util.stream.Collector;
import java.util.stream.Collectors;

@Data
public class OrderDTO {

    private Long no;
    private UserDTO user;
    private int totalPrice;
    private LocalDateTime orderDate;
    private String orderRequest;
    private OrderStatus orderStatus;
    private List<OrderHistoryDTO> orderHistory;

    public OrderDTO() {
    }

    public OrderDTO(OrderHistory orderHistory) {
        Order order = orderHistory.getOrders();  // OrderHistory에서 Order를 가져옴
        this.no = order.getNo();
        this.user = new UserDTO(order.getUsers());
        this.totalPrice = order.getTotalPrice();
        this.orderDate = order.getOrderDate();
        this.orderRequest = order.getOrderRequest();
        this.orderStatus = order.getOrderStatus();
        // OrderHistoryDTO를 생성해서 List에 추가
        this.orderHistory = order.getOrderHistory()
                .stream()
                .map(OrderHistoryDTO::new)
                .collect(Collectors.toList());
    }
}


