package lsj.spring.project.controller;

import lsj.spring.project.service.NoticeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class NoticeController {

    @Autowired
    private NoticeService nsrv;

    @GetMapping("/notice/list")
    public ModelAndView noticeList(ModelAndView mv, String cp){
        if (cp == null || cp == "") cp = "1";
        mv.setViewName("notice/list.tiles");
        mv.addObject("ns", nsrv.readNotice(cp));
        mv.addObject("ncnt", nsrv.countNotice());
        return mv;
    }

    @GetMapping("/notice/detail")
    public ModelAndView noticeDetail(String bno, ModelAndView mv){
        nsrv.viewCountNotice(bno);

        mv.setViewName("notice/detail.tiles");
        mv.addObject("nts", nsrv.readOneNotice(bno));
        return mv;
    }

    @GetMapping("/notice/find")
    public ModelAndView find(ModelAndView mv, String cp, String findtype, String findkey) {
        mv.setViewName("notice/list.tiles");
        mv.addObject("ns", nsrv.readNotice(cp, findtype, findkey));
        mv.addObject("ncnt", nsrv.countNotice(findtype, findkey));
        return mv;
    }

    @GetMapping("/notice/prev")
    public String noticePrev(String bno) {
        String prvbno = nsrv.readPrvbno(bno);
        return "redirect:/notice/detail?bno=" + prvbno;
    }

    @GetMapping("/notice/next")
    public String noticeNext(String bno) {
        String nxtbno = nsrv.readNxtbno(bno);
        return "redirect:/notice/detail?bno=" + nxtbno;
    }
}
