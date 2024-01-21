package com.dabook.dabook.repository;

import com.dabook.dabook.entity.Book;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface BookRepository extends JpaRepository<Book,Long> {


    // 책 정보 출력
    @Query("select b from Book b LEFT join b.bookDetail where b.no = :no")
    Book findBookInfo(@Param("no") Long no);

    // 베스트셀러 출력
    @Query("select b from Book b order by b.salesVolume desc")
    List<Book> findBestSeller();



}