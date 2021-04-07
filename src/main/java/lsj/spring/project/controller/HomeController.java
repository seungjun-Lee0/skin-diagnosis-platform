package lsj.spring.project.controller;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;


@Controller
public class HomeController {

    @RequestMapping("/home")
    public ModelAndView homepage(ModelAndView mv){
        mv.setViewName("home.tiles");
        return mv;
    }

    @RequestMapping("/intro")
    public ModelAndView intro(ModelAndView mv){
        mv.setViewName("intro.tiles");
        return mv;
    }

    @RequestMapping("/tos")
    public ModelAndView tos(ModelAndView mv){
        mv.setViewName("tos.tiles");
        return mv;
    }

    @RequestMapping("/privacy")
    public ModelAndView privacy(ModelAndView mv){
        mv.setViewName("privacy.tiles");
        return mv;
    }

    @RequestMapping("/counsel")
    public ModelAndView counsel(ModelAndView mv){
        mv.setViewName("counsel.tiles");
        return mv;
    }

}