package com.dabook.dabook.config.security;

import com.dabook.dabook.config.auth.RememberMeService;
import com.dabook.dabook.config.auth.UserDetailsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;

@Configuration
@EnableWebSecurity
public class SecurityConfig {

    @Autowired UserDetailsService userDetailsService;

    @Bean
    public RememberMeService rememberMeService(){
        return new RememberMeService("key", userDetailsService);
    }

    //비밀번호 암호화
    @Bean
    public BCryptPasswordEncoder encode(){
        return new BCryptPasswordEncoder();
    }

    //시큐리티 설정
    @Bean
    SecurityFilterChain filterChain(HttpSecurity http) throws  Exception {

        http
                .csrf((auth) -> auth.disable());

        http
                .authorizeHttpRequests(auth -> auth
                        .requestMatchers("/dabook/user/**").hasRole("USER")
                        .anyRequest().permitAll()
                )
                .formLogin((login) -> {
                    login.loginPage("/dabook/main/login")
                            .usernameParameter("userId")
                            .passwordParameter("password")
                            .loginProcessingUrl("/dabook/main/login")
                            .defaultSuccessUrl("/dabook/main/success")
                            .failureHandler(loginFailHandler());

                });
        http
                .rememberMe((remember)-> {
                    remember.rememberMeParameter("remember")
                            .tokenValiditySeconds(604800) //7days
                            .alwaysRemember(false)
                            .userDetailsService(userDetailsService);

                });



        http
                .logout((logout)->{
                    logout.logoutUrl("/dabook/main/logout")
                            .logoutSuccessUrl("/");

                });


        return http.build();

    }

    @Bean public LoginFailHandler loginFailHandler(){
        return new LoginFailHandler();
    }


}
