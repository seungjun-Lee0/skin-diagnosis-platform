package lsj.spring.project.controller;

import lsj.spring.project.service.NoticeService;
import lsj.spring.project.vo.Notice;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
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
        mv.addObject("nsall", nsrv.readAllNotice());
        mv.addObject("ncnt", nsrv.countNotice());
        return mv;
    }

    @GetMapping("/notice/detail")
    public ModelAndView noticeDetail(ModelAndView mv, String bno){
        String prev = String.valueOf(Integer.parseInt(bno) - 1);
        String next = String.valueOf(Integer.parseInt(bno) + 1);

        nsrv.viewCountNotice(bno);

        mv.setViewName("notice/detail.tiles");
        mv.addObject("nts", nsrv.readOneNotice(bno));
        mv.addObject("ncnt", nsrv.countNotice());
        mv.addObject("prev", nsrv.readOneNotice(prev));
        mv.addObject("next", nsrv.readOneNotice(next));
        return mv;
    }

    @GetMapping("/notice/write")
    public String noticeWrite(){
        return "notice/write.tiles";
    }

    @PostMapping("/notice/write")
    public String noticeWriteok(Notice n, MultipartFile[] img){
        String returnPage = "redirect:/notice/list?cp=1";
        nsrv.newNotice(n, img);
        return returnPage;
    }

    @GetMapping("/notice/modify")
    public ModelAndView noticeModify(String bno, ModelAndView mv){
        mv.setViewName("notice/modify.tiles");
        mv.addObject("nts", nsrv.readOneNotice(bno));
        return mv;
    }

    @PostMapping("/notice/modify")
    public String noticeModifyOk(Notice n, String bno, MultipartFile[] img)
    {
        nsrv.modifyNotice(n, bno, img);
        return "redirect:/notice/list?cp=1";
    }

    @PostMapping("/notice/delete")
    public String noticeDeleteOk(String bno)
    {
        nsrv.deleteNotice(bno);
        return "redirect:/notice/list?cp=1";
    }

    @GetMapping("/notice/find")
    public ModelAndView find(ModelAndView mv, String cp, String findtype, String findkey) {
        mv.setViewName("notice/list.tiles");

        mv.addObject("find", 1);
        mv.addObject("ns", nsrv.readNotice(cp, findtype, findkey));
        mv.addObject("nsall", nsrv.readAllNotice());
        mv.addObject("ncnt", nsrv.countNotice(findtype, findkey));
        return mv;
    }
}
