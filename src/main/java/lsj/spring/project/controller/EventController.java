package lsj.spring.project.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class EventController {

    @GetMapping("/event/list")
    public ModelAndView eventList(ModelAndView mv){
        mv.setViewName("event/list.tiles");
        return mv;
    }
}
