package com.dabook.dabook.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class UserController {

    //구독
    @GetMapping("/user/subscription")
    public String subscription(){
        return "/customer/subscription";
    }
}
