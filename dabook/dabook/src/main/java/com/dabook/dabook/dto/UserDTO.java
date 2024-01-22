package com.dabook.dabook.dto;

import com.dabook.dabook.entity.GuestCheck;
import com.dabook.dabook.entity.User;
import lombok.Data;

@Data
public class UserDTO {

    private String userId;

    private String password;

    private String phone;

    private String email;

    private GuestCheck guestCheck;

    private Long userNo;
    private String userName;

    public UserDTO() {
    }

    public UserDTO(User user){
        userNo = user.getNo();
        phone = user.getPhone();
        userName = user.getUsername();
    }

}
