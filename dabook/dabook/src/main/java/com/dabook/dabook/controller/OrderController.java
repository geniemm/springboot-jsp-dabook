package com.dabook.dabook.controller;

import com.dabook.dabook.dto.CartDTO;
import com.dabook.dabook.service.OrderService;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;
import java.util.Map;

@Controller
@RequiredArgsConstructor
public class OrderController {

    public final OrderService orderService;

    @GetMapping("/order")
    public String orderPage(HttpSession session, Model model) throws JsonProcessingException {
        Object items = session.getAttribute("items");

        ObjectMapper objectMapper = new ObjectMapper();
        String list = objectMapper.writeValueAsString(items);

        orderService.userInfo("2");

        model.addAttribute("items", items); // html 사용
        model.addAttribute("list", list);   // script 사용

        return "/customer/order";
    }

}

