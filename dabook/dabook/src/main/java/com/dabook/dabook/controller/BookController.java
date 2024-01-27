package com.dabook.dabook.controller;

import com.dabook.dabook.entity.Book;
import com.dabook.dabook.service.BookService;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

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
        List<Book> allBook = bookService.getAllBook();
        model.addAttribute("books",allBook);
        log.info("책 몇개야:"+allBook.size());
        return "book/allBook";
    }

    // 베스트 셀러
    @GetMapping("/bestSeller")
    public String bestSeller(Model model){
        List<Book> bestSeller = bookService.getBestSeller();
        model.addAttribute("books",bestSeller);
        return "book/bestSeller";
    }

    // 책 정보 가져오기
    @GetMapping("/book")
    public String bookInfo(Model model, @RequestParam(value = "no") Long no, HttpSession httpSession){
        Book bookInfo = bookService.getBookInfo(no);
        String userId=(String)httpSession.getAttribute("userId");
        model.addAttribute("book",bookInfo);
        model.addAttribute("userId",userId);
        log.info("아아디값:"+userId);
        log.info("책번호: "+bookInfo.getNo());
        return "book/bookInfo";
    }

    // 지금 이 책
    @GetMapping("/nowBook")
    public String nowBook(Model model){
        List<Book> nowBook = bookService.getNowBook();
        model.addAttribute("books",nowBook);
        return "book/nowBook";
    }

    // 찾는 책
    @GetMapping("/searchBook")
    public String SearchBook(@RequestParam("data") String data, Model model){
        System.out.println("bookController: "+ data);
        List<Book> searchBook = bookService.getSearchBook(data);
        System.out.println("searchBook = " + searchBook);
        model.addAttribute("books", searchBook);
        return "book/searchBook";
    }
}
