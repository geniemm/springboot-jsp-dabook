package com.dabook.dabook.controller;

import com.dabook.dabook.dto.ReviewUpdateDTO;
import com.dabook.dabook.entity.Review;
import com.dabook.dabook.service.BookService;
import com.dabook.dabook.service.ReviewService;
import com.dabook.dabook.service.ReviewServiceImpl;
import com.dabook.dabook.service.UserService;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Optional;

@Controller
@RequestMapping("/dabook")
@RequiredArgsConstructor
@Slf4j
public class ReviewController {

    private final ReviewService reviewService;
    private final ReviewServiceImpl reviewServiceImpl;



    //리뷰 보기
    @GetMapping("/review")
    public String getReview(Model model, @RequestParam(value = "no") Long no, HttpSession httpSession){
        List<Review> reviews = reviewServiceImpl.getReviewsByBookNo(no);
        String userId = (String)httpSession.getAttribute("userId");
        model.addAttribute("reviews",reviews);
        model.addAttribute("uId",userId);
        return "review/review";
    }

    //리뷰 작성
    @PostMapping("/review")
    public String addReview(@RequestParam(value = "no") Long no,
                            @RequestBody Review review){
        reviewServiceImpl.saveReview(no,review);
        return "redirect:/";
    }

//    // 리뷰수정
//    @PutMapping("/review/{reviewNo}")
//    @ResponseStatus(HttpStatus.NO_CONTENT)
//    public ResponseEntity<Review> updateReview(@PathVariable Long reviewNo, @RequestBody ReviewUpdateDTO reviewUpdateDTO) {
//        log.info("--------수정하기----------"+reviewUpdateDTO+"no:"+reviewNo);
//        Optional<Review> review = this.reviewService.updateReview(reviewNo,reviewUpdateDTO);
//        return new ResponseEntity(reviewUpdateDTO,HttpStatus.OK);
//    }

    // 리뷰삭제
    @DeleteMapping("/review")
    @ResponseStatus(HttpStatus.NO_CONTENT)
    public void delReview(@RequestParam(name="no") Long reviewNo){
        reviewServiceImpl.deleteReview(reviewNo);
    }
}
