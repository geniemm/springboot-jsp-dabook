package com.dabook.dabook.config.auth;

import com.dabook.dabook.entity.User;
import com.dabook.dabook.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class UserDetailsService implements org.springframework.security.core.userdetails.UserDetailsService {

    @Autowired private UserRepository userRepository;


    @Override
    public org.springframework.security.core.userdetails.UserDetails loadUserByUsername(String userId) throws UsernameNotFoundException {

        List<User> userIdList = userRepository.findByUserId(userId);

        if (userIdList == null || userIdList.isEmpty()) {
            throw new UsernameNotFoundException(String.format("아이디를 찾을 수 없음"));
        }

        User user = userIdList.get(0);



        return new UserDetails(user);
    }

}
