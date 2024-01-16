package com.dabook.dabook.entity;

import jakarta.persistence.Embeddable;
import lombok.Getter;

@Embeddable
@Getter
public class BookDetail {

    private String photo;
    private String content;

}