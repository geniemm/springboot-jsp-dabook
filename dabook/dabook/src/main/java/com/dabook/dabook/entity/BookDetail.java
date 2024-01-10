package com.dabook.dabook.entity;

import jakarta.persistence.Embeddable;

@Embeddable
public class BookDetail {

    private String photo;
    private String content;

}