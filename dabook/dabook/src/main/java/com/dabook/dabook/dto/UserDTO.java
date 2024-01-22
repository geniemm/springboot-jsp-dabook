package com.dabook.dabook.dto;

import com.dabook.dabook.entity.GuestCheck;
import lombok.Data;

@Data
public class UserDTO {

    private String userId;

    private String password;

    private String name;

    private String phone;

    private String email;

    private GuestCheck guestCheck;


}
