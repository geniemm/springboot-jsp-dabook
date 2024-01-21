package com.dabook.dabook.dto;

import com.dabook.dabook.entity.User;
import lombok.Data;

@Data
public class UserDTO {
    private Long userNo;
    private String phone;
    private String userName;

    public UserDTO(User user){
        userNo = user.getNo();
        phone = user.getPhone();
        userName = user.getUsername();
    }

}
