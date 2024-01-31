package com.dabook.dabook.service;

import com.dabook.dabook.dto.ReviewUpdateDTO;
import com.dabook.dabook.entity.Review;
import org.springframework.stereotype.Service;

import java.util.Optional;

@Service
public interface ReviewService {
    // 작성한 리뷰있는지 확인
    boolean hasReviewByUserAndBook(String userId, Long bookNo);
}
