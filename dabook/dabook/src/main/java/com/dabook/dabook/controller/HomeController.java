package com.dabook.dabook.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.Arrays;
import java.util.List;

@Controller
public class HomeController {

    @RequestMapping("/test")
    public String test(){
        System.out.println("test실행");
        return "test";
    }

    @RequestMapping("/login")
    public String login(){
        System.out.println("login");
        return "main/login";
    }

    @RequestMapping("/join")
    public String join(){
        System.out.println("Join");
        return "main/join";
    }

    @RequestMapping("/mypage")
    public String mypage(){
        System.out.println("mypage");
        return "main/mypage";
    }

    @RequestMapping("/modifyInfo")
    public String modifyInfo(){
        System.out.println("modifyInfo");
        return "main/modifyInfo";
    }


}