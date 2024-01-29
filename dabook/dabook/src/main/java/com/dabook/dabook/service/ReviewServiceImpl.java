package com.dabook.dabook.service;

import com.dabook.dabook.dto.ReviewUpdateDTO;
import com.dabook.dabook.entity.Book;
import com.dabook.dabook.entity.Review;
import com.dabook.dabook.entity.User;
import com.dabook.dabook.repository.BookRepository;
import com.dabook.dabook.repository.ReviewRepository;
import com.dabook.dabook.repository.UserRepository;
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
    private final UserRepository userRepository;


    @Transactional(readOnly = true)
    public List<Review> getReviewsByBookNo(Long no){

        return reviewRepository.findReviewsByBookNo(no);
    }


    //리뷰 등록
    public Review saveReview(String review, String userId, Long bookNo,int rating) {
        Book book = bookRepository.findBookInfo(bookNo); //책번호로 책엔티티
        User user = userRepository.findOneUser(userId); // 아이디값으로 유저엔티티

        Review saveReview = Review.saveReview(user, book, review, rating);
        return reviewRepository.save(saveReview);
    }

    public void deleteReview(Long review_no){
        reviewRepository.deleteById(review_no);
    }

//    @Override
//    public Optional<Review> updateReview(Long review_no, ReviewUpdateDTO reviewUpdateDTO) {
//        Optional<Review> review = this.reviewRepository.findById(review_no);
//        review.ifPresent(r->{
//            r.setRating(reviewUpdateDTO.getRating());
//            r.setReviewDate(LocalDateTime.now());
//            if(reviewUpdateDTO.getReviewContent()!=null){
//                r.setReviewContent(reviewUpdateDTO.getReviewContent());
//            }
//            this.reviewRepository.save(r);
//        });
//        log.info("----r:---"+review);
//        return review;
//    }

    // 이미 등록된 리뷰 있는지 확인
    @Override
    public boolean hasReviewByUserAndBook(String userId, Long bookNo) {
        return reviewRepository.existsByBooksNoAndUsersUserId(bookNo, userId);
    }
}