package lsj.spring.project.controller;

import lsj.spring.project.service.DiagnosisService;
import lsj.spring.project.vo.Acne;
import lsj.spring.project.vo.Diagnosis;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import java.io.*;

import java.io.IOException;

@Controller
public class DiagnosisController {

    @Autowired private DiagnosisService dgsrv;
    //File rawImagePath = new File("C:\\Users\\USER\\Desktop\\acne_detect\\dist\\acne_detect\\test");
    File rawImagePath = new File("/home/ec2-user/acne_detect/dist/acne_detect/test");
    //File patchedImagePath = new File("C:\\Users\\USER\\Desktop\\acne_detect\\dist\\acne_detect\\patch_path");
    File patchedImagePath = new File("/home/ec2-user/acne_detect/dist/acne_detect/patch_path");
    //private String resultFile = "C:\\Users\\USER\\Desktop\\acne_detect\\dist\\acne_detect\\result_file.csv";
    private String resultFile = "/home/ec2-user/acne_detect/dist/acne_detect/result_file.csv";
    private File[] rawImageFiles = rawImagePath.listFiles();
    private File[] patchedImageFiles = patchedImagePath.listFiles();
    private String uid;

    @GetMapping("/diagnosis/intro")
    public ModelAndView diagnosisIntro(ModelAndView mv){
        mv.setViewName("diagnosis/intro.tiles");
        return mv;
    }

    @GetMapping("/diagnosis/check")
    public ModelAndView selfDiagnosis(ModelAndView mv){
        mv.setViewName("diagnosis/check.tiles");
        return mv;
    }

    @PostMapping("/diagnosis/check")
    public String selfDiagnosisOk(Diagnosis d){
        dgsrv.newDiagnosis1(d);
        return "redirect:/diagnosis/check2";
    }

    @GetMapping("/diagnosis/check2")
    public ModelAndView selfDiagnosis2(ModelAndView mv){
        mv.setViewName("diagnosis/check2.tiles");
        return mv;
    }

    @PostMapping("/diagnosis/check2")
    public String selfDiagnosis2Ok(Diagnosis d, @RequestParam(value = "img") MultipartFile[] img){
        d.setDno(dgsrv.readOneDno(d.getUid()));
        dgsrv.newDiagnosis2(d, img);
        return "redirect:/diagnosis/acne_detect";
    }

    @GetMapping("/diagnosis/acne_detect")
    public ModelAndView acneDetect(ModelAndView mv){
        mv.setViewName("diagnosis/loading.tiles");
        return mv;
    }

    @PostMapping("/diagnosis/acne_detect")
    public String acneDetectOk(Acne a){
        Runtime rt = Runtime.getRuntime();

        String url = "C:\\Users\\USER\\Desktop\\acne_detect\\dist\\acne_detect\\acne_detect.exe";
        //String url = "\\home\\ec2-user\\acne_detect\\dist\\acne_detect\\acne_detect.exe";
        Process pro;

        try{
            File deleteCSV = new File(resultFile);
            if(deleteCSV.exists()){
                deleteCSV.delete();
                System.out.printf("CSV file has been deleted.");
            }else {
                System.out.println("CSV file does not exist.");
            }
            if(rawImageFiles != null) {
                for (File file : rawImageFiles) {
                    if(file.delete()){
                        System.out.println("files have been successfully deleted : " + file);
                    }
                    else{
                        System.out.println("files have not been deleted");
                    }
                }
            }
            if(patchedImageFiles != null) {
                for (File file : patchedImageFiles) {
                    if(file.delete()){
                        System.out.println("files have been successfully deleted : " + file);
                    }
                    else{
                        System.out.println("files have not been deleted");
                    }
                }
            }
            pro = rt.exec(url);
            pro.waitFor();
            readCSV(a);
        } catch (Exception e) {
            e.printStackTrace();
        }

        return "redirect:/diagnosis/result";
    }

    public void readCSV(Acne a) {
        //File csv = new File("C:\\Users\\USER\\Desktop\\acne_detect\\dist\\acne_detect\\result_file.csv");
        File csv = new File("/home/ec2-user/acne_detect/dist/acne_detect/result_file.csv");
        BufferedReader br = null;
        String line = "";

        try {
            br = new BufferedReader(new FileReader(csv));
            int num = 0;
            while ((line = br.readLine()) != null) { // read each line of the file
                String[] lineArr = line.split(","); // save the values as list by dividing each line with comma
                if(num > 0) {
                    a.setFname(lineArr[0].trim());
                    uid = lineArr[0].split("-")[0];
                    a.setAvg(lineArr[1].trim());
                    a.setFh(lineArr[2].trim());
                    a.setLc(lineArr[3].trim());
                    a.setRc(lineArr[4].trim());
                    a.setNose(lineArr[5].trim());
                    a.setChin(lineArr[6].trim());
                    dgsrv.newAcneScore(a);
                }
                num+=1;
            }

        } catch (FileNotFoundException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            try {
                if (br != null) {
                    br.close(); // close BufferedReader after use
                }
            } catch(IOException e) {
                e.printStackTrace();
            }
        }
    }
    @GetMapping("/diagnosis/result")
    public ModelAndView diagnosisResult(ModelAndView mv){
        mv.addObject("rsall", dgsrv.readAcneScore(uid));
        mv.setViewName("diagnosis/result.tiles");
        return mv;
    }

    @GetMapping("/diagnosis/completed")
    public ModelAndView diagnosisCompleted(ModelAndView mv){
        mv.setViewName("diagnosis/completed.tiles");
        return mv;
    }
}
