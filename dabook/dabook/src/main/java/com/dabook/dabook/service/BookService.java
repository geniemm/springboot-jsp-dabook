package com.dabook.dabook.service;

import com.dabook.dabook.entity.Book;
import com.dabook.dabook.repository.BookRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@RequiredArgsConstructor
@Service
@Transactional(readOnly = true)
public class BookService {


    @Autowired
    private BookRepository bookRepository;

    public Page<Book> getAllBook(Pageable pageable){
        return bookRepository.findAll(pageable);
    }

    // 베스트셀러 페이징
    public Page<Book> getBestSeller(Pageable pageable){
        return bookRepository.findBestSeller(pageable);
    }

    // 베스트셀러 전체출력
    public List<Book> getBestSeller(){
        return bookRepository.findAllBestSeller();
    }

    //한건조회
    public Book getBookInfo(Long no) {
        return bookRepository.findBookInfo(no);
    }

    // 홈화면 용 요즘 이책
    public List<Book> getNowBook(){
        return bookRepository.findSelectedNowBook();
    }
    // 요즘 이책 페이징
    public Page<Book> getNowBook(Pageable pageable){
        return bookRepository.findNowBook(pageable);
    }

}