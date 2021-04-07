package lsj.spring.project.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class InquiryController {

    @GetMapping("/inquiry/list")
    public ModelAndView inquiryList(ModelAndView mv){
        mv.setViewName("inquiry/list.tiles");
        return mv;
    }

    @GetMapping("/inquiry/detail")
    public ModelAndView inquiryDetail(ModelAndView mv){
        mv.setViewName("inquiry/detail.tiles");
        return mv;
    }

    @GetMapping("/inquiry/write")
    public ModelAndView inquiryWrite(ModelAndView mv){
        mv.setViewName("inquiry/write.tiles");
        return mv;
    }

    @GetMapping("/inquiry/modify")
    public ModelAndView inquiryModify(ModelAndView mv){
        mv.setViewName("inquiry/modify.tiles");
        return mv;
    }
}
