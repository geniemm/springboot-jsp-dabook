package com.dabook.dabook.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.Arrays;
import java.util.List;

@Controller
public class HomeController {

    @RequestMapping("/test")
    public String test(){
        System.out.println("test실행");
        return "test";
    }



}