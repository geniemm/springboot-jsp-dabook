package com.dabook.dabook.dto;

import com.dabook.dabook.entity.Review;
import lombok.Data;

import java.time.LocalDateTime;

@Data
public class ReviewUpdateDTO {
    private Long no;
    private int rating;
    private String reviewContent;
    private LocalDateTime create_date;
    private LocalDateTime update_date;


    public ReviewUpdateDTO(Review review) {
        this.reviewContent = review.getReviewContent();
        this.rating = review.getRating();
        this.no = review.getBooks().getNo();
    }
}
