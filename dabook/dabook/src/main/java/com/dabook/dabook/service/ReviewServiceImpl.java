package com.dabook.dabook.service;

import com.dabook.dabook.dto.ReviewUpdateDTO;
import com.dabook.dabook.dto.UserDTO;
import com.dabook.dabook.entity.Book;
import com.dabook.dabook.entity.Review;
import com.dabook.dabook.entity.User;
import com.dabook.dabook.repository.BookRepository;
import com.dabook.dabook.repository.ReviewRepository;
import com.dabook.dabook.repository.UserRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.List;
import java.util.NoSuchElementException;
import java.util.Optional;

@Service
@Transactional
@RequiredArgsConstructor
@Slf4j
public class ReviewServiceImpl implements ReviewService {

    private final ReviewRepository reviewRepository;
    private final BookRepository bookRepository;
    private final UserRepository userRepository;


    // 리뷰 리스트 가져오기
    @Transactional(readOnly = true)
    public List<Review> getReviewsByBookNo(Long no) {
        return reviewRepository.findReviewsByBookNo(no);
    }

    //리뷰 등록
    public Review saveReview(String review, String userId, Long bookNo,int rating) {
        Book book = bookRepository.findBookInfo(bookNo); //책번호로 책엔티티
        User user = userRepository.findOneUser(userId); // 아이디값으로 유저엔티티

        Review saveReview = Review.saveReview(user, book, review, rating);
        return reviewRepository.save(saveReview);
    }

    // 리뷰 삭제
    public void deleteReview(Long review_no) {
        reviewRepository.deleteById(review_no);
    }

//    // 리뷰수정
//    @Override
//    public Review updateReview(Long bookNo, ReviewUpdateDTO reviewUpdateDTO, String userId) {
//        // bookNo로 해당 사용자의 리뷰를 찾아옴
//        Review existingReview = reviewRepository.findByBookNoAndUserId(bookNo, userId);
//
//        if (existingReview != null) {
//            existingReview.setReviewContent(reviewUpdateDTO.getReviewContent());
//            existingReview.setRating(reviewUpdateDTO.getRating());
//            existingReview.setReviewDate(LocalDateTime.now());
//
//            // 리뷰 업데이트를 저장
//            return reviewRepository.save(existingReview);
//        } else {
//            throw new NoSuchElementException("해당 리뷰를 찾을 수 없습니다.");
//        }
//    }

    // 이미 등록된 리뷰 있는지 확인
    @Override
    public boolean hasReviewByUserAndBook(String userId, Long bookNo) {
        return reviewRepository.existsByBooksNoAndUsersUserId(bookNo, userId);
    }


}

