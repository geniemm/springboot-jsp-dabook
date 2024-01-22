package com.dabook.dabook.service;

import com.dabook.dabook.dto.ReviewUpdateDTO;
import com.dabook.dabook.entity.Book;
import com.dabook.dabook.entity.Review;
import com.dabook.dabook.repository.BookRepository;
import com.dabook.dabook.repository.ReviewRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

@Service
@Transactional
@RequiredArgsConstructor
@Slf4j
public class ReviewServiceImpl implements ReviewService{

    private final ReviewRepository reviewRepository;
    private final BookRepository bookRepository;


    @Transactional(readOnly = true)
    public List<Review> getReviewsByBookNo(Long no){

        return reviewRepository.findReviewsByBookNo(no);
    }

    public Review saveReview(Long bookNo, Review review){
        Book book = bookRepository.findBookInfo(bookNo);
        review.setBooks(book);
        book.getReviews().add(review);

        return reviewRepository.save(review);
    }

    public void deleteReview(Long review_no){
        reviewRepository.deleteById(review_no);
    }

    @Override
    public Optional<Review> updateReview(Long review_no, ReviewUpdateDTO reviewUpdateDTO) {
        Optional<Review> review = this.reviewRepository.findById(review_no);
        review.ifPresent(r->{
            r.setRating(reviewUpdateDTO.getRating());
            r.setReviewDate(LocalDateTime.now());
            if(reviewUpdateDTO.getReviewContent()!=null){
                r.setReviewContent(reviewUpdateDTO.getReviewContent());
            }
            this.reviewRepository.save(r);
        });
        log.info("----r:---"+review);
        return review;
    }
}
