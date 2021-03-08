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

}