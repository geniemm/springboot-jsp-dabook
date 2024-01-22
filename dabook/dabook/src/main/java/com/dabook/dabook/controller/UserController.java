package com.dabook.dabook.controller;

import com.dabook.dabook.dto.UserDTO;
import com.dabook.dabook.service.UserService;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.io.IOException;
import java.io.PrintWriter;

@Controller
@RequiredArgsConstructor
@Slf4j
@RequestMapping("/dabook")
public class UserController {

    private final UserService userService;
    private final BCryptPasswordEncoder encode;


    //로그인 페이지 연결
    @GetMapping("/main/login")
    public String login(@RequestParam(value = "error", required = false) String error, Model model){
        model.addAttribute("error", error);
        return "main/login";
    }

    //세션 만들기
    @RequestMapping("/main/success")
    public String loginSuccess(HttpSession session){
        String id = SecurityContextHolder.getContext().getAuthentication().getName();
        session.setAttribute("userId", id);
        return "redirect:/dabook/user/mypage?id=" + id ;
    }

    //회원가입 페이지 연결
    @GetMapping("/main/joinForm")
    public String joinForm(Model model){
        model.addAttribute("JoinFormDTO", new UserDTO());
        return "main/joinForm";
    }

    //회원가입 로직
    @PostMapping("/main/join")
    public void join(UserDTO form, HttpServletResponse res){
        form.setPassword(encode.encode(form.getPassword())); //암호화
        String msg = userService.join(form); //저장
        res.setContentType("text/html; charset=utf-8");
        PrintWriter out = null;
        try{
            out = res.getWriter();
        }catch (IOException e) {
            e.printStackTrace();
        }
        out.print(msg);
    }

    //아이디 중복체크
    @PostMapping("/main/idCheck")
    @ResponseBody
    public Boolean idCheck(@RequestParam String id){
        boolean result = true;
        if(id.trim().isEmpty()){
            result = false;
        }else{
            if(userService.idCheck(id)){
                result = false; //중복 아이디 있음
            }else{
                return result;
            }
        }
        return result;
    }

    //이메일 중복체크
    @PostMapping("/main/emailCheck")
    @ResponseBody
    public Boolean emailCheck(String email){
        boolean result = true;
        if(email.trim().isEmpty()){
            result = false;
        }else{
            if(userService.emailCheck(email)){
                result = false; //중복 이메일 있음
            }else{
                return result;
            }
        }
        return result;
    }

    //마이페이지
    @GetMapping("/user/mypage")
    public String mypage(@RequestParam String id, Model model){
        model.addAttribute("info", userService.info(id));
        return "main/mypage";
    }

    //정보수정 페이지
    @GetMapping("/user/modifyInfo")
    public String modifyInfo(@RequestParam String id, Model model){
        model.addAttribute("info", userService.info(id));
        return "main/modifyInfo";
    }

    //정보수정 적용
    @PostMapping("/user/modifyInfo") //String userId, String name, String phone, String email
    public void modiInfo(UserDTO dto, HttpServletResponse res, Model model,HttpSession session) throws IOException {

        String userId = (String)session.getAttribute("userId");
        String username = dto.getUserName();
        String phone = dto.getPhone();
        String email = dto.getEmail();

        String msg = userService.modifyInfo(userId, username, phone, email);

        res.setContentType("text/html; charset=utf-8");
        PrintWriter out = res.getWriter();
        out.print(msg);
    }

}