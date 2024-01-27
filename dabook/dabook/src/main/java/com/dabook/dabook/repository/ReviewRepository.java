package com.dabook.dabook.repository;

import com.dabook.dabook.entity.Review;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface ReviewRepository  extends JpaRepository<Review,Long> {

    @Query("select r from Review r LEFT JOIN r.books left JOIN r.users where r.books.no = :no")
    List<Review> findReviewsByBookNo(@Param("no") Long no);

    @Query("SELECT r FROM Review r WHERE r.books.no = :bookNo AND r.users.userId = :userId")
    Review findByBookNoAndUserId(@Param("bookNo") Long bookNo, @Param("userId") String userId);

    boolean existsByBooksNoAndUsersUserId(Long bookNo, String userId);

}
