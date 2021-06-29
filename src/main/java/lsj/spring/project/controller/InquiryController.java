package lsj.spring.project.controller;

import lsj.spring.project.service.InquiryReplyService;
import lsj.spring.project.service.InquiryService;
import lsj.spring.project.vo.Inquiry;
import lsj.spring.project.vo.InquiryReply;
import lsj.spring.project.vo.Notice;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
public class InquiryController {

    @Autowired private InquiryService isrv;
    @Autowired private InquiryReplyService irsrv;
    private String secretBno;

    @GetMapping("/inquiry/list")
    public ModelAndView inquiryList(ModelAndView mv, String cp){
        if (cp == null || cp == "") cp = "1";

        mv.setViewName("inquiry/list.tiles");
        mv.addObject("is", isrv.readInquiry(cp));
        mv.addObject("isall", isrv.readAllInquiry());
        mv.addObject("icnt", isrv.countInquiry());
        return mv;
    }


    @GetMapping("/inquiry/detail")
    public ModelAndView inquiryDetail(ModelAndView mv, String bno){
        isrv.viewCountInquiry(bno);
        isrv.updateComment(Integer.parseInt(bno), irsrv.countComment(bno));

        mv.setViewName("inquiry/detail.tiles");
        mv.addObject("its", isrv.readOneInquiry(bno));
        mv.addObject("icnt", isrv.countInquiry());
        mv.addObject("irps", irsrv.readReply(bno));
        return mv;
    }

    @GetMapping("/inquiry/secret")
    public String inquiryPwdCheck(String bno){
        secretBno = bno;
        return "inquiry/secret.tiles";
    }

    @PostMapping("/inquiry/secret")
    public String inquiryPwdCheckOk(RedirectAttributes ra, String pwd){
        String returnPage = "redirect:/fail";
        ra.addFlashAttribute("msg", "비밀번호가 일치하지 않습니다!!");
        ra.addFlashAttribute("url","/inquiry/list?cp=1");

        if(isrv.checkSecretInquiry(secretBno, pwd) > 0) {
            returnPage = "redirect:/inquiry/detail?bno=" + secretBno;
        }
        return returnPage;
    }

    @GetMapping("/inquiry/write")
    public String inquiryWrite(){
        return "inquiry/write.tiles";
    }

    @PostMapping("/inquiry/write")
    public String inquiryWriteOk(Inquiry iq, MultipartFile[] img){
        String returnPage = "redirect:/inquiry/list?cp=1";
        isrv.newInquiry(iq, img);
        return returnPage;
    }

    @GetMapping("/inquiry/modify")
    public ModelAndView inquiryModify(String bno, ModelAndView mv){
        mv.setViewName("inquiry/modify.tiles");
        mv.addObject("its", isrv.readOneInquiry(bno));
        return mv;
    }

    @PostMapping("/inquiry/modify")
    public String inquiryModifyOk(Inquiry iq, String bno, MultipartFile[] img)
    {
        isrv.modifyInquiry(iq, bno, img);
        return "redirect:/inquiry/list?cp=1";
    }

    @PostMapping("/inquiry/delete")
    public String inquiryDeleteOk(String bno)
    {
        isrv.deleteInquiry(bno);
        return "redirect:/inquiry/list?cp=1";
    }

    @GetMapping("/inquiry/find")
    public ModelAndView find(ModelAndView mv, String cp, String findtype, String findkey) {
        mv.setViewName("inquiry/list.tiles");

        mv.addObject("find", 1);
        mv.addObject("is", isrv.readInquiry(cp, findtype, findkey));
        mv.addObject("isall", isrv.readAllInquiry());
        mv.addObject("icnt", isrv.countInquiry(findtype, findkey));
        return mv;
    }

    // write comment
    @PostMapping("/reply/write")
    public String commentOk(InquiryReply ir, String status) {
        String returnPage = "redirect:/inquiry/detail?bno=" + ir.getBno();

        if(status.equals("true")){
            isrv.updateStatus(ir.getBno());
        }

        irsrv.newComment(ir);
        return returnPage;
    }

    // modify comment
    @PostMapping("/reply/modify")
    public String commentModifyOk(InquiryReply ir) {
        String returnPage = "redirect:/inquiry/detail?bno=" + ir.getBno();

        irsrv.modifyComment(ir);
        return returnPage;
    }

    // delete comment
    @PostMapping("/reply/delete")
    public String commentDeleteOk(InquiryReply ir) {
        String returnPage = "redirect:/inquiry/detail?bno=" + ir.getBno();

        irsrv.deleteComment(ir);
        return returnPage;
    }
}
