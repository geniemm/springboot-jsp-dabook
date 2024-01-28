package com.dabook.dabook.dto;

import com.dabook.dabook.entity.OrderHistory;
import lombok.Data;

@Data
public class OrderHistoryDTO {

        private Long no;
        private OrderDTO order;
        private BookDTO book;

        public OrderHistoryDTO(OrderHistory orderHistory) {
                // 필드에 orderHistory에서 필요한 정보를 가져와서 설정
        }
}

