package com.dabook.dabook.service;

import com.dabook.dabook.entity.Book;
import com.dabook.dabook.repository.BookRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@RequiredArgsConstructor
@Service
@Transactional
public class BookService {

    @Autowired
    private BookRepository bookRepository;

    @Transactional(readOnly = true)
    public List<Book> getAllBook(){
        return bookRepository.findAll();
    }

    @Transactional(readOnly = true)
    public List<Book> getBestSeller(){
        return bookRepository.findBestSeller();
    }

    @Transactional(readOnly = true) //한건조회
    public Book getBookInfo(Long no) {
        return bookRepository.findBookInfo(no);
    }

    @Transactional(readOnly = true) // 요즘 이책
    public List<Book> getNowBook(){
        return bookRepository.findNowBook();
    }

    @Transactional(readOnly = true) // 찾는 책
    public List<Book> getSearchBook(String data){
        return bookRepository.findSearchBook(data);
    }

}