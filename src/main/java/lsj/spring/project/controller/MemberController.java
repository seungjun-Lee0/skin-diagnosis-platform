package lsj.spring.project.controller;


import lsj.spring.project.service.MemberService;
import lsj.spring.project.vo.Member;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;

@Controller
public class MemberController {

    @Autowired private MemberService mbsrv;
    @Autowired private JavaMailSenderImpl mailSender;

    @GetMapping("/member/regAgree")
    public String regAgree(){
        return "member/regAgree.tiles";
    }

    @GetMapping("/member/regForm")
    public String regForm(){
        return "member/regForm.tiles";
    }

    @GetMapping("/member/regCompleted")
    public String regCompleted(){
        return "member/regDone.tiles";
    }

    @PostMapping("/member/regDone")
    public String regOk(Member m) throws Exception {
        mbsrv.newMember(m);
        return "redirect:/member/regCompleted";
    }

    // id duplicate check
    @ResponseBody
    @GetMapping("/member/checkuid")
    public void checkuid(String uid, HttpServletResponse res) {
        try {
            res.getWriter().println(mbsrv.checkUserid(uid));
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    // email duplicate check
    @ResponseBody
    @GetMapping("/member/checkemail")
    public void checkueamil(String email1, String email2, HttpServletResponse res) {
        try {
            res.getWriter().println(mbsrv.checkUemail(email1 + '@' + email2));
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    @GetMapping("/member/login")
    public String login(){
        return "member/login.tiles";
    }

    @PostMapping("/member/login")
    public String login(Member m, HttpSession sess , RedirectAttributes ra) throws Exception {
        String returnPage = "";

        if (mbsrv.checkLogin(m, sess)) returnPage = "redirect:/";
        else{
            ra.addFlashAttribute("msg", "아이디 또는 비밀번호가 일치하지 않습니다!!");
            ra.addFlashAttribute("url","/member/login");
            return "redirect:/fail";
        }
        return returnPage;
    }

    @GetMapping("/fail")
    public String fail() { return "member/fail.tiles"; }

    @GetMapping("/member/logout")
    public String logout(HttpSession sess) {
        sess.invalidate();
        return "redirect:/";
    }

    @GetMapping("/member/findid")
    public String findid(){
        return "member/findid.tiles";
    }

    @PostMapping("/member/findidok")
    public String findidOk( Member m, RedirectAttributes ra, HttpServletResponse res){
        String returnPage = "";

        if (mbsrv.findUserid(m)) {
            res.setContentType("text/html; charset=UTF-8");
            PrintWriter out = null;
            try {
                out = res.getWriter();
            } catch (IOException e) {
                e.printStackTrace();
            }
            out.println("<script>alert('고객님의 아이디는" + m.getUid() + "입니다.'); location.href=\"/member/login\";</script>");
            out.flush();

            returnPage = "redirect:/member/login";
        }
        else{
            ra.addFlashAttribute("msg", "이름 또는 이메일이 일치하지 않습니다");
            ra.addFlashAttribute("url","/");
            return "redirect:/fail";
        }

        return returnPage;
    }

    @GetMapping("/member/findpwd")
    public String findpwd(){
        return "member/findpwd.tiles";
    }

    @PostMapping("/member/findpwdok")
    public String findpwdOk( Member m, String uemail, RedirectAttributes ra, HttpServletResponse res) throws Exception {
        String returnPage = "";

        if (mbsrv.checkUserid2(m).equals("1")) {
            res.setContentType("text/html; charset=UTF-8");
            PrintWriter out = null;
            try {
                out = res.getWriter();
            } catch (IOException e) {
                e.printStackTrace();
            }
            out.println("<script>alert('고객님의 이메일로 임시비밀번호가 발송되었습니다.'); location.href=\"/member/login\";</script>");
            out.flush();

            returnPage = "redirect:/member/login";

            try {
                String uname = mbsrv.readOneMember(m.getUid()).getUname();
                MimeMessage message = mailSender.createMimeMessage();
                MimeMessageHelper messageHelper = new MimeMessageHelper(message, true, "UTF-8");

                messageHelper.setFrom("더삼점영 피부과 <82tool82@gmail.com>");
                messageHelper.setTo(m.getUemail());
                messageHelper.setSubject("[비밀번호 변경안내]");
                messageHelper.setText(
                        "<div style=\"font-size:20px\"><span style=\"color:#7e69fe\">" + uname + "</span> 고객님의 비밀번호가"
                                + "<span style=\"color:#7e69fe\">'" + mbsrv.updateUserpwd(m) +
                                "'</span>으로 바뀌었음을 알려드립니다. 웹사이트에 방문하셔서 암호를 재설정 해주시길 바랍니다.</div>", true);

                mailSender.send(message);
            } catch (Exception e){
                System.out.println(e);
            }
        }
        else{
            ra.addFlashAttribute("msg", "아이디 또는 이메일이 일치하지 않습니다");
            ra.addFlashAttribute("url","/member/findid");
            return "redirect:/fail";
        }

        return returnPage;
    }

}
