package com.dabook.dabook.controller;

import com.dabook.dabook.entity.Book;
import com.dabook.dabook.service.BookService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

@Controller
@RequiredArgsConstructor
public class HomeController {

    private final BookService bookService;

    @RequestMapping("/test")
    public String test(){
        System.out.println("test실행");
        return "test";
    }

    @GetMapping("/dabook")
    public String home(Model model){
        System.out.println("home");
        List<Book> nowBook = bookService.getNowBook();
        model.addAttribute("books",nowBook);
        return "main/home";
    }



}