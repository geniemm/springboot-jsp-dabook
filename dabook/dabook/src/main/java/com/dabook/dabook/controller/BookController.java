package com.dabook.dabook.controller;

import com.dabook.dabook.entity.Book;
import com.dabook.dabook.service.BookService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;

@Controller
@Slf4j
@RequiredArgsConstructor
@RequestMapping("/dabook")
public class BookController {

    private final BookService bookService;


    // 전체 책 보기
    @GetMapping("/allBook")
    public String allBook(Model model){
        List<Book> books = bookService.getAllBook();
        model.addAttribute("books",books);
        log.info("책 몇개야"+books.size());
        return "book/allBook";
    }

    // 베스트 셀러
    @GetMapping("/bestSeller")
    public String bestSeller(){
        return "book/bestSeller";
    }
    // 지금 이 책
    @GetMapping("/nowBook")
    public String nowBook(){
        return "book/nowBook";
    }
}
