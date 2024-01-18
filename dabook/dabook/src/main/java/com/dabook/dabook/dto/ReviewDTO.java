package com.dabook.dabook.dto;

import com.dabook.dabook.entity.Review;

public class ReviewDTO {
    private String reviewContent;
    private int rating;
    private Long no;


    public ReviewDTO(Review review) {
        this.reviewContent = review.getReviewContent();
        this.rating = review.getRating();
        this.no = review.getBooks().getNo();
    }
}
