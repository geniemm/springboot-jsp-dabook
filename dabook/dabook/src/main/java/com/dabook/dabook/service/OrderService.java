package com.dabook.dabook.service;

import com.dabook.dabook.dto.AddressDTO;
import com.dabook.dabook.dto.OrderDTO;
import com.dabook.dabook.dto.OrderHistoryDTO;
import com.dabook.dabook.dto.UserDTO;
import com.dabook.dabook.entity.Address;
import com.dabook.dabook.entity.Order;
import com.dabook.dabook.entity.OrderHistory;
import com.dabook.dabook.entity.User;
import com.dabook.dabook.repository.AddressRepositoryImpl;
import com.dabook.dabook.repository.OrderHistoryRepository;
import com.dabook.dabook.repository.OrderRepository;
import com.dabook.dabook.repository.UserRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.util.Collections;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
@Slf4j
public class OrderService {

    private final UserRepository userRepository;
    private final AddressRepositoryImpl addressRepository;
    private final OrderHistoryRepository orderHistoryRepository;
    private final OrderRepository orderRepository;

    // 주문 페이지 로드 시 주문자 정보
    public List<UserDTO> userInfo(Long no){
        Optional<User> info = userRepository.findById(no);

        return info.stream()
                .map(UserDTO::new)
                .collect(Collectors.toList());
    }

    // 주문 페이지 로드 시 주문자 주소
    public List<AddressDTO> userAddress(Long no){
        List<Address> addresses = addressRepository.addressList(no);

        return addresses.stream()
                .map(AddressDTO::new)
                .collect(Collectors.toList());

    }

    public List<Order> getHistory(String id){
        List<Order> orders = orderRepository.findByUserId(id);
        return orders;
    }

    public List<OrderHistory> getHistoryDetail(Long orderNo){
        List<OrderHistory> orderHistories = orderHistoryRepository.findByOrderNo(orderNo);
        return orderHistories;
    }

    public boolean hasOrderedBook(String userId, Long bookNo) {
        boolean result = false;
        List<Order> orderList = orderRepository.findByUserId(userId);
        for (int i = 0; i < orderList.size(); i++) {
            List<OrderHistory> orderHistories = orderHistoryRepository.findByOrderNo(orderList.get(i).getNo());
            for (int j = 0; j < orderHistories.size(); j++) {
                if (orderHistories.get(j).getBooks().getNo() == bookNo) {
                    result = true;
                } else {
                }
            }
        }
        return result;
    }
}