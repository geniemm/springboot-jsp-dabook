package com.dabook.dabook.dto;

import com.dabook.dabook.entity.Address;
import lombok.Data;

@Data
public class AddressDTO {

    private Long addressNo;
    private Long userNo;
    private String zipcode;
    private String address;
    private String addressDetail;

    public AddressDTO(){}

    public AddressDTO(Long no, String zipcode, String address, String detail){
        this.userNo = no;
        this.zipcode = zipcode;
        this.address = address;
        this.addressDetail = detail;
    }


    public AddressDTO(Address add){
        addressNo = add.getNo();
        userNo = add.getUsers().getNo();
        zipcode = add.getZipcode();
        address = add.getCity();
        addressDetail = add.getStreet();
    }

}