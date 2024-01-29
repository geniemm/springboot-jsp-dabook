package com.dabook.dabook.controller;

import com.dabook.dabook.common.PaginationUtil;
import com.dabook.dabook.entity.Book;
import com.dabook.dabook.service.BookService;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
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
    public String allBook(Model model,
                          @RequestParam(defaultValue = "0",name="page")int page,
                          @RequestParam(defaultValue = "12",name="size")int size){
        // 페이지랑 사이즈 정보로 Pagealbe 객체 만듬
        PageRequest pageRequest = PageRequest.of(page, size);
        //페이지 정보를 포함한 BookList 가져오기
        Page<Book> bookPage = bookService.getAllBook(pageRequest);

        List<Book> allBook = bookPage.getContent();
        model.addAttribute("books",allBook);
        PaginationUtil.addPageAttributesWithSize(model, bookPage, size);
        return "book/allBook";
    }

    // 베스트 셀러
    @GetMapping("/bestSeller")
    public String bestSeller(Model model, @RequestParam(defaultValue = "0",name="page")int page,
                                        @RequestParam(defaultValue = "12",name="size")int size){
        PageRequest pageRequest = PageRequest.of(page,size);
        Page<Book> bookPage = bookService.getBestSeller(pageRequest);

        List<Book> bestSeller = bookPage.getContent();
        List<Book> bestSellerBanner = bookService.getBestSeller();
        model.addAttribute("books",bestSeller);
        PaginationUtil.addPageAttributesWithSize(model, bookPage, size);
        model.addAttribute("banner",bestSellerBanner);
        return "book/bestSeller";
    }


    // 지금 이 책
    @GetMapping("/nowBook")
    public String nowBook(Model model,@RequestParam(defaultValue = "0",name="page")int page,
                          @RequestParam(defaultValue = "12",name="size")int size){
        PageRequest pageRequest = PageRequest.of(page,size);
        Page<Book> bookPage = bookService.getNowBook(pageRequest);
        List<Book> nowBook = bookPage.getContent();
        List<Book> nowBookBanner = bookService.getNowBook();
        model.addAttribute("books",nowBook);
        PaginationUtil.addPageAttributesWithSize(model, bookPage, size);
        model.addAttribute("banner",nowBookBanner);
        return "book/nowBook";
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
}
