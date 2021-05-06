package lsj.spring.project.controller;

import lsj.spring.project.service.MemberService;
import lsj.spring.project.vo.Member;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;

@Controller
public class MypageController {

    @Autowired private MemberService mbsrv;

    @GetMapping("/mypage/myInfo")
    public ModelAndView myInfo(ModelAndView mv){
        mv.setViewName("mypage/myInfo.tiles");
        return mv;
    }

    @PostMapping("/member/myInfoChanged")
    public String modifyOk(Member m, ModelAndView mv, HttpSession sess) throws Exception {
        mbsrv.modifyMember(m, sess);
        mv.addObject("mb", sess.getAttribute("MyInfo"));
        return "redirect:/";
    }

    // 회원탈퇴
    @GetMapping("/mypage/withdraw")
    public String withdraw() {
        return "mypage/withdraw.tiles";
    }

    @GetMapping("/mypage/withdrawfail")
    public String withdrawfail() { return "mypage/withdrawfail.tiles"; }

    @PostMapping("/mypage/withdraw")
    public String withdrawOk(Member m, HttpSession sess, RedirectAttributes ra, HttpServletResponse res) throws Exception {

        String returnPage = "";

        if (mbsrv.checkLogin(m, sess)) {
            res.setContentType("text/html; charset=UTF-8");
            PrintWriter out = null;
            try {
                out = res.getWriter();
            } catch (IOException e) {
                e.printStackTrace();
            }
            out.println("<script>alert('정상적으로 탈퇴 되었습니다'); location.href=\"/\";</script>");
            out.flush();

            mbsrv.removeMember(m);
            sess.invalidate();
            returnPage = "redirect:/";
        }
        else{
            ra.addFlashAttribute("msg", "아이디 또는 비밀번호가 일치하지 않습니다");
            ra.addFlashAttribute("url","/");
            return "redirect:/mypage/withdrawfail"; // alert 후, 전달된 url 파라미터로 이동시키는 페이지
        }

        return returnPage;
    }

    @GetMapping("/mypage/myDiagnosis")
    public ModelAndView myDiagnosis(ModelAndView mv){
        mv.setViewName("mypage/myDiagnosis.tiles");
        return mv;
    }

    @GetMapping("/mypage/myInquiry")
    public ModelAndView myInquiry(ModelAndView mv){
        mv.setViewName("mypage/myInquiry.tiles");
        return mv;
    }

}
