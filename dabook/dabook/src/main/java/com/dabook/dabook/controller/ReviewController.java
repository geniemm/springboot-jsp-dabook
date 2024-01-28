package com.dabook.dabook.controller;

import com.dabook.dabook.common.GetMessage;
import com.dabook.dabook.dto.ReviewUpdateDTO;
import com.dabook.dabook.entity.OrderHistory;
import com.dabook.dabook.entity.Review;
import com.dabook.dabook.service.*;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

@Controller
@RequestMapping("/dabook")
@RequiredArgsConstructor
@Slf4j
public class ReviewController {

    private final ReviewService reviewService;
    private final ReviewServiceImpl reviewServiceImpl;
    private final OrderService orderService;


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
                            @RequestParam(value="reviewContent")String reviewContent,
                            @RequestParam(value = "rating")int rating,
                            HttpSession httpSession){
        log.info("review:"+reviewContent);
        String userId = (String)httpSession.getAttribute("userId");
        reviewServiceImpl.saveReview(reviewContent,userId,no,rating);

        return "redirect:/";
    }

//    // 리뷰수정
//    @PutMapping("/review")
//    @ResponseStatus(HttpStatus.NO_CONTENT)
//    public String updateReview(@RequestParam(value = "no") Long bookNo,
//                               @RequestBody ReviewUpdateDTO reviewUpdateDTO,
//                               HttpSession httpSession) {
//        log.info("--------수정하기----------" + reviewUpdateDTO + "bookNo:" + bookNo);
//        String userId = (String) httpSession.getAttribute("userId");
//        reviewService.updateReview(bookNo, reviewUpdateDTO, userId);
//        return "redirect:/";
//    }


    // 작성한 리뷰, 구매이력 있는지 확인
    @GetMapping("/review/checkByUser")
    @ResponseBody
    public Map<String, Boolean> checkReviewByUser(@RequestParam(name = "no") Long bookNo, HttpSession httpSession) {
        String userId = (String) httpSession.getAttribute("userId");
        boolean hasReview = reviewService.hasReviewByUserAndBook(userId, bookNo);
        boolean hasOrderedBook = orderService.hasOrderedBook(userId, bookNo);
        Map<String, Boolean> result = new HashMap<>();
        result.put("hasReview", hasReview);
        result.put("hasOrderedBook",hasOrderedBook);
        log.info("리뷰있는지?"+result.get(hasReview));
        log.info("구매했는지?"+result.get(hasOrderedBook));
        return result;
    }

    // 리뷰삭제
    @DeleteMapping("/review")
    @ResponseStatus(HttpStatus.NO_CONTENT)
    public void delReview(@RequestParam(name="no") Long reviewNo){
        reviewServiceImpl.deleteReview(reviewNo);
    }
}
