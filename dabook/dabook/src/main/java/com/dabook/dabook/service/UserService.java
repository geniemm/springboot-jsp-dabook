package com.dabook.dabook.service;

import com.dabook.dabook.common.GetMessage;
import com.dabook.dabook.dto.UserDTO;
import com.dabook.dabook.entity.GuestCheck;
import com.dabook.dabook.entity.User;
import com.dabook.dabook.repository.UserRepository;
import lombok.RequiredArgsConstructor;
//import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashMap;
import java.util.List;
import java.util.Map;


@Service
@Transactional(readOnly = true)
@RequiredArgsConstructor
public class UserService {

    private final UserRepository userRepository;


    //회원가입
    @Transactional
    public String join(UserDTO dto) {

        dto.setGuestCheck(GuestCheck.valueOf("ROLE_USER"));

        User user = User.toUserEntity(dto.getUserId(), dto.getPassword(), dto.getUserName(), dto.getPhone(), dto.getEmail(), dto.getGuestCheck());

        if(userRepository.saveAndFlush(user) != null){
            return GetMessage.getMessage("회원가입 완료하였습니다.", "/dabook/main/login");
        }else{
            return GetMessage.getMessage("회원가입 실패하셨습니다.", "/dabook/main/joinForm");
        }
    }

    //회원 정보수정
    @Transactional //String userId, String name, String phone, String email
    public String modifyInfo(String userId, String username, String phone, String email) {

        try {
            userRepository.modiInfo(userId, username, phone, email);
            return GetMessage.getMessage("회원 정보가 수정되었습니다.", "/dabook/user/mypage?id=" + userId);
        }catch (Exception e){
            e.printStackTrace();
            return GetMessage.getMessage("회원 정보 수정에 실패했습니다.", "dabook/user/modifyInfo?id=" + userId);
        }

    }

    //회원가입 - id체크
    public boolean idCheck(String id) {

        boolean result = true;

        List<User> idCheck = userRepository.findByUserId(id);
        if( !idCheck.isEmpty()){ //null이 아니하면 -> id가 존재한다면
            return result; //true -> 중복아이디 존재
        }else{
            result = false; // 중복 아이디 없음 -> 회원가입 가능
        }
        return result;
    }

    //회원가입 - email체크
    public boolean emailCheck(String email) {

        boolean result = true;
        List<User> emailCheck = userRepository.findByEmail(email);
        if(!emailCheck.isEmpty()){
            return result;
        }else {
            result = false;
        }
        return result;
    }

    //마이페이지
    public Map<String, String> info(String id) {

        List<User> userInfo = userRepository.findByUserId(id);

        String userId = userInfo.get(0).getUserId();
        String password =  userInfo.get(0).getPassword();
        String username =  userInfo.get(0).getUsername();
        String email =  userInfo.get(0).getEmail();
        String phone = userInfo.get(0).getPhone();


        Map<String, String> info = new HashMap<>();
        info.put("userId", userId);
        info.put("password", password);
        info.put("username", username);
        info.put("email", email);
        info.put("phone", phone);

        return info;
    }

    public User getUserById(String userId) {
        return userRepository.findOneUser(userId);
    }

}