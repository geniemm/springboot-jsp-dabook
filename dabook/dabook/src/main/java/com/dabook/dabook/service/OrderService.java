package com.dabook.dabook.service;

import com.dabook.dabook.dto.AddressDTO;
import com.dabook.dabook.dto.UserDTO;
import com.dabook.dabook.entity.Address;
import com.dabook.dabook.entity.User;
import com.dabook.dabook.repository.AddressRepositoryImpl;
import com.dabook.dabook.repository.UserRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class OrderService {

    private final UserRepository userRepository;
    private final AddressRepositoryImpl addressRepository;

    // 주문 페이지 로드 시 주문자 정보
    public List<UserDTO> userInfo(Long no){
        Optional<User> info = userRepository.findById(no);

        return info.stream()
                .map(UserDTO::new)
                .collect(Collectors.toList());
    }
    
    // 주문 페이지 로드 시 주문자 주소
    public List<AddressDTO> userAddress(Long no){
        List<Address> addresses = addressRepository.addressList(no);

        return addresses.stream()
                .map(AddressDTO::new)
                .collect(Collectors.toList());

    }
}
