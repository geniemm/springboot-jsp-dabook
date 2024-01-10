package com.dabook.dabook.repository;

import com.dabook.dabook.entity.Book;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

public interface BookRepository extends JpaRepository<Book,Long> {

    // 베스트셀러 출력
    @Query("select b from Book b order by b.salesVolume desc")
    List<Book> findBestSeller();

}