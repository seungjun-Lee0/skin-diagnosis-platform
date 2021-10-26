package lsj.spring.project.controller;

import lsj.spring.project.service.AdminDataService;
import lsj.spring.project.vo.AdminData;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class AdminController {

    @Autowired private AdminDataService adsrv;

    @GetMapping("/admin/main")
    public ModelAndView adminDataCon(ModelAndView mv){
        mv.setViewName("admin/main.tiles");
        return mv;
    }

    @PostMapping("/admin/main")
    public String adminDataConOk(AdminData ad){
        adsrv.newAdminDataLog(ad);
        return "redirect:/admin/main.tiles";
    }

    @GetMapping("/admin/cureMain")
    public ModelAndView adminCureMain(ModelAndView mv){
        mv.setViewName("admin/cureMain.tiles");
        return mv;
    }

    @GetMapping("/admin/cure/V")
    public ModelAndView adminCureV(ModelAndView mv){
        mv.setViewName("admin/cureV.tiles");
        return mv;
    }

    @PostMapping("/admin/cure/V")
    public String adminCureVOk(AdminData ad){
        adsrv.newAdminDataCureV(ad);
        return "redirect:/admin/cureMain.tiles";
    }

    @GetMapping("/admin/cure/I")
    public ModelAndView adminCureI(ModelAndView mv){
        mv.setViewName("admin/cureI.tiles");
        return mv;
    }

    @PostMapping("/admin/cure/I")
    public String adminCureIOk(AdminData ad){
        adsrv.newAdminDataCureI(ad);
        return "redirect:/admin/cureMain.tiles";
    }

    @GetMapping("/admin/cure/T")
    public ModelAndView adminCureT(ModelAndView mv){
        mv.setViewName("admin/cureT.tiles");
        return mv;
    }

    @PostMapping("/admin/cure/T")
    public String adminCureTOk(AdminData ad){
        adsrv.newAdminDataCureT(ad);
        return "redirect:/admin/cureMain.tiles";
    }

    @GetMapping("/admin/cure/L")
    public ModelAndView adminCureL(ModelAndView mv){
        mv.setViewName("admin/cureL.tiles");
        return mv;
    }

    @PostMapping("/admin/cure/L")
    public String adminCureLOk(AdminData ad){
        adsrv.newAdminDataCureL(ad);
        return "redirect:/admin/cureMain.tiles";
    }

    @GetMapping("/admin/inquiry")
    public ModelAndView adminInquiry(ModelAndView mv, String cp){
        if (cp == null || cp == "") cp = "1";
        mv.setViewName("admin/inquiry.tiles");
        mv.addObject("ads", adsrv.readAdminData(cp));
        mv.addObject("adAll", adsrv.readAllAdminData());
        mv.addObject("adCnt", adsrv.countAdminData());
        return mv;
    }

    @GetMapping("/admin/inquiry/find")
    public ModelAndView find(ModelAndView mv, String cp, String findkey1, String findkey2) {
        mv.setViewName("admin/inquiry.tiles");

        mv.addObject("find", 1);
        mv.addObject("ads", adsrv.readAdminData(cp, findkey1, findkey2));
        mv.addObject("adAll", adsrv.readAllAdminData());
        mv.addObject("adCnt", adsrv.countAdminData(findkey1, findkey2));
        return mv;
    }

    @GetMapping("/admin/inquiry/detail")
    public ModelAndView adminInquiryDetail(ModelAndView mv, String adno){
        mv.setViewName("admin/inquiryDetail.tiles");

        mv.addObject("adTs", adsrv.readOneAdminData(adno));
        mv.addObject("adCnt", adsrv.countAdminData());
        return mv;
    }

    @PostMapping("/admin/inquiry/delete")
    public String adminInquiryDelete(String adno)
    {
        System.out.println(adno);
        adsrv.deleteAdminInquiry(adno);
        return "redirect:/admin/inquiry?cp=1";
    }
}
