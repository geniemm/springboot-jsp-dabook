package com.dabook.dabook.entity;

import jakarta.persistence.Embeddable;
import lombok.Getter;

@Embeddable
@Getter
public class BookDetail {

    private String photo;
    private String content;

//    protected BookDetail(){
//
//    }
//    public BookDetail(String photo,String content){
//        this.photo = photo;
//        this.content = content;
//    }


}