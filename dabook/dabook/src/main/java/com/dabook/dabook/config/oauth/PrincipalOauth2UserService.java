package com.dabook.dabook.config.oauth;

import com.dabook.dabook.config.auth.PrincipalDetails;
import com.dabook.dabook.config.oauth.provider.GoogleUserInfo;
import com.dabook.dabook.config.oauth.provider.NaverUserInfo;
import com.dabook.dabook.config.oauth.provider.OAuth2UserInfo;
import com.dabook.dabook.config.security.SecurityConfig;
import com.dabook.dabook.dto.UserDTO;
import com.dabook.dabook.entity.GuestCheck;
import com.dabook.dabook.entity.User;
import com.dabook.dabook.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.oauth2.client.userinfo.DefaultOAuth2UserService;
import org.springframework.security.oauth2.client.userinfo.OAuth2UserRequest;
import org.springframework.security.oauth2.core.OAuth2AuthenticationException;
import org.springframework.security.oauth2.core.user.OAuth2User;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Map;

@Service
public class PrincipalOauth2UserService extends DefaultOAuth2UserService {

    @Autowired UserRepository userRepository;


    @Override
    public OAuth2User loadUser(OAuth2UserRequest userRequest) throws OAuth2AuthenticationException {

        OAuth2User oAuth2User = super.loadUser(userRequest);

        // 강제 회원가입 진행
        OAuth2UserInfo oAuth2UserInfo = null;
        if(userRequest.getClientRegistration().getRegistrationId().equals("google")){
            oAuth2UserInfo = new GoogleUserInfo(oAuth2User.getAttributes());
        } else if (userRequest.getClientRegistration().getRegistrationId().equals("naver")) {
            oAuth2UserInfo = new NaverUserInfo((Map)oAuth2User.getAttributes().get("response") );
        }

        String userId = oAuth2UserInfo.getProvider() + "-" + oAuth2UserInfo.getUsername();
        String password = SecurityConfig.encode().encode(userId);
        String username = oAuth2UserInfo.getUsername();
        String email = oAuth2UserInfo.getEmail();
        String phone = oAuth2UserInfo.getPhone();
        String role = "ROLE_USER";
        String provider = oAuth2UserInfo.getProvider() + "-" + oAuth2UserInfo.getProviderId();

        List<User> idCheck = userRepository.findByUserId(userId);
        List<User> emailCheck = userRepository.findByEmail(email);

        User userEntity = User.builder()
                .userId(userId)
                .password(password)
                .username(username)
                .email(email)
                .phone(phone)
                .provider(provider)
                .guestCheck(GuestCheck.valueOf(role))
                .build();

        if (idCheck.isEmpty() && emailCheck.isEmpty()) {
            userRepository.saveAndFlush(userEntity);
        }

        return new PrincipalDetails(userEntity, oAuth2User.getAttributes());
    }
}
