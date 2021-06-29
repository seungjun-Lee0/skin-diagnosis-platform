package lsj.spring.project.controller;

import lsj.spring.project.service.EventService;
import lsj.spring.project.vo.Event;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class EventController {

    @Autowired private EventService esrv;

    @GetMapping("/event/list")
    public ModelAndView eventList(ModelAndView mv, String cp){
        if (cp == null || cp == "") cp = "1";
        mv.setViewName("event/list.tiles");
        mv.addObject("es", esrv.readEvent(cp));
        mv.addObject("esall", esrv.readAllEvent());
        mv.addObject("ecnt", esrv.countEvent());
        return mv;
    }

    @GetMapping("/event/detail")
    public ModelAndView eventDetail(ModelAndView mv, String bno){
        String prev = String.valueOf(Integer.parseInt(bno) - 1);
        String next = String.valueOf(Integer.parseInt(bno) + 1);

        esrv.viewCountEvent(bno);

        mv.setViewName("event/detail.tiles");
        mv.addObject("ets", esrv.readOneEvent(bno));
        mv.addObject("ecnt", esrv.countEvent());
        mv.addObject("prev", esrv.readOneEvent(prev));
        mv.addObject("next", esrv.readOneEvent(next));
        return mv;
    }

    @GetMapping("/event/write")
    public ModelAndView eventWrite(ModelAndView mv){
        mv.setViewName("event/write.tiles");
        return mv;
    }

    @PostMapping("/event/write")
    public String eventWriteOk(Event e, MultipartFile[] img) {
        String returnPage = "redirect:/event/list?cp=1";
        esrv.newEvent(e, img);
        return returnPage;
    }

    @GetMapping("/event/find")
    public ModelAndView find(ModelAndView mv, String cp, String findtype, String findkey) {
        mv.setViewName("event/list.tiles");

        mv.addObject("find", 1);
        mv.addObject("es", esrv.readEvent(cp, findtype, findkey));
        mv.addObject("esall", esrv.readAllEvent());
        mv.addObject("ecnt", esrv.countEvent(findtype, findkey));
        return mv;
    }

    @GetMapping("/event/modify")
    public ModelAndView eventModify(String bno, ModelAndView mv){
        mv.setViewName("event/modify.tiles");
        mv.addObject("ets", esrv.readOneEvent(bno));
        return mv;
    }

    @PostMapping("/event/modify")
    public String eventModifyOk(Event e, String bno, MultipartFile[] img)
    {
        esrv.modifyEvent(e, bno, img);
        return "redirect:/event/list?cp=1";
    }

    @PostMapping("/event/delete")
    public String eventDeleteOk(String bno)
    {
        esrv.deleteEvent(bno);
        return "redirect:/event/list?cp=1";
    }

}
