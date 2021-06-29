package lsj.spring.project.controller;
import lsj.spring.project.service.NoticeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpSession;


@Controller
public class HomeController {

    @Autowired
    private NoticeService nsrv;

    @GetMapping("/")
    public ModelAndView homepage(ModelAndView mv, HttpSession sess){
        sess.setAttribute("Notice", nsrv.readAllNotice());
        mv.setViewName("home.tiles");
        return mv;
    }

    @GetMapping("/intro")
    public ModelAndView intro(ModelAndView mv){
        mv.setViewName("intro.tiles");
        return mv;
    }

    @GetMapping("/tos")
    public ModelAndView tos(ModelAndView mv){
        mv.setViewName("tos.tiles");
        return mv;
    }

    @GetMapping("/privacy")
    public ModelAndView privacy(ModelAndView mv){
        mv.setViewName("privacy.tiles");
        return mv;
    }

    @GetMapping("/counsel")
    public ModelAndView counsel(ModelAndView mv){
        mv.setViewName("counsel.tiles");
        return mv;
    }

}