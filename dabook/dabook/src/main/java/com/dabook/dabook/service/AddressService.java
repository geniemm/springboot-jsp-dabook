package com.dabook.dabook.service;

import com.dabook.dabook.dto.AddressDTO;
import com.dabook.dabook.entity.Address;
import com.dabook.dabook.entity.User;
import com.dabook.dabook.repository.AddressRepository;
import com.dabook.dabook.repository.AddressRepositoryImpl;
import com.dabook.dabook.repository.UserRepository;
import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@Transactional
@RequiredArgsConstructor
public class AddressService {

    private final AddressRepositoryImpl addressRepositoryImpl;
    private final AddressRepository addressRepository;
    private final UserRepository userRepository;

    public Long userNo(String userId){
        List<User> byUserId = userRepository.findByUserId(userId);
        for (User user : byUserId) {
            System.out.println("user.getNo() = " + user.getNo());
        }
        return byUserId.get(0).getNo();

    }


    public List<AddressDTO> addressList(Long no){
        List<Address> addresses = addressRepositoryImpl.addressList(no);

        return addresses.stream()
                .map(AddressDTO::new)
                .toList();
    }

    public boolean chkAddrDel(List<Long> noList){
        try{
            addressRepository.chkAddrDel(noList);
            return true;
        }catch (Exception e){
            e.printStackTrace();
            return false;
        }
    }

    public boolean addrDel(Long no){
        try{
            addressRepository.addrDel(no);
            return true;
        }catch (Exception e){
            e.printStackTrace();
            return false;
        }
    }

    public boolean addrAdd(Long no, String zipcode, String address, String detail){
        System.out.println(address);
        try {
            addressRepository.addrAdd(no, zipcode, address, detail);
            return true;
        }catch (Exception e){
            e.printStackTrace();
            return false;
        }
    }

    public boolean addrModi(Long no, String zipcode, String address, String detail){
        System.out.println(address);
        try {
            addressRepository.addrModi(no, zipcode, address, detail);
            return true;
        }catch (Exception e){
            e.printStackTrace();
            return false;
        }
    }
}