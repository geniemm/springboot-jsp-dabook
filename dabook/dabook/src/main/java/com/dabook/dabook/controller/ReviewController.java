package com.dabook.dabook.controller;

import com.dabook.dabook.entity.Review;
import com.dabook.dabook.service.BookService;
import com.dabook.dabook.service.ReviewService;
import com.dabook.dabook.service.UserService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
@RequestMapping("/dabook")
@RequiredArgsConstructor
@Slf4j
public class ReviewController {

    private final ReviewService reviewService;
    private final BookService bookService;
    private final UserService UserService;



    //리뷰 보기
    @GetMapping("/review")
    public String getReview(Model model, @RequestParam(value = "no") Long no){
        List<Review> reviews = reviewService.getReviewsByBookNo(no);
        model.addAttribute("reviews",reviews);
        return "review/review";
    }

    //리뷰 작성
    @PostMapping("/review")
    public String addReview(@RequestParam(value = "no") Long no,
                            @RequestBody Review review,
                            Model model){
        reviewService.saveReview(no,review);
        return "redirect:/";
    }



}
