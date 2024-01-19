package com.dabook.dabook.controller;

import com.dabook.dabook.entity.Book;
import com.dabook.dabook.service.BookService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.Arrays;
import java.util.List;

@Controller
@RequestMapping("/dabook")
@RequiredArgsConstructor
public class HomeController {

    private final BookService bookService;

    @RequestMapping("/test")
    public String test(){
        System.out.println("test실행");
        return "test";
    }

    @GetMapping("")
    public String home(Model model){
        System.out.println("home");
        List<Book> nowBook = bookService.getNowBook();
        model.addAttribute("books",nowBook);
        return "main/home";
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