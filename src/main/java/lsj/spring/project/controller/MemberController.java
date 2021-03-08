package lsj.spring.project.controller;


import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class MemberController {

    @GetMapping("/member/joinAgree")
    public String regAgree(){
        return "member/regAgree.tiles";
    }

    @GetMapping("/member/joinForm")
    public String regForm(){
        return "member/regForm.tiles";
    }

    @GetMapping("/member/joinDone")
    public String regDone(){
        return "member/regDone.tiles";
    }

    @GetMapping("member/login")
    public String login(){
        return "member/login.tiles";
    }
}
