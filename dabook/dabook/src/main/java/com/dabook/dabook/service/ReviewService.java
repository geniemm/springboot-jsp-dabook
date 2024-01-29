package com.dabook.dabook.service;

import com.dabook.dabook.dto.ReviewUpdateDTO;
import com.dabook.dabook.entity.Review;
import org.springframework.stereotype.Service;

import java.util.Optional;

@Service
public interface ReviewService {
//    Review updateReview(Long reviewNo, ReviewUpdateDTO reviewUpdateDTO ,String userId);
    boolean hasReviewByUserAndBook(String userId, Long bookNo);}