package com.dabook.dabook.service;

import com.dabook.dabook.entity.Book;
import com.dabook.dabook.entity.Review;
import com.dabook.dabook.repository.BookRepository;
import com.dabook.dabook.repository.ReviewRepository;
import com.dabook.dabook.repository.UserRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@Transactional
@RequiredArgsConstructor
public class ReviewService {

    private final ReviewRepository reviewRepository;
    private final BookRepository bookRepository;
    private final UserRepository userRepository;


    public Review saveReview(Long bookNo, Review review){
        Book book = bookRepository.findBookInfo(bookNo);

        review.setBooks(book);

        book.getReviews().add(review);

        return reviewRepository.save(review);
    }

    @Transactional(readOnly = true)
    public List<Review> getReviewsByBookNo(Long no){
        return reviewRepository.findReviewsByBookNo(no);
    }
}
