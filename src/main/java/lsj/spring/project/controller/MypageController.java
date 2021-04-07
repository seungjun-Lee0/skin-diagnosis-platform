package lsj.spring.project.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class MypageController {

    @GetMapping("/mypage/myInfo")
    public ModelAndView myInfo(ModelAndView mv){
        mv.setViewName("mypage/myInfo.tiles");
        return mv;
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
