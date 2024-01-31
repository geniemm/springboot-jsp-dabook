package com.dabook.dabook.controller;

import com.dabook.dabook.common.GetMessage;
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
import java.util.List;

@Controller
@RequiredArgsConstructor
@Slf4j
@RequestMapping("/dabook")
public class UserController {

    private final UserService userService;
    private final BCryptPasswordEncoder encode;


    //로그인 페이지 연결
    @GetMapping("/main/login")
    public String login(@RequestParam(value = "error", required = false) String error, Model model) {
        model.addAttribute("error", error);
        return "main/login";
    }

    //로그인 성공 - 세션 만들기
    @RequestMapping("/main/success")
    public String loginSuccess(HttpSession session) {
        String id = SecurityContextHolder.getContext().getAuthentication().getName();
        session.setAttribute("userId", id);
        return "redirect:/dabook";
    }

    //회원가입 페이지 연결
    @GetMapping("/main/joinForm")
    public String joinForm(Model model) {
        model.addAttribute("JoinFormDTO", new UserDTO());
        return "main/joinForm";
    }

    //회원가입 로직
    @PostMapping("/main/join")
    public void join(UserDTO form, HttpServletResponse res) {
        form.setPassword(encode.encode(form.getPassword())); //암호화
        String msg = userService.join(form); //저장
        res.setContentType("text/html; charset=utf-8");
        PrintWriter out = null;
        try {
            out = res.getWriter();
        } catch (IOException e) {
            e.printStackTrace();
        }
        out.print(msg);
    }

    //회원가입 - 아이디 중복체크
    @PostMapping("/main/idCheck")
    @ResponseBody
    public Boolean idCheck(@RequestParam String id) {
        boolean result = true;
        if (id.trim().isEmpty()) {
            result = false;
        } else {
            if (userService.idCheck(id)) {
                result = false; //중복 아이디 있음
            } else {
                return result;
            }
        }
        return result;
    }

    //회원가입 - 이메일 중복체크
    @PostMapping("/main/emailCheck")
    @ResponseBody
    public Boolean emailCheck(String email) {
        return userService.emailCheck(email);
    }


    //정보수정 - 이메일 중복 체크
    @PostMapping("/user/emailCheck")
    @ResponseBody
    public Boolean modiEmailCheck(String email) {
        return userService.emailCheck(email);
    }

    //마이페이지
    @GetMapping("/user/mypage")
    public String mypage(@RequestParam(name="id") String id, Model model) {
        model.addAttribute("info", userService.info(id));
        return "main/mypage";
    }

    //정보수정 페이지
    @GetMapping("/user/modifyInfo")
    public String modifyInfo(@RequestParam(name="id") String id, Model model) {
        model.addAttribute("info", userService.info(id));
        return "main/modifyInfo";
    }

    //정보수정 적용
    @PostMapping("/user/modifyInfo") //String userId, String name, String phone, String email
    public void modiInfo(UserDTO dto, HttpServletResponse res, Model model, HttpSession session) throws IOException {

        String userId = (String) session.getAttribute("userId");
        String username = dto.getUserName();
        String phone = dto.getPhone();
        String email = dto.getEmail();

        String msg = userService.modifyInfo(userId, username, phone, email);

        alert(res, msg);
    }

    // id/pw 찾기 페이지 연결
    @GetMapping("/main/idpwFind")
    public String idpwFind() {
        return "main/idPwFind";
    }

    // id 찾기
    @RequestMapping("/main/searchId")
    public String idFind(String email, Model model, HttpServletResponse res) throws IOException {
        List<String> findId = userService.findId(email);

        if (findId.size() >= 1) {
            String id = findId.get(0);
            model.addAttribute("id", id);
            return "main/searchId";
        } else {
            String msg = GetMessage.getMessage("일치하는 아이디를 찾지 못했습니다.", "/dabook/main/idpwFind");
            alert(res, msg);
            return null;
        }
    }

    //pw 찾기(변경)
    @RequestMapping("/main/changePw")
    public void pwChange(@RequestParam(name="id") String userId, HttpServletResponse res,
                         @RequestParam String password1, @RequestParam String password2) throws IOException {

        if (password1.equals(password2)) {
            userService.pwChange(userId, password2);

            String msg = GetMessage.getMessage("비밀번호가 변경되었습니다.", "/dabook/main/login");
            alert(res, msg);
        } else {
            String msg = GetMessage.getMessage("새 비밀번호와 비밀번호 확인이 일치하지 않습니다.", "/dabook/main/idpwFind");
            alert(res, msg);
        }
    }


    // 비밀번호 변경 페이지
    @GetMapping("/user/newPw")
    public String newPw(@RequestParam(name="id") String userId, Model model) {
        model.addAttribute("userId", userId);
        return "main/newPw";
    }

    // mypage - 비밀번호 확인페이지
    @GetMapping("/user/pwCheck")
    public String pwCheck(@RequestParam(name="id") String id, Model model) {
        model.addAttribute("userId", id);
        return "main/pwCheck";
    }

    // mypage - 비밀번호 확인 로직
    @PostMapping("/user/pwCheck")
    public String pwCheckLogic(@RequestParam(name="userId") String userId, @RequestParam(name="password") String password, Model model, HttpServletResponse res) throws IOException {
        boolean check = userService.pwCheck(userId, password);

        model.addAttribute("userId", userId);
        if (check) {
            return "main/newPw";
        } else {
            String msg = GetMessage.getMessage("비밀번호 확인에 실패했습니다.", "/dabook/user/pwCheck?id=" + userId);
            alert(res, msg);
            return null;
        }

    }

    // mypage - 비밀번호 수정
    @PostMapping("/user/changePw")
    public void changePw(@RequestParam(name="userId") String userId, @RequestParam(name="password1") String password1,
                         @RequestParam(name="password2") String password2, HttpServletResponse res) throws IOException {

        if (password1.equals(password2)) {
            userService.pwChange(userId, password2);

            String msg = GetMessage.getMessage("비밀번호가 변경되었습니다.", "/dabook/user/mypage?id=" + userId);
            alert(res, msg);
        } else {
            String msg = GetMessage.getMessage("새 비밀번호와 비밀번호 확인이 일치하지 않습니다.", "/dabook/user/pwCheck?id=" + userId);
            alert(res, msg);
        }
    }

    public void alert(HttpServletResponse res, String msg) throws IOException {
        res.setContentType("text/html; charset=utf-8");
        PrintWriter out = res.getWriter();
        out.print(msg);
    }


}
