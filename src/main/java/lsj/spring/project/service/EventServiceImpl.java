package lsj.spring.project.service;

import lsj.spring.project.dao.EventDAO;
import lsj.spring.project.utils.ImgUploadUtil;
import lsj.spring.project.vo.Event;
import lsj.spring.project.vo.Notice;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.awt.image.BufferedImage;
import java.io.File;
import java.util.*;

@Service("esrv")
public class EventServiceImpl implements EventService{

    @Autowired private EventDAO edao;
    @Autowired private ImgUploadUtil imgutil;

    //private String uploadPath = "C:\\Users\\USER\\IdeaProjects\\the3.0-dermatology-hospital-website\\src\\main\\webapp\\resources\\images\\downloadedImages\\";
    private String uploadPath = "/home/ec2-user/apache-tomcat-8.5.75/webapps/SemiProjectV3-1.0-SNAPSHOT/resources/images/downloadedImages/";
    private String dir = "event/";
    private String[] imgType = {"_thumb_", "_main_"};

    @Override
    public boolean newEvent(Event e, MultipartFile[] img) {
        String uuid = imgutil.makeUUID();

        boolean isSubmitted = false;

        if(imgutil.checkFiles(img)){

            List<String> imgs = new ArrayList<>();

            if (!Objects.requireNonNull(img[0].getOriginalFilename()).isEmpty()) {
                imgs.add(imgutil.ImageUpload(img[0], "_thumb_" + uuid, dir, 580, 210));
            }
            else {
                imgs.add("-/-");
            }

            if (!Objects.requireNonNull(img[1].getOriginalFilename()).isEmpty()) {
                imgs.add(imgutil.ImageUpload(img[1], "_main_" + uuid, dir));
            }
            else {
                imgs.add("-/-");
            }

            String fnames = "";

            for (int i = 0; i < imgs.size(); ++i) {
                fnames += imgs.get(i).split("[/]")[0] + "/";
            }

            e.setFnames( fnames );
            e.setUuid( uuid );
        }

        if(edao.insertEvent(e)>0){
            isSubmitted = true;
        }

        return isSubmitted;
    }

    @Override
    public List<Event> readEvent(String cp) {
        int snum = 4 * (Integer.parseInt(cp) - 1);
        return edao.selectEvent(snum);
    }

    @Override
    public List<Event> readEvent(String cp, String ftype, String fkey) {
        int snum = 4 * (Integer.parseInt(cp) - 1);

        Map<String, Object> params = new HashMap<>();
        params.put("snum", snum);
        params.put("ftype", ftype);
        params.put("fkey", fkey);
        return edao.findSelectEvent(params);
    }

    @Override
    public List<Event> readAllEvent() {
        return edao.selectAllEvent();
    }

    @Override
    public Event readOneEvent(String bno) {
        return edao.selectOneEvent(bno);
    }


    @Override
    public int countEvent() {
        return edao.selectCountEvent();
    }

    @Override
    public int countEvent(String ftype, String fkey) {
        Map<String, Object> params = new HashMap<>();
        params.put("ftype", ftype);
        params.put("fkey", fkey);

        return edao.selectCountEvent(params);
    }

    @Override
    public boolean viewCountEvent(String bno) {
        boolean isUpdated = false;
        if (edao.viewCountEvent(bno) > 0) isUpdated = true;

        return isUpdated;
    }

    @Override
    public void modifyEvent(Event e, String bno, MultipartFile[] img) {
        if(imgutil.checkFiles(img)){
            int num = 0;
            List<String> imgs = new ArrayList<>();

            for(MultipartFile f : img) {
                if (!f.getOriginalFilename().isEmpty() && e.getTodie().equals("1")) {
                    imgs.add(imgutil.ImageUpload(f, "_thumb_" + e.getUuid(), dir, 580, 210));
                }
                else if (!f.getOriginalFilename().isEmpty() && e.getTodie().equals("2")) {
                    imgs.add(imgutil.ImageUpload(f, "_main_" + e.getUuid(), dir));
                }
                else if (!f.getOriginalFilename().isEmpty() && (e.getTodie().equals("12") || e.getTodie().equals("21"))) {
                    if(num == 0) {
                        imgs.add(imgutil.ImageUpload(f, imgType[num] + e.getUuid(), dir, 580, 210));
                    }
                    else if(num == 1) {
                        imgs.add(imgutil.ImageUpload(f, imgType[num] + e.getUuid(), dir));
                    }
                    num+=1;
                }
                else {
                    imgs.add("-/-");
                }
            }

            // read original fnames
            String fn = edao.readFnames(bno);

            // modify fnames to new files
            String[] ofn = fn.split("[/]");

            String fnames = "";

            for (int i = 0; i < imgs.size(); ++i) {
                fnames += imgs.get(i).split("[/]")[0] + "/";
            }

            String[] nfn = fnames.split("[/]");

            String todie[] = new String[3];

            for(int i=0; i < e.getTodie().length(); ++i){
                int pos = Integer.parseInt(e.getTodie().substring(i, i+1));
                ofn[pos-1] = nfn[i];    // save the changed file names
                todie[i] = fn.split("[/]")[pos-1];  // file names to be deleted
            }

            fnames = String.join("/", ofn);

            e.setFnames( fnames );

            for (int i=0; i < todie.length; ++i){
                try {
                    int pos = todie[i].lastIndexOf(".");
                    String name = todie[i].substring(0, pos);
                    String ext = todie[i].substring(pos + 1);
                    String one = name + imgType[i] +e.getUuid() + "." + ext;
                    File f = new File(uploadPath + dir + one);
                    f.delete();
                }catch (Exception ex){}

            }
        }

        edao.modifyEvent(e);
    }

    @Override
    public void deleteEvent(String bno) {
        String fn = edao.readFnames(bno);
        String uuid = edao.readUuid(bno);

        if(fn!=null) {
            String[] ofn = fn.split("[/]");

            for (int i = 0; i < ofn.length; ++i) {
                try {
                    int pos = ofn[i].lastIndexOf(".");
                    String name = ofn[i].substring(0, pos);
                    String ext = ofn[i].substring(pos + 1);
                    String one = name + imgType[i] + uuid + "." + ext;

                    File f = new File(uploadPath + dir + one);
                    f.delete();
                }
                catch (Exception e){}
            }
        }
        edao.deleteEvent(bno);
    }
}
