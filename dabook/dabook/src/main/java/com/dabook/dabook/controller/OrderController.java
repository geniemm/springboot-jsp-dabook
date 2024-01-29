package com.dabook.dabook.controller;

import com.dabook.dabook.dto.AddressDTO;
import com.dabook.dabook.dto.OrderDTO;
import com.dabook.dabook.dto.UserDTO;
import com.dabook.dabook.entity.Order;
import com.dabook.dabook.entity.OrderHistory;
import com.dabook.dabook.service.OrderService;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

@Controller
@RequiredArgsConstructor
@RequestMapping("/dabook")
@Slf4j
public class OrderController {

    public final OrderService orderService;

    @GetMapping("/user/order")
    public String orderPage(@RequestParam("no") Long no, HttpSession session, Model model) throws JsonProcessingException {
        System.out.println("orderNo: " + no);

        List<UserDTO> infoDto = orderService.userInfo(no);
        List<AddressDTO> addrDto = orderService.userAddress(no);

        System.out.println(infoDto);

        ObjectMapper objectMapper = new ObjectMapper();
        String info = objectMapper.writeValueAsString(infoDto);
        String addr = objectMapper.writeValueAsString(addrDto);

        Object items = session.getAttribute("items"); // checked 상품 목록

        model.addAttribute("info", info);            // 주문자 정보
        model.addAttribute("addr", addr);            // 주문자 주소
        model.addAttribute("items", items);          // html 사용
        model.addAttribute("addrDto", addrDto);      // 주문자 주소

        return "customer/order";
    }
    @GetMapping("/user/order/history")
    public String history(@RequestParam(name="id") String id, Model model){
        List<Order> orders = orderService.getHistory(id);
        for(Order order :orders){
            Long orderNo= order.getNo();
            List<OrderHistory> orderHistories = orderService.getHistoryDetail(orderNo);
            model.addAttribute("orderHistories",orderHistories);
        }

        log.info("오더리스트개수:"+orders.size());
        model.addAttribute("orders", orders);
        return "customer/history";
    }

    @GetMapping("/user/order/historyDetail")
    public String historyDetail(@RequestParam(name = "no") Long orderNo, Model model) {
        log.info("주문번호:" + orderNo);
        // 주문 상세 정보 조회
        List<OrderHistory> orderHistories = orderService.getHistoryDetail(orderNo);
        // 모델에 주문 상세 정보 추가
        model.addAttribute("orderHistories", orderHistories);

        return "customer/historyDetail";
    }

}