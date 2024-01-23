package com.dabook.dabook.controller;

import com.dabook.dabook.dto.AddressDTO;
import com.dabook.dabook.dto.UserDTO;
import com.dabook.dabook.service.OrderService;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

@Controller
@RequiredArgsConstructor
public class OrderController {

    public final OrderService orderService;

    @GetMapping("/dabook/user/order")
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
}