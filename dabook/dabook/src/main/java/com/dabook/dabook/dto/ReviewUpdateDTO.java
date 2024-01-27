package com.dabook.dabook.dto;

import com.fasterxml.jackson.annotation.JsonCreator;
import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Data;

import java.time.LocalDateTime;

@Data
public class ReviewUpdateDTO {
    private Long no;
    private int rating;
    private String reviewContent;
    private LocalDateTime create_date;
    private LocalDateTime update_date;


    @JsonCreator
    public ReviewUpdateDTO(@JsonProperty("no") Long no,
                           @JsonProperty("rating") int rating,
                           @JsonProperty("reviewContent") String reviewContent,
                           @JsonProperty("create_date") LocalDateTime create_date,
                           @JsonProperty("update_date") LocalDateTime update_date) {
        this.no = no;
        this.rating = rating;
        this.reviewContent = reviewContent;
        this.create_date = create_date;
        this.update_date = update_date;
    }
}