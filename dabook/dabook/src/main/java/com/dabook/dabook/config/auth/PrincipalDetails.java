package com.dabook.dabook.config.auth;

import com.dabook.dabook.entity.User;
import lombok.Data;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.oauth2.core.user.OAuth2User;

import java.util.ArrayList;
import java.util.Collection;
import java.util.Map;

@Data
public class PrincipalDetails implements UserDetails, OAuth2User {

    private User user;
    private Map<String, Object> attreibutes;

    @Override
    public Map<String, Object> getAttributes() {
        return attreibutes;
    }

    @Override
    public String getName() {
        return null;
    }

    // 일반로그인 생성자
    public PrincipalDetails(User user) {
        this.user = user;
    }

    // oauth - 로셜 로그인 생성자
    public PrincipalDetails(User user, Map<String, Object> attreibutes) {
        this.user = user;
        this.attreibutes = attreibutes;
    }

    @Override
    public String getPassword() {
        return user.getPassword();
    }

    @Override
    public String getUsername() {
        return user.getUserId();
    }

    @Override
    public boolean isAccountNonExpired() {
        return true;
    }

    @Override
    public boolean isAccountNonLocked() {
        return true;
    }

    @Override
    public boolean isCredentialsNonExpired() {
        return true;
    }

    @Override
    public boolean isEnabled() {
        return true;
    }



    @Override
    public Collection<? extends GrantedAuthority> getAuthorities() {
        Collection<GrantedAuthority> collection = new ArrayList<>();
        collection.add(new GrantedAuthority() {
            @Override
            public String getAuthority() {
                return String.valueOf(user.getGuestCheck());
            }
        });
        return collection;
    }


}