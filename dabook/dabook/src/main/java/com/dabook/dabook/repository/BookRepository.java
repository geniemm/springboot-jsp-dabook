package com.dabook.dabook.repository;

import com.dabook.dabook.entity.Book;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface BookRepository extends JpaRepository<Book,Long> {

    Page<Book> findAll(Pageable pageable);

    // 책 정보 출력 페이징
    @Query("select b from Book b LEFT join b.bookDetail where b.no = :no")
    Book findBookInfo(@Param("no") Long no);

    // 베스트셀러 페이징
    @Query("select b from Book b order by b.salesVolume desc")
    Page<Book> findBestSeller(Pageable pageable);

    // 베스트셀러
    @Query("select b from Book b order by b.salesVolume desc")
    List<Book> findAllBestSeller();

    // 요즘이책 페이징
    @Query("select b from Book b order by b.publishDate desc")
    Page<Book> findNowBook(Pageable pageable);


    // 요즘 이책(신간) 10개만 가져와서 홈화면 출력'
    @Query("select b from Book b order by b.publishDate desc limit 10")
    List<Book> findSelectedNowBook();

}