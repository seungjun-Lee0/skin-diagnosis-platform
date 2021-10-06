package lsj.spring.project.service;

import lsj.spring.project.dao.DiagnosisDAO;
import lsj.spring.project.utils.ImgUploadUtil;
import lsj.spring.project.vo.Acne;
import lsj.spring.project.vo.Diagnosis;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.util.*;

@Service("dgsrv")
public class DiagnosisServiceImpl implements DiagnosisService{

    @Autowired private DiagnosisDAO dgdao;
    @Autowired private ImgUploadUtil imgutil;

    //private String uploadPath = "C:\\Users\\USER\\IdeaProjects\\the3.0-dermatology-hospital-website\\src\\main\\webapp\\resources\\images\\downloadedImages\\";
    private String uploadPath = "/opt/tomcat/apache-tomcat-8.5.75/webapps/SemiProjectV3-1.0-SNAPSHOT/resources/images/downloadedImages/";
    private String dir = "diagnosis/";

    @Override
    public void newDiagnosis1(Diagnosis d) {
        dgdao.insertDiagnosis1(d);
    }

    @Override
    public String readOneDno(String uid) {
        return dgdao.selectOneDno(uid);
    }

    @Override
    public void newDiagnosis2(Diagnosis d, MultipartFile[] img) {
        String uuid = imgutil.makeUUID(); // create identification code

        String[] pos = {"front", "right", "left"};

        if(imgutil.checkFiles(img)){
            int num = 0;
            int num2 = 0;
            List<String> imgs = new ArrayList<>();

            for (MultipartFile f : img) {
                if (!Objects.requireNonNull(f.getOriginalFilename()).isEmpty())
                    imgs.add(imgutil.ImageUpload2(f, d.getUid() + "_" + pos[num] + "(" + uuid + ")"));
                else
                    imgs.add("-/-");
                num+=1;
            }

            String fnames = "";

            for (int i = 0; i < imgs.size(); ++i) {
                fnames += d.getUid() + "_" + pos[num2] + "/";
                num2+=1;
            }

            d.setFnames( fnames );
            d.setUuid( uuid );
        }
        else{
            d.setFnames( "-/-/-/");
            d.setUuid( uuid );
        }

        dgdao.insertDiagnosis2(d);
    }

    @Override
    public List<Diagnosis> readDiagnosis(String cp) {
        int snum = 10 * (Integer.parseInt(cp) - 1);
        return dgdao.selectDiagnosis(snum);
    }

    @Override
    public List<Diagnosis> readDiagnosis(String cp, String ftype, String fkey) {
        int snum = 10 * (Integer.parseInt(cp) - 1);

        Map<String, Object> params = new HashMap<>();
        params.put("snum", snum);
        params.put("ftype", ftype);
        params.put("fkey", fkey);
        return dgdao.findSelectDiagnosis(params);
    }

    @Override
    public int countDiagnosis() {
        return dgdao.selectCountDiagnosis();
    }

    @Override
    public int countDiagnosis(String ftype, String fkey) {
        Map<String, Object> params = new HashMap<>();
        params.put("ftype", ftype);
        params.put("fkey", fkey);

        return dgdao.selectCountDiagnosis(params);
    }

    @Override
    public Diagnosis readOneDiagnosis(String dno) {
        return dgdao.selectOneDiagnosis(dno);
    }

    @Override
    public void newAcneScore(Acne a){ dgdao.insertAcneScore(a); }

    @Override
    public Acne readAcneScore(String uid) {
        return dgdao.selectAcneScore(uid);
    }
}
