package lsj.spring.project.service;

import lsj.spring.project.dao.NoticeDAO;
import lsj.spring.project.utils.ImgUploadUtil;
import lsj.spring.project.vo.Notice;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpSession;
import java.io.File;
import java.util.*;

@Service("nsrv")
public class NoticeServiceImpl implements NoticeService{

    @Autowired private NoticeDAO ndao;
    @Autowired private ImgUploadUtil imgutil;

    //private String uploadPath = "C:\\Users\\USER\\IdeaProjects\\the3.0-dermatology-hospital-website\\src\\main\\webapp\\resources\\images\\downloadedImages\\";
    private String uploadPath = "/home/ec2-user/apache-tomcat-8.5.75/webapps/SemiProjectV3-1.0-SNAPSHOT/resources/images/downloadedImages/";
    private String dir = "notice/";

    @Override
    public boolean newNotice(Notice n, MultipartFile[] img) {
        String uuid = imgutil.makeUUID();
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

            n.setFnames( fnames );
            n.setUuid( uuid );
        }
        else{
            n.setFnames( "-/-/-/");
            n.setUuid( uuid );
        }

        if(ndao.insertNotice(n)>0){
            isSubmitted = true;
        }

        return isSubmitted;
    }

    @Override
    public List<Notice> readNotice(String cp) {
        int snum = 10 * (Integer.parseInt(cp) - 1);
        return ndao.selectNotice(snum);
    }

    @Override
    public List<Notice> readNotice(String cp, String ftype, String fkey) {
        int snum = 10 * (Integer.parseInt(cp) - 1);

        Map<String, Object> params = new HashMap<>();
        params.put("snum", snum);
        params.put("ftype", ftype);
        params.put("fkey", fkey);
        return ndao.findSelectNotice(params);
    }

    @Override
    public List<Notice> readAllNotice() {
        return ndao.selectAllNotice();
    }

    @Override
    public Notice readOneNotice(String bno) {
        return ndao.selectOneNotice(bno);
    }

    @Override
    public int countNotice() {
        return ndao.selectCountNotice();
    }

    @Override
    public int countNotice(String ftype, String fkey) {
        Map<String, Object> params = new HashMap<>();
        params.put("ftype", ftype);
        params.put("fkey", fkey);

        return ndao.selectCountNotice(params);
    }

    @Override
    public boolean viewCountNotice(String bno) {
        boolean isUpdated = false;
        if (ndao.viewCountNotice(bno) > 0) isUpdated = true;

        return isUpdated;
    }

    @Override
    public void modifyNotice(Notice n, String bno, MultipartFile[] img) {
        List<String> imgs = new ArrayList<>();

        for(MultipartFile f : img) {
            if (!f.getOriginalFilename().isEmpty())
                imgs.add(imgutil.ImageUpload(f, n.getUuid(),dir));
            else
                imgs.add("-/-");
        }

        String fn = ndao.readFnames(bno);

        String[] ofn = fn.split("[/]");

        String fnames = "";

        for (int i = 0; i < imgs.size(); ++i) {
            fnames += imgs.get(i).split("[/]")[0] + "/";
        }

        String[] nfn = fnames.split("[/]");

        String todie[] = new String[3];


        System.out.println(n.getTodie());
        for(int i=0; i < n.getTodie().length(); ++i){
            int pos = Integer.parseInt(n.getTodie().substring(i, i+1));
            ofn[pos-1] = nfn[i];
            todie[i] = fn.split("[/]")[pos-1];
        }

        fnames = String.join("/", ofn);

        n.setFnames( fnames );

        for (int i=0; i < todie.length; ++i){
            try {
                int pos = todie[i].lastIndexOf(".");
                String name = todie[i].substring(0, pos);
                String ext = todie[i].substring(pos + 1);
                String one = name + n.getUuid() + "." + ext;
                File f = new File(uploadPath + dir + one);
                f.delete();
            }catch (Exception e){}

        }

        ndao.modifyNotice(n);
    }

    @Override
    public void deleteNotice(String bno) {
        String fn = ndao.readFnames(bno);
        String uuid = ndao.readUuid(bno);

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
        ndao.deleteNotice(bno);
    }
}
