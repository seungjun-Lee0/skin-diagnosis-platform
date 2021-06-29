package lsj.spring.project.service;

import lsj.spring.project.dao.InquiryDAO;
import lsj.spring.project.utils.ImgUploadUtil;
import lsj.spring.project.vo.Inquiry;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.util.*;

@Service("isrv")
public class InquiryServiceImpl implements InquiryService{

    @Autowired private InquiryDAO idao;
    @Autowired private ImgUploadUtil imgutil;

    //private String uploadPath = "C:\\Users\\USER\\IdeaProjects\\the3.0-dermatology-hospital-website\\src\\main\\webapp\\resources\\images\\downloadedImages\\";
    private String uploadPath = "\\home\\ec2-user\\downloadedImages\\";
    private String dir = "inquiry\\";


    @Override
    public boolean newInquiry(Inquiry iq, MultipartFile[] img) {
        String uuid = imgutil.makeUUID(); // 식별코드 생성
        boolean isSubmitted = false;

        if(imgutil.checkFiles(img)){

            List<String> imgs = new ArrayList<>();

            for (MultipartFile f : img) {
                if (!Objects.requireNonNull(f.getOriginalFilename()).isEmpty())
                    imgs.add(imgutil.ImageUpload(f, uuid, dir));
                else
                    imgs.add("-/-");
            }

            String fnames = "";

            for (int i = 0; i < imgs.size(); ++i) {
                fnames += imgs.get(i).split("[/]")[0] + "/";
            }

            iq.setFnames( fnames );
            iq.setUuid( uuid );
        }
        else{
            iq.setFnames( "-/-/-/");
            iq.setUuid( uuid );
        }

        if(idao.insertInquiry(iq)>0){
            isSubmitted = true;
        }

        return isSubmitted;
    }

    @Override
    public List<Inquiry> readInquiry(String cp) {
        int snum = 10 * (Integer.parseInt(cp) - 1);
        return idao.selectInquiry(snum);
    }

    @Override
    public List<Inquiry> readInquiry(String cp, String bno) {
        int snum = 10 * (Integer.parseInt(cp) - 1);
        return idao.selectInquiry(snum, bno);
    }

    @Override
    public List<Inquiry> readInquiry(String cp, String ftype, String fkey) {
        int snum = 10 * (Integer.parseInt(cp) - 1);

        Map<String, Object> params = new HashMap<>();
        params.put("snum", snum);
        params.put("ftype", ftype);
        params.put("fkey", fkey);
        return idao.findSelectInquiry(params);
    }

    @Override
    public List<Inquiry> readAllInquiry() {
        return idao.selectAllInquiry();
    }

    @Override
    public Inquiry readOneInquiry(String bno) {
        return idao.selectOneInquiry(bno);
    }

    @Override
    public int countInquiry() {
        return idao.selectCountInquiry();
    }

    @Override
    public int countInquiry(String uid) {
        return idao.selectCountInquiryByUid(uid);
    }

    @Override
    public int countInquiry(String ftype, String fkey) {
        Map<String, Object> params = new HashMap<>();
        params.put("ftype", ftype);
        params.put("fkey", fkey);

        return idao.selectCountInquiry(params);
    }

    @Override
    public int checkSecretInquiry(String bno, String pwd){
        return idao.checkSecretInquiry(bno, pwd);
    }

    @Override
    public boolean viewCountInquiry(String bno) {
        boolean isUpdated = false;
        if (idao.viewCountInquiry(bno) > 0) isUpdated = true;

        return isUpdated;
    }

    @Override
    public void modifyInquiry(Inquiry iq, String bno, MultipartFile[] img) {

        List<String> imgs = new ArrayList<>();

        for(MultipartFile f : img) {
            if (!f.getOriginalFilename().isEmpty())
                imgs.add(imgutil.ImageUpload(f, iq.getUuid(),dir));
            else
                imgs.add("-/-");
        }

        String fn = idao.readFnames(bno);

        String[] ofn = fn.split("[/]");

        String fnames = "";

        for (int i = 0; i < imgs.size(); ++i) {
            fnames += imgs.get(i).split("[/]")[0] + "/";
        }

        String[] nfn = fnames.split("[/]");

        String todie[] = new String[3];


        for(int i=0; i < iq.getTodie().length(); ++i){
            int pos = Integer.parseInt(iq.getTodie().substring(i, i+1));
            ofn[pos-1] = nfn[i];
            todie[i] = fn.split("[/]")[pos-1];
        }

        fnames = String.join("/", ofn);

        iq.setFnames( fnames );

        for (int i=0; i < todie.length; ++i){
            try {
                int pos = todie[i].lastIndexOf(".");
                String name = todie[i].substring(0, pos);
                String ext = todie[i].substring(pos + 1);
                String one = name + iq.getUuid() + "." + ext;
                File f = new File(uploadPath + dir + one);
                f.delete();
            }catch (Exception e){}

        }

        idao.modifyInquiry(iq);
    }

    @Override
    public void deleteInquiry(String bno) {

        String fn = idao.readFnames(bno);
        String uuid = idao.readUuid(bno);

        if(fn!=null) {
            String[] ofn = fn.split("[/]");

            for (int i = 0; i < ofn.length; ++i) {
                try {
                    int pos = ofn[i].lastIndexOf(".");
                    String name = ofn[i].substring(0, pos);
                    String ext = ofn[i].substring(pos + 1);
                    String one = name + uuid + "." + ext;

                    File f = new File(uploadPath + dir + one);
                    f.delete();
                } catch (Exception e) {
                }

            }
        }
        idao.deleteInquiry(bno);
    }

    @Override
    public void updateComment(int bno, int countComment) {
        idao.updateComment(bno, countComment);
    }

    @Override
    public void updateStatus(String bno) {
        idao.updateStatus(bno);
    }
}
